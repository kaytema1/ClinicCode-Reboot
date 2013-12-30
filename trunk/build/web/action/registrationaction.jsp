<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="javax.swing.text.StyledEditorKit.BoldAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,helper.HibernateUtil"%>
<!DOCTYPE html>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("records.jsp");
        }
        // HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
        SimpleDateFormat dobformatter = new SimpleDateFormat("yyyy-MM-dd");
        sess.beginTransaction();
        HMSHelper mg = new HMSHelper();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        if ("folderlocation".equals(request.getParameter("action"))) {
            String patientID = request.getParameter("patientid");
            String location = request.getParameter("location");
            Patient p = null;
            Folder f = null;

            p = mgr.getPatientByID(patientID);



            f = mgr.updateFolderLocation(patientID, location);
            if (f == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Folder Location Could Not Be Updated, Please Try Again");
                response.sendRedirect("../recentpatients.jsp");
                return;
            }


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Folder Location Updated Successfully!");
            session.setAttribute("patient", p);
            response.sendRedirect("../recentpatients.jsp");
            return;
        }

        
        if ("consultationreview".equals(request.getParameter("action"))) {
            String patientID = request.getParameter("patientid");
            String visitIdSTring = request.getParameter("visitid");
            String location = request.getParameter("location");
            Patient p = null;
            Folder f = null;
            int visitId = Integer.parseInt(visitIdSTring);
            
            Visitationtable visit  = mgr.getVisitById(visitId);

            p = mgr.getPatientByID(patientID);
            visit = mgr.updateVisitReview(visit.getVisitid(),true);
            

            f = mgr.updateFolderLocation(patientID, location);
            if (f == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Folder Location Could Not Be Updated, Please Try Again");
                response.sendRedirect("../reviewpatients.jsp");
                return;
            }


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Folder Location Updated Successfully!");
            session.setAttribute("patient", p);
            response.sendRedirect("../patientconsultation.jsp?visitId="+visitId );
            return;
        }






        if ("patient".equals(request.getParameter("action"))) {
            //String patientID = request.getParameter("patientid");

            String lName = request.getParameter("lname") == "" ? "" : request.getParameter("lname");
            String fName = request.getParameter("fname") == "" ? "" : request.getParameter("fname");
            String midName = request.getParameter("midname") == "" ? "" : request.getParameter("midname");
            String gender = request.getParameter("gender") == "" ? "N/A" : request.getParameter("gender");
            String country = request.getParameter("country") == "" ? "N/A" : request.getParameter("country");
            String city = request.getParameter("city") == "" ? "N/A" : request.getParameter("city");
            String maritalstatus = request.getParameter("maritalstatus") == "" ? "N/A" : request.getParameter("maritalstatus");

            String year = request.getParameter("year") == "" ? "0000-" : request.getParameter("year");
            String month = request.getParameter("month") == "" ? "00-" : request.getParameter("month");
            String day = request.getParameter("day") == "" ? "00" : request.getParameter("day");
            String address = request.getParameter("address") == "" ? "N/A" : request.getParameter("address");
            String employer = request.getParameter("employer") == "" ? "N/A" : request.getParameter("employer");
            String contact = request.getParameter("contact") == "" ? "N/A" : request.getParameter("contact");
            String secondContact = request.getParameter("second_contact") == "" ? "N/A" : request.getParameter("second_contact");
            String emergencyPerson = request.getParameter("emergencyperson") == "" ? "N/A" : request.getParameter("emergencyperson");
            String emergencyContact = request.getParameter("emergencycontact") == "" ? "N/A" : request.getParameter("emergencycontact");
            String email = request.getParameter("email") == "" ? "NA" : request.getParameter("email");
            String nhismembershipid = request.getParameter("nhismembershipid") == "" ? "N/A" : request.getParameter("nhismembershipid");
            String coperateid = request.getParameter("coperateid") == "" ? "N/A" : request.getParameter("coperateid");
            String nhisid = request.getParameter("nhisid") == "" ? "N/A" : request.getParameter("nhisid");
            String outofpocketpid = request.getParameter("outofpocketpid") == "" ? "N/A" : request.getParameter("outofpocketpid");
            String coperate = request.getParameter("coperate") == "" ? "N/A" : request.getParameter("coperate");
            String dependentNumber = request.getParameter("dependentNumber") == "" ? "N/A" : request.getParameter("dependentNumber");

            String bearerlname = request.getParameter("bearerlname") == "" ? "N/A" : request.getParameter("outofpocketpid");
            String bearerfname = request.getParameter("bearerfname") == "" ? "N/A" : request.getParameter("coperate");
            String secondarycoperate = request.getParameter("secondarycoperate") == "" ? "N/A" : request.getParameter("secondarycoperate");
            String secondaryType = request.getParameter("secondarytype") == "" ? "N/A" : request.getParameter("secondarytype");
            String secondarycoperateid = request.getParameter("secondarycoperateid") == "" ? "N/A" : request.getParameter("secondarycoperateid");
            String secondarysponsorid = request.getParameter("secondarysponsorid") == "" ? "N/A" : request.getParameter("secondarysponsorid");
            String secondarymembership = request.getParameter("secondarymembership") == "" ? "N/A" : request.getParameter("secondarymembership");
            String secondarybenefitplan = request.getParameter("secondarybenefitplan") == "" ? "N/A" : request.getParameter("secondarybenefitplan");
            String secondarynhismembershipid = request.getParameter("secondarynhismembershipid") == "" ? "N/A" : request.getParameter("secondarynhismembershipid");
            String secondaryoutofpocketpid = request.getParameter("secondaryoutofpocketpid") == "" ? "N/A" : request.getParameter("secondaryoutofpocketpid");
            String secondarynhisid = request.getParameter("secondarynhisid") == "" ? "N/A" : request.getParameter("secondarynhisid");
            String occupation = request.getParameter("occupation") == null ? "N/A" : request.getParameter("occupation");
            //Boolean bool = request.getParameter("bool") == "" ? Boolean.FALSE : Boolean.parseBoolean(request.getParameter("bool"));

            int spid = 0;
            //String membershipID = request.getParameter("membershipid");
            String dob = year + "-" + month + "-" + day;
            String membershipID = request.getParameter("membershipid") == "" ? "N/A" : request.getParameter("membershipid");

            String benefitPlan = request.getParameter("benefitplan") == "" ? "N/A" : request.getParameter("benefitplan");
            //int contype = request.getParameter("contype") == "" ? 0 : Integer.parseInt(request.getParameter("contype"));

            String sponsorType = request.getParameter("type");
            //String benefitPlan = request.getParameter("benefitplan");
            String sponsorid = request.getParameter("sponsorid");
            System.out.println(contact.length());
            String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
            String y = yr.substring(2);
            String code = mgr.getProfile("1").getClinicFolderCode();

            int number = 0;
            if (mgr.listPatients().isEmpty()) {

                number = 0;
            } else {
                Patient lastPatient = (Patient) mgr.listPatients().get(mgr.listPatients().size() - 1);

                String lastPatientid = lastPatient.getPatientid();

                number = Integer.parseInt(lastPatientid.substring(4));
            }
             String patientID = (y + code + (mgr.listPatients().size() + 1));

            Patient p = null;
            Folder f = null;
            Sponsorhipdetails sd = null;
            //String name = fName+" "+lName+" "+midName;
            List list = mgr.listPatientExist(fName, lName, dob);
            if (list.size() > 1 || list == null || !list.isEmpty()) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "This Patient Exist Already");
                response.sendRedirect("../records.jsp");
                return;
            }

            lName = lName.substring(0, 1).toUpperCase() + lName.substring(1);
            try {
                midName = midName.substring(0, 1).toUpperCase() + midName.substring(1);
            } catch (Exception v) {
            }
            fName = fName.substring(0, 1).toUpperCase() + fName.substring(1);


            p = mgr.createPatient(patientID, fName, lName, midName, gender, address, employer, dob, contact, secondContact, emergencyPerson, emergencyContact, email, country, city, maritalstatus, "", bearerlname, bearerfname, Boolean.FALSE, occupation, 0);
            System.out.println("here : " + p);

            if (p == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient Details could not be saved, Please Try Again");
                response.sendRedirect("../records.jsp");
                return;
            }


            f = mgr.createFolder(p.getPatientid(), p.getLname().substring(0, 1) + "-0001", (String) session.getAttribute("unit"), (String) session.getAttribute("unit"));
            if (f == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient Details could not be saved, Please Try Again");
                response.sendRedirect("../records.jsp");
                return;
            }

            if (sponsorType.trim().equals("NHIS")) {
                sd = mgr.createPatientSponsorshipDetails(p.getPatientid(), nhismembershipid, sponsorType, "N/A", nhisid, dependentNumber, secondaryType);
            }
            if (sponsorType.trim().equals("Private")) {
                sd = mgr.createPatientSponsorshipDetails(p.getPatientid(), membershipID, sponsorType, benefitPlan, sponsorid, dependentNumber, secondaryType);
            }
            if (sponsorType.trim().equals("Cooperate")) {
                sd = mgr.createPatientSponsorshipDetails(p.getPatientid(), coperateid, sponsorType, "N/A", coperate, dependentNumber, secondaryType);
            }
            if (sponsorType.trim().equals("CASH")) {
                sd = mgr.createPatientSponsorshipDetails(p.getPatientid(), "N/A", sponsorType, "N/A", outofpocketpid, dependentNumber, secondaryType);
            }
            if (secondaryType.trim().equals("NHIS")) {
                sd = mgr.updateSponsorDetails(p.getPatientid(), secondarynhisid, "N/A", secondarynhismembershipid);
            }
            if (secondaryType.trim().equals("Private")) {
                sd = mgr.updateSponsorDetails(p.getPatientid(), secondarysponsorid, secondarybenefitplan, secondarymembership);
            }

            if (secondaryType.trim().equals("Cooperate")) {
                sd = mgr.updateSponsorDetails(p.getPatientid(), secondarycoperate, secondarybenefitplan, secondarycoperateid);
            }
            if (secondaryType.trim().equals("CASH")) {
                sd = mgr.updateSponsorDetails(p.getPatientid(), secondaryoutofpocketpid, "N/A", "N/A");
            }
            if (sd == null) {
                session.setAttribute("lasterror", "Patient Sponsorship Details could not be updated. Please Update Later");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../records.jsp");
                return;
            }
            /*if (p != null) {
             mgr.createNewVisit(p.getPatientid(), "", "", "OPD", contype,"");
             }*/

            mgr.addPatientReg(patientID);
           // PatientBills bill = mgr.addPatientBills(0, patientID, regfee, 0, "Not-Paid", 0, 0, 0, 0);
            List regFees =   mgr.listCurrentRegFee("Yes");
            RegFee regFee = (RegFee) regFees.get(0);
            mgr.addPatientReg(patientID);
            //Visitationtable visit = mgr.createEmergencyVisit(patientID);
            PatientBills bills = (PatientBills) mgr.addPatientBills(0,"Registration Bill", p.getPatientid(), regFee.getRegFee() , 0, "Not-Paid", 0, 0, 0, 0, current.getStaffid());
            
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "" + p.getPatientid() + " \'s Details Saved Successfully!");
            session.setAttribute("patient", p);
            response.sendRedirect("../printid.jsp?patientid=" + p.getPatientid());
            return;
        }

        if ("cardupdate".equals(request.getParameter("action"))) {
            String patientId = request.getParameter("patientid");
            String orderedBy = request.getParameter("orderedby");
            List cardList = mgr.listPrintedCardsByPatientId(patientId);
            CardPrinting card = null;

            if (cardList.size() > 0) {
                card = (CardPrinting) cardList.get(0);
                card = mgr.updateCardCount(card.getId(), current.getStaffid());
            } else {
                card = mgr.addCard(patientId, orderedBy);
            }
            
            List cardFees =   mgr.listCurrentCardFee("Yes");
            CardFee cardFee = (CardFee) cardFees.get(0);
            
            PatientBills bill = (PatientBills) mgr.addPatientBills(0,"Card Bill", patientId, cardFee.getCardFee() , 0, "Not-Paid", 0, 0, 0, 0, current.getStaffid());
            
            return;
        }


        if ("emergencypatient".equals(request.getParameter("action"))) {
            //String patientID = request.getParameter("patientid");

            String lName = "Patient" + formatter.format(new Date());
            String fName = "Emergency";
            String midName = "";
            String gender = request.getParameter("gender") == "" ? "N/A" : request.getParameter("gender");
            String country = "Ghana";
            String city = "Accra";
            String maritalstatus = "Single";


            String address = "Unknown";
            String employer = "Unknown";
            String contact = "Unknown";
            String secondContact = "Unknown";
            String emergencyPerson = "Unknown";
            String emergencyContact = "Unknown";
            String email = "unknown@unknown.com";
            String outofpocketpid = mgr.getCASHID().getSponshorshipid();
            String dependentNumber = request.getParameter("dependentNumber") == "" ? "N/A" : request.getParameter("dependentNumber");

            String bearerlname = request.getParameter("bearerlname") == "" ? "N/A" : request.getParameter("outofpocketpid");
            String bearerfname = request.getParameter("bearerfname") == "" ? "N/A" : request.getParameter("coperate");
            String secondaryType = "CASH";
            String secondaryoutofpocketpid = mgr.getCASHID().getSponshorshipid();
            String occupation = request.getParameter("occupation") == null ? "N/A" : request.getParameter("occupation");
            String dob = dobformatter.format(new Date());
            String sponsorType = "CASH";
            String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
            String y = yr.substring(2);
            String code = mgr.getProfile("1").getClinicFolderCode();

            int number = 0;
            if (mgr.listPatients().isEmpty()) {

                number = 0;
            } else {
                Patient lastPatient = (Patient) mgr.listPatients().get(mgr.listPatients().size() - 1);

                String lastPatientid = lastPatient.getPatientid();

                number = Integer.parseInt(lastPatientid.substring(4));
            }
            String patientID = (y + code + (mgr.listPatients().size() + 1));

            Patient p = null;
            Folder f = null;
            Sponsorhipdetails sd = null;
            //String name = fName+" "+lName+" "+midName;
            List list = mgr.listPatientExist(fName, lName, dob);
            if (list.size() > 1 || list == null || !list.isEmpty()) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "This Patient Exist Already");
                response.sendRedirect("../records.jsp");
                return;
            }

            lName = lName.substring(0, 1).toUpperCase() + lName.substring(1);
            try {
                midName = midName.substring(0, 1).toUpperCase() + midName.substring(1);
            } catch (Exception v) {
            }
            fName = fName.substring(0, 1).toUpperCase() + fName.substring(1);


            p = mgr.createPatient(patientID, fName, lName, midName, gender, address, employer, dob, contact, secondContact, emergencyPerson, emergencyContact, email, country, city, maritalstatus, "", bearerlname, bearerfname, Boolean.FALSE, occupation, 1);
            System.out.println("here : " + p);
            
            if (p == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient Details could not be saved, Please Try Again");
                response.sendRedirect("../records.jsp");
                return;
            }


            f = mgr.createFolder(p.getPatientid(), p.getLname().substring(0, 1) + "-0001", (String) session.getAttribute("unit"), (String) session.getAttribute("unit"));
            if (f == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient Details could not be saved, Please Try Again");
                response.sendRedirect("../records.jsp");
                return;
            }


            if (sponsorType.trim().equals("CASH")) {
                sd = mgr.createPatientSponsorshipDetails(p.getPatientid(), "N/A", sponsorType, "N/A", outofpocketpid, dependentNumber, secondaryType);
            }
            if (secondaryType.trim().equals("CASH")) {
                sd = mgr.updateSponsorDetails(p.getPatientid(), secondaryoutofpocketpid, "N/A", "N/A");
            }
            if (sd == null) {
                session.setAttribute("lasterror", "Patient Sponsorship Details could not be updated. Please Update Later");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../records.jsp");
                return;
            }
            
          List regFees =   mgr.listCurrentRegFee("Yes");
            RegFee regFee = (RegFee) regFees.get(0);
            mgr.addPatientReg(patientID);
            Visitationtable visit = mgr.createEmergencyVisit(patientID);
            PatientBills bills = (PatientBills) mgr.addPatientBills(visit.getVisitid(),"Registration Bill", p.getPatientid(), regFee.getRegFee() , 0, "Not-Paid", 0, 0, 0, 0, current.getStaffid());
            

            session.setAttribute("class", "alert-success");

            if (p.getEmergencyPatient() == 0) {
                session.setAttribute("lasterror", "" + p.getPatientid() + " \'s Details Saved Successfully!");
            } else {
                session.setAttribute("lasterror", "" + p.getPatientid() + "EMG \'s Details Saved Successfully!");
            }
            session.setAttribute("patient", p);
            response.sendRedirect("../records.jsp");
            return;
        }


        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        ex.printStackTrace();
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            // throw (ServletException) ex;
            out.print(ex.getMessage());
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "An Error Occurred. Please Try Again Later");
            response.sendRedirect("../records.jsp");
        } else {
            // throw new ServletException(ex);
            out.print(ex.getMessage());
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "An Error Occurred. Please Try Again Later");
            response.sendRedirect("../records.jsp");
        }
    }%>