package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * RefRangeUni generated by hbm2java
 */
@Entity
@Table(name="ref_range_uni"
    ,catalog="extended"
)
public class RefRangeUni  implements java.io.Serializable {


     private Integer id;
     private int detailedinvRefrangeTypeId;
     private int selected;
     private String lowerRefRange;
     private String upperRefRange;
     private String paragraphic;

    public RefRangeUni() {
    }

	
    public RefRangeUni(int detailedinvRefrangeTypeId, int selected) {
        this.detailedinvRefrangeTypeId = detailedinvRefrangeTypeId;
        this.selected = selected;
    }
    public RefRangeUni(int detailedinvRefrangeTypeId, int selected, String lowerRefRange, String upperRefRange, String paragraphic) {
       this.detailedinvRefrangeTypeId = detailedinvRefrangeTypeId;
       this.selected = selected;
       this.lowerRefRange = lowerRefRange;
       this.upperRefRange = upperRefRange;
       this.paragraphic = paragraphic;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="detailedinv_refrange_type_id", nullable=false)
    public int getDetailedinvRefrangeTypeId() {
        return this.detailedinvRefrangeTypeId;
    }
    
    public void setDetailedinvRefrangeTypeId(int detailedinvRefrangeTypeId) {
        this.detailedinvRefrangeTypeId = detailedinvRefrangeTypeId;
    }
    
    @Column(name="selected", nullable=false)
    public int getSelected() {
        return this.selected;
    }
    
    public void setSelected(int selected) {
        this.selected = selected;
    }
    
    @Column(name="lower_ref_range", length=25)
    public String getLowerRefRange() {
        return this.lowerRefRange;
    }
    
    public void setLowerRefRange(String lowerRefRange) {
        this.lowerRefRange = lowerRefRange;
    }
    
    @Column(name="upper_ref_range", length=25)
    public String getUpperRefRange() {
        return this.upperRefRange;
    }
    
    public void setUpperRefRange(String upperRefRange) {
        this.upperRefRange = upperRefRange;
    }
    
    @Column(name="paragraphic", length=65535)
    public String getParagraphic() {
        return this.paragraphic;
    }
    
    public void setParagraphic(String paragraphic) {
        this.paragraphic = paragraphic;
    }




}

