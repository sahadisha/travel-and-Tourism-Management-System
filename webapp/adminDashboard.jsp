<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String adminEmail = (String) session.getAttribute("adminEmail");
    if(adminEmail == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #1e3c72, #2a5298);
    }

    .navbar {
        background: white;
        padding: 15px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 3px 8px rgba(0,0,0,0.2);
    }

    .navbar h2 {
        margin: 0;
    }

    .logout-btn {
        background: red;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
    }

    .container {
        padding: 40px;
        text-align: center;
        color: white;
    }

    .card-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
        margin-top: 40px;
    }

    .card {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        transition: 0.3s;
    }

    .card:hover {
        transform: scale(1.05);
    }

    .card h3 {
        margin-bottom: 15px;
        color: #333;
    }

    .card a {
        text-decoration: none;
        background: #2a5298;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
    }

    .card a:hover {
        background: #1e3c72;
    }

</style>
</head>
<body>

<div class="navbar">
    <h2>Admin Dashboard</h2>
    <a class="logout-btn" href="AdminLogoutServlet">Logout</a>
</div>

<div class="container">
    <h1>Welcome Admin 👑</h1>

    <div class="card-container">

        <div class="card">
            <h3>🌍 Manage Tour Bookings</h3>
            <a href="adminBookings.jsp">View Tour Bookings</a>
        </div>

        <div class="card">
            <h3>🏨 Manage Hotel Bookings</h3>
            <a href="adminHotelBookings.jsp">View Hotel Bookings</a>
        </div>

       

        

    </div>
</div>

</body>
</html>
