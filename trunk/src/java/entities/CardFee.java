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
 * CardFee generated by hbm2java
 */
@Entity
@Table(name="card_fee"
    ,catalog="extended"
)
public class CardFee  implements java.io.Serializable {


     private Integer id;
     private double cardFee;
     private String userId;
     private Date dateAdded;
     private String status;

    public CardFee() {
    }

    public CardFee(double cardFee, String userId, Date dateAdded, String status) {
       this.cardFee = cardFee;
       this.userId = userId;
       this.dateAdded = dateAdded;
       this.status = status;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="card_fee", nullable=false, precision=22, scale=0)
    public double getCardFee() {
        return this.cardFee;
    }
    
    public void setCardFee(double cardFee) {
        this.cardFee = cardFee;
    }
    
    @Column(name="user_id", nullable=false, length=50)
    public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="date_added", nullable=false, length=19)
    public Date getDateAdded() {
        return this.dateAdded;
    }
    
    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }
    
    @Column(name="status", nullable=false, length=20)
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }




}


