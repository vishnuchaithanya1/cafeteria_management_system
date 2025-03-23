<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Menu - Cafeteria Management System</title>
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

        .main-content h1 {
            color: #2e4e6d;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #fcb45c;
            color: #fff;
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .button-container button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #fcb45c;
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .button-container button:hover {
            background-color: #ffa541;
        }

        form input, form button {
            margin: 5px 0;
            padding: 10px;
            width: calc(100% - 22px);
            font-size: 14px;
        }

        form button {
            background-color: #2e4e6d;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        form button:hover {
            background-color: #1e3548;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
 <div class="sidebar"> 
            <h1>CMS Admin</h1> 
            <a href="admin_dashboard.jsp">🏠 Dashboard</a> 
            <a href="manage_menu.jsp" class="active">📋 Manage Menu</a> 
            <a href="verify_coupon.jsp">✅ Verify Coupon</a> 
            <a href="view_reports.jsp">📜 View Reports</a> 
            <a href="view_feedback.jsp">💬 View Feedback</a> 
            <a href="#" onclick="logout();">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Manage Menu Items</h1>
            <!-- Form to Add a New Menu Item -->
            <form method="POST" action="manage_menu.jsp">
                <label for="itemName">Item Name:</label>
                <input type="text" id="itemName" name="itemName" required>
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" required>
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" required>
                <button type="submit" name="action" value="add">Add Item</button>
            </form>

            <h2>Existing Menu</h2>
            <table>
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String url = "jdbc:mysql://localhost:3306/cafeteria_management";
                        String user = "root";
                        String pass = "vis@rkvp1";

                        try {
                            String action = request.getParameter("action");

                            Connection conn = DriverManager.getConnection(url, user, pass);

                            if ("add".equals(action)) {
                                String itemName = request.getParameter("itemName");
                                String category = request.getParameter("category");
                                String price = request.getParameter("price");

                                if (itemName != null && category != null && price != null) {
                                    String insertSql = "INSERT INTO menu (item_name, category, price) VALUES (?, ?, ?)";
                                    PreparedStatement pstmt = conn.prepareStatement(insertSql);
                                    pstmt.setString(1, itemName);
                                    pstmt.setString(2, category);
                                    pstmt.setDouble(3, Double.parseDouble(price));
                                    pstmt.executeUpdate();
                                }
                            } else if ("remove".equals(action)) {
                                String itemNameToRemove = request.getParameter("itemName");

                                if (itemNameToRemove != null) {
                                    String deleteSql = "DELETE FROM menu WHERE item_name = ?";
                                    PreparedStatement pstmt = conn.prepareStatement(deleteSql);
                                    pstmt.setString(1, itemNameToRemove);
                                    pstmt.executeUpdate();
                                }
                            }

                            String fetchSql = "SELECT * FROM menu";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(fetchSql);

                            while (rs.next()) {
                                String fetchedItemName = rs.getString("item_name");
                                String fetchedCategory = rs.getString("category");
                                double fetchedPrice = rs.getDouble("price");
                    %>
                    <tr>
                        <td><%= fetchedItemName %></td>
                        <td><%= fetchedCategory %></td>
                        <td><%= fetchedPrice %></td>
                        <td>
                            <form method="POST" action="manage_menu.jsp" style="display:inline;">
                                <input type="hidden" name="itemName" value="<%= fetchedItemName %>">
                                <button type="submit" name="action" value="remove">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <% 
                            }
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                        }
                    %>
                </tbody>
            </table>

            <!-- Button to navigate to Admin Dashboard -->
            <div class="button-container">
                <a href="admin_dashboard.jsp">
                    <button type="button">Go to Admin Dashboard</button>
                </a>
            </div>
        </div>
    </div>
</body>
<script> 
        function logout() { 
            // Show confirmation dialog 
            if (confirm("You have been logged out successfully!")) { 
                // Redirect to admin_login.jsp if confirmed 
                window.location.href = 'index.jsp'; 
            } 
        } 
    </script> 
</html>

