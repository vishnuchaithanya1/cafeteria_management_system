<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.util.Enumeration" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cart - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="cart-container">
        <h1>Your Cart</h1>
        <form method="POST" action="place_order.jsp">
            <table>
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        double totalCost = 0;
                        // Get the session
                        HttpSession session = request.getSession(false);
                        if (session == null) {
                            out.println("<p>Error: No active session. Please log in again.</p>");
                            return;
                        }

                        // Iterate over the selected items and calculate total
                        Enumeration<String> parameterNames = request.getParameterNames();
                        while (parameterNames.hasMoreElements()) {
                            String paramName = parameterNames.nextElement();
                            if (paramName.endsWith("_quantity")) {
                                String itemIdStr = paramName.replace("_quantity", "");
                                int itemId = Integer.parseInt(itemIdStr);
                                int quantity = Integer.parseInt(request.getParameter(paramName));
                                double price = Double.parseDouble(request.getParameter(itemIdStr + "_price"));
                                double totalPrice = price * quantity;
                                totalCost += totalPrice;

                                // Get item details from the database
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");
                                String sql = "SELECT * FROM menu WHERE id = ?";
                                PreparedStatement pstmt = conn.prepareStatement(sql);
                                pstmt.setInt(1, itemId);
                                ResultSet rs = pstmt.executeQuery();
                                if (rs.next()) {
                                    String itemName = rs.getString("item_name");
                                    String category = rs.getString("category");
                    %>
                    <tr>
                        <td><%= itemName %></td>
                        <td><%= category %></td>
                        <td><%= price %></td>
                        <td><%= quantity %></td>
                        <td><%= totalPrice %></td>
                    </tr>
                    <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                            }
                        }
                    %>
                    <tr>
                        <td colspan="4" style="text-align: right; font-weight: bold;">Total Cost</td>
                        <td><%= totalCost %></td>
                    </tr>
                </tbody>
            </table>
            <button type="submit">Place Order</button>
        </form>
    </div>
</body>
</html>

