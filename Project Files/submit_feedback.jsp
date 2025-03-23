<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Check if the session exists
    if (session == null || session.getAttribute("studentId") == null) {
        response.sendRedirect("student_login.jsp");
        return;
    }

    String studentId = (String) session.getAttribute("studentId");
    int couponId = Integer.parseInt(request.getParameter("coupon_id"));
    String feedbackText = request.getParameter("feedback_text");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean feedbackExists = false;
    boolean feedbackSubmitted = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

        // Check if feedback already exists
        String checkQuery = "SELECT COUNT(*) FROM feedback WHERE student_id = ? AND coupon_id = ?";
        pstmt = conn.prepareStatement(checkQuery);
        pstmt.setString(1, studentId);
        pstmt.setInt(2, couponId);
        rs = pstmt.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            feedbackExists = true;
        } else {
            // Insert new feedback
            String insertQuery = "INSERT INTO feedback (student_id, coupon_id, feedback_text) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, studentId);
            pstmt.setInt(2, couponId);
            pstmt.setString(3, feedbackText);
            pstmt.executeUpdate();

            feedbackSubmitted = true;
        }
    } catch (Exception e) {
        out.println("<h1>Error: " + e.getMessage() + "</h1>");
    } finally {
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Status</title>
    <link rel="stylesheet" href="styles.css">
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

        /* Feedback Status Page Styles */
        .feedback-status {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #ffffff;
        }

        .feedback-status h1 {
            font-size: 2rem;
            color: #34495e;
            margin-bottom: 10px;
        }

        .feedback-status p {
            font-size: 1rem;
            color: #6c7a91;
            margin-bottom: 20px;
        }

        .feedback-status a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .feedback-status a:hover {
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
            <a href="verify_coupon.jsp">✅ Verify Coupon</a> 
            <a href="view_reports.jsp">📜 View Reports</a> 
            <a href="view_feedback.jsp" class="active">💬 View Feedback</a> 
           <a href="logout.jsp">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="feedback-status">
            <% if (feedbackExists) { %>
                <h1>Feedback Already Given!</h1>
                <p>You have already submitted feedback for this coupon.</p>
                <a href="student_dashboard.jsp">Go to Dashboard</a>
            <% } else if (feedbackSubmitted) { %>
                <h1>Feedback Submitted Successfully!</h1>
                <p>Thank you for your valuable feedback.</p>
                <a href="student_dashboard.jsp">Go to Dashboard</a>
            <% } else { %>
                <h1>Failed to Submit Feedback</h1>
                <p>There was an issue submitting your feedback. Please try again.</p>
                <a href="give_feedback.jsp">Go Back to Feedback Page</a>
            <% } %>
        </div>
    </div>
    
</body>
</html>

