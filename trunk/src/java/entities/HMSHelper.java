 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/* import com.itextpdf.text.Phrase; */
import helper.HibernateUtil;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;

/**
 *
 * @author afuaantwi
 */
public class HMSHelper {

    Session session = null;

    public HMSHelper() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public Session getSession() {
        return this.session;
    }
    /*
     * Creating or adding new instances / rows into the database
     */

    public Patient createPatient(String patientid, String fname, String lname, String midname, String gender, String Address, String employer, String dob, String contact, String secondContact, String emergencyperson, String emergencycontact, String email, String country, String city, String maritalstatus, String imglocation, String bearerlname, String beareronames, boolean dependent, String occupation, int emergencyPatient) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patient patient = new Patient();
        DateFormat formatter;
        Date date;
        formatter = new SimpleDateFormat("yyyy-MM-dd");
        date = (Date) formatter.parse(dob);
        patient.setFname(fname);
        patient.setLname(lname);
        patient.setPatientid(patientid);
        patient.setAddress(Address);
        patient.setContact(contact);
        patient.setSecondContact(secondContact);
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
        patient.setDateofregistration(new Date());
        patient.setLastVisitId(0);
        patient.setBearerLastname(bearerlname);
        patient.setBearerOthernames(beareronames);
        patient.setDependent(dependent);
        patient.setOccupation(occupation);
        patient.setEmergencyPatient(emergencyPatient);
        session.save(patient);

        session.getTransaction().commit();
        return patient;
    }

    /* public Folder updateFolderLocation(String lastlocation, String currentlocation, String foldernumber) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
    
     Folder folder = (Folder) session.get(Folder.class, foldernumber);
    
     folder.setStatus(currentlocation);
     folder.setPreviouslocation(lastlocation);
     session.update(folder);
     session.getTransaction().commit();
     return folder;
     }
     */
    public Patient updatePatient(String patientid, String fname, String lname, String midname, String gender, String Address, String employer, String dob, String contact, String secondContact, String emergencyperson, String emergencycontact, String email, String country, String city, String maritalstatus, String imglocation, String bearerlname, String beareronames, boolean dependent, String occupation, int emergencyPatient) throws Exception {
        System.out.println("We are in the Method");

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patient patient = (Patient) session.get(Patient.class, patientid);

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
        patient.setSecondContact(secondContact);
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
        patient.setDependent(dependent);
        patient.setOccupation(occupation);
        patient.setEmergencyPatient(emergencyPatient);
        System.out.println("The Whole Method Works");
        session.update(patient);
        session.getTransaction().commit();
        System.out.println("The Whole Method Works");
        return patient;
    }

    public Patient updatePatientOccupation(String patientid, String occupation) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patient patient = (Patient) session.get(Patient.class, patientid);
        patient.setOccupation(occupation);
        session.update(patient);
        session.getTransaction().commit();
        return patient;
    }

    public Appoint addAppointment(String doctorId, String patientId, String content, String start, String allDay, String end, String title) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Appoint app = new Appoint();
        app.setDoctorId(doctorId);
        app.setPatientId(patientId);
        app.setContent(content);
        app.setStart(start);
        app.setAllday(allDay);
        app.setEnd(end);
        app.setTitle(title);
        app.setHonored(Boolean.FALSE);
        session.save(app);
        session.getTransaction().commit();
        return app;
    }

    public CardPrinting addCard(String patientid, String orderedBy) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CardPrinting card = new CardPrinting();
        card.setPatientid(patientid);
        card.setPrice(20);
        card.setLastPrintDate(new Date());
        card.setPrintCount(1);
        card.setOrderedby(orderedBy);
        session.save(card);
        session.getTransaction().commit();
        return card;
    }

    
    
    
    public PatientMajorExaminations addPatientMajorExamination (String patientid, int visitid, String examination_note) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientMajorExaminations major = new PatientMajorExaminations();
        major.setPatientid(patientid);
        major.setVisitid(visitid);
        major.setExaminationNote(examination_note);
        session.save(major);
        session.getTransaction().commit();
        return major;
    }
    public CardPrinting updateCardCount(int id, String orderedBy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CardPrinting card = (CardPrinting) session.get(CardPrinting.class, id);
        card.setPrintCount(card.getPrintCount() + 1);
        card.setOrderedby(orderedBy);


        session.update(card);
        session.getTransaction().commit();
        return card;
    }

    public List listPrintedCards() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CardPrinting").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPrintedCardsByPatientId(String patientid) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CardPrinting where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listVisitsByPatientId(String patientid) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientid='" + patientid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public Folder updateFolderLocation(String folderNumber, String newLocation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Folder folder = (Folder) session.get(Folder.class, folderNumber);
        folder.setPreviouslocation(folder.getStatus());
        folder.setStatus(newLocation);

        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Folder createFolder(String foldernumber, String shelvenumber, String status, String previouslocation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Folder folder = new Folder();
        folder.setFoldernumber(foldernumber);
        folder.setShelvenumber(shelvenumber);
        folder.setStatus(status);
        folder.setPreviouslocation(previouslocation);
        session.save(folder);
        session.getTransaction().commit();
        return folder;

    }

    public Sponsorship createSponsor(String id, String sponsorName, String sponsorType, String sponsorAddress, String sponsorContact, String sponsorEmail, double labmarkup, double treatmentmarkup, double treatmentpercent, double labpercentage) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Sponsorship sponsor = new Sponsorship();
        sponsor.setSponshorshipid(id);
        sponsor.setAddress(sponsorAddress);
        sponsor.setContact(sponsorContact);
        sponsor.setEmail(sponsorEmail);
        sponsor.setSponsorname(sponsorName);
        sponsor.setType(sponsorType);
        sponsor.setLabmarkup(labmarkup);
        sponsor.setTreatmentMarkup(treatmentmarkup);
        sponsor.setMarkupLabPercentage(labpercentage);
        sponsor.setMarkupTreatPercentage(treatmentpercent);
        session.save(sponsor);
        session.getTransaction().commit();
        return sponsor;
    }

    public Sponsorship deleteSponsor(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        Sponsorship sponsor = (Sponsorship) session.get(Sponsorship.class, id);

        session.delete(sponsor);
        session.getTransaction().commit();
        return sponsor;
    }

    public Sponsorship updateSponsor(String id, String sponsorName, String sponsorType, String sponsorAddress, String sponsorContact, String sponsorEmail, double labmarkup, double treatmentmarkup, double treatmentpercent, double labpercentage) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Sponsorship sponsor = (Sponsorship) session.get(Sponsorship.class, id);

        sponsor.setAddress(sponsorAddress);
        sponsor.setContact(sponsorContact);
        sponsor.setEmail(sponsorEmail);
        sponsor.setSponsorname(sponsorName);
        sponsor.setType(sponsorType);
        sponsor.setLabmarkup(labmarkup);
        sponsor.setTreatmentMarkup(treatmentmarkup);
        sponsor.setMarkupLabPercentage(labpercentage);
        sponsor.setMarkupTreatPercentage(treatmentpercent);
        session.update(sponsor);
        session.getTransaction().commit();
        return sponsor;
    }

    public Sponsorship updateSponsorInfo(String id, String sponsorName, String sponsorType, String sponsorAddress, String sponsorContact, String sponsorEmail) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Sponsorship sponsor = (Sponsorship) session.get(Sponsorship.class, id);

        sponsor.setAddress(sponsorAddress);
        sponsor.setContact(sponsorContact);
        sponsor.setEmail(sponsorEmail);
        sponsor.setSponsorname(sponsorName);
        sponsor.setType(sponsorType);

        session.update(sponsor);
        session.getTransaction().commit();
        return sponsor;
    }

    public Sponsorhipdetails createPatientSponsorshipDetails(String patientID, String membershipID, String type, String benefitPlan, String companyName, String dependentNumber, String secondaryType) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Sponsorhipdetails sponsorDetails = new Sponsorhipdetails();
        sponsorDetails.setPatientid(patientID);
        sponsorDetails.setBenefitplan(benefitPlan);
        sponsorDetails.setSponsorid(companyName);
        sponsorDetails.setType(type);
        sponsorDetails.setMembershipid(membershipID);
        sponsorDetails.setDependentnumber(dependentNumber);
        sponsorDetails.setSecondarySponsor("");
        sponsorDetails.setSecondaryType(secondaryType);
        sponsorDetails.setSecondaryBenefitplan("");
        sponsorDetails.setSecondaryMembership("");
        session.save(sponsorDetails);
        session.getTransaction().commit();
        return sponsorDetails;
    }

    public Units addUnit(String name, String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Units unit = new Units();
        unit.setUnitname(name);
        unit.setType(type);
        session.save(unit);
        session.getTransaction().commit();
        return unit;
    }

    public Ward addWard(String name, double cost) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Ward unit = new Ward();
        unit.setWardname(name);
        unit.setNumberofbeds(0);
        unit.setOccupied(0);
        unit.setCost(cost);
        unit.setType("ward");
        session.save(unit);
        session.getTransaction().commit();
        return unit;
    }

    public Wardnote addWardNote(int wardid, String staffid, String note) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Wardnote unit = new Wardnote();
        unit.setNote(note);
        unit.setNurseid(staffid);
        unit.setWardid(wardid);
        unit.setDate(new Date());
        session.save(unit);
        session.getTransaction().commit();
        return unit;
    }

    public Admissionnotes addAdmissionNoteint(int visitid, String doctorid, String note) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Admissionnotes admissionnotes = new Admissionnotes();
        admissionnotes.setDoctorsid(doctorid);
        admissionnotes.setNote(note);
        admissionnotes.setVisitid(visitid);
        admissionnotes.setDate(new Date());

        session.save(admissionnotes);
        session.getTransaction().commit();
        return admissionnotes;
    }

    public Consultingrooms addConRoom(String name) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Consultingrooms conroom = new Consultingrooms();
        conroom.setConsultingroom(name);
        conroom.setType("consultation");

        session.save(conroom);
        session.getTransaction().commit();
        return conroom;
    }

    public Visitationtable createNewVisit(String patientID, String doctor, String vitals, String status, String previous, int type, String notes) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Visitationtable visitation = new Visitationtable();
        visitation.setPatientid(patientID);
        visitation.setVitals(vitals);
        visitation.setDoctor(doctor);
        visitation.setDate(new Date());
        visitation.setStatus(status);
        visitation.setNotes(notes);
        visitation.setPatientstatus("Out Patient");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MMM-dd");
        Date date = new Date();
        String dates[] = dateFormat.format(date).split("-");
        //System.out.println(date);
        visitation.setMonth(dates[1]);
        visitation.setYear((dates[0]));
        visitation.setVisittype(type);
        visitation.setPreviouslocstion(previous);
        visitation.setReview(Boolean.FALSE);
        visitation.setTotalAmountPaid(0.0);
        visitation.setTotalBill(0.0);
        visitation.setDepositedAmount(0);
        session.save(visitation);
        session.getTransaction().commit();
        return visitation;
    }
    
    
    
    public Visitationtable createEmergencyVisit(String patientID) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Visitationtable visitation = new Visitationtable();
        visitation.setPatientid(patientID);
        visitation.setVitals("");
        visitation.setDoctor("");
        visitation.setDate(new Date());
        visitation.setStatus("ward");
        visitation.setNotes("");
        visitation.setPatientstatus("In Patient");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MMM-dd");
        Date date = new Date();
        String dates[] = dateFormat.format(date).split("-");
        //System.out.println(date);
        visitation.setMonth(dates[1]);
        visitation.setYear((dates[0]));
        visitation.setVisittype(-1);
        visitation.setPreviouslocstion("records");
        visitation.setReview(Boolean.FALSE);
         visitation.setTotalAmountPaid(0.0);
        visitation.setTotalBill(0.0);
        visitation.setDepositedAmount(0);
        session.save(visitation);
        session.getTransaction().commit();
        return visitation;
    }

    public InventoryItems addItem(String code, int quantity, String batchno, Date expDate, int manufacturing, int supplier, int reorderquantity, int emergencyquantity, double price, double dispensing, double pharmacy, double laboratory, double nhis, String locationId) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InventoryItems item = new InventoryItems();
        /*item.set(code);
        item.setBatchNumber(batchno);
        item.setCode(code);
        item.setDispensaryprice(dispensing);
        item.setEmergencyLevel(emergencyquantity);
        item.setExpiryDate(expDate);
        item.setLaboratoryprice(laboratory);
        item.setManufacturer(manufacturing);
        item.setNhisprice(nhis);
        item.setPharmacyprice(pharmacy);
        item.setPurchasingprice(price);
        item.setQuantity(quantity);
        item.setReorderLevel(reorderquantity);
        item.setSupplier(supplier);
        item.setLocationId(locationId);*/
        session.save(item);
        session.getTransaction().commit();
        return item;
    }

    /*  public patientTreatments addNewTreament(String treatment_item, double price, String ICD10Code, String GDRGCode , int quantity) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     patientTreatments treatmentObj = new patientTreatments();
     treatmentObj.setBatchNumber(batchNumber);
     treatmentObj.setTreatment(treatment);
     treatmentObj.setPrice(price);
     treatmentObj.setIcd10(icd10);
     treatmentObj.setGdrg(gdrg);
     treatmentObj.setQuantity(quantity);

     session.save(treatmentObj);
     session.getTransaction().commit();
     return treatmentObj;
     }
     */
    public Diagnosis addANewDiagnosis(String code, String diagnosis, String gdrg) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Diagnosis diagnosisObj = new Diagnosis();
        diagnosisObj.setDiagnosisCode(code);
        diagnosisObj.setDiagnosis(diagnosis);
        diagnosisObj.setGdrg(gdrg);

        session.save(diagnosisObj);
        session.getTransaction().commit();
        return diagnosisObj;
    }

    public Consultation addConsultation(String type, double amount) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Consultation diagnosisObj = new Consultation();
        diagnosisObj.setContype(type);
        diagnosisObj.setAmount(amount);
        //diagnosisObj.s

        session.save(diagnosisObj);
        session.getTransaction().commit();
        return diagnosisObj;
    }

    public Laborders addLaborders(String orderid, String fromdoc, String physician, String facility, int id, String patientid, String status, String receivedBy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //List lst = list
        Laborders laborders = new Laborders();
        laborders.setOrderid(orderid);
        laborders.setDonedate(null);
        laborders.setFromdoc(fromdoc);
        laborders.setPatientid(patientid);
        laborders.setPhysician(physician);
        laborders.setFacility(facility);
        laborders.setOrderdate(new Date());
        laborders.setVisitid(id);
        laborders.setTodoc("");
        laborders.setOutstanding(0.0);
        laborders.setTotalAmount(0.0);
        laborders.setAmountpaid(0.0);
        laborders.setViewed(Boolean.FALSE);
        laborders.setDone(status);
        laborders.setScrutinized("");
        laborders.setDate(new Date());
        laborders.setReceivedBy(receivedBy);
        session.save(laborders);
        session.getTransaction().commit();
        return laborders;
    }

    /* public Investigation addAnInvestigation(String investigation, double price, String icd10, String gdrg) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     Investigation investigationObj = new Investigation();
     investigationObj.setInvestigation(investigation);
     investigationObj.setPrice(price);
     investigationObj.setGdrg(gdrg);
     investigationObj.setIcd10(icd10);
    
     session.save(investigationObj);
     session.getTransaction().commit();
     return investigationObj;
     }*/
    public Patientclerking addPatientClerking(int visitid, int questionid, int answerid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientclerking patientclerking = new Patientclerking();
        patientclerking.setVisitid(visitid);
        patientclerking.setQuestionid(questionid);


        session.save(patientclerking);
        session.getTransaction().commit();
        return patientclerking;
    }

    public Clerkingquestion addClerkingQuestion(String question, int frequency, int category_id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Clerkingquestion clerkingquestion = new Clerkingquestion();
        clerkingquestion.setQuestion(question);
        clerkingquestion.setFrequecy(frequency);
        clerkingquestion.setCategoryId(category_id);

        session.save(clerkingquestion);
        session.getTransaction().commit();
        return clerkingquestion;
    }

    public MedicalHistories addMedicalHistory(String medicalHistory) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        MedicalHistories medHistory = new MedicalHistories();
        medHistory.setHistory(medicalHistory);


        session.save(medHistory);
        session.getTransaction().commit();
        return medHistory;
    }

    public SocialHistories addSocialHistory(String socialHistory) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        SocialHistories socHistory = new SocialHistories();
        socHistory.setSocialHistory(socialHistory);


        session.save(socHistory);
        session.getTransaction().commit();
        return socHistory;
    }

    public BodyPartOptions addBodyPartOptions(String bodyPartOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        BodyPartOptions bodyPart = new BodyPartOptions();
        bodyPart.setBodyPart(bodyPartOption);


        session.save(bodyPart);
        session.getTransaction().commit();
        return bodyPart;
    }

   

    public CharacteristicOptions addCharacteristicOptions(String characteristicOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CharacteristicOptions characteristic = new CharacteristicOptions();
        characteristic.setCharacteristic(characteristicOption);


        session.save(characteristic);
        session.getTransaction().commit();
        return characteristic;
    }

    public DurationOptions addDurationOptions(String durationOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DurationOptions duration = new DurationOptions();
        duration.setDuration(durationOption);


        session.save(duration);
        session.getTransaction().commit();
        return duration;
    }

    public TreatmentOptions addTreatmentOptions(String treatmentOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TreatmentOptions treatment = new TreatmentOptions();
        treatment.setTreatment(treatmentOption);


        session.save(treatment);
        session.getTransaction().commit();
        return treatment;
    }

    public ProblemOptions addProblemOptions(String problemOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ProblemOptions problem = new ProblemOptions();
        problem.setProblemName(problemOption);


        session.save(problem);
        session.getTransaction().commit();
        return problem;
    }

    public OnsetOptions addOnsetOptions(String onsetOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        OnsetOptions onset = new OnsetOptions();
        onset.setOnset(onsetOption);


        session.save(onset);
        session.getTransaction().commit();
        return onset;
    }

    public AggrevationOptions addAggrevationOptions(String aggrevationOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        AggrevationOptions aggrevation = new AggrevationOptions();
        aggrevation.setAggrevation(aggrevationOption);


        session.save(aggrevation);
        session.getTransaction().commit();
        return aggrevation;
    }

    public ReliefOptions addReliefOptions(String reliefOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ReliefOptions relief = new ReliefOptions();
        relief.setRelief(reliefOption);


        session.save(relief);
        session.getTransaction().commit();
        return relief;
    }

    public ClerkingCategories addClerkingCategory(String name, boolean active) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClerkingCategories category = new ClerkingCategories();
        category.setCategoryName(name);
        category.setActive(active);


        session.save(category);
        session.getTransaction().commit();
        return category;
    }

    public Patientconsultation addPatientConsultation(int visitid, int typeid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientconsultation patientconsultation = new Patientconsultation();
        patientconsultation.setVisitid(visitid);
        patientconsultation.setTypeid(typeid);
        patientconsultation.setAmountpaid(0.0);
        patientconsultation.setCopaid(Boolean.FALSE);
        patientconsultation.setStatus("Not Paid");
        patientconsultation.setSecondaryPayment(0.0);
        patientconsultation.setPersonallySupported(Boolean.FALSE);
        patientconsultation.setPersonalSupportAmount(0.0);
        session.save(patientconsultation);
        session.getTransaction().commit();
        return patientconsultation;
    }

    public Transferlocation addTransferLocation(int visitid, Date date, String location, String doctorid, int diagnosis, String note) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Transferlocation transferlocation = new Transferlocation();
        transferlocation.setDoctorid(doctorid);
        transferlocation.setLocation(location);
        transferlocation.setNote(note);
        transferlocation.setVisitdate(date);
        transferlocation.setVisitid(visitid);
        transferlocation.setDiagnosisid(diagnosis);


        session.save(transferlocation);
        session.getTransaction().commit();
        return transferlocation;
    }

    public Qualification addStaffQualification(String qualification, String startYear, String endYear, String institution, String staffid) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Qualification qualification1 = new Qualification();
        qualification1.setStartyear(startYear);
        qualification1.setInstitution(institution);
        qualification1.setQualification(qualification);

        qualification1.setEndyear(endYear);
        qualification1.setStaffid(staffid);


        session.save(qualification1);
        session.getTransaction().commit();
        return qualification1;
    }

    public Stafftable addStaff(String employeeid, String lastname, String othername, String ssn, String dob, String pob, String yearemployed, String email, String gender, String contact, String address, String nextofkin, String kincontact, int departmentid, int roleid, String extraduty, String imglocation) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Stafftable stafftable = new Stafftable();

        stafftable.setActive(Boolean.TRUE);
        stafftable.setAddress(address);
        stafftable.setContact(contact);
        stafftable.setDob(dob);
        stafftable.setEmail(email);
        stafftable.setExtraduty(extraduty);
        stafftable.setGender(gender);
        stafftable.setImglocation(imglocation);
        stafftable.setLastname(lastname);
        stafftable.setNextofkin(nextofkin);
        stafftable.setNextofkincontact(kincontact);
        stafftable.setOthername(othername);
        stafftable.setPlaceofbirth(pob);
        stafftable.setRole(roleid);
        stafftable.setSsn(ssn);
        stafftable.setStaffid(employeeid);
        stafftable.setUnit(departmentid);
        stafftable.setYearofemployment(yearemployed);

        session.save(stafftable);
        session.getTransaction().commit();
        return stafftable;

    }

    public Stafftable editStaff(String employeeid, String email, String contact, String address, String nextofkin, String kincontact) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Stafftable stafftable = (Stafftable) session.get(Stafftable.class, employeeid);

        stafftable.setAddress(address);
        stafftable.setContact(contact);

        stafftable.setEmail(email);

        stafftable.setNextofkin(nextofkin);
        stafftable.setNextofkincontact(kincontact);

        stafftable.setStaffid(employeeid);


        session.update(stafftable);
        session.getTransaction().commit();
        return stafftable;

    }

    public Patientinvestigation addPatientInvestigation(String patientid, String code, int investigationid, String result, Double price, int visitationid, String visitDate, String performed, String notes, int qty, String orderid) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DateFormat formatter;
        Date date;
        formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        date = (Date) formatter.parse(visitDate);

        Patientinvestigation patientInvestigation = new Patientinvestigation();
        //patientInvestigation.setId(patientid);
        patientInvestigation.setCode(code);
        patientInvestigation.setPrice(price);
        //patientInvestigation.setInvestigation(investigation);
        patientInvestigation.setInvestigationid(investigationid);
        patientInvestigation.setResult(result);
        patientInvestigation.setDate(date);
        patientInvestigation.setPatientid(patientid);
        patientInvestigation.setVisitationid(visitationid);
        patientInvestigation.setPerformed(performed);
        patientInvestigation.setNote(notes);
        patientInvestigation.setQuantity(qty);
        patientInvestigation.setConcentration("");
        patientInvestigation.setResultrange("");
        patientInvestigation.setAmountpaid(0.0);
        patientInvestigation.setCopaid(Boolean.FALSE);
        patientInvestigation.setIsPrivate(Boolean.FALSE);
        patientInvestigation.setSecondaryAmount(0.0);
        patientInvestigation.setPrivateAmount(0.0);
        patientInvestigation.setOrderid(orderid);

        session.save(patientInvestigation);
        session.getTransaction().commit();
        return patientInvestigation;
    }

    public Patienttreatment addPatientTreatment(int treatmentid, Dosage dosage, Double price, String dispensed, int visitationid, String visitDate, int qty, Pharmorder orderid) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        

        Patienttreatment patientTreatment = new Patienttreatment();
        patientTreatment.setPrice(price);
        patientTreatment.setDispensed(dispensed);
        patientTreatment.setDosage(dosage);
        patientTreatment.setTreatmentid(treatmentid);
        patientTreatment.setQuantity(qty);
        patientTreatment.setVisitationid(visitationid);
        patientTreatment.setAmounpaid(0.0);
        patientTreatment.setCopaid(Boolean.FALSE);
        patientTreatment.setPharmorder(orderid);
        session.save(patientTreatment);
        session.getTransaction().commit();
        return patientTreatment;
    }

    public Patientdiagnosis addPatientDiagnosis(String patientid, int diagnosisid, String code, int visitationid, String visitDate) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DateFormat formatter;
        Date date;
        formatter = new SimpleDateFormat("yyyy-MM-dd");
        date = (Date) formatter.parse(visitDate);

        Patientdiagnosis patientdiagnosis = new Patientdiagnosis();
        patientdiagnosis.setDate(date);
        //patientdiagnosis.setDiagnosis(diagnosis);
        patientdiagnosis.setDiagnosisid(diagnosisid);
        patientdiagnosis.setCode(code);
        patientdiagnosis.setPatientid(patientid);
        patientdiagnosis.setVisitationid(visitationid);

        session.save(patientdiagnosis);
        session.getTransaction().commit();
        return patientdiagnosis;
    }

    public Dosagemonitor addDosageMonitor(int visitid, String patienttreatmentid, int quantity, String nurse) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Dosagemonitor dosagemonitor = new Dosagemonitor();
        dosagemonitor.setDate(new Date());
        dosagemonitor.setNurse(nurse);
        dosagemonitor.setQuantity(quantity);
        dosagemonitor.setTreatmentId(patienttreatmentid);
        dosagemonitor.setVisitid(visitid);
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss a");
        dosagemonitor.setTime(dateFormat.format(date));

        session.save(dosagemonitor);
        session.getTransaction().commit();
        return dosagemonitor;
    }

    public Newborn addNewborn(Date year, String month, String day, Date time, String patientid, String supervisor, String complications) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Newborn newborn = new Newborn();
        newborn.setComplications(complications);
        newborn.setDay(day);
        newborn.setMomsid(patientid);
        newborn.setMonth(month);
        newborn.setSupervisingmidwife(supervisor);
        newborn.setTime(time);
        newborn.setYear(year);
        session.save(newborn);
        session.getTransaction().commit();
        return newborn;
    }

    public PatientConditions addPatientCondition(int conditionId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientConditions condition = new PatientConditions();
        condition.setConditionId(conditionId);
        condition.setPatientid(patientid);
        condition.setVisitid(visitid);
        session.save(condition);
        session.getTransaction().commit();
        return condition;
    }

    public PatientImmunizations addPatientImmnunization(String patientid, int visitid, String immunizationString) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientImmunizations immunization = new PatientImmunizations();
        immunization.setImmunization(immunizationString);
        immunization.setPatientid(patientid);
        immunization.setVisitid(visitid);
        session.save(immunization);
        session.getTransaction().commit();
        return immunization;
    }

    public PatientSurgeries addPatientSurgery(String patientid, int visitid, String SurgeryString) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientSurgeries surgery = new PatientSurgeries();
        surgery.setSurgery(SurgeryString);
        surgery.setPatientid(patientid);
        surgery.setVisitid(visitid);
        session.save(surgery);
        session.getTransaction().commit();
        return surgery;
    }

    public NursesPatientConditions addNursesPatientCondition(int conditionId, String patientid, int visitid, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursesPatientConditions condition = new NursesPatientConditions();
        condition.setConditionId(conditionId);
        condition.setPatientid(patientid);
        condition.setVisitid(visitid);
        condition.setSeenby(staff);
        session.save(condition);
        session.getTransaction().commit();
        return condition;
    }

    public PatientConditionNotes addPatientConditionNote(String conditionNote, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientConditionNotes condition = new PatientConditionNotes();
        condition.setConditionNote(conditionNote);
        condition.setPatientid(patientid);
        condition.setVisitid(visitid);

        session.save(condition);
        session.getTransaction().commit();
        return condition;
    }

    public NursesPatientConditionNotes addNursesPatientConditionNote(String conditionNote, String patientid, int visitid, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursesPatientConditionNotes condition = new NursesPatientConditionNotes();
        condition.setConditionNote(conditionNote);
        condition.setPatientid(patientid);
        condition.setVisitid(visitid);
        condition.setSeenby(staff);
        session.save(condition);
        session.getTransaction().commit();
        return condition;
    }

    public PatientOnsets addPatientOnsets(int onsetId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientOnsets onset = new PatientOnsets();
        onset.setOnsetId(onsetId);
        onset.setPatientid(patientid);
        onset.setVisitid(visitid);
        session.save(onset);
        session.getTransaction().commit();
        return onset;
    }

    public NursesPatientOnsets addNursesPatientOnsets(int onsetId, String patientid, int visitid, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursesPatientOnsets onset = new NursesPatientOnsets();
        onset.setOnsetId(onsetId);
        onset.setPatientid(patientid);
        onset.setVisitid(visitid);
        onset.setSeenby(staff);
        session.save(onset);
        session.getTransaction().commit();
        return onset;
    }

    public PatientOnsetNotes addPatientOnsetNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientOnsetNotes onsetNote = new PatientOnsetNotes();
        onsetNote.setOnsetNote(note);
        onsetNote.setPatientid(patientid);
        onsetNote.setVisitid(visitid);
        session.save(onsetNote);
        session.getTransaction().commit();
        return onsetNote;
    }

    public NursesPatientOnsetNotes addNursesPatientOnsetNote(String note, String patientid, int visitid, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursesPatientOnsetNotes onsetNote = new NursesPatientOnsetNotes();
        onsetNote.setOnsetNote(note);
        onsetNote.setPatientid(patientid);
        onsetNote.setVisitid(visitid);
        onsetNote.setSeenby(staff);
        session.save(onsetNote);
        session.getTransaction().commit();
        return onsetNote;
    }

    public PatientBodyParts addPatientBodyParts(int bodyPartId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBodyParts bodyPart = new PatientBodyParts();
        bodyPart.setBodyPartId(bodyPartId);
        bodyPart.setPatientid(patientid);
        bodyPart.setVisitid(visitid);
        session.save(bodyPart);
        session.getTransaction().commit();
        return bodyPart;
    }

    public PatientBodyPartNotes addPatientBodyPartNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientBodyPartNotes bodyPartNote = new PatientBodyPartNotes();
        bodyPartNote.setBodyPartNote(note);
        bodyPartNote.setPatientid(patientid);
        bodyPartNote.setVisitid(visitid);
        session.save(bodyPartNote);
        session.getTransaction().commit();
        return bodyPartNote;
    }

    public PatientDurations addPatientDuration(int durationId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientDurations duration = new PatientDurations();
        duration.setDurationId(durationId);
        duration.setPatientid(patientid);
        duration.setVisitid(visitid);
        session.save(duration);
        session.getTransaction().commit();
        return duration;
    }

    public PatientDurationNotes addPatientDurationNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientDurationNotes durationNote = new PatientDurationNotes();
        durationNote.setDurationNote(note);
        durationNote.setPatientid(patientid);
        durationNote.setVisitid(visitid);
        session.save(durationNote);
        session.getTransaction().commit();
        return durationNote;
    }

    public PatientCharacteristics addPatientCharacteristic(int characteristicId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientCharacteristics characteristic = new PatientCharacteristics();
        characteristic.setCharacteristicId(characteristicId);
        characteristic.setPatientid(patientid);
        characteristic.setVisitid(visitid);
        session.save(characteristic);
        session.getTransaction().commit();
        return characteristic;
    }

    public PatientCharacteristicNotes addPatientCharacteristicNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientCharacteristicNotes characteristicNote = new PatientCharacteristicNotes();
        characteristicNote.setCharacteristicNote(note);
        characteristicNote.setPatientid(patientid);
        characteristicNote.setVisitid(visitid);
        session.save(characteristicNote);
        session.getTransaction().commit();
        return characteristicNote;
    }

    public PatientAggravations addPatientAggravation(int aggravationId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientAggravations aggravation = new PatientAggravations();
        aggravation.setAggravationId(aggravationId);
        aggravation.setPatientid(patientid);
        aggravation.setVisitid(visitid);
        session.save(aggravation);
        session.getTransaction().commit();
        return aggravation;
    }

    public PatientAggravationNotes addPatientAggravationNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientAggravationNotes aggravationNote = new PatientAggravationNotes();
        aggravationNote.setAggravationNote(note);
        aggravationNote.setPatientid(patientid);
        aggravationNote.setVisitid(visitid);
        session.save(aggravationNote);
        session.getTransaction().commit();
        return aggravationNote;
    }

    public PatientReliefs addPatientRelief(int reliefId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientReliefs relief = new PatientReliefs();
        relief.setReliefId(reliefId);
        relief.setPatientid(patientid);
        relief.setVisitid(visitid);
        session.save(relief);
        session.getTransaction().commit();
        return relief;
    }

    public NursesPatientReliefs addNursesPatientRelief(int reliefId, String patientid, int visitid, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursesPatientReliefs relief = new NursesPatientReliefs();
        relief.setReliefId(reliefId);
        relief.setPatientid(patientid);
        relief.setVisitid(visitid);
        relief.setSeenby(staff);
        session.save(relief);
        session.getTransaction().commit();
        return relief;
    }

    public PatientReliefNotes addPatientReliefNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientReliefNotes reliefNote = new PatientReliefNotes();
        reliefNote.setReliefNote(note);
        reliefNote.setPatientid(patientid);
        reliefNote.setVisitid(visitid);
        session.save(reliefNote);
        session.getTransaction().commit();
        return reliefNote;
    }

    public NursesPatientReliefNotes addNursesPatientReliefNote(String note, String patientid, int visitid, String staff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursesPatientReliefNotes reliefNote = new NursesPatientReliefNotes();
        reliefNote.setReliefNote(note);
        reliefNote.setPatientid(patientid);
        reliefNote.setVisitid(visitid);
        reliefNote.setSeenby(staff);
        session.save(reliefNote);
        session.getTransaction().commit();
        return reliefNote;
    }

    public PatientTreats addPatientTreats(int treatmentId, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientTreats treatment = new PatientTreats();
        treatment.setTreatmentId(treatmentId);
        treatment.setPatientid(patientid);
        treatment.setVisitid(visitid);
        session.save(treatment);
        session.getTransaction().commit();
        return treatment;
    }

    public PatientTreatmentNotes addPatientTreatmentNote(String note, String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientTreatmentNotes treatmentNote = new PatientTreatmentNotes();
        treatmentNote.setTreatmentNote(note);
        treatmentNote.setPatientid(patientid);
        treatmentNote.setVisitid(visitid);
        session.save(treatmentNote);
        session.getTransaction().commit();
        return treatmentNote;
    }

    public PatientSystemicReviews addPatientSystemicReview(int systemicReviewId, int visitid, String patientid, Date date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientSystemicReviews patientReviews = new PatientSystemicReviews();
        patientReviews.setDate(date);
        patientReviews.setPatientid(patientid);
        patientReviews.setSystemicReviewId(systemicReviewId);
        patientReviews.setVisitid(visitid);

        session.save(patientReviews);
        session.getTransaction().commit();
        return patientReviews;
    }

    public PatientMedicalHistory addPatientMedicalHistory(int medicalhistoryId, int visitid, String patientid, Date date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientMedicalHistory medicalHistory = new PatientMedicalHistory();
        medicalHistory.setVisitid(visitid);
        medicalHistory.setPatientid(patientid);
        medicalHistory.setHistoryId(medicalhistoryId);
        medicalHistory.setDate(date);
        session.save(medicalHistory);
        session.getTransaction().commit();
        return medicalHistory;
    }

    public PatientFamilyHistory addPatientFamilyHistory(int familyhistoryId, int visitid, int durationid, String patientid, String relative, Date date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientFamilyHistory familyHistory = new PatientFamilyHistory();
        familyHistory.setVisitid(visitid);
        familyHistory.setPatientid(patientid);
        familyHistory.setHistoryId(familyhistoryId);
        familyHistory.setFamilyMember(relative);
        familyHistory.setDurationId(durationid);
        familyHistory.setDate(date);
        session.save(familyHistory);
        session.getTransaction().commit();
        return familyHistory;
    }

    public List listPatientFamilyHistoryByPatientId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientFamilyHistory where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientMedicalHistoryByPatientId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientMedicalHistory where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientSocialHistoryByPatientId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientSocialHistory where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientAllergiesByPatientId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientAllergies where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public PatientSocialHistory addPatientSocialHistory(int socialhistoryId, int visitid, int durationid, String patientid, Date date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientSocialHistory socialHistory = new PatientSocialHistory();
        socialHistory.setVisitid(visitid);
        socialHistory.setPatientid(patientid);
        socialHistory.setSocialHistoryId(socialhistoryId);
        socialHistory.setDurationId(durationid);
        socialHistory.setDate(date);
        session.save(socialHistory);
        session.getTransaction().commit();
        return socialHistory;
    }

    public Symptoms addSymptom(String symptomname) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Symptoms symptoms = new Symptoms();
        symptoms.setSymptomname(symptomname);
        session.save(symptoms);
        session.getTransaction().commit();
        return symptoms;
    }

    public Users addUser(Users users) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        session.save(users);
        session.getTransaction().commit();
        return users;
    }

    public Users editUser(String userid, String password) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Users user = (Users) session.get(Users.class, userid);

        user.setPassword(password);
        user.setUsername(userid);

        session.update(user);
        session.getTransaction().commit();
        return user;
    }

    
    public Visitationtable updateVisitReview(int visitid, boolean bool) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable user = (Visitationtable) session.get(Visitationtable.class, visitid);

        user.setReview(bool);
     
        session.update(user);
        session.getTransaction().commit();
        return user;
    }
    
    
    
    public Visitationtable updateTotalBill(int visitid, double billToBeAdded) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable user = (Visitationtable) session.get(Visitationtable.class, visitid);

        user.setTotalBill(user.getTotalBill()+billToBeAdded);
     
        session.update(user);
        session.getTransaction().commit();
        return user;
    }
    
    
    public Visitationtable updateTotalAmountPaid(int visitid, double amountPaid) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable user = (Visitationtable) session.get(Visitationtable.class, visitid);

        user.setTotalAmountPaid(user.getTotalAmountPaid()+amountPaid);
     
        session.update(user);
        session.getTransaction().commit();
        return user;
    }
    
    
    public Visitationtable updateDeposit(int visitid, double amountDeposited) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable user = (Visitationtable) session.get(Visitationtable.class, visitid);

        user.setDepositedAmount(user.getDepositedAmount()+amountDeposited);
     
        session.update(user);
        session.getTransaction().commit();
        return user;
    }
    
    
    public Loggingtable addLogging(Loggingtable loggingtable) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        session.save(loggingtable);
        session.getTransaction().commit();
        return loggingtable;
    }

    public Roletable addRole(String rolename, String roledesceription) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Roletable roletable = new Roletable();
        roletable.setRolename(rolename);
        roletable.setRoledescription(roledesceription);
        session.save(roletable);
        session.getTransaction().commit();
        return roletable;
    }

    public Roletable updateRole(String rolename, String roledesceription) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Roletable roletable = (Roletable) session.get(Roletable.class, rolename);
        roletable.setRolename(rolename);
        roletable.setRoledescription(roledesceription);
        session.update(roletable);
        session.getTransaction().commit();
        return roletable;
    }

    public Department addDepartment(String rolename) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Department roletable = new Department();
        roletable.setDepartment(rolename);

        session.save(roletable);
        session.getTransaction().commit();
        return roletable;
    }

    public Permission addPermission(String rolename, int department) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Permission roletable = new Permission();
        roletable.setPermission(rolename);
        roletable.setDepartmentid(department);
        session.save(roletable);
        session.getTransaction().commit();
        return roletable;
    }

    public StaffPermission addStaffPermission(int permissionid, String staffid) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        StaffPermission staffPermission = new StaffPermission();
        staffPermission.setPermissionid(permissionid);
        staffPermission.setStaffid(staffid);

        //staffPermission.setId(staffPermission);
        session.save(staffPermission);
        session.getTransaction().commit();
        return staffPermission;
    }

    public Dosage addDosage(String shortCut, String desceription, int quantity) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Dosage dosage = new Dosage();
        dosage.setDescription(desceription);
        dosage.setShortCode(shortCut);
        dosage.setQuantity(quantity);
        session.save(dosage);
        session.getTransaction().commit();
        return dosage;
    }

    public Dosage updateDosage(int dosagename, String description) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Dosage dosage = (Dosage) session.get(Symptoms.class, dosagename);

        dosage.setDescription(description);

        session.update(dosage);
        session.getTransaction().commit();
        return dosage;
    }

    public Dosage deleteDosage(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Dosage itm = (Dosage) session.get(Dosage.class, id);
        session.delete(itm);
        session.getTransaction().commit();

        return itm;
    }
    // Add Item Type

    public Itemtype addType(String itemType) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Itemtype type = new Itemtype();
        type.setItemType(itemType);
        // type.setId(id);
        session.save(type);
        session.getTransaction().commit();
        return type;
    }

    public Drugtype addDrugType(String drugType) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Drugtype type = new Drugtype();
        type.setDrugType(drugType);
        // type.setId(id);
        session.save(type);
        session.getTransaction().commit();
        return type;
    }

    // below is for posting to other units
    public Receive postItems(Date date, String items, String itemId, int quantity, String unit, String receiver, String transactionId, int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        // Query result = session.createQuery("update InventoryItems set items='"+items+"',quantity="+quantity+",price="+price+",date='"+date+"', exp_date='"+expDate+"' where items_id = "+id);

        //  Receive itm = (Receive) session.get(Receive.class, id);
        // System.out.println(items+" "+quantity+" "+price+" "+date+" "+expDate+" "+id);
        Receive itm = new Receive();
        itm.setDate(date);
        itm.setItems(items);
        itm.setItemId(itemId);
        itm.setQuantity(quantity);
        itm.setUnit(unit);
        itm.setReceiver(receiver);
        itm.setTransactionId(transactionId);
        itm.setId(id);
        session.save(itm);
        session.getTransaction().commit();
        return itm;
    }

    // below are for supliers 
    public Post addSupplier(Date date, String firstName, String lastName, String address, String tellNumber, String item, int quantity) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Post sup = new Post();
        sup.setDate(date);
        sup.setFirstName(firstName);
        sup.setLastName(lastName);
        sup.setAddress(address);
        sup.setTellNumber(tellNumber);
        sup.setItemSupplied(item);
        sup.setQuantity(quantity);
        session.save(sup);
        session.getTransaction().commit();
        return sup;
    }

    /*
     * End of database additions
     *
     * Querying the database for a list of objects 
     */
    public List listPrivateSponsors() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorship where type='Private'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listSponsors() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorship").list();
        session.getTransaction().commit();
        return result;
    }

    public List listUsers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Users").list();
        session.getTransaction().commit();
        return result;
    }

    public List login(String username, String password) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Users where username='" + username + "' and password='" + password + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listUsers(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Users where staffid='" + staffid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLoggings() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Loggingtable").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLoggingsByDate(String date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Loggingtable where date='" + date + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLoggingsByUserid(String userid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Loggingtable where userd='" + userid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listFolders() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Folder").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientClerkingByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientclerking where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listTransfers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Transferlocation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listTransfersByDate(Date date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Transferlocation where visitdate='" + date + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listTransfersByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Transferlocation where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatients() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patient").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabPatients() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabPatient ORDER BY dateofregistration DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listUnits() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Units").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDepartments() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Department").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPermissions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Permission").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientAdmissionNote(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Admissionnotes where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listConRooms() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Consultingrooms").list();
        session.getTransaction().commit();
        return result;
    }

    public List listVisitations() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable").list();
        session.getTransaction().commit();
        return result;
    }

    public List listVisitations(String patiencestatus) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientstatus ='" + patiencestatus + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public int countVisitations(String month, String year) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where month ='" + month + "' and year ='" + year + "'").list();
        session.getTransaction().commit();
        return result.size();
    }

    public int countVisitations(String month, String year, String patientstatus) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientstatus='" + patientstatus + "' and month ='" + month + "' and year ='" + year + "'").list();
        session.getTransaction().commit();
        return result.size();
    }

    public List listVisitationsTest() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List results = session.createCriteria(Visitationtable.class).setProjection(Projections.projectionList().add(Projections.rowCount()).add(Projections.groupProperty("month"))).list();
        session.getTransaction().commit();
        return results;
    }

    public List listMonthVisitations(String month) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where month ='" + month + "' group by month").list();
        session.getTransaction().commit();
        return result;
    }

    public List listVisitations(String month, String year) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where month ='" + month + "' and year ='" + year + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public int getMonthlyValues(String month, String year, String type) {
        int count = 0;
        List list = listVisitations(month, year);
        for (int i = 0; i < list.size(); i++) {
            Visitationtable v = (Visitationtable) list.get(i);
            if (type.equals("Private")) {
                if (sponsorshipDetails(v.getPatientid()).getType().equals("Cooperate")) {
                    count++;
                }
            }
            if (sponsorshipDetails(v.getPatientid()).getType().equals(type)) {
                count++;
            }
        }
        return count;
    }

    public int getMonthlyValues(String month, String year, String pstatus, String type) {
        int count = 0;
        List list = listVisitations(month, year, pstatus);
        for (int i = 0; i < list.size(); i++) {
            Visitationtable v = (Visitationtable) list.get(i);
            if (type.equals("Private")) {
                if (sponsorshipDetails(v.getPatientid()).getType().equals("Cooperate")) {
                    count++;
                }
            }
            if (sponsorshipDetails(v.getPatientid()).getType().equals(type)) {
                count++;
            }
        }
        return count;
    }

    public List listVisitations(String month, String year, String patientstatus) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientstatus='" + patientstatus + "' and month ='" + month + "' and year ='" + year + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listYearVisitations(String year) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where year ='" + year + "' group by year").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientsBySponsorType(String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorhipdetails where type ='" + type + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listUnitVisitations(String status, String today) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where status='" + status + "' and date='" + today + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listUnitVisitations(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where status='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }
    
    
    
    
    
    public List listUnitVisitationsByPatientStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientstatus='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listUnitVisitationsByPatient(String status, String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where status='" + status + "' and patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listVisitationsAtUnit(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where status='" + status + "' and patientstatus='In Patient'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listSecondaryConsultation(String unitname) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where status='" + unitname + "' and review=" + Boolean.TRUE).list();
        session.getTransaction().commit();
        return result;
    }

    public List listRecentVisits(String today) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where date='" + today + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientByDob(String today) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patient where dateofbirth='" + today + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listRecentVisits(String today, String pstatus) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where date='" + today + "' and patientstatus='" + pstatus + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientHistory(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientAdmissionHistory(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientid='" + patientid + "' and patientstatus='In Patient'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDiagnosis() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Diagnosis").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClerkQuestions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Clerkingquestion").list();
        session.getTransaction().commit();
        return result;
    }

    public List listMedicalHistoryOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from MedicalHistories").list();
        session.getTransaction().commit();
        return result;
    }

    public List listSocialHistoryOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from SocialHistories").list();
        session.getTransaction().commit();
        return result;
    }

    public List listSystemicReviewOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from SystemicReviews").list();
        session.getTransaction().commit();
        return result;
    }

    public List listBodyPartsOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from BodyPartOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listCharacteristicsOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CharacteristicOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listProblemOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ProblemOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDurationOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DurationOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listOnsetOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from OnsetOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAggrevationOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from AggrevationOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listReliefOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ReliefOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listTreatmentOptions() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from TreatmentOptions").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClerkCategories() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from ClerkingCategories").list();
        session.getTransaction().commit();
        return result;
    }

    public List listClerkQuestionsbyCategoryId(int categoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Clerkingquestion where category_id=" + categoryId).list();
        session.getTransaction().commit();
        return result;
    }

    public List listDiagnosisShow(String letters) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Diagnosis WHERE diagnosis like '%" + letters + "%'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listTreatmentShow(String letters) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Treatment WHERE batch_number like '%" + letters + "%'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listInvestigationShow(String letters) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation WHERE investigation like '%" + letters + "%'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listNhisInvesigation(String letters) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhisinvestigation WHERE investigation like %'" + letters + "%'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listNhisTreatment(String letters) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhistreatment WHERE drug like %'" + letters + "%'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listNhisInvesigation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Nhisinvestigation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDosages() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Dosage").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDosagesMonitorByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Dosagemonitor where visitid=" + visitid + " group by treatment_id").list();
        session.getTransaction().commit();
        return result;
    }

    public List listWardNotes() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Wardnote").list();
        session.getTransaction().commit();
        return result;
    }

    public List listWardNoteByWardid(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Wardnote where wardid=" + id).list();
        session.getTransaction().commit();
        return result;
    }

    public List listWardNoteByStaffid(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Wardnote where nurseid='" + staffid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listWardNoteByDate(String date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Wardnote where date='" + date + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List getPatientByName(String fname) {
        System.out.println("here" + fname);
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patient where fname like '%" + fname + "%' or lname like '%" + fname + "%'").list();

        session.getTransaction().commit();
        return result;
    }

    public List getPatientByFName(String fname) {
        System.out.println("here" + fname);
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patient where fname like '%" + fname + "%' or lname like '%" + fname + "%'").list();

        session.getTransaction().commit();
        return result;
    }

    public List getPatientByLName(String fname) {
        System.out.println("here" + fname);
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patient where fname like '%" + fname + "%' or lname like '%" + fname + "%'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listInvestigation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientExist(String fname, String lname, String dob) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patient where (fname='" + fname + "' OR fname='" + lname + "') AND (lname='" + fname + "' OR lname='" + lname + "') AND dateofbirth='" + dob + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabPatientExist(String fname, String lname, String dob) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabPatient where (fname='" + fname + "' OR fname='" + lname + "') AND (lname='" + fname + "' OR lname='" + lname + "') AND dateofbirth='" + dob + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listTreatments() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Treatment").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllTreatments() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Treatments").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDosageMonitor(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Dosagemonitor where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List patientDiagnosis(int visitationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientdiagnosis where visitationid=" + visitationid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientTreatmentsByVisitId(int visitationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment where visitationid=" + visitationid).list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigation(int visitationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where visitationid=" + visitationid).list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByType() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByTypeForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where date = '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByTypeForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByTypeMost() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation group by investigationid").setMaxResults(10).list();
        //query.setMaxResults(pageSize);
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByInvestigationid(int investigationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where investigationid=" + investigationid).list();
        session.getTransaction().commit();
        return result;
    }

    public List patientParticularInvDoneOnParticularVisit(int investigationid, int visitationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where investigationid = '" + investigationid + "' and visitationid='" + visitationid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByOrderId(String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where orderid='" + orderid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List patientInvestigationByOrderIdnStatus(String orderid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where orderid='" + orderid + "' AND performed='" + status + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List hasPatientBeenHereToday(String patientid, String today) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where patientid='" + patientid + "' and date ='" + today + "'").list();
        session.getTransaction().commit();

        return result;
    }

    public List listItems() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems").list();
        session.getTransaction().commit();
        return result;
    }

    public List listItemsByIemCode(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where code='" + code + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listCategory(String type) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("itemType from InventoryItems").list();
        session.getTransaction().commit();
        return result;
    }

    public List CheckItems() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where (emergency_level < curdate() or emergency_level = curdate())").list();
        session.getTransaction().commit();
        return result;
    }

    public List EditItems(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where items_id =" + id).list();
        session.getTransaction().commit();
        return result;
    }

    public List EditSups(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Post where id =" + id).list();
        session.getTransaction().commit();
        return result;
    }

    public List searchItems(String items) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where items like '%" + items + "%' ").list();
        session.getTransaction().commit();
        return result;
    }

    public List searchByCategory(String types) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where itemType = '" + types + "' ").list();
        session.getTransaction().commit();
        return result;
    }

    public List listItemType() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Itemtype ").list();
        session.getTransaction().commit();
        return result;
    }

    public List listDrugType() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Drugtype ").list();
        session.getTransaction().commit();
        return result;
    }

    public List listRoles() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Roletable ").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientTreatmentsForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment where date = '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientTreatmentsForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment where date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where date= '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPaymentObjectsByStaffForDate(String staffid, Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where staff_id= '" + staffid + "'and date_paid= '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPaymentObjectsByDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where date_paid= '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPaymentObjectsForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where date_paid between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPaymentObjectsByStaff(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where staff_id= '" + staffid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPaymentObjectsByStaffForDuration(String staffid, Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where staff_id= '" + staffid + "'and date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientInvestigationForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where date = '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientInvestigationForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientBabies(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Newborn where momsid = '" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> listLabPaymentsForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where date_paid = '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> listLabPaymentsForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where date_paid between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    /* public List listPatien(Date startDate, Date endDate) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
     List result = session.createQuery("from Patientinvestigation where date between '" + startDate + "' and '" + endDate + "'").list();
     session.getTransaction().commit();
     return result;
     }*/
    public List patientHistoryForDate(String patientid, Date date) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Visitationtable where patientid='" + patientid + "' and date = '" + date + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List patientHistoryForDateDuration(String patientid, Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Visitationtable where patientid='" + patientid + "' and date between '" + startDate + "' and '" + endDate + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNewbornByYear(Date year) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Newborn where year='" + year + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNewbornByYearNMonth(Date year, String month) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Newborn where year='" + year + "' and month= '" + month + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNewbornBetweenYears(Date startYear, Date endYear) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Newborn between year='" + startYear + "' and year='" + endYear + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNewbornDay(Date startYear, String month, String day) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Newborn where year='" + startYear + "' and month='" + month + "' and day = '" + day + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientInCity(String city) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Patient where city='" + city + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientCountry(String country) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Patient where country='" + country + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatienyByMaritalStatus(String maritalstatus) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Patient where maritalstatus='" + maritalstatus + "'";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNewbornBetweenYearNMonth(Date startYear, String startMonth, Date endYear, String endMonth) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String query = "from Newborn between (year='" + startYear + "' and month= '" + startMonth + "') and (year='" + endYear + "' month='" + endMonth + "')";
        System.out.println("query : " + query);
        List result = session.createQuery(query).list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientInvestigation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientConsultationByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientconsultation where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientConditionsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientConditions where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientSystemicReviewsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientSystemicReviews where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientConditionNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientConditionNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientOnsetsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientOnsets where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientOnsetNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientOnsetNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientBodyPartsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBodyParts where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientBodyPartNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientBodyPartNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientDurationsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientDurations where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientDurationNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientDurationNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientCharacteristicsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientCharacteristics where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientCharacteristicNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientCharacteristicNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientAggravationsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientAggravations where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientAggravationNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientAggravationNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientReliefsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientReliefs where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientReliefNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientReliefNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientTreatsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientTreats where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientTreatmentNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientTreatmentNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNursesPatientConditionsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursesPatientConditions where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNursesPatientConditionNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursesPatientConditionNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNursesPatientOnsetsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursesPatientOnsets where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNursesPatientOnsetNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursesPatientOnsetNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNursesPatientReliefsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursesPatientReliefs where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listNursesPatientReliefNotesByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursesPatientReliefNotes where visitid =" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientMajorExaminationByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientMajorExaminations where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientSurgeriesByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientSurgeries where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientImmunizationsByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientImmunizations where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientConsultation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientconsultation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientTreatments() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllStaff() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Stafftable").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAppointment() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Appoint").list();
        session.getTransaction().commit();
        return result;
    }

    public List listConsultation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Consultation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listStaffInUnit(int unit) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Stafftable where unit=" + unit).list();
        session.getTransaction().commit();
        return result;
    }

    public List listStaffInDepartment(int departmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Stafftable where unit=" + departmentid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listStaffPermissions(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from StaffPermission where staffid='" + staffid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listStaffWithPermissions(int permissionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from StaffPermission where permissionid=" + permissionid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listStaffWithThisRole(int roleid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Stafftable where role=" + roleid).list();
        session.getTransaction().commit();
        return result;
    }

    public String stepOverVisit(String patientid, String today) {
        //System.out.println("ahaaaa!  " + today);
        String size = "No";
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientid='" + patientid + "' and date ='" + today + "'").list();
        if (result.size() > 0) {
            size = "Yes";
        }
        session.getTransaction().commit();
        return size;
    }

    public List listCooperateInsurers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorship where type='Cooperate'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listNHISInsurers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorship where type='NHIS'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listCASHInsurers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorship where type='CASH'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listQualificationByStaffid(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Qualification where staffid='" + staffid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List postItem(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from InventoryItems where items_id =" + id + "").list();
        session.getTransaction().commit();
        return result;
    }

    public List listRecievers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Receive").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLaborders() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersReturned() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done='Returned'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByDoctorid() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where facility <>'Danpong Clinic'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByDoctoridForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where facility <>'Danpong Clinic' AND date= '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByDoctoridForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where facility <>'Danpong Clinic' AND date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByDoctorid(String doctorid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where physician = '" + doctorid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByFacilityid(String doctorid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where facility='" + doctorid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listOutstanding() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where outstanding > 0").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByStatus(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done ='" + status + "' ORDER BY orderdate DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByStatuses(String status, String status2) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done ='" + status + "' OR done ='" + status2 + "' ORDER BY orderdate DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByRecievedBy(String recievedBy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where received_by ='" + recievedBy + "' ORDER BY orderdate DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByStatusOr(String status, String statusTwo) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done ='" + status + "' or '" + statusTwo + "' ORDER BY orderdate DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersForVetting() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done=" + Boolean.TRUE + " ORDER BY orderdate DESC").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where visitid=" + visitid).list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByPatientid(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where patientid='" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listSuppliers() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Post").list();
        session.getTransaction().commit();
        return result;
    }

    public List listWard() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Ward").list();
        session.getTransaction().commit();
        return result;
    }

    public List listSymptoms() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Symptoms").list();
        session.getTransaction().commit();
        return result;
    }
    /*
     * End of methods for collecting /retrieving objects
     * 
     * Update database rows
     */

    public Folder updateFolderLocation(String lastlocation, String currentlocation, String foldernumber) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Folder folder = (Folder) session.get(Folder.class, foldernumber);

        folder.setStatus(currentlocation);
        folder.setPreviouslocation(lastlocation);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Sponsorhipdetails updateSponsorDetails(String patientid, String secondarySponsorid, String secondaryPlan, String secondaryMembership) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Sponsorhipdetails details = (Sponsorhipdetails) session.get(Sponsorhipdetails.class, patientid);
        details.setSecondaryBenefitplan(secondaryPlan);
        details.setSecondaryMembership(secondaryMembership);
        details.setSecondarySponsor(secondarySponsorid);
        session.update(details);
        session.getTransaction().commit();
        return details;
    }

    public Sponsorhipdetails updatePatientSponsorDetails(String benefitplan, String type, String membershipid, String patientid, String sponsorid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Sponsorhipdetails details = (Sponsorhipdetails) session.get(Sponsorhipdetails.class, patientid);

        details.setBenefitplan(benefitplan);
        details.setType(type);
        details.setMembershipid(membershipid);
        details.setPatientid(patientid);
        details.setSponsorid(sponsorid);

        session.update(details);
        session.getTransaction().commit();
        return details;
    }

    public Visitationtable updateVisitation(String patientid, int visitid, String status, String previouslocation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        visit.setPreviouslocstion(previouslocation);
        visit.setStatus(status);
        //visit.setVitals(vitals);
        //visit.setPatientstatus(patientStatus);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }
    
    
    public Visitationtable updateVisitationStatus(int visitid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        visit.setStatus(status);
        
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Visitationtable updateVisitation(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        visit.setReview(Boolean.TRUE);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Visitationtable updateVisitation(int visitid, String doctor) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        visit.setDoctor(doctor);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Visitationtable updateVisitationComplaints(int visitid, String complaints) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        visit.setVitals(complaints);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Investigation updateInvestigationResultsOptionType(int investigationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Investigation visit = (Investigation) session.get(Investigation.class, investigationid);
        visit.setResultOptions(Boolean.TRUE);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Investigation updateInvestigationRefRanges(int investigationid, String refType) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Investigation visit = (Investigation) session.get(Investigation.class, investigationid);
        visit.setRefRangeType(refType);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Permission updatePermission(int permissionid, String permision) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Permission visit = (Permission) session.get(Permission.class, permissionid);
        visit.setPermission(permision);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Department updateDepartment(int departmentid, String department) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Department visit = (Department) session.get(Department.class, departmentid);
        visit.setDepartment(department);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Visitationtable updateVisitNotes(int visitid, String notes) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        visit.setNotes(notes);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }
    
    
    public Visitationtable updateVisitTotalBill(int visitid, double totalbill) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);
        double oldtotalBill = visit.getTotalBill();
        visit.setTotalBill(oldtotalBill + totalbill);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Patienttreatment updatePatientTreatment(int ptid, String yes, double amountpaid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patienttreatment folder = (Patienttreatment) session.get(Patienttreatment.class, ptid);
        folder.setDispensed(yes);
        folder.setAmounpaid(amountpaid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patienttreatment updatePatientTreatment(int ptid, double secondary, boolean isSeondary) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patienttreatment folder = (Patienttreatment) session.get(Patienttreatment.class, ptid);
        folder.setCopaid(isSeondary);
        folder.setSecondaryAmount(secondary);
        //folder.setAmounpaid(amountpaid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patienttreatment updatePatientTreatment(int ptid, boolean isPrivateSupport, double privateSupport) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patienttreatment folder = (Patienttreatment) session.get(Patienttreatment.class, ptid);

        folder.setIsPrivate(isPrivateSupport);

        folder.setPrivateAmount(privateSupport);
        //folder.setAmounpaid(amountpaid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Loggingtable updateLogout(Loggingtable loggingtable) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        session.update(loggingtable);
        session.getTransaction().commit();
        return loggingtable;
    }

    public Patienttreatment updatePatientTreatment(int ptid, String yes) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patienttreatment folder = (Patienttreatment) session.get(Patienttreatment.class, ptid);
        folder.setDispensed(yes);

        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Clerkingquestion updateClerkingFrequency(int questionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Clerkingquestion folder = (Clerkingquestion) session.get(Clerkingquestion.class, questionid);
        folder.setFrequecy(folder.getFrequecy() + 1);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Clerkingquestion updateClerking(int questionid, String question, int categoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Clerkingquestion reviewQuestion = (Clerkingquestion) session.get(Clerkingquestion.class, questionid);
        reviewQuestion.setQuestion(question);
        reviewQuestion.setCategoryId(categoryId);

        session.update(reviewQuestion);
        session.getTransaction().commit();
        return reviewQuestion;
    }

    public ClerkingCategories updateClerkingCategory(int categoryId, String categoryName, boolean active) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ClerkingCategories category = (ClerkingCategories) session.get(ClerkingCategories.class, categoryId);
        category.setCategoryName(categoryName);
        category.setActive(active);
        session.update(category);
        session.getTransaction().commit();
        return category;
    }

    public MedicalHistories updateMedicalHistory(int historyId, String medicalHistoryOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        MedicalHistories medHistory = (MedicalHistories) session.get(MedicalHistories.class, historyId);
        medHistory.setHistory(medicalHistoryOption);

        session.update(medHistory);
        session.getTransaction().commit();
        return medHistory;
    }

    public SocialHistories updateSocialHistory(int historyId, String socialHistoryOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        SocialHistories socialHistory = (SocialHistories) session.get(SocialHistories.class, historyId);
        socialHistory.setSocialHistory(socialHistoryOption);

        session.update(socialHistory);
        session.getTransaction().commit();
        return socialHistory;
    }

    public BodyPartOptions updateBodyPartOptions(int bodyPartId, String BodyPartOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        BodyPartOptions BodyPart = (BodyPartOptions) session.get(BodyPartOptions.class, bodyPartId);
        BodyPart.setBodyPart(BodyPartOption);

        session.update(BodyPart);
        session.getTransaction().commit();
        return BodyPart;
    }

   

    public CharacteristicOptions updateCharacteristicOptions(int characteristicId, String CharacteristicOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CharacteristicOptions Characteristic = (CharacteristicOptions) session.get(CharacteristicOptions.class, characteristicId);
        Characteristic.setCharacteristic(CharacteristicOption);

        session.update(Characteristic);
        session.getTransaction().commit();
        return Characteristic;
    }

    public TreatmentOptions updateTreatmentOptions(int treatmentId, String TreatmentOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        TreatmentOptions Treatment = (TreatmentOptions) session.get(TreatmentOptions.class, treatmentId);
        Treatment.setTreatment(TreatmentOption);

        session.update(Treatment);
        session.getTransaction().commit();
        return Treatment;
    }

    public ProblemOptions updateProblemOptions(int problemId, String ProblemOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ProblemOptions Problem = (ProblemOptions) session.get(ProblemOptions.class, problemId);
        Problem.setProblemName(ProblemOption);

        session.update(Problem);
        session.getTransaction().commit();
        return Problem;
    }

    public DurationOptions updateDurationOptions(int durationId, String DurationOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DurationOptions Duration = (DurationOptions) session.get(DurationOptions.class, durationId);
        Duration.setDuration(DurationOption);

        session.update(Duration);
        session.getTransaction().commit();
        return Duration;
    }

    public OnsetOptions updateOnsetOptions(int onsetId, String OnsetOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        OnsetOptions Onset = (OnsetOptions) session.get(OnsetOptions.class, onsetId);
        Onset.setOnset(OnsetOption);

        session.update(Onset);
        session.getTransaction().commit();
        return Onset;
    }

    public AggrevationOptions updateAggrevationOptions(int aggrevationId, String AggrevationOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        AggrevationOptions Aggrevation = (AggrevationOptions) session.get(AggrevationOptions.class, aggrevationId);
        Aggrevation.setAggrevation(AggrevationOption);

        session.update(Aggrevation);
        session.getTransaction().commit();
        return Aggrevation;
    }

    public ReliefOptions updateReliefOptions(int reliefId, String ReliefOption) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ReliefOptions Relief = (ReliefOptions) session.get(ReliefOptions.class, reliefId);
        Relief.setRelief(ReliefOption);

        session.update(Relief);
        session.getTransaction().commit();
        return Relief;
    }

    public Roletable updateRoletable(int roleid, String rolename, String roledescription) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Roletable roletable = (Roletable) session.get(Roletable.class, roleid);
        roletable.setRoledescription(roledescription);
        roletable.setRolename(rolename);
        session.update(roletable);

        session.getTransaction().commit();
        return roletable;
    }

    public Patient updatePatientLastVisit(String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patient patient = (Patient) session.get(Patient.class, patientid);
        patient.setLastVisitId(visitid);
        session.update(patient);

        session.getTransaction().commit();
        return patient;
    }

    public Patient updatePatientLastClaimid(String patientid, int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patient patient = (Patient) session.get(Patient.class, patientid);
        patient.setLastClaimId(visitid);
        session.update(patient);

        session.getTransaction().commit();
        return patient;
    }

    public Patientinvestigation updatePatientInvestigation(int ptid, String result, String concentration, String range, String yes, String comment, double amountpaid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);
        folder.setResult(result);
        folder.setConcentration(concentration);
        folder.setResultrange(range);
        folder.setPerformed(yes);
        folder.setNote(comment);
        folder.setAmountpaid(amountpaid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patientinvestigation updatePatientInvestigation(int ptid, String result, String comment) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);
        folder.setResult(result);
        folder.setNote(comment);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patientinvestigation updatePatientInvestigation(int ptid, String orderid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);
        folder.setOrderid(orderid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patientinvestigation updatePatientInvestigation(int ptid, boolean iscopay, double secondarysupport) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);
        folder.setCopaid(iscopay);
        folder.setSecondaryAmount(secondarysupport);

        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patientinvestigation updatePatientInvestigation(int ptid, double privatesupport, boolean isprivate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);
        folder.setIsPrivate(isprivate);
        folder.setPrivateAmount(privatesupport);

        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patientinvestigation updatePatientInvestigationPayment(int ptid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);

        folder.setPerformed("Pending");
        // folder.setAmountpaid(amountpaid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Patientinvestigation updatePatientInvestigationStatus(int ptid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation folder = (Patientinvestigation) session.get(Patientinvestigation.class, ptid);

        folder.setPerformed("Pending");
        // folder.setAmountpaid(amountpaid);
        session.update(folder);
        session.getTransaction().commit();
        return folder;
    }

    public Visitationtable updateVisitationStatus(int visitid, String status, String previouslocation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);

        visit.setStatus(status);
        visit.setPreviouslocstion(previouslocation);
        // visit.setVitals(vitals);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Visitationtable admitPatience(int visitid, String patiencestatus, Date admissiondate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);

        visit.setAdmissiondate(admissiondate);
        visit.setPatientstatus(patiencestatus);
        //visit.setPreviouslocstion(previouslocation);
        // visit.setVitals(vitals);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Visitationtable dischargePatience(int visitid, String patiencestatus, Date dischargedate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable visit = (Visitationtable) session.get(Visitationtable.class, visitid);

        visit.setDischargedate(dischargedate);
        visit.setPatientstatus(patiencestatus);
        //visit.setPreviouslocstion(previouslocation);
        // visit.setVitals(vitals);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Laborders updateLabordersStatus(String orderid, Date dischargedate, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Laborders visit = (Laborders) session.get(Laborders.class, orderid);
        visit.setDonedate(new Date());
        visit.setDone(status);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Pharmorder updatePharmorderStatus(String orderid, Date dischargedate, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder visit = (Pharmorder) session.get(Pharmorder.class, orderid);
        //visit.setDonedate(new Date());
        visit.setOrderdate(new Date());
        visit.setDispensed(status);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Laborders updateLaborders(String orderid, double total, double amountpaid, double amountdue) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Laborders visit = (Laborders) session.get(Laborders.class, orderid);
        visit.setTotalAmount(total);
        visit.setAmountpaid(amountpaid);
        visit.setOutstanding(amountdue);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Pharmorder updatePharmorder(String orderid, double total, double amountpaid, double amountdue) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder visit = (Pharmorder) session.get(Pharmorder.class, orderid);
        visit.setTotalAmount(total);
        visit.setAmoutpaid(amountpaid);
        visit.setOutstanding(amountdue);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Laborders updateLaborderScrutinize(String orderid, String scrutinized) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Laborders visit = (Laborders) session.get(Laborders.class, orderid);
        visit.setScrutinized(scrutinized);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Laborders updateLaborderReceivedBy(String orderid, String receivedBy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Laborders visit = (Laborders) session.get(Laborders.class, orderid);
        visit.setReceivedBy(receivedBy);

        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Pharmorder updatePharmorderDispensedBy(String orderid, String receivedBy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder visit = (Pharmorder) session.get(Pharmorder.class, orderid);
        visit.setDispensedBy(receivedBy);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Pharmorder updatePharmorderReceivedBy(String orderid, String receivedBy) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Pharmorder visit = (Pharmorder) session.get(Pharmorder.class, orderid);
        visit.setReceivedBy(receivedBy);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Appoint updateAppointment(String start, String allDay, String end, String title, String doctorId, String patientId, String content, int id) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Appoint app = (Appoint) session.get(Appoint.class, id);

        app.setDoctorId(doctorId);
        app.setPatientId(patientId);
        app.setContent(content);
        app.setStart(start);
        app.setAllday(allDay);
        app.setEnd(end);
        app.setTitle(title);
        app.setId(id);

        session.update(app);
        session.getTransaction().commit();
        return app;
    }

    public Appoint honorAppointment(int id) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Appoint app = (Appoint) session.get(Appoint.class, id);

        app.setHonored(Boolean.TRUE);

        session.update(app);
        session.getTransaction().commit();
        return app;
    }

    public List EditAppointment(String title) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Appoint where title = '" + title + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List EditTitle(String start) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Appoint where start = '" + start + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Patientconsultation updatePatientConsultation(int id, double amountpaid, String status, boolean copaid, boolean privateSupport, double secondaryPayment, double privatePayment) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientconsultation patientconsultation = (Patientconsultation) session.get(Patientconsultation.class, id);

        patientconsultation.setAmountpaid(amountpaid);
        patientconsultation.setStatus(status);
        patientconsultation.setCopaid(copaid);
        patientconsultation.setSecondaryPayment(secondaryPayment);
        patientconsultation.setPersonalSupportAmount(privatePayment);
        patientconsultation.setPersonallySupported(privateSupport);
        session.update(patientconsultation);
        session.getTransaction().commit();
        return patientconsultation;
    }

    public Laborders updateLaborders(String orderid, String todoc) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Laborders visit = (Laborders) session.get(Laborders.class, orderid);
        visit.setDonedate(new Date());
        visit.setViewed(Boolean.TRUE);
        visit.setTodoc(todoc);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public Laborders updateLaborders(String orderid, double diff) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Laborders visit = (Laborders) session.get(Laborders.class, orderid);
        double initial_total = visit.getAmountpaid() + diff;
        double rem = visit.getTotalAmount() - (visit.getAmountpaid() + diff);
        visit.setAmountpaid(initial_total);

        visit.setOutstanding(rem);
        //visit.setTodoc(todoc);
        session.update(visit);
        session.getTransaction().commit();
        return visit;
    }

    public InventoryItems updateItem(String code, int quantity, String batchno, Date expDate, int manufacturing, int supplier, int reorderquantity, int emergencyquantity, double price, double dispensing, double pharmacy, double laboratory, double nhis, String locationId) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InventoryItems item = (InventoryItems) session.get(InventoryItems.class, batchno);
        /*item.setCode(code);
        item.setBatchNumber(batchno);
        //item.setCode(code);
        item.setDispensaryprice(dispensing);
        item.setEmergencyLevel(emergencyquantity);
        item.setExpiryDate(expDate);
        item.setLaboratoryprice(laboratory);
        item.setManufacturer(manufacturing);
        item.setNhisprice(nhis);
        item.setPharmacyprice(pharmacy);
        item.setPurchasingprice(price);
        item.setQuantity(quantity);
        item.setReorderLevel(reorderquantity);
        item.setSupplier(supplier);
        item.setLocationId(locationId);*/
        session.update(item);
        session.getTransaction().commit();
        return item;
    }

    public InventoryItems updateItemQuantity(String batch, int quantity) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InventoryItems itm = (InventoryItems) session.get(InventoryItems.class, batch);
        itm.setQuantityOnHand(quantity);
        session.update(itm);
        session.getTransaction().commit();
        return itm;
    }

    public Post updateSupplier(Date date, String firstName, String lastName, String address, String tellNumber, String item, int quantity, int id) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Post sup = (Post) session.get(Post.class, id);
        sup.setDate(date);
        sup.setFirstName(firstName);
        sup.setLastName(lastName);
        sup.setAddress(address);
        sup.setTellNumber(tellNumber);
        sup.setItemSupplied(item);
        sup.setQuantity(quantity);
        session.update(sup);
        session.getTransaction().commit();
        return sup;
    }

    public Ward updateWardInfo(int wardid, String name, int numberofbeds, int occupied, double cost) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Ward ward = (Ward) session.get(Ward.class, wardid);
        ward.setWardname(name);
        ward.setOccupied(occupied);
        ward.setNumberofbeds(numberofbeds);
        ward.setCost(cost);
        session.update(ward);
        session.getTransaction().commit();
        return ward;
    }

    public Ward updateWardInfo(int wardid, String name, double cost) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Ward ward = (Ward) session.get(Ward.class, wardid);
        ward.setWardname(name);
        ward.setCost(cost);
        session.update(ward);
        session.getTransaction().commit();
        return ward;
    }

    public Ward updateWardInfo(int wardid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Ward ward = (Ward) session.get(Ward.class, wardid);
        ward.setOccupied(ward.getOccupied() + 1);
        session.update(ward);
        session.getTransaction().commit();
        return ward;
    }

    public Ward updateWardInfoDed(int wardid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Ward ward = (Ward) session.get(Ward.class, wardid);
        ward.setOccupied(ward.getOccupied() - 1);
        session.update(ward);
        session.getTransaction().commit();
        return ward;
    }

    public Ward updateNumberofBed(int wardid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Ward ward = (Ward) session.get(Ward.class, wardid);
        ward.setNumberofbeds(ward.getNumberofbeds() + 1);
        //ward.setNumberofbeds(ward.getNumberofbeds()+1);
        session.update(ward);
        session.getTransaction().commit();
        return ward;
    }

    public Dosagemonitor updateDosage(int dosageid, int visitid, String patienttreatmentid, int quantity, String nurse) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Dosagemonitor dosagemonitor = (Dosagemonitor) session.get(Dosagemonitor.class, dosageid);
        dosagemonitor.setDate(new Date());
        dosagemonitor.setNurse(nurse);
        dosagemonitor.setQuantity(quantity);
        dosagemonitor.setTreatmentId(patienttreatmentid);
        dosagemonitor.setVisitid(visitid);
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss a");

        session.update(dosagemonitor);
        session.getTransaction().commit();
        return dosagemonitor;
    }

    public Symptoms updateSymptom(int symptomid, String symptomname) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Symptoms symptoms = (Symptoms) session.get(Symptoms.class, symptomid);
        symptoms.setSymptomname(symptomname);

        session.update(symptoms);
        session.getTransaction().commit();
        return symptoms;
    }

    public Wardnote updateWardnote(int noteid, String note) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Wardnote wardnote = (Wardnote) session.get(Wardnote.class, noteid);
        wardnote.setNote(note);

        session.update(wardnote);
        session.getTransaction().commit();
        return wardnote;
    }

    public Stafftable updateStaffDetails(String employeeid, String lastname, String othername, String ssn, String dob, String pob, String yearemployed, String email, String gender, String contact, String address, String nextofkin, String kincontact, int departmentid, int roleid, String extraduty, String imglocation) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Stafftable stafftable = new Stafftable();

        stafftable.setActive(Boolean.TRUE);
        stafftable.setAddress(address);
        stafftable.setContact(contact);
        stafftable.setDob(dob);
        stafftable.setEmail(email);
        stafftable.setExtraduty(extraduty);
        stafftable.setGender(gender);
        stafftable.setImglocation(imglocation);
        stafftable.setLastname(lastname);
        stafftable.setNextofkin(nextofkin);
        stafftable.setNextofkincontact(kincontact);
        stafftable.setOthername(othername);
        stafftable.setPlaceofbirth(pob);
        stafftable.setRole(roleid);
        stafftable.setSsn(ssn);
        stafftable.setStaffid(employeeid);
        stafftable.setUnit(departmentid);
        stafftable.setYearofemployment(yearemployed);

        session.update(stafftable);
        session.getTransaction().commit();
        return stafftable;
    }

    public Patient updatePatientDetails(Patient patient) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        //Wardnote wardnote = (Wardnote) session.get(Wardnote.class, noteid);
        //wardnote.setNote(note);

        session.update(patient);
        session.getTransaction().commit();
        return patient;
    }

    public Consultation updateConsultation(int conid, String type, double amount) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Consultation wardnote = (Consultation) session.get(Consultation.class, conid);
        wardnote.setAmount(amount);
        wardnote.setContype(type);

        session.update(wardnote);
        session.getTransaction().commit();
        return wardnote;
    }

    public Units updateUnit(int uid, String uname) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Units wardnote = (Units) session.get(Units.class, uid);
        wardnote.setUnitname(uname);

        session.update(wardnote);
        session.getTransaction().commit();
        return wardnote;
    }

    public Consultingrooms updateConroon(int uid, String uname) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Consultingrooms wardnote = (Consultingrooms) session.get(Consultingrooms.class, uid);
        wardnote.setConsultingroom(uname);
        session.update(wardnote);
        session.getTransaction().commit();
        return wardnote;
    }

    public Qualification updateQualification(int quid, String qualification, String startYear, String endYear, String institution) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Qualification qualification1 = (Qualification) session.get(Qualification.class, quid);
        qualification1.setStartyear(startYear);
        qualification1.setInstitution(institution);
        qualification1.setQualification(qualification);
        qualification1.setEndyear(endYear);

        session.update(qualification1);
        session.getTransaction().commit();
        return qualification1;
    }

    public Newborn updateNewbornInfo(int newbornid, Date year, String month, String day, Date time, String patientid, String midwife, String complications) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Newborn newborn = (Newborn) session.get(Newborn.class, newbornid);
        newborn.setComplications(complications);
        newborn.setDay(day);
        newborn.setMomsid(patientid);
        newborn.setMonth(month);
        newborn.setSupervisingmidwife(midwife);
        newborn.setTime(time);
        newborn.setYear(year);

        session.update(newborn);
        session.getTransaction().commit();
        return newborn;
    }

    /*
     * End of the collection of methods for updating objects and rows
     * 
     * Following is a collection of methods the retrieve a singular object/row
     */
    public Sponsorhipdetails sponsorshipDetails(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Sponsorhipdetails sponsorship = (Sponsorhipdetails) session.get(Sponsorhipdetails.class, patientid);

        session.getTransaction().commit();
        return sponsorship;
    }

    public Patient getPatientByID(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Patient patient = (Patient) session.get(Patient.class, patientid);

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

    public List getSearchedSpID(String membershipid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorhipdetails where membershipid = '" + membershipid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Sponsorship getNHISID() {
        Sponsorship sponsorship = (Sponsorship) listNHISInsurers().get(0);
        return sponsorship;
    }

    public Sponsorship getCASHID() {
        Sponsorship sponsorship = (Sponsorship) listCASHInsurers().get(0);
        return sponsorship;
    }

    public Visitationtable currentVisitations(int patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable sponsorship = (Visitationtable) session.get(Visitationtable.class, patientid);

        session.getTransaction().commit();
        return sponsorship;

    }

    public Sponsorship getSponsor(String sponsorid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Sponsorship sponsor = (Sponsorship) session.get(Sponsorship.class, sponsorid);

        session.getTransaction().commit();
        return sponsor;
    }

    public Clerkingquestion getClerkingQuestionByid(int questionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Clerkingquestion sponsor = (Clerkingquestion) session.get(Clerkingquestion.class, questionid);

        session.getTransaction().commit();
        return sponsor;
    }

    public ClerkingCategories getClerkingCategoriesById(int categoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        ClerkingCategories category = (ClerkingCategories) session.get(ClerkingCategories.class, categoryId);

        session.getTransaction().commit();
        return category;
    }

    public MedicalHistories getMedicalHistoryById(int medHistoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        MedicalHistories medHistory = (MedicalHistories) session.get(MedicalHistories.class, medHistoryId);

        session.getTransaction().commit();
        return medHistory;
    }

    public SocialHistories getSocialHistoryById(int socHistoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        SocialHistories socHistory = (SocialHistories) session.get(SocialHistories.class, socHistoryId);

        session.getTransaction().commit();
        return socHistory;
    }

    public Permission getPermissionByid(int permissionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Permission sponsor = (Permission) session.get(Permission.class, permissionid);

        session.getTransaction().commit();
        return sponsor;
    }

    public Department getDepartmentByid(int departmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Department sponsor = (Department) session.get(Department.class, departmentid);

        session.getTransaction().commit();
        return sponsor;
    }

    public Patientconsultation getPatientConsultationByid(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Patientconsultation sponsor = (Patientconsultation) session.get(Patientconsultation.class, id);

        session.getTransaction().commit();
        return sponsor;
    }

    public Patientclerking getPatientClerking(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Patientclerking sponsor = (Patientclerking) session.get(Patientclerking.class, id);

        session.getTransaction().commit();
        return sponsor;
    }

    public Laborders getLaborders(String sponsorid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Laborders sponsor = (Laborders) session.get(Laborders.class, sponsorid);

        session.getTransaction().commit();
        return sponsor;
    }

    public Laborders getLabOrdersByOrderId(String orderId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Laborders sponsor = (Laborders) session.get(Laborders.class, orderId);

        session.getTransaction().commit();
        return sponsor;
    }

    public Qualification getQualification(int sponsorid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Qualification qualification = (Qualification) session.get(Qualification.class, sponsorid);

        session.getTransaction().commit();
        return qualification;
    }

    public Stafftable getStafftableByid(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Stafftable sponsor = (Stafftable) session.get(Stafftable.class, staffid);

        session.getTransaction().commit();
        return sponsor;
    }

    public Folder getPatientFolder(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Folder folder = (Folder) session.get(Folder.class, patientid);

        session.getTransaction().commit();
        return folder;
    }

    public Wardnote getWardnoteByid(int noteid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Wardnote wardnote = (Wardnote) session.get(Wardnote.class, noteid);

        session.getTransaction().commit();
        return wardnote;
    }

    public Transferlocation getTransferLocationByid(int symptomid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Transferlocation transferlocation = (Transferlocation) session.get(Transferlocation.class, symptomid);

        session.getTransaction().commit();
        return transferlocation;
    }

    public Units getUnit(int unitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Units units = (Units) session.get(Units.class, unitid);

        session.getTransaction().commit();
        return units;
    }

    public Users getUserById(String userid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Users user = (Users) session.get(Users.class, userid);

        session.getTransaction().commit();
        return user;
    }

    public Boolean findUserById(String userid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        boolean present = false;

        Users user = (Users) session.get(Users.class, userid);

        if (user != null) {
            present = true;
        }

        session.getTransaction().commit();
        return present;
    }

    public List getUserByStaffid(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List result = session.createQuery("from Users where staffid = '" + staffid + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public Loggingtable getLoggingtableByid(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Loggingtable loggingtable = (Loggingtable) session.get(Loggingtable.class, id);

        session.getTransaction().commit();
        return loggingtable;
    }

    public Diagnosis getId(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Diagnosis diagnosis = (Diagnosis) session.get(Diagnosis.class, id);

        session.getTransaction().commit();
        return diagnosis;
    }

    public Treatments getTreatment(int treatmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Treatments treatment = (Treatments) session.get(Treatments.class, treatmentid);

        session.getTransaction().commit();
        return treatment;
    }

    public Diagnosis getDiagnosis(int treatmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Diagnosis treatment = (Diagnosis) session.get(Diagnosis.class, treatmentid);

        session.getTransaction().commit();
        return treatment;
    }

    public Patienttreatment getPatientTreatment(int treatmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Patienttreatment treatment = (Patienttreatment) session.get(Patienttreatment.class, treatmentid);

        session.getTransaction().commit();
        return treatment;
    }

    public Investigation getInvestigation(int investigationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Investigation investigationObj = (Investigation) session.get(Investigation.class, investigationid);

        session.getTransaction().commit();
        return investigationObj;
    }

    public Ward getWardById(int wardid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Ward ward = (Ward) session.get(Ward.class, wardid);

        session.getTransaction().commit();
        return ward;
    }

    public Roletable getRoleByid(int roleid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Roletable roletable = (Roletable) session.get(Roletable.class, roleid);

        session.getTransaction().commit();
        return roletable;
    }

    public Dosagemonitor getDosageById(int dosageid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Dosagemonitor dosageMonitor = (Dosagemonitor) session.get(Dosagemonitor.class, dosageid);

        session.getTransaction().commit();
        return dosageMonitor;
    }

    public Symptoms getSymptomById(int symptomid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Symptoms symptoms = (Symptoms) session.get(Symptoms.class, symptomid);

        session.getTransaction().commit();
        return symptoms;
    }

    public DurationOptions getDurationById(int durationid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        DurationOptions duration = (DurationOptions) session.get(DurationOptions.class, durationid);

        session.getTransaction().commit();
        return duration;
    }

    public Dosagemonitor getDosageByVisitId(int treatmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Dosagemonitor dosageMonitor = (Dosagemonitor) session.createQuery("from dosagemonitor where visitid=" + treatmentid).list().get(0);

        session.getTransaction().commit();
        return dosageMonitor;
    }

    public Newborn getNewbornById(int symptomid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Newborn newborn = (Newborn) session.get(Newborn.class, symptomid);

        session.getTransaction().commit();
        return newborn;
    }

    public Visitationtable getVisitById(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Visitationtable newborn = (Visitationtable) session.get(Visitationtable.class, visitid);

        session.getTransaction().commit();
        return newborn;
    }

    public Consultingrooms getConsultingroom(int conroomid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Consultingrooms consultingrooms = (Consultingrooms) session.get(Consultingrooms.class, conroomid);

        session.getTransaction().commit();
        return consultingrooms;
    }

    public Itemtype getItemType(int typeid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Itemtype consultingrooms = (Itemtype) session.get(Itemtype.class, typeid);
        session.getTransaction().commit();
        return consultingrooms;
    }

    public Appoint getAppointmentById(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        System.out.println("in the code");
        Appoint appoint = (Appoint) session.get(Appoint.class, id);

        session.getTransaction().commit();
        return appoint;
    }

    public Newborn getNewbornByPatientVisitId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Newborn newborn = (Newborn) session.createQuery("from newborn where patientid=" + patientid).list().get(0);

        session.getTransaction().commit();
        return newborn;
    }

    /*public Patientconsultation getPatientConsultationByVisitid(int visitid) {
     session = HibernateUtil.getSessionFactory().getCurrentSession();
     session.beginTransaction();
    
     Patientconsultation patientconsultation = (Patientconsultation) session.createQuery("from patientconsultation where visitid=" + visitid);
    
     session.getTransaction().commit();
     return patientconsultation;
     }
     */
    public Admissionnotes getAdmissionNotebyId(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Admissionnotes dosageMonitor = (Admissionnotes) session.get(Admissionnotes.class, id);

        session.getTransaction().commit();
        return dosageMonitor;
    }

    public Consultation getConsultationId(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Consultation dosageMonitor = (Consultation) session.get(Consultation.class, id);
        //session.delete(dosageMonitor);
        session.getTransaction().commit();
        return dosageMonitor;
    }


    /*
     * Deleting items from the system
     */
    public InventoryItems deleteItem(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        InventoryItems itm = (InventoryItems) session.get(InventoryItems.class, id);
        session.delete(itm);
        session.getTransaction().commit();

        return itm;
    }

    public Post deleteSupplier(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Post itm = (Post) session.get(Post.class, id);
        session.delete(itm);
        session.getTransaction().commit();

        return itm;
    }

    public Receive deleteReceivers(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Receive itm = (Receive) session.get(Receive.class, id);
        session.delete(itm);
        session.getTransaction().commit();

        return itm;
    }

    public Ward deleteWard(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Ward ward = (Ward) session.get(Ward.class, id);
        session.delete(ward);
        session.getTransaction().commit();

        return ward;
    }

    public Clerkingquestion deleteClerking(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Clerkingquestion ward = (Clerkingquestion) session.get(Clerkingquestion.class, id);
        session.delete(ward);
        session.getTransaction().commit();

        return ward;
    }

    public ClerkingCategories deleteClerkingCategory(int categoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        ClerkingCategories category = (ClerkingCategories) session.get(ClerkingCategories.class, categoryId);
        session.delete(category);
        session.getTransaction().commit();

        return category;
    }

    public MedicalHistories deleteMedicalHistory(int medicalHistoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        MedicalHistories medHistory = (MedicalHistories) session.get(MedicalHistories.class, medicalHistoryId);
        session.delete(medHistory);
        session.getTransaction().commit();

        return medHistory;
    }

    public SocialHistories deleteSocialHistory(int socialHistoryId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        SocialHistories socialHistory = (SocialHistories) session.get(SocialHistories.class, socialHistoryId);
        session.delete(socialHistory);
        session.getTransaction().commit();

        return socialHistory;
    }

    public BodyPartOptions deleteBodyPartOption(int bodyPartOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        BodyPartOptions bodyPartOption = (BodyPartOptions) session.get(BodyPartOptions.class, bodyPartOptionId);
        session.delete(bodyPartOption);
        session.getTransaction().commit();

        return bodyPartOption;
    }

    

    public CharacteristicOptions deleteCharacteristicOption(int characteristicOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        CharacteristicOptions characteristicOption = (CharacteristicOptions) session.get(CharacteristicOptions.class, characteristicOptionId);
        session.delete(characteristicOption);
        session.getTransaction().commit();

        return characteristicOption;
    }

    public TreatmentOptions deleteTreatmentOption(int treatmentOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        TreatmentOptions treatmentOption = (TreatmentOptions) session.get(TreatmentOptions.class, treatmentOptionId);
        session.delete(treatmentOption);
        session.getTransaction().commit();

        return treatmentOption;
    }

    public ProblemOptions deleteProblemOption(int problemOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        ProblemOptions problemOption = (ProblemOptions) session.get(ProblemOptions.class, problemOptionId);
        session.delete(problemOption);
        session.getTransaction().commit();

        return problemOption;
    }

    public DurationOptions deleteDurationOption(int durationOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        DurationOptions durationOption = (DurationOptions) session.get(DurationOptions.class, durationOptionId);
        session.delete(durationOption);
        session.getTransaction().commit();

        return durationOption;
    }

    public OnsetOptions deleteOnsetOption(int onsetOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        OnsetOptions onsetOption = (OnsetOptions) session.get(OnsetOptions.class, onsetOptionId);
        session.delete(onsetOption);
        session.getTransaction().commit();

        return onsetOption;
    }

    public AggrevationOptions deleteAggrevationOption(int aggrevationOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        AggrevationOptions aggrevationOption = (AggrevationOptions) session.get(AggrevationOptions.class, aggrevationOptionId);
        session.delete(aggrevationOption);
        session.getTransaction().commit();

        return aggrevationOption;
    }

    public ReliefOptions deleteReliefOption(int reliefOptionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        ReliefOptions reliefOption = (ReliefOptions) session.get(ReliefOptions.class, reliefOptionId);
        session.delete(reliefOption);
        session.getTransaction().commit();

        return reliefOption;
    }

    public Clerkingquestion deleteQuestion(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Clerkingquestion question = (Clerkingquestion) session.get(Clerkingquestion.class, id);
        session.delete(question);
        session.getTransaction().commit();

        return question;
    }

    public Wardnote deleteWardNote(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Wardnote ward = (Wardnote) session.get(Wardnote.class, id);
        session.delete(ward);
        session.getTransaction().commit();

        return ward;
    }

    public Patient deletePatient(String id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Patient patient = (Patient) session.get(Patient.class, id);
        session.delete(patient);
        session.getTransaction().commit();

        return patient;
    }

    public Consultation deleteConsultation(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Consultation consultation = (Consultation) session.get(Consultation.class, id);
        session.delete(consultation);
        session.getTransaction().commit();

        return consultation;
    }

    public Dosagemonitor deleteDosagemonitor(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Dosagemonitor dosageMonitor = (Dosagemonitor) session.get(Dosagemonitor.class, id);
        session.delete(dosageMonitor);
        session.getTransaction().commit();

        return dosageMonitor;
    }

    public Symptoms deleteSymptom(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Symptoms symptoms = (Symptoms) session.get(Symptoms.class, id);
        session.delete(symptoms);
        session.getTransaction().commit();

        return symptoms;
    }

    public Laborders deleteLaborders(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Laborders symptoms = (Laborders) session.get(Laborders.class, id);
        session.delete(symptoms);
        session.getTransaction().commit();

        return symptoms;
    }

    public Units deleteUnit(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Units unit = (Units) session.get(Units.class, id);
        session.delete(unit);
        session.getTransaction().commit();

        return unit;
    }

    public Consultingrooms deleteConroom(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Consultingrooms unit = (Consultingrooms) session.get(Consultingrooms.class, id);
        session.delete(unit);
        session.getTransaction().commit();

        return unit;
    }

    public Roletable deleteRole(int roleid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Roletable roletable = (Roletable) session.get(Roletable.class, roleid);
        session.delete(roletable);
        session.getTransaction().commit();
        return roletable;
    }

    public Qualification deleteQualification(int roleid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Qualification qualification = (Qualification) session.get(Qualification.class, roleid);
        session.delete(qualification);
        session.getTransaction().commit();
        return qualification;
    }

    public Stafftable deleteStaff(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Stafftable stafftable = (Stafftable) session.get(Stafftable.class, staffid);
        //session.delete(stafftable);
        stafftable.setActive(Boolean.FALSE);
        session.getTransaction().commit();
        return stafftable;
    }

    public Stafftable activateStaff(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Stafftable stafftable = (Stafftable) session.get(Stafftable.class, staffid);
        //session.delete(stafftable);
        stafftable.setActive(Boolean.TRUE);
        session.getTransaction().commit();
        return stafftable;
    }

    public Permission deletePermission(int permissionid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Permission stafftable = (Permission) session.get(Permission.class, permissionid);
        session.delete(stafftable);
        session.getTransaction().commit();
        return stafftable;
    }

    public Department deleteDepartment(int departmentid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Department stafftable = (Department) session.get(Department.class, departmentid);
        session.delete(stafftable);

        session.getTransaction().commit();
        return stafftable;
    }

    public void deleteStaffPermissionWhereStaffid(int permid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        StaffPermission staffPermission = (StaffPermission) session.get(StaffPermission.class, permid);
        session.delete(staffPermission);
        session.getTransaction().commit();
        //return stafftable;
    }

    public void deleteStaffPermissionWherePermid(int permid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        StaffPermission stafftable = (StaffPermission) session.get(StaffPermission.class, permid);
        session.delete(stafftable);
        session.getTransaction().commit();
        //return stafftable;
    }

    public void deleteUser(String userid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Users user = (Users) session.get(Users.class, userid);
        session.delete(user);
        session.getTransaction().commit();
        //return stafftable;
    }

    public Appoint deleteAppointment(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Appoint app = (Appoint) session.get(Appoint.class, id);
        session.delete(app);
        session.getTransaction().commit();

        return app;
    }

    public void deleteUserByStaffid(String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Users user = (Users) session.createQuery("delete from Users where staffid = '" + staffid + "'");
        //session.delete(user);
        session.getTransaction().commit();
        //return stafftable;
    }

    public Boolean ifEmpty() {
        if (this == null) {
            return false;
        }
        return true;
    }

    /**
     * **
     * Nezer Sept 22th Sept 2012 *
     */
    public List listPatientVisits(String patientId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientid ='" + patientId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientPreviousVisits(String patientId, int curVisitId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where patientid ='" + patientId + "' "
                + "and visitid != '" + curVisitId + "' order by visitid desc").list();
        session.getTransaction().commit();
        return result;
    }

    public List getPatientConsultationByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        Query query = session.createQuery("from Patientconsultation where visitid = :code ");
        query.setParameter("code", visitid);
        List list = query.list();

        session.getTransaction().commit();
        System.out.println("size of list : " + list.size());
        return list;
    }

    public List getPatientTreatmentByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        Query query = session.createQuery("from Patienttreatment where visitationid = :code ");
        query.setParameter("code", visitid);
        List list = query.list();

        session.getTransaction().commit();
        return list;
    }

    public List getPatientInvestigatonsByVisitid(int visitid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        Query query = session.createQuery("from Patientinvestigation where visitationid = :code ");
        query.setParameter("code", visitid);
        List list = query.list();

        session.getTransaction().commit();
        return list;
    }

    public List listAllPatientVisitsForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where date = '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientVisitsForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable where date between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientVisits() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Visitationtable").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientsOfSponsor(String sponsorId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorhipdetails where sponsorid = '" + sponsorId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Labtypes addLabType(String name, String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Labtypes labType = new Labtypes();
        labType.setLabType(name);
        labType.setLabCode(code);

        session.save(labType);
        session.getTransaction().commit();
        return labType;
    }

    public Labtypes deleteLabType(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Labtypes unit = (Labtypes) session.get(Labtypes.class, id);
        session.delete(unit);
        session.getTransaction().commit();

        return unit;
    }

    public Labtypes deactivateLabType(int id, int active) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        Labtypes unit = (Labtypes) session.get(Labtypes.class, id);
        unit.setActive(active);
        session.update(unit);
        session.getTransaction().commit();

        return unit;
    }

    public Labtypes updateLabType(int uid, String code, String uname) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Labtypes wardnote = (Labtypes) session.get(Labtypes.class, uid);
        wardnote.setLabType(uname);
        wardnote.setLabCode(code);

        session.update(wardnote);
        session.getTransaction().commit();
        return wardnote;
    }

    public List listLabTypes() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Labtypes order by order_num").list();
        session.getTransaction().commit();
        return result;
    }

    public Investigation createDetailedInvestigation(String code, String name, double rate, String lowBound, String highBound, int labTypeId, int typeOfTestId, int groupUnderId, String units,
            String interpretation, String defaultValue, String rangeFrom,
            String rangeUpTo, String comments, String reportCollDays, Date reportCollTime,
            boolean resultOptions, String referenceType, boolean hasantibiotic, double nhisrate, int specimen, boolean isSubheading) throws Exception {
        System.out.println("we wre here at last and finaaly");
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Investigation detailedInv = new Investigation();
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
        detailedInv.setAntibiotic(hasantibiotic);
        detailedInv.setSpecimenId(specimen);
        detailedInv.setNhisRate(nhisrate);
        detailedInv.setIsSubheading(isSubheading);
        session.save(detailedInv);

        session.getTransaction().commit();
        return detailedInv;
    }

    // associate lab type with main investigation
    public LabtypeDetailedinv addLabTypeMainTest(int labTypeId, int mainTestId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabtypeDetailedinv labTypeMainTest = new LabtypeDetailedinv();
        labTypeMainTest.setLabtypeId(labTypeId);
        labTypeMainTest.setDetailedInvId(mainTestId);
        session.save(labTypeMainTest);
        session.getTransaction().commit();
        return labTypeMainTest;
    }

    // associate main investigation with sub investigation
    public MaininvSubinv addMainTestSubTest(int mainTestId, int subTestId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        MaininvSubinv mainInvSubInv = new MaininvSubinv();
        mainInvSubInv.setMaininvId(mainTestId);
        mainInvSubInv.setSubinvId(subTestId);
        session.save(mainInvSubInv);
        session.getTransaction().commit();
        return mainInvSubInv;
    }

    public PossibleinvResults addPosInvResult(String result) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PossibleinvResults posinvResult = new PossibleinvResults();
        posinvResult.setPosinvResult(result);

        session.save(posinvResult);
        session.getTransaction().commit();
        return posinvResult;
    }

    public DetailedinvPosinvresults addDetInvPosResult(int detailedInvId, int posResultId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DetailedinvPosinvresults detInvPosResult = new DetailedinvPosinvresults();
        detInvPosResult.setDetailedinvId(detailedInvId);
        detInvPosResult.setPosinvresultId(posResultId);
        session.save(detInvPosResult);
        session.getTransaction().commit();
        return detInvPosResult;
    }

    public Investigation updateDetailedInvestigation(int labid, String code, String name, double rate, String lowBound, String highBound, int labTypeId, int typeOfTestId, int groupUnderId, String units,
            String interpretation, String defaultValue, String rangeFrom,
            String rangeUpTo, String comments, String reportCollDays, Date reportCollTime,
            boolean resultOptions, String referenceType, boolean hasantibiotic, double nhisrate, int specimen, boolean isSubheading) throws Exception {
        System.out.println("we wre here at last and finaaly");
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Investigation detInv = (Investigation) session.get(Investigation.class, labid);
        DateFormat formatter;
        Date date;
//        formatter = new SimpleDateFormat("yyyy-MM-dd");
//        date = (Date) formatter.parse(dob);
        detInv.setCode(code);
        detInv.setName(name);
        detInv.setRate(rate);
        detInv.setLowBound(lowBound);
        detInv.setHighBound(highBound);
        detInv.setLabTypeId(labTypeId);
        detInv.setTypeOfTestId(typeOfTestId);
        detInv.setGroupedUnderId(groupUnderId);
        detInv.setUnits(units);
        detInv.setInterpretation(interpretation);
        detInv.setDefaultValue(defaultValue);
        detInv.setRangeFrom(rangeFrom);
        detInv.setRangeUpTo(rangeUpTo);
        detInv.setComments(comments);
        detInv.setReportCollDays(reportCollDays);
        detInv.setReportCollTime(reportCollTime);
        detInv.setResultOptions(resultOptions);
        detInv.setRefRangeType(referenceType);
        detInv.setAntibiotic(hasantibiotic);
        detInv.setSpecimenId(specimen);
        detInv.setIsSubheading(isSubheading);
        detInv.setNhisRate(nhisrate);
        session.update(detInv);

        session.getTransaction().commit();
        return detInv;
    }

    public List listLabTypeDetailedInv(int labTypeId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabtypeDetailedinv where labtype_id = '" + labTypeId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public Investigation getDetailedInvById(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Investigation detInv = (Investigation) session.get(Investigation.class, id);

        session.getTransaction().commit();
        return detInv;
    }

    public LabtypeDetailedinv getLabtypeDetailedinvByIds(int labTypeId, int detailedInvId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        LabtypeDetailedinv labTypeDetailedInv = (LabtypeDetailedinv) session.createQuery("from labtype_detailedinv where labtype_id =" + labTypeId + " and detailed_inv_id =" + detailedInvId);

        session.getTransaction().commit();
        return labTypeDetailedInv;
    }

    public List listLabtypeDetailedinvId(int detailedInvId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List result = session.createQuery("from LabtypeDetailedinv where detailed_inv_id =" + detailedInvId).list();

        session.getTransaction().commit();
        return result;
    }

    public List listAllDetailedInvestigation() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation").list();
        session.getTransaction().commit();
        return result;
    }

    public List listMainInvestigation() {
        int typeOfTestId = 1;
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation where type_of_test_id = '" + typeOfTestId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientDiagnosisForVisit(String patientId, int visitId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientdiagnosis where patientid = '" + patientId + "' and visitationid = '" + visitId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientDiagnosisByVisit(int visitId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientdiagnosis where visitationid = " + visitId).list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientLabForVisit(String patientId, int visitId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where patientid = '" + patientId + "' and visitationid = '" + visitId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listPatientTreatmentForVisit(String patientId, int visitId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patienttreatment where patientid = '" + patientId + "' and visitationid = '" + visitId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    /**
     * Nezer 10th Oct
     */
    public PatientRegistration addPatientReg(String patientId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientRegistration pR = new PatientRegistration();
        pR.setPatientId(patientId);
        pR.setAmountPaid(0);
        pR.setPaymentStatus(false);
        pR.setCopaid(Boolean.FALSE);
        pR.setPersonallySupported(Boolean.FALSE);
        pR.setSecondaryPayment(0.0);
        pR.setPersonalSupportAmount(0.0);
        pR.setDatePaid(new java.sql.Date(new java.util.Date().getTime()));
        session.save(pR);
        session.getTransaction().commit();
        return pR;
    }

    public List listDetailedInvPosResults(int detailedInvId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DetailedinvPosinvresults where detailedinv_id = '" + detailedInvId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public PossibleinvResults getPossibleInvResultById(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        PossibleinvResults posInvResult = (PossibleinvResults) session.get(PossibleinvResults.class, id);
        //session.delete(dosageMonitor);
        session.getTransaction().commit();
        return posInvResult;
    }

    public Post getPost(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Post posInvResult = (Post) session.get(Post.class, id);
        session.delete(posInvResult);
        session.getTransaction().commit();
        return posInvResult;
    }

    public LabtypeDetailedinv deleteLabTypeMain(int labidtype) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        LabtypeDetailedinv posInvResult = (LabtypeDetailedinv) session.get(LabtypeDetailedinv.class, labidtype);
        session.delete(posInvResult);
        session.getTransaction().commit();
        return posInvResult;
    }

    public DetailedinvPosinvresults deletePossibleResult(int labidtype) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        DetailedinvPosinvresults posInvResult = (DetailedinvPosinvresults) session.get(DetailedinvPosinvresults.class, labidtype);
        session.delete(posInvResult);
        session.getTransaction().commit();
        return posInvResult;
    }

    public List getPatientReg(String patientId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientRegistration where patient_id = '" + patientId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public PatientRegistration updatePReg(int pRId, boolean paymentStatus, double amountPaid, java.sql.Date datePaid, int regId, boolean copaid, boolean isPrivateSupport, double secondarySupport, double privateSupport) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        PatientRegistration pReg = (PatientRegistration) session.get(PatientRegistration.class, pRId);

        pReg.setAmountPaid(amountPaid);
        pReg.setPaymentStatus(paymentStatus);
        pReg.setDatePaid(datePaid);
        pReg.setCopaid(copaid);
        pReg.setPersonallySupported(isPrivateSupport);
        pReg.setSecondaryPayment(secondarySupport);
        pReg.setPersonalSupportAmount(privateSupport);
        session.update(pReg);
        session.getTransaction().commit();
        return pReg;
    }
    
    
    public List listPatientRegistrationsByPatientId(String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientRegistration where patient_id = '" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientRegsForDate(Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientRegistration where date_paid = '" + specificDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientRegsForDuration(Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientRegistration where date_paid between '" + startDate + "' and '" + endDate + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllPatientRegs() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PatientRegistration").list();
        session.getTransaction().commit();
        return result;
    }

    // 10/9/2012 
    public String getQueryDate() {
        String queryDate;

        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Calendar cal = Calendar.getInstance();

        queryDate = dateFormat.format(cal.getTime());
        System.out.println(queryDate);

        return queryDate;
    }

    public String getAgeDifference(String doB) {
        String today = getQueryDate();
        String age;
        //age = "";

        today = today.replace("/", "-");
        String splittedToday[] = today.split("-");
        String splittedDob[] = doB.split("-");

        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();

        cal1.set(Integer.parseInt(splittedDob[0]), Integer.parseInt(splittedDob[1]), Integer.parseInt(splittedDob[2]));
        cal2.set(Integer.parseInt(splittedToday[2]), Integer.parseInt(splittedToday[0]), Integer.parseInt(splittedToday[1]));

        long milis1 = cal1.getTimeInMillis();
        long milis2 = cal2.getTimeInMillis();

        long diff = milis2 - milis1;

        long diffDays = diff / (24 * 60 * 60 * 1000);

        int days = 360;
        long years = diffDays / days;
        age = years + "";

        return age;
    }

    public List getPatientSponsor(String patientId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Sponsorhipdetails where patientid = '" + patientId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public NursingtableVitals addNursingTableVitals(int visitId, String nurseId, String docId, Date time) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        NursingtableVitals nV = new NursingtableVitals();
        nV.setVisitId(visitId);
        nV.setStaffId(nurseId);
        nV.setDocId(docId);
        nV.setTime(new java.sql.Date(new java.util.Date().getTime()));
        session.save(nV);
        session.getTransaction().commit();
        return nV;
    }

    public DetailedinvRefrangeType addDetailedInvRefRangeType(int detailedInvId, String refRangeType) throws Exception {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        DetailedinvRefrangeType dIRefRangeT = new DetailedinvRefrangeType();


        dIRefRangeT.setDetailedinvId(detailedInvId);
        dIRefRangeT.setRefRangeType(refRangeType);

        session.save(dIRefRangeT);

        session.getTransaction().commit();
        return dIRefRangeT;
    }

    public RefRangeUni addUniversalRefRange(int detailedInvRefId, int selected, String lowerRef, String upperRef, String paragraphic) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        RefRangeUni uRefRange = new RefRangeUni();
        uRefRange.setDetailedinvRefrangeTypeId(detailedInvRefId);
        uRefRange.setSelected(selected);
        uRefRange.setLowerRefRange(lowerRef);
        uRefRange.setUpperRefRange(upperRef);
        uRefRange.setParagraphic(paragraphic);
        session.save(uRefRange);
        session.getTransaction().commit();
        return uRefRange;
    }

    public RefRangeUni deleteUniversalResult(int labidtype) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        RefRangeUni posInvResult = (RefRangeUni) session.get(RefRangeUni.class, labidtype);
        session.delete(posInvResult);
        session.getTransaction().commit();
        return posInvResult;
    }

    public RefRangeDet deleteDetailResult(int labidtype) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        RefRangeDet posInvResult = (RefRangeDet) session.get(RefRangeDet.class, labidtype);
        session.delete(posInvResult);
        session.getTransaction().commit();
        return posInvResult;
    }

    public RefRangeDet addDetailedRefRange(int detailedInvRefId, String from, String to, String mlowerRef, String mupperRef, String flowerRef, String fUpperRef) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        RefRangeDet detRefRange = new RefRangeDet();
        detRefRange.setDetailedinvRefrangeTypeId(detailedInvRefId);
        detRefRange.setDetFrom(from);
        detRefRange.setDetTo(to);
        detRefRange.setMLower(mlowerRef);
        detRefRange.setMUpper(mupperRef);
        detRefRange.setFLower(flowerRef);
        detRefRange.setFUpper(fUpperRef);


        System.out.println(detailedInvRefId + "" + from + " " + to + " " + mlowerRef + " " + mupperRef + " " + flowerRef + " " + fUpperRef);
        session.save(detRefRange);
        session.getTransaction().commit();
        return detRefRange;
    }

    public List listSubInvUnderMainInv(int mainInvId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation where grouped_under_id =" + mainInvId + " order by order_num").list();
        session.getTransaction().commit();
        return result;
    }

    public List listInvsUnderLabType(int labTypeId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation where lab_type_id =" + labTypeId).list();
        session.getTransaction().commit();
        return result;
    }

    public List getNursingVitalsInfo(int visitId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from NursingtableVitals where visit_id = '" + visitId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List getUniRefRangeByDetInvId(int detInvId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from RefRangeUni where detailedinv_refrange_type_id='" + detInvId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List getDetRefRangeByDetInvId(int detInvId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from RefRangeDet where detailedinv_refrange_type_id='" + detInvId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List getDetRefRangeByDetInvIdDetails(int detInvId, int detfrom, int detto) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from RefRangeDet where detailedinv_refrange_type_id='" + detInvId + "' and det_from < " + detfrom + " and det_to > " + detto).list();
        session.getTransaction().commit();
        return result;
    }

    /**
     *
     * Nezer Nov 10
     */
    public LabStockPackaging addLabStockPackaging(String name, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockPackaging labStockP = new LabStockPackaging();
        labStockP.setName(name);
        labStockP.setStatus(status);

        session.save(labStockP);
        session.getTransaction().commit();
        return labStockP;
    }

    public LabStockDistributor addLabStockDistributor(String name, String conPerson, String num, String loc) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockDistributor labStockD = new LabStockDistributor();
        labStockD.setName(name);
        labStockD.setContactPerson(conPerson);
        labStockD.setPhone(num);
        labStockD.setLocation(loc);

        session.save(labStockD);
        session.getTransaction().commit();
        return labStockD;
    }

    public LabStockItem addLabStockItem(String code, String name, int reOrderLevel, String markUp, int emegencyLevel, int maximumLevel, String userId, Date addedTime) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItem labStockD = new LabStockItem();
        labStockD.setId(code);
        labStockD.setName(name);
        labStockD.setReOrderLevel(reOrderLevel);
        labStockD.setEmergencyStockLevel(emegencyLevel);
        labStockD.setMarkUp(markUp);
        labStockD.setMaximumStockLevel(maximumLevel);
        labStockD.setStaffId(userId);
        labStockD.setDateAdded(addedTime);
        labStockD.setQuantity(0);
        session.save(labStockD);
        session.getTransaction().commit();
        return labStockD;
    }

    public LabStock addLabStock(String batchNo, int distributor, String itemId, Date manuDate, int qty, Date expiry, double unitPrice, double total, String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStock labStockD = new LabStock();
        labStockD.setBatchNumber(batchNo);
        labStockD.setDateAdded(new Date());
        labStockD.setExpiryDate(expiry);
        labStockD.setItemId(itemId);
        labStockD.setLabStockItemDistributorId(distributor);
        labStockD.setManufactureDate(manuDate);
        labStockD.setQty(qty);
        labStockD.setStaffId(staffid);
        labStockD.setTotalPrice(total);
        labStockD.setUnitPrice(unitPrice);
        session.save(labStockD);
        session.getTransaction().commit();
        return labStockD;
    }

    public LabStock updateLabStock(String batchNo, int distributor, String itemId, Date manuDate, int qty, Date expiry, double unitPrice, double total, String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStock labStockD = (LabStock) session.get(LabStock.class, batchNo);
        labStockD.setBatchNumber(batchNo);
        labStockD.setDateAdded(new Date());
        labStockD.setExpiryDate(expiry);
        labStockD.setItemId(itemId);
        labStockD.setLabStockItemDistributorId(distributor);
        labStockD.setManufactureDate(manuDate);
        labStockD.setQty(qty);
        labStockD.setStaffId(staffid);
        labStockD.setTotalPrice(total);
        labStockD.setUnitPrice(unitPrice);
        session.update(labStockD);
        session.getTransaction().commit();
        return labStockD;
    }

    public void deleteLabStock(String batchno) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStock labStockD = (LabStock) session.get(LabStock.class, batchno);
        session.delete(labStockD);
        session.getTransaction().commit();

    }

    public LabStockItem updateLabStockItem(String code, String name, int reOrderLevel, String markUp, int emegencyLevel, int maximumLevel) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItem labStockD = (LabStockItem) session.get(LabStockItem.class, code);
        labStockD.setId(code);
        labStockD.setName(name);
        labStockD.setReOrderLevel(reOrderLevel);
        labStockD.setEmergencyStockLevel(emegencyLevel);
        labStockD.setMarkUp(markUp);
        labStockD.setMaximumStockLevel(maximumLevel);

        session.update(labStockD);
        session.getTransaction().commit();
        return labStockD;
    }

    public void updateLabStockItemQty(String code, int qty) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItem labStockItem = (LabStockItem) session.get(LabStockItem.class, code);
        labStockItem.setQuantity(qty);
        session.update(labStockItem);
        session.getTransaction().commit();
    }

    public void deleteLabStockItem(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItem labStockItem = (LabStockItem) session.get(LabStockItem.class, code);
        session.delete(labStockItem);
        session.getTransaction().commit();
    }

    public LabStockItem getLabStockItem(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItem labStockItem = (LabStockItem) session.get(LabStockItem.class, code);
        //session.delete(labStockItem);
        session.getTransaction().commit();
        return labStockItem;
    }

    public LabStock getLabStock(String code) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStock labStockItem = (LabStock) session.get(LabStock.class, code);
        //session.delete(labStockItem);
        session.getTransaction().commit();
        return labStockItem;
    }

    public List listLabStockItems() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStockItem").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabStocks() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStock").list();
        session.getTransaction().commit();
        return result;
    }

    public java.sql.Date convertStringToSqlDate(String text) {
        System.out.println("text : " + text);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
        java.util.Date utilDate;
        java.sql.Date returnedSqlDate = null;

        String splitted[] = text.split("-");
        String specificDate = splitted[2] + "/" + splitted[1] + "/" + splitted[0];
        try {
            utilDate = formatter.parse(specificDate);
            returnedSqlDate = new java.sql.Date(utilDate.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(HMSHelper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return returnedSqlDate;
    }

    public Date convertStringToUtilDate(String text) {

        System.out.println("text : " + text);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
        java.util.Date utilDate = null;
        java.sql.Date returnedSqlDate = null;

        String splitted[] = text.split("-");
        String specificDate = splitted[2] + "/" + splitted[1] + "/" + splitted[0];
        try {
            utilDate = formatter.parse(specificDate);
            //       returnedUtilDate = utilDate.getTime();
        } catch (ParseException ex) {
            Logger.getLogger(HMSHelper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (Date) utilDate;
    }

//      public LabStockItemDistributor getLabStockItemDistributorByIds(int itemId, int distId) {
//        session = HibernateUtil.getSessionFactory().getCurrentSession();
//        session.beginTransaction();
//
//        LabStockItemDistributor lsid = (LabStockItemDistributor) session.createQuery("from LabStockItemDistributor where item_id =" + itemId + " and distributor_id =" + distId);
//
//        session.getTransaction().commit();
//        return lsid;
//    }
    public List listLabStockItemDistributorByIds(int itemId, int distId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStockItemDistributor where item_id =" + itemId + " and distributor_id =" + distId).list();
        session.getTransaction().commit();
        return result;
    }

    public LabStockItemDistributor addLabStockItemDistributor(int itemId, int posResultId, double curLev, double spentLev, double totLev) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItemDistributor lsid = new LabStockItemDistributor();
        lsid.setItemId(itemId);
        lsid.setDistributorId(posResultId);
        lsid.setCurrentLevel(curLev);
        lsid.setSpentLevel(spentLev);
        lsid.setTotalLevel(totLev);
        session.save(lsid);
        session.getTransaction().commit();
        return lsid;
    }

    public List listLabStockItemById(int itemId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStockItem where id =" + itemId).list();
        session.getTransaction().commit();
        return result;
    }

    public List listStockLabItemBatchInfo() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStockItemBatchInfo").list();
        session.getTransaction().commit();
        return result;
    }

    public LabStockItemBatchInfo addStockLabItemBatchInfo(int itemId, String batchNum, double startQty, Date endQty, String batchInUse) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabStockItemBatchInfo libi = new LabStockItemBatchInfo();
        libi.setItemId(itemId);
        libi.setBatchNum(batchNum);
        libi.setStartQty(startQty);
        libi.setStartDate(endQty);
        libi.setStaffId(batchInUse);
        session.save(libi);
        session.getTransaction().commit();
        return libi;
    }

    public List listStockItemDistributorsByItemId(int itemId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStockItemDistributor where item_id='" + itemId + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public List listLabStockDistributorById(int itemId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabStockDistributor where id =" + itemId).list();
        session.getTransaction().commit();
        return result;
    }

    public List listAppointmentTypes() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from AppointmentType").list();
        session.getTransaction().commit();
        return result;
    }

    public AppointmentType addAppointmentType(String name, String description, String staffId, Date dateAdded) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        AppointmentType apType = new AppointmentType();
        apType.setName(name);
        apType.setDescription(description);
        apType.setStaffId(staffId);
        apType.setDateAdded(dateAdded);
        session.save(apType);
        session.getTransaction().commit();
        return apType;


    }

    public AppointmentType deleteAppointmentType(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        //   Query result = session.createQuery("delete from InventoryItems where items_id = "+id);
        AppointmentType app = (AppointmentType) session.get(AppointmentType.class, id);
        session.delete(app);
        session.getTransaction().commit();

        return app;
    }

    public AppointmentType updateAppointmentType(int id, String name, String description) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        AppointmentType app = (AppointmentType) session.get(AppointmentType.class, id);

        app.setDescription(description);
        app.setName(name);

        session.update(app);
        session.getTransaction().commit();
        return app;
    }

    public List listScheduledAppointments(int unit) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Appoint where honored =" + unit).list();
        System.out.println("result.size : " + result.size());
        session.getTransaction().commit();
        return result;


    }

    public Appointment addNewAppointment(String patientId, String title, String detail, String start, String end,
            String allDay, String status, String staffId, Timestamp timeAdded, Date dateAdded) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Appointment app = new Appointment();
        app.setPatientId(patientId);
        app.setTitle(title);
        app.setDetail(detail);
        app.setStart(start);
        app.setEnd(end);
        app.setAllday(allDay);
        app.setStatus(status);
        app.setStaffId(staffId);
        app.setTimeAdded(timeAdded);
        app.setDateAdded(dateAdded);

        session.save(app);
        session.getTransaction().commit();
        return app;


    }

    public List listMainInvsUnderLabType(int labTypeId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Investigation where lab_type_id =" + labTypeId + " and type_of_test_id = 1 order by order_num").list();
        session.getTransaction().commit();
        return result;
    }

    public Labtypes getLabTypeByid(int id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Labtypes lt = (Labtypes) session.get(Labtypes.class, id);

        session.getTransaction().commit();
        return lt;
    }

    public Labtypes updateLabTypeOrderNum(int ltId, int newOrderNum) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Labtypes lt = (Labtypes) session.get(Labtypes.class, ltId);
        lt.setOrderNum(newOrderNum);

        session.update(lt);
        session.getTransaction().commit();
        return lt;
    }

    public Investigation updateInvOrderNum(int ltId, int newOrderNum) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Investigation lt = (Investigation) session.get(Investigation.class, ltId);
        lt.setOrderNum(newOrderNum);

        session.update(lt);
        session.getTransaction().commit();
        return lt;
    }

    // nezer 17th Dec
    public List listLabtypeDetailedinvByDetailedInvId(int invId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabtypeDetailedinv where detailed_inv_id = " + invId).list();
        session.getTransaction().commit();
        return result;
    }

    // key value map operations
    public int getTypeKey(String type, TreeMap<Integer, String> map) {
        int key = 0;
        for (Map.Entry<Integer, String> entry : map.entrySet()) {
            //     System.out.println("entry.getValue : " + entry.getValue() + " " + type + " " + entry.getKey());
            if (entry.getValue().equals(type)) {
                key = entry.getKey();
                break;
            }
        }
        //   System.out.println("key : " + key);
        return key;
    }

    public Patientinvestigation getPatInvInstance(int objectId, TreeMap<Integer, Patientinvestigation> map) {
        Patientinvestigation inv = new Patientinvestigation();
        for (Map.Entry<Integer, Patientinvestigation> entry : map.entrySet()) {
            // System.out.println("entry.getKey : " + entry.getKey() + " teach " + entry.getValue());
            if (entry.getKey() == objectId) {
                inv = entry.getValue();
                break;
            }
        }
        return inv;
    }

    public List listLabTypeDetailedInvs(int labTypeId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabtypeDetailedinv where labtype_id =" + labTypeId).list();
        session.getTransaction().commit();
        return result;
    }

    public RegFee addRegFee(double regFee, String userId, Timestamp timeAdded, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        RegFee rF = new RegFee();
        rF.setRegFee(regFee);
        rF.setUserId(userId);
        rF.setDateAdded(timeAdded);
        rF.setStatus(status);

        session.save(rF);
        session.getTransaction().commit();
        return rF;
    }

    
    
    public List listRegFees() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from RegFee").list();
        session.getTransaction().commit();
        return result;
    }
    
    
     

    public RegFee updateRegFee(int uid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        RegFee rF = (RegFee) session.get(RegFee.class, uid);
        rF.setStatus(status);
        session.update(rF);
        session.getTransaction().commit();
        return rF;
    }

    public List listCurrentRegFee(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from RegFee where status ='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }
    
    
    
    
    public CardFee addCardFee(double cardFee, String userId, Timestamp timeAdded, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        CardFee rF = new CardFee();
        rF.setCardFee(cardFee);
        rF.setUserId(userId);
        rF.setDateAdded(timeAdded);
        rF.setStatus(status);

        session.save(rF);
        session.getTransaction().commit();
        return rF;
    }

    
    
    public List listCardFees() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CardFee").list();
        session.getTransaction().commit();
        return result;
    }
    
    
     

    public CardFee updateCardFee(int uid, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        CardFee rF = (CardFee) session.get(CardFee.class, uid);
        rF.setStatus(status);
        session.update(rF);
        session.getTransaction().commit();
        return rF;
    }

    public List listCurrentCardFee(String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from CardFee where status ='" + status + "'").list();

        session.getTransaction().commit();
        return result;
    }

    public PatientRegistration updatePatientRegistration(int patRegId, boolean paymentStatus, double amPaid, Date datePaid, int regId, boolean copaid, boolean isPrivateSupport, double secondarySupport, double privateSupport) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientRegistration pReg = (PatientRegistration) session.get(PatientRegistration.class, patRegId);

        pReg.setPaymentStatus(paymentStatus);
        pReg.setAmountPaid(amPaid);
        pReg.setDatePaid(datePaid);
        pReg.setRegFeeId(regId);
        pReg.setCopaid(copaid);
        pReg.setPersonallySupported(isPrivateSupport);
        pReg.setSecondaryPayment(secondarySupport);
        pReg.setPersonalSupportAmount(privateSupport);
        session.update(pReg);
        session.getTransaction().commit();
        return pReg;
    }
    
    
     public PatientRegistration updatePatientRegistration(int patRegId, boolean paymentStatus) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        PatientRegistration pReg = (PatientRegistration) session.get(PatientRegistration.class, patRegId);
        pReg.setPaymentStatus(paymentStatus);
        session.update(pReg);
        session.getTransaction().commit();
        return pReg;
    }

    public List listAllLabPatients() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabPatient").list();
        session.getTransaction().commit();
        return result;
    }

    // Nezer 30th Dec
    public LabAntibiotic addLabAntibiotic(String name) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabAntibiotic antibiotic = new LabAntibiotic();
        antibiotic.setName(name);

        session.save(antibiotic);
        session.getTransaction().commit();
        return antibiotic;
    }

    public LabAntibiotic updateLabAntibiotic(int labAntiId, int newOrderNum) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabAntibiotic lt = (LabAntibiotic) session.get(LabAntibiotic.class, labAntiId);
        lt.setOrderNum(newOrderNum);
        session.update(lt);
        session.getTransaction().commit();
        return lt;
    }

    public LabAntibiotic updateLabAntibiotic(int labAntiId, String antibiotic) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabAntibiotic lt = (LabAntibiotic) session.get(LabAntibiotic.class, labAntiId);
        lt.setName(antibiotic);
        session.update(lt);
        session.getTransaction().commit();
        return lt;
    }

    public List listLabAntibiotics() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabAntibiotic order by order_num").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllAntibiotics() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from LabAntibiotic").list();
        session.getTransaction().commit();
        return result;
    }

    public List listAllSpecimen() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Specimen").list();
        session.getTransaction().commit();
        return result;
    }

    public InvestigationAntibiotic addInvAntibiotic(int invId, int antibioticId, String status) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        InvestigationAntibiotic invAntibiotic = new InvestigationAntibiotic();
        invAntibiotic.setInvId(invId);
        invAntibiotic.setAntibioticId(antibioticId);
        invAntibiotic.setStatus(status);
        session.save(invAntibiotic);
        session.getTransaction().commit();
        return invAntibiotic;
    }

    public Patientinvestigation getPatientInvById(int invId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Patientinvestigation treatment = (Patientinvestigation) session.get(Patientinvestigation.class, invId);
        session.getTransaction().commit();
        return treatment;
    }

    public LabAntibiotic getLabAntibiotic(int invId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        LabAntibiotic treatment = (LabAntibiotic) session.get(LabAntibiotic.class, invId);
        session.getTransaction().commit();
        return treatment;
    }

    public List listPatientInvByInvIdNOrderId(int invId, String orderId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Patientinvestigation where investigationid = " + invId + " and orderid = '" + orderId + "'").list();
        session.getTransaction().commit();
        return result;
    }
    // Start  Nezer 27th January

    public List listLabordersByStatusNPatientid(String status, String patientid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done ='" + status + "' and patientid = '" + patientid + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List listLabordersByStatusNOrderId(String status, String orderId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from Laborders where done ='" + status + "' and orderid = '" + orderId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    // End  Nezer 27th January
    public List listAllPossibleResults() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from DetailedinvPosinvresults").list();
        session.getTransaction().commit();
        return result;
    }

    // Start Nezer 5th July
    public static java.sql.Timestamp getCurrentTimestamp() {
        return new java.sql.Timestamp((new java.util.Date().getTime()));
    }

    public static java.sql.Time getCurrentTime() {
        return new java.sql.Time((new java.util.Date().getTime()));
    }

    public static java.sql.Date getCurrentDate() {
        return new java.sql.Date((new java.util.Date().getTime()));
    }

    public PaymentObject addPaymentObject(PaymentObject paymentObject) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        session.save(paymentObject);
        session.getTransaction().commit();
        return paymentObject;
    }

    public List getPatientTransactionPayments(String transactionId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where transaction_id = '" + transactionId + "'").list();
        session.getTransaction().commit();
        return result;
    }

    public List getPatientTransactionPaymentsByStaff(String transactionId, String staffid) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where transaction_id = '" + transactionId + "' and staff_id = '" + staffid + "' ").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> getPaymentObjectByTransactionIdTransactionTypeItemId(String transactionId, String transactionType, int itemId) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where "
                + "transaction_id = '" + transactionId + "' and transaction_type = '" + transactionType + "' and item_id = '" + itemId + "' ").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> listAllPayments() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> listAllPaymentsMade() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where transaction_type='Lab Payment Outstanding'").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> listAllPaymentsMadeFromTo() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where transaction_type='Lab Payment Outstanding").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> getPaymentObjectOfSponsor(String sponsorshipType, String sponsorId, String problem) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery(""
                + "from PaymentObject where '" + sponsorshipType + " = '" + sponsorId + "' and '" + problem + "' > 0").list();
        session.getTransaction().commit();
        System.out.println("result.size : " + result.size());
        return result;
    }

    public GeneralSettings getGeneralSettingByName(String name) {
        GeneralSettings setting = null;
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from GeneralSettings where name = '" + name + "'").list();
        if (result != null && result.size() > 0) {
            setting = (GeneralSettings) result.get(0);
        }
        session.getTransaction().commit();
        return setting;
    }

    public GeneralSettings addGeneralSetting(GeneralSettings genSetting) throws ParseException {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();


        session.save(genSetting);
        session.getTransaction().commit();
        return genSetting;
    }

    public GeneralSettings updateGeneralSetting(GeneralSettings genSetting) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        //Wardnote wardnote = (Wardnote) session.get(Wardnote.class, noteid);
        //wardnote.setNote(note);

        session.update(genSetting);
        session.getTransaction().commit();
        return genSetting;
    }

    public Investigation updateDetailedInvestigation(Investigation inv) throws Exception {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        session.update(inv);

        session.getTransaction().commit();
        return inv;
    }

    // Nezer 22nd August 2013
    public List<PaymentObject> listLabPaymentsByStaffForDate(String staffId, Date specificDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where date_paid = '" + specificDate + "' and staff_id = '" + staffId + "' ").list();
        session.getTransaction().commit();
        return result;
    }

    public List<PaymentObject> listLabPaymentsByStaffForDuration(String staffId, Date startDate, Date endDate) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List result = session.createQuery("from PaymentObject where date_paid between '" + startDate + "' and '" + endDate + "' and staff_id = '" + staffId + "' ").list();
        session.getTransaction().commit();
        return result;
    }
}
