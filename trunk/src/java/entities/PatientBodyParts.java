package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * PatientBodyParts generated by hbm2java
 */
@Entity
@Table(name="patient_body_parts"
    ,catalog="extended"
)
public class PatientBodyParts  implements java.io.Serializable {


     private Integer id;
     private int bodyPartId;
     private String patientid;
     private int visitid;

    public PatientBodyParts() {
    }

    public PatientBodyParts(int bodyPartId, String patientid, int visitid) {
       this.bodyPartId = bodyPartId;
       this.patientid = patientid;
       this.visitid = visitid;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="body_part_id", nullable=false)
    public int getBodyPartId() {
        return this.bodyPartId;
    }
    
    public void setBodyPartId(int bodyPartId) {
        this.bodyPartId = bodyPartId;
    }
    
    @Column(name="patientid", nullable=false, length=10)
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




}


