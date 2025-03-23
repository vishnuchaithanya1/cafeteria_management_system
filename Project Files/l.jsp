<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cafeteria Management System</title>
    <style>
        /* Global Styles */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to bottom, #ffffff, #f1f4f8);
            color: #2e4e6d;
            overflow-x: hidden;
        }

        h1, p {
            margin: 0;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* Landing Page Container */
        .landing-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            min-height: 100vh;
            padding: 40px;
        }

        /* Header Section */
        .header {
            text-align: center;
            margin-bottom: 50px;
        }

        .header h1 {
            font-size: 3rem;
            font-weight: bold;
            color: #3b5179;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 1.25rem;
            color: #6c7a91;
            font-weight: 300;
        }

        /* Options Section */
        .options {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
            width: 100%;
        }

        .option {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 280px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .option:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .option img {
            width: 80px;
            margin-bottom: 15px;
        }

        .option button {
            background: linear-gradient(to right, #fcb045, #fd1d1d, #833ab4);
            border: none;
            color: white;
            padding: 12px 20px;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 30px;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s;
        }

        .option button:hover {
            background: linear-gradient(to right, #fd1d1d, #833ab4, #fcb045);
            transform: scale(1.05);
        }

        .option p {
            margin-top: 15px;
            font-size: 0.9rem;
            color: #6c7a91;
        }

        /* Footer Section */
        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 0.9rem;
            color: #a2a9b8;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .options {
                flex-direction: column;
                align-items: center;
            }

            .option {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>

<body>
    <div class="landing-container">
        <!-- Header Section -->
        <div class="header">
            <h1>Cafeteria Management System</h1>
            <p>Your one-stop solution for meal management</p>
        </div>

        <!-- Options Section -->
        <div class="options">
            <div class="option">
                <img src="admin_icon.png" alt="Admin Icon">
                <button onclick="window.location.href='admin_login.jsp'">Admin</button>
                <p>Manage menus, verify coupons, and more.</p>
            </div>
            <div class="option">
                <img src="student_icon.png" alt="Student Icon">
                <button onclick="window.location.href='student_login.jsp'">Student</button>
                <p>Buy coupons, view the menu, and order your meals.</p>
            </div>
        </div>

        <!-- Footer Section -->
        <div class="footer">
            <p>&copy; 2024 Cafeteria Management System | All Rights Reserved</p>
        </div>
    </div>
</body>

</html>

