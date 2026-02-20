<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

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
<title>My Hotel Bookings</title>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #36d1dc, #5b86e5);
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

    .back-btn {
        background: #5b86e5;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
    }

    .container {
        padding: 40px;
    }

    .title {
        text-align: center;
        color: white;
        margin-bottom: 30px;
    }

    .booking-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
    }

    .booking-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    .status {
        font-weight: bold;
        padding: 5px 10px;
        border-radius: 5px;
        display: inline-block;
        margin-top: 10px;
    }

    .Pending { background: orange; color: white; }
    .Approved { background: green; color: white; }
    .Rejected { background: red; color: white; }

    .no-data {
        text-align: center;
        color: white;
        font-size: 20px;
    }

    footer {
        margin-top: 40px;
        text-align: center;
        color: white;
    }
</style>

</head>
<body>

<div class="navbar">
    <h2>My Hotel Bookings</h2>
    <a class="back-btn" href="userDashboard.jsp">⬅ Back</a>
</div>

<div class="container">

<div class="title">
    <h1>Your Booked Hotels 🏨</h1>
</div>

<div class="booking-grid">

<%
try {
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT h.hotel_name, hb.check_in, hb.check_out, hb.status " +
        "FROM hotel_bookings hb JOIN hotels h ON hb.hotel_id = h.id " +
        "WHERE hb.user_email = ?"
    );

    ps.setString(1, userEmail);
    ResultSet rs = ps.executeQuery();

    boolean hasData = false;

    while(rs.next()) {
        hasData = true;
        String status = rs.getString("status");
%>

    <div class="booking-card">
        <h3><%= rs.getString("hotel_name") %></h3>
        <p><strong>Check-in:</strong> <%= rs.getString("check_in") %></p>
        <p><strong>Check-out:</strong> <%= rs.getString("check_out") %></p>

        <div class="status <%= status %>">
            <%= status %>
        </div>
    </div>

<%
    }

    if(!hasData){
%>
        <div class="no-data">
            You have no hotel bookings yet.
        </div>
<%
    }

} catch(Exception e){
    out.println("<div class='no-data'>Error: " + e.getMessage() + "</div>");
}
%>

</div>
</div>

<footer>
    <p>© 2026 Travel Tourism Management System</p>
</footer>

</body>
</html>
