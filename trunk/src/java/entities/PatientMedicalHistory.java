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
 * PatientMedicalHistory generated by hbm2java
 */
@Entity
@Table(name="patient_medical_history"
    ,catalog="extended"
)
public class PatientMedicalHistory  implements java.io.Serializable {


     private Integer id;
     private int visitid;
     private String patientid;
     private int historyId;
     private Date date;

    public PatientMedicalHistory() {
    }

    public PatientMedicalHistory(int visitid, String patientid, int historyId, Date date) {
       this.visitid = visitid;
       this.patientid = patientid;
       this.historyId = historyId;
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
    
    @Column(name="visitid", nullable=false)
    public int getVisitid() {
        return this.visitid;
    }
    
    public void setVisitid(int visitid) {
        this.visitid = visitid;
    }
    
    @Column(name="patientid", nullable=false, length=11)
    public String getPatientid() {
        return this.patientid;
    }
    
    public void setPatientid(String patientid) {
        this.patientid = patientid;
    }
    
    @Column(name="history_id", nullable=false)
    public int getHistoryId() {
        return this.historyId;
    }
    
    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="date", nullable=false, length=19)
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }




}


