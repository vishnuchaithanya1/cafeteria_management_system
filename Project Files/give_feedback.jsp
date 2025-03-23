<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Check if the session exists
    if (session == null || session.getAttribute("studentId") == null) {
        response.sendRedirect("student_login.jsp");
        return;
    }

    String studentId = (String) session.getAttribute("studentId");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Fetch coupons for the logged-in student
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");
        
        String query = "SELECT id, coupon_number FROM coupons WHERE student_id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, studentId);
        rs = pstmt.executeQuery();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Give Feedback - Cafeteria Management System</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f5f1;
        }

        .container {
            display: flex;
        }

        /* Sidebar Styles */
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

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #fcb45c;
            color: #2e4e6d;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header h2 {
            font-size: 1.5rem;
            color: #2e4e6d;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        /* Feedback Form */
        .feedback-container {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .feedback-container h1 {
            color: #2e4e6d;
        }

        .feedback-container label {
            font-weight: bold;
            color: #2e4e6d;
        }

        .feedback-container textarea,
        .feedback-container select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .button-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            justify-content: center;
        }

        .button-container button {
            padding: 10px 20px;
            background-color: #fcb45c;
            border: none;
            border-radius: 5px;
            color: #000;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .button-container button:hover {
            background-color: #ffa541;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h1>CMS Student</h1>
            <a href="student_dashboard.jsp">🏠 Dashboard</a>
            <a href="buy_item.jsp">🍽️ Buy Item</a>
            <a href="my_coupons.jsp">🎟️ My Coupons</a>
            <a href="give_feedback.jsp" class="active">💬 Give Feedback</a>
            <a href="logout.jsp">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h2>Give Feedback</h2>
                <div class="profile">
                    <img src="https://via.placeholder.com/40" alt="Profile">
                    <span><%= studentId %></span>
                </div>
            </div>

            <!-- Feedback Form -->
            <div class="feedback-container">
                <h1>Give Feedback</h1>
                <form action="submit_feedback.jsp" method="post">
                    <label for="coupon_id">Select Coupon:</label>
                    <select name="coupon_id" id="coupon_id" required>
                        <option value="" disabled selected>Choose a Coupon</option>
                        <% 
                            try {
                                while (rs != null && rs.next()) {
                        %>
                                <option value="<%= rs.getInt("id") %>">
                                    <%= rs.getString("coupon_number") %>
                                </option>
                        <% 
                                }
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                            }
                        %>
                    </select>
                    <br>
                    <label for="feedback_text">Your Feedback:</label>
                    <textarea name="feedback_text" id="feedback_text" rows="5" cols="50" required></textarea>

                    <div class="button-container">
                        <button type="submit">Submit Feedback</button>
                        <a href="student_dashboard.jsp">
                            <button type="button">Go to Student Dashboard</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

<%
    try {
        if (conn != null) conn.close();
    } catch (Exception e) {
        out.println("Closing error: " + e.getMessage());
    }
%>

