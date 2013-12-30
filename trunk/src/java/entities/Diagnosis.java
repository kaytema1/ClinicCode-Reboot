package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Diagnosis generated by hbm2java
 */
@Entity
@Table(name="diagnosis"
    ,catalog="extended"
)
public class Diagnosis  implements java.io.Serializable {


     private Integer id;
     private String diagnosisCode;
     private String diagnosis;
     private String gdrg;

    public Diagnosis() {
    }

	
    public Diagnosis(String diagnosisCode, String diagnosis) {
        this.diagnosisCode = diagnosisCode;
        this.diagnosis = diagnosis;
    }
    public Diagnosis(String diagnosisCode, String diagnosis, String gdrg) {
       this.diagnosisCode = diagnosisCode;
       this.diagnosis = diagnosis;
       this.gdrg = gdrg;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="diagnosis_code", nullable=false, length=100)
    public String getDiagnosisCode() {
        return this.diagnosisCode;
    }
    
    public void setDiagnosisCode(String diagnosisCode) {
        this.diagnosisCode = diagnosisCode;
    }
    
    @Column(name="diagnosis", nullable=false, length=200)
    public String getDiagnosis() {
        return this.diagnosis;
    }
    
    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }
    
    @Column(name="gdrg", length=25)
    public String getGdrg() {
        return this.gdrg;
    }
    
    public void setGdrg(String gdrg) {
        this.gdrg = gdrg;
    }




}

