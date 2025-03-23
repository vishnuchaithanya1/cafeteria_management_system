<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="payment-container">
        <h1>Enter UPI ID to Complete Payment</h1>
        <form method="POST" action="order_confirmation.jsp">
            <label for="upiId">UPI ID:</label>
            <input type="text" id="upiId" name="upiId" required>
            <input type="hidden" name="totalAmount" value="<%= request.getParameter("totalAmount") %>">
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>

