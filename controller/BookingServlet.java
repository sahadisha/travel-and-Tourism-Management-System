package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

import dao.DBConnection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String packageName = request.getParameter("packageName");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings(user_email, package_name, status) VALUES(?,?,?)"
            );
            ps.setString(1, userEmail);
            ps.setString(2, packageName);
            ps.setString(3, "Pending");

            int i = ps.executeUpdate();

            ps.close();
            con.close();

            if (i > 0) {
                response.sendRedirect("myBookings.jsp?success=1");
            } else {
                response.sendRedirect("myBookings.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myBookings.jsp?error=1");
        }
    }
}
