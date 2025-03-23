<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reports - Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f5f1;
        }

        .container {
            display: flex;
        }

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

        .sidebar a:hover, .sidebar a.active {
            background-color: #fcb45c;
            color: #2e4e6d;
        }

        .sidebar a i {
            font-size: 1.2rem;
        }

        .main-content {
            flex: 1;
            padding: 20px;
        }

        .report-container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .report-table {
            width: 100%;
            border-collapse: collapse;
        }

        .report-table th, .report-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        .report-table th {
            background-color: #f2f2f2;
        }

        .back-button {
            text-align: center;
            margin-top: 20px;
        }

        button {
            background-color: #fcb45c;
            border: none;
            padding: 10px;
            border-radius: 5px;
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
            <h1>CMS Admin</h1> 
            <a href="admin_dashboard.jsp">🏠 Dashboard</a> 
            <a href="manage_menu.jsp">📋 Manage Menu</a> 
            <a href="verify_coupon.jsp">✅ Verify Coupon</a> 
            <a href="view_reports.jsp" class="active">📜 View Reports</a> 
            <a href="view_feedback.jsp">💬 View Feedback</a> 
            <a href="#" onclick="logout();">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="report-container">
                <div class="header">
                    <h1>All Coupon Orders and Item Details</h1>
                </div>
                <div class="report-table">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Coupon ID</th>
                                <th>Student ID</th>
                                <th>Coupon Number</th>
                                <th>Total Price</th>
                                <th>Created At</th>
                                <th>Redeemed At</th>
                                <th>Item Names & Quantities</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Initialize database connection
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;

                                try {
                                    // Load the JDBC driver and establish the connection
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

                                    // Query to fetch coupons and related items
                                    String query = "SELECT c.id AS coupon_id, c.student_id, c.coupon_number, c.total_price, c.created_at, c.redeemed_at, " +
                                                   "GROUP_CONCAT(ci.item_name ORDER BY ci.item_name SEPARATOR ', ') AS item_names, " +
                                                   "GROUP_CONCAT(ci.quantity ORDER BY ci.item_name SEPARATOR ', ') AS quantities " +
                                                   "FROM coupons c " +
                                                   "JOIN coupon_items ci ON c.id = ci.coupon_id " +
                                                   "GROUP BY c.id " +
                                                   "ORDER BY c.created_at DESC";

                                    pstmt = conn.prepareStatement(query);
                                    rs = pstmt.executeQuery();

                                    // Loop through the result set and display data
                                    while (rs.next()) {
                                        String couponId = rs.getString("coupon_id");
                                        String studentId = rs.getString("student_id");
                                        String couponNumber = rs.getString("coupon_number");
                                        double totalPrice = rs.getDouble("total_price");
                                        String createdAt = rs.getTimestamp("created_at").toString();
                                        String redeemedAt = rs.getTimestamp("redeemed_at") != null ? rs.getTimestamp("redeemed_at").toString() : "Not Redeemed";
                                        String itemNames = rs.getString("item_names");
                                        String quantities = rs.getString("quantities");

                                        // Display coupon and item details in a single row
                                        out.println("<tr>");
                                        out.println("<td>" + couponId + "</td>");
                                        out.println("<td>" + studentId + "</td>");
                                        out.println("<td>" + couponNumber + "</td>");
                                        out.println("<td>" + totalPrice + "</td>");
                                        out.println("<td>" + createdAt + "</td>");
                                        out.println("<td>" + redeemedAt + "</td>");
                                        out.println("<td>" + itemNames + " - Quantities: " + quantities + "</td>");
                                        out.println("</tr>");
                                    }
                                } catch (Exception e) {
                                    // Handle exceptions
                                    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    // Close the connection after use
                                    if (conn != null) conn.close();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="back-button">
                    <button onclick="window.location.href='admin_dashboard.jsp'">Back to Dashboard</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Logout Confirmation Script -->
    <script>
        function logout() {
            // Show confirmation dialog
            if (confirm("You have been logged out successfully!")) {
                // Redirect to admin_login.jsp if confirmed
                window.location.href = 'index.jsp';
            }
        }
    </script>
</body>
</html>

