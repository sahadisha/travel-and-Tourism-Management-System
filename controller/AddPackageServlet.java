package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import model.Package;
import dao.PackageDAO;

@WebServlet("/AddPackageServlet")
public class AddPackageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String location = request.getParameter("location");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        Package pkg = new Package();
        pkg.setTitle(title);
        pkg.setLocation(location);
        pkg.setPrice(price);
        pkg.setDescription(description);

        PackageDAO dao = new PackageDAO();

        if (dao.addPackage(pkg)) {
            response.getWriter().println("Package Added Successfully!");
        } else {
            response.getWriter().println("Failed to Add Package!");
        }
    }
}
