package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * PatientProcedureWalkins generated by hbm2java
 */
@Entity
@Table(name="patient_procedure_walkins"
    ,catalog="extended"
)
public class PatientProcedureWalkins  implements java.io.Serializable {


     private Integer id;
     private String orderid;
     private String procedureCode;
     private double procedurePrice;
     private String status;

    public PatientProcedureWalkins() {
    }

    public PatientProcedureWalkins(String orderid, String procedureCode, double procedurePrice, String status) {
       this.orderid = orderid;
       this.procedureCode = procedureCode;
       this.procedurePrice = procedurePrice;
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
    
    @Column(name="orderid", nullable=false)
    public String getOrderid() {
        return this.orderid;
    }
    
    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }
    
    @Column(name="procedure_code", nullable=false)
    public String getProcedureCode() {
        return this.procedureCode;
    }
    
    public void setProcedureCode(String procedureCode) {
        this.procedureCode = procedureCode;
    }
    
    @Column(name="procedure_price", nullable=false, precision=22, scale=0)
    public double getProcedurePrice() {
        return this.procedurePrice;
    }
    
    public void setProcedurePrice(double procedurePrice) {
        this.procedurePrice = procedurePrice;
    }
    
    @Column(name="status", nullable=false)
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }




}


