<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4 mx-auto" style="width:400px;">

        <h3 class="text-center text-dark">Admin Login</h3>

        <form action="AdminLoginServlet" method="post">

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
                    class="btn btn-dark w-100">
                Login
            </button>

        </form>

        <div class="text-center mt-3">
            <a href="index.jsp">Back to Home</a>
        </div>

    </div>

</div>

</body>
</html>
