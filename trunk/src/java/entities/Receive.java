package entities;
// Generated Nov 25, 2013 10:35:09 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * Receive generated by hbm2java
 */
public class Receive  implements java.io.Serializable {


     private Integer id;
     private Date date;
     private String items;
     private String itemId;
     private int quantity;
     private String unit;
     private String receiver;
     private String transactionId;

    public Receive() {
    }

    public Receive(Date date, String items, String itemId, int quantity, String unit, String receiver, String transactionId) {
       this.date = date;
       this.items = items;
       this.itemId = itemId;
       this.quantity = quantity;
       this.unit = unit;
       this.receiver = receiver;
       this.transactionId = transactionId;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    public String getItems() {
        return this.items;
    }
    
    public void setItems(String items) {
        this.items = items;
    }
    public String getItemId() {
        return this.itemId;
    }
    
    public void setItemId(String itemId) {
        this.itemId = itemId;
    }
    public int getQuantity() {
        return this.quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getUnit() {
        return this.unit;
    }
    
    public void setUnit(String unit) {
        this.unit = unit;
    }
    public String getReceiver() {
        return this.receiver;
    }
    
    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }
    public String getTransactionId() {
        return this.transactionId;
    }
    
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }




}

