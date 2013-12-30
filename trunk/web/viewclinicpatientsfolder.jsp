<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat nice = new SimpleDateFormat("d MMM. yyyy");

    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
    SimpleDateFormat day = new SimpleDateFormat("dd");
    SimpleDateFormat month = new SimpleDateFormat("MM");
    SimpleDateFormat year = new SimpleDateFormat("yyyy");

%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
    String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");
    String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");

    Patient patient = null;
    List patientVisits = null;





    try {
        if (patientid != "") {
            patient = mgr.getPatientByID(patientid);

            if (patient == null) {
                session.setAttribute("lasterror", "Please Select a Patient");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("listpatients.jsp");
                return;
            }
        }


    } catch (NullPointerException e) {
        session.setAttribute("lasterror", "Please Select a Patient");
        session.setAttribute("class", "alert");
        response.sendRedirect("records.jsp");
        return;
    }




%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body style="overflow-y: scroll;" data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="records.jsp">Records <i class="icon-chevron-right"></i></a><span class="divider"></span>
                        </li>

                        <li class="active">
                            <a href="#"><% if (patient.getEmergencyPatient() == 1) {%> 
                                <%=patient.getPatientid()%>EMG 
                                <% } else {%>
                                <%=patient.getPatientid()%>
                                <%}%>  </a><span class="divider"></span>
                        </li>



                    </ul>
                </div>

            </header>

            <div style="position: absolute; left: 30%; top: 200px; text-align: center;" class="progress1">
                <img src="images/logoonly.png" width="136px;" style="margin-bottom: 20px;" />
                <a href="#"> <h3 class="segoe" style="text-align: center; font-weight: lighter;"> Your page is taking longer than expected to load.....
                        <br />
                        Please be patient!</h3>
                    <br />
                </a>
                <div  class="progress progress-striped active span5">

                    <div class="bar"
                         style="width: 100%;"></div>
                </div>
            </div>

            <%if (patient != null) {%>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <div class="row-fluid">
                    <div style="padding-left: 4%; display: none;" class="span3 profile">

                        <div class="thumbnail">

                            <div class="center" style="width: 100%; padding-top: 5%">
                                <% if (patient.getGender().equalsIgnoreCase("Male")) {%>


                                <img src="img/default-facebook-avatar-male.gif"  />


                                <% } else {%>

                                <img src="img/default-facebook-avatar-female.gif"  />

                                <% }%>
                            </div>

                            <dl>
                                <dd style=" font-size: 15px; text-align: center; text-transform: uppercase"><%= patient.getFname()%> <%if (patient.getMidname() != null) {%> <%= patient.getMidname()%> <% }%> <%= patient.getLname()%></dt>


                                <dd style=" font-size: 15px; text-align: center; text-transform: uppercase;  "><a href="#"> <% if (patient.getEmergencyPatient() == 1) {%> 
                                        <%=patient.getPatientid()%>EMG 
                                        <% } else {%>
                                        <%=patient.getPatientid()%>
                                        <%}%> </a> </dt>

                            </dl>
                            <div class="clearfix">

                            </div>
                            <dl class="dl-horizontal">
                                <dt style="text-align: left; padding-left: 5%;">AGE</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getAgeDifference(format.format(patient.getDateofbirth()))%> YRS</dd>


                                <dt style="text-align: left; padding-left: 5%;">BIRTHDAY</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= nice.format(patient.getDateofbirth())%></dd>


                                <dt style="text-align: left; padding-left: 5%;">GENDER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= patient.getGender()%></dd>


                                <dt style="text-align: left; padding-left: 5%;">MARITAL STATUS</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= patient.getMaritalstatus()%></dd>

                                <dt style="text-align: left; padding-left: 5%;">NATIONALITY</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= patient.getCountry()%></dd>
                            </dl>
                                <a style="margin-left: 22%; width: 50%" href="updateclinicpatient.jsp?patientid=<%=patient.getPatientid()%>" class="btn btn-small">
                                <i class="icon-edit"></i> Update Details
                            </a>
                        </div>


                        <div class="clearfix"></div>




                        <div style="margin-bottom: 2%; width: 95%; float: left;  height: 150px;" class="thumbnail">
                            <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                <li>
                                    <span  class="lead" style="font-size: 15px;"> <img src="img/glyphicons/png/glyphicons_227_usd.png"/> Billing Information </span>
                                </li>

                            </ul>

                            <dl class="dl-horizontal">

                                <% if (mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("Private")) {%>  
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>

                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%></dd>

                                <% }%>



                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getMembershipid()%></dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">BENEFIT PLAN</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getBenefitplan()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("Cooperate")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>
                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%></dd>

                                <% }%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">COMPANY ID</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getMembershipid()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("NHIS")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%> </dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getMembershipid()%></dd>



                                <% } else {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%=mgr.sponsorshipDetails(patient.getPatientid()) == null ? mgr.sponsorshipDetails(patient.getPatientid()).getType() : mgr.sponsorshipDetails(patient.getPatientid()).getType()%></dd>



                                <% }%>






                                <% if (mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("Private")) {%>  
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname()%></dd>

                                <% }%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryMembership()%></dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">BENEFIT PLAN</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryBenefitplan()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("Cooperate")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname()%></dd>

                                <% }%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">COMPANY ID</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryMembership()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("NHIS")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname()%> </dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryMembership()%></dd>



                                <% } else {%>

                                <% if (!mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("CASH")) {%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%=mgr.sponsorshipDetails(patient.getPatientid()) == null ? mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType() : mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType()%></dd>

                                <% }
                                    }%>

                                <% if (!mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("CASH")) {%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">TERTIARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%">CASH</dd>



                                <% }%>



                            </dl>
                        </div>
                    </div>

                    <div style="display: none; " class="span8 main-c">
                        <div id="tabs">

                            <ul>
                                <li> <a href="#tabs-2"> Medical Information  </a> </li>
                                <li> <a href="#tabs-3"> Visit Details  </a> </li>
                                <li> <a href="#tabs-1"> Contact Information  </a> </li>


                            </ul>


                            <div  id="tabs-1">
                                <div style="margin-bottom: 2%; width: 47%; float: left; margin-left: 1%; height: 150px;" class="thumbnail">
                                    <ul style="padding: 3px; padding-left: 8px;" class="breadcrumb">

                                        <li>
                                            <span  class="lead" style="font-size: 15px;"> <img src="img/glyphicons/png/glyphicons_264_vcard.png"/> Contact Information </span>
                                        </li>


                                    </ul>

                                    <dl class="dl-horizontal">
                                        <dt style="text-align: left; padding-left: 5%; width: 200px;">PHONE NUMBER</dt>
                                        <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getContact() != null) {%> <%= patient.getContact()%> <% }%></dd>


                                        <dt style="text-align: left; padding-left: 5%; width: 200px;">OTHER PHONE NUMBER</dt>
                                        <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getSecondContact() != null) {%> <%= patient.getSecondContact()%> <% }%></dd>


                                        <dt style="text-align: left; padding-left: 5%; width: 200px;">PHYSICAL ADDRESS</dt>
                                        <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getAddress() != null) {%> <%= patient.getAddress()%> <% }%></dd>


                                        <dt style="text-align: left; padding-left: 5%;width: 200px;">EMAIL ADDRESS</dt>
                                        <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getEmail() != null) {%> <%= patient.getEmail()%> <% }%></dd>

                                        <dt style="text-align: left; padding-left: 5%; width: 200px;">OCCUPATION</dt>
                                        <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getOccupation() != null) {%> <%= patient.getOccupation()%> <% }%></dd>
                                    </dl>
                                </div>

                                <div style="margin-bottom: 2%; width: 47%; float: left; margin-left: 1%; height: 150px;" class="thumbnail">
                                    <ul style="padding: 3px; padding-left: 8px;" class="breadcrumb">

                                        <li>
                                            <span  class="lead" style="font-size: 15px;"> <img src="img/glyphicons/png/glyphicons_006_user_add.png"/> Emergency Contact Information  </span>
                                        </li>

                                    </ul>

                                    <dl class="dl-horizontal">
                                        <dt style="text-align: left; padding-left: 5%; width: 180px;">EMERGENCY CONTACT</dt>
                                        <dd style="text-transform: uppercase; padding-left: 0px;"><% if (patient.getEmergencyperson() != null) {%> <%= patient.getEmergencyperson()%> <% }%></dd>


                                        <dt style="text-align: left; padding-left: 5%; width: 180px;">EMERGENCY NUMBER</dt>
                                        <dd style="text-transform: uppercase; padding-left: 0px;"><% if (patient.getEmergencycontact() != null) {%> <%= patient.getEmergencycontact()%> <% }%></dd>



                                    </dl>
                                </div>

                                <div class="clearfix"></div>

                            </div>
                            <div  id="tabs-2">          
                                <%






                                    List patient_allergies = null;
                                    List patient_medical_histories = null;
                                    List patient_family_histories = null;
                                    List patient_social_histories = null;

                                    List patient_immunizations = null;
                                    List patient_surgeries = null;





                                    patient_immunizations = mgr.listPatientImmunizationsByPatientid(patientid);
                                    patient_surgeries = mgr.listPatientSurgeriesByPatientid(patientid);
                                    patient_medical_histories = mgr.listPatientMedicalHistoryByPatientId(patientid);
                                    patient_family_histories = mgr.listPatientFamilyHistoryByPatientId(patientid);
                                    patient_social_histories = mgr.listPatientSocialHistoryByPatientId(patientid);
                                    patient_allergies = mgr.listPatientAllergiesByPatientId(patientid);


                                    List previous_visits = null;

                                    List nurses_patient_conditions = null;
                                    List nurses_condition_notes = null;
                                    List nurses_patient_onsets = null;
                                    List nurses_onset_notes = null;
                                    List nurses_patient_reliefs = null;
                                    List nurses_relief_notes = null;




                                    previous_visits = mgr.listPatientVisits(patientid);







                                    //System.out.println(dateFormat.format(date));
                                    String conroom = (String) session.getAttribute("unit");
                                    String ls = conroom.split("_")[0];
                                    System.out.println(ls);
                                    // out.print(ls);



                                %>


                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 47%; line-height: 18px; float: left; margin-left: 1%; margin-bottom: 1% ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Allergies </b></a>
                                        </li>
                                    </ul>

                                    <% if (patient_allergies.size() > 0) {%> 

                                    <table class="table table-striped">


                                        <tbody>
                                            <% for (int y = 0; y < patient_allergies.size(); y++) {
                                                    PatientAllergies allergy = (PatientAllergies) patient_allergies.get(y);
                                                    if (allergy != null) {%>
                                            <tr>
                                                <td style="text-transform: capitalize;  font-size: 14px; font-weight: bold">
                                                    <%=mgr.getAllergyByid(allergy.getAllergyid()).getName().toLowerCase()%>
                                                </td>
                                            </tr>
                                            <% }
                                                }%>



                                        </tbody>



                                    </table>

                                    <% }%>



                                </div>

                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 47%; line-height: 18px; float: left; margin-left: 1%; margin-bottom: 1%   ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Immunizations </b></a>
                                        </li>

                                    </ul>
                                    </ul>
                                    <% if (patient_immunizations.size() > 0) {%>
                                    <table>
                                        <% for (int x = 0; x < patient_immunizations.size(); x++) {

                                                PatientImmunizations immunization = (PatientImmunizations) patient_immunizations.get(x);
                                        %>

                                        <tr>
                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= immunization.getImmunization()%>
                                            </td>
                                        </tr>

                                        <% }%>
                                    </table>

                                    <% }%>
                                </div>

                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 47%; line-height: 18px; float: left; margin-left: 1%; margin-bottom: 1%  ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Surgeries </b></a>
                                        </li>

                                    </ul>

                                    <% if (patient_surgeries.size() > 0) {%>
                                    <table>
                                        <% for (int x = 0; x < patient_surgeries.size(); x++) {

                                                PatientSurgeries surgery = (PatientSurgeries) patient_surgeries.get(x);
                                        %>

                                        <tr>
                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= surgery.getSurgery()%>
                                            </td>
                                        </tr>

                                        <% }%>
                                    </table>

                                    <% }%>

                                </div>
                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 47%; line-height: 18px; float: left; margin-left: 1%; margin-bottom: 1%  ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Past Medical History </b></a>
                                        </li>



                                    </ul>

                                    <% if (patient_medical_histories.size() > 0) {%>
                                    <table class="table">

                                        <tbody>

                                            <% for (int y = 0; y < patient_medical_histories.size(); y++) {
                                                    PatientMedicalHistory patient_medical_history = (PatientMedicalHistory) patient_medical_histories.get(y);
                                                    if (patient_medical_history != null) {%>
                                            <tr>

                                                <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                    <%= mgr.getMedicalHistoryById(patient_medical_history.getHistoryId()).getHistory().toLowerCase()%>
                                                </td>
                                            </tr>


                                            <% }
                                                }%>
                                        </tbody>

                                    </table>
                                    <% }%>

                                </div>

                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 47%; line-height: 18px; float: left; margin-left: 1%;  margin-bottom: 1%  ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Family History </b></a>
                                        </li>

                                    </ul>
                                    <% if (patient_family_histories.size() > 0) {%>

                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Condition
                                                </th>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Relative
                                                </th>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Duration
                                                </th>
                                            </tr>
                                        </thead>
                                        <% for (int y = 0; y < patient_family_histories.size(); y++) {
                                                PatientFamilyHistory patientFamilyHistory = (PatientFamilyHistory) patient_family_histories.get(y);
                                        %>

                                        <tr>
                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= mgr.getMedicalHistoryById(patientFamilyHistory.getHistoryId()).getHistory()%>

                                            </td>
                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= patientFamilyHistory.getFamilyMember()%>
                                            </td>
                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= mgr.getDurationById(patientFamilyHistory.getDurationId()).getDuration()%>
                                            </td>
                                        </tr>
                                        <% }%>

                                    </table>


                                    <% }%>
                                </div>

                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 47%; line-height: 18px; float: left; margin-left: 1%; margin-bottom: 1%  ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Social History </b></a>
                                        </li>

                                    </ul>

                                    <% if (patient_social_histories.size() > 0) {%>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Social Behavior
                                                </th>

                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Duration
                                                </th>
                                            </tr>
                                        </thead>
                                        <% for (int y = 0; y < patient_social_histories.size(); y++) {
                                                PatientSocialHistory patientSocialHistory = (PatientSocialHistory) patient_social_histories.get(y);
                                        %>

                                        <tr>
                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= mgr.getSocialHistoryById(patientSocialHistory.getSocialHistoryId()).getSocialHistory()%>

                                            </td>

                                            <td style="text-transform: capitalize; font-size: 14px; font-weight: bold">
                                                <%= mgr.getDurationById(patientSocialHistory.getDurationId()).getDuration()%>
                                            </td>
                                        </tr>
                                        <% }%>

                                    </table>


                                    <% }%>

                                </div>



                            </div>

                            <div  id="tabs-3">
                                <% if (previous_visits.size() > 0) {%>
                                <div class="thumbnail center previous_visit<%=patientid%>" style="width: 95%; line-height: 18px; float: left; margin-left: 1%; margin-bottom: 1%   ">
                                    <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                        <li>
                                            <a style="text-align: center;"> <b> Visit Summaries Summary </b></a>
                                        </li>

                                    </ul>

                                    <div class="clearfix"></div>
                                    <div id="verticaltabs">
                                        <ul>

                                            <% for (int x = previous_visits.size() - 1; x >= 0; x--) {

                                                    Visitationtable vis = (Visitationtable) previous_visits.get(x);
                                            %>
                                            <li>

                                                <% if (previous_visits.size() == x + 1) {%>   

                                                <a href="#tabs-<%=x + 1%> "> CURRENT VISIT </a>

                                                <% } else {%>
                                                <a href="#tabs-<%=x + 1%> "> VISIT NO.<%=x + 1%></a>
                                                <% }%> 
                                            </li>


                                            <% }%>
                                        </ul>

                                        <% for (int x = previous_visits.size() - 1; x >= 0; x--) {

                                                Visitationtable vis = (Visitationtable) previous_visits.get(x);
                                        %>
                                        <div  id="tabs-<%=x + 1%>"> 
                                            <lead style="color: #0063DC; font-weight: 200; text-transform: uppercase;" class="control-label pull-right">

                                                <%= datetimeformat.format(vis.getDate())%>

                                            </lead>
                                            <div class="clearfix">

                                            </div>
                                            <br />


                                            <div style="border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    <b> NURSES ENQUIRY </b> 
                                                </lead>

                                                <% List visitVitals = mgr.listVitalTableVisitid(vis.getVisitid());



                                                    Vitaltable myVitals = (Vitaltable) visitVitals.get(0);
                                                %>

                                                <table style="font-size: 12px;" class="table table-striped">
                                                    <tr>
                                                        <td><b style="color: #4183C4; font-size: 12px;">Temperature</b></td>

                                                        <td style="font-size: 12px;"><%=myVitals.getTemperature()%>&nbsp;&nbsp;(°C)
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td><b style="color: #4183C4; font-size: 12px;">Weight </b></td>

                                                        <td style="font-size: 12px;"><%=myVitals.getWeight()%>&nbsp;&nbsp;(Kg)</td>
                                                    </tr>

                                                    <tr>
                                                        <td><b style="color: #4183C4; font-size: 12px;">Height </b> </td>

                                                        <td style="font-size: 12px;"><%=myVitals.getHeight()%>&nbsp; &nbsp;(cm)</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td><b style="color: #4183C4; font-size: 12px;">Blood Pressure </b> </td>
                                                        <td style="font-size: 12px;">
                                                            <%=myVitals.getSistolic()%> / <%=myVitals.getDiatolic()%>&nbsp;&nbsp;(mmHg)
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size: 12px; color: #4183C4; font-weight: bold;">
                                                            Pulse
                                                        </td>

                                                        <td style="font-size: 12px;">
                                                            <%=myVitals.getPulse()%>&nbsp; &nbsp;(BPM)
                                                        </td>
                                                    </tr>

                                                </table>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div style="width: 100%">
                                                <% List patientVisitConditions = mgr.listPatientConditionsByVisitid(vis.getVisitid());
                                                    int count1 = patientVisitConditions.size();
                                                    List patientVisitConditionNotes = mgr.listPatientConditionNotesByVisitid(vis.getVisitid());
                                                    int count2 = patientVisitConditionNotes.size();
                                                    List patientVisitSystemicReviews = mgr.listPatientSystemicReviewsByVisitid(vis.getVisitid());
                                                    int count3 = patientVisitSystemicReviews.size();
                                                    List major_findings = mgr.listPatientMajorExaminationByVisitid(vis.getVisitid());
                                                    int count4 = major_findings.size();
                                                    List patientDiagnosis = mgr.listPatientDiagnosisByVisit(vis.getVisitid());
                                                    int count5 = patientDiagnosis.size();
                                                    List patientInvestigations = mgr.listPatientLabForVisit(vis.getPatientid(), vis.getVisitid());
                                                    int count6 = patientInvestigations.size();


                                                    nurses_patient_conditions = mgr.listNursesPatientConditionsByVisitid(vis.getVisitid());
                                                    int count7 = nurses_patient_conditions.size();
                                                    nurses_condition_notes = mgr.listNursesPatientConditionNotesByVisitid(vis.getVisitid());
                                                    int count8 = nurses_condition_notes.size();
                                                    nurses_patient_onsets = mgr.listNursesPatientOnsetsByVisitid(vis.getVisitid());
                                                    int count9 = nurses_patient_onsets.size();
                                                    nurses_onset_notes = mgr.listNursesPatientOnsetNotesByVisitid(vis.getVisitid());
                                                    int count10 = nurses_onset_notes.size();
                                                    nurses_patient_reliefs = mgr.listNursesPatientReliefsByVisitid(vis.getVisitid());
                                                    int count11 = nurses_patient_reliefs.size();
                                                    nurses_relief_notes = mgr.listNursesPatientReliefNotesByVisitid(vis.getVisitid());
                                                    int count12 = nurses_relief_notes.size();
                                                %>
                                                <%

                                                    if (count7 > 0 || count8 > 0 || count9 > 0 || count10 > 0 || count11 > 0 || count12 > 0) {
                                                %>
                                                <div style=" padding: 1%; margin-right: 2%;  margin-bottom: 2%">
                                                    <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                        NURSES REVIEW  
                                                    </lead>

                                                    <div class="clearfix"></div>
                                                    <br />


                                                    <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            PRESENTING COMPLAINTS 
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />
                                                        <% if (nurses_patient_conditions.size() > 0) {%>



                                                        <table style="width: 95%" class="table table-striped">
                                                            <%  for (int y = 0; y < nurses_patient_conditions.size(); y++) {
                                                                    NursesPatientConditions condition = (NursesPatientConditions) nurses_patient_conditions.get(y);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= mgr.getProblemOption(condition.getConditionId()).getProblemName()%>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </table>
                                                        <% }%>
                                                        <% if (nurses_condition_notes.size() > 0) {%>



                                                        <table style="width: 95%" class="table table-striped">
                                                            <%
                                                                NursesPatientConditionNotes note = (NursesPatientConditionNotes) nurses_condition_notes.get(0);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= note.getConditionNote()%>
                                                                </td>
                                                            </tr>

                                                        </table>
                                                        <% }%>
                                                    </div>

                                                    <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            PRESENTING COMPLAINTS ONSET
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />
                                                        <% if (nurses_patient_onsets.size() > 0) {%>
                                                        <table style="width: 95%" class="table table-striped">
                                                            <%  for (int y = 0; y < nurses_patient_onsets.size(); y++) {
                                                                    NursesPatientOnsets onset = (NursesPatientOnsets) nurses_patient_onsets.get(y);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= mgr.getOnsetOption(onset.getOnsetId()).getOnset()%>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </table>
                                                        <% }%>
                                                        <% if (nurses_onset_notes.size() > 0) {%>



                                                        <table style="width: 95%" class="table table-striped">
                                                            <%
                                                                NursesPatientOnsetNotes note = (NursesPatientOnsetNotes) nurses_onset_notes.get(0);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= note.getOnsetNote()%>
                                                                </td>
                                                            </tr>

                                                        </table>
                                                        <% }%>
                                                    </div>   

                                                    <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            PRESENTING COMPLAINTS RELIEF
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />
                                                        <% if (nurses_patient_reliefs.size() > 0) {%>
                                                        <table style="width: 95%" class="table table-striped">
                                                            <%  for (int y = 0; y < nurses_patient_reliefs.size(); y++) {
                                                                    NursesPatientReliefs relief = (NursesPatientReliefs) nurses_patient_reliefs.get(y);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= mgr.getReliefOption(relief.getReliefId()).getRelief()%>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </table>
                                                        <% }%>
                                                        <% if (nurses_relief_notes.size() > 0) {%>



                                                        <table style="width: 95%" class="table table-striped">
                                                            <%
                                                                NursesPatientReliefNotes note = (NursesPatientReliefNotes) nurses_relief_notes.get(0);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= note.getReliefNote()%>
                                                                </td>
                                                            </tr>

                                                        </table>
                                                        <% }%>
                                                    </div>






                                                </div>




                                                <% }%>






                                                <% if (count1 > 0 || count2 > 0 || count3 > 0 || count4 > 0 || count5 > 0 || count6 > 0) {%>

                                                <div style="width: 100%">
                                                    <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                        CONSULTATION SUMMARY  
                                                    </lead>

                                                    <div class="clearfix"></div>
                                                    <br />

                                                    <% if (patientVisitConditions.size() > 0) {%>    
                                                    <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            PRESENTING COMPLAINTS 
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />




                                                        <table style="width: 95%" class="table table-striped">
                                                            <% for (int y = 0; y < patientVisitConditions.size(); y++) {
                                                                    PatientConditions condition = (PatientConditions) patientVisitConditions.get(y);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= mgr.getProblemOption(condition.getConditionId()).getProblemName()%>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </table>

                                                        <% if (patientVisitConditionNotes.size() > 0) {
                                                                PatientConditionNotes note = (PatientConditionNotes) patientVisitConditionNotes.get(0);

                                                        %>
                                                        <table>
                                                            <tr>
                                                                <td><%= note.getConditionNote()%> </td>
                                                            </tr>

                                                        </table>


                                                        <% }%>





                                                    </div>
                                                    <% }%>
                                                    <%

                                                        if (patientVisitSystemicReviews.size() > 0) {%>
                                                    <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%;margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            SYSTEMIC REVIEW
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />

                                                        <table style="width: 95%" class="table table-striped">
                                                            <% for (int y = 0; y < patientVisitSystemicReviews.size(); y++) {
                                                                    PatientSystemicReviews review = (PatientSystemicReviews) patientVisitSystemicReviews.get(y);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= mgr.getClerkingQuestionByid(review.getSystemicReviewId()).getQuestion()%>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </table>
                                                    </div>
                                                    <%}%>


                                                    <%
                                                        if (major_findings.size() > 0) {%>
                                                    <div style="width: 45%; font-size: 12px;  border: solid 1px #DDD; padding: 1%;margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            MAJOR EXAMINATION FINDINGS
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />
                                                        <% PatientMajorExaminations exam = (PatientMajorExaminations) major_findings.get(0);%>

                                                        <%= exam.getExaminationNote()%>
                                                    </div>


                                                    <% }%>

                                                    <%

                                                        if (patientDiagnosis.size() > 0) {%>
                                                    <div style="width: 45%; font-size: 12px;  border: solid 1px #DDD; padding: 1%;margin-right: 2%; margin-bottom: 2%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                            DIAGNOSES
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />
                                                        <table style="width: 95%" class="table table-striped">
                                                            <% for (int y = 0; y < patientDiagnosis.size(); y++) {
                                                                    Patientdiagnosis patientDiag = (Patientdiagnosis) patientDiagnosis.get(y);
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= mgr.getDiagnosis(patientDiag.getDiagnosisid()).getDiagnosis()%>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </table>

                                                    </div>

                                                    <% }%>

                                                    <%

                                                        if (patientInvestigations.size() > 0) {
                                                    %>
                                                    <div style="width: 45%; font-size: 10px; border: solid 1px #DDD; padding: 1%" class="pull-left center">
                                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase; " class="control-label" >
                                                            INVESTIGATIONS
                                                        </lead> 
                                                        <div class="clearfix"></div>
                                                        <br />
                                                        <table class="table table-striped">

                                                            <tbody>
                                                                <% for (int y = 0; y < patientInvestigations.size(); y++) {
                                                                        Patientinvestigation patientInv = (Patientinvestigation) patientInvestigations.get(y);
                                                                        Investigation investigation = mgr.getInvestigation(patientInv.getInvestigationid());
                                                                        if (investigation.getRate() > 0) {
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <%= mgr.getInvestigation(patientInv.getInvestigationid()).getName()%>
                                                                    </td>

                                                                    <td>
                                                                        <%= patientInv.getResult()%>
                                                                    </td>
                                                                </tr>

                                                                <% }
                                                                    }%>
                                                            </tbody>
                                                        </table>



                                                    </div>

                                                </div>




                                                <% }
                                                    }%>

                                            </div>




                                        </div>

                                        <% }%>

                                    </div>

                                </div>
                                <% }%>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>
        </div>



        <%}


        %>


        <!--end static dialog-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltipatient.js"></script>

        <script src="js/application.js"></script>
        <script src="js/jquery.validate.min.js"></script>

        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

        <script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

        <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
        <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="js/tablecloth.js"></script>
        <script type="text/javascript" src="js/demo.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript"> 
            
                
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();

                $(".menu").fadeIn();
                $(".alert").fadeIn();
                $(".main-c").fadeIn();
                $("#sidebar-toggle-container").fadeIn();
                $(".profile").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $("#bgimage").fadeIn();
                $(".progress1").hide();

                menu_a.click(function(e) {
                    e.preventDefault();
                    if(!$(this).hasClass('active')) {
                        menu_a.removeClass('active');
                        menu_ul.filter(':visible').slideUp('normal');
                        $(this).addClass('active').next().stop(true, true).slideDown('normal');
                    } else {
                        $(this).removeClass('active');
                        $(this).next().stop(true, true).slideUp('normal');
                    }
                });
                
                $("input:checkbox").attr("checked", false);
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true

                });
                    
                    
                $('#sidebar-toggle').click(function(e) {
                    e.preventDefault();
                    $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                    $('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('span3 hide');
                    $('.main-c').toggleClass('span8');
                
                });

                   

                   
            
                

            });
        </script>




    </body>
</html>
