package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

import dao.DBConnection;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM admin WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Successful login
                HttpSession session = request.getSession();
                session.setAttribute("adminEmail", email);
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("adminLogin.jsp?error=1");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
