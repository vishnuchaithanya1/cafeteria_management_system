<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Feedback - Admin Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
         <div class="sidebar"> 
            <h1>CMS Admin</h1> 
            <a href="admin_dashboard.jsp">🏠 Dashboard</a> 
            <a href="manage_menu.jsp">📋 Manage Menu</a> 
            <a href="verify_coupon.jsp">✅ Verify Coupon</a> 
            <a href="view_reports.jsp">📜 View Reports</a> 
            <a href="view_feedback.jsp" class="active">💬 View Feedback</a> 
            <a href="#" onclick="logout();">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Feedback from Students</h1>
            </div>
            <div class="feedback-table">
                <table>
                    <thead>
                        <tr>
                            <th>Feedback ID</th>
                            <th>Student ID</th>
                            <th>Coupon Number</th>
                            <th>Feedback</th>
                            <th>Submitted At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            try {
                                // Establish database connection
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

                                // Query to fetch feedback with coupon details
                                String query = "SELECT f.feedback_id, f.student_id, c.coupon_number, f.feedback_text, f.submitted_at " +
                                               "FROM feedback f " +
                                               "JOIN coupons c ON f.coupon_id = c.id " +
                                               "ORDER BY f.submitted_at DESC";

                                pstmt = conn.prepareStatement(query);
                                rs = pstmt.executeQuery();

                                // Loop through feedback records
                                while (rs.next()) {
                        %>
                            <tr>
                                <td><%= rs.getInt("feedback_id") %></td>
                                <td><%= rs.getString("student_id") %></td>
                                <td><%= rs.getString("coupon_number") %></td>
                                <td><%= rs.getString("feedback_text") %></td>
                                <td><%= rs.getTimestamp("submitted_at") %></td>
                            </tr>
                        <%
                                }
                            } catch (Exception e) {
                                // Handle exceptions
                                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                            } finally {
                                // Close connection
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="button-container">
                <a href="admin_dashboard.jsp">
                    <button type="button">Back to Dashboard</button>
                </a>
            </div>
        </div>
    </div>

    <!-- CSS for layout and styling -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f0f2f5;
        }

        .container {
            display: flex;
            height: 100vh;
            width: 100vw; /* Ensures full-width */
            overflow: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 200px;
            background-color: #34495e;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
            flex-shrink: 0;
        }

        .sidebar h1 {
            font-size: 1.2rem;
            color: #f1c40f;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .sidebar a.active, .sidebar a:hover {
            background-color: #f1c40f;
            color: #34495e;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #ffffff;
            overflow-y: auto;
        }

        .main-content h1 {
            color: #34495e;
            margin-bottom: 15px;
        }

        .feedback-table table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .feedback-table th {
            background-color: #f1c40f;
            color: white;
        }

        .feedback-table th, .feedback-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
            color: black; /* Updated color */
        }

        .button-container {
            text-align: center;
        }

        .button-container button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button-container button:hover {
            background-color: #2980b9;
        }
    </style>
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

