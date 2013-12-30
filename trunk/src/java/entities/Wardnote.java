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
 * Wardnote generated by hbm2java
 */
@Entity
@Table(name="wardnote"
    ,catalog="extended"
)
public class Wardnote  implements java.io.Serializable {


     private Integer noteid;
     private int wardid;
     private String nurseid;
     private String note;
     private Date date;

    public Wardnote() {
    }

	
    public Wardnote(int wardid, String note, Date date) {
        this.wardid = wardid;
        this.note = note;
        this.date = date;
    }
    public Wardnote(int wardid, String nurseid, String note, Date date) {
       this.wardid = wardid;
       this.nurseid = nurseid;
       this.note = note;
       this.date = date;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="noteid", unique=true, nullable=false)
    public Integer getNoteid() {
        return this.noteid;
    }
    
    public void setNoteid(Integer noteid) {
        this.noteid = noteid;
    }
    
    @Column(name="wardid", nullable=false)
    public int getWardid() {
        return this.wardid;
    }
    
    public void setWardid(int wardid) {
        this.wardid = wardid;
    }
    
    @Column(name="nurseid")
    public String getNurseid() {
        return this.nurseid;
    }
    
    public void setNurseid(String nurseid) {
        this.nurseid = nurseid;
    }
    
    @Column(name="note", nullable=false, length=65535)
    public String getNote() {
        return this.note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="date", nullable=false, length=10)
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }




}


