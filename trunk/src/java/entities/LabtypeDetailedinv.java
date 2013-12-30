package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * LabtypeDetailedinv generated by hbm2java
 */
@Entity
@Table(name="labtype_detailedinv"
    ,catalog="extended"
)
public class LabtypeDetailedinv  implements java.io.Serializable {


     private Integer labtypeMaintestId;
     private int labtypeId;
     private int detailedInvId;

    public LabtypeDetailedinv() {
    }

    public LabtypeDetailedinv(int labtypeId, int detailedInvId) {
       this.labtypeId = labtypeId;
       this.detailedInvId = detailedInvId;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="labtype_maintest_id", unique=true, nullable=false)
    public Integer getLabtypeMaintestId() {
        return this.labtypeMaintestId;
    }
    
    public void setLabtypeMaintestId(Integer labtypeMaintestId) {
        this.labtypeMaintestId = labtypeMaintestId;
    }
    
    @Column(name="labtype_id", nullable=false)
    public int getLabtypeId() {
        return this.labtypeId;
    }
    
    public void setLabtypeId(int labtypeId) {
        this.labtypeId = labtypeId;
    }
    
    @Column(name="detailed_inv_id", nullable=false)
    public int getDetailedInvId() {
        return this.detailedInvId;
    }
    
    public void setDetailedInvId(int detailedInvId) {
        this.detailedInvId = detailedInvId;
    }




}


