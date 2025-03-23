<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Menu - Cafeteria Management System</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .menu-container {
            max-width: 900px;
            margin: auto;
            padding: 20px;
            text-align: center;
        }

        .menu-header {
            margin-bottom: 30px;
        }

        .menu-header h1 {
            font-size: 2.5rem;
            color: #333;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .menu-item {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 15px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .menu-item:hover {
            transform: translateY(-5px);
        }

        .menu-item h3 {
            font-size: 1.5rem;
            color: #333;
        }

        .menu-item p {
            font-size: 1rem;
            color: #555;
            margin: 5px 0;
        }

        .menu-item .price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #4CAF50;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="menu-container">
        <div class="menu-header">
            <h1>Our Menu</h1>
            <p>Explore the delicious items we have to offer!</p>
        </div>

        <div class="menu-grid">
            <% 
                // Database connection details
                String url = "jdbc:mysql://localhost:3306/cafeteria_management";
                String user = "root";
                String pass = "vis@rkvp1"; // Replace with your password

                try {
                    // Establish database connection
                    Connection conn = DriverManager.getConnection(url, user, pass);

                    // SQL query to fetch menu items
                    String sql = "SELECT * FROM menu";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    // Iterate over menu items and display
                    while (rs.next()) {
                        String itemName = rs.getString("item_name");
                        String category = rs.getString("category");
                        double price = rs.getDouble("price");
            %>
                <div class="menu-item">
                    <h3><%= itemName %></h3>
                    <p>Category: <%= category %></p>
                    <p class="price">₹<%= price %></p>
                </div>
            <% 
                    }
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</body>
</html>

