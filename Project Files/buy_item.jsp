<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");
        String query = "SELECT * FROM menu";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Items - Cafeteria Management System</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f5f1;
        }

        .container {
            display: flex;
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
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header h2 {
            font-size: 1.5rem;
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

        /* Table Styles */
        .table-container {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #fcb45c;
            color: #2e4e6d;
        }

        table td input[type="number"] {
            width: 60px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
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
        <!-- Sidebar -->
        <div class="sidebar">
            <h1>CMS Student</h1>
            <a href="student_dashboard.jsp">🏠 Dashboard</a>
            <a href="buy_item.jsp" class="active">🍽️ Buy Item</a>
            <a href="my_coupons.jsp">🎟️ My Coupons</a>
            <a href="give_feedback.jsp">💬 Give Feedback</a>
            <a href="logout.jsp">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h2>Buy Items</h2>
            <div class="table-container">
                <form action="bill.jsp" method="post">
                    <table>
                        <tr>
                            <th>Item Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Select</th>
                            <th>Quantity</th>
                        </tr>
                        <% while (rs != null && rs.next()) { %>
                            <tr>
                                <td><%= rs.getString("item_name") %></td>
                                <td><%= rs.getString("category") %></td>
                                <td>₹<%= rs.getDouble("price") %></td>
                                <td><input type="checkbox" name="item_name" value="<%= rs.getString("item_name") %>"></td>
                                <td><input type="number" name="quantity_<%= rs.getString("item_name") %>" min="1"></td>
                            </tr>
                        <% } %>
                    </table>
                    <button type="submit">Generate Bill</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<%
    try {
        if (conn != null) conn.close();
    } catch (Exception e) {
        out.println("Closing error: " + e.getMessage());
    }
%>

