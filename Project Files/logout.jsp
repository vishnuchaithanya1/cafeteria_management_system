<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Invalidate the session on the server side
    if (session != null) {
        session.invalidate(); // End the session
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <script>
        // Show the success message and redirect to the login page
        function handleLogout() {
            alert("You have been logged out successfully!");
            window.location.href = "index.jsp"; // Redirect to login page
        }
    </script>
</head>
<body onload="handleLogout()">
</body>
</html>

