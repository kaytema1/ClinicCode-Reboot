<%--
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <style type="text/css">

            table thead th{
                background-color: #FFF !important;
                background-image: none !important;
                color: #000;
            }
        </style>
        
        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat smallformatter = new SimpleDateFormat("dd-MM-yy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy  h:mm a");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();

            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);
            ////System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;

            String labOrderId = request.getParameter("labOrderId");

            if (labOrderId == null) {
                labOrderId = "Null";
            }
            Laborders vst = mgr.getLaborders(labOrderId);
            String specimen = "";
            String latest = "";
            Investigation investigation = null;

            // String arr[]= null;

            List ptreatmentss = mgr.patientInvestigationByOrderId(vst.getOrderid());
            for (int r = 0; r < ptreatmentss.size(); r++) {
                Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                investigation = (Investigation) mgr.getInvestigation(ptPatienttreatments.getInvestigationid());
                Specimen specimen1 = mgr.getSpecimen(investigation.getSpecimenId());
                if (specimen1 != null) {
                    if (!specimen.contains(specimen1.getSpecimen())) {
                        specimen = specimen + ", " + specimen1.getSpecimen();
                    }
                }
            }

        %>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Laboratory Results Archive</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide"><div style="padding-bottom: 80px;" class="span9 thumbnail  content">



                            <%if (vst.getOutstanding() < 1) {%>
                            <%if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                            <div class="btn-group pull-right">
                                <a class="btn dropdown-toggle btn-info btn-small" data-toggle="dropdown" href="#">
                                    Action
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a onclick='printSelection(document.getElementById("print<%=vst.getOrderid()%>"));
                                        return false' href="#">Print Only </a></li>
                                    <li><a onclick='dispatch("clinic_<%=vst.getOrderid()%>");
                                        return false' href="#">Forward Only </a></li>
                                    <li><a onclick='printSelection(document.getElementById("print<%=vst.getOrderid()%>"));
                                        dispatch("clinic_<%=vst.getOrderid()%>");
                                        return false' href="#">Print & Forward </a></li>
                                </ul>
                            </div>

                                          <!--  <button class="btn btn-info btn-small" href="" onclick='printSelection(document.getElementById("print<%=vst.getOrderid()%>")); dispatch("clinic_<%=vst.getOrderid()%>");return false'>
                                                <i class="icon-white icon-print"></i> Print & Forward Result
                                            </button>  -->
                            <%} else {%>
                            <button class="btn btn-info btn-small pull-right" href="" onclick='dispatch("print_<%=vst.getOrderid()%>"); hidePrint(); printSelection(document.getElementById("print<%=vst.getOrderid()%>"));
                                
                                return false'>
                                <i class="icon-white icon-print"></i> Print Result
                            </button>
                            <%}%>
                            <%} else {%>
                            <a id="settle<%=vst.getVisitid()%>" href="laboutstandingbills.jsp" class="btn btn-danger btn-small pull-right"> <i class="icon-white icon-print"></i>  Settle Outstanding | <%=df.format(vst.getOutstanding())%> </a> 
                            <div class="clearfix">

                            </div>
                            <a  class ="btn btn-small btn-inverse pull-right" style="color: white;" href="#" id="confirm<%=vst.getVisitid()%>"> <i class="icon-white icon-lock"></i> Admin Override</a>
                            <button id="adminprint<%=vst.getVisitid()%>" class="btn btn-info btn-small hide pull-right" href="" onclick='dispatch("print_<%=vst.getOrderid()%>"); hidePrint(); printSelection(document.getElementById("print<%=vst.getOrderid()%>"));
                                return false'>
                                <i class="icon-white icon-print"></i> Print Result
                            </button>
                            <div class="hide" id="password_link<%=vst.getVisitid()%>" title='Confirm Authorization'>
                                <form class="form-horizontal">
                                    <table>
                                        <tr>
                                            <td>
                                                Username
                                            </td>

                                            <td>
                                                <input type="text" name="username" id="username<%=vst.getVisitid()%>" /><br/>

                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                Password
                                            </td>

                                            <td>
                                                <input type="password" name="password" id="password<%=vst.getVisitid()%>" /><br/>

                                            </td>



                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td>
                                                <button class="btn btn-info btn-small pull-right" id="verify<%=vst.getVisitid()%>" onclick="return false">
                                                    <i class="icon-white icon-check"></i> Confirm Printing
                                                </button>  
                                            </td>
                                        </tr>
                                    </table>

                                </form>
                            </div>
    <!--    <button id="popupdiv<%=vst.getOrderid()%>link" class="btn btn-info btn-small" href="" onclick=''>
        <i class="icon-white icon-print"></i> Settle Outstanding (<%=df.format(vst.getOutstanding())%>)
    </button>  -->
                            <%}%>

                            </button>
                            <div class="clearfix">

                            </div>


                            <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=vst.getOrderid()%>">
                                <section  id="dashboard">

                                    <!-- Headings & Paragraph Copy -->

                                    <%
                                        GeneralSettings setting = null;
                                        setting = mgr.getGeneralSettingByName("lab_report_header_active");

                                        if (setting.isValue()) {
                                    %>
                                    <div class="container">
                                        <div style="margin-bottom: -15px;" class="row clearfix">
                                            <div class="span3" style="float: left;">
                                                <img src="images/danponglab.png" width="250px;" style="margin-top: 30px;" />
                                            </div>

                                            <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" />        

                                        </div>
                                        <div style="clear: both"></div>


                                        <% }%>


                                        <%


                                            if (!setting.isValue()) {
                                        %>
                                        <table style="padding-top: 120px; color: #000;">

                                            <% } else {%>
                                            <table>
                                                <% }%>
                                                <thead  style="display: table-header-group; background-color: #FFF !important ; color: #000;">
                                                    <tr>
                                                        <th style="background-color: #FFFFFF !important; color: black;" colspan="4">
                                                            <!--  <hr style="border: solid #000000 0.5px ;"  /> -->
                                                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                                    <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> CONFIDENTIAL MEDICAL REPORT  </h3>

                                                </div>
                                                <hr class="row" style="border-top: 3px dashed black; border-bottom: none; margin-top: 0px; margin-top: 10px; margin-left: 0px" />
                                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;padding-left: 25px " class="row center">

                                                    <table style="width: 45%; float: left; margin-left: 6px; font-size:  10px; text-transform: uppercase;">

                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                LABORATORY NO.:
                                                            </td>
                                                            <td style="line-height: 18px; text-transform: uppercase">
                                                                <b> <% if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                                                                    <%=vst.getPatientid()%> 
                                                                    <%} else {%>
                                                                    <%=vst.getOrderid()%>
                                                                    <%}%></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                PATIENT NAME:
                                                            </td>
                                                            <td style="line-height: 18px;">
                                                                <% if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                                                                <b> <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                                    <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                                    <%=mgr.getPatientByID(vst.getPatientid()).getLname()%> </b>
                                                                    <%} else {%>
                                                                <b> <%=mgr.getLabPatientByID(vst.getPatientid()).getFname()%>
                                                                    <%=mgr.getLabPatientByID(vst.getPatientid()).getMidname()%>
                                                                    <%=mgr.getLabPatientByID(vst.getPatientid()).getLname()%> </b>
                                                                    <%}%>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                PATIENT SEX:
                                                            </td>
                                                            <td style="line-height: 18px;">
                                                                <% if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getGender()%>
                                                                <%} else {%>
                                                                <%=mgr.getLabPatientByID(vst.getPatientid()).getGender()%>
                                                                <%}%>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                PATIENT AGE & DOB:
                                                            </td>
                                                            <td style="line-height: 18px;">
                                                                <%
                                                                    String t = "";
                                                                    String tt = "";
                                                                    if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {
                                                                        String yr = mgr.getPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                                                        tt = yr.split("-")[0];
                                                                        //String tyr = new Date()+"";
                                                                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                                        String tyr = dateFormat1.format(new Date()) + "";
                                                                        t = tyr.split("-")[0];%>
                                                                <%} else {
                                                                        String yr = mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                                                        tt = yr.split("-")[0];
                                                                        //String tyr = new Date()+"";
                                                                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                                        String tyr = dateFormat1.format(new Date()) + "";
                                                                        t = tyr.split("-")[0];
                                                                    }%>

                                                                <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years & 
                                                                <%  if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                                                                <%= formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%>

                                                                <%} else {%>
                                                                <%= formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%>
                                                                <% }%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                PATIENT TEL NO.:
                                                            </td>
                                                            <td style="line-height: 18px;">
                                                                <%if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getContact()%>
                                                                <%} else {%><%=mgr.getLabPatientByID(vst.getPatientid()).getContact()%><%}%>
                                                            </td>
                                                        </tr>

                                                    </table>

                                                    <table style="width: 50%; float: left; margin-left: 6px; font-size:  10px; text-transform: uppercase;">


                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                REFERRED BY:
                                                            </td>
                                                            <td style="line-height: 18px;">
                                                                <%=vst.getPatientid().contains("C") || vst.getPatientid().contains("c") ? vst.getFromdoc() : vst.getPhysician()%>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                HOSPITAL / CLINIC:
                                                            </td>
                                                            <td style="line-height: 18px;">
                                                                <%= vst.getFacility()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                SPECIMEN TYPE:
                                                            </td>
                                                            <td style="line-height: 18px; text-transform: uppercase">
                                                                <%=specimen.substring(1)%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 18px; ">
                                                                COLLECTION DATE:
                                                            </td>
                                                            <td style="line-height: 20px; text-transform: uppercase; font-size: 11px;">
                                                                <%=datetimeformat.format(vst.getOrderdate())%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 18px;">
                                                                REPORT DATE:
                                                            </td>
                                                            <td style="line-height: 20px; text-transform: uppercase; font-size: 11px;">
                                                                <%=datetimeformat.format(vst.getDonedate())%>
                                                            </td>
                                                        </tr>

                                                    </table> 
                                                </div>
                                                <div style="clear: both;"></div>


                                                <hr class="row" style="border-top: 3px dashed black; border-bottom: none; margin-top: 0px; margin-top: 10px; margin-left: 0px " >

                                                </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" colspan="4">
                                                            <%
                                                            %>

                                                            <%

                                                                // get count of all investigations saved in the database
                                                                int invCount = mgr.listInvestigation().size();
                                                                // Set to hold investigation id of previous visits investigation
                                                                Set<Integer> prevInvSet = new HashSet<Integer>();

                                                                // get patient's previous visits
                                                                List pPrevVisits = mgr.listPatientPreviousVisits(vst.getPatientid(), vst.getVisitid());
                                                                boolean prevVisitsFound = false;

                                                                int pPrevVisitsSize = pPrevVisits.size();
                                                                //System.out.println("ppfpapdpa : " + pPrevVisitsSize);

                                                                ptreatmentss = mgr.patientInvestigationByOrderIdnStatus(vst.getOrderid(), "Performed");
                                                                //   List ptreatmentss = mgr.performedPatientInvestigation(vst.getVisitid(), "Performed");
                                                                //System.out.println("porkipio treatments size : " + ptreatmentss.size());
                                                                Patientinvestigation pInv;
                                                                Investigation inve;
                                                                LabtypeDetailedinv labtypeDetailedinv;
                                                                TreeMap<Integer, String> labTypesSortableMap = new TreeMap<Integer, String>();
                                                                TreeMap<Integer, String> labTypesMap = new TreeMap<Integer, String>();
                                                                List<Investigation> comparisnDetailedInvs;
                                                                List<Investigation> comparisnMainInvs;
                                                                List<Integer> mainInvIds = new ArrayList<Integer>();
                                                                List<Integer> subInvIds = new ArrayList<Integer>();
                                                                TreeMap<Integer, Patientinvestigation> mainNSubInvsMap = new TreeMap<Integer, Patientinvestigation>();
                                                                List<Visitationtable> pVisitationsList = new ArrayList<Visitationtable>();
                                                                boolean prevInvFound = false, showOnOwnLine = false;

                                                                Set labTypesSet = new HashSet();
                                                                Labtypes labType;
                                                                int pInvInvId;
                                                                if (!ptreatmentss.isEmpty()) {
                                                                    // get the investigations

                                                                    for (int q = 0; q < ptreatmentss.size(); q++) {
                                                                        pInv = (Patientinvestigation) ptreatmentss.get(q);

                                                                        // check if investigation is a main investigation
                                                                        pInvInvId = pInv.getInvestigationid();
                                                                        inve = mgr.getInvestigation(pInvInvId);

                                                                        if (inve.getTypeOfTestId() == 1) {  // main test
                                                                            // get laby type main test belongs to
                                                                            labtypeDetailedinv = (LabtypeDetailedinv) mgr.listLabtypeDetailedinvByDetailedInvId(inve.getDetailedInvId()).get(0);
                                                                            // add labtype id to a non duplicate set
                                                                            labTypesSet.add(labtypeDetailedinv.getLabtypeId());

                                                                            //get labtype
                                                                            labType = mgr.getLabTypeByid(labtypeDetailedinv.getLabtypeId());
                                                                            // put labtype into a map to use in ordering how the results should be displayed
                                                                            labTypesSortableMap.put(labType.getOrderNum(), labType.getLabType());

                                                                            // put labType into a map that will give u back the labtypeid given the labtype name
                                                                            labTypesMap.put(labType.getLabTypeId(), labType.getLabType());

                                                                            // list to hold ids of all main tests. comparison to be made later
                                                                            mainInvIds.add(pInvInvId);
                                                                            mainNSubInvsMap.put(pInvInvId, pInv);
                                                                        } else {
                                                                            // list to hold ids of all sub 
                                                                            subInvIds.add(pInvInvId);
                                                                            mainNSubInvsMap.put(pInvInvId, pInv);
                                                                        }

                                                                    }

                                                                    Visitationtable visitationtable;
                                                                    if (!pPrevVisits.isEmpty()) {
                                                                        prevVisitsFound = true;

                                                                        for (int py = 0; py < pPrevVisits.size(); py++) {
                                                                            //System.out.println("id : " + ((Visitationtable) pPrevVisits.get(py)).getVisitid());
                                                                            visitationtable = (Visitationtable) pPrevVisits.get(py);
                                                                            pVisitationsList.add((Visitationtable) pPrevVisits.get(py));
                                                                        }
                                                                    }

                                                                    SortedSet<Integer> keys = new TreeSet<Integer>(labTypesSortableMap.keySet());
                                                                    int labTypeId;
                                                                    int detInvId;
                                                                    int subInvId;
                                                                    Investigation inves;
                                                                    Investigation inv;
                                                                    int prevVisitId = 0;
                                                                    List prevPatientInvs;
                                                                    Patientinvestigation prevPatInv;
                                                                    String prevResult = "";
                                                                    String prevResultDate = "";
                                                                    String comment = "";

                                                                    for (Integer key : keys) {
                                                            %>


                                                            <%
                                                                String value = labTypesSortableMap.get(key);

                                                                labTypeId = mgr.getTypeKey(value, labTypesMap);
                                                            %>
                                                            <div style="text-align: center;">
                                                                <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; text-transform: uppercase; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;  ">
                                                                    <%=value%></h3> 
                                                            </div>
                                                            <table cellspacing="0">
                                                                <thead>
                                                                    <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                        <th style="width: 350px; border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;">Test Name(s) </th> 
                                                                        <th style="width: 200px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px; text-align: left; border-right: none; border-left: none; padding-left: 5px;">Current Result(s) </th>
                                                                        <th style="width: 220px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px; text-align: left; border-right: none; border-left: none; padding-left: 5px;">Previous Result(s) </th>
                                                                        <th style="width: 80px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px; border-right: none; border-left: none; text-align: left; padding-left: 5px;">Unit(s)</th>
                                                                        <th style="width: 220px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-align: left; padding-left: 5px;">Reference Range(s)</th>


                                                                    </tr>
                                                                </thead>

                                                                <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                                                    <%
                                                                        // get main laps of this lab type
                                                                        comparisnDetailedInvs = mgr.listMainInvsUnderLabType(labTypeId);

                                                                        if (!comparisnDetailedInvs.isEmpty()) {

                                                                            for (int y = 0; y < comparisnDetailedInvs.size(); y++) {
                                                                                detInvId = ((Investigation) comparisnDetailedInvs.get(y)).getDetailedInvId();

                                                                                // this detailed investigation was performed during this visit ?
                                                                                if (mainInvIds.contains(detInvId)) {

                                                                                    // get subinvs associated with main inv
                                                                                    comparisnMainInvs = mgr.listSubInvUnderMainInv(detInvId);

                                                                                    if (comparisnMainInvs.isEmpty()) {  // no sub invs exist under main inv
                                                                                        Investigation mainInv = mgr.getInvestigation(detInvId);
                                                                                        //System.out.println("********* " + mgr.getInvestigation(detInvId).getName());

                                                                                        Patientinvestigation patInv = mgr.getPatInvInstance(detInvId, mainNSubInvsMap);

                                                                    %> 
                                                                    <% if (patInv.getPerformed().equalsIgnoreCase("Performed")) {%> 
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>"  style="line-height: 18px; margin: 0px; padding: 0px;">
                                                                        <%
                                                                            //System.out.println("--- " + patInv.getResult());

                                                                            String unit = mainInv.getUnits();

                                                                            if (unit.equals("NA")) {
                                                                                unit = "";
                                                                            }
                                                                        %>


                                                                        <td  style="text-align: left; padding-left: 5px;">
                                                                            <input type="checkbox" checked="checked" id="patInv<%=patInv.getInvestigationid()%>checkbox" style="margin-right: 10px;" class="pull-left no-print"/>  
                                                                            <%=mgr.getInvestigation(detInvId).getName()%>
                                                                        </td>

                                                                        <%
                                                                            if (!pVisitationsList.isEmpty()) {
                                                                                prevInvFound = false;
                                                                                showOnOwnLine = false;

                                                                                for (int qt = 0; qt < pVisitationsList.size(); qt++) {
                                                                                    prevVisitId = pVisitationsList.get(qt).getVisitid();
                                                                                    //System.out.println("incoming : " + pVisitationsList.get(qt).getVisitid());

                                                                                    prevPatientInvs = mgr.patientParticularInvDoneOnParticularVisit(mainInv.getDetailedInvId(), prevVisitId);

                                                                                    if (prevPatientInvs.size() > 0) {
                                                                                        prevPatInv = (Patientinvestigation) prevPatientInvs.get(0);
                                                                                        //System.out.println("found him " + prevPatInv.getId());
                                                                                        prevResult = prevPatInv.getResult();
                                                                                        prevResultDate = prevPatInv.getDate() + "";
                                                                                        prevInvFound = true;
                                                                                        if (prevResult.length() > 25) {
                                                                                            showOnOwnLine = true;
                                                                                        }
                                                                                        break;
                                                                                    }
                                                                                }
                                                                            }

                                                                        %>

                                                                        <%

                                                                            ArchivedRefRangeUni uniRange = null;
                                                                            ArchivedRefRangeDet detRange = null;
                                                                            List uniRanges = null;
                                                                            List detRanges = null;
                                                                            int uniRangeSelected = 0;
                                                                            String genlower = "";
                                                                            String genupper = "";
                                                                            String checkRefRange = mainInv.getRefRangeType();
                                                                            String genRefRange = mainInv.getRefRangeType();
                                                                            boolean foundLongerGenRefRange = false;

                                                                            if (!genRefRange.equals("non")) {

                                                                                if (genRefRange.equals("uni")) {
                                                                                    // universal reference range
                                                                                    uniRanges = mgr.listArchiveUniRef(patInv.getId(), patInv.getOrderid());
                                                                                    if (uniRanges.size() > 0 && uniRanges != null) {
                                                                                        uniRange = (ArchivedRefRangeUni) (uniRanges.get(0));
                                                                                        if (uniRange != null) {
                                                                                            uniRangeSelected = uniRange.getSelected();

                                                                                            if (uniRangeSelected == 1) {  // paragraphic universal reference range
                                                                                                genRefRange = uniRange.getParagraphic();
                                                                                            } else if (uniRangeSelected == 2) {  // lower and upper ranges
                                                                                                genRefRange = uniRange.getLowerRefRange() + " - " + uniRange.getUpperRefRange();
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }

                                                                                if (genRefRange.equals("det")) {
                                                                                    detRanges = mgr.listArchiveDetRef(patInv.getId(), patInv.getOrderid());
                                                                                    if (detRanges.size() > 0 && detRanges != null) {
                                                                                        detRange = (ArchivedRefRangeDet) (detRanges.get(0));
                                                                                        if (detRange != null) {
                                                                                            if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {
                                                                                                if (mgr.getPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Male")) {
                                                                                                    genlower = detRange.getMLower();
                                                                                                    genupper = detRange.getMUpper();
                                                                                                    genRefRange = genlower + " - " + genupper;
                                                                                                } else {
                                                                                                    genlower = detRange.getFLower();
                                                                                                    genupper = detRange.getFUpper();
                                                                                                    genRefRange = genlower + " - " + genupper;
                                                                                                }
                                                                                            } else {
                                                                                                if (mgr.getLabPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Female")) {
                                                                                                    genlower = detRange.getFLower();
                                                                                                    genupper = detRange.getFUpper();
                                                                                                    genRefRange = genlower + " - " + genupper;
                                                                                                } else {
                                                                                                    genlower = detRange.getMLower();
                                                                                                    genupper = detRange.getMUpper();
                                                                                                    genRefRange = genlower + " - " + genupper;
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } else {
                                                                                genRefRange = "";
                                                                            }
                                                                        %>
                                                                        <td  style="text-align: left; padding-left: 5px;">

                                                                            <% if (patInv.getPerformed().equals("Performed")) {%>
                                                                            <% try {
                                                                                    if (checkRefRange.equalsIgnoreCase("det")) {

                                                                                        if (Double.parseDouble(patInv.getResult()) < Double.parseDouble(genlower) || Double.parseDouble(patInv.getResult()) > Double.parseDouble(genupper)) {%>
                                                                            <b><%=patInv.getResult()%></b>
                                                                            <% } else {%>
                                                                            <%=patInv.getResult()%><%}
                                                                            } else {%> <%=patInv.getResult()%>
                                                                            <%}
                                                                                } catch (NumberFormatException ne) {
                                                                                    out.print(patInv.getResult());
                                                                                }
                                                                            } else if (patInv.getPerformed().equals("Pending")) {%>
                                                                            Not Performed
                                                                            <% }%>                                                                                                                </td>
                                                                        <td  style="text-align: left;">
                                                                            <%
                                                                                List l = mgr.listPatientPreviousTest(patInv.getInvestigationid(), patInv.getPatientid());
                                                                                if (l != null && l.size() > 1) {
                                                                                    System.out.println("more than 1 " + patInv.getId() + " " + l.size());
                                                                                    for (int g = 0; g < l.size(); g++) {
                                                                                        System.out.println("hhhhhhh dispatch");
                                                                                        Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(g);

                                                                                        if ((patientinvestigation.getId() + "").equals("" + patInv.getId())) {
                                                                                            System.out.println("hhhhhhh dispatch one " + mgr.compareTo(patientinvestigation, patInv) + "");
                                                                                            int index = l.indexOf(patientinvestigation);
                                                                                            System.out.println(index);
                                                                                            if ((index + 1) < l.size()) {
                                                                                                Patientinvestigation patientinvestigation1 = (Patientinvestigation) l.get(index + 1);
                                                                                                if (patientinvestigation1 != null) {%>
                                                                            <b style="font-size: 9px; font-weight: normal; float: left; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : patientinvestigation1.getResult()%></b>&nbsp;<b style="font-size: 8px; font-weight: normal; float: right; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : smallformatter.format(patientinvestigation1.getDate())%></b>
                                                                            <%}
                                                                                            }
                                                                                        }
                                                                                        //break;

                                                                                    }
                                                                                }%>    
                                                                        </td>
                                                                        <td  style="text-align: left; padding-left: 5px;">
                                                                            <%=unit%>
                                                                        </td>
                                                                        <td  style="text-align: left; padding-left: 10px;">
                                                                            <%
                                                                                //System.out.println("gner : " + genRefRange.length());
                                                                                // if (genRefRange.equalsIgnoreCase("det")) {
                                                                                if (genRefRange.length() > 25) {
                                                                                    foundLongerGenRefRange = true;
                                                                                }
                                                                                if (!foundLongerGenRefRange && genRefRange != "") {
                                                                            %>

                                                                            (<%=genRefRange%>)
                                                                            <% }
                                                                                //  }
                                                                            %>
                                                                        </td>
                                                                    </tr>    
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>" style="margin: 0px; padding: 0px;">
                                                                        <td  style="text-align: left; padding-left: 0px; margin-top: 0px; padding-top: 0px;" colspan="5">
                                                                            <hr style="border-bottom: dashed 0.001px grey; border-top: none; border-left: none; border-right: none; width: 100%">
                                                                        </td>
                                                                    </tr>
                                                                    <%
                                                                        if (foundLongerGenRefRange) {
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>" style="margin: 0px; padding: 0px;">
                                                                        <td style="text-align: left; padding-left: 5px; margin-top: 0px; padding-top: 0px;" colspan="5"> 
                                                                            &#8226; &emsp; &emsp; <b> Reference:  </b> <%=genRefRange%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: dotted 1px grey; border-top: none; border-left: none; border-right: none; width: 100%">
                                                                        </td>
                                                                    </tr>
                                                                    <% }%>
                                                                    <%
                                                                        if (prevInvFound && showOnOwnLine) {%>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>" style="line-height: 18px;">
                                                                        <td  style="text-align: left; padding-left: 0px;" colspan="5"> &#8226; &emsp; &emsp; <b> (Previous Results) </b> <%=prevResult%> <%= formatter.format(prevResultDate)%>

                                                                        </td>
                                                                    </tr>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: dotted 1px grey; border-top: none; border-left: none; border-right: none; width: 100%">
                                                                        </td>
                                                                    </tr>
                                                                    <% }%>

                                                                    <%

                                                                        comment = patInv.getNote() == null ? "" : patInv.getNote();
                                                                        if (!comment.isEmpty()) {
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>"  style="line-height: 18px;">
                                                                        <td  style="text-align: left; padding-left: 0px; font-weight: lighter;" colspan="5"> &#8226; &emsp; &emsp; <b>(Comments) </b> <%=comment%>

                                                                        </td>
                                                                    </tr>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: dotted 1px grey; border-top: none; border-left: none; border-right: none; width: 100%">
                                                                        </td>
                                                                    </tr>

                                                                    <%     }%>
                                                                    <%    }
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: dashed 0.01px grey; border-top: none; border-left: none; border-right: none; width: 100%"/>
                                                                        </td>
                                                                    </tr>


                                                                    <%
                                                                    } else { // sub invs exist under this main in

                                                                        //System.out.println("********* " + mgr.getInvestigation(detInvId).getName());
                                                                    %>

                                                                    <tr id="patInv<%=mgr.getInvestigation(detInvId).getDetailedInvId()%>" style="line-height: 18px;">
                                                                        <td style="padding-left: 5px; font-weight: bolder; text-transform: uppercase;" colspan="5">
                                                                            <input type="checkbox" checked="checked"  style="margin-right: 10px;" id ="patInv<%=mgr.getInvestigation(detInvId).getDetailedInvId()%>checkbox" class="pull-left no-print"/> 
                                                                            <%=mgr.getInvestigation(detInvId).getName()%>  
                                                                        </td>

                                                                    </tr>

                                                                    <% Patientinvestigation patInv;
                                                                        Investigation subInv;

                                                                    %>
                                                                    <% for (int w = 0; w < comparisnMainInvs.size(); w++) {
                                                                            subInv = (Investigation) comparisnMainInvs.get(w);
                                                                            subInvId = subInv.getDetailedInvId();
                                                                            //System.out.println("**** " + mgr.getInvestigation(subInvId).getName());

                                                                            if (subInvIds.contains(subInvId)) {
                                                                                patInv = mgr.getPatInvInstance(subInvId, mainNSubInvsMap);

                                                                                String unit = subInv.getUnits();

                                                                                if (unit.equals("NA")) {
                                                                                    unit = "";
                                                                                }

                                                                    %>  
                                                                    <%
                                                                        if (!pVisitationsList.isEmpty()) {
                                                                            prevInvFound = false;
                                                                            showOnOwnLine = false;

                                                                            for (int qt = 0; qt < pVisitationsList.size(); qt++) {
                                                                                prevVisitId = pVisitationsList.get(qt).getVisitid();
                                                                                //System.out.println("incoming : " + pVisitationsList.get(qt).getVisitid());

                                                                                prevPatientInvs = mgr.patientParticularInvDoneOnParticularVisit(subInv.getDetailedInvId(), prevVisitId);

                                                                                if (prevPatientInvs.size() > 0) {
                                                                                    prevPatInv = (Patientinvestigation) prevPatientInvs.get(0);
                                                                                    //System.out.println("found him " + prevPatInv.getId());
                                                                                    prevResult = prevPatInv.getResult();
                                                                                    prevInvFound = true;
                                                                                    if (prevResult.length() > 25) {
                                                                                        showOnOwnLine = true;
                                                                                    }
                                                                                    break;
                                                                                }
                                                                            }
                                                                        }

                                                                    %>
                                                                    <%

                                                                        ArchivedRefRangeUni uniRange = null;
                                                                        ArchivedRefRangeDet detRange = null;
                                                                        List uniRanges = null;
                                                                        List detRanges = null;
                                                                        int uniRangeSelected = 0;
                                                                        boolean foundLongerGenRefRange = false;
                                                                        String checkRefRange = subInv.getRefRangeType();
                                                                        String genRefRange = subInv.getRefRangeType();
                                                                        String genlower = "";
                                                                        String genupper = "";

                                                                        if (!genRefRange.equals("non")) {

                                                                            if (genRefRange.equals("uni")) {  // universal reference range
                                                                                uniRanges = mgr.listArchiveUniRef(patInv.getId(), patInv.getOrderid());
                                                                                if (uniRanges.size() > 0 && uniRanges != null) {
                                                                                    uniRange = (ArchivedRefRangeUni) uniRanges.get(0);

                                                                                    if (uniRange != null) {
                                                                                        uniRangeSelected = uniRange.getSelected();

                                                                                        if (uniRangeSelected == 1) {  // paragraphic universal reference range
                                                                                            genRefRange = uniRange.getParagraphic();
                                                                                        } else if (uniRangeSelected == 2) {  // lower and upper ranges
                                                                                            genRefRange = uniRange.getLowerRefRange() + " - " + uniRange.getUpperRefRange();
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }

                                                                            if (genRefRange.equals("det")) {
                                                                                detRanges = mgr.listArchiveDetRef(patInv.getId(), patInv.getOrderid());
                                                                                if (detRanges.size() > 0 && detRanges != null) {
                                                                                    detRange = (ArchivedRefRangeDet) (detRanges.get(0));
                                                                                    System.out.println("successful successful successful");
                                                                                    if (detRange != null) {
                                                                                        System.out.println("DetRange is not Null!");
                                                                                        if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {
                                                                                            if (mgr.getPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Male")) {
                                                                                                genlower = detRange.getMLower();
                                                                                                genupper = detRange.getMUpper();
                                                                                                genRefRange = genlower + " - " + genupper;
                                                                                            } else {
                                                                                                genlower = detRange.getFLower();
                                                                                                genupper = detRange.getFUpper();
                                                                                                genRefRange = genlower + " - " + genupper;
                                                                                            }
                                                                                        } else {
                                                                                            if (mgr.getLabPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Female")) {
                                                                                                genlower = detRange.getFLower();
                                                                                                genupper = detRange.getFUpper();
                                                                                                genRefRange = genlower + " - " + genupper;
                                                                                            } else {
                                                                                                genlower = detRange.getMLower();
                                                                                                genupper = detRange.getMUpper();
                                                                                                genRefRange = genlower + " - " + genupper;
                                                                                            }
                                                                                        }
                                                                                        System.out.println("Double Parse : Result " + patInv.getResult());
                                                                                        System.out.println("Double Parse : Result for " + mgr.getInvestigation(patInv.getInvestigationid()).getName() + " " + patInv.getResult());


                                                                                    }
                                                                                }
                                                                            }
                                                                        } else {
                                                                            genRefRange = "";
                                                                        }
                                                                    %>
                                                                    <%

                                                                        if (mgr.getInvestigation(patInv.getInvestigationid()).isAntibiotic()) {
                                                                            if (patInv.getPerformed().equalsIgnoreCase("Performed")) {
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  style="padding-left: 25px;">
                                                                            <input type="checkbox" checked="checked"  style="margin-right: 10px;" id="patInv<%=patInv.getInvestigationid()%>checkbox" class="pull-left  no-print"/>   
                                                                            <%=mgr.getInvestigation(subInvId).getName()%>
                                                                        </td>
                                                                        <td  colspan="4"> 

                                                                            <% if (patInv.getPerformed().equalsIgnoreCase("Performed")) {%> 
                                                                            <% if (patInv.getResult() != null) {%>
                                                                            <%=patInv.getResult()%> 
                                                                            <% }
                                                                                }
                                                                                if (patInv.getPerformed().equalsIgnoreCase("Pending")) {%>
                                                                            Not Performed
                                                                            <% }%>
                                                                        </td>
                                                                    </tr>
                                                                    <% List list = mgr.listInvestigationSuscByInvestigationId(patInv.getId());
                                                                        List list1 = mgr.listInvestigationSuscByInvestigationId(patInv.getId());
                                                                        if (list.size() > 0 || list1.size() > 0) {
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">

                                                                        <td  style="text-align: center;" colspan="5">

                                                                            <br />
                                                                            <span style="text-align: center; letter-spacing: 2px; text-transform: uppercase;">  Anti-Microbial Susceptibility Testing </span> <br />
                                                                            The Above Isolate is:
                                                                        </td>
                                                                    </tr>

                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">

                                                                        <td  style="text-align: center; " colspan="5">

                                                                            <div style="width: 50%; float: left" >
                                                                                <div  style="margin-left: 0px; text-align: right; padding-right: 40px;">

                                                                                    <ul style="text-align: right; list-style: none; " class="nav nav-list">    
                                                                                        <li> <b> Susceptible to: </b> </li>
                                                                                        <% //List list = mgr.listInvestigationSuscByInvestigationId(patInv.getId());
                                                                                            for (int z = 0; z < list.size(); z++) {
                                                                                                InvestigationResistantSusc investigationResistantSusc = (InvestigationResistantSusc) list.get(z);
                                                                                                if (investigationResistantSusc.getSusceptibleTo() > 0) {
                                                                                        %>
                                                                                        <li>
                                                                                            <%=mgr.getLabAntibiotic(investigationResistantSusc.getSusceptibleTo()).getName()%>
                                                                                        </li>

                                                                                        <%}
                                                                                            }%>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                            <div style="width: 50%; float: left;">
                                                                                <div  style="margin-left: 0px;  text-align: left; ">

                                                                                    <ul style="text-align: left; list-style: none; " class="nav nav-list">   
                                                                                        <li> <b> Resistant to: </b> </li>
                                                                                        <% //List list1 = mgr.listInvestigationSuscByInvestigationId(patInv.getId());
                                                                                            for (int z = 0; z < list1.size(); z++) {
                                                                                                InvestigationResistantSusc investigationResistantSusc = (InvestigationResistantSusc) list1.get(z);
                                                                                                if (investigationResistantSusc.getResistantTo() > 0) {
                                                                                        %>
                                                                                        <li>
                                                                                            <%=mgr.getLabAntibiotic(investigationResistantSusc.getResistantTo()).getName()%>
                                                                                        </li>

                                                                                        <%}
                                                                                            }%>
                                                                                    </ul>
                                                                                </div>

                                                                            </div>

                                                                        </td>
                                                                    </tr>
                                                                    <% }
                                                                        }
                                                                    } else {%> 
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>" style="line-height: 18px;">
                                                                        <td  style="padding-left: 25px;">
                                                                            <input type="checkbox" checked="checked"  style="margin-right: 10px; " id="patInv<%=patInv.getInvestigationid()%>checkbox" class="pull-left no-print"/>   

                                                                            <%if (mgr.getInvestigation(subInvId).isIsSubheading()) {%>
                                                                            <b> <%=mgr.getInvestigation(subInvId).getName()%></b>
                                                                            <% } else {%>
                                                                            <% System.out.println(mgr.getInvestigation(subInvId).getName());%>
                                                                            <%=mgr.getInvestigation(subInvId).getName()%>
                                                                            <%}%>
                                                                        </td>
                                                                        <td  style="text-align: left; padding-left: 5px;">

                                                                            <%if (mgr.getInvestigation(subInvId).isIsSubheading()) {%>
                                                                            <% }%>

                                                                            <% if (patInv.getPerformed().equalsIgnoreCase("Performed")) {%>
                                                                            <% System.out.println("Performed");%>
                                                                            <% if (patInv.getResult() != null) {
                                                                                    if (checkRefRange.equalsIgnoreCase("det")) {
                                                                                        if (!patInv.getResult().equals("")) {
                                                                                            try {
                                                                                                if (Double.parseDouble(patInv.getResult()) < Double.parseDouble(genlower) || Double.parseDouble(patInv.getResult()) > Double.parseDouble(genupper)) {%>
                                                                            <b><%=patInv.getResult()%></b>
                                                                            <% } else {%><%=patInv.getResult()%><%}
                                                                                    } catch (NumberFormatException ne) {
                                                                                        out.print(patInv.getResult());
                                                                                    }
                                                                                }



                                                                            } else {%><%=patInv.getResult()%><%}
                                                                                }
                                                                            } else if (patInv.getPerformed().equalsIgnoreCase("Pending")) {
                                                                                System.out.println("Pending");
                                                                            %>

                                                                            Not Performed

                                                                            <%}
                                                                                if (mgr.getInvestigation(patInv.getInvestigationid()).isAntibiotic()) {%>

                                                                            <%}%>
                                                                        </td>
                                                                        <td   style="text-align: left;">
                                                                            <%
                                                                                List l = mgr.listPatientPreviousTest(patInv.getInvestigationid(), patInv.getPatientid());
                                                                                if (l != null && l.size() > 1) {
                                                                                    System.out.println("more then 1 " + patInv.getId() + " " + l.size());
                                                                                    for (int g = 0; g < l.size(); g++) {
                                                                                        System.out.println("hhhhhhh dispatch");
                                                                                        Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(g);

                                                                                        if ((patientinvestigation.getId() + "").equals("" + patInv.getId())) {
                                                                                            System.out.println("hhhhhhh dispatch " + mgr.compareTo(patientinvestigation, patInv) + "");
                                                                                            int index = l.indexOf(patientinvestigation);
                                                                                            System.out.println(index);
                                                                                            if ((index + 1) < l.size()) {
                                                                                                Patientinvestigation patientinvestigation1 = (Patientinvestigation) l.get(index + 1);
                                                                                                if (patientinvestigation1 != null) {%>
                                                                            <b style="font-size: 9px; font-weight: normal; float: left; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : patientinvestigation1.getResult()%></b>&nbsp;<b style="font-size: 8px; font-weight: normal; float: right; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : smallformatter.format(patientinvestigation1.getDate())%></b>
                                                                            <%}
                                                                                            }
                                                                                        }
                                                                                        //break;

                                                                                    }
                                                                                }%>    
                                                                        </td>
                                                                        <td  style="text-align: left; padding-left: 5px;">
                                                                            <%=unit%>
                                                                        </td>

                                                                        <td  style="text-align: left; padding-left: 10px;">
                                                                            <%
                                                                                System.out.println("gner : two 2" + genRefRange.length());
                                                                                //if (genRefRange.equalsIgnoreCase("uni")) {
                                                                                if (genRefRange.length() > 25) {

                                                                                    foundLongerGenRefRange = true;
                                                                                }
                                                                                if (!foundLongerGenRefRange && genRefRange != "") {

                                                                            %>

                                                                            (<%=genRefRange%>)
                                                                            <% }
                                                                                //  }
                                                                            %>
                                                                        </td>
                                                                    </tr>

                                                                    <%
                                                                        if (foundLongerGenRefRange) {
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  style="text-align: left; padding-left: 5px; word-spacing: 2px; " colspan="5">
                                                                            &#8226; &emsp; &emsp; <b>Reference :</b> <%=genRefRange%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: dotted 1px grey; border-top: none; border-left: none; border-right: none; width: 100%"/>
                                                                        </td>
                                                                    </tr>

                                                                    <% }%>      

                                                                    <%
                                                                        if (prevInvFound && showOnOwnLine) {%>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  style="text-align: left; padding-left: 5px; word-spacing: 2px;" colspan="5"> 
                                                                            &#8226; &emsp; &emsp; <b>(Previous Results)<b/> <%=prevResult%> <%=prevResultDate%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>">
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: dotted 1px grey; border-top: none; border-left: none; border-right: none; width: 100%">
                                                                        </td>
                                                                    </tr>
                                                                    <% }
                                                                            // }
                                                                        }
                                                                    %>

                                                                    <%

                                                                        comment = patInv.getNote() == null ? "" : patInv.getNote();
                                                                        if (!comment.isEmpty()) {
                                                                    %>
                                                                    <tr id="patInv<%=patInv.getInvestigationid()%>" style="line-height: 18px;">
                                                                        <td  style="text-align: left; padding-left: 0px; font-weight: lighter;" colspan="5"> &#8226; &emsp; &emsp; <b>(Comments)<b/> <%=comment%>
                                                                                <br/>
                                                                                <!--     <hr style="border-bottom: dashed 1px black; border-top: none; width: 100%">  -->
                                                                        </td>
                                                                    </tr>


                                                                    <%     }
                                                                    %> 

                                                                    <% }%> 


                                                                    <%
                                                                        }

                                                                    %>
                                                                    <tr >
                                                                        <td colspan="5">
                                                                            <hr style="border-bottom: dashed 0.01px grey; border-top: none; border-left: none; border-right: none; width: 100%"/>
                                                                        </td>
                                                                    </tr>
                                                                    <%
                                                                        }
                                                                    %>


                                                                    <%
                                                                            }
                                                                        }
                                                                    %>
                                                                    <tr>
                                                                        <td  colspan="5">
                                                                            <hr style="border-bottom: solid 1px grey; border-top: none; border-left: none; border-right: none;  width: 100%">
                                                                        </td>
                                                                    </tr>
                                                                    <%
                                                                        }

                                                                    %>
                                                                </tbody>
                                                            </table>
                                                            <%

                                                                    }
                                                                }

                                                            %>

                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot style="display: table-footer-group;">

                                                    <tr>
                                                        <th  colspan="4">




                                                        </th>
                                                    </tr>
                                                </tfoot>

                                            </table>
                                            <%
                                                GeneralSettings setting1 = null;
                                                setting1 = mgr.getGeneralSettingByName("lab_report_footer_active");

                                                if (setting1.isValue()) {
                                            %>

                                            <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                                <br />
                                                <br />
                                                <span style="letter-spacing: 5px;" >***************************</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Report</span> <span style="letter-spacing: 5px;" >***************************</span>
                                                <br />
                                                Electronically Validated by: <%=mgr.getStafftableByid(vst.getScrutinized()) == null ? "" : mgr.getStafftableByid(vst.getScrutinized()).getOthername()%> <%=mgr.getStafftableByid(vst.getScrutinized()) == null ? "" : mgr.getStafftableByid(vst.getScrutinized()).getLastname()%>  
                                            </div>
                                    </div>




                                    <div style="clear: both">

                                    </div>
                                    <br />


                                    <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                        <div style="text-align: center; letter-spacing: 2px; text-transform: uppercase;">
                                            Limitations 
                                        </div>
                                        <div style="clear: both">

                                        </div>
                                        <div style="font-size: 9px;">  As with all diagnostic test(s), a definite clinical diagnosis should not be based on the result of a single test, but should only be made by  <br />
                                            the physician after all clinical and laboratory findings have been evaluated.
                                        </div>
                                    </div>
                                    <% }%>
                                </section>  
                            </div>









                        </div>

                    </div>

                </div>
                <div class="clearfix"></div>

        </div>

    </section>

    <%@include file="widgets/footer.jsp" %>

</div><!-- /container -->    

</div>
</div>
<!--end static dialog-->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap-dropdown.js"></script>
<script src="js/bootstrap-scrollspy.js"></script>
<script src="js/bootstrap-collapse.js"></script>
<script src="js/bootstrap-tooltip.js"></script>
<script src="js/bootstrap-popover.js"></script>
<script src="js/application.js"></script>

<script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

<script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
<script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

<script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
<script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

<script type="text/javascript" src="js/tablecloth.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/demo.js"></script>

<!--initiate accordion-->
<script type="text/javascript">
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();

        $(".menu").fadeIn();
        $(".content1").fadeIn();
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
        $(".alert").fadeIn();
        $(".progress1").hide();

        menu_a.click(function(e) {
            e.preventDefault();
            if (!$(this).hasClass('active')) {
                menu_a.removeClass('active');
                menu_ul.filter(':visible').slideUp('normal');
                $(this).addClass('active').next().stop(true, true).slideDown('normal');
            } else {
                $(this).removeClass('active');
                $(this).next().stop(true, true).slideUp('normal');
            }
        });

    });

    function printSelection(node) {

        var content = node.innerHTML
        var pwin = window.open('', 'print_content', 'width=950,height=1200');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">' + content + '</body></html>');
        pwin.document.close();

        setTimeout(function() {
            pwin.close();
            location.reload(); 
        }, 1000);
         
    }

    function dispatch(id) {
        //alert("here");
        //var name = document.getElementById(id).value;

        $.post('action/labaction.jsp', {action: "dispatch", name: id}, function(data) {
            //alert(data);
            $('#results').html(data).hide().slideDown('slow');
        });

    }
</script>

<script type="text/javascript">
    
    $(document).ready(function(){ 
        
        
    
    <%                              
        List patientInvestigations = mgr.patientInvestigationByOrderIdnStatus(vst.getOrderid(), "Performed");

        for (int x = 0; x < patientInvestigations.size(); x++) {
            Patientinvestigation patInv = (Patientinvestigation) patientInvestigations.get(x);
            
    %>
    
    
            $("#patInv<%=patInv.getInvestigationid()%>checkbox").change(function(){
        
                if($(this).is(':checked')){ 
            
                   
                    $("#patInv<%=patInv.getInvestigationid()%>").children().css("text-decoration","none")
                    $("#patInv<%=patInv.getInvestigationid()%>").removeAttr("class");
                    $("#patInv<%=patInv.getInvestigationid()%>").children().removeAttr("class");
                    
                    
                }else{
                    
                    $("#patInv<%=patInv.getInvestigationid()%>").attr("class","no-print");
                    $("#patInv<%=patInv.getInvestigationid()%>").children().css("text-decoration","line-through")
                    $("#patInv<%=patInv.getInvestigationid()%>").children().addClass("no-print")
                    
                    
                    
                    
                }
                
                //alert($(this).attr("class"));
            })
        
    
    <% }%>
        });
    
</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers",
            "iDisplayLength": 25,
            "aaSorting": [],
            "bSort": true,
            "sScrollY": 400

        });

        

        $(".patient").popover({
            placement: 'right',
            animation: true

        });


        $("#popupdiv<%=vst.getOrderid()%>").dialog({
            autoOpen: false,
            width: 350,
            modal: true

        });


        $("#password_link<%=vst.getVisitid()%>").dialog({
            autoOpen: false,
            width: 350,
            modal: true
        });

        $("#confirm<%=vst.getVisitid()%>").click(function() {
            $("#password_link<%=vst.getVisitid()%>").dialog("open")
        });

        $("#verify<%=vst.getVisitid()%>").click(function() {
            alert("")
            $("#password_link<%=vst.getVisitid()%>").dialog("close")
            $("#confirm<%=vst.getVisitid()%>").hide();
            $("#settle<%=vst.getVisitid()%>").hide()
            $("#adminprint<%=vst.getVisitid()%>").show()
        })

        $("#popupdiv<%=vst.getOrderid()%>link").click(function() {
            $("#popupdiv<%=vst.getOrderid()%>").dialog("open");
        })

    });



    function hidePrint(){
             
        $(".no-print").css("display","none");
        
        //alert("Printing")            
    }
    
</script>


</body>
</html>
