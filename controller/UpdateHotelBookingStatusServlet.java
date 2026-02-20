package controller;

import java.io.*;
import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;

@jakarta.servlet.annotation.WebServlet("/UpdateHotelBookingStatusServlet")
public class UpdateHotelBookingStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE hotel_bookings SET status=? WHERE id=?"
            );

            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();

            response.sendRedirect("adminHotelBookings.jsp");

        } catch(Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
