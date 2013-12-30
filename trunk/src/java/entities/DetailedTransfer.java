package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * DetailedTransfer generated by hbm2java
 */
@Entity
@Table(name="detailed_transfer"
    ,catalog="extended"
)
public class DetailedTransfer  implements java.io.Serializable {


     private Integer detailedId;
     private String itemBatch;
     private int quantityOrderd;
     private int transferId;

    public DetailedTransfer() {
    }

    public DetailedTransfer(String itemBatch, int quantityOrderd, int transferId) {
       this.itemBatch = itemBatch;
       this.quantityOrderd = quantityOrderd;
       this.transferId = transferId;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="detailed_id", unique=true, nullable=false)
    public Integer getDetailedId() {
        return this.detailedId;
    }
    
    public void setDetailedId(Integer detailedId) {
        this.detailedId = detailedId;
    }
    
    @Column(name="item_batch", nullable=false)
    public String getItemBatch() {
        return this.itemBatch;
    }
    
    public void setItemBatch(String itemBatch) {
        this.itemBatch = itemBatch;
    }
    
    @Column(name="quantity_orderd", nullable=false)
    public int getQuantityOrderd() {
        return this.quantityOrderd;
    }
    
    public void setQuantityOrderd(int quantityOrderd) {
        this.quantityOrderd = quantityOrderd;
    }
    
    @Column(name="transfer_id", nullable=false)
    public int getTransferId() {
        return this.transferId;
    }
    
    public void setTransferId(int transferId) {
        this.transferId = transferId;
    }




}

