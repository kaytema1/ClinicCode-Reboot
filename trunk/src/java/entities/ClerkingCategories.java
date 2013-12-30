package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ClerkingCategories generated by hbm2java
 */
@Entity
@Table(name="clerking_categories"
    ,catalog="extended"
)
public class ClerkingCategories  implements java.io.Serializable {


     private Integer id;
     private String categoryName;
     private Boolean active;

    public ClerkingCategories() {
    }

	
    public ClerkingCategories(String categoryName) {
        this.categoryName = categoryName;
    }
    public ClerkingCategories(String categoryName, Boolean active) {
       this.categoryName = categoryName;
       this.active = active;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="category_name", nullable=false)
    public String getCategoryName() {
        return this.categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    @Column(name="active")
    public Boolean getActive() {
        return this.active;
    }
    
    public void setActive(Boolean active) {
        this.active = active;
    }




}


