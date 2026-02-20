<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }

        .navbar {
            background: #ffffff;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }

        .navbar h2 {
            margin: 0;
            color: #333;
        }

        .logout-btn {
            background: #ff4d4d;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }

        .logout-btn:hover {
            background: #cc0000;
        }

        .container {
            padding: 40px;
        }

        .welcome {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card h3 {
            margin-bottom: 15px;
        }

        .card a {
            text-decoration: none;
            background: #4facfe;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .card a:hover {
            background: #007bff;
        }

        footer {
            margin-top: 50px;
            text-align: center;
            color: white;
        }
    </style>
</head>

<body>

    <!-- Navbar -->
    <div class="navbar">
        <h2>Travel Tourism System</h2>
        <a class="logout-btn" href="LogoutServlet">Logout</a>
    </div>

    <div class="container">

        <div class="welcome">
            <h1>Welcome, <%= userEmail %> 👋</h1>
            <p>Explore tours, book hotels, and manage your trips easily.</p>
        </div>

        <div class="card-container">

            <div class="card">
                <h3>🌍 View Tour Packages</h3>
                <p>Explore exciting travel destinations and book your next adventure.</p>
                <a href="packages.jsp">Explore Packages</a>
            </div>

            <div class="card">
                <h3>🏨 View Hotels</h3>
                <p>Find comfortable hotels and book your stay easily.</p>
                <a href="hotels.jsp">View Hotels</a>
            </div>

            <div class="card">
                <h3>📖 View My Bookings</h3>
                <p>Check your tour and hotel booking details.</p>
                <a href="myBookings.jsp">View Bookings</a>
            </div>

            <div class="card">
                <h3>👤 My Profile</h3>
                <p>View and manage your account information.</p>
                <a href="profile.jsp">View Profile</a>
            </div>

        </div>

    </div>

    <footer>
        <p>© 2026 Travel Tourism Management System</p>
    </footer>

</body>
</html>
