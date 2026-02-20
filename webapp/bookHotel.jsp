<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null){
        response.sendRedirect("login.jsp");
    }

    int hotelId = Integer.parseInt(request.getParameter("id"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Hotel</title>
<style>
    body { font-family: Arial; background:#f2f2f2; }
    .form-box {
        width:400px;
        margin:50px auto;
        background:white;
        padding:30px;
        border-radius:10px;
        box-shadow:0 4px 10px rgba(0,0,0,0.2);
    }
    input, button {
        width:100%;
        padding:10px;
        margin-top:10px;
    }
    button {
        background:#667eea;
        color:white;
        border:none;
    }
</style>
</head>
<body>

<div class="form-box">
    <h2>Book Hotel</h2>

    <form action="HotelBookingServlet" method="post">
        <input type="hidden" name="hotel_id" value="<%= hotelId %>">

        <label>Check-in Date</label>
        <input type="date" name="check_in" required>

        <label>Check-out Date</label>
        <input type="date" name="check_out" required>

        <button type="submit">Confirm Booking</button>
    </form>
</div>

</body>
</html>
