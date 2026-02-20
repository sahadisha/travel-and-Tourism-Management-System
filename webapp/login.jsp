<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4 mx-auto" style="width:400px;">

        <h3 class="text-center text-success">User Login</h3>

        <form action="LoginServlet" method="post">

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password"
                       class="form-control" required>
            </div>

            <button type="submit"
                    class="btn btn-success w-100">
                Login
            </button>

        </form>

        <div class="text-center mt-3">
            <small>
                New User?
                <a href="register.jsp">Register Here</a>
            </small>
        </div>

    </div>

</div>

</body>
</html>
