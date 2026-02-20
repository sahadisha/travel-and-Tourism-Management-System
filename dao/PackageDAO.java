package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Package;

public class PackageDAO {

    // 1️ Add Package
    public boolean addPackage(Package pkg) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO packages(title, location, price, description) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, pkg.getTitle());
            ps.setString(2, pkg.getLocation());
            ps.setDouble(3, pkg.getPrice());
            ps.setString(4, pkg.getDescription());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // 2️ Get All Packages
    public List<Package> getAllPackages() {

        List<Package> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM packages";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Package pkg = new Package();

                //  VERY IMPORTANT
                pkg.setId(rs.getInt("id"));

                pkg.setTitle(rs.getString("title"));
                pkg.setLocation(rs.getString("location"));
                pkg.setPrice(rs.getDouble("price"));
                pkg.setDescription(rs.getString("description"));

                list.add(pkg);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }



    // 3️ Get Package By ID (Useful for Booking Page Later)
    public Package getPackageById(int id) {

        Package pkg = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM packages WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                pkg = new Package();
                pkg.setTitle(rs.getString("title"));
                pkg.setLocation(rs.getString("location"));
                pkg.setPrice(rs.getDouble("price"));
                pkg.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pkg;
    }


    // 4️ Delete Package (Admin Future Use)
    public boolean deletePackage(int id) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM packages WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

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
