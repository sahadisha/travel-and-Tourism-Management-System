<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%@ page session="true" %>

<%
    String email = (String) session.getAttribute("userEmail");

    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = "";
    String role = "";

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT name, role FROM users WHERE email=?"
        );
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            role = rs.getString("role");
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
      rel="stylesheet">

<style>
    body {
        background: linear-gradient(to right, #ff9a9e, #fad0c4);
    }
    .card {
        border-radius: 15px;
    }
</style>

</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Travel & Tourism System</span>
        <a href="LogoutServlet" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-5">

    <div class="card shadow-lg p-4">

        <h2 class="text-center text-primary mb-4">My Profile</h2>

        <div class="mb-3">
            <label class="form-label"><b>Name</b></label>
            <input type="text" class="form-control" value="<%= name %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Email</b></label>
            <input type="text" class="form-control" value="<%= email %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Role</b></label>
            <input type="text" class="form-control" value="<%= role %>" readonly>
        </div>

        <div class="text-center mt-4">
            <a href="userDashboard.jsp" class="btn btn-secondary">
                Back to Dashboard
            </a>
        </div>

    </div>

</div>

</body>
</html>
