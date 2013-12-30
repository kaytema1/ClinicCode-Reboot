package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Laborders generated by hbm2java
 */
@Entity
@Table(name="laborders"
    ,catalog="extended"
)
public class Laborders  implements java.io.Serializable {


     private String orderid;
     private String patientid;
     private String facility;
     private String fromdoc;
     private String todoc;
     private String physician;
     private double totalAmount;
     private Date orderdate;
     private Date donedate;
     private Boolean viewed;
     private int visitid;
     private String done;
     private Double amountpaid;
     private Double outstanding;
     private String scrutinized;
     private Date date;
     private String receivedBy;

    public Laborders() {
    }

	
    public Laborders(String orderid, String patientid, String facility, String fromdoc, String physician, double totalAmount, Date orderdate, int visitid, String done, String scrutinized, Date date, String receivedBy) {
        this.orderid = orderid;
        this.patientid = patientid;
        this.facility = facility;
        this.fromdoc = fromdoc;
        this.physician = physician;
        this.totalAmount = totalAmount;
        this.orderdate = orderdate;
        this.visitid = visitid;
        this.done = done;
        this.scrutinized = scrutinized;
        this.date = date;
        this.receivedBy = receivedBy;
    }
    public Laborders(String orderid, String patientid, String facility, String fromdoc, String todoc, String physician, double totalAmount, Date orderdate, Date donedate, Boolean viewed, int visitid, String done, Double amountpaid, Double outstanding, String scrutinized, Date date, String receivedBy) {
       this.orderid = orderid;
       this.patientid = patientid;
       this.facility = facility;
       this.fromdoc = fromdoc;
       this.todoc = todoc;
       this.physician = physician;
       this.totalAmount = totalAmount;
       this.orderdate = orderdate;
       this.donedate = donedate;
       this.viewed = viewed;
       this.visitid = visitid;
       this.done = done;
       this.amountpaid = amountpaid;
       this.outstanding = outstanding;
       this.scrutinized = scrutinized;
       this.date = date;
       this.receivedBy = receivedBy;
    }
   
     @Id 
    
    @Column(name="orderid", unique=true, nullable=false, length=100)
    public String getOrderid() {
        return this.orderid;
    }
    
    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }
    
    @Column(name="patientid", nullable=false, length=50)
    public String getPatientid() {
        return this.patientid;
    }
    
    public void setPatientid(String patientid) {
        this.patientid = patientid;
    }
    
    @Column(name="facility", nullable=false, length=65535)
    public String getFacility() {
        return this.facility;
    }
    
    public void setFacility(String facility) {
        this.facility = facility;
    }
    
    @Column(name="fromdoc", nullable=false)
    public String getFromdoc() {
        return this.fromdoc;
    }
    
    public void setFromdoc(String fromdoc) {
        this.fromdoc = fromdoc;
    }
    
    @Column(name="todoc")
    public String getTodoc() {
        return this.todoc;
    }
    
    public void setTodoc(String todoc) {
        this.todoc = todoc;
    }
    
    @Column(name="physician", nullable=false, length=65535)
    public String getPhysician() {
        return this.physician;
    }
    
    public void setPhysician(String physician) {
        this.physician = physician;
    }
    
    @Column(name="total_amount", nullable=false, precision=22, scale=0)
    public double getTotalAmount() {
        return this.totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="orderdate", nullable=false, length=19)
    public Date getOrderdate() {
        return this.orderdate;
    }
    
    public void setOrderdate(Date orderdate) {
        this.orderdate = orderdate;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="donedate", length=19)
    public Date getDonedate() {
        return this.donedate;
    }
    
    public void setDonedate(Date donedate) {
        this.donedate = donedate;
    }
    
    @Column(name="viewed")
    public Boolean getViewed() {
        return this.viewed;
    }
    
    public void setViewed(Boolean viewed) {
        this.viewed = viewed;
    }
    
    @Column(name="visitid", nullable=false)
    public int getVisitid() {
        return this.visitid;
    }
    
    public void setVisitid(int visitid) {
        this.visitid = visitid;
    }
    
    @Column(name="done", nullable=false, length=20)
    public String getDone() {
        return this.done;
    }
    
    public void setDone(String done) {
        this.done = done;
    }
    
    @Column(name="amountpaid", precision=22, scale=0)
    public Double getAmountpaid() {
        return this.amountpaid;
    }
    
    public void setAmountpaid(Double amountpaid) {
        this.amountpaid = amountpaid;
    }
    
    @Column(name="outstanding", precision=22, scale=0)
    public Double getOutstanding() {
        return this.outstanding;
    }
    
    public void setOutstanding(Double outstanding) {
        this.outstanding = outstanding;
    }
    
    @Column(name="scrutinized", nullable=false, length=65535)
    public String getScrutinized() {
        return this.scrutinized;
    }
    
    public void setScrutinized(String scrutinized) {
        this.scrutinized = scrutinized;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="date", nullable=false, length=10)
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    @Column(name="received_by", nullable=false)
    public String getReceivedBy() {
        return this.receivedBy;
    }
    
    public void setReceivedBy(String receivedBy) {
        this.receivedBy = receivedBy;
    }




}

