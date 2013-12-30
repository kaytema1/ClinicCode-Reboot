<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
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

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E dd MMM, yyyy HH:mm a");
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);
            Date date = new Date();
            //System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            // List listorders = mgr.listLabordersByStatus("Clinic");
            List listorders = mgr.listTransitLabs();
            System.out.println("laborders " + listorders.size());
            List ptreatmentss1;

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
                            <a href="labreception.jsp">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Clinic Lab Requests</a><span class="divider"></span>
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
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">

                            <table class="example display table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;"> Folder Number</th>
                                        <th style="text-align: left;"> Patient Name </th>
                                        <th style="text-align: left;"> Payment Type </th>
                                        <th style="text-align: left;"> Date of Birth  </th>


                                        <th style="text-align: left;"> Requested On </th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (listorders != null) {
                                            for (int i = 0; i < listorders.size(); i++) {
                                                TransitClinicLabs vst = (TransitClinicLabs) listorders.get(i);
                                                //String type = mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname();

                                    %>
                                    <tr>
                                        <td>
                                            <div style="max-height: 100%; overflow-y: hidden;" class="dialog" id="<%=vst.getOrderid()%>_dialog" title="Laboratory Request for <%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                 <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                 <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>">


                                                <span class="span4">
                                                    <dl class="dl-horizontal">
                                                        <dt style="text-align: left;" >Date:</dt>
                                                        <dd><%= datetimeformat.format(vst.getOrderdate())%> </dd>


                                                        <dt style="text-align: left;" >Patient Name:</dt>
                                                        <dd>
                                                            <b> <%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                                <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                                <%= mgr.getPatientByID(vst.getPatientid()).getLname()%> </b>
                                                        </dd>
                                                        <dt style="text-align: left;" >Payment Type:</dt>
                                                        <dd><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></dd>
                                                    </dl>
                                                </span>

                                                <div class="clearfix">
                                                </div>
                                                <div style="font-weight: bolder; text-align: center;" class="lead center"> <u>
                                                        REQUESTED LABS</u>  
                                                </div>

                                                <form action="action/labaction.jsp" method="post">
                                                    <div style="max-height: 350px; overflow-y: scroll"  class="center thumbnail">
                                                        <table  class="table">
                                                            <thead>
                                                                <tr>
                                                                    <th rowspan="2" style="color: #FFF;"> Test </th>
                                                                    <th rowspan="2"  style="color: #FFF; text-align: right; padding-right: 15px;"> Price </th>
                                                                    <th rowspan="2"  style="color: #FFF; width: 100px"> Approval </th>
                                                                    <!--   <th colspan="2" style="color: #FFF; width: 100px; text-align: center;"> Co Payment </th>   -->
                                                                    <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                                                    <th  colspan="3" style="color: #fff; width: 100px;"> Co-Payment

                                                                    </th>
                                                                    <% }%>
                                                                </tr>
                                                                <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                                                <tr>
                                                                    <th  style="color: #fff; width: 100px;">
                                                                        <span style="font-size: 10px;"> <%

                                                                            out.print(mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname());
                                                                            %> 
                                                                        </span>
                                                                    </th>
                                                                    <th  style="color: #fff; width: 100px;">
                                                                        <span style="font-size: 10px;"> <%
                                                                            if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {
                                                                                //out.print(mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType()));
                                                                                out.print(mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor())==null?"":mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname());
                                                                            }%> 
                                                                        </span>
                                                                    </th>
                                                                    <th style="color: #fff; width: 100px;"> Out of Pocket</th>
                                                                </tr>
                                                                <% }%> 
                                                            </thead>
                                                            <tbody>
                                                                <%List ptreatmentss = mgr.patientInvestigation(vst.getVisitid());
                                                                double primary = 0;
                                                                double secondary=0;
                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                        Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                                                                        if (ptPatienttreatments.getPrice() > 0) {
                                                                            primary = primary+(ptPatienttreatments.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getLabmarkup());
                                                                            secondary = secondary+(ptPatienttreatments.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getLabmarkup());
                                                                %>
                                                                <tr>

                                                                    <td class="investigation_row<%=vst.getOrderid()%><%=ptPatienttreatments.getInvestigationid()%>" style="line-height: 18px;"><%=mgr.getInvestigation(ptPatienttreatments.getInvestigationid()).getName()%> </td>

                                                                    <td class="investigation_row<%=vst.getOrderid()%><%=ptPatienttreatments.getInvestigationid()%>" style="text-align: right;"> 

                                                                        <%= df.format(ptPatienttreatments.getPrice())%>
                                                                        <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" value="<%= (ptPatienttreatments.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getLabmarkup())%>" />

                                                                    </td>
                                                                    <td style="width: 100px;">

                                                                        <label class="switch-container">
                                                                            <input id="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments.getInvestigationid()%>" type="checkbox" name="performed[]" value="<%=ptPatienttreatments.getId()%>" checkvalue="<%=ptPatienttreatments.getPrice()%>" style="width: 100px" class="switch-input checkValue<%=vst.getOrderid()%> hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label> 

                                                                        <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                                        <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                                        <input type="hidden" name="labid" value="<%=vst.getOrderid()%>"/>
                                                                    </td>
                                                                    
                                                                    <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                                                    <td style="text-align: center; padding-left: 25px;"> 
                                                                        <div class="clearfix"></div>
                                                                         <%=df.format((ptPatienttreatments.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getLabmarkup()))%><br/>
                                                                        <input  class="input-mini decimal" style=" display: none ;text-align: right; vertical-align: bottom" type="text" placeholder="0.00" id="1_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getInvestigationid()%>" name="<%=ptPatienttreatments.getInvestigationid()%>_primarysponsor_<%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponshorshipid()%>" value=""/>     
                                                                    </td>
                                                                    
                                                                    <td>
                                                                        <%if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                                                        <%=df.format((ptPatienttreatments.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getLabmarkup()))%><br/>
                                                                       
                                                                        <div style="display: block; text-align: center;" id="displaycon<%=vst.getPatientid()%>">
                                                                            <label style="text-align: center;" class="switch-container">
                                                                                <input type="checkbox"  name="copaymentsecondarynotcash" value="" attribute="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getInvestigationid()%>" style="width: 100px" class="switch-input hide copaymentsecondarycashdefault">
                                                                                <div class="switch">
                                                                                    <span class="switch-label">Yes</span>
                                                                                    <span class="switch-label">No</span>
                                                                                    <span class="switch-handle"></span>
                                                                                </div>  
                                                                            </label>
                                                                        </div>
                                                                        <%}%>
                                                                        <div class="clearfix"></div>
                                                                        <div style="display: block; text-align: center;">
                                                                            <%
                                                                                if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>


                                                                            <input class="input-mini decimal decimal" style="text-align: right; display: none;" type="text" 
                                                                                   name="<%=ptPatienttreatments.getInvestigationid()%>_secondarysponsor_<%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponshorshipid()%>" placeholder="0.00" id="2_copaymentsecondarycashdefault_input<%= ptPatienttreatments.getInvestigationid()%>"  value=""/>
                                                                            <%}%>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div>
                                                                            <label class="switch-container">
                                                                                <%= df.format(ptPatienttreatments.getPrice())%>
                                                                                <input type="checkbox"  name="copaymentsecondarycashdefault" value="" attribute="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getInvestigationid()%>"   style="width: 100px" class="switch-input hide copaymentsecondarycashdefault">
                                                                                <div class="switch">
                                                                                    <span class="switch-label">Yes</span>
                                                                                    <span class="switch-label">No</span>
                                                                                    <span class="switch-handle"></span>
                                                                                </div>  
                                                                            </label>
                                                                        </div>
                                                                        <div style="text-align: center; ">
                                                                            <input class="input-mini decimal decimal" style="text-align: right; display: none;" name="<%=ptPatienttreatments.getInvestigationid()%>_outofpocket" type="text" id="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getInvestigationid()%>"  value=""/>
                                                                        </div>
                                                                    </td>
                                                                    <% }%>

                                                                </tr>


                                                                <% }
                                                                    }%>

                                                                <%%>
                                                                <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 

                                                                <tr>
                                                                    <td style="text-align: left; border-top: solid 2px black;"> <b> Total Bill Credited <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></b> </td>
                                                                    <td style="text-align: right; border-top: solid 2px black;"> 
                                                                        <span style="font-weight: bolder;" class="amountduetext<%=vst.getOrderid()%>">  </span> 
                                                                        <input class="amountdueinput<%=vst.getOrderid()%>" style="color: blue;"  type="hidden" disabled="disabled" value="" /></td>
                                                                    <td  style="border-top: solid 2px black;"></td>    
                                                                </tr>
                                                                <% } else {%> 
                                                                <tr>
                                                                    <td style="text-align: left; border-top: solid 2px black;"> <b> Total Bill </b> </td>

                                                                    <td style="text-align: right; border-top: solid 2px black;"> <span class="amountduetext<%=vst.getOrderid()%>">  </span> <input class="amountdueinput<%=vst.getOrderid()%>" style="color: blue;"  type="hidden" disabled="disabled" value="" /></td>
                                                                    <td colspan="3" style="border-top: solid 2px black;"></td>    
                                                                </tr>

                                                                <% }%>
                                                            </tbody>

                                                        </table>

                                                    </div>
                                                    <div class="form-actions center">

                                                        <button class="btn btn-danger btn-small pull-right" name="action" value="fromclinic" id="">
                                                            <i class="icon-white icon-arrow-right"></i> Save and Assign Patient & Lab. Number
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>

                                            <div style="text-align: center; font-family: 'Helvetica Neue ',Helvetica,Arial,sans-serif; display: none; font-size: larger; width: 100%; height: 100%;" id="print<%=vst.getOrderid()%>" >
                                                <section class="hide" id="dashboard">

                                                    <!-- Headings & Paragraph Copy -->
                                                    <div class="container">

                                                        <div style="margin-bottom: -15px;" class="row">
                                                            <div class="span3" style="float: left;">
                                                                <img src="images/danponglab.png" width="250px;" style="margin-top: 30px;" />
                                                            </div>

                                                            <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" />        

                                                        </div>

                                                        <div style="clear: both;"></div>

                                                        <hr style="border: solid #000000 0.5px ;"  />


                                                        <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                                            <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px;text-transform: uppercase; ">LABORATORY NO: <%=vst.getOrderid()%> </h3>

                                                        </div>
                                                        <hr class="row" style="border-top: 3px dashed #45BF55; border-bottom: none; margin-top: 0px;" >
                                                        <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; " class="row center">

                                                            <table style="width: 45%; float: left; margin-left: 6px; font-size:  11px; text-transform: uppercase;">

                                                                <tr>
                                                                    <td style="line-height: 18px; width: 120px;">
                                                                        LABORATORY NO.: 
                                                                    </td>
                                                                    <td style="line-height: 18px; text-transform: uppercase">
                                                                        <%=vst.getOrderid()%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        PATIENT NAME: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <b> <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                                            <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                                            <%=mgr.getPatientByID(vst.getPatientid()).getLname()%> </b>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        PATIENT SEX: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <%=mgr.getPatientByID(vst.getPatientid()).getGender()%>

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        PATIENT AGE & DOB: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <% String yr = mgr.getPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                                                            String tt = yr.split("-")[0];
                                                                            //String tyr = new Date()+"";
                                                                            SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                                            String tyr = dateFormat1.format(new Date()) + "";
                                                                            String t = tyr.split("-")[0];
                                                                        %>

                                                                        <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years / <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        PATIENT TEL NO.: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <%=mgr.getPatientByID(vst.getPatientid()).getContact()%>
                                                                    </td>
                                                                </tr>

                                                            </table>

                                                            <table style="width: 50%; float: left; margin-left: 22px; font-size:  11px; text-transform: uppercase;">


                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        REFERRED BY:
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <%= mgr.getStafftableByid(vst.getFromdoc()).getLastname()%>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        HOSPITAL/ CLINIC: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        DANPONG CLINIC 
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        COLLECTION DATE: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <%=datetimeformat.format(vst.getOrderdate())%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        REPORT DATE: 
                                                                    </td>
                                                                    <td style="line-height: 18px;">
                                                                        <%=datetimeformat.format(vst.getOrderdate())%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 18px;">
                                                                        SPECIMEN: 
                                                                    </td>
                                                                    <td style="line-height: 18px; text-transform: uppercase">

                                                                    </td>
                                                                </tr>
                                                            </table>        


                                                            <div style="clear: both;"></div>


                                                            <hr class="row" style="border-top: 3px dashed #45BF55; border-bottom: none; margin-top: 0px; margin-top: 10px;" >
                                                            <div class="row center">

                                                                <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing:  ">LABORATORY REQUEST</h3>

                                                            </div>

                                                            <table style="width: 100%" cellspacing="0" class="table">
                                                                <thead>
                                                                    <tr style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                        <th style=" border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;"> Test </th>
                                                                        <th style="width: 80px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-align: right; padding-right: 50px;"> Price </th>

                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% ptreatmentss1 = mgr.patientInvestigation(vst.getVisitid());
                                                                        for (int r = 0; r < ptreatmentss1.size(); r++) {
                                                                            Patientinvestigation ptPatienttreatments1 = (Patientinvestigation) ptreatmentss1.get(r);
                                                                            if (ptPatienttreatments1.getPrice() > 0) {
                                                                    %>

                                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                        <td class="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>"  style="padding-left: 15px; line-height: 25px;">

                                                                            <%=mgr.getInvestigation(ptPatienttreatments1.getInvestigationid()).getName()%>

                                                                        </td>
                                                                        <td class="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>" style="line-height: 25px; text-align: right; padding-right: 50px;">
                                                                            <%=df.format(ptPatienttreatments1.getPrice())%> 

                                                                        </td>
                                                                    </tr>
                                                                    <% }
                                                                        }%>

                                                                    <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                        <td style="border-top: solid 1px black; padding-left: 15px; ">
                                                                            <b>Total Bill Credited </b>
                                                                        </td>
                                                                        <td style="border-top: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=vst.getOrderid()%>">

                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                        <td style="padding-top: 10px; padding-left: 15px;">
                                                                            Payment Status  
                                                                        </td>
                                                                        <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="paymentstatus<%=vst.getOrderid()%> ">

                                                                            Credited to <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

                                                                        </td>
                                                                    </tr>



                                                                    <% } else {%> 

                                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                        <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                            <b>   Total Bill </b>
                                                                        </td>
                                                                        <td style="border-top: solid 1px black; text-align: right; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=vst.getOrderid()%>">

                                                                        </td>

                                                                    </tr>

                                                                    <% }%>
                                                                </tbody>
                                                            </table>

                                                            <hr class="row" style="border-top: 2px solid #000; margin-top: 5px;" >

                                                            <br />


                                                            <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                                                <br />
                                                                <br />
                                                                <span style="letter-spacing: 5px;" >***************************</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Request</span> <span style="letter-spacing: 5px;" >***************************</span>
                                                                <br />

                                                            </div>  
                                                        </div>
                                                </section>  
                                            </div>  

                                            <div style="text-align: center; font-family: 'Helvetica Neue ',Helvetica,Arial,sans-serif; display: none; font-size: larger; width: 100%; height: 100%;" id="print<%=vst.getOrderid()%>receipt" >
                                                <section class="hide" id="dashboard">
                                                    <div class="container">

                                                        <div style="margin-bottom: -15px;" class="row">
                                                            <div class="span3" style="float: left;">
                                                                <img src="images/danpongclinic.png" width="120px;" style="margin-top: 30px;" />
                                                            </div>

                                                            <img src="images/danpongaddress.png" width="140px;" style="float: right; margin-top: 20px;" /> 


                                                        </div>
                                                    </div>


                                                    <div style="clear: both;"></div>

                                                    <hr style="border: solid #000000 0.5px ;"  />

                                                    <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                                        <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> 

                                                            <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                            OFFICIAL INVOICE 
                                                            <% } else {%> OFFICIAL RECEIPT <% }%> </h3>

                                                    </div>
                                                    <hr class="row" style="border-top: 2px solid #000;;margin-top: 0px;" >

                                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">

                                                        <table style="width: 300px; float: left; margin-left: 6px; font-size:  12px;">
                                                            <tr>
                                                                <td style="line-height: 25px;">
                                                                    Date
                                                                </td>
                                                                <td style="line-height: 25px;">
                                                                    <%= formatter.format(vst.getOrderdate())%>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="line-height: 25px;">
                                                                    Invoice No.
                                                                </td>
                                                                <td style="line-height: 25px;">
                                                                    INV<%=vst.getVisitid()%>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="line-height: 25px;">
                                                                    Account
                                                                </td>
                                                                <td style="line-height: 25px;">
                                                                    <%=mgr.sponsorshipDetails(vst.getPatientid()).getType()%> Patient
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
                                                                    Laboratory No.
                                                                </td>
                                                                <td style="line-height: 25px; text-transform: uppercase">
                                                                    <%= vst.getOrderid()%>
                                                                </td>
                                                            </tr>


                                                        </table>
                                                        <div style="clear: both"></div>
                                                        <table style="width: 100%" cellspacing="0" class="table">
                                                            <thead>
                                                                <tr style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                    <th style=" border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;"> Test </th>
                                                                    <th style="width: 80px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-align: right; padding-right: 20px;"> Price </th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%ptreatmentss1 = mgr.patientInvestigation(vst.getVisitid());
                                                                    for (int r = 0; r < ptreatmentss1.size(); r++) {
                                                                        Patientinvestigation ptPatienttreatments1 = (Patientinvestigation) ptreatmentss1.get(r);
                                                                        if (ptPatienttreatments1.getPrice() > 0) {
                                                                %>

                                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                    <td class="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>"  style="padding-left: 5px; line-height: 25px;">

                                                                        <%=mgr.getInvestigation(ptPatienttreatments1.getInvestigationid()).getName()%>

                                                                    </td>
                                                                    <td class="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>" style="line-height: 25px; text-align: right; padding-right: 20px;">
                                                                        <%=df.format(ptPatienttreatments1.getPrice())%> 

                                                                    </td>
                                                                </tr>
                                                                <% }
                                                                    }%>
                                                                <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                    <td style="border-top: solid 1px black; padding-left: 5px; ">
                                                                        <b>Total Bill Credited </b>
                                                                    </td>
                                                                    <td style="border-top: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=vst.getOrderid()%>">

                                                                    </td>
                                                                </tr>
                                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                    <td style="padding-top: 10px; padding-left: 5px;">
                                                                        Payment Status  
                                                                    </td>
                                                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 20px;" class="paymentstatus<%=vst.getOrderid()%> ">

                                                                        Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

                                                                    </td>
                                                                </tr>
                                                                <% } else {%> 

                                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                    <td style="border-top: solid 1px black; padding-left: 5px; line-height: 25px;">
                                                                        <b>   Total Bill </b>
                                                                    </td>
                                                                    <td style="border-top: solid 1px black; text-align: right; font-weight: bold; line-height: 25px; text-align: right; padding-right: 20px;" class="amountduetext<%=vst.getOrderid()%>">

                                                                    </td>
                                                                </tr>


                                                                <% }%>
                                                            </tbody>
                                                        </table>
                                                        <div style="clear: both"></div>

                                                        <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                                            Served & Electronically Signed by: <%= mgr.getStafftableByid(user.getStaffid()).getOthername()%>  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                                            Thank you for doing business with us <br /> Wishing you the best of health.
                                                        </div>
                                                    </div>
                                                </section>
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
                                    </tr>

                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid() : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%= vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                        <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                     <!--   <td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                        <td><%=formatter.format(vst.getOrderdate())%> </td>


                                        <td>
                                            <button class="btn btn-info btn-small" id="<%=vst.getOrderid()%>_link">
                                                <i class="icon-white icon-check"></i> Confirm Payment 
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

            <%@include file="widgets/footer.jsp" %>

            <div id="override_action" title="Admin Override" class="hide">



                <form class="form-horizontal">
                    <div class="control-group">
                        <label class="control-label" for="inputEmail">Username</label>
                        <div class="controls">
                            <input type="text" id="inputEmail" placeholder="Username">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputPassword">Password</label>
                        <div class="controls">
                            <input type="password" id="inputPassword" placeholder="Password">
                        </div>
                    </div>
                    <div class="form-actions">

                        <button  type="submit" class="btn btn-danger">Confirm</button>
                    </div>

                </form>

            </div>

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
<script type="text/javascript" charset="utf-8" src="media/js/ZeroClipboard.js"></script>
<script type="text/javascript" charset="utf-8" src="media/js/TableTools.js"></script>
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
            if(!$(this).hasClass('active')) {
                menu_a.removeClass('active');
                menu_ul.filter(':visible').slideUp('normal');
                $(this).addClass('active').next().stop(true, true).slideDown('normal');
            } else {
                $(this).removeClass('active');
                $(this).next().stop(true, true).slideUp('normal');
            }
        });

    });

</script>


<script type="text/javascript" charset="utf-8">
    function printSelection(node){

        var content=node.innerHTML
        var pwin=window.open('','print_content','width=750,height=1200');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
    
    function printReceipt(node){

        var content=node.innerHTML
        var pwin=window.open('','print_content','width=400,height=900');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
    
    
    
    $(document).ready(function() {
        $("input:checkbox").attr("checked", true);
        $(".copaymentsecondarycashdefault").attr("checked", false);
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 500 
            

        });
            
            

        $(".patient").popover({

            placement : 'right',
            animation : true

        });
        
    });

</script>
<% for (int i = 0;
            i < listorders.size();
            i++) {
        TransitClinicLabs vst = (TransitClinicLabs) listorders.get(i);


%>


<script type="text/javascript">
    
    var amountdue<%=vst.getOrderid()%> = 0.0;
    
    $(".amountduepiece<%=vst.getOrderid()%>").each(function(){
         
       
        amountdue<%=vst.getOrderid()%> = parseFloat(amountdue<%=vst.getOrderid()%>)  + parseFloat($(this).attr("value"));
        $(".amountduetext<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
        
        
    });
    
    
                      
    $("#<%= vst.getOrderid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true,
        position : 'top'

    });
    
    $("#<%= vst.getOrderid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getOrderid()%>_link").click(function(){
      
        $("#<%=vst.getOrderid()%>_dialog").dialog('open');
    
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
    
    $(".copaymentsecondarycashdefault").change(function(){
        var attrID =  $(this).attr("attribute");
        // alert(attrID);
                    
        if($(this).is(':checked')){  
            $("#"+attrID).css("display","block");
            $("#1_"+attrID).css("display","block");
            $("#2_"+attrID).css("display","block");
                       
                    
        }else {
            $("#"+attrID).css("display","none");
            $("#1_"+attrID).css("display","none");
            $("#2_"+attrID).css("display","none");
        }
    })
    $(function(){
        
        
        var amountdue = parseFloat($(".amountdueinput<%= vst.getOrderid()%>").attr("value")).toFixed(2);
        
        $(".amountduetext<%= vst.getOrderid()%>").html(amountdue);
        var checkedValue = 0;
        //$("#amountdue").attr("value",parseFloat(0));
        //$("#amountduetext").html("0.0");
        
        
        $(".balanceinput<%= vst.getOrderid()%>").attr("value",parseFloat(0).toFixed(2));
        $(".balancetext<%= vst.getOrderid()%>").html("0.00");
        
        $(".amountpaidinput<%= vst.getOrderid()%>").attr("value",parseFloat(0).toFixed(2))
        $(".amountpaidtext<%= vst.getOrderid()%>").html($(".amountpaidinput<%= vst.getOrderid()%>").attr("value"))
        
        $(".amountpaidinput<%= vst.getOrderid()%>").live('keyup',function(){
           
            var amountdue = $(".amountdueinput<%= vst.getOrderid()%>").attr("value");
            
            var amountpaid = $(".amountpaidinput<%= vst.getOrderid()%>").attr("value");
            $(".amountpaidtext<%= vst.getOrderid()%>").html($(".amountpaidinput<%= vst.getOrderid()%>").attr("value"))
            
            if(amountpaid == ""){
                amountpaid = 0;
            }
            
            var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
            
            
            
            if(amountpaid > 0 &&balance < 0){
                $(".paymentstatus<%= vst.getOrderid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                $('.balanceinput<%= vst.getOrderid()%>').closest('.control-group').addClass('error').removeClass('success')
                $('.balancetext<%= vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
                $('.balancetextcolour<%= vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
               
            } else if (amountpaid == 0){
                $(".paymentstatus<%= vst.getOrderid()%>").html("").removeClass('text-success').removeClass('text-error')
                $('.balanceinput<%= vst.getOrderid()%>').closest('.control-group').removeClass('success').removeClass('error')
                $('.balancetext<%= vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                
            } 
           
            else if(amountpaid > 0 && balance >= 0){
                $(".paymentstatus<%= vst.getOrderid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                $('.balanceinput<%= vst.getOrderid()%>').closest('.control-group').addClass('success').removeClass('error')
                $('.balancetext<%= vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
            }
            
            
            $(".balanceinput<%= vst.getOrderid()%>").attr("value",parseFloat(balance).toFixed(2));
            $(".balancetext<%= vst.getOrderid()%>").html(parseFloat(balance).toFixed(2));
            $(".amountduetext<%= vst.getOrderid()%>").attr("value",$(".amountdue<%= vst.getOrderid()%>").attr("value"));
            
        });
        
        
        var amounttoplimit = amountdue;
        var amountbottomlimit = 0;
        
        
        $(".checkValue<%=vst.getOrderid()%>").change(function(){
            
            
            var amountpaid = parseFloat($(".amountpaidinput<%=vst.getOrderid()%>").attr("value"));
            //alert(amountpaid)
            if(amountpaid == ""){
                amountpaid = 0;
            }
            var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
            if($(this).is(':checked')){ 
                
                // alert("Checked")
                checkedValue = parseFloat($(this).attr("checkvalue")).toFixed(2);
                //alert(checkedValue);
                if(amountdue < amounttoplimit) { 
                    
                    amountdue = parseFloat(amountdue) + parseFloat(checkedValue);
                    
                    $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue);
                    $(".amountduetext<%=vst.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    
                }
                
    <%
        ptreatmentss1 = mgr.patientInvestigation(vst.getVisitid());
        for (int r = 0; r < ptreatmentss1.size(); r++) {
            Patientinvestigation ptPatienttreatments1 = (Patientinvestigation) ptreatmentss1.get(r);

    %>
                    if ($(this).attr("id")=="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>"){
                        $(".investigation_row<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>").css('text-decoration','none')
                        $(".investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>").css('display','block')
                    }                                                                   
                                                                                
    <% }%>
                                                                                
            
                }else {
               
                    checkedValue = parseFloat($(this).attr("checkvalue")); 
                 
                    if(amountdue > amountbottomlimit) { 
                        amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                    
                        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue);
                        $(".amountduetext<%=vst.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    }
               
    <%
        ptreatmentss1 = mgr.patientInvestigation(vst.getVisitid());
        for (int r = 0; r < ptreatmentss1.size(); r++) {
            Patientinvestigation ptPatienttreatments1 = (Patientinvestigation) ptreatmentss1.get(r);

    %>
                    if ($(this).attr("id")=="investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>"){
                        $(".investigation_row<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>").css('text-decoration','line-through')
                        $(".investigation_check<%=vst.getOrderid()%><%=ptPatienttreatments1.getInvestigationid()%>").css('display','none')
                    }                                                                  
                                                                                
    <% }%>
                
                    $("#override_action").dialog("open")
               
               
                }
                if (amountpaid > 0 && amountdue > 0){ 
                    balance = parseFloat(amountdue).toFixed(2) - parseFloat(amountpaid).toFixed(2);
                    $(".balancetext<%=vst.getOrderid()%>").html(parseFloat(balance).toFixed(2));
                
                }
                if(amountpaid > 0 && balance < 0){
                    $(".paymentstatus<%=vst.getOrderid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                    $('.balanceinput<%=vst.getOrderid()%>').closest('.control-group').addClass('error').removeClass('success')
                    $('.balancetext<%=vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
                    $('.balancetextcolour<%=vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
               
                } else if (amountpaid == 0.00){
                    $(".paymentstatus").html("").removeClass('text-success').removeClass('text-error')
                    $('.balanceinput<%=vst.getOrderid()%>').closest('.control-group').removeClass('success').removeClass('error')
                    $('.balancetext<%=vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                    $('.balancetextcolour<%=vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                
                }
                else if(amountpaid > 0 && balance >= 0){
                    $(".paymentstatus").html("Full Payment").addClass('text-success').removeClass('text-error')
                    $('.balanceinput<%=vst.getOrderid()%>').closest('.control-group').addClass('success').removeClass('error')
                    $('.balancetext<%=vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
                    $('.balancetextcolour<%=vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
                }
           
            });
        
        
        })
   
    
</script>




<% }%>

</body>
</html>
