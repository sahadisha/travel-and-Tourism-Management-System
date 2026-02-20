package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
