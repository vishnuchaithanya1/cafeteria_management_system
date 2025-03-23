<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify and Redeem Coupon</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f9f5f1;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 200px;
            background-color: #2e4e6d;
            color: #fff;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .sidebar h1 {
            font-size: 1.2rem;
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
            overflow-y: auto; /* Ensure content fits within the height */
        }

        .main-content h1 {
            color: #2e4e6d;
            margin-bottom: 15px;
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
            margin-top: 20px;
            text-align: center;
        }

        .button-container button {
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            background-color: #3498db;
            color: white;
            border: none;
        }

        .button-container button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
         <div class="sidebar"> 
            <h1>CMS Admin</h1> 
            <a href="admin_dashboard.jsp">🏠 Dashboard</a> 
            <a href="manage_menu.jsp">📋 Manage Menu</a> 
            <a href="verify_coupon.jsp" class="active">✅ Verify Coupon</a> 
            <a href="view_reports.jsp">📜 View Reports</a> 
            <a href="view_feedback.jsp">💬 View Feedback</a> 
            <a href="#" onclick="logout();">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Verify and Redeem Coupon</h1>

            <!-- Coupon Verification Form -->
            <div class="form-container">
                <form method="post">
                    <label for="coupon_id">Enter Coupon Code:</label>
                    <input type="text" id="coupon_id" name="coupon_id" required>
                    <button type="submit">Verify & Redeem</button>
                </form>
            </div>

            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String couponId = request.getParameter("coupon_id");
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

                        // Query to check coupon details
                        String query = "SELECT redeemed_at FROM coupons WHERE coupon_number = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, couponId);
                        rs = pstmt.executeQuery();

                        if (!rs.next()) {
                            // Coupon does not exist
                            out.println("<div class='message error'>Invalid Coupon Code. Please try again.</div>");
                        } else {
                            Timestamp redeemedAt = rs.getTimestamp("redeemed_at");
                            if (redeemedAt != null) {
                                // Coupon already redeemed
                                out.println("<div class='message error'>This coupon has already been redeemed on " + redeemedAt + ".</div>");
                            } else {
                                // Coupon is valid and not redeemed
                                // Update the coupon as redeemed
                                String updateQuery = "UPDATE coupons SET redeemed_at = NOW() WHERE coupon_number = ?";
                                PreparedStatement updatePstmt = conn.prepareStatement(updateQuery);
                                updatePstmt.setString(1, couponId);
                                int rowsUpdated = updatePstmt.executeUpdate();

                                if (rowsUpdated > 0) {
                                    out.println("<div class='message success'>Coupon redeemed successfully! Redeemed at: " + new java.util.Date() + ".</div>");
                                } else {
                                    out.println("<div class='message error'>Failed to redeem the coupon. Please try again.</div>");
                                }

                                updatePstmt.close();
                            }
                        }
                    } catch (Exception e) {
                        out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("<div class='message error'>Error closing resources: " + e.getMessage() + "</div>");
                        }
                    }
                }
            %>

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

