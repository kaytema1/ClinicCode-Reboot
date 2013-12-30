package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * AggrevationOptions generated by hbm2java
 */
@Entity
@Table(name="aggrevation_options"
    ,catalog="extended"
)
public class AggrevationOptions  implements java.io.Serializable {


     private Integer aggrevationId;
     private String aggrevation;

    public AggrevationOptions() {
    }

    public AggrevationOptions(String aggrevation) {
       this.aggrevation = aggrevation;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="aggrevation_id", unique=true, nullable=false)
    public Integer getAggrevationId() {
        return this.aggrevationId;
    }
    
    public void setAggrevationId(Integer aggrevationId) {
        this.aggrevationId = aggrevationId;
    }
    
    @Column(name="aggrevation", nullable=false)
    public String getAggrevation() {
        return this.aggrevation;
    }
    
    public void setAggrevation(String aggrevation) {
        this.aggrevation = aggrevation;
    }




}

