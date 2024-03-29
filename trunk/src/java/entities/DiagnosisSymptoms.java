package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * DiagnosisSymptoms generated by hbm2java
 */
@Entity
@Table(name="diagnosis_symptoms"
    ,catalog="extended"
)
public class DiagnosisSymptoms  implements java.io.Serializable {


     private Integer id;
     private int diagnosisId;
     private int symptomsId;

    public DiagnosisSymptoms() {
    }

    public DiagnosisSymptoms(int diagnosisId, int symptomsId) {
       this.diagnosisId = diagnosisId;
       this.symptomsId = symptomsId;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="diagnosis_id", nullable=false)
    public int getDiagnosisId() {
        return this.diagnosisId;
    }
    
    public void setDiagnosisId(int diagnosisId) {
        this.diagnosisId = diagnosisId;
    }
    
    @Column(name="symptoms_id", nullable=false)
    public int getSymptomsId() {
        return this.symptomsId;
    }
    
    public void setSymptomsId(int symptomsId) {
        this.symptomsId = symptomsId;
    }




}


