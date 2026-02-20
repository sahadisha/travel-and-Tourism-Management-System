

package controller;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;

import dao.DBConnection;
@WebServlet("/HotelBookingServlet")

public class HotelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userEmail = (String) request.getSession().getAttribute("userEmail");
        int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
        String checkIn = request.getParameter("check_in");
        String checkOut = request.getParameter("check_out");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO hotel_bookings (user_email, hotel_id, check_in, check_out) VALUES (?, ?, ?, ?)"
            );

            ps.setString(1, userEmail);
            ps.setInt(2, hotelId);
            ps.setString(3, checkIn);
            ps.setString(4, checkOut);

            int i = ps.executeUpdate();

            if(i > 0){
                response.sendRedirect("myHotelBookings.jsp");
            } else {
                response.getWriter().println("Booking Failed");
            }

        } catch(Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
