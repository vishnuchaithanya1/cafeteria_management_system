<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Order Confirmation</h1>
    <%
        String totalCostStr = request.getParameter("totalCost");
        String upiId = request.getParameter("upiId");

        if (totalCostStr == null || upiId == null) {
            out.println("<p>Error: Missing required information.</p>");
            return;
        }

        double totalCost = Double.parseDouble(totalCostStr);
        
        out.println("<h3>Total Cost: ₹" + totalCost + "</h3>");
        out.println("<h3>UPI ID: " + upiId + "</h3>");
        out.println("<p>Your order has been successfully placed. Thank you for your purchase!</p>");
    %>
</body>
</html>

