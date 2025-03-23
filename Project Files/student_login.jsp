<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

            // Query to validate student credentials
            String query = "SELECT * FROM students WHERE student_id = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, studentId);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Valid credentials: use implicit session object
                session.setAttribute("studentId", studentId); // No need to redeclare `session`
                response.sendRedirect("student_dashboard.jsp");
                return;
            } else {
                message = "Invalid Student ID or Password!";
            }
            conn.close();
        } catch (Exception e) {
            message = "Database connection error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - Cafeteria Management</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: url('background.png') center/cover no-repeat; /* Background image for the body */
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #1a1a1a; /* Dark background for the login container */
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            width: 400px; /* Adjusted width */
            height: 400px; /* Adjusted height */
            display: flex;
            flex-direction: column;
            justify-content: center; /* Center content vertically */
            align-items: center; /* Center content horizontally */
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent overlay */
            backdrop-filter: blur(5px); /* Adds a blur effect to the background */
        }

        .title {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #f26522;
            text-align: center;
        }

        .login-form {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 15px; /* Reduced gap between fields */
        }

        .input-field {
            padding: 10px;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 1rem;
            width: 100%; /* Full width for input fields */
        }

        .btn-login {
            padding: 10px;
            background-color: #f26522;
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%; /* Full width for button */
        }

        .btn-login:hover {
            background-color: #e0541e;
        }

        .message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-section">
            <h1 class="title">Student Login</h1>
            <form class="login-form" method="post" action="student_login.jsp">
                <input type="text" name="studentId" placeholder="Student ID" class="input-field" required>
                <input type="password" name="password" placeholder="Password" class="input-field" required>
                <button type="submit" class="btn-login">Login</button>
            </form>
            <p class="message"><%= message %></p>
        </div>
    </div>
</body>
</html>

