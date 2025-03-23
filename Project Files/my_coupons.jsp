<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String studentId = (String) session.getAttribute("studentId");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<Map<String, Object>> coupons = new ArrayList<>();

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafeteria_management", "root", "vis@rkvp1");

        // Fetch all coupons for the student
        String query = "SELECT c.coupon_number, c.total_price, c.created_at, c.redeemed_at, i.item_name, i.quantity " +
                       "FROM coupons c " +
                       "LEFT JOIN coupon_items i ON c.id = i.coupon_id " +
                       "WHERE c.student_id = ? " +
                       "ORDER BY c.created_at DESC";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, studentId);
        rs = pstmt.executeQuery();

        // Process result set
        Map<String, Map<String, Object>> couponMap = new LinkedHashMap<>();
        while (rs.next()) {
            String couponNumber = rs.getString("coupon_number");
            Map<String, Object> coupon = couponMap.get(couponNumber);

            // If coupon is not already added, initialize it
            if (coupon == null) {
                coupon = new HashMap<>();
                coupon.put("coupon_number", couponNumber);
                coupon.put("total_price", rs.getDouble("total_price"));
                coupon.put("created_at", rs.getTimestamp("created_at"));
                coupon.put("redeemed_at", rs.getTimestamp("redeemed_at"));
                coupon.put("items", new ArrayList<Map<String, Object>>());
                couponMap.put(couponNumber, coupon);
            }

            // Add item details to the coupon
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> items = (List<Map<String, Object>>) coupon.get("items");
            Map<String, Object> item = new HashMap<>();
            item.put("item_name", rs.getString("item_name"));
            item.put("quantity", rs.getInt("quantity"));
            items.add(item);
        }

        coupons.addAll(couponMap.values());
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Coupons - Cafeteria Management System</title>
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

        /* Coupon Section */
        .coupon-section {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .coupon-section h3 {
            color: #2e4e6d;
        }

        .coupon-section p {
            margin: 5px 0;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
            color: #2e4e6d;
        }

        button {
            padding: 10px;
            background-color: #fcb45c;
            border: none;
            border-radius: 5px;
            color: #000;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
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
            <a href="my_coupons.jsp class ="active">🎟️ My Coupons</a>
            <a href="give_feedback.jsp">💬 Give Feedback</a>
            <a href="logout.jsp">🔓 Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h2>My Coupons</h2>
                <div class="profile">
                    <img src="https://via.placeholder.com/40" alt="Profile">
                    <span><%= studentId %></span>
                </div>
            </div>

            <!-- Coupons -->
            <% if (coupons.isEmpty()) { %>
                <p>No coupons found.</p>
            <% } else { %>
                <% for (Map<String, Object> coupon : coupons) { %>
                    <div class="coupon-section">
                        <h3>Coupon Number: <%= coupon.get("coupon_number") %></h3>
                        <p><strong>Total Price:</strong> ₹<%= coupon.get("total_price") %></p>
                        <p><strong>Created At:</strong> <%= coupon.get("created_at") %></p>
                        <p><strong>Redeemed At:</strong> <%= coupon.get("redeemed_at") != null ? coupon.get("redeemed_at") : "Not yet redeemed" %></p>

                        <h4>Items:</h4>
                        <table>
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% @SuppressWarnings("unchecked")
                                   List<Map<String, Object>> items = (List<Map<String, Object>>) coupon.get("items");
                                   for (Map<String, Object> item : items) { %>
                                    <tr>
                                        <td><%= item.get("item_name") %></td>
                                        <td><%= item.get("quantity") %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            <% } %>
            <!-- Back Button -->
            <a href="student_dashboard.jsp">
                <button>Go to Student Dashboard</button>
            </a>
        </div>
    </div>
</body>
</html>

