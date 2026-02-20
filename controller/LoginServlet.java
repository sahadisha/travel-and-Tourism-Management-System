package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String role = rs.getString("role");

                HttpSession session = request.getSession();

                // 🔥 If Admin
                if ("admin".equalsIgnoreCase(role)) {

                    session.setAttribute("admin", email);
                    response.sendRedirect("adminDashboard.jsp");

                }
                // 🔥 If Normal User
                else {

                    session.setAttribute("userEmail", email);
                    response.sendRedirect("userDashboard.jsp");

                }

            } else {

                response.sendRedirect("login.jsp?error=1");

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

