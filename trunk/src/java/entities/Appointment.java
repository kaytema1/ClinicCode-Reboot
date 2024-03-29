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
 * Appointment generated by hbm2java
 */
@Entity
@Table(name="appointment"
    ,catalog="extended"
)
public class Appointment  implements java.io.Serializable {


     private Integer id;
     private String patientId;
     private String title;
     private String detail;
     private String start;
     private String end;
     private String allday;
     private String status;
     private Date timeHonoured;
     private Integer visitId;
     private String staffId;
     private Date timeAdded;
     private Date dateAdded;

    public Appointment() {
    }

	
    public Appointment(String title, String end, String status, String staffId, Date timeAdded, Date dateAdded) {
        this.title = title;
        this.end = end;
        this.status = status;
        this.staffId = staffId;
        this.timeAdded = timeAdded;
        this.dateAdded = dateAdded;
    }
    public Appointment(String patientId, String title, String detail, String start, String end, String allday, String status, Date timeHonoured, Integer visitId, String staffId, Date timeAdded, Date dateAdded) {
       this.patientId = patientId;
       this.title = title;
       this.detail = detail;
       this.start = start;
       this.end = end;
       this.allday = allday;
       this.status = status;
       this.timeHonoured = timeHonoured;
       this.visitId = visitId;
       this.staffId = staffId;
       this.timeAdded = timeAdded;
       this.dateAdded = dateAdded;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="patientId", length=30)
    public String getPatientId() {
        return this.patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    @Column(name="title", nullable=false, length=50)
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    @Column(name="detail", length=65535)
    public String getDetail() {
        return this.detail;
    }
    
    public void setDetail(String detail) {
        this.detail = detail;
    }
    
    @Column(name="start", length=65535)
    public String getStart() {
        return this.start;
    }
    
    public void setStart(String start) {
        this.start = start;
    }
    
    @Column(name="end", nullable=false, length=65535)
    public String getEnd() {
        return this.end;
    }
    
    public void setEnd(String end) {
        this.end = end;
    }
    
    @Column(name="allday", length=65535)
    public String getAllday() {
        return this.allday;
    }
    
    public void setAllday(String allday) {
        this.allday = allday;
    }
    
    @Column(name="status", nullable=false, length=15)
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="time_honoured", length=19)
    public Date getTimeHonoured() {
        return this.timeHonoured;
    }
    
    public void setTimeHonoured(Date timeHonoured) {
        this.timeHonoured = timeHonoured;
    }
    
    @Column(name="visit_id")
    public Integer getVisitId() {
        return this.visitId;
    }
    
    public void setVisitId(Integer visitId) {
        this.visitId = visitId;
    }
    
    @Column(name="staff_id", nullable=false, length=50)
    public String getStaffId() {
        return this.staffId;
    }
    
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="time_added", nullable=false, length=19)
    public Date getTimeAdded() {
        return this.timeAdded;
    }
    
    public void setTimeAdded(Date timeAdded) {
        this.timeAdded = timeAdded;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="date_added", nullable=false, length=10)
    public Date getDateAdded() {
        return this.dateAdded;
    }
    
    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }




}


