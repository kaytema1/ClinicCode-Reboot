package entities;
// Generated Nov 25, 2013 10:35:09 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * LabStockItemBatchInfo generated by hbm2java
 */
public class LabStockItemBatchInfo  implements java.io.Serializable {


     private Integer id;
     private int itemId;
     private String batchNum;
     private double startQty;
     private Date startDate;
     private String staffId;

    public LabStockItemBatchInfo() {
    }

    public LabStockItemBatchInfo(int itemId, String batchNum, double startQty, Date startDate, String staffId) {
       this.itemId = itemId;
       this.batchNum = batchNum;
       this.startQty = startQty;
       this.startDate = startDate;
       this.staffId = staffId;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public int getItemId() {
        return this.itemId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    public String getBatchNum() {
        return this.batchNum;
    }
    
    public void setBatchNum(String batchNum) {
        this.batchNum = batchNum;
    }
    public double getStartQty() {
        return this.startQty;
    }
    
    public void setStartQty(double startQty) {
        this.startQty = startQty;
    }
    public Date getStartDate() {
        return this.startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public String getStaffId() {
        return this.staffId;
    }
    
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }




}


