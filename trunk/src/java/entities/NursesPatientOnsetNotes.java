package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * NursesPatientOnsetNotes generated by hbm2java
 */
@Entity
@Table(name="nurses_patient_onset_notes"
    ,catalog="extended"
)
public class NursesPatientOnsetNotes  implements java.io.Serializable {


     private Integer id;
     private String patientid;
     private int visitid;
     private String onsetNote;
     private String seenby;

    public NursesPatientOnsetNotes() {
    }

    public NursesPatientOnsetNotes(String patientid, int visitid, String onsetNote, String seenby) {
       this.patientid = patientid;
       this.visitid = visitid;
       this.onsetNote = onsetNote;
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
    
    @Column(name="onset_note", nullable=false, length=65535)
    public String getOnsetNote() {
        return this.onsetNote;
    }
    
    public void setOnsetNote(String onsetNote) {
        this.onsetNote = onsetNote;
    }
    
    @Column(name="seenby", nullable=false)
    public String getSeenby() {
        return this.seenby;
    }
    
    public void setSeenby(String seenby) {
        this.seenby = seenby;
    }




}

