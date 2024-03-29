package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Procedure generated by hbm2java
 */
@Entity
@Table(name="procedure"
    ,catalog="extended"
)
public class Procedure  implements java.io.Serializable {


     private String code;
     private String description;
     private double price;

    public Procedure() {
    }

    public Procedure(String code, String description, double price) {
       this.code = code;
       this.description = description;
       this.price = price;
    }
   
     @Id 
    
    @Column(name="code", unique=true, nullable=false, length=100)
    public String getCode() {
        return this.code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    @Column(name="description", nullable=false, length=65535)
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Column(name="price", nullable=false, precision=22, scale=0)
    public double getPrice() {
        return this.price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }




}


