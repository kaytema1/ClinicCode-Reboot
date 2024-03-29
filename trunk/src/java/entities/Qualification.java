package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Qualification generated by hbm2java
 */
@Entity
@Table(name="qualification"
    ,catalog="extended"
)
public class Qualification  implements java.io.Serializable {


     private Integer quid;
     private String qualification;
     private String startyear;
     private String endyear;
     private String institution;
     private String staffid;

    public Qualification() {
    }

	
    public Qualification(String qualification, String institution, String staffid) {
        this.qualification = qualification;
        this.institution = institution;
        this.staffid = staffid;
    }
    public Qualification(String qualification, String startyear, String endyear, String institution, String staffid) {
       this.qualification = qualification;
       this.startyear = startyear;
       this.endyear = endyear;
       this.institution = institution;
       this.staffid = staffid;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="quid", unique=true, nullable=false)
    public Integer getQuid() {
        return this.quid;
    }
    
    public void setQuid(Integer quid) {
        this.quid = quid;
    }
    
    @Column(name="qualification", nullable=false)
    public String getQualification() {
        return this.qualification;
    }
    
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
    
    @Column(name="startyear", length=4)
    public String getStartyear() {
        return this.startyear;
    }
    
    public void setStartyear(String startyear) {
        this.startyear = startyear;
    }
    
    @Column(name="endyear", length=4)
    public String getEndyear() {
        return this.endyear;
    }
    
    public void setEndyear(String endyear) {
        this.endyear = endyear;
    }
    
    @Column(name="institution", nullable=false)
    public String getInstitution() {
        return this.institution;
    }
    
    public void setInstitution(String institution) {
        this.institution = institution;
    }
    
    @Column(name="staffid", nullable=false)
    public String getStaffid() {
        return this.staffid;
    }
    
    public void setStaffid(String staffid) {
        this.staffid = staffid;
    }




}


