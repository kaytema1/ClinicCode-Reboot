package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Consultation generated by hbm2java
 */
@Entity
@Table(name="consultation"
    ,catalog="extended"
)
public class Consultation  implements java.io.Serializable {


     private Integer conid;
     private String contype;
     private double amount;

    public Consultation() {
    }

    public Consultation(String contype, double amount) {
       this.contype = contype;
       this.amount = amount;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="conid", unique=true, nullable=false)
    public Integer getConid() {
        return this.conid;
    }
    
    public void setConid(Integer conid) {
        this.conid = conid;
    }
    
    @Column(name="contype", nullable=false)
    public String getContype() {
        return this.contype;
    }
    
    public void setContype(String contype) {
        this.contype = contype;
    }
    
    @Column(name="amount", nullable=false, precision=22, scale=0)
    public double getAmount() {
        return this.amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }




}


