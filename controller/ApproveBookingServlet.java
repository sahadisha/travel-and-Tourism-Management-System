package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

import dao.DBConnection;

@WebServlet("/ApproveBookingServlet")
public class ApproveBookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE bookings SET status=? WHERE id=?"
            );

            ps.setString(1, action.equalsIgnoreCase("approve") ? "Approved" : "Rejected");
            ps.setInt(2, Integer.parseInt(id));

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("adminDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
