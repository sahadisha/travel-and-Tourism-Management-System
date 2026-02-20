<%
Connection testCon = DBConnection.getConnection();
out.println("Connected DB: " + testCon.getCatalog());
%>


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
<title>Admin - Tour Bookings</title>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #141e30, #243b55);
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
        background: #243b55;
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
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    }

    th, td {
        padding: 12px;
        text-align: center;
    }

    th {
        background: #243b55;
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

    .Pending { color: orange; }
    .Approved { color: green; }
    .Rejected { color: red; }

</style>
</head>
<body>

<div class="navbar">
    <h2>Admin - Tour Bookings</h2>
    <a class="back-btn" href="adminDashboard.jsp">⬅ Back</a>
</div>

<div class="container">

<table>
<tr>
    <th>ID</th>
    <th>User Email</th>
    <th>Package Name</th>
    <th>Travel Date</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
try {
    Connection con = DBConnection.getConnection();
    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery("SELECT * FROM bookings");

    while(rs.next()) {
        String status = rs.getString("status");
%>

<tr>
    <td><%= rs.getInt("id") %></td>
<td><%= rs.getString("user_email") %></td>
<td><%= rs.getString("package_name") %></td>
<td><%= rs.getString("status") %></td>
    <td>
        <% if(status.equals("Pending")) { %>

            <form action="UpdateBookingStatusServlet" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="status" value="Approved">
                <button class="btn approve">Approve</button>
            </form>

            <form action="UpdateBookingStatusServlet" method="post" style="display:inline;">
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
