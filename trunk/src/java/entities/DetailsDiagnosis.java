package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * DetailsDiagnosis generated by hbm2java
 */
@Entity
@Table(name="details_diagnosis"
    ,catalog="extended"
)
public class DetailsDiagnosis  implements java.io.Serializable {


     private Integer detailid;
     private String diagnosticGroup;
     private String gdrg;
     private String icd10;
     private String description;

    public DetailsDiagnosis() {
    }

    public DetailsDiagnosis(String diagnosticGroup, String gdrg, String icd10, String description) {
       this.diagnosticGroup = diagnosticGroup;
       this.gdrg = gdrg;
       this.icd10 = icd10;
       this.description = description;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="detailid", unique=true, nullable=false)
    public Integer getDetailid() {
        return this.detailid;
    }
    
    public void setDetailid(Integer detailid) {
        this.detailid = detailid;
    }
    
    @Column(name="diagnostic_group", nullable=false, length=10)
    public String getDiagnosticGroup() {
        return this.diagnosticGroup;
    }
    
    public void setDiagnosticGroup(String diagnosticGroup) {
        this.diagnosticGroup = diagnosticGroup;
    }
    
    @Column(name="gdrg", nullable=false, length=10)
    public String getGdrg() {
        return this.gdrg;
    }
    
    public void setGdrg(String gdrg) {
        this.gdrg = gdrg;
    }
    
    @Column(name="icd10", nullable=false, length=10)
    public String getIcd10() {
        return this.icd10;
    }
    
    public void setIcd10(String icd10) {
        this.icd10 = icd10;
    }
    
    @Column(name="description", nullable=false, length=65535)
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }




}


