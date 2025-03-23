<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Cafeteria Management System</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: url('background4.png') center/cover no-repeat; /* Background image for the body */
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
        }

        .login-section {
            width: 100%;
            padding: 30px; /* Increased padding */
            display: flex;
            flex-direction: column;
            gap: 20px; /* Proper spacing between input fields and button */
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black background overlay */
            height: 100%; /* Full height to stretch */
            justify-content: center; /* Center form content */
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

        .error-message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <div class="login-section">
            <h1 class="title">Admin Login</h1>
            <form class="login-form" method="POST">
                <input type="text" name="username" placeholder="Username" class="input-field" required>
                <input type="password" name="password" placeholder="Password" class="input-field" required>
                <button type="submit" class="btn-login">Login</button>
            </form>
            <%
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                if (username != null && password != null) {
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

                        String query = "SELECT * FROM admin_login WHERE username = ? AND password = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, username);
                        stmt.setString(2, password);
                        rs = stmt.executeQuery();

                        if (rs.next()) {
                            response.sendRedirect("admin_dashboard.jsp");
                        } else {
                            out.println("<p class='error-message'>Invalid username or password. Please try again.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p class='error-message'>Database error occurred. Please try again later.</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
    </div>
</body>

</html>

