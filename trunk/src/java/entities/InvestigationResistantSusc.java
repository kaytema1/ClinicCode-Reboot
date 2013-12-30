package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * InvestigationResistantSusc generated by hbm2java
 */
@Entity
@Table(name="investigation_resistant_susc"
    ,catalog="extended"
)
public class InvestigationResistantSusc  implements java.io.Serializable {


     private Integer id;
     private int ptreatmentId;
     private int susceptibleTo;
     private int resistantTo;

    public InvestigationResistantSusc() {
    }

    public InvestigationResistantSusc(int ptreatmentId, int susceptibleTo, int resistantTo) {
       this.ptreatmentId = ptreatmentId;
       this.susceptibleTo = susceptibleTo;
       this.resistantTo = resistantTo;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="ptreatment_id", nullable=false)
    public int getPtreatmentId() {
        return this.ptreatmentId;
    }
    
    public void setPtreatmentId(int ptreatmentId) {
        this.ptreatmentId = ptreatmentId;
    }
    
    @Column(name="susceptible_to", nullable=false)
    public int getSusceptibleTo() {
        return this.susceptibleTo;
    }
    
    public void setSusceptibleTo(int susceptibleTo) {
        this.susceptibleTo = susceptibleTo;
    }
    
    @Column(name="resistant_to", nullable=false)
    public int getResistantTo() {
        return this.resistantTo;
    }
    
    public void setResistantTo(int resistantTo) {
        this.resistantTo = resistantTo;
    }




}


