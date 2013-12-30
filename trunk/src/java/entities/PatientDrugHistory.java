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
 * PatientDrugHistory generated by hbm2java
 */
@Entity
@Table(name="patient_drug_history"
    ,catalog="extended"
)
public class PatientDrugHistory  implements java.io.Serializable {


     private Integer patientDrugHistoryId;
     private int visitId;
     private String patientId;
     private String drugTaken;
     private Date date;

    public PatientDrugHistory() {
    }

    public PatientDrugHistory(int visitId, String patientId, String drugTaken, Date date) {
       this.visitId = visitId;
       this.patientId = patientId;
       this.drugTaken = drugTaken;
       this.date = date;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="patient_drug_history_id", unique=true, nullable=false)
    public Integer getPatientDrugHistoryId() {
        return this.patientDrugHistoryId;
    }
    
    public void setPatientDrugHistoryId(Integer patientDrugHistoryId) {
        this.patientDrugHistoryId = patientDrugHistoryId;
    }
    
    @Column(name="visit_id", nullable=false)
    public int getVisitId() {
        return this.visitId;
    }
    
    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }
    
    @Column(name="patient_id", nullable=false, length=11)
    public String getPatientId() {
        return this.patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    @Column(name="drug_taken", nullable=false)
    public String getDrugTaken() {
        return this.drugTaken;
    }
    
    public void setDrugTaken(String drugTaken) {
        this.drugTaken = drugTaken;
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


