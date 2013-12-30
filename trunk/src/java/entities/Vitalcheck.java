package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Vitalcheck generated by hbm2java
 */
@Entity
@Table(name="vitalcheck"
    ,catalog="extended"
)
public class Vitalcheck  implements java.io.Serializable {


     private Integer id;
     private int visitid;
     private double pressure;
     private double temperature;
     private double systolic;
     private double diatolic;
     private String time;

    public Vitalcheck() {
    }

    public Vitalcheck(int visitid, double pressure, double temperature, double systolic, double diatolic, String time) {
       this.visitid = visitid;
       this.pressure = pressure;
       this.temperature = temperature;
       this.systolic = systolic;
       this.diatolic = diatolic;
       this.time = time;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="visitid", nullable=false)
    public int getVisitid() {
        return this.visitid;
    }
    
    public void setVisitid(int visitid) {
        this.visitid = visitid;
    }
    
    @Column(name="pressure", nullable=false, precision=22, scale=0)
    public double getPressure() {
        return this.pressure;
    }
    
    public void setPressure(double pressure) {
        this.pressure = pressure;
    }
    
    @Column(name="temperature", nullable=false, precision=22, scale=0)
    public double getTemperature() {
        return this.temperature;
    }
    
    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }
    
    @Column(name="systolic", nullable=false, precision=22, scale=0)
    public double getSystolic() {
        return this.systolic;
    }
    
    public void setSystolic(double systolic) {
        this.systolic = systolic;
    }
    
    @Column(name="diatolic", nullable=false, precision=22, scale=0)
    public double getDiatolic() {
        return this.diatolic;
    }
    
    public void setDiatolic(double diatolic) {
        this.diatolic = diatolic;
    }
    
    @Column(name="time", nullable=false, length=65535)
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }




}


