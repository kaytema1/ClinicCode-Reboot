/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import helper.HibernateUtil;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author drac852002
 */
public class ExtendedHMSHelper extends HMSHelper {

    Session session = getSession();

    public ExtendedHMSHelper() {
        super();
    }

    public int compareTo(Patientinvestigation patientinvestigation1, Patientinvestigation patientinvestigation) {
        if (patientinvestigation1.getId() == patientinvestigation.getId()) {
            return 1;
        } else if (patientinvestigation1.getId() != patientinvestigation.getId()) {
            return 0;
        } else {
            return -1;
        }
    }

    public DiagnosticGroupings addGroup(String code, String description) {
        DiagnosticGroupings diagnosticGroupings = new DiagnosticGroupings();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        diagnosticGroupings.setCode(code);
        diagnosticGroupings.setDescriptio(description);
        session.save(diagnosticGroupings);
        session.getTransaction().commit();
        return diagnosticGroupings;
    }

    public ReferringDoctors addDoctor(String code, String description) {
        ReferringDoctors referringDoctors = new ReferringDoctors();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        referringDoctors.setNameName(code);
        referringDoctors.setFacility(description);
        session.save(referringDoctors);
        session.getTransaction().commit();
        return referringDoctors;
    }

    public Facility addFacility(String code, String description) {
        Facility facility = new Facility();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        facility.setDoctorIncharge(code);
        facility.setFacilityName(description);
        session.save(facility);
        session.getTransaction().commit();
        return facility;
    }

    public List listGroups() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DiagnosticGroupings").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDoctors() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ReferringDoctors").list();
        session.getTransaction().commit();
        return result;
    }

    public List listFacilities() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Facility").list();
        session.getTransaction().commit();
        return result;
    }

    public DiagnosticGroupings getGroups(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DiagnosticGroupings groupings = (DiagnosticGroupings) session.get(DiagnosticGroupings.class, code);
        session.getTransaction().commit();
        return groupings;
    }

    public DiagnosticGroupings updateGroupings(String code, String description) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DiagnosticGroupings groupings = (DiagnosticGroupings) session.get(DiagnosticGroupings.class, code);
        groupings.setDescriptio(description);
        session.update(groupings);
        session.getTransaction().commit();
        return groupings;
    }

    public ReferringDoctors updateDoctosInfo(int id, String code, String description) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ReferringDoctors referringDoctors = (ReferringDoctors) session.get(ReferringDoctors.class, id);
        referringDoctors.setNameName(code);
        referringDoctors.setFacility(description);
        session.update(referringDoctors);
        session.getTransaction().commit();
        return referringDoctors;
    }

    public Facility updateFacility(int id, String code, String description) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Facility facility = (Facility) session.get(Facility.class, id);
        facility.setDoctorIncharge(code);
        facility.setFacilityName(description);
        session.update(facility);
        session.getTransaction().commit();
        return facility;
    }

    public DiagnosticGroupings deleteGroup(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DiagnosticGroupings itm = (DiagnosticGroupings) session.get(DiagnosticGroupings.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public ReferringDoctors deleteDocotr(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ReferringDoctors itm = (ReferringDoctors) session.get(ReferringDoctors.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public Facility deleteFacility(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Facility itm = (Facility) session.get(Facility.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public CoreGhanaGroupings addCoreGroup(String gdrg, String description, String group) {
        CoreGhanaGroupings diagnosticGroupings = new CoreGhanaGroupings();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        diagnosticGroupings.setCoreGdrg(gdrg);
        diagnosticGroupings.setDescription(description);
        diagnosticGroupings.setDiagnosticGroup(group);
        session.save(diagnosticGroupings);
        session.getTransaction().commit();
        return diagnosticGroupings;
    }

    public PatientBills addPatientBills(int visitid, String bill_type, String patientid, double totalBills, double amountPaid, String status, int labDiscount, int pharmDiscount, int procedureDicount, int medicalDiscount, String staffid) {
        PatientBills patientBills = new PatientBills();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        patientBills.setVisitid(visitid);
        patientBills.setBillType(bill_type);
        patientBills.setPatientid(patientid);
        patientBills.setTotalBill(totalBills);
        patientBills.setAmountPaid(amountPaid);
        patientBills.setStatus(status);
        patientBills.setPharmorderDiscount(pharmDiscount);
        patientBills.setProcedureDiscount(procedureDicount);
        patientBills.setMedicalDiscount(medicalDiscount);
        patientBills.setLaborderDiscount(labDiscount);
        patientBills.setStaffId(staffid);
        Date now = new Date();
        patientBills.setBilldate(now);
        patientBills.setDate(now);
        session.save(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public InPatientBills addInPatientBills(int visitid, String patientid, double totalBill, double amountPaid, String status) {
        InPatientBills inPatientBills = new InPatientBills();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        inPatientBills.setVisitid(visitid);
        inPatientBills.setPatientid(patientid);
        inPatientBills.setTotalBill(totalBill);
        inPatientBills.setAmountPaid(amountPaid);
        inPatientBills.setStatus(status);
        session.save(inPatientBills);
        session.getTransaction().commit();
        return inPatientBills;
    }

    public List listCoreGroups() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CoreGhanaGroupings").list();
        session.getTransaction().commit();
        return result;
    }

    public List listCoreGroupsWithGdrg(String gdrg) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CoreGhanaGroupings where core_gdrg='" + gdrg + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLaborders(String gdrg) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CoreGhanaGroupings where core_gdrg='" + gdrg + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listCoreGroupsWithDiagnostic(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CoreGhanaGroupings where diagnostic_group='" + code + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public CoreGhanaGroupings getCoreGroups(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CoreGhanaGroupings groupings = (CoreGhanaGroupings) session.get(CoreGhanaGroupings.class, code);
        session.getTransaction().commit();
        return groupings;
    }

    public CoreGhanaGroupings updateGroupings(int code, String description, String gdrg, String group) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CoreGhanaGroupings groupings = (CoreGhanaGroupings) session.get(CoreGhanaGroupings.class, code);
        groupings.setCoreGdrg(gdrg);
        groupings.setDescription(description);
        groupings.setDiagnosticGroup(group);
        session.update(groupings);
        session.getTransaction().commit();
        return groupings;
    }

    public CoreGhanaGroupings deleteCoreGroup(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CoreGhanaGroupings itm = (CoreGhanaGroupings) session.get(CoreGhanaGroupings.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public DetailsDiagnosis addNHISDiagnosis(String gdrg, String description, String icd10, String group) {
        DetailsDiagnosis detailsDiagnosis = new DetailsDiagnosis();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        detailsDiagnosis.setIcd10(icd10);
        detailsDiagnosis.setDescription(description);
        detailsDiagnosis.setGdrg(gdrg);
        detailsDiagnosis.setDiagnosticGroup(group);
        session.save(detailsDiagnosis);
        session.getTransaction().commit();
        return detailsDiagnosis;
    }

    public List listNHISDiagnosis() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DetailsDiagnosis").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDiagnosisWithGdrg(String gdrg) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DetailsDiagnosis where gdrg='" + gdrg + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDiagnosisWithDiagnostic(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DetailsDiagnosis where diagnostic_group='" + code + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public DetailsDiagnosis getNHISdiagnosis(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DetailsDiagnosis groupings = (DetailsDiagnosis) session.get(DetailsDiagnosis.class, code);
        session.getTransaction().commit();
        return groupings;
    }

    public DetailsDiagnosis updateNHISDiagnosis(int code, String description, String gdrg, String icd10, String group) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DetailsDiagnosis groupings = (DetailsDiagnosis) session.get(DetailsDiagnosis.class, code);
        groupings.setGdrg(gdrg);
        groupings.setDescription(description);
        groupings.setDiagnosticGroup(group);
        groupings.setIcd10(icd10);
        session.update(groupings);
        session.getTransaction().commit();
        return groupings;
    }

    public DetailsDiagnosis deleteNHISDiagnosis(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DetailsDiagnosis itm = (DetailsDiagnosis) session.get(DetailsDiagnosis.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public TherapeuticGroup addTherapeuticGroup(String description) {
        TherapeuticGroup detailsDiagnosis = new TherapeuticGroup();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        detailsDiagnosis.setDescription(description);

        session.save(detailsDiagnosis);
        session.getTransaction().commit();
        return detailsDiagnosis;
    }

    public List listTherapeuticGroup() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from TherapeuticGroup").list();
        session.getTransaction().commit();
        return result;
    }

    public TherapeuticGroup getTherapeuticGroup(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TherapeuticGroup groupings = (TherapeuticGroup) session.get(TherapeuticGroup.class, code);
        session.getTransaction().commit();
        return groupings;
    }

    public TherapeuticGroup updateTherapeuticGroup(int code, String group) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TherapeuticGroup groupings = (TherapeuticGroup) session.get(TherapeuticGroup.class, code);
        groupings.setDescription(group);
        session.update(groupings);
        session.getTransaction().commit();
        return groupings;
    }

    public TherapeuticGroup deleteTherapeuticGroup(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TherapeuticGroup itm = (TherapeuticGroup) session.get(TherapeuticGroup.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public Nhistreatment addNhistreatment(String medicine, String unitprice, double price, String gdrg, int groupid, String diagnosticgroup) {
        Nhistreatment detailsDiagnosis = new Nhistreatment();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        detailsDiagnosis.setDiagnosticgroup(diagnosticgroup);
        detailsDiagnosis.setGdrg(gdrg);
        detailsDiagnosis.setMedicine(medicine);
        detailsDiagnosis.setPrice(price);
        detailsDiagnosis.setUnitPrice(unitprice);
        detailsDiagnosis.setTherapeuticGroup(groupid);
        session.save(detailsDiagnosis);
        session.getTransaction().commit();
        return detailsDiagnosis;
    }

    public List listNhistreatment() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhistreatment").list();
        session.getTransaction().commit();
        return result;
    }

    public List listNhistreatmentWhereTherapeuticGroup(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhistreatment where therapeutic_group=" + code).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNhistreatmentWhereDiagnosticGroup(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhistreatment where diagnosticgroup='" + code + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Nhistreatment getNhistreatment(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Nhistreatment groupings = (Nhistreatment) session.get(Nhistreatment.class, code);
        session.getTransaction().commit();
        return groupings;
    }

    public Nhistreatment updateNhistreatment(int code, String medicine, String unitprice, double price, String gdrg, int groupid, String diagnosticgroup) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Nhistreatment groupings = (Nhistreatment) session.get(Nhistreatment.class, code);
        groupings.setDiagnosticgroup(diagnosticgroup);
        groupings.setGdrg(gdrg);
        groupings.setMedicine(medicine);
        groupings.setPrice(price);
        groupings.setUnitPrice(unitprice);
        groupings.setTherapeuticGroup(groupid);
        session.update(groupings);
        session.getTransaction().commit();
        return groupings;
    }

    public Nhistreatment deleteNhistreatment(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Nhistreatment itm = (Nhistreatment) session.get(Nhistreatment.class, code);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public Nhisinvestigation addNHISInvestigation(String code, String name, double rate, String lowBound, String highBound, int labTypeId, int typeOfTestId, int groupUnderId, String units,
            String interpretation, String defaultValue, String rangeFrom,
            String rangeUpTo, String comments, String reportCollDays, Date reportCollTime,
            boolean resultOptions, String referenceType) throws Exception {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Nhisinvestigation detailedInv = new Nhisinvestigation();
        DateFormat formatter;
        Date date;
//        formatter = new SimpleDateFormat("yyyy-MM-dd");
//        date = (Date) formatter.parse(dob);
        detailedInv.setCode(code);
        detailedInv.setName(name);
        detailedInv.setRate(rate);
        detailedInv.setLowBound(lowBound);
        detailedInv.setHighBound(highBound);
        detailedInv.setLabTypeId(labTypeId);
        detailedInv.setTypeOfTestId(typeOfTestId);
        detailedInv.setGroupedUnderId(groupUnderId);
        detailedInv.setUnits(units);
        detailedInv.setInterpretation(interpretation);
        detailedInv.setDefaultValue(defaultValue);
        detailedInv.setRangeFrom(rangeFrom);
        detailedInv.setRangeUpTo(rangeUpTo);
        detailedInv.setComments(comments);
        detailedInv.setReportCollDays(reportCollDays);
        detailedInv.setReportCollTime(reportCollTime);
        detailedInv.setResultOptions(resultOptions);
        detailedInv.setRefRangeType(referenceType);
        session.save(detailedInv);
        session.getTransaction().commit();
        return detailedInv;
    }

    public List listNhisinvestigation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhisinvestigation").list();
        session.getTransaction().commit();
        return result;
    }

    public Nhisinvestigation getNhisInvestigation(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Nhisinvestigation bed = (Nhisinvestigation) session.get(Nhisinvestigation.class, code);

        session.getTransaction().commit();
        return bed;
    }

    public Bed addBed(String description, String wardRoom, int wardid, int roomid ) {
        Bed bed = new Bed();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        bed.setDescription(description);
        bed.setWardOrRoom(wardRoom);
        bed.setOccuppied(Boolean.FALSE);
        bed.setWardid(wardid);
        bed.setRoomid(roomid);
        session.save(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listBed() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Bed").list();
        session.getTransaction().commit();
        return result;
    }
    
     public List listAvailableBed() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Bed where occuppied = 0").list();
        session.getTransaction().commit();
        return result;
    }
     
     
     public List listOccupiedBed() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Bed where occuppied = 1").list();
        session.getTransaction().commit();
        return result;
    }

    public List listBedByRoomid(int roomid) {
        
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Bed where roomid=" + roomid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listBedByWardid(int wardid) {
        
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Bed where wardid=" + wardid).list();
        session.getTransaction().commit();
        return result;
    }

    public Bed getBed(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Bed bed = (Bed) session.get(Bed.class, code);
        session.getTransaction().commit();
        return bed;
    }

    public Bed updateBed(int code, String group, String wardroom, int wardid, int roomid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Bed bed = (Bed) session.get(Bed.class, code);
        bed.setDescription(group);
        bed.setWardOrRoom(wardroom);
        bed.setWardid(wardid);
        bed.setRoomid(roomid);
        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Bed updateBedStatus(int code, Boolean bool) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Bed bed = (Bed) session.get(Bed.class, code);
        bed.setOccuppied(bool);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Bed deleteBed(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Bed bed = (Bed) session.get(Bed.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Room addRoom(String description, int ward, double cost) {
        Room room = new Room();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        room.setDescription(description);
        room.setCost(cost);
        room.setWardId(ward);

        session.save(room);
        session.getTransaction().commit();
        return room;
    }

    public List listRoom() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Room").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientBills() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBills").list();
        session.getTransaction().commit();
        return result;
    }

    public List listInPatientBills() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InPatientBills").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDebtors() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBills where status='Outstanding'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listInDebtors() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InPatientBills Where status='Debt'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listWardRoom(int wardid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Room where ward_id=" + wardid).list();
        session.getTransaction().commit();
        return result;
    }

    public Room getRoom(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Room room = (Room) session.get(Room.class, code);
        session.getTransaction().commit();
        return room;
    }

    public PatientBills getPatientBill(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        session.getTransaction().commit();
        return patientBills;
    }

    public InPatientBills getInPatientBill(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InPatientBills inPatientBills = (InPatientBills) session.get(InPatientBills.class, code);
        session.getTransaction().commit();
        return inPatientBills;
    }

    public Room updateRoom(int code, String description, int wardroom, double cost) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Room bed = (Room) session.get(Room.class, code);
        bed.setDescription(description);
        bed.setWardId(wardroom);
        bed.setCost(cost);
        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public PatientBills updatePatientBills(int code, double amounPaid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setAmountPaid(amounPaid);
        patientBills.setStatus(status);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }
    
    
    
    
    public PatientBills updatePatientBills(int code, double totalBill, double amounPaid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setTotalBill(totalBill);
        patientBills.setAmountPaid(amounPaid);
        patientBills.setStatus(status);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }
    
     public PatientBills updatePatientBills(int code, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setVisitid(visitid);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public InPatientBills updateInPatientBills(int code, double totalBill, double amounPaid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InPatientBills patientBills = (InPatientBills) session.get(InPatientBills.class, code);
        patientBills.setTotalBill(totalBill);
        patientBills.setAmountPaid(totalBill);
        patientBills.setStatus(status);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public PatientBills updatePatientBillsLabDiscount(int code, int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setLaborderDiscount(discountid);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public PatientBills updatePatientBillsMedicalDiscount(int code, int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setMedicalDiscount(discountid);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public PatientBills updatePatientBillsProcedureDiscount(int code, int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setProcedureDiscount(discountid);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public PatientBills updatePatientBillsPharmDiscount(int code, int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBills patientBills = (PatientBills) session.get(PatientBills.class, code);
        patientBills.setPharmorderDiscount(discountid);
        session.update(patientBills);
        session.getTransaction().commit();
        return patientBills;
    }

    public Room updateNumberofRoomBed(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Room bed = (Room) session.get(Room.class, code);
        bed.setNumberOfBeds(bed.getNumberOfBeds() + 1);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Room updateRoomStatus(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Room bed = (Room) session.get(Room.class, code);
        bed.setStatus(bed.getStatus() + 1);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Room updateRoomStatusDed(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Room bed = (Room) session.get(Room.class, code);
        bed.setStatus(bed.getStatus() - 1);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Room deleteRoom(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Room bed = (Room) session.get(Room.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Investigation deleteInvestigation(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Investigation investigation = (Investigation) session.get(Investigation.class, code);
        session.delete(investigation);
        session.getTransaction().commit();
        return investigation;
    }

    public Investigation deactivateInvestigation(int code, int active) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Investigation investigation = (Investigation) session.get(Investigation.class, code);
        investigation.setActive(active);
        session.update(investigation);
        session.getTransaction().commit();
        return investigation;
    }

    public int countDaysBetween(Date start, Date end) {
        final int MILLISECONDS_IN_DAY = 1000 * 60 * 60 * 24;


        if (end.before(start)) {

            throw new IllegalArgumentException("The end date must be later than the start date");

        }
        Calendar startCal = GregorianCalendar.getInstance();

        startCal.setTime(start);

        startCal.set(Calendar.HOUR_OF_DAY, 0);

        startCal.set(Calendar.MINUTE, 0);

        startCal.set(Calendar.SECOND, 0);

        int startTime = (int) startCal.getTimeInMillis();

        Calendar endCal = GregorianCalendar.getInstance();

        endCal.setTime(end);

        endCal.set(Calendar.HOUR_OF_DAY, 0);

        endCal.set(Calendar.MINUTE, 0);

        endCal.set(Calendar.SECOND, 0);

        int endTime = (int) endCal.getTimeInMillis();

        return (endTime - startTime) / MILLISECONDS_IN_DAY;

    }

    public int getAge(Date birthday) {
        GregorianCalendar today = new GregorianCalendar();
        GregorianCalendar bday = new GregorianCalendar();
        GregorianCalendar bdayThisYear = new GregorianCalendar();

        bday.setTime(birthday);
        bdayThisYear.setTime(birthday);
        bdayThisYear.set(Calendar.YEAR, today.get(Calendar.YEAR));

        int age = today.get(Calendar.YEAR) - bday.get(Calendar.YEAR);

        if (today.getTimeInMillis() < bdayThisYear.getTimeInMillis()) {
            age--;
        }

        return age;
    }

    public Claimtable addClaim(String type, int claimid, int visitid, String patientid, String status, int age, String insuranceid) {
        Claimtable claimtable = new Claimtable();
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        claimtable.setClaimid(claimid);
        claimtable.setClaimDate(new Date());
        claimtable.setFirstVisit(new Date());
        claimtable.setFourthVisit(null);
        claimtable.setPatientage(age);
        claimtable.setPatientid(patientid);
        claimtable.setSecondVisit(null);
        claimtable.setSportype(type);
        claimtable.setStatus(status);
        claimtable.setThirdVisit(null);
        claimtable.setTotalClaim(0.0);
        claimtable.setVisitid(visitid);
        claimtable.setFourthVisitid(0);
        claimtable.setThirdVisitid(0);
        claimtable.setSecondVisitid(0);
        claimtable.setBadgeid("");
        claimtable.setReturnNotes("");
        claimtable.setReturnAmount(0.0);
        claimtable.setAcceptReject("");
        claimtable.setInsuranceid(insuranceid);
        session.save(claimtable);
        session.getTransaction().commit();
        return claimtable;

    }

    public Claimtable getClaim(int tableid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable room = (Claimtable) session.get(Claimtable.class, tableid);
        session.getTransaction().commit();
        return room;

    }

    public List listClaims() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClaimsWithType(String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable where sportype='" + type + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClaimsWithPatient(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable where patientid=" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClaimsOnDate(String date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable where claimdate=" + date + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClaimsWithVisitId(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listClaimsWhereStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable where status='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClaimsFromTo(String fromdate, String todate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Claimtable where claimdate between '" + fromdate + "' and '" + todate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Claimtable updateClaim(int claimid, double totalclaim) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        bed.setTotalClaim(totalclaim);
        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaimBadge(int claimid, String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        bed.setBadgeid(type + "_" + formate.format(date));

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaimNote(int claimid, String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        bed.setReturnNotes(type);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaimStatus(int claimid, String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        bed.setStatus(type);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaimReturnStatus(int claimid, String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        bed.setAcceptReject(type);

        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaim2ndVisit(int claimid, Date date, int _2visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        bed.setSecondVisit(date);
        bed.setSecondVisitid(_2visitid);
        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaim3rdVisit(int claimid, Date date, int _3visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        bed.setThirdVisit(date);
        bed.setThirdVisitid(_3visitid);
        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable updateClaim4thVisit(int claimid, Date date, int _4visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        bed.setFourthVisit(date);
        bed.setFourthVisitid(_4visitid);
        session.update(bed);
        session.getTransaction().commit();
        return bed;
    }

    public Claimtable deleteClaim(int claimid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Claimtable bed = (Claimtable) session.get(Claimtable.class, claimid);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public LabPatient addNewLabPatient(String patientid, String fname, String lname, String midname, String gender, String Address, String employer, String dob, String contact, String emergencyperson, String emergencycontact, String email, String country, String city, String maritalstatus, String imglocation, String folderNumber) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabPatient patient = new LabPatient();
        DateFormat formatter, formatter1;
        formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        formatter = new SimpleDateFormat("yyyy-MM-dd");

        Date date, date1;
        date1 = new Date();
        date = (Date) formatter.parse(dob);
        String strDate = formatter1.format(date1);
        date1 = formatter1.parse(strDate);

        patient.setFname(fname);
        patient.setLname(lname);
        patient.setPatientid(patientid);
        patient.setAddress(Address);
        patient.setContact(contact);
        patient.setDateofbirth(date);
        patient.setEmail(email);
        patient.setEmployer(employer);
        patient.setEmergencyperson(emergencyperson);
        patient.setGender(gender);
        patient.setMidname(midname);
        patient.setEmergencycontact(emergencycontact);
        patient.setCountry(country);
        patient.setCity(city);
        patient.setMaritalstatus(maritalstatus);
        patient.setImglocation(imglocation);
        patient.setDateofregistration(date1);
        patient.setLastVisitId(0);
        patient.setFolderNumber(folderNumber);
        session.save(patient);

        session.getTransaction().commit();
        return patient;
    }

    public LabPatient updateLabPatient(String patientid, String fname, String lname, String midname, String gender, String Address, String employer, String dob, String contact, String emergencyperson, String emergencycontact, String email, String country, String city, String maritalstatus, String imglocation, String bearerlname, String beareronames, boolean dependent, String occupation) throws Exception {
        System.out.println("We are in the Method");

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabPatient patient = (LabPatient) session.get(LabPatient.class, patientid);

        System.out.println("Still in the Method 2");
        DateFormat formatter;
        Date date;
        formatter = new SimpleDateFormat("yyyy-MM-dd");
        date = (Date) formatter.parse(dob);
        patient.setFname(fname);
        patient.setLname(lname);
        //patient.setPatientid(patientid);
        patient.setAddress(Address);
        patient.setContact(contact);
        patient.setDateofbirth(date);
        patient.setEmail(email);
        patient.setEmployer(employer);
        patient.setEmergencyperson(emergencyperson);
        patient.setGender(gender);
        patient.setMidname(midname);
        patient.setEmergencycontact(emergencycontact);
        patient.setCountry(country);
        patient.setCity(city);
        patient.setMaritalstatus(maritalstatus);
        patient.setImglocation(imglocation);
        //patient.setDateofregistration(new Date());
        //patient.setLastVisitId(0);
        //patient.setBearerLastname(bearerlname);
        //patient.setBearerOthernames(beareronames);
        //patient.setDependent(dependent);
        //patient.setOccupation(occupation);
        System.out.println("The Whole Method Works");
        session.update(patient);
        session.getTransaction().commit();
        System.out.println("The Whole Method Works");
        return patient;
    }

    public List listLabPatients() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabPatient").list();
        session.getTransaction().commit();
        return result;
    }

    public LabPatient updateLabPatientDetails(LabPatient patient) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        //Wardnote wardnote = (Wardnote) session.get(Wardnote.class, noteid);
        //wardnote.setNote(note);

        session.update(patient);
        session.getTransaction().commit();
        return patient;
    }

    public LabPatient getLabPatientByID(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        LabPatient patient = (LabPatient) session.get(LabPatient.class, patientid);

        session.getTransaction().commit();
        return patient;
    }

    public CompanyProfile getProfile(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        CompanyProfile companyProfile = (CompanyProfile) session.get(CompanyProfile.class, id);

        session.getTransaction().commit();
        return companyProfile;
    }

    public CompanyProfile updateCompanyProfile(CompanyProfile profile) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        //Wardnote wardnote = (Wardnote) session.get(Wardnote.class, noteid);
        //wardnote.setNote(note);

        session.update(profile);
        session.getTransaction().commit();
        return profile;
    }

    public LabPatient deleteLabPatient(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        LabPatient patient = (LabPatient) session.get(LabPatient.class, id);
        session.delete(patient);
        session.getTransaction().commit();

        return patient;
    }

    public List getLabPatientByName(String fname) {
        //System.out.println("here" + fname);
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabPatient where fname like '%" + fname + "%' or lname like '%" + fname + "%'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listLabPatientByDob(String today) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabPatient where dateofbirth='" + today + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public String diagnosisToString(Patientdiagnosis patientdiagnosis, int claimid) {
        String diagnosis = "";
        diagnosis = "" + patientdiagnosis.getDiagnosisid() + "><" + getDiagnosis(patientdiagnosis.getDiagnosisid()).getDiagnosis() + "><" + claimid + "><" + patientdiagnosis.getDate();
        return diagnosis;
    }

    public String treatmentToString(Patienttreatment patienttreatment, int claimid) {
        String treatment = "";
        treatment = "" + patienttreatment.getTreatmentid() + "><" + claimid + "><" + patienttreatment.getQuantity() + "><" + patienttreatment.getPrice() + "><" + (patienttreatment.getPrice() * patienttreatment.getQuantity()) + "><" + getTreatment(patienttreatment.getId()).getTreatment() + "><" + patienttreatment.getPharmacyorder().getDate() + "><" + 0.0 + "><" + "";
        return treatment;
    }

    public String investigationToString(Patientinvestigation patientinvestigation, int claimid) {
        String investigation = "";
        investigation = "" + patientinvestigation.getInvestigationid() + "><" + claimid + "><" + patientinvestigation.getQuantity() + "><" + patientinvestigation.getPrice() + "><" + (patientinvestigation.getPrice() * patientinvestigation.getQuantity()) + "><" + getInvestigation(patientinvestigation.getInvestigationid()).getName() + "><" + patientinvestigation.getDate() + "><" + 0.0 + "><LAB";
        return investigation;
    }

    public String claimToString(Claimtable claimtable) {
        String claim = "";
        String dependentNum = getPatientByID(claimtable.getPatientid()).isDependent() ? sponsorshipDetails(claimtable.getPatientid()).getDependentnumber() : "";
        String dependentName = getPatientByID(claimtable.getPatientid()).isDependent() ? getPatientByID(claimtable.getPatientid()).getFname() + " " + getPatientByID(claimtable.getPatientid()).getMidname() + " " + getPatientByID(claimtable.getPatientid()).getLname() : "";
        String patientName = getPatientByID(claimtable.getPatientid()).isDependent() ? getPatientByID(claimtable.getPatientid()).getLname() + "><" + getPatientByID(claimtable.getPatientid()).getMidname() + "><" + getPatientByID(claimtable.getPatientid()).getFname() : getPatientByID(claimtable.getPatientid()).getBearerLastname() + "><" + "" + "><" + getPatientByID(claimtable.getPatientid()).getBearerOthernames();
        Patientconsultation list = (Patientconsultation) getPatientConsultationByVisitid(claimtable.getVisitid()).get(0);
        double pcon = getConsultationId(list.getTypeid()).getAmount();
        String clinician = getStafftableByid(getVisitById(claimtable.getVisitid()).getDoctor()).getLastname() + " " + getStafftableByid(getVisitById(claimtable.getVisitid()).getDoctor()).getOthername();

        claim = "" + claimtable.getClaimid() + "><" + sponsorshipDetails(claimtable.getPatientid()).getMembershipid() + "><" + patientName + "><"
                + getProfile("1").getEclaimnumber() + "><" + getPatientByID(claimtable.getPatientid()).getDateofbirth() + "><" + dependentNum + "><"
                + dependentName + "><" + getVisitById(claimtable.getVisitid()).getDate() + "><" + getVisitById(claimtable.getVisitid()).getDate() + "><"
                + claimtable.getTotalClaim() + ">< ><" + getVisitById(claimtable.getVisitid()).getAdmissiondate() + "><" + "" + "><" + getVisitById(claimtable.getVisitid()).getDischargedate() + "><"
                + claimtable.getStatus() + "><" + claimtable.getInsuranceid() + "><" + pcon + "><" + "" + "><" + clinician + "><" + getProfile("1").getTelephone() + "><" + getVisitById(claimtable.getVisitid()).getPatientstatus() + "><" + "" + "><" + "" + "><" + getPatientByID(claimtable.getPatientid()).getCompany() + "><" + getPatientByID(claimtable.getPatientid()).getGender();

        return claim;
    }

    public Pharmorder addPharmOrder(String orderid, String patientid, String fromdoc, Date orderdate, int visitid, String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder pharmorder = new Pharmorder();
        pharmorder.setAmoutpaid(0.0);
        pharmorder.setDispensed("Not Done");
        pharmorder.setDispenseddate(null);
        pharmorder.setFromdoc(fromdoc);
        pharmorder.setOrderid(orderid);
        pharmorder.setOutstanding(0.0);
        pharmorder.setPatientid(patientid);
        pharmorder.setVisitid(visitid);
        pharmorder.setOrderdate(orderdate);
        pharmorder.setDispensedBy("Non");
        pharmorder.setReceivedBy("Non");
        session.save(pharmorder);
        session.getTransaction().commit();
        return pharmorder;
    }

    public Pharmorder getPharmorder(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder companyProfile = (Pharmorder) session.get(Pharmorder.class, orderid);
        session.getTransaction().commit();
        return companyProfile;
    }

    public Pharmorder updateDispensed(String orderid, String dispensed) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder companyProfile = (Pharmorder) session.get(Pharmorder.class, orderid);
        companyProfile.setDispensed(dispensed);
        companyProfile.setDispenseddate(new Date());
        session.update(companyProfile);
        session.getTransaction().commit();
        return companyProfile;
    }

    public Pharmorder updateAmounts(String orderid, double amountpaid, double outstanding) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Pharmorder companyProfile = (Pharmorder) session.get(Pharmorder.class, orderid);
        companyProfile.setAmoutpaid(amountpaid);
        companyProfile.setOutstanding(outstanding);
        session.getTransaction().commit();
        return companyProfile;
    }

    public List listPharmorders() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Pharmorder").list();

        session.getTransaction().commit();
        return result;
    }

    public List listPharmordersByStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Pharmorder where dispensed='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }
    
    
   
    
    
    public List listPharmordersByStatusByPatient(String status, String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Pharmorder where dispensed='" + status + "' and patientid='"+ patientid +"'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listPatientTreatmentsByOrderid(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment where orderid='" + orderid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listPatientTreatmentsByStatus(String dispensed) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment where dispensed='" + dispensed + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listPatientBillByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBills where visitid=" + visitid).list();

        session.getTransaction().commit();
        return result;
    }
    
     public List listPatientBillByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBills where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }
    
    public List listUnPaidPatientBillByBillTypenStatus( String billtype,String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBills  where status='" + status+ "'" + " AND bill_type='" + billtype + "'").list();

        session.getTransaction().commit();
        return result;
    }
     
    
     public List listUnPaidPatientBillByPatientIDnBillType(String patientid, String billtype ) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBills  where patientid='" + patientid + "'" + " AND bill_type='" + billtype + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public Vitaltable addVitals(int vitalid, String patientid, double temperature, double weight, double height, double systolic, double diatolic, double pulse, String others) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitaltable vitaltable = new Vitaltable();
        vitaltable.setVitalid(vitalid);
        vitaltable.setPatientid(patientid);
        vitaltable.setDiatolic(diatolic);
        vitaltable.setSistolic(systolic);
        vitaltable.setHeight(height);
        vitaltable.setWeight(weight);
        vitaltable.setOtherSymptons(others);
        vitaltable.setPulse(pulse);
        vitaltable.setTemperature(temperature);
        vitaltable.setDate(new Date());

        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitaltable updateVital(int vitalid, String patientid, double temperature, double weight, double height, double systolic, double diatolic, double pulse, String others) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitaltable vitaltable = (Vitaltable) session.get(Vitaltable.class, vitalid);
        //Vitaltable vitaltable = new Vitaltable(); 
        vitaltable.setPatientid(patientid);
        vitaltable.setDiatolic(diatolic);
        vitaltable.setSistolic(systolic);
        vitaltable.setHeight(height);
        vitaltable.setWeight(weight);
        vitaltable.setOtherSymptons(others);
        vitaltable.setPulse(pulse);
        vitaltable.setTemperature(temperature);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public List listVitals() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Vitabletable").list();

        session.getTransaction().commit();
        return result;
    }

    public Vitaltable getVitaltableByid(int vitalid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitaltable vitaltable = (Vitaltable) session.get(Vitaltable.class, vitalid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public List listVitaltableByPatientId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Vitaltable where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public Vitaltable deleteVital(int vitalid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitaltable itm = (Vitaltable) session.get(Vitaltable.class, vitalid);
        session.delete(itm);
        session.getTransaction().commit();
        return itm;
    }

    public LabStock addLabStock(int distId, String batchNumber,
            Date manuDate, Date exDate, int qty, double unitPrice, double totalPrice,
            String staffId, Timestamp dateAdded) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStock labStock = new LabStock();

        labStock.setLabStockItemDistributorId(distId);
        labStock.setBatchNumber(batchNumber);
        labStock.setManufactureDate(manuDate);
        labStock.setExpiryDate(exDate);
        labStock.setQty(qty);
        labStock.setUnitPrice(unitPrice);

        labStock.setTotalPrice(totalPrice);
        labStock.setStaffId(staffId);
        labStock.setDateAdded(dateAdded);
        session.save(labStock);

        session.getTransaction().commit();
        return labStock;
    }

    public LabStockItemDistributor updateLSID(int lsidId, double curLev, double totLev) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItemDistributor lsid = (LabStockItemDistributor) session.get(LabStockItemDistributor.class, lsidId);
        lsid.setCurrentLevel(curLev);
        lsid.setTotalLevel(totLev);
        session.update(lsid);
        session.getTransaction().commit();
        return lsid;
    }

    public Allergies addAllergiess(String name, String type, String reaction, String suggested) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Allergies vitaltable = new Allergies();
        vitaltable.setName(name);
        vitaltable.setType(type);
        vitaltable.setPossibleRxns(reaction);
        vitaltable.setSuggestedTreatment(suggested);

        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Allergies updateAllergies(int allergyid, String name, String type, String reactions, String suggested) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Allergies companyProfile = (Allergies) session.get(Allergies.class, allergyid);
        companyProfile.setName(name);
        companyProfile.setPossibleRxns(reactions);
        companyProfile.setSuggestedTreatment(suggested);
        companyProfile.setType(type);
        session.update(companyProfile);
        session.getTransaction().commit();
        return companyProfile;
    }

    public Allergies getAllergyByid(int vitalid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Allergies vitaltable = (Allergies) session.get(Allergies.class, vitalid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Allergies deleteAllergy(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Allergies bed = (Allergies) session.get(Allergies.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listAllergiess() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Allergies").list();

        session.getTransaction().commit();
        return result;
    }

    public List listAllergiessByType(String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Allergies where type='" + type + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public PatientAllergies addPatientAllergiess(String patientid, int allergy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientAllergies vitaltable = new PatientAllergies();
        vitaltable.setAllergyid(allergy);
        vitaltable.setPatientid(patientid);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientAllergies updatePatientAllergies(int allergyid, String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientAllergies companyProfile = (PatientAllergies) session.get(PatientAllergies.class, allergyid);
        companyProfile.setAllergyid(allergyid);
        companyProfile.setPatientid(patientid);
        session.update(companyProfile);
        session.getTransaction().commit();
        return companyProfile;
    }

    public PatientAllergies getPatientAllergyByid(int vitalid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientAllergies vitaltable = (PatientAllergies) session.get(PatientAllergies.class, vitalid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientAllergies deletePatientAllergy(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientAllergies bed = (PatientAllergies) session.get(PatientAllergies.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listPatientAllergiess() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientAllergies").list();

        session.getTransaction().commit();
        return result;
    }

    public List listAllergiessByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientAllergies where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public VisitSymptoms addVisitSymptoms(int visitid, String patientid, int symptomid, String note) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        VisitSymptoms vitaltable = new VisitSymptoms();
        vitaltable.setVisitid(visitid);
        vitaltable.setPatientid(patientid);
        vitaltable.setSymptomid(symptomid);
        vitaltable.setNote(note);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public VisitSymptoms updateVisitSymptoms(int id, int visitid, int symptomid, String patientid, String note) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        VisitSymptoms companyProfile = (VisitSymptoms) session.get(VisitSymptoms.class, id);
        companyProfile.setPatientid(patientid);
        companyProfile.setSymptomid(symptomid);
        companyProfile.setVisitid(visitid);
        companyProfile.setNote(note);
        session.update(companyProfile);
        session.getTransaction().commit();
        return companyProfile;
    }

    public VisitSymptoms getVisitSymptom(int vitalid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        VisitSymptoms vitaltable = (VisitSymptoms) session.get(VisitSymptoms.class, vitalid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public VisitSymptoms deleteVisitSymptoms(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        VisitSymptoms bed = (VisitSymptoms) session.get(VisitSymptoms.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listVisitSymptoms() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from VisitSymptoms").list();

        session.getTransaction().commit();
        return result;
    }

    public List listVisistSymptomsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from VisitSymptoms where visitid=" + visitid).list();

        session.getTransaction().commit();
        return result;
    }

    public List listVisitsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where visitid=" + visitid).list();

        session.getTransaction().commit();
        return result;
    }

    public List listVisistSymptomsByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from VisitSymptoms where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public DispensaryItems addStockItem(String code, String icd10, String description, int type, double markup, String unitofpricing, String group, int theragroup, int reorder, int emergency) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DispensaryItems vitaltable = new DispensaryItems();
/*        vitaltable.setCode(code);
        vitaltable.setIcd10(icd10);
        vitaltable.setDescription(description);
        vitaltable.setTypeId(type);
        vitaltable.setMarkUp(markup);
        vitaltable.setUnitOfPricing(unitofpricing);
        vitaltable.setGroupId(group);
        vitaltable.setTheragroup(theragroup);
        vitaltable.setReOrderLevel(reorder);
        vitaltable.setEmergencyLevel(emergency);
        vitaltable.setQuantity(0);*/
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public DispensaryItems updateStockItems(String code, String icd10, String description, int type, double markup, String unitofpricing, int quantity, int emergency, int reorder, int theragroup, String group) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DispensaryItems vitaltable = (DispensaryItems) session.get(DispensaryItems.class, code);
        /*vitaltable.setCode(code);
        vitaltable.setIcd10(icd10);
        vitaltable.setDescription(description);
        vitaltable.setTypeId(type);
        vitaltable.setMarkUp(markup);
        vitaltable.setUnitOfPricing(unitofpricing);
        vitaltable.setEmergencyLevel(emergency);
        vitaltable.setReOrderLevel(reorder);
        vitaltable.setTheragroup(theragroup);
        vitaltable.setGroupId(group);
        vitaltable.setQuantity(quantity);*/
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public DispensaryItems getStockItem(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DispensaryItems vitaltable = (DispensaryItems) session.get(DispensaryItems.class, code);
        session.getTransaction().commit();
        return vitaltable;
    }

    public DispensaryItems deleteStockItem(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DispensaryItems bed = (DispensaryItems) session.get(DispensaryItems.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listStockItems() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DispensaryItems").list();

        session.getTransaction().commit();
        return result;
    }

    public List listStockItemsBytype(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DispensaryItems where type=" + visitid).list();

        session.getTransaction().commit();
        return result;
    }

    /* public StockOrders addStockOrder(int supplier, String orderby) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     StockOrders vitaltable = new StockOrders();
     vitaltable.setCost(0.0);
     vitaltable.setDeliverer("");
     vitaltable.setDeliverydate(new Date());
     vitaltable.setOrderer(orderby);
     vitaltable.setSupplier(supplier);
     vitaltable.setStatus("Ordered");
     session.save(vitaltable);
     session.getTransaction().commit();
     return vitaltable;
     }

     public DispensaryItems updateStockItemQuantity(String code, int qty) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     DispensaryItems vitaltable = (DispensaryItems) session.get(DispensaryItems.class, code);
     vitaltable.setQunaity(qty);

     session.update(vitaltable);
     session.getTransaction().commit();
     return vitaltable;
     }

     public StockOrders updateStockOrder(int orderid, String orderby, int supplier, double cost, Date orderdate, String deliverer, Date deliverydate, String status) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     StockOrders vitaltable = (StockOrders) session.get(StockOrders.class, orderid);
     vitaltable.setCost(cost);
     vitaltable.setDeliverer(deliverer);
     vitaltable.setDeliverydate(deliverydate);
     vitaltable.setOrderdate(orderdate);
     vitaltable.setOrderer(orderby);
     vitaltable.setOrderid(orderid);
     vitaltable.setSupplier(supplier);
     vitaltable.setStatus(status);
     session.update(vitaltable);
     session.getTransaction().commit();
     return vitaltable;
     }

     public StockOrders getStockOrder(int orderid) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     StockOrders vitaltable = (StockOrders) session.get(StockOrders.class, orderid);
     session.getTransaction().commit();
     return vitaltable;
     }

     public StockOrders deleteStockOrder(int orderid) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     StockOrders bed = (StockOrders) session.get(StockOrders.class, orderid);
     session.delete(bed);
     session.getTransaction().commit();
     return bed;
     }

     public List listStockOrders() {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from StockOrders").list();

     session.getTransaction().commit();
     return result;
     }

     public List listOrderItemsOrderid(int orderid) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from Ordertimes where orderid=" + orderid).list();

     session.getTransaction().commit();
     return result;
     }

     public List listOrdersByStatus(String status) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from StockOrders where status='" + status + "'").list();

     session.getTransaction().commit();
     return result;
     }

     public List listOrdersSupplier(int supplier) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from StockOrders where supplier='" + supplier + "'").list();

     session.getTransaction().commit();
     return result;
     }

     public Orderitems addOrderItem(int orderid, String itemcode, int quantityOrdered, int quantitySupplied, String status) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     Orderitems vitaltable = new Orderitems();
     vitaltable.setItemcode(itemcode);
     vitaltable.setOrderid(orderid);
     vitaltable.setQuantityOrdered(quantityOrdered);
     vitaltable.setQuantitySupplied(quantitySupplied);
     vitaltable.setStatus(status);
     session.save(vitaltable);
     session.getTransaction().commit();
     return vitaltable;
     }

     public Orderitems updateOrderItems(int id, int orderid, String itemcode, int quantityOrdered, int quantitySupplied, String status) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     Orderitems vitaltable = (Orderitems) session.get(Orderitems.class, id);
     vitaltable.setItemcode(itemcode);
     vitaltable.setOrderid(orderid);
     vitaltable.setQuantityOrdered(quantityOrdered);
     vitaltable.setQuantitySupplied(quantitySupplied);
     vitaltable.setStatus(status);
     session.update(vitaltable);
     session.getTransaction().commit();
     return vitaltable;
     }

     public Orderitems getOrderItem(int id) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     Orderitems vitaltable = (Orderitems) session.get(Orderitems.class, id);
     session.getTransaction().commit();
     return vitaltable;
     }

     public Orderitems deleteOrderItem(int id) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     Orderitems bed = (Orderitems) session.get(Orderitems.class, id);
     session.delete(bed);
     session.getTransaction().commit();
     return bed;
     }

     public List listOrderitems() {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from Orderitems").list();

     session.getTransaction().commit();
     return result;
     }

     public List listOrderItemsBystatus(String status) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from Orderitems where status='" + status + "'").list();

     session.getTransaction().commit();
     return result;
     }
     */
    public ClinicInventoryRequests addRequisitions(String itemcode, String orderer, String unit, int quantity) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = new ClinicInventoryRequests();
        vitaltable.setDeliverer("");
        vitaltable.setDeliverydate(null);
        vitaltable.setItemcode(itemcode);
        vitaltable.setOrderdate(new Date());
        vitaltable.setOrderer(orderer);
        vitaltable.setRequestedquantity(quantity);
        vitaltable.setDeliveredquantity(0);
        vitaltable.setStatus("Pending");
        vitaltable.setUnit(unit);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests updateRequisition(int requisitionid, String itemcode, String orderer, Date orderdate, Date deliverydate, String deliverer, Date deliverytime, String status, String unit, int quantity) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        vitaltable.setDeliverer(deliverer);
        vitaltable.setDeliverydate(deliverydate);
        vitaltable.setItemcode(itemcode);
        vitaltable.setOrderdate(orderdate);
        vitaltable.setOrderer(orderer);
        vitaltable.setRequestedquantity(quantity);
        vitaltable.setStatus(status);
        vitaltable.setUnit(unit);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests updateRequisition(int requisitionid, String itemcode, int quantity) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        vitaltable.setItemcode(itemcode);
        vitaltable.setRequestedquantity(quantity);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests updateRequisition(int requisitionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        vitaltable.setStatus("Approved");
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests cancelRequisition(int requisitionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        vitaltable.setStatus("Cancelled");
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests cancelPost(int requisitionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        vitaltable.setStatus("Pending");
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests updateRequisition(int requisitionid, int quantity, String deliverer) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        vitaltable.setDeliveredquantity(quantity);
        vitaltable.setDeliverer(deliverer);
        vitaltable.setDeliverydate(new Date());
        vitaltable.setStatus("Delivered");
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests getRequisition(int requisitionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests vitaltable = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public ClinicInventoryRequests deleteRequisition(int requisitionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClinicInventoryRequests bed = (ClinicInventoryRequests) session.get(ClinicInventoryRequests.class, requisitionid);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listRequisitions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ClinicInventoryRequests").list();
        session.getTransaction().commit();
        return result;
    }

    public List listRequisitionByStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ClinicInventoryRequests where status='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listPatientVisitPharmorders(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Pharmorder where visitid=" + visitid).list();

        session.getTransaction().commit();
        return result;
    }

    public List listRequisitionByOrderer(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ClinicInventoryRequests where orderer='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listPatientPreviousTest(int investigationid, String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where investigationid = " + investigationid + " and patientid='" + patientid + "' ORDER BY date DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listRequisitionByDelivery(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ClinicInventoryRequests where deliverer='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public Supplier addSupplierProper(String name, String address, String telephone, String email) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Supplier vitaltable = new Supplier();
        vitaltable.setAddress(address);
        vitaltable.setEmail(email);
        vitaltable.setName(name);
        vitaltable.setTelephone(telephone);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Supplier updateSupplier(int supplier, String name, String address, String telephone, String email) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Supplier vitaltable = (Supplier) session.get(Supplier.class, supplier);
        vitaltable.setAddress(address);
        vitaltable.setEmail(email);
        vitaltable.setName(name);
        vitaltable.setTelephone(telephone);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Supplier getSupplier(int supplierid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Supplier vitaltable = (Supplier) session.get(Supplier.class, supplierid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public InventoryItems getItemTable(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InventoryItems vitaltable = (InventoryItems) session.get(InventoryItems.class, code);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Supplier deleteSupplierByid(int supplierid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Supplier bed = (Supplier) session.get(Supplier.class, supplierid);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listSuppliersProper() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Supplier").list();

        session.getTransaction().commit();
        return result;
    }

    public Manufacturer addManufacturer(String manufaturer, String telephone, String address, String email) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Manufacturer vitaltable = new Manufacturer();
        vitaltable.setAddress(address);
        vitaltable.setEmail(email);
        vitaltable.setManufaturer(manufaturer);
        vitaltable.setTelephone(telephone);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Manufacturer updateManufaturer(int manufacturerid, String manufaturer, String telephone, String address, String email) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Manufacturer vitaltable = (Manufacturer) session.get(Manufacturer.class, manufacturerid);
        vitaltable.setAddress(address);
        vitaltable.setEmail(email);
        vitaltable.setManufaturer(manufaturer);
        vitaltable.setTelephone(telephone);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Manufacturer getManufacturer(int manufacturerid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Manufacturer vitaltable = (Manufacturer) session.get(Manufacturer.class, manufacturerid);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Manufacturer deleteManufacturer(int manufacturerid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Manufacturer bed = (Manufacturer) session.get(Manufacturer.class, manufacturerid);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listManufacturer() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Manufacturer").list();

        session.getTransaction().commit();
        return result;
    }

    public List listStockItemsByManufacturer(int manufacturerid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where manufacturer=" + manufacturerid).list();

        session.getTransaction().commit();
        return result;
    }

    public List listStockItemsBySupplier(int supplierid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where supplier=" + supplierid).list();

        session.getTransaction().commit();
        return result;
    }

    public Procedure addProcedure(String code, String description, double price) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedure vitaltable = new Procedure();
        vitaltable.setCode(code);
        vitaltable.setDescription(description);
        vitaltable.setPrice(price);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Procedure updateProcedure(String code, String description, double price) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedure vitaltable = (Procedure) session.get(Procedure.class, code);
        vitaltable.setCode(code);
        vitaltable.setDescription(description);
        vitaltable.setPrice(price);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Procedure getProcedure(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedure vitaltable = (Procedure) session.get(Procedure.class, code);
        session.getTransaction().commit();
        return vitaltable;
    }
    
    
    public ProblemOptions getProblemOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ProblemOptions option = (ProblemOptions) session.get(ProblemOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
    
    
    public OnsetOptions getOnsetOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        OnsetOptions option = (OnsetOptions) session.get(OnsetOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
    
     public DurationOptions getDurationOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DurationOptions option = (DurationOptions) session.get(DurationOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
     
     
     public CharacteristicOptions getCharacteristicOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CharacteristicOptions option = (CharacteristicOptions) session.get(CharacteristicOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
     
     
     public BodyPartOptions getBodyPartOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        BodyPartOptions option = (BodyPartOptions) session.get(BodyPartOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
    
     
     public AggrevationOptions getAggrevationOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        AggrevationOptions option = (AggrevationOptions) session.get(AggrevationOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
     
     
     public ReliefOptions getReliefOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ReliefOptions option = (ReliefOptions) session.get(ReliefOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
     
     
     public TreatmentOptions getTreatmentOption(int option_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TreatmentOptions option = (TreatmentOptions) session.get(TreatmentOptions.class, option_id);
        session.getTransaction().commit();
        return option;
    }
    

    public Procedure deleteProcedure(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedure bed = (Procedure) session.get(Procedure.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listProcedure() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedure").list();

        session.getTransaction().commit();
        return result;
    }

    public PatientProcedure addPatientProcedure(String patientid, String code, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedure vitaltable = new PatientProcedure();
        vitaltable.setPatientid(patientid);
        vitaltable.setDate(new Date());
        vitaltable.setVisitid(visitid);
        vitaltable.setProcedureCode(code);
        vitaltable.setAmountpaid(0.0);
        vitaltable.setCopaid(Boolean.FALSE);
        vitaltable.setIsPrivate(Boolean.FALSE);
        vitaltable.setSecondaryAmount(0.0);
        vitaltable.setPrivateAmount(0.0);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientProcedureWalkins addPatientProcedureWalkins(String orderid, String code, double price) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedureWalkins patientwalkingprocedure = new PatientProcedureWalkins();
        patientwalkingprocedure.setOrderid(orderid);
        patientwalkingprocedure.setProcedureCode(code);
        patientwalkingprocedure.setProcedurePrice(price);
        patientwalkingprocedure.setStatus(code);

        session.save(patientwalkingprocedure);
        session.getTransaction().commit();
        return patientwalkingprocedure;
    }

    public PatientProcedure updatePatientProcedure(int id, String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedure vitaltable = (PatientProcedure) session.get(PatientProcedure.class, id);
        vitaltable.setProcedureCode(code);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientProcedure updatePatientProcedure(int id, boolean iscopaid, double secondaryamonut) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedure vitaltable = (PatientProcedure) session.get(PatientProcedure.class, id);
        vitaltable.setCopaid(iscopaid);
        vitaltable.setSecondaryAmount(secondaryamonut);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientProcedure updatePatientProcedure(int id, double privateamount, boolean isisprivate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedure vitaltable = (PatientProcedure) session.get(PatientProcedure.class, id);
        vitaltable.setIsPrivate(isisprivate);
        vitaltable.setPrivateAmount(privateamount);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientProcedure getPatientProcedure(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedure vitaltable = (PatientProcedure) session.get(PatientProcedure.class, id);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientProcedure deletePatientProcedure(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientProcedure bed = (PatientProcedure) session.get(PatientProcedure.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listPatientProcdure(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientProcedure where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listWalkinProcedures() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedureorderswalkin").list();

        session.getTransaction().commit();
        return result;
    }

    public List listWalkinProcedures(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedureorderswalkin where status='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }
    /*public List listPatientProcdureByVisit(int visitid) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from PatientProcedure where visitid='"+visitid).list();

     session.getTransaction().commit();
     return result;
     }*/

    public List listPatientProcdureByOrderid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientProcedure where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listWalkingProcedureByOrderid(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientProcedureWalkins where orderid='" + orderid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Procedureorders addProcedureOrder(int visitid, String patientid, double amount, String orderedby) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Procedureorders vitaltable = new Procedureorders();
        vitaltable.setPatientid(patientid);
        vitaltable.setTotal(0.0);
        vitaltable.setAmoutpaid(0.0);
        vitaltable.setVisitid(visitid);
        vitaltable.setStatus("Cashier");
        vitaltable.setOrderdate(new Date());
        vitaltable.setOrderedby(orderedby);
        vitaltable.setPerformedby("");
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Procedureorderswalkin addProcedureOrder(String orderid, String firstname, String lastname, String gender, String dob, double totalbill, String staff) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Procedureorderswalkin walkingOrder = new Procedureorderswalkin();
        walkingOrder.setFirstName(firstname);
        walkingOrder.setLastName(lastname);
        walkingOrder.setGender(gender);
        DateFormat formatter;
        Date date;
        formatter = new SimpleDateFormat("yyyy-MM-dd");
        date = (Date) formatter.parse(dob);
        walkingOrder.setDateOfBirth(date);
        walkingOrder.setTotal(totalbill);
        walkingOrder.setAmoutpaid(0.0);
        walkingOrder.setOrderid(orderid);
        walkingOrder.setStatus("Cashier");
        walkingOrder.setOrderdate(new Date());
        walkingOrder.setOrderedby(staff);
        walkingOrder.setPerformedby("");
        session.save(walkingOrder);
        session.getTransaction().commit();
        return walkingOrder;
    }

    public Procedureorders updateProcedureorders(int id, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders vitaltable = (Procedureorders) session.get(Procedureorders.class, id);
        vitaltable.setStatus(status);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }
    
    public Procedureorders updateProcedureorders(int id, String status, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders vitaltable = (Procedureorders) session.get(Procedureorders.class, id);
        vitaltable.setStatus(status);
        vitaltable.setPerformedby(staff);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }
    
    
    public Procedureorderswalkin updateProcedureorderswalkinStatus(String id, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorderswalkin vitaltable = (Procedureorderswalkin) session.get(Procedureorderswalkin.class, id);
        vitaltable.setStatus(status);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }
    
     public Procedureorderswalkin updateProcedureorderswalkinStatus(String id, String status,String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorderswalkin vitaltable = (Procedureorderswalkin) session.get(Procedureorderswalkin.class, id);
        vitaltable.setStatus(status);
        vitaltable.setPerformedby(staff);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }
    

    public Procedureorders updateProcedureordersTotal(int id, double amountpaid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders vitaltable = (Procedureorders) session.get(Procedureorders.class, id);
        vitaltable.setTotal(amountpaid);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Procedureorders updateProcedureorders(int id, double amountpaid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders vitaltable = (Procedureorders) session.get(Procedureorders.class, id);
        vitaltable.setAmoutpaid(amountpaid);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }
    
    public Procedureorders updateProcedurePerformer(int id, String performer) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders vitaltable = (Procedureorders) session.get(Procedureorders.class, id);
        vitaltable.setPerformedby(performer);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

        public Procedureorderswalkin updateProcedureorders(String orderid, double amountpaid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorderswalkin order = (Procedureorderswalkin) session.get(Procedureorderswalkin.class, orderid);
        order.setAmoutpaid(amountpaid);
        order.setStatus("Not Done");
        session.update(order);
        session.getTransaction().commit();
        return order;
    }

    public Procedureorderswalkin updateProcedurePerformer(String orderid, String performer) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorderswalkin order = (Procedureorderswalkin) session.get(Procedureorderswalkin.class, orderid);
        order.setPerformedby(performer);
        order.setStatus("Done");
        session.update(order);
        session.getTransaction().commit();
        return order;
    }

    public Procedureorders getProcedureorders(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders vitaltable = (Procedureorders) session.get(Procedureorders.class, id);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Procedureorderswalkin getProcedureorderswalking(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorderswalkin order = (Procedureorderswalkin) session.get(Procedureorderswalkin.class, orderid);
        session.getTransaction().commit();
        return order;
    }

    public Procedureorders deleteProcedureorders(int code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Procedureorders bed = (Procedureorders) session.get(Procedureorders.class, code);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listPatientProcedures(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedureorders where status='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }

     public List listPatientProceduresByStatusandPatient(String status,String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedureorders where status='" + status + "' and patientid='"+ patientid +"'").list();

        session.getTransaction().commit();
        return result;
    }
    public List listProcdureordersByPatient(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedureorders where status='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listProcdureordersByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Procedureorders where visitid=" + visitid).list();

        session.getTransaction().commit();
        return result;
    }

    public Vitalcheck addVitalCheck(int visitid, double temp, double pressure, double systolic, double diatolic) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = new Vitalcheck();
        vitaltable.setDiatolic(diatolic);
        vitaltable.setPressure(pressure);
        vitaltable.setSystolic(systolic);
        vitaltable.setTemperature(temp);
        vitaltable.setVisitid(visitid);

        Date date = new Date();
        //formatting time to have AM/PM text using 'a' format
        String strDateFormat = "HH:mm:ss a";
        SimpleDateFormat sdf = new SimpleDateFormat(strDateFormat);
        //String time = sdf+"";
        vitaltable.setTime(sdf.format(date));
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck updateVitalCheck(int id, int visitid, double temp, double pressure, double systolic, double diatolic) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        vitaltable.setDiatolic(diatolic);
        vitaltable.setPressure(pressure);
        vitaltable.setSystolic(systolic);
        vitaltable.setTemperature(temp);
        vitaltable.setVisitid(visitid);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck updateVitalCheckTemp(int id, double temp) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        vitaltable.setTemperature(temp);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck updateVitalCheckPress(int id, double pressure) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        vitaltable.setPressure(pressure);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck updateVitalCheckSystolic(int id, double systolic) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        vitaltable.setSystolic(systolic);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck updateVitalCheckDiatolic(int id, double diatolic) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        vitaltable.setDiatolic(diatolic);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck updateVitalCheck(int id, double temp) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        vitaltable.setTemperature(temp);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck getVitalCheck(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck vitaltable = (Vitalcheck) session.get(Vitalcheck.class, id);
        session.getTransaction().commit();
        return vitaltable;
    }

    public Vitalcheck deleteVitalCheck(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Vitalcheck bed = (Vitalcheck) session.get(Vitalcheck.class, id);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listVitalCheck() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Vitalcheck").list();
        session.getTransaction().commit();
        return result;
    }

    public List listVitalCheckByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Vitalcheck where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }
    
    
    
    public List listVitalTableVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Vitaltable where vitalid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public PatientBed addPatientBed(int visitid, String patientid, int bedid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBed vitaltable = new PatientBed();
        vitaltable.setBedid(bedid);
        vitaltable.setPatientid(patientid);
        vitaltable.setVisitid(visitid);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PostedItems addPostedItem(int requestedid, int quantity, String batchnumber) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PostedItems postedItems = new PostedItems();
        postedItems.setRequestid(requestedid);
        postedItems.setQunatity(quantity);
        postedItems.setBatchNumber(batchnumber);
        session.save(postedItems);
        session.getTransaction().commit();
        return postedItems;
    }

    public List listPostedItemsByRequestid(int requestid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PostedItems where requestid=" + requestid).list();
        session.getTransaction().commit();
        return result;
    }
    
    public List listPatientBedByBedId(int bedid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBed where bedid=" + bedid).list();
        session.getTransaction().commit();
        return result;
    }

    public PatientBed updatePatientBed(int visitid, int bedid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBed vitaltable = (PatientBed) session.get(PatientBed.class, visitid);
        vitaltable.setBedid(bedid);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientBed getPatientBed(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBed vitaltable = (PatientBed) session.get(PatientBed.class, id);
        session.getTransaction().commit();
        return vitaltable;
    }

    public PatientBed deletePatientBed(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBed bed = (PatientBed) session.get(PatientBed.class, id);
        session.delete(bed);
        session.getTransaction().commit();
        return bed;
    }

    public List listPatientBed() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBed").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientBedByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBed where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public TransitClinicLabs addTransitLabs(String orderid, String patientid, String fromdoc, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TransitClinicLabs vitaltable = new TransitClinicLabs();
        vitaltable.setDone("Clinic");
        vitaltable.setPatientid(patientid);
        vitaltable.setVisitid(visitid);
        vitaltable.setFromdoc(fromdoc);
        vitaltable.setOrderdate(new Date());
        vitaltable.setOrderid(orderid);
        session.save(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public TransitClinicLabs updatePatientBed(String orderid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TransitClinicLabs vitaltable = (TransitClinicLabs) session.get(TransitClinicLabs.class, orderid);
        vitaltable.setDone(status);
        session.update(vitaltable);
        session.getTransaction().commit();
        return vitaltable;
    }

    public TransitClinicLabs getTransitLabById(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TransitClinicLabs vitaltable = (TransitClinicLabs) session.get(TransitClinicLabs.class, id);
        session.getTransaction().commit();
        return vitaltable;
    }

    public List listTransitLabsInClinic() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from TransitClinicLabs").list();
        session.getTransaction().commit();
        return result;
    }

    public List listTransitLabs() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from TransitClinicLabs where done='Clinic'").list();
        session.getTransaction().commit();
        return result;
    }

    public TransitClinicLabs updateTransitClinicLabs(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TransitClinicLabs transitClinicLabs = (TransitClinicLabs) session.get(TransitClinicLabs.class, orderid);
        transitClinicLabs.setDone("Forwarded");

        session.update(transitClinicLabs);
        session.getTransaction().commit();
        return transitClinicLabs;
    }

    public PatientDiscount addDiscount(int visitid, String patientid, double percentage, double actual, double newcharge, String staffid, String status, String reason) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientDiscount patientDiscount = new PatientDiscount();
        patientDiscount.setDiscounted(actual);
        patientDiscount.setNewAmount(newcharge);
        patientDiscount.setPatientId(patientid);
        patientDiscount.setPercentageDiscount(percentage);
        patientDiscount.setReason(reason);
        patientDiscount.setStaffId(staffid);
        patientDiscount.setStatus(status);
        patientDiscount.setVisitId(visitid);
        session.save(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public PatientDiscount updateDiscount(int discountid, double percentage, double actual, double newcharge) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientDiscount patientDiscount = (PatientDiscount) session.get(PatientDiscount.class, discountid);
        patientDiscount.setPercentageDiscount(percentage);
        patientDiscount.setDiscounted(actual);
        patientDiscount.setNewAmount(newcharge);
        session.update(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public PatientDiscount deleteDiscount(int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientDiscount patientDiscount = (PatientDiscount) session.get(PatientDiscount.class, discountid);
        session.delete(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public List listPatientDiscountByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientDiscount where visit_id=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientDisountByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientDiscount where patient_id='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientDiscountByStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientDiscount where status='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public LabDiscount addLabDiscount(String labid, String patientid, double percentage, double actual, double newcharge, String staffid, String status, String reason) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabDiscount patientDiscount = new LabDiscount();
        patientDiscount.setDiscounted(actual);
        patientDiscount.setNewAmount(newcharge);
        patientDiscount.setPatientId(patientid);
        patientDiscount.setPercentageDiscount(percentage);
        patientDiscount.setReason(reason);
        patientDiscount.setStaffId(staffid);
        patientDiscount.setStatus(status);
        patientDiscount.setLabId(labid);
        session.save(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public LabDiscount updateLabDiscount(int discountid, double percentage, double actual, double newcharge) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabDiscount patientDiscount = (LabDiscount) session.get(LabDiscount.class, discountid);
        patientDiscount.setPercentageDiscount(percentage);
        patientDiscount.setDiscounted(actual);
        patientDiscount.setNewAmount(newcharge);
        session.update(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public LabDiscount deleteLabDiscount(int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabDiscount patientDiscount = (LabDiscount) session.get(LabDiscount.class, discountid);
        session.delete(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public List listLabDiscountByVisitid(String labid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabDiscount where labid='" + labid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabDisountByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabDiscount where patient_id='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabDiscountByStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabDiscount where status='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public PharmacyDiscount addPharmDiscount(String labid, String patientid, double percentage, double actual, double newcharge, String staffid, String status, String reason) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PharmacyDiscount patientDiscount = new PharmacyDiscount();
        patientDiscount.setDiscounted(actual);
        patientDiscount.setNewAmount(newcharge);
        patientDiscount.setPatientId(patientid);
        patientDiscount.setPercentageDiscount(percentage);
        patientDiscount.setReason(reason);
        patientDiscount.setStaffId(staffid);
        patientDiscount.setStatus(status);
        patientDiscount.setOrderid(labid);
        session.save(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public PharmacyDiscount updatePharmDiscount(int discountid, double percentage, double actual, double newcharge) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PharmacyDiscount patientDiscount = (PharmacyDiscount) session.get(PharmacyDiscount.class, discountid);
        patientDiscount.setPercentageDiscount(percentage);
        patientDiscount.setDiscounted(actual);
        patientDiscount.setNewAmount(newcharge);
        session.update(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public PharmacyDiscount deletePharmDiscount(int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PharmacyDiscount patientDiscount = (PharmacyDiscount) session.get(PharmacyDiscount.class, discountid);
        session.delete(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public List listPharmDiscountByOrderid(String labid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PharmacyDiscount where orderid='" + labid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPharmDisountByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PharmacyDiscount where patient_id='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPharmDiscountByStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PharmacyDiscount where status='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Profile addProfile(String description, double profilecharge) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Profile profile = new Profile();
        profile.setProfileDescription(description);
        profile.setProfileAmount(profilecharge);
        session.save(profile);
        session.getTransaction().commit();
        return profile;
    }

    public Profile deleteProfile(int discountid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Profile patientDiscount = (Profile) session.get(Profile.class, discountid);
        session.delete(patientDiscount);
        session.getTransaction().commit();
        return patientDiscount;
    }

    public List listProfile() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Profile").list();
        session.getTransaction().commit();
        return result;
    }

    public ProfileDetails addLabToProfile(int profileid, int labid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ProfileDetails profileDetails = new ProfileDetails();
        profileDetails.setProfileId(profileid);
        profileDetails.setLabId(labid);
        session.save(profileDetails);
        session.getTransaction().commit();
        return profileDetails;
    }

    public ProfileDetails deleteDetailLab(int labid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ProfileDetails profileDetails = (ProfileDetails) session.get(ProfileDetails.class, labid);
        session.delete(profileDetails);
        session.getTransaction().commit();
        return profileDetails;
    }

    public List listProfileLab(int profileid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ProfileDetails where profile_id=" + profileid).list();
        session.getTransaction().commit();
        return result;
    }

    public InvestigationResistantSusc addInvestigationSusc(int investigation, int resistant, int suscetible) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InvestigationResistantSusc profileDetails = new InvestigationResistantSusc();
        profileDetails.setPtreatmentId(investigation);
        profileDetails.setResistantTo(resistant);
        profileDetails.setSusceptibleTo(suscetible);
        session.save(profileDetails);
        session.getTransaction().commit();
        return profileDetails;
    }

    public List listInvestigationSuscByInvestigationId(int pInvestigation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InvestigationResistantSusc where ptreatment_id=" + pInvestigation).list();
        session.getTransaction().commit();
        return result;
    }

    public List listInvestigationSuscByInvestigationIdWhereSuscIsTrue(int pInvestigation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InvestigationResistantSusc where ptreatment_id=" + pInvestigation).list();
        session.getTransaction().commit();
        return result;
    }

    public List listInvestigationSuscByInvestigationIdWhereSuscIsFalse(int pInvestigation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InvestigationResistantSusc where ptreatment_id=" + pInvestigation).list();
        session.getTransaction().commit();
        return result;
    }

    public Specimen addSpecimen(String specimen) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Specimen specimen1 = new Specimen();
        specimen1.setSpecimen(specimen);
        session.save(specimen1);
        session.getTransaction().commit();
        return specimen1;
    }

    public Specimen updateSpecimen(int specimenid, String specimen) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Specimen specimen1 = (Specimen) session.get(Specimen.class, specimenid);
        specimen1.setSpecimen(specimen);

        session.update(specimen1);
        session.getTransaction().commit();
        return specimen1;
    }

    public Specimen deleteSpecimen(int specimenid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Specimen specimen = (Specimen) session.get(Specimen.class, specimenid);
        session.delete(specimen);
        session.getTransaction().commit();
        return specimen;
    }

    public List listSpecimen() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Specimen").list();
        session.getTransaction().commit();
        return result;
    }

    public Specimen getSpecimen(int specimen) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Specimen specimen1 = (Specimen) session.get(Specimen.class, specimen);
        session.getTransaction().commit();
        return specimen1;
    }

    public ArchivedRefRangeDet archiveDetailedRefRange(int detailedInvRefId, String from, String to, String mlowerRef, String mupperRef, String flowerRef, String fUpperRef, String orderid, int ptreatment) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ArchivedRefRangeDet detRefRange = new ArchivedRefRangeDet();
        detRefRange.setId(ptreatment);
        detRefRange.setDetailedinvRefrangeTypeId(detailedInvRefId);
        detRefRange.setDetFrom(from);
        detRefRange.setDetTo(to);
        detRefRange.setMLower(mlowerRef);
        detRefRange.setMUpper(mupperRef);
        detRefRange.setFLower(flowerRef);
        detRefRange.setFUpper(fUpperRef);
        detRefRange.setOerderid(orderid);
        detRefRange.setPatienttreatmentid(ptreatment);

        System.out.println(detailedInvRefId + "" + from + " " + to + " " + mlowerRef + " " + mupperRef + " " + flowerRef + " " + fUpperRef);
        session.save(detRefRange);
        session.getTransaction().commit();
        return detRefRange;
    }

    public ArchivedRefRangeUni archivedUniversalRefRange(int detailedInvRefId, int selected, String lowerRef, String upperRef, String paragraphic, String orderid, int ptreatment) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ArchivedRefRangeUni uRefRange = new ArchivedRefRangeUni();
        //uRefRange.setId(ptreatment);
        uRefRange.setDetailedinvRefrangeTypeId(detailedInvRefId);
        uRefRange.setSelected(selected);
        uRefRange.setLowerRefRange(lowerRef);
        uRefRange.setUpperRefRange(upperRef);
        uRefRange.setParagraphic(paragraphic);
        uRefRange.setOrderid(orderid);
        uRefRange.setPatienttreatmentid(ptreatment);
        session.save(uRefRange);
        session.getTransaction().commit();
        return uRefRange;
    }

    public List listArchiveUniRef(int ptreamentid, String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ArchivedRefRangeUni where orderid='" + orderid + "' and patienttreatmentid=" + ptreamentid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listArchiveDetRef(int ptreamentid, String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ArchivedRefRangeDet where oerderid='" + orderid + "' and patienttreatmentid=" + ptreamentid).list();
        session.getTransaction().commit();
        return result;
    }

    public ArchivedRefRangeDet getRefDet(int specimen) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ArchivedRefRangeDet specimen1 = (ArchivedRefRangeDet) session.get(ArchivedRefRangeDet.class, specimen);
        session.getTransaction().commit();
        return specimen1;
    }

    public ArchivedRefRangeUni getRefUni(int specimen) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ArchivedRefRangeUni specimen1 = (ArchivedRefRangeUni) session.get(ArchivedRefRangeUni.class, specimen);
        session.getTransaction().commit();
        return specimen1;
    }

    public FolderNumbering initialFolderSetup(String clinicAbbreviation, String diagnosticAbbreviation, String pharmacyAbbreviation, int clinicNumber, int diagnosticNumber, int pharmacyNumber) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = new FolderNumbering();
        folderNumbering.setClinicCounter(0);
        folderNumbering.setClinicStartNumber(clinicNumber);
        folderNumbering.setDiagnosticCounter(0);
        folderNumbering.setDiagnosticStartNumber(diagnosticNumber);
        folderNumbering.setFolderAbbreviationClinic(clinicAbbreviation);
        folderNumbering.setFolderAbbreviationDiagnostics(diagnosticAbbreviation);
        folderNumbering.setFolderAbbreviationPharmacy(pharmacyAbbreviation);
        folderNumbering.setPharmacyCounter(0);
        folderNumbering.setPharmacyStartNumber(pharmacyNumber);
        session.save(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering initialDiagnosticNumberSetup(int id, String diagnosticAbbreviation, int diagnosticNumber) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = (FolderNumbering) session.get(FolderNumbering.class, id);
        folderNumbering.setDiagnosticStartNumber(diagnosticNumber);
        folderNumbering.setFolderAbbreviationDiagnostics(diagnosticAbbreviation);
        folderNumbering.setDiagnosticCounter(0);
        session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering initialClinicNumberSetup(int id, String clinicAbbreviation, int clinicNumber) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = (FolderNumbering) session.get(FolderNumbering.class, id);
        folderNumbering.setClinicStartNumber(clinicNumber);
        folderNumbering.setFolderAbbreviationClinic(clinicAbbreviation);
        folderNumbering.setClinicCounter(0);
        session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering initialPharmcaySetup(int id, String pharmacyAbbreviation, int pharmacyNumber) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = new FolderNumbering();
        folderNumbering.setFolderAbbreviationPharmacy(pharmacyAbbreviation);
        folderNumbering.setPharmacyStartNumber(pharmacyNumber);
        folderNumbering.setPharmacyCounter(0);
        session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering updateDiagnosticCounter(int id, int counter) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = (FolderNumbering) session.get(FolderNumbering.class, id);
        folderNumbering.setDiagnosticCounter(counter);
        session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering updateClinicCounter(int id, int counter) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = (FolderNumbering) session.get(FolderNumbering.class, id);
        folderNumbering.setClinicCounter(counter);
        session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering updatePharmacyCounter(int id, int counter) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = (FolderNumbering) session.get(FolderNumbering.class, id);
        folderNumbering.setPharmacyCounter(counter);
        session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public FolderNumbering getFolderNumbering(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        FolderNumbering folderNumbering = (FolderNumbering) session.get(FolderNumbering.class, id);
        //session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public SponsorLabitemPrice addSponsorPrice(String sponsorid, double price, int item_code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        SponsorLabitemPrice labitemPrice = new SponsorLabitemPrice();
        labitemPrice.setPrice(price);
        labitemPrice.setSponsorId(sponsorid);
        labitemPrice.setLabItemId(item_code);
        session.save(labitemPrice);
        session.beginTransaction();
        return labitemPrice;
    }

    public SponsorLabitemPrice getSPonsorPriceItem(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        SponsorLabitemPrice folderNumbering = (SponsorLabitemPrice) session.get(SponsorLabitemPrice.class, id);
        //session.update(folderNumbering);
        session.getTransaction().commit();
        return folderNumbering;
    }

    public List listSponsorPriceList(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from SponsorLabitemPrice where sponsor_id='" + orderid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listItemPriceLists(int labitemid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from SponsorLabitemPrice where lab_item_id=" + labitemid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listItemPriceList(int labitemid, String sponsorId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from SponsorLabitemPrice where lab_item_id=" + labitemid + " AND sponsor_id='" + sponsorId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listItemPrice(int labitemid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from SponsorLabitemPrice").list();
        session.getTransaction().commit();
        return result;
    }

    public void deletePriceList(String discountid) throws NullPointerException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query q = session.createQuery("from SponsorLabitemPrice where sponsor_id = :sponsor_id");
        q.setParameter("sponsor_id", discountid);
        SponsorLabitemPrice stock = (SponsorLabitemPrice) q.list().get(0);
        session.delete(stock);
        //session.delete(folderNumbering);
        session.getTransaction().commit();
        //return sponsorLabitemPrice;
    }
//    public LabStockItem updateLS(int lsId, double curLev) {
//        session = HibernateUtil.getSessionFactory().getCurrentSession();
//        session.beginTransaction();
//        LabStockItem lsid = (LabStockItem) session.get(LabStockItem.class, lsId);
//        lsid.setCurrentLevel(curLev);
//        session.update(lsid);
//        session.getTransaction().commit();
//        return lsid;
//    }
    /*
     * check this method again
     * 
     */
    /*public LabStockItem updateLSI(int lsiId, double curLev, double totLev) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     LabStockItem lsi = (LabStockItem) session.get(LabStockItem.class, lsiId);
     lsi.setCurrentLevel(curLev);
     lsi.setTotalLevel(totLev);
     session.update(lsi);
     session.getTransaction().commit();
     return lsi;
     }
     */
}