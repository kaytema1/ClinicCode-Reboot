package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Specimen generated by hbm2java
 */
@Entity
@Table(name="specimen"
    ,catalog="extended"
)
public class Specimen  implements java.io.Serializable {


     private Integer specimenId;
     private String specimen;

    public Specimen() {
    }

    public Specimen(String specimen) {
       this.specimen = specimen;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="specimen_id", unique=true, nullable=false)
    public Integer getSpecimenId() {
        return this.specimenId;
    }
    
    public void setSpecimenId(Integer specimenId) {
        this.specimenId = specimenId;
    }
    
    @Column(name="specimen", nullable=false, length=65535)
    public String getSpecimen() {
        return this.specimen;
    }
    
    public void setSpecimen(String specimen) {
        this.specimen = specimen;
    }




}


