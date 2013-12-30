package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ReliefOptions generated by hbm2java
 */
@Entity
@Table(name="relief_options"
    ,catalog="extended"
)
public class ReliefOptions  implements java.io.Serializable {


     private Integer reliefId;
     private String relief;

    public ReliefOptions() {
    }

    public ReliefOptions(String relief) {
       this.relief = relief;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="relief_id", unique=true, nullable=false)
    public Integer getReliefId() {
        return this.reliefId;
    }
    
    public void setReliefId(Integer reliefId) {
        this.reliefId = reliefId;
    }
    
    @Column(name="relief", nullable=false)
    public String getRelief() {
        return this.relief;
    }
    
    public void setRelief(String relief) {
        this.relief = relief;
    }




}

