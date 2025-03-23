<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    if (session == null || session.getAttribute("studentId") == null) {
        response.sendRedirect("student_login.jsp");
        return;
    }
    String studentId = (String) session.getAttribute("studentId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Cafeteria Management System</title>
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

        /* Dashboard Options */
        .dashboard-options {
            display: flex;
            gap: 20px;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .option {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 200px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .option img {
            width: 100px;
            height: 100px;
            margin-bottom: 10px;
        }

        .option button {
            background-color: #fcb45c;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .option button:hover {
            background-color: #ffa541;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h1>CMS Student</h1>
            <a href="student_dashboard.jsp" class="active">🏠 Dashboard</a>
            <a href="buy_item.jsp">🍽️ Buy Item</a>
            <a href="my_coupons.jsp">🎟️ My Coupons</a>
            <a href="give_feedback.jsp">💬 Give Feedback</a>
            <a href="logout.jsp">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h2>Student Dashboard</h2>
                <div class="profile">
                    <img src="student_profile.png" alt="Profile">
                    <span><%= studentId %></span>
                </div>
            </div>

            <!-- Dashboard Options -->
            <div class="dashboard-options">
                <div class="option">
                    <img src="buy_item.png" alt="Buy Item">
                    <div style="margin-top: 10px; font-size: 1.2rem; font-weight: bold;"></div>
                    <button onclick="window.location.href='buy_item.jsp'">Buy Item</button>
                </div>
                <div class="option">
                    <img src="my_coupons.png" alt="My Coupons">
                    <div style="margin-top: 10px; font-size: 1.2rem; font-weight: bold;"></div>
                    <button onclick="window.location.href='my_coupons.jsp'">My Coupons</button>
                </div>
                <div class="option">
                    <img src="give_feedback.png" alt="Give Feedback">
                    <div style="margin-top: 10px; font-size: 1.2rem; font-weight: bold;"></div>
                    <button onclick="window.location.href='give_feedback.jsp'">Give Feedback</button>
                </div>
                <div class="option">
                    <img src="logout.png" alt="Logout">
                    <div style="margin-top: 10px; font-size: 1.2rem; font-weight: bold;"></div>
                    <button onclick="window.location.href='logout.jsp'">Logout</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

