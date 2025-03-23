<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String studentId = (String) session.getAttribute("studentId");
    String couponNumber = (String) session.getAttribute("couponNumber");
    double totalPrice = (double) session.getAttribute("totalPrice");
    Map<String, Integer> quantities = (Map<String, Integer>) session.getAttribute("quantities");

    boolean paymentSuccessful = false;
    String message = "";
    int randomTime = 0;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String upiId = request.getParameter("upi_id");

        if (upiId == null || upiId.trim().isEmpty()) {
            message = "UPI ID is required.";
        } else {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1")) {
                String query = "INSERT INTO coupons (student_id, coupon_number, total_price) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, studentId);
                pstmt.setString(2, couponNumber);
                pstmt.setDouble(3, totalPrice);
                pstmt.executeUpdate();

                ResultSet rs = pstmt.getGeneratedKeys();
                int couponId = rs.next() ? rs.getInt(1) : 0;

                query = "INSERT INTO coupon_items (coupon_id, item_name, quantity) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(query);

                for (Map.Entry<String, Integer> entry : quantities.entrySet()) {
                    pstmt.setInt(1, couponId);
                    pstmt.setString(2, entry.getKey());
                    pstmt.setInt(3, entry.getValue());
                    pstmt.executeUpdate();
                }

                Random rand = new Random();
                randomTime = 5 + rand.nextInt(56);

                paymentSuccessful = true;
                message = "Payment successful! Coupon: " + couponNumber;

            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f5f1;
        }

        .container {
            display: flex;
            height: 100vh; /* Full viewport height */
            width: 100%;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background-color: #2e4e6d;
            color: #fff;
            height: 100vh;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .sidebar h1 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: #fcb45c;
        }

        .sidebar a {
            text-decoration: none;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #fcb45c;
            color: #2e4e6d;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 20px;
            display: flex;
        }

        .main-content div {
            margin: auto;
            text-align: center;
        }

        h2 {
            font-size: 1.8rem;
            color: #2e4e6d;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        form input {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            width: 100%;
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

        .message {
            color: red;
        }

        .success-message {
            color: green;
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            form input {
                padding: 8px;
            }

            button {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 1.5rem;
            }

            form {
                padding: 0 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h1>Cafeteria</h1>
            <a href="student_dashboard.jsp">Dashboard</a>
            <a href="buy_item.jsp">Buy Item</a>
            <a href="my_coupons.jsp">My Coupons</a>
            <a href="give_feedback.jsp">Give Feedback</a>
            <a href="logout.jsp">Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div>
                <h2>Payment</h2>
                <% if (!paymentSuccessful) { %>
                    <p>Total Price: ₹<%= totalPrice %></p>
                    <form method="post">
                        <label>UPI ID:</label>
                        <input type="text" name="upi_id" required>
                        <button type="submit">Pay</button>
                    </form>
                    <p class="message"><%= message %></p>
                <% } else { %>
                    <h3 class="success-message"><%= message %></h3>
                    <p>Collect your order in <b><%= randomTime %></b> minutes.</p>
                    <a href="student_dashboard.jsp"><button>Go to Dashboard</button></a>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>

