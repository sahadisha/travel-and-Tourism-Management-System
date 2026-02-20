package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.BookingDAO;

@WebServlet("/BookNowServlet")
public class BookNowServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int packageId = Integer.parseInt(request.getParameter("id"));

        BookingDAO dao = new BookingDAO();

        if (dao.bookPackage(email, packageId)) {
            response.getWriter().println("Booking Successful!");
        } else {
            response.getWriter().println("Booking Failed!");
        }
    }
}
