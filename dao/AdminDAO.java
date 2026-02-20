package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Booking;

public class AdminDAO {

    // 🔹 Get All Bookings
    public List<Booking> getAllBookings() {

        List<Booking> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT b.id, b.user_email, b.booking_date, b.status, p.title " +
                         "FROM bookings b " +
                         "JOIN packages p ON b.package_id = p.id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking b = new Booking();

                b.setId(rs.getInt("id"));
                b.setUserEmail(rs.getString("user_email"));
                b.setBookingDate(rs.getDate("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setPackageTitle(rs.getString("title"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔹 Approve Booking
    public boolean approveBooking(int bookingId) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE bookings SET status='Approved' WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}
