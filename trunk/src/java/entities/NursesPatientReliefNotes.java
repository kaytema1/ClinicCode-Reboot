package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * NursesPatientReliefNotes generated by hbm2java
 */
@Entity
@Table(name="nurses_patient_relief_notes"
    ,catalog="extended"
)
public class NursesPatientReliefNotes  implements java.io.Serializable {


     private Integer id;
     private String reliefNote;
     private String patientid;
     private int visitid;
     private String seenby;

    public NursesPatientReliefNotes() {
    }

    public NursesPatientReliefNotes(String reliefNote, String patientid, int visitid, String seenby) {
       this.reliefNote = reliefNote;
       this.patientid = patientid;
       this.visitid = visitid;
       this.seenby = seenby;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="relief_note", nullable=false, length=65535)
    public String getReliefNote() {
        return this.reliefNote;
    }
    
    public void setReliefNote(String reliefNote) {
        this.reliefNote = reliefNote;
    }
    
    @Column(name="patientid", nullable=false, length=11)
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
    
    @Column(name="seenby", nullable=false)
    public String getSeenby() {
        return this.seenby;
    }
    
    public void setSeenby(String seenby) {
        this.seenby = seenby;
    }




}

