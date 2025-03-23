<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Item - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="remove-item-container">
        <h1>Remove Menu Item</h1>

        <% 
            // Get the itemName parameter from the request
            String itemName = request.getParameter("itemName");
            
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/cafeteria_management"; // Modify if needed
            String user = "root"; // Modify with your username
            String pass = "Vis@rkvp1"; // Modify with your password

            if (itemName != null && !itemName.isEmpty()) {
                try {
                    // Connect to the database
                    Connection conn = DriverManager.getConnection(url, user, pass);
                    
                    // SQL query to delete the item
                    String sql = "DELETE FROM menu WHERE item_name = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, itemName);
                    
                    int rowsAffected = pstmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        out.println("<p>Item '" + itemName + "' removed successfully!</p>");
                    } else {
                        out.println("<p>Failed to remove item '" + itemName + "'. It might not exist.</p>");
                    }
                    
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p>No item selected to remove.</p>");
            }
        %>

        <br>
        <a href="manage_menu.jsp">Go back to Manage Menu</a>
    </div>
</body>
</html>

