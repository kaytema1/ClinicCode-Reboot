package entities;
// Generated Nov 25, 2013 10:35:09 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * LabStock generated by hbm2java
 */
public class LabStock  implements java.io.Serializable {


     private String batchNumber;
     private String itemId;
     private int labStockItemDistributorId;
     private Date manufactureDate;
     private Date expiryDate;
     private int qty;
     private double unitPrice;
     private double totalPrice;
     private String staffId;
     private Date dateAdded;

    public LabStock() {
    }

	
    public LabStock(String batchNumber, String itemId, int labStockItemDistributorId, Date expiryDate, int qty, double unitPrice, double totalPrice, String staffId, Date dateAdded) {
        this.batchNumber = batchNumber;
        this.itemId = itemId;
        this.labStockItemDistributorId = labStockItemDistributorId;
        this.expiryDate = expiryDate;
        this.qty = qty;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.staffId = staffId;
        this.dateAdded = dateAdded;
    }
    public LabStock(String batchNumber, String itemId, int labStockItemDistributorId, Date manufactureDate, Date expiryDate, int qty, double unitPrice, double totalPrice, String staffId, Date dateAdded) {
       this.batchNumber = batchNumber;
       this.itemId = itemId;
       this.labStockItemDistributorId = labStockItemDistributorId;
       this.manufactureDate = manufactureDate;
       this.expiryDate = expiryDate;
       this.qty = qty;
       this.unitPrice = unitPrice;
       this.totalPrice = totalPrice;
       this.staffId = staffId;
       this.dateAdded = dateAdded;
    }
   
    public String getBatchNumber() {
        return this.batchNumber;
    }
    
    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }
    public String getItemId() {
        return this.itemId;
    }
    
    public void setItemId(String itemId) {
        this.itemId = itemId;
    }
    public int getLabStockItemDistributorId() {
        return this.labStockItemDistributorId;
    }
    
    public void setLabStockItemDistributorId(int labStockItemDistributorId) {
        this.labStockItemDistributorId = labStockItemDistributorId;
    }
    public Date getManufactureDate() {
        return this.manufactureDate;
    }
    
    public void setManufactureDate(Date manufactureDate) {
        this.manufactureDate = manufactureDate;
    }
    public Date getExpiryDate() {
        return this.expiryDate;
    }
    
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    public int getQty() {
        return this.qty;
    }
    
    public void setQty(int qty) {
        this.qty = qty;
    }
    public double getUnitPrice() {
        return this.unitPrice;
    }
    
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
    public double getTotalPrice() {
        return this.totalPrice;
    }
    
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    public String getStaffId() {
        return this.staffId;
    }
    
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
    public Date getDateAdded() {
        return this.dateAdded;
    }
    
    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }




}


