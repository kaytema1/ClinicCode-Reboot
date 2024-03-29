package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * CompanyProfile generated by hbm2java
 */
@Entity
@Table(name="company_profile"
    ,catalog="extended"
)
public class CompanyProfile  implements java.io.Serializable {


     private String companyid;
     private String comapnyname;
     private String servicenumber;
     private String telephone;
     private String address;
     private String eclaimnumber;
     private String clinicFolderCode;
     private String diagnosticsFolderCode;
     private int clinicFolderStartNumber;
     private int diagnosticFolderStartNumber;
     private int clinicFolderStartActive;
     private int labFolderStartActive;
     private boolean labReportHeaderActive;
     private boolean labReportFooterActive;

    public CompanyProfile() {
    }

    public CompanyProfile(String companyid, String comapnyname, String servicenumber, String telephone, String address, String eclaimnumber, String clinicFolderCode, String diagnosticsFolderCode, int clinicFolderStartNumber, int diagnosticFolderStartNumber, int clinicFolderStartActive, int labFolderStartActive, boolean labReportHeaderActive, boolean labReportFooterActive) {
       this.companyid = companyid;
       this.comapnyname = comapnyname;
       this.servicenumber = servicenumber;
       this.telephone = telephone;
       this.address = address;
       this.eclaimnumber = eclaimnumber;
       this.clinicFolderCode = clinicFolderCode;
       this.diagnosticsFolderCode = diagnosticsFolderCode;
       this.clinicFolderStartNumber = clinicFolderStartNumber;
       this.diagnosticFolderStartNumber = diagnosticFolderStartNumber;
       this.clinicFolderStartActive = clinicFolderStartActive;
       this.labFolderStartActive = labFolderStartActive;
       this.labReportHeaderActive = labReportHeaderActive;
       this.labReportFooterActive = labReportFooterActive;
    }
   
     @Id 
    
    @Column(name="companyid", unique=true, nullable=false, length=200)
    public String getCompanyid() {
        return this.companyid;
    }
    
    public void setCompanyid(String companyid) {
        this.companyid = companyid;
    }
    
    @Column(name="comapnyname", nullable=false, length=65535)
    public String getComapnyname() {
        return this.comapnyname;
    }
    
    public void setComapnyname(String comapnyname) {
        this.comapnyname = comapnyname;
    }
    
    @Column(name="servicenumber", nullable=false, length=65535)
    public String getServicenumber() {
        return this.servicenumber;
    }
    
    public void setServicenumber(String servicenumber) {
        this.servicenumber = servicenumber;
    }
    
    @Column(name="telephone", nullable=false, length=65535)
    public String getTelephone() {
        return this.telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    @Column(name="address", nullable=false, length=65535)
    public String getAddress() {
        return this.address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    @Column(name="eclaimnumber", nullable=false, length=65535)
    public String getEclaimnumber() {
        return this.eclaimnumber;
    }
    
    public void setEclaimnumber(String eclaimnumber) {
        this.eclaimnumber = eclaimnumber;
    }
    
    @Column(name="clinic_folder_code", nullable=false, length=10)
    public String getClinicFolderCode() {
        return this.clinicFolderCode;
    }
    
    public void setClinicFolderCode(String clinicFolderCode) {
        this.clinicFolderCode = clinicFolderCode;
    }
    
    @Column(name="diagnostics_folder_code", nullable=false, length=10)
    public String getDiagnosticsFolderCode() {
        return this.diagnosticsFolderCode;
    }
    
    public void setDiagnosticsFolderCode(String diagnosticsFolderCode) {
        this.diagnosticsFolderCode = diagnosticsFolderCode;
    }
    
    @Column(name="clinic_folder_start_number", nullable=false)
    public int getClinicFolderStartNumber() {
        return this.clinicFolderStartNumber;
    }
    
    public void setClinicFolderStartNumber(int clinicFolderStartNumber) {
        this.clinicFolderStartNumber = clinicFolderStartNumber;
    }
    
    @Column(name="diagnostic_folder_start_number", nullable=false)
    public int getDiagnosticFolderStartNumber() {
        return this.diagnosticFolderStartNumber;
    }
    
    public void setDiagnosticFolderStartNumber(int diagnosticFolderStartNumber) {
        this.diagnosticFolderStartNumber = diagnosticFolderStartNumber;
    }
    
    @Column(name="clinic_folder_start_active", nullable=false)
    public int getClinicFolderStartActive() {
        return this.clinicFolderStartActive;
    }
    
    public void setClinicFolderStartActive(int clinicFolderStartActive) {
        this.clinicFolderStartActive = clinicFolderStartActive;
    }
    
    @Column(name="lab_folder_start_active", nullable=false)
    public int getLabFolderStartActive() {
        return this.labFolderStartActive;
    }
    
    public void setLabFolderStartActive(int labFolderStartActive) {
        this.labFolderStartActive = labFolderStartActive;
    }
    
    @Column(name="lab_report_header_active", nullable=false)
    public boolean isLabReportHeaderActive() {
        return this.labReportHeaderActive;
    }
    
    public void setLabReportHeaderActive(boolean labReportHeaderActive) {
        this.labReportHeaderActive = labReportHeaderActive;
    }
    
    @Column(name="lab_report_footer_active", nullable=false)
    public boolean isLabReportFooterActive() {
        return this.labReportFooterActive;
    }
    
    public void setLabReportFooterActive(boolean labReportFooterActive) {
        this.labReportFooterActive = labReportFooterActive;
    }




}


