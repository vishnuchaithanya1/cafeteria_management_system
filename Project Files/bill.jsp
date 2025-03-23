<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%
    String studentId = (String) session.getAttribute("studentId");
    String[] selectedItems = request.getParameterValues("item_name");
    Map<String, Integer> quantities = new HashMap<>();
    double totalPrice = 0.0;

    for (String item : selectedItems) {
        int quantity = Integer.parseInt(request.getParameter("quantity_" + item));
        quantities.put(item, quantity);
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

        for (Map.Entry<String, Integer> entry : quantities.entrySet()) {
            String query = "SELECT price FROM menu WHERE item_name = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, entry.getKey());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalPrice += rs.getDouble("price") * entry.getValue();
            }
        }

        String couponNumber = "C" + System.currentTimeMillis();
        session.setAttribute("couponNumber", couponNumber);
        session.setAttribute("quantities", quantities);
        session.setAttribute("totalPrice", totalPrice);

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f9f5f1;
        }

        .container {
            display: flex;
            height: 100vh;
            padding: 20px;
        }

        .sidebar {
            width: 250px;
            background-color: #2e4e6d;
            color: #fff;
            height: 100%;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .sidebar h1 {
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: #fcb45c;
        }

        .sidebar a {
            text-decoration: none;
            color: #fff;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #fcb45c;
            color: #2e4e6d;
        }

        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header h2 {
            font-size: 1.8rem;
            color: #2e4e6d;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        ul li {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        button {
            padding: 10px 20px;
            background-color: #fcb45c;
            border: none;
            border-radius: 5px;
            color: #000;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #ffa541;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Cafeteria</h1>
            <a href="student_dashboard.jsp">Dashboard</a>
            <a href="buy_item.jsp">Buy Item</a>
            <a href="my_coupons.jsp">My Coupons</a>
            <a href="give_feedback.jsp">Give Feedback</a>
            <a href="logout.jsp">Logout</a>
        </div>
        <div class="main-content">
            <h2>Bill</h2>
            <p>Student ID: <%= studentId %></p>
            <p>Total Price: ₹<%= totalPrice %></p>
            <h3>Items:</h3>
            <ul>
                <% for (Map.Entry<String, Integer> entry : quantities.entrySet()) { %>
                    <li><%= entry.getKey() %>: <%= entry.getValue() %></li>
                <% } %>
            </ul>
            <form action="payment.jsp" method="post">
                <input type="hidden" name="coupon_number" value="<%= session.getAttribute("couponNumber") %>">
                <button type="submit">Proceed to Payment</button>
            </form>
        </div>
    </div>
</body>
</html>

