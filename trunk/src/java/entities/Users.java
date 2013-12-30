package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Users generated by hbm2java
 */
@Entity
@Table(name="users"
    ,catalog="extended"
)
public class Users  implements java.io.Serializable {


     private String username;
     private String password;
     private String staffid;
     private boolean temporal;

    public Users() {
    }

    public Users(String username, String password, String staffid, boolean temporal) {
       this.username = username;
       this.password = password;
       this.staffid = staffid;
       this.temporal = temporal;
    }
   
     @Id 
    
    @Column(name="username", unique=true, nullable=false, length=100)
    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    @Column(name="password", nullable=false, length=512)
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Column(name="staffid", nullable=false, length=100)
    public String getStaffid() {
        return this.staffid;
    }
    
    public void setStaffid(String staffid) {
        this.staffid = staffid;
    }
    
    @Column(name="temporal", nullable=false)
    public boolean isTemporal() {
        return this.temporal;
    }
    
    public void setTemporal(boolean temporal) {
        this.temporal = temporal;
    }




}


