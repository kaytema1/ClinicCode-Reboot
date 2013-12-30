package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * PatientBills generated by hbm2java
 */
@Entity
@Table(name="patient_bills"
    ,catalog="extended"
)
public class PatientBills  implements java.io.Serializable {


     private Integer id;
     private String billType;
     private String patientid;
     private int visitid;
     private double totalBill;
     private double amountPaid;
     private String status;
     private int laborderDiscount;
     private int pharmorderDiscount;
     private int medicalDiscount;
     private int procedureDiscount;
     private Date billdate;
     private String staffId;
     private Date date;

    public PatientBills() {
    }

    public PatientBills(String billType, String patientid, int visitid, double totalBill, double amountPaid, String status, int laborderDiscount, int pharmorderDiscount, int medicalDiscount, int procedureDiscount, Date billdate, String staffId, Date date) {
       this.billType = billType;
       this.patientid = patientid;
       this.visitid = visitid;
       this.totalBill = totalBill;
       this.amountPaid = amountPaid;
       this.status = status;
       this.laborderDiscount = laborderDiscount;
       this.pharmorderDiscount = pharmorderDiscount;
       this.medicalDiscount = medicalDiscount;
       this.procedureDiscount = procedureDiscount;
       this.billdate = billdate;
       this.staffId = staffId;
       this.date = date;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="bill_type", nullable=false)
    public String getBillType() {
        return this.billType;
    }
    
    public void setBillType(String billType) {
        this.billType = billType;
    }
    
    @Column(name="patientid", nullable=false, length=65535)
    public String getPatientid() {
        return this.patientid;
    }
    
    public void setPatientid(String patientid) {
        this.patientid = patientid;
    }
    
    @Column(name="visitid", nullable=false)
    public int getVisitid() {
        return this.visitid;
    }
    
    public void setVisitid(int visitid) {
        this.visitid = visitid;
    }
    
    @Column(name="total_bill", nullable=false, precision=22, scale=0)
    public double getTotalBill() {
        return this.totalBill;
    }
    
    public void setTotalBill(double totalBill) {
        this.totalBill = totalBill;
    }
    
    @Column(name="amount_paid", nullable=false, precision=22, scale=0)
    public double getAmountPaid() {
        return this.amountPaid;
    }
    
    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }
    
    @Column(name="status", nullable=false, length=65535)
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    @Column(name="laborder_discount", nullable=false)
    public int getLaborderDiscount() {
        return this.laborderDiscount;
    }
    
    public void setLaborderDiscount(int laborderDiscount) {
        this.laborderDiscount = laborderDiscount;
    }
    
    @Column(name="pharmorder_discount", nullable=false)
    public int getPharmorderDiscount() {
        return this.pharmorderDiscount;
    }
    
    public void setPharmorderDiscount(int pharmorderDiscount) {
        this.pharmorderDiscount = pharmorderDiscount;
    }
    
    @Column(name="medical_discount", nullable=false)
    public int getMedicalDiscount() {
        return this.medicalDiscount;
    }
    
    public void setMedicalDiscount(int medicalDiscount) {
        this.medicalDiscount = medicalDiscount;
    }
    
    @Column(name="procedure_discount", nullable=false)
    public int getProcedureDiscount() {
        return this.procedureDiscount;
    }
    
    public void setProcedureDiscount(int procedureDiscount) {
        this.procedureDiscount = procedureDiscount;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="billdate", nullable=false, length=19)
    public Date getBilldate() {
        return this.billdate;
    }
    
    public void setBilldate(Date billdate) {
        this.billdate = billdate;
    }
    
    @Column(name="staff_id", nullable=false)
    public String getStaffId() {
        return this.staffId;
    }
    
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="date", nullable=false, length=10)
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }




}

