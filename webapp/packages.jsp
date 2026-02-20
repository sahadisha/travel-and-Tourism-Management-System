<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tour Packages</title>
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
    <h2 class="text-center mb-4">Available Tour Packages</h2>
    <div class="row">

        <%
            // Example Packages
            String[][] packages = {
                {"Darjeeling Tour", "Explore Darjeeling hills and tea gardens."},
                {"Goa Package", "Relax on Goa beaches with fun activities."},
                {"Manali Adventure", "Snow, mountains, and trekking in Manali."}
            };

            for(int i=0;i<packages.length;i++){
        %>

        <div class="col-md-4 mb-4">
            <div class="card shadow h-100">
                <div class="card-body">
                    <h5 class="card-title"><%= packages[i][0] %></h5>
                    <p class="card-text"><%= packages[i][1] %></p>

                    <form action="BookingServlet" method="post">
                        <input type="hidden" name="packageName" value="<%= packages[i][0] %>">
                        <button type="submit" class="btn btn-success w-100">Book Now</button>
                    </form>

                </div>
            </div>
        </div>

        <% } %>

    </div>
</div>

</body>
</html>

