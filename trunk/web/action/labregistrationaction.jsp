<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
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
        sess.beginTransaction();
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
            String emergencyPerson = request.getParameter("emergencyperson") == "" ? "N/A" : request.getParameter("emergencyperson");
            String emergencyContact = request.getParameter("emergencycontact") == "" ? "N/A" : request.getParameter("emergencycontact");
            String email = request.getParameter("email") == "" ? "NA" : request.getParameter("email");
            String nhismembershipid = request.getParameter("nhismembershipid") == "" ? "N/A" : request.getParameter("nhismembershipid");
            String coperateid = request.getParameter("coperateid") == "" ? "N/A" : request.getParameter("coperateid");
            String nhisid = request.getParameter("nhisid") == "" ? "N/A" : request.getParameter("nhisid");
            String outofpocketpid = request.getParameter("outofpocketpid") == "" ? "N/A" : request.getParameter("outofpocketpid");
            String coperate = request.getParameter("coperate") == "" ? "N/A" : request.getParameter("coperate");
            String dependentNumber = request.getParameter("dependentNumber") == "" ? "N/A" : request.getParameter("dependentNumber");
            String secondaryType = request.getParameter("secondarytype") == "" ? "N/A" : request.getParameter("secondarytype");
            String secondarycoperateid = request.getParameter("secondarycoperateid") == "" ? "N/A" : request.getParameter("secondarycoperateid");
            String secondarysponsorid = request.getParameter("secondarysponsorid") == "" ? "N/A" : request.getParameter("secondarysponsorid");
            String secondarymembership = request.getParameter("secondarymembership") == "" ? "N/A" : request.getParameter("secondarymembership");
            String secondarybenefitplan = request.getParameter("secondarybenefitplan") == "" ? "N/A" : request.getParameter("secondarybenefitplan");
            String secondarynhismembershipid = request.getParameter("secondarynhismembershipid") == "" ? "N/A" : request.getParameter("secondarynhismembershipid");
            String secondaryoutofpocketpid = request.getParameter("secondaryoutofpocketpid") == "" ? "N/A" : request.getParameter("secondaryoutofpocketpid");
            String secondarynhisid = request.getParameter("secondarynhisid") == "" ? "N/A" : request.getParameter("secondarynhisid");
            String secondarycoperate = request.getParameter("secondarycoperate") == "" ? "N/A" : request.getParameter("secondarycoperate");
            String bearerlname = request.getParameter("bearerlname") == "" ? "N/A" : request.getParameter("outofpocketpid");
            String bearerfname = request.getParameter("bearerfname") == "" ? "N/A" : request.getParameter("coperate");
            Boolean bool = request.getParameter("bool") == "" ? Boolean.FALSE : Boolean.parseBoolean(request.getParameter("bool"));

            int spid = 0;
            //String membershipID = request.getParameter("membershipid");
            String dob = year + "-" + month + "-" + day;
            String membershipID = request.getParameter("membershipid") == null ? "N/A" : request.getParameter("membershipid");

            String benefitPlan = request.getParameter("benefitplan") == "" ? "N/A" : request.getParameter("benefitplan");
            //int contype = request.getParameter("contype") == "" ? 0 : Integer.parseInt(request.getParameter("contype"));

            String sponsorType = request.getParameter("type");
            //String benefitPlan = request.getParameter("benefitplan");
            String sponsorid = request.getParameter("sponsorid");
            System.out.println(contact.length());
            if (lName.equalsIgnoreCase("") || fName.equalsIgnoreCase("")) {
                session.setAttribute("lasterror", "Name fields cannot be empty");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            
            if (year.equalsIgnoreCase("D") || month.equalsIgnoreCase("M") || day.equalsIgnoreCase("Y")) {
                session.setAttribute("lasterror", "Date fields cannot be empty");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            if (!contact.equals("N/A") && contact.length() > 14) {
                session.setAttribute("lasterror", "Telephone number length cannot be more than 10 digits");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            if (!contact.equals("N/A") && contact.length() < 9) {
                session.setAttribute("lasterror", "Telephone number length cannot be less then 10 digits");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            if (!emergencyContact.equals("N/A") && emergencyContact.length() > 14) {
                session.setAttribute("lasterror", "Emergency telephone number length cannot be more than 10 digits");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            if (!emergencyContact.equals("N/A") && emergencyContact.length() < 9) {
                session.setAttribute("lasterror", "Emergency telephone number length cannot be less than 10 digits");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
           
            if (sponsorType.trim().equals("NHIS") && nhismembershipid.equalsIgnoreCase("")) {
                session.setAttribute("lasterror", "NHIS membership number field cannot be empty");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            if (sponsorType.trim().equals("Cooperate") && coperateid.equalsIgnoreCase("N/A")) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Corporate membership number field cannot be empty");
                response.sendRedirect("../labreception.jsp");
                return;
            }

            if (sponsorType.trim().equals("Private") && membershipID.equalsIgnoreCase("")) {
                session.setAttribute("lasterror", "Private membership number field cannot be empty");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../labreception.jsp");
                return;
            }

            if (sponsorid != "") {
                //spid = Integer.parseInt(sponsorid);
            }
            /* if (!coperate.equalsIgnoreCase("Select")) {
             spid = Integer.parseInt(coperate);
             }*/

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            LabPatient p = null;
            Folder f = null;
            Sponsorhipdetails sd = null;
            //String name = fName+" "+lName+" "+midName;
            List list = mgr.listLabPatientExist(fName, lName, dob);
            if (list.size() > 1 || list == null || !list.isEmpty()) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "This Laboratory Patient Exist Already");
                response.sendRedirect("../labreception.jsp");
                return;
            }
            //String name = fName+" "+lName+" "+midName;
            String patientID = "";
            String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
            String y = yr.substring(2);
            patientID = (y + "LP" + (mgr.listLabPatients().size() + 1));
            
            lName = lName==""?"":lName.substring(0, 1).toUpperCase() + lName.substring(1);
            midName = midName==""?"":midName.substring(0, 1).toUpperCase() + midName.substring(1);
            fName = fName==""?"":fName.substring(0, 1).toUpperCase() + fName.substring(1);
            
            p = mgr.addNewLabPatient(patientID, fName, lName, midName, gender, address, employer, dob, contact, emergencyPerson, emergencyContact, email, country, city, maritalstatus, "","");
            
            System.out.println("here : " + p);

            if (p == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient Details could not be saved, Please Try Again");
                response.sendRedirect("../labreception.jsp");
                return;
            }


            f = mgr.createFolder(p.getPatientid(), p.getLname().substring(0, 1) + "-0001", (String) session.getAttribute("unit"), (String) session.getAttribute("unit"));
            if (f == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient Details could not be saved, Please Try Again");
                response.sendRedirect("../labreception.jsp");
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
                response.sendRedirect("../labreception.jsp");
                return;
            }
            

            mgr.addPatientReg(patientID);

            session.setAttribute("class", "alert-success");
            session.setAttribute("patientid","" + p.getPatientid());
            session.setAttribute("lasterror", "" + p.getPatientid() + " \'s Details Saved Successfully!" ); 
            
            session.setAttribute("patient", p);
            response.sendRedirect("../labpatientsearch.jsp?searchid=patientid&searchquery="+p.getPatientid());
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            // throw (ServletException) ex;
            out.print(ex.getMessage());
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "An Error Occurred. Please Try Again Later1");
            response.sendRedirect("../labreception.jsp");
        } else {
            // throw new ServletException(ex);
            System.out.print(ex.getMessage());
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "An Error Occurred. Please Try Again Later2");
            response.sendRedirect("../labreception.jsp");
        }
    }%>