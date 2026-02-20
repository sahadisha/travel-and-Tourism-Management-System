package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

import dao.DBConnection;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String bookingId = request.getParameter("id");
        String userRole = request.getParameter("role"); // "user" or "admin"

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE bookings SET status='Cancelled' WHERE id=?"
            );

            ps.setInt(1, Integer.parseInt(bookingId));
            ps.executeUpdate();

            ps.close();
            con.close();

            // Redirect based on role
            if ("admin".equalsIgnoreCase(userRole)) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("myBookings.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
