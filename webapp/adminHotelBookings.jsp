<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

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
<title>Admin - Hotel Bookings</title>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #ff9966, #ff5e62);
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
        background: #ff5e62;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
    }

    .container {
        padding: 40px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    th, td {
        padding: 12px;
        text-align: center;
    }

    th {
        background: #ff5e62;
        color: white;
    }

    tr:nth-child(even) {
        background: #f2f2f2;
    }

    .btn {
        padding: 6px 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        color: white;
    }

    .approve {
        background: green;
    }

    .reject {
        background: red;
    }

    .status {
        font-weight: bold;
    }

</style>
</head>
<body>

<div class="navbar">
    <h2>Admin - Hotel Bookings</h2>
    <a class="back-btn" href="adminDashboard.jsp">⬅ Back</a>
</div>

<div class="container">

<table>
<tr>
    <th>ID</th>
    <th>User Email</th>
    <th>Hotel</th>
    <th>Check-in</th>
    <th>Check-out</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
try {
    Connection con = DBConnection.getConnection();
    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(
        "SELECT hb.id, hb.user_email, h.hotel_name, hb.check_in, hb.check_out, hb.status " +
        "FROM hotel_bookings hb JOIN hotels h ON hb.hotel_id = h.id"
    );

    while(rs.next()) {
        String status = rs.getString("status");
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("user_email") %></td>
    <td><%= rs.getString("hotel_name") %></td>
    <td><%= rs.getString("check_in") %></td>
    <td><%= rs.getString("check_out") %></td>
    <td class="status"><%= status %></td>
    <td>
        <% if(status.equals("Pending")) { %>
            <form action="UpdateHotelBookingStatusServlet" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="status" value="Approved">
                <button class="btn approve">Approve</button>
            </form>

            <form action="UpdateHotelBookingStatusServlet" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="status" value="Rejected">
                <button class="btn reject">Reject</button>
            </form>
        <% } else { %>
            No Action
        <% } %>
    </td>
</tr>

<%
    }
} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

</table>

</div>

</body>
</html>
