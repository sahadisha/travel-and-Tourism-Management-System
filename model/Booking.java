package model;

import java.sql.Date;

public class Booking {

    private int id;
    private String userEmail;
    private int packageId;
    private Date bookingDate;
    private String status;
    private String packageTitle;
    private String location;
    private double price;


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public int getPackageId() { return packageId; }
    public void setPackageId(int packageId) { this.packageId = packageId; }

    public Date getBookingDate() { return bookingDate; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getPackageTitle() { return packageTitle; }
    public void setPackageTitle(String packageTitle) { this.packageTitle = packageTitle; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

}
