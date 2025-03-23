<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String studentId = (String) session.getAttribute("studentId");
    String couponNumber = (String) session.getAttribute("couponNumber");
    double totalPrice = (double) session.getAttribute("totalPrice");
    Map<String, Integer> quantities = (Map<String, Integer>) session.getAttribute("quantities");

    boolean paymentSuccessful = false;
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String upiId = request.getParameter("upi_id");

        if (upiId == null || upiId.trim().isEmpty()) {
            message = "UPI ID is required.";
        } else {
            try {
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/cafeteria_management", 
                    "root", 
                    "vis@rkvp1"
                );

                // Insert into coupons
                String query = "INSERT INTO coupons (student_id, coupon_number, total_price) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, studentId);
                pstmt.setString(2, couponNumber);
                pstmt.setDouble(3, totalPrice);
                pstmt.executeUpdate();

                ResultSet rs = pstmt.getGeneratedKeys();
                int couponId = 0;
                if (rs.next()) {
                    couponId = rs.getInt(1);
                }

                // Insert associated items
                query = "INSERT INTO coupon_items (coupon_id, item_name, quantity) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(query);

                for (Map.Entry<String, Integer> entry : quantities.entrySet()) {
                    pstmt.setInt(1, couponId);
                    pstmt.setString(2, entry.getKey());
                    pstmt.setInt(3, entry.getValue());
                    pstmt.executeUpdate();
                }

                paymentSuccessful = true;
                message = "Payment successful! Coupon: " + couponNumber + "<br>Please collect your order from the cafeteria in approximately 49 minutes.";

                conn.close();
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
    <title>Payment</title>
</head>
<body>
    <h1>Payment</h1>

    <% if (!paymentSuccessful) { %>
        <p>Total Price: ₹<%= totalPrice %></p>
        <form method="post">
            <label>UPI ID:</label>
            <input type="text" name="upi_id" required>
            <button type="submit">Pay</button>
        </form>
        <p style="color: red;"><%= message %></p>
    <% } else { %>
        <h2><%= message %></h2>
        <a href="student_dashboard.jsp">
            <button>Go to Student Dashboard</button>
        </a>
    <% } %>
</body>
</html>

