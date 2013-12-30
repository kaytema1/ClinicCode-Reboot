<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ClaimSync Extended</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <link href="css/docs.css" rel="stylesheet">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/switch.css">
        <style type="text/css" title="currentStyle">
            @import "css/jquery.dataTables_themeroller.css";
            @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
            body {
                overflow: hidden; 
            }

            .large_button {
                background-color: #35AFE3;
                background-image: -moz-linear-gradient(center top , #45C7EB, #2698DB);
                box-shadow: 0 1px 0 0 #6AD2EF inset;
                color: #FFFFFF;
                text-decoration: none;
                font-weight: lighter;
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
                font-size: 36px;
            }

            .large_button:hover {
                background-color: #FBFBFB;
                background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
                background-repeat: repeat-x;
                border: 1px solid #DDDDDD;
                border-radius: 3px 3px 3px 3px;
                box-shadow: 0 1px 0 #FFFFFF inset;
                list-style: none outside none;
                color: #777777;
                /* padding: 7px 14px; */
            }

            .table th {
                border-top: 1px solid #DDDDDD;
                line-height: 18px;
                padding: 8px;

                text-align: center;
                vertical-align: top;
            }

            .table td {
                border-top: 1px solid #DDDDDD;
                font-size: 15px;
                line-height: 25px;
                padding: 5px;
                padding-bottom: 0px;
                text-align: center;
                vertical-align: middle;
            }

        </style>

        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />



        <%
            Users user = (Users) session.getAttribute("staff");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            //Patient p = (Patient)session.getAttribute("patient");
            //get current date time with Date()
            Date date = new Date();
            //System.out.println(dateFormat.format(date));

            List visits = mgr.listSecondaryConsultation("account_8");
            List treatments = null;

            // for (int i = 0; i < visits.size(); i++) {
            //   Visitationtable visit = (Visitationtable) visits.get(i);
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

                        <li class="active">
                            <a href="#">Accounts</a><span class="divider"></span>
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

                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">



                        <div class="span9 thumbnail well content">

                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th style="font-size: 12px;"> Patient #</th>
                                        <th style="font-size: 12px;"> Patient Name </th>
                                        <th style="font-size: 12px;"> Date of Birth  </th>
                                        <th style="font-size: 12px;"> Sponsor </th>
                                        <th style="font-size: 12px;"> Policy ID </th>
                                        <th style="font-size: 12px;"> Request Date </th>
                                        <th style="text-transform: capitalize; font-size: 12px;"> <%=(String) session.getAttribute("unit")%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (visits != null) {

                                            String pId = "";
                                            PatientRegistration pReg = null;
                                            List result;
                                            boolean paymentStatus = false;


                                            for (int i = 0; i < visits.size(); i++) {
                                                Visitationtable vst = (Visitationtable) visits.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <div class="dialog" id="<%=vst.getVisitid()%>_dialog" title="TRANSACTION ENTRY">
                                                <span class="span4">
                                                    <dl class="dl-horizontal">
                                                        <dt style="text-align: left;" >Date:</dt>
                                                        <dd><%= formatter.format(vst.getDate())%> </dd>
                                                        <dt style="text-align: left;" >Reference:</dt>
                                                        <dd style="text-transform: uppercase;"><%= formatter.format(vst.getDate())%>/<%= vst.getPatientid()%></dd>
                                                        <dt style="text-align: left;" >Patient ID:</dt>
                                                        <dd style="text-transform: uppercase;"><%= vst.getPatientid()%></dd>
                                                        <dt style="text-align: left;" >Patient Name:</dt>
                                                        <dd><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                            <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                            <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                        </dd>
                                                        <dt style="text-align: left;" >Sponsor:</dt>
                                                        <dd><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></dd>
                                                    </dl>
                                                </span>
                                                <div class="clearfix">
                                                </div>    
                                                <div class="center thumbnail">
                                                    <span style="font-weight: bolder;" class="lead"> <u> OFFICIAL RECEIPT </u> </span>
                                                    <%

                                                        Double total = 0.0;
                                                        String previouslocation = vst.getPreviouslocstion();

                                                        String[] previouslocations = previouslocation.split("_");
                                                        if (previouslocations[0].equals("pharmacy")) {%>
                                                    <form action="action/accountsaction.jsp" method="post">

                                                        <table  class="table">
                                                            <thead>
                                                                <tr style="color: #000; font-size: 10px;">
                                                                    <th>Requested  </th>
                                                                    <th>Quantity </th>
                                                                    <th>Unit Cost </th>
                                                                    <th>Total </th>
                                                                    <th>Tendered</th>
                                                                    <th>Balance</th>
                                                                    <th>Payment</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%
                                                                    if (mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {
                                                                        List ptreatmentss = mgr.patientTreatment(vst.getVisitid());

                                                                        if (ptreatmentss != null && !ptreatmentss.isEmpty()) {
                                                                            for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                                Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
                                                                                // if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No")) {
%>
                                                                <tr>
                                                                    <td>
                                                                        <%=mgr.getNhistreatment(ptPatienttreatments.getTreatmentid()).getMedicine()%> </td>
                                                                    <td><%=ptPatienttreatments.getQuantity()%> </td>
                                                                    <td><%=ptPatienttreatments.getPrice()%> </td>

                                                                    <td><%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%></td>
                                                                    <%if (ptPatienttreatments.getDispensed().equals("Afford")) {%>
                                                                    <td>
                                                                        <input accept=""class="input-mini" type="text" name="mn_<%=ptPatienttreatments.getId()%>"/>
                                                                        <input type="hidden" name="pid[]" value="<%=ptPatienttreatments.getId()%>"/>
                                                                    </td>
                                                                    <td id="outstanding"></td>
                                                                    <td><input type="checkbox" name="paid[]" value="<%=ptPatienttreatments.getId()%>"/></td>
                                                                        <% total = total + (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice());%>

                                                                    <%}
                                                                        if (ptPatienttreatments.getDispensed().equals("No")) {%>
                                                                    <td>Cannot Afford</td>
                                                                    <td>
                                                                        <%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%>
                                                                    </td>
                                                                    <td></td>

                                                                    <%}
                                                                        if (ptPatienttreatments.getDispensed().equals("paid")) {%>
                                                                    <td><%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%></td>
                                                                    <td>0</td>
                                                                    <td>Awaiting Dispensing</td>
                                                                    <%}
                                                                        if (ptPatienttreatments.getDispensed().equals("Dispensed")) {%>
                                                                    <td>
                                                                        <%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%> 
                                                                    </td>
                                                                    <td>0</td>
                                                                    <td>Dispensed</td>
                                                                    <%}%>


                                                                </tr>

                                                                <%}
                                                                    }
                                                                %>
                                                                <tr>
                                                                    <td>Total Cost</td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td><%=total%></td>
                                                                </tr>
                                                            </tbody>
                                                            <%} else {

                                                                List ptreatmentss = mgr.patientTreatment(vst.getVisitid());

                                                                if (ptreatmentss != null && !ptreatmentss.isEmpty()) {
                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                        Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
                                                                        // if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No")) {
%>
                                                            <tr>
                                                                <td>
                                                                    <%=mgr.getTreatment(ptPatienttreatments.getTreatmentid()).getTreatment()%> </td>
                                                                <td><%=ptPatienttreatments.getQuantity()%> </td>
                                                                <td><%=ptPatienttreatments.getPrice()%> </td>

                                                                <td><%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%></td>
                                                                <%if (ptPatienttreatments.getDispensed().equals("Afford")) {%>
                                                                <td>
                                                                    <input accept=""class="input-mini" type="text" name="mn_<%=ptPatienttreatments.getId()%>"/>
                                                                    <input type="hidden" name="pid[]" value="<%=ptPatienttreatments.getId()%>"/>
                                                                </td>
                                                                <td id="outstanding"></td>
                                                                <td><input type="checkbox" name="paid[]" value="<%=ptPatienttreatments.getId()%>"/></td>
                                                                    <% total = total + (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice());%>

                                                                <%}
                                                                    if (ptPatienttreatments.getDispensed().equals("No")) {%>
                                                                <td>Cannot Afford</td>
                                                                <td>
                                                                    <%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%>
                                                                </td>
                                                                <td></td>

                                                                <%}
                                                                    if (ptPatienttreatments.getDispensed().equals("paid")) {%>
                                                                <td><%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%></td>
                                                                <td>0</td>
                                                                <td>Awaiting Dispensing</td>
                                                                <%}
                                                                    if (ptPatienttreatments.getDispensed().equals("Dispensed")) {%>
                                                                <td>
                                                                    <%= (ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice())%> 
                                                                </td>
                                                                <td>0</td>
                                                                <td>Dispensed</td>
                                                                <%}%>


                                                            </tr>

                                                            <%}
                                                                }
                                                            %>
                                                            <tr>
                                                                <td>Total Cost</td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td><%=total%></td>
                                                            </tr>
                                                            </tbody>
                                                            <%}%>
                                                        </table>

                                                        <div style="text-align: center;" class="form-actions">
                                                            <button type="button" name="action"  class="btn btn-inverse btn-small pull-left">

                                                                <i class="icon-white icon-print"> </i> Print
                                                            </button>
                                                            <button class="btn btn-info btn-small" href="" onclick='printSelection(document.getElementById("print"));return false'>
                                                                <i class="icon-white icon-print"></i> Print
                                                            </button>
                                                            <!-- <input type="hidden" name="unitid" value="Accounts"/>-->
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <!-- <input type="submit" name="action" value="Forward to Accounts"/>-->
                                                            <select name="unitid" class="pull-right">
                                                                <%
                                                                    List units = mgr.listUnits();
                                                                    for (int j = 0; j < units.size(); j++) {
                                                                        Units unit = (Units) units.get(j);
                                                                %>
                                                                <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option> 
                                                                <% }
                                                                    List wards = mgr.listWard();
                                                                    for (int j = 0; j < wards.size(); j++) {
                                                                        Ward ward = (Ward) wards.get(j);
                                                                %>
                                                                <option value="<%=ward.getType()%>_<%=ward.getWardid()%>"><%=ward.getWardname()%></option> 
                                                                <% }

                                                                %>
                                                            </select>
                                                            <br/>
                                                            <div class="clearfix">

                                                            </div>

                                                            <button type="submit" name="action" value="Pharmacy Receipt" class="btn btn-danger btn-small pull-right">

                                                                <i class="icon-white icon-arrow-right"> </i> Forward
                                                            </button>
                                                        </div>
                                                    </form>
                                                    <%}%>
                                                    <%
                                                        String prev = vst.getPreviouslocstion();
                                                        String[] prevs = prev.split("_");
                                                        if (prevs[0].equals("lab")) {%>
                                                    <form action="action/accountsaction.jsp" method="post">


                                                        <table class="table">
                                                            <thead>
                                                                <tr style="color: #000;">
                                                                    <th>Requested dd</th>
                                                                    <th>Quantity </th>
                                                                    <th>Unit Cost </th>
                                                                    <th>Total </th>
                                                                    <!-- <th>Amount Paid</th>
                                                                     <th>Outstanding Amount</th>  -->
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%if (mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {
                                                                        List pinvestigations = mgr.patientInvestigation(vst.getVisitid());
                                                                        for (int u = 0; u < pinvestigations.size(); u++) {
                                                                            Patientinvestigation patientinvestigation = (Patientinvestigation) pinvestigations.get(u);


                                                                            if (patientinvestigation != null) {
                                                                                if (patientinvestigation.getPerformed().equalsIgnoreCase("No")) {%>
                                                                <tr style="color:  red">

                                                                    <td >
                                                                        <%=mgr.getNhisInvestigation(patientinvestigation.getInvestigationid()).getName()%>
                                                                    </td>
                                                                    <td><%=patientinvestigation.getQuantity()%> </td>
                                                                    <td><%=patientinvestigation.getPrice()%></td>
                                                                    <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                        double tt = patientinvestigation.getPrice() * qty;%>
                                                                    <td><%=tt%></td>
                                                                 <!--   <td><input type="text"class="input-small" name="nm_<%=patientinvestigation.getId()%>" readonly="readonly"/></td>
                                                                    <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                                    <td>CANNOT AFFORD</td>
                                                                </tr>

                                                                <% }
                                                                    if (patientinvestigation.getPerformed().equalsIgnoreCase("paid")) {%>
                                                                <tr>

                                                                    <td >
                                                                        <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%>
                                                                    </td>
                                                                    <td><%=patientinvestigation.getQuantity()%> </td>
                                                                    <td><%=patientinvestigation.getPrice()%></td>
                                                                    <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                        double tt = patientinvestigation.getPrice() * qty;%>
                                                                    <td><%=tt%></td>
                                                                    <!--   <td>Paid</td>
                                                                       <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                                    <td>Pending Performance</td>

                                                                </tr>
                                                                <%}
                                                                    if (patientinvestigation.getPerformed().equalsIgnoreCase("Afford")) {%>
                                                                <tr>
                                                            <input type="hidden" name="vid[]" value="<%=patientinvestigation.getId()%>"/>
                                                            <td >
                                                                <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%> </td>
                                                            <td><%=patientinvestigation.getQuantity()%> </td>
                                                            <td><%=patientinvestigation.getPrice()%></td>
                                                            <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                double tt = patientinvestigation.getPrice() * qty;%>
                                                            <td><%=tt%></td>
                                                            <!-- <td></td>
                                                             <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                            <td><input class="checkValue checkbox" checkvalue="<%=tt%>" type="checkbox" name="checks[]" value="<%=patientinvestigation.getId()%>" /></td>
                                                                <% total = total + patientinvestigation.getPrice();%> 

                                                            </tr>

                                                            <%}
                                                                if (patientinvestigation.getPerformed().equalsIgnoreCase("Yes")) {%>
                                                            <tr>

                                                                <td>
                                                                    <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%> </td>
                                                                <td><%=patientinvestigation.getQuantity()%> </td>
                                                                <td><%=patientinvestigation.getPrice()%></td>
                                                                <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                    double tt = patientinvestigation.getPrice() * qty;%>
                                                                <td><%=tt%></td>
                                                                <!-- <td>%=patientinvestigation.getAmountpaid()%></td>
                                                                 <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                                <td>Performed</td>
                                                            </tr>
                                                            <%   }
                                                                    }
                                                                }
                                                            } else {
                                                                List pinvestigations = mgr.patientInvestigation(vst.getVisitid());
                                                                for (int u = 0; u < pinvestigations.size(); u++) {
                                                                    Patientinvestigation patientinvestigation = (Patientinvestigation) pinvestigations.get(u);


                                                                    if (patientinvestigation != null) {
                                                                        if (patientinvestigation.getPerformed().equalsIgnoreCase("No")) {%>
                                                            <tr style="color:  red">

                                                                <td >
                                                                    <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%>
                                                                </td>
                                                                <td><%=patientinvestigation.getQuantity()%> </td>
                                                                <td><%=patientinvestigation.getPrice()%></td>
                                                                <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                    double tt = patientinvestigation.getPrice() * qty;%>
                                                                <td><%=tt%></td>
                                                             <!--   <td><input type="text"class="input-small" name="nm_<%=patientinvestigation.getId()%>" readonly="readonly"/></td>
                                                                <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                                <td>CANNOT AFFORD</td>
                                                            </tr>

                                                            <% }
                                                                if (patientinvestigation.getPerformed().equalsIgnoreCase("paid")) {%>
                                                            <tr>

                                                                <td >
                                                                    <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%>
                                                                </td>
                                                                <td><%=patientinvestigation.getQuantity()%> </td>
                                                                <td><%=patientinvestigation.getPrice()%></td>
                                                                <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                    double tt = patientinvestigation.getPrice() * qty;%>
                                                                <td><%=tt%></td>
                                                                <!--   <td>Paid</td>
                                                                   <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                                <td>Pending Performance</td>

                                                            </tr>
                                                            <%}
                                                                if (patientinvestigation.getPerformed().equalsIgnoreCase("Afford")) {%>
                                                            <tr>
                                                            <input type="hidden" name="vid[]" value="<%=patientinvestigation.getId()%>"/>
                                                            <td >
                                                                <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%> </td>
                                                            <td><%=patientinvestigation.getQuantity()%> </td>
                                                            <td><%=patientinvestigation.getPrice()%></td>
                                                            <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                double tt = patientinvestigation.getPrice() * qty;%>
                                                            <td><%=tt%></td>
                                                            <!-- <td></td>
                                                             <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                            <td><input class="checkValue checkbox" checkvalue="<%=tt%>" type="checkbox" name="checks[]" value="<%=patientinvestigation.getId()%>" /></td>
                                                                <% total = total + patientinvestigation.getPrice();%> 

                                                            </tr>

                                                            <%}
                                                                if (patientinvestigation.getPerformed().equalsIgnoreCase("Yes")) {%>
                                                            <tr>

                                                                <td>
                                                                    <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName()%> </td>
                                                                <td><%=patientinvestigation.getQuantity()%> </td>
                                                                <td><%=patientinvestigation.getPrice()%></td>
                                                                <% int qty = patientinvestigation.getQuantity() == 0 ? 1 : patientinvestigation.getQuantity();
                                                                    double tt = patientinvestigation.getPrice() * qty;%>
                                                                <td><%=tt%></td>
                                                                <!-- <td>%=patientinvestigation.getAmountpaid()%></td>
                                                                 <td>%=tt - patientinvestigation.getAmountpaid()%></td>  -->
                                                                <td>Performed</td>
                                                            </tr>
                                                            <%   }
                                                                        }
                                                                    }
                                                                }%> 
                                                            <tr>
                                                                <td>Total</td>
                                                                <td></td>
                                                                <td></td>
                                                                <td><%= total%></td>
                                                                <!--   <td></td>
                                                                   <td></td>  -->
                                                                <td></td>
                                                            </tr>

                                                            </tbody>

                                                        </table>
                                                        <table class="table">
                                                            <thead>
                                                                <tr style="color: #000;">
                                                                    <th>Payment For </th>
                                                                    <th>Total </th>
                                                                    <th>Amount Tendered</th>
                                                                    <th>Balance Due </th>
                                                                    <th>Payment Status</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>

                                                                <tr>
                                                                    <td>Lab Tests</td>
                                                                    <td><input class="input-small " style="color: blue;" id="amountdue" type="text" disabled="disabled" name="amountdue" value="" id="amountdue"/></td>
                                                                    <td><input  class="input-small" style="color: blue;" id="amountpaid" type="text" name="amountsettled" value=""/></td>
                                                                    <td>
                                                                        <div class="control-group">

                                                                            <div class="controls">

                                                                                <input disabled="disabled"  class="input-small" id="balance" type="text" id="balance"    value=""/></td>

                                                                            </div>
                                                                        </div>
                                                                    <td><select class="input-medium" name="status">
                                                                            <option value="Full Payment">Full Payment</option>
                                                                            <option value="Part Payment">Part Payment</option>
                                                                            <option value="Unpaid">No Payment</option>
                                                                        </select>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table> 

                                                        <div style="text-align: center;" class="form-actions">

                                                            <!-- <input type="hidden" name="unitid" value="Accounts"/>-->
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <!-- <input type="submit" name="action" value="Forward to Accounts"/>-->
                                                            <select name="unitid">
                                                                <%
                                                                    List units = mgr.listUnits();
                                                                    for (int j = 0; j < units.size(); j++) {
                                                                        Units unit = (Units) units.get(j);
                                                                %>
                                                                <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option> 
                                                                <% }
                                                                    List wards = mgr.listWard();
                                                                    for (int j = 0; j < wards.size(); j++) {
                                                                        Ward ward = (Ward) wards.get(j);
                                                                %>
                                                                <option value="<%=ward.getType()%>_<%=ward.getType()%>"><%=ward.getWardname()%></option> 
                                                                <% }
                                                                    List consultingrooms = mgr.listConRooms();
                                                                    for (int j = 0; j < consultingrooms.size(); j++) {
                                                                        Consultingrooms consultingroom = (Consultingrooms) consultingrooms.get(j);
                                                                %>
                                                                <option value="<%=consultingroom.getType()%>_<%=consultingroom.getType()%>"><%=consultingroom.getConsultingroom()%></option> 
                                                                <% }



                                                                %>

                                                                %>
                                                            </select>
                                                            <br/>

                                                            <button type="submit" name="action" value="Laboratory Receipt" class="btn btn-danger btn-large">

                                                                <i class="icon-white icon-arrow-right"> </i> Forward
                                                            </button>
                                                        </div>
                                                    </form>
                                                    <%}
                                                        String rec = vst.getPreviouslocstion();
                                                        //String[] recs = rec.split("_");
                                                        if (rec.equals("records")) { %>
                                                    <form action="action/accountsaction.jsp" method="post">


                                                        <table class="table">
                                                            <thead>
                                                                <tr style="color: #000;">
                                                                    <th style="text-align: left;">Details </th>
                                                                    <th style="width: 30px;">Quantity</th>
                                                                    <th style="width: 30px;">Bill </th>
                                                                    <th>Approved</th>

                                                                    <!--  <th>Payment Status</th>  -->

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% List l = mgr.listPatientConsultationByVisitid(vst.getVisitid());
                                                                    System.out.println(vst.getVisitid());

                                                                    System.out.println("erorororororororo ++++++   +++++");

                                                                    System.out.println(l.size());
                                                                    Patientconsultation patientconsultation = (Patientconsultation) l.get(0);
                                                                    if (patientconsultation != null && l.size() > 0) {%>
                                                                <tr>
                                                                    <td style="text-transform: capitalize; text-align: left;"><%=mgr.getConsultationId(patientconsultation.getTypeid()).getContype()%></td>
                                                                    <td> 1 </td>
                                                                    <td style="text-align: right;"> <%=mgr.getConsultationId(patientconsultation.getTypeid()).getAmount()%><input class="input-small " style="color: blue;" id="amountdue" type="hidden" disabled="disabled" value="<%=mgr.getConsultationId(patientconsultation.getTypeid()).getAmount()%>" id="amountdue"/></td>
                                                                    <td style="width: 100px"> 



                                                                        <label class="switch-container">
                                                                            <input type="checkbox" id="consultation_check" checkvalue="<%=mgr.getConsultationId(patientconsultation.getTypeid()).getAmount()%>"  style="width: 100px" class="switch-input checkValue hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label> 
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left; border-top: solid 2px black;"> <b> Total Bill </b> </td>
                                                                    <td style="border-top: solid 2px black;"> </td>
                                                                    <td style="text-align: right; border-top: solid 2px black;"><span id="amountduetext"> <%=mgr.getConsultationId(patientconsultation.getTypeid()).getAmount()%> </span><input class="input-mini " style="color: blue;" id="amountdue" type="hidden" disabled="disabled" value="<%=mgr.getConsultationId(patientconsultation.getTypeid()).getAmount()%>" id="amountdue"/></td>
                                                                    <td style="border-top: solid 2px black;"></td>    
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left;"> <b> Amount Paid </b> </td>
                                                                    <td> </td>
                                                                    <td style="text-align: right;"> <input  class="input-mini" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;" id="amountpaid" type="text" name="amountpaid" value=""/></td>
                                                                    <td></td>

                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left;">  <b id="balancetext2"> Balance Due </b>  </td>
                                                                    <td> </td>
                                                                    <td style="text-align: right;"> <div class="control-group">

                                                                            <div class="controls">

                                                                                <span style="margin: 0px;" id="balancetext">

                                                                                </span>
                                                                                <input disabled="disabled"  class="input-small" id="balance" type="hidden"   value=""/>

                                                                            </div>
                                                                        </div></td>
                                                                    <td></td>

                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print" style="display: none">
                                                                            <section class="hide" id="dashboard">

                                                                                <!-- Headings & Paragraph Copy -->
                                                                                <div class="container">

                                                                                    <div style="margin-bottom: -15px;" class="row">
                                                                                        <div class="span3" style="float: left;">
                                                                                            <img src="images/danpongclinic.png" width="300px;" style="margin-top: 30px;" />
                                                                                        </div>

                                                                                       <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" />  

                                                                                     
                                                                                    </div>
                                                                                </div>

                                                                                <div style="clear: both;"></div>

                                                                                <hr style="border: solid #000000 0.5px ;"  />

                                                                                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                                                                    <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> OFFICIAL RECEIPT </h3>

                                                                                </div>
                                                                                <hr class="row" style="border-top: 2px dashed #45BF55;margin-top: 0px;" >


                                                                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">



                                                                                    <table style="width: 300px; float: left; margin-left: 20px; font-size:  12px;">
                                                                                        <tr>
                                                                                            <td style="line-height: 25px;">
                                                                                                Patient Id:
                                                                                            </td>
                                                                                            <td style="line-height: 25px; text-transform: uppercase">
                                                                                                <%= vst.getPatientid()%>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="line-height: 25px;">
                                                                                                Name:
                                                                                            </td>
                                                                                            <td style="line-height: 25px;">
                                                                                                <%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                                                                <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                                                                <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="line-height: 25px;">
                                                                                                Referred By:
                                                                                            </td>
                                                                                            <td style="line-height: 25px;">

                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>


                                                                                    <table style="width: 300px;  float: right; font-size:  12px;">
                                                                                        <tr>
                                                                                            <td style="line-height: 25px;">
                                                                                                Date
                                                                                            </td>
                                                                                            <td style="line-height: 25px;">
                                                                                                <%= formatter.format(vst.getDate())%>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="line-height: 25px;">
                                                                                                Age / Sex
                                                                                            </td>
                                                                                            <td style="line-height: 25px;">
                                                                                                <% String yr = mgr.getPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                                                                                    String tt = yr.split("-")[0];
                                                                                                    //String tyr = new Date()+"";
                                                                                                    SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                                                                    String tyr = dateFormat1.format(new Date()) + "";
                                                                                                    String t = tyr.split("-")[0];
                                                                                                %>

                                                                                                <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Yrs / <%=mgr.getPatientByID(vst.getPatientid()).getGender()%>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="line-height: 25px;">
                                                                                                Facility
                                                                                            </td>
                                                                                            <td style="line-height: 25px;">
                                                                                                <%=mgr.sponsorshipDetails(vst.getPatientid()).getType()%> Patient
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <div style="clear: both;"></div>

                                                                                    <hr class="row" style="border-top: 2px dashed #45BF55;
                                                                                        margin-top: 5px;" >
                                                                                    <div class="row center">

                                                                                        <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing:  ">CONSULTATION</h3>

                                                                                    </div>

                                                                                    <table style="width: 100%" cellspacing="0">
                                                                                        <thead>
                                                                                            <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;">Details </th>
                                                                                                
                                                                                                <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none;">Bill</th>

                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                                            <tr>
                                                                                                <td style="padding-left: 15px; line-height: 25px;">
                                                                                                    <%=mgr.getConsultationId(patientconsultation.getTypeid()).getContype()%>
                                                                                                </td>
                                                                                                <td style="width: 80px; text-align: right; padding-left: 15px; line-height: 25px;">
                                                                                                    <%=mgr.getConsultationId(patientconsultation.getTypeid()).getAmount()%>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td style="border-top: solid 1px black">
                                                                                                    <b>   Total Bill </b>
                                                                                                </td>
                                                                                                <td style="border-top: solid 1px black">
                                                                                                    <span style="text-align: right; font-weight: bold" id="amountduetext1"> </span>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <hr class="row" style="border-top: 2px dashed #000;
                                                                                        margin-top: 5px;" >

                                                                                    <br />

                                                                                    <hr class="row" style="border-top: 2px dashed #000;
                                                                                        margin-top: 5px;" >

                                                                                    <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                                                                        <br />
                                                                                        <br />
                                                                                        <span style="letter-spacing: 5px;" >***************************</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Report</span> <span style="letter-spacing: 5px;" >***************************</span>
                                                                                        <br />
                                                                                      
                                                                                    </div>
                                                                                </div>
                                                                             <img src="images/danpongfooter.png" width="100%" style="position: absolute; bottom: 0px; "/>         
                                                                          
                                                                          </section> 
                                                                        </div>
                                                                    </td>
                                                                    <td>

                                                                    </td>
                                                                    <td>

                                                                    </td>
                                                                    <td>

                                                                    </td>
                                                                </tr>

                                                                <%}
                                                                %>
                                                            </tbody>
                                                        </table>
                                                        <div style="text-align: center;" class="form-actions">
                                                            <button class="btn btn-small btn-info pull-left" type="button" onclick='printSelection(document.getElementById("print")); return false'>
                                                                <i class="icon-print icon-white"></i> Print Now
                                                            </button>
                                                            <!-- <input type="hidden" name="unitid" value="Accounts"/>-->
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="cid" value="<%=patientconsultation.getId()%>"/>
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="unitid" value="vitals_14"/>
                                                            <!-- <input type="submit" name="action" value="Forward to Accounts"/>-->

                                                           <!-- <select class="input-medium pull-right" name="unitid">
                                                                <%

                                                                    List list = mgr.listWard();
                                                                    for (int r = 0; r < list.size(); r++) {
                                                                        Ward ward = (Ward) list.get(r);

                                                                %>

                                                                <option value="<%=ward.getType()%>_<%=ward.getWardid()%>"><%=ward.getWardname()%></option>
                                                                <%}
                                                                    List lists = mgr.listUnits();

                                                                    for (int v = 0; v < lists.size(); v++) {
                                                                        Units unit = (Units) lists.get(v);


                                                                %>  

                                                                <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option>
                                                                <%}
                                                                %>
                                                            </select>-->

                                                            <br/>
                                                            <div class="clearfix">

                                                            </div>

                                                            <button type="submit" name="action" value="Consultation Receipt" class="btn btn-danger btn-small pull-right">

                                                                <i class="icon-white icon-arrow-right"> </i> Forward
                                                            </button>
                                                        </div>
                                                    </form>
                                                    <%}%>

                                                </div>
                                            </div>
                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bold" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>

                                        <td><%=formatter.format(vst.getDate())%> </td>

                                        <td>
                                            <button class="btn btn-info btn-small" id="<%=vst.getVisitid()%>_link">
                                                <i class="icon-white icon-check"></i> Make Payment
                                            </button></td>
                                    </tr>
                                    <%}
                                        }%> 

                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <footer style="display: none; margin-top: 50px;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

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
    
    
    function printSelection(node){

        var content=node.innerHTML
        var pwin=window.open('','print_content','width=950,height=1200');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
    
    
    $(function() {
        

        $("input:checkbox").attr("checked", false);
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        //menu_ul.hide();

        $(".menu").fadeIn();
        $(".content1").fadeIn();
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
        $(".alert").fadeIn();
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

        
       
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 300

        }); 
        $(".patient").popover({

            placement : 'right',
            animation : true

        });
        
        
        var checkedValue = 0;
        $("#amountdue").attr("value",parseFloat(0));
        $("#amountduetext").html("0.0");
        $("#balance").attr("value",parseFloat(0));
        $("#balancetext").html("0.0");
        $("#amountpaid").attr("value",parseFloat(0))
        
        $("#amountpaid").live('keyup',function(){
           
            var amountdue = $("#amountdue").attr("value");
            var amountpaid = $("#amountpaid").attr("value");
            
            if(amountpaid == ""){
                amountpaid = 0;
            }
            
            var balance = amountpaid - amountdue;
            
            
            
            if(balance < 0){
                
                $('#balance').closest('.control-group').addClass('error').removeClass('success')
                $('#balancetext').addClass('text-error').removeClass('text-success')
                $('#balancetext2').addClass('text-error').removeClass('text-success')
               
            }
            
            else if(balance == 0){
                
                $('#balance').closest('.control-group').addClass('info').removeClass('success').removeClass('error')
                $('#balancetext').addClass('text-info').removeClass('text-success').removeClass('text-error')
                $('#balancetext2').addClass('text-info').removeClass('text-success').removeClass('text-error')
            }
            else{
                
                $('#balance').closest('.control-group').addClass('success').removeClass('error')
                $('#balancetext').addClass('text-success').removeClass('text-error')
                $('#balancetext2').addClass('text-success').removeClass('text-error')
            }
            
            
            $("#balance").attr("value",balance);
            $("#balancetext").html(balance);
            
            
        });
        
        
        
        $(".checkValue").change(function(){
            
            
            var amountdue = $("#amountdue").attr("value");
            var amountpaid = $("#amountpaid").attr("value");
            if(amountpaid == ""){
                amountpaid = 0;
            }
            var balance = parseFloat(amountpaid) - parseFloat(amountdue);
            
            
            if($(this).is(':checked')){ 
                
                checkedValue += parseFloat($(this).attr("checkvalue")); 
                
                //alert(checkedValue)
                var amountpaid = $("#amountpaid").attr("value");
                if(amountpaid == ""){
                    amountpaid = 0;
                }
                
                $("#amountdue").attr("value",checkedValue);
                $("#amountduetext").html(checkedValue);
                $("#amountduetext1").html(checkedValue);
                var balance = parseFloat(amountpaid) - parseFloat(checkedValue);
                $("#balancetext").html(parseFloat(balance));
                
              
            
            }else {
                
                checkedValue -= parseFloat($(this).attr("checkvalue")); 
                
                var amountpaid = $("#amountpaid").attr("value"); 
                if(amountpaid == ""){
                    amountpaid = 0;
                }
                
                $("#amountdue").attr("value",checkedValue);
                $("#amountduetext").html(checkedValue);
                $("#amountduetext1").html(checkedValue);
                var balance = parseFloat(amountpaid) + parseFloat(checkedValue);
                $("#balancetext").html(parseFloat(balance));
                
                
              
               
                
            }
            
            
            if(balance < 0){
                
                $('#balance').closest('.control-group').addClass('error').removeClass('success')
                $('#balancetext').addClass('text-error').removeClass('text-success')
                $('#balancetext2').addClass('text-error').removeClass('text-success')
               
            }
            
            
            else{
                
                $('#balance').closest('.control-group').addClass('success').removeClass('error')
                $('#balancetext').addClass('text-success').removeClass('text-error')
                $('#balancetext2').addClass('text-success').removeClass('text-error')
            }
            
           
        });
        
        

    });

</script>



<% for (int i = 0;
            i < visits.size();
            i++) {
        Visitationtable vst = (Visitationtable) visits.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getVisitid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
    $("#<%= vst.getVisitid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getVisitid()%>_link").click(function(){
      
        $("#<%=vst.getVisitid()%>_dialog").dialog('open');
    
    })
   
    $("#<%= vst.getPatientid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getVisitid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getVisitid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>


<% }%>

</body>
</html>
