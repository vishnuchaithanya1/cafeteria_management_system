<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cafeteria Management System</title>
    <!-- Box Icons -->
    <link rel="stylesheet"
  href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
  <!-- Link To CSS -->
  <link rel="stylesheet" href="styles1.css">

</head>
<body>
    <!-- Navbar -->
    <header>
        <a href="#" class="logo">Cafeteria Management System</a>
        <div class="bx bx-menu" id="menu-icon"></div>

        <ul class="navbar">
            <li><a href="#home">Home</a></li>
            <li><a href="student_login.jsp">Student</a></li>
            <li><a href="admin_login.jsp">Admin</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
            <!-- Dark Mode -->
            <div class="bx bx-moon" id="darkmode"></div>
        </ul>
    </header>
    <!-- Home Section -->
    <section class="home" id="home">
        <div class="home-text">
            <h1>Cafeteria Management System</h1>
            <h2>The tasty food of <br> your choice</h2>
            <a href="admin_login.jsp" class="btn">Admin</a>
            <a href="student_login.jsp" class="btn">Student</a>
        </div>
        <div class="home-img">
            <img src="s.png" alt="">
        </div>
    </section>

    <!-- About -->
    <section class="about" id="about">
        <div class="about-img">
            <img src="ep.jpg" alt="">
        </div>
        <div class="about-text">
            <span>About Us</span>
            <h2>We make good and <br> tasty food</h2>
            <p>Welcome to Cafeteria Management System  – Your go-to spot for fresh, delicious, and affordable meals! Whether you're craving a quick snack, a hearty lunch, or a refreshing drink, we’ve got something for everyone. Enjoy a cozy ambiance and a menu crafted to satisfy every taste. Come in hungry, leave happy!</p>
            <a href="#" class="btn">Learn More</a>
        </div>
    </section>

    <!-- Connect -->
    <section class="connect">
        <div class="connect-text">
            <span>Let's Talk</span>
            <h2>Connect now</h2>
        </div>
        <a href="#" class="btn">Contact Us</a>
    </section>

    <!-- Contact -->
    <section class="contact" id="contact">
        <div class="contact-box">
            <h3>Cafeteria Management System</h3>
            <span>Connect With Us</span>
            <div class="social">
                <a href="https://www.facebook.com/"><i class='bx bxl-facebook' ></i></a>
                <a href="https://www.x.com/"><i class='bx bxl-twitter' ></i></a>
                <a href="https://www.instagram.com/"><i class='bx bxl-instagram' ></i></a>
            </div>
        </div>
        <div class="contact-box">
            <h3>Menu Links</h3>
            <li><a href="#home">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#menu">Menu</a></li>
            <li><a href="#services">Service</a></li>
            <li><a href="#contact">Contact</a></li>
        </div>
        <div class="contact-box">
            <h3>Quick Links</h3>
            <li><a href="#Contact">Contact</a></li>
            <li><a href="#Privacy Policy">Privacy Policy</a></li>
            <li><a href="#Disclaimer">Disclaimer</a></li>
            <li><a href="#Terms Of Use">Terms Of Use</a></li>
        </div>
        <div class="contact-box address">
            <h3>Contact</h3>
            <i class='bx bxs-map' ><span>Rgukt Basar</span></i>
            <i class='bx bxs-phone' ><span>+91 9988017689</span></i>
            <i class='bx bxs-envelope' ><span>contact@cms.com</span></i>
        </div>
    </section>

    <!-- Copyright -->
    <div class="copyright">
        <p>© All Rights Reserved.</p>
    </div>

    <!-- Scroll Reveal -->
    <script src="https://unpkg.com/scrollreveal"></script>
    <!-- Link To JavaScript -->
    <script src="script1.js"></script>
</body>
</html>

