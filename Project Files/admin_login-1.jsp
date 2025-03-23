<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
    <script src="script.js" defer></script>
</head>

<body>
    <div class="login-container">
        <div class="header">
            <h1>Admin Login</h1>
        </div>

        <form method="POST">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="btn">Login</button>
        </form>

        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null && password != null) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // Connect to the database
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

                    // Check if the username and password match
                    String query = "SELECT * FROM admin_login WHERE username = ? AND password = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        // Redirect to the Admin Dashboard if login is successful
                        response.sendRedirect("admin_dashboard.jsp");
                    } else {
                        out.println("<p style='color:red;'>Invalid username or password. Please try again.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Database error occurred. Please try again later.</p>");
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
</body>

</html>

