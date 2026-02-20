package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Booking;

public class BookingDAO {

    // 🔹 1️⃣ Book Package (Insert into DB)
    public boolean bookPackage(String email, int packageId) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO bookings(user_email, package_id, booking_date, status) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setInt(2, packageId);
            ps.setDate(3, Date.valueOf(LocalDate.now()));
            ps.setString(4, "Pending");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // 🔹 2️⃣ Get All Bookings of Logged-in User (With Package Details)
    public List<Booking> getUserBookings(String email) {

        List<Booking> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT b.id AS booking_id, b.booking_date, b.status, " +
                         "p.id AS package_id, p.title, p.location, p.price " +
                         "FROM bookings b " +
                         "JOIN packages p ON b.package_id = p.id " +
                         "WHERE b.user_email = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setId(rs.getInt("booking_id"));
                booking.setPackageId(rs.getInt("package_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setStatus(rs.getString("status"));

                // Optional (if your Booking model has these fields)
                booking.setPackageTitle(rs.getString("title"));
                booking.setLocation(rs.getString("location"));
                booking.setPrice(rs.getDouble("price"));

                booking.setUserEmail(email);

                list.add(booking);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
