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
 * Claimtable generated by hbm2java
 */
@Entity
@Table(name="claimtable"
    ,catalog="extended"
)
public class Claimtable  implements java.io.Serializable {


     private Integer tableid;
     private int claimid;
     private String sportype;
     private int visitid;
     private String patientid;
     private String status;
     private Double totalClaim;
     private Date claimDate;
     private Date firstVisit;
     private Date secondVisit;
     private Date thirdVisit;
     private Date fourthVisit;
     private Integer secondVisitid;
     private Integer thirdVisitid;
     private Integer fourthVisitid;
     private int patientage;
     private String badgeid;
     private double returnAmount;
     private String returnNotes;
     private String insuranceid;
     private String acceptReject;

    public Claimtable() {
    }

	
    public Claimtable(int claimid, String sportype, int visitid, String patientid, String status, Date claimDate, Date firstVisit, int patientage, String badgeid, double returnAmount, String returnNotes, String insuranceid, String acceptReject) {
        this.claimid = claimid;
        this.sportype = sportype;
        this.visitid = visitid;
        this.patientid = patientid;
        this.status = status;
        this.claimDate = claimDate;
        this.firstVisit = firstVisit;
        this.patientage = patientage;
        this.badgeid = badgeid;
        this.returnAmount = returnAmount;
        this.returnNotes = returnNotes;
        this.insuranceid = insuranceid;
        this.acceptReject = acceptReject;
    }
    public Claimtable(int claimid, String sportype, int visitid, String patientid, String status, Double totalClaim, Date claimDate, Date firstVisit, Date secondVisit, Date thirdVisit, Date fourthVisit, Integer secondVisitid, Integer thirdVisitid, Integer fourthVisitid, int patientage, String badgeid, double returnAmount, String returnNotes, String insuranceid, String acceptReject) {
       this.claimid = claimid;
       this.sportype = sportype;
       this.visitid = visitid;
       this.patientid = patientid;
       this.status = status;
       this.totalClaim = totalClaim;
       this.claimDate = claimDate;
       this.firstVisit = firstVisit;
       this.secondVisit = secondVisit;
       this.thirdVisit = thirdVisit;
       this.fourthVisit = fourthVisit;
       this.secondVisitid = secondVisitid;
       this.thirdVisitid = thirdVisitid;
       this.fourthVisitid = fourthVisitid;
       this.patientage = patientage;
       this.badgeid = badgeid;
       this.returnAmount = returnAmount;
       this.returnNotes = returnNotes;
       this.insuranceid = insuranceid;
       this.acceptReject = acceptReject;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="tableid", unique=true, nullable=false)
    public Integer getTableid() {
        return this.tableid;
    }
    
    public void setTableid(Integer tableid) {
        this.tableid = tableid;
    }
    
    @Column(name="claimid", nullable=false)
    public int getClaimid() {
        return this.claimid;
    }
    
    public void setClaimid(int claimid) {
        this.claimid = claimid;
    }
    
    @Column(name="sportype", nullable=false, length=20)
    public String getSportype() {
        return this.sportype;
    }
    
    public void setSportype(String sportype) {
        this.sportype = sportype;
    }
    
    @Column(name="visitid", nullable=false)
    public int getVisitid() {
        return this.visitid;
    }
    
    public void setVisitid(int visitid) {
        this.visitid = visitid;
    }
    
    @Column(name="patientid", nullable=false, length=100)
    public String getPatientid() {
        return this.patientid;
    }
    
    public void setPatientid(String patientid) {
        this.patientid = patientid;
    }
    
    @Column(name="status", nullable=false, length=100)
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    @Column(name="total_claim", precision=22, scale=0)
    public Double getTotalClaim() {
        return this.totalClaim;
    }
    
    public void setTotalClaim(Double totalClaim) {
        this.totalClaim = totalClaim;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="claim_date", nullable=false, length=10)
    public Date getClaimDate() {
        return this.claimDate;
    }
    
    public void setClaimDate(Date claimDate) {
        this.claimDate = claimDate;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="first_visit", nullable=false, length=10)
    public Date getFirstVisit() {
        return this.firstVisit;
    }
    
    public void setFirstVisit(Date firstVisit) {
        this.firstVisit = firstVisit;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="second_visit", length=10)
    public Date getSecondVisit() {
        return this.secondVisit;
    }
    
    public void setSecondVisit(Date secondVisit) {
        this.secondVisit = secondVisit;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="third_visit", length=10)
    public Date getThirdVisit() {
        return this.thirdVisit;
    }
    
    public void setThirdVisit(Date thirdVisit) {
        this.thirdVisit = thirdVisit;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="fourth_visit", length=10)
    public Date getFourthVisit() {
        return this.fourthVisit;
    }
    
    public void setFourthVisit(Date fourthVisit) {
        this.fourthVisit = fourthVisit;
    }
    
    @Column(name="second_visitid")
    public Integer getSecondVisitid() {
        return this.secondVisitid;
    }
    
    public void setSecondVisitid(Integer secondVisitid) {
        this.secondVisitid = secondVisitid;
    }
    
    @Column(name="third_visitid")
    public Integer getThirdVisitid() {
        return this.thirdVisitid;
    }
    
    public void setThirdVisitid(Integer thirdVisitid) {
        this.thirdVisitid = thirdVisitid;
    }
    
    @Column(name="fourth_visitid")
    public Integer getFourthVisitid() {
        return this.fourthVisitid;
    }
    
    public void setFourthVisitid(Integer fourthVisitid) {
        this.fourthVisitid = fourthVisitid;
    }
    
    @Column(name="patientage", nullable=false)
    public int getPatientage() {
        return this.patientage;
    }
    
    public void setPatientage(int patientage) {
        this.patientage = patientage;
    }
    
    @Column(name="badgeid", nullable=false, length=65535)
    public String getBadgeid() {
        return this.badgeid;
    }
    
    public void setBadgeid(String badgeid) {
        this.badgeid = badgeid;
    }
    
    @Column(name="return_amount", nullable=false, precision=22, scale=0)
    public double getReturnAmount() {
        return this.returnAmount;
    }
    
    public void setReturnAmount(double returnAmount) {
        this.returnAmount = returnAmount;
    }
    
    @Column(name="return_notes", nullable=false, length=65535)
    public String getReturnNotes() {
        return this.returnNotes;
    }
    
    public void setReturnNotes(String returnNotes) {
        this.returnNotes = returnNotes;
    }
    
    @Column(name="insuranceid", nullable=false, length=65535)
    public String getInsuranceid() {
        return this.insuranceid;
    }
    
    public void setInsuranceid(String insuranceid) {
        this.insuranceid = insuranceid;
    }
    
    @Column(name="accept_reject", nullable=false, length=65535)
    public String getAcceptReject() {
        return this.acceptReject;
    }
    
    public void setAcceptReject(String acceptReject) {
        this.acceptReject = acceptReject;
    }




}


