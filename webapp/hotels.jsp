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
    <title>Available Hotels</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #667eea, #764ba2);
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
            background: #667eea;
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

        .hotel-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }

        .hotel-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        .hotel-card:hover {
            transform: scale(1.05);
        }

        .hotel-card h3 {
            margin-top: 0;
            color: #333;
        }

        .price {
            font-weight: bold;
            color: #4CAF50;
            margin: 10px 0;
        }

        .book-btn {
            display: inline-block;
            margin-top: 10px;
            background: #667eea;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
        }

        .book-btn:hover {
            background: #4b5bdc;
        }

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
    <h2>Travel Tourism System</h2>
    <a class="back-btn" href="userDashboard.jsp">⬅ Back to Dashboard</a>
</div>

<div class="container">

    <div class="title">
        <h1>🏨 Available Hotels</h1>
        <p>Choose your perfect stay</p>
    </div>

    <div class="hotel-grid">

<%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM hotels");

        boolean hasData = false;

        while(rs.next()) {
            hasData = true;
%>

        <div class="hotel-card">
            <h3><%= rs.getString("hotel_name") %></h3>
            <p><strong>Location:</strong> <%= rs.getString("location") %></p>
            <p><%= rs.getString("description") %></p>
            <div class="price">₹ <%= rs.getInt("price_per_night") %> / night</div>

            <a class="book-btn" href="bookHotel.jsp?id=<%= rs.getInt("id") %>">
                Book Now
            </a>
        </div>

<%
        }

        if(!hasData){
%>
            <div class="no-data">
                No Hotels Available
            </div>
<%
        }

    } catch(Exception e) {
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
