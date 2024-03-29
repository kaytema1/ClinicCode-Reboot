package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Symptoms generated by hbm2java
 */
@Entity
@Table(name="symptoms"
    ,catalog="extended"
)
public class Symptoms  implements java.io.Serializable {


     private Integer symptomid;
     private String symptomname;

    public Symptoms() {
    }

    public Symptoms(String symptomname) {
       this.symptomname = symptomname;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="symptomid", unique=true, nullable=false)
    public Integer getSymptomid() {
        return this.symptomid;
    }
    
    public void setSymptomid(Integer symptomid) {
        this.symptomid = symptomid;
    }
    
    @Column(name="symptomname", nullable=false)
    public String getSymptomname() {
        return this.symptomname;
    }
    
    public void setSymptomname(String symptomname) {
        this.symptomname = symptomname;
    }




}


