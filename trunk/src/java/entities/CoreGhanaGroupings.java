package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * CoreGhanaGroupings generated by hbm2java
 */
@Entity
@Table(name="core_ghana_groupings"
    ,catalog="extended"
)
public class CoreGhanaGroupings  implements java.io.Serializable {


     private Integer groupingid;
     private String coreGdrg;
     private String diagnosticGroup;
     private String description;

    public CoreGhanaGroupings() {
    }

    public CoreGhanaGroupings(String coreGdrg, String diagnosticGroup, String description) {
       this.coreGdrg = coreGdrg;
       this.diagnosticGroup = diagnosticGroup;
       this.description = description;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="groupingid", unique=true, nullable=false)
    public Integer getGroupingid() {
        return this.groupingid;
    }
    
    public void setGroupingid(Integer groupingid) {
        this.groupingid = groupingid;
    }
    
    @Column(name="core_GDRG", nullable=false, length=10)
    public String getCoreGdrg() {
        return this.coreGdrg;
    }
    
    public void setCoreGdrg(String coreGdrg) {
        this.coreGdrg = coreGdrg;
    }
    
    @Column(name="diagnostic_group", nullable=false, length=10)
    public String getDiagnosticGroup() {
        return this.diagnosticGroup;
    }
    
    public void setDiagnosticGroup(String diagnosticGroup) {
        this.diagnosticGroup = diagnosticGroup;
    }
    
    @Column(name="description", nullable=false, length=65535)
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }




}


