<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="userDashboard.jsp">Travel & Tourism</a>
        <a href="LogoutServlet" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">My Bookings</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Package Name</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>

        <%
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM bookings WHERE user_email=?");
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();

                if(!rs.isBeforeFirst()){ // No bookings
        %>
            <tr>
                <td colspan="3" class="text-center">No bookings found</td>
            </tr>
        <%
                } else {
                    while(rs.next()){
                        int id = rs.getInt("id");
                        String packageName = rs.getString("package_name");
                        String status = rs.getString("status");
        %>
            <tr>
                <td><%= id %></td>
                <td><%= packageName %></td>
                <td><%= status %></td>
            </tr>
        <%
                    }
                }

                rs.close();
                ps.close();
                con.close();

            } catch(Exception e){
                out.println("<tr><td colspan='3'>Error: "+e.getMessage()+"</td></tr>");
            }
        %>

        </tbody>
    </table>

</div>

</body>
</html>
