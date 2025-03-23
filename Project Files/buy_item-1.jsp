<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Items - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="menu-container">
        <h1>Menu</h1>
        <form method="POST" action="view_cart.jsp">
            <table>
                <thead>
                    <tr>
                        <th>Select</th>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Database connection details
                        String url = "jdbc:mysql://localhost:3306/cafeteria_management";
                        String user = "root";
                        String pass = "vis@rkvp1"; // Replace with your database password
                        try {
                            Connection conn = DriverManager.getConnection(url, user, pass);
                            String sql = "SELECT * FROM menu";  // Query to get cafeteria menu items
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(sql);
                            
                            while (rs.next()) {
                                String itemName = rs.getString("item_name");
                                String category = rs.getString("category");
                                double price = rs.getDouble("price");
                                int itemId = rs.getInt("id");
                    %>
                    <tr>
                        <td>
                            <input type="checkbox" name="cartItems" value="<%= itemId %>">
                            <!-- Hidden input to pass the item's price -->
                            <input type="hidden" name="<%= itemId + "_price" %>" value="<%= price %>">
                        </td>
                        <td><%= itemName %></td>
                        <td><%= category %></td>
                        <td><%= price %></td>
                        <td><input type="number" name="<%= itemId + "_quantity" %>" value="1" min="1"></td>
                    </tr>
                    <% 
                            }
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
            <button type="submit">Continue to Cart</button>
        </form>
    </div>
</body>
</html>

