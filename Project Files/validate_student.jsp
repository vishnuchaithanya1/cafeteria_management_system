<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String studentId = request.getParameter("studentId");
    String password = request.getParameter("password");
    String dbUrl = "jdbc:mysql://localhost:3306/cafeteria_management";
    String dbUser = "root";
    String dbPass = "vis@rkvp1";

    boolean isValidUser = false;

    try {
        // Database connection
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        String query = "SELECT * FROM students WHERE student_id = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, studentId);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            isValidUser = true;
            // Start a session and store studentId
            HttpSession userSession = request.getSession(); // Renamed the variable to avoid conflict
            userSession.setAttribute("studentId", studentId);
        }
        conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if (isValidUser) {
        response.sendRedirect("student_dashboard.jsp");
    } else {
        out.println("<script>alert('Invalid Student ID or Password');</script>");
        out.println("<script>window.location.href='student_login.jsp';</script>");
    }
%>

