package controller;

import java.io.*;
import java.sql.*;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE bookings SET status=? WHERE id=?"
            );

            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();

            response.sendRedirect("adminBookings.jsp");

        } catch(Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
