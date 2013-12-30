package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Dosagemonitor generated by hbm2java
 */
@Entity
@Table(name="dosagemonitor"
    ,catalog="extended"
)
public class Dosagemonitor  implements java.io.Serializable {


     private Integer id;
     private String treatmentId;
     private int visitid;
     private int quantity;
     private String nurse;
     private Date date;
     private String time;

    public Dosagemonitor() {
    }

    public Dosagemonitor(String treatmentId, int visitid, int quantity, String nurse, Date date, String time) {
       this.treatmentId = treatmentId;
       this.visitid = visitid;
       this.quantity = quantity;
       this.nurse = nurse;
       this.date = date;
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
    
    @Column(name="treatment_id", nullable=false, length=65535)
    public String getTreatmentId() {
        return this.treatmentId;
    }
    
    public void setTreatmentId(String treatmentId) {
        this.treatmentId = treatmentId;
    }
    
    @Column(name="visitid", nullable=false)
    public int getVisitid() {
        return this.visitid;
    }
    
    public void setVisitid(int visitid) {
        this.visitid = visitid;
    }
    
    @Column(name="quantity", nullable=false)
    public int getQuantity() {
        return this.quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    @Column(name="nurse", nullable=false, length=65535)
    public String getNurse() {
        return this.nurse;
    }
    
    public void setNurse(String nurse) {
        this.nurse = nurse;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="date", nullable=false, length=10)
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    @Column(name="time", nullable=false, length=65535)
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }




}


