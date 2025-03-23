<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="order-summary-container">
        <h1>Order Summary</h1>
        <table>
            <thead>
                <tr>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    double totalCost = 0;
                    HttpSession session = request.getSession(false);
                    if (session == null) {
                        out.println("<p>Error: No active session. Please log in again.</p>");
                        return;
                    }

                    // Insert order into database
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");
                    String insertOrderSQL = "INSERT INTO orders (user_id, total_price) VALUES (?, ?)";
                    PreparedStatement orderStmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
                    orderStmt.setInt(1, Integer.parseInt(session.getAttribute("user_id").toString()));  // Assuming user_id is stored in session
                    orderStmt.setDouble(2, totalCost);
                    orderStmt.executeUpdate();

                    ResultSet generatedKeys = orderStmt.getGeneratedKeys();
                    int orderId = -1;
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }

                    // Insert order items into the order_items table
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

                            String insertOrderItemSQL = "INSERT INTO order_items (order_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";
                            PreparedStatement orderItemStmt = conn.prepareStatement(insertOrderItemSQL);
                            orderItemStmt.setInt(1, orderId);
                            orderItemStmt.setInt(2, itemId);
                            orderItemStmt.setInt(3, quantity);
                            orderItemStmt.setDouble(4, totalPrice);
                            orderItemStmt.executeUpdate();
                        }
                    }

                    conn.close();
                %>
            </tbody>
        </table>
        <h3>Total Cost: <%= totalCost %></h3>
        <p>Your order has been placed successfully. Thank you!</p>
    </div>
</body>
</html>

