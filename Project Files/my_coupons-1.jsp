<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Coupons - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="coupons-container">
        <h1>My Coupons</h1>

        <%
            // Get the student ID from the session
            String studentId = (String) session.getAttribute("studentId");
            if (studentId == null) {
                // If session is invalid, redirect to login
                response.sendRedirect("student_login.jsp");
                return;
            }

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/cafeteria_management";
            String user = "root";
            String pass = "vis@rkvp1";
            
            try {
                // Connect to the database
                Connection conn = DriverManager.getConnection(url, user, pass);

                // Prepare the SQL query to retrieve the coupons
                String sql = "SELECT * FROM coupons WHERE student_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, studentId);

                // Execute the query
                ResultSet rs = stmt.executeQuery();

                // Check if there are any results
                if (rs.next()) {
                    out.println("<table>");
                    out.println("<thead><tr><th>Coupon Code</th><th>Selected Items</th><th>Total Cost</th><th>Status</th></tr></thead>");
                    out.println("<tbody>");
                    do {
                        String couponCode = rs.getString("coupon_code");
                        String selectedItems = rs.getString("selected_items");
                        double totalCost = rs.getDouble("total_cost");
                        String status = rs.getString("status");

                        out.println("<tr>");
                        out.println("<td>" + couponCode + "</td>");
                        out.println("<td>" + selectedItems + "</td>");
                        out.println("<td>" + totalCost + "</td>");
                        out.println("<td>" + status + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</tbody>");
                    out.println("</table>");
                } else {
                    out.println("<p>No coupons available.</p>");
                }

                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error retrieving coupons.</p>");
            }
        %>
    </div>
</body>
</html>

