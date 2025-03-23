<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!DOCTYPE html> 
<html lang="en"> 
<head> 
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>Admin Dashboard - Cafeteria Management System</title> 
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

        .sidebar a i { 
            font-size: 1.2rem; 
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

        .header .search-bar { 
            display: flex; 
            align-items: center; 
            gap: 10px; 
        } 

        .header .search-bar input { 
            padding: 10px; 
            border: 1px solid #ccc; 
            border-radius: 5px; 
        } 

        .header .profile { 
            display: flex; 
            align-items: center; 
            gap: 10px; 
        } 

        .header .profile img { 
            width: 40px; 
            height: 40px; 
            border-radius: 50%; 
        } 

        /* Dashboard Options */ 
        .dashboard-options { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 20px; 
            justify-content: space-around; 
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
            <h1>CMS Admin</h1> 
            <a href="admin_dashboard.jsp" class="active">🏠 Dashboard</a> 
            <a href="manage_menu.jsp">📋 Manage Menu</a> 
            <a href="verify_coupon.jsp">✅ Verify Coupon</a> 
            <a href="view_reports.jsp">📜 View Reports</a> 
            <a href="view_feedback.jsp">💬 View Feedback</a> 
            <a href="#" onclick="logout();">🔓 Logout</a> 
        </div> 

        <!-- Main Content --> 
        <div class="main-content"> 
            <!-- Header --> 
            <div class="header"> 
                <h2>Admin Dashboard</h2> 
                <div class="profile"> 
                    <img src="admin_profile.png" alt="Profile"> 
                    <span>Admin</span> 
                </div> 
            </div> 

            <!-- Dashboard Options --> 
            <div class="dashboard-options"> 
                <div class="option"> 
                    <img src="manage_menu.png" alt="Manage Menu"> 
                    <button onclick="window.location.href='manage_menu.jsp'">Manage Menu</button> 
                </div> 
                <div class="option"> 
                    <img src="verify_coupon.png" alt="Verify Coupon"> 
                    <button onclick="window.location.href='verify_coupon.jsp'">Verify Coupon</button> 
                </div> 
                <div class="option"> 
                    <img src="view_reports.png" alt="View Reports"> 
                    <button onclick="window.location.href='view_reports.jsp'">View Reports</button> 
                </div> 
                <div class="option"> 
                    <img src="view_feedback.png" alt="View Feedback"> 
                    <button onclick="window.location.href='view_feedback.jsp'">View Feedback</button> 
                </div> 
                <div class="option"> 
                    <img src="logout.png" alt="Logout"> 
                    <div style="margin-top: 10px;"> 
                        <button onclick="logout()">Logout</button> 
                    </div> 
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

