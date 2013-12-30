<%-- 
    Document   : accounts
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : ClaimSync
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> list = (ArrayList<Integer>) session.getAttribute("staffPermission");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            DecimalFormat df = new DecimalFormat();




            df.setMinimumFractionDigits(2);
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            Date date = new Date();
            double registrationFee = 0;
            //List visits = mgr.listUnitVisitations("account");
            String visitString = request.getParameter("visitid");
            int visitId = Integer.parseInt(visitString);
            List visits = mgr.listVisitsByVisitid(visitId);
            List treatments = null;
            //   Visitationtable visit = (Visitationtable) visits.get(i);
        %>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">

                    <li>
                        <a href="#">Billing</a><span class="divider"></span>
                    </li>
                    <li  class="active">
                        <a href="#"> Medical Bills</a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>
            <br/>
            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                    }%>

            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span8 thumbnail main-c">

                    <table class="example display">
                        <thead>
                            <tr>
                                <th style="font-size: 12px;"> Folder Number</th>
                                <th style="font-size: 12px;"> Patient Name </th>
                                <th style="font-size: 12px;"> Payment Type </th>
                                <th style="font-size: 12px;"> Date of Birth  </th>
                                <th style="font-size: 12px;"> Requested On </th>
                                <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
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
                                    <div class="dialog" id="<%=vst.getVisitid()%>_dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-right' style='margin-top: 0px; padding: 0px;' />  ">

                                        <span class="pull-left">
                                            <dl class="dl-horizontal">
                                                <dt style="text-align: left;" >Date:</dt>
                                                <dd><%= formatter.format(vst.getDate())%> </dd>
                                                <dt style="text-align: left;" >Invoice No.</dt>
                                                <dd style="text-transform: uppercase;">INV<%=vst.getVisitid()%></dd>
                                                <% session.setAttribute("visit_id", vst.getVisitid() + "");%>
                                                <dt style="text-align: left;" >Account</dt>
                                                <dd style="text-transform: capitalize;"><%=mgr.sponsorshipDetails(vst.getPatientid()).getType()%> Patient</dd>
                                                <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private")) {%>
                                                <dt style="text-align: left"> Insured By: </dt>
                                                <dd> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></dd>

                                                <% }%>
                                                <dt style="text-align: left;" >Name:</dt>
                                                <dd><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                    <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                    <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                </dd>
                                                <dt style="text-align: left;" >Card No:</dt>
                                                <dd style="text-transform: uppercase;">
                                                    <b> <%= vst.getPatientid()%> </b>
                                                </dd>

                                            </dl>

                                        </span>

                                        <div class="clearfix">
                                        </div>    
                                        <div class="center thumbnail">
                                            <span style="font-weight: bolder;" class="lead"> <u> <%
                                                        if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                    OFFICIAL INVOICE 
                                                    <% } else {%> OFFICIAL RECEIPT <% }%> </u> </span>

                                            <% String rec = vst.getPreviouslocstion();
                                                //String[] recs = rec.split("_");
                                                if (rec.equals("records")) {%>
                                            <form action="action/accountsaction.jsp" method="post">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th rowspan="2" style="text-align: left; color: #fff;">Details </th>
                                                            <th rowspan="2" style="width: 30px; color: #fff;">Bill </th>
                                                            <th rowspan="2" style="color: #fff; width: 100px;"> Approved</th>
                                                            <%
                                                                        if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                                            <th  colspan="2" style="color: #fff; width: 100px;"> Co-Payment
                                                            </th>
                                                            <% }%>
                                                            <!--  <th>Payment Status</th>  -->
                                                        </tr>
                                                        <%
                                                                    if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                                        <tr>

                                                            <th  style="color: #fff; width: 100px;"><span style="font-size: 10px;"> <%
                                                                if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {
                                                                    out.print(mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname());
                                                                }%> </span></th>
                                                            <th style="color: #fff; width: 100px;"> Out of Pocket</th>
                                                        </tr>
                                                        <% } else {%>
                                                        <!--  <tr>


                                                              <th colspan="2" style="color: #fff; width: 100px;"> Out of Pocket</th>
                                                          </tr>  -->
                                                        <% }%>
                                                    </thead>
                                                    <tbody>
                                                        <% List l = mgr.listPatientConsultationByVisitid(vst.getVisitid());
                                                            Patientconsultation patientconsultation = (Patientconsultation) l.get(0);
                                                            if (patientconsultation != null && l.size() > 0) { %>


                                                        <% List registrations = mgr.getPatientReg(vst.getPatientid());
                                                            PatientRegistration pRegg = null;
                                                            RegFee rFee = null;
                                                            List curRFees;


                                                            if (registrations != null && registrations.size() > 0) {
                                                                System.out.println("herehrehrherhe " + registrations.size());
                                                                pRegg = (PatientRegistration) registrations.get(0);

                                                                if (pRegg != null) {

                                                                    double amountPaid = pRegg.getAmountPaid();
                                                                    if (amountPaid == 0) {
                                                                        curRFees = mgr.listCurrentRegFee("Yes");
                                                                        if (!curRFees.isEmpty()) {
                                                                            rFee = (RegFee) curRFees.get(0);
                                                                            if (rFee != null) {
                                                                                registrationFee = rFee.getRegFee();


                                                        %>
                                                        <tr>
                                                            <td class="registration_row<%=vst.getVisitid()%>keys" style="text-transform: capitalize; text-align: left;">Registration</td>
                                                            <td class="registration_row<%=vst.getVisitid()%>value" style="text-align: right;"><%=df.format(registrationFee)%></td>
                                                            <td> 

                                                                <input name="regFee" type="hidden" value="<%=registrationFee%>" />

                                                                <input name="secondarysupportreg" type="hidden" value="0.0" />
                                                                <input name="privatesupportreg" type="hidden" value="0.0" />
                                                                <label class="switch-container">
                                                                    <input type="checkbox" id="registration_check<%=vst.getVisitid()%>"  checkvalue="<%=df.format(registrationFee)%>"  style="width: 100px" class="switch-input checkValue<%=vst.getVisitid()%> hide">
                                                                    <div class="switch">
                                                                        <span class="switch-label">Yes</span>
                                                                        <span class="switch-label">No</span>
                                                                        <span class="switch-handle"></span>
                                                                    </div> 

                                                                </label>
                                                            </td>
                                                            <%
                                                                        if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                                            <td>
                                                                <%if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                                                <div id="displayregg<%=vst.getVisitid()%>" style="display: block"> 
                                                                    <label class="switch-container">
                                                                        <input name="copaidreg" type="checkbox" value="<%=pRegg.getRegId()%>" onclick="displayReg()" id="regg<%=vst.getVisitid()%>"  style="width: 100px" class="switch-input  hide">
                                                                        <div class="switch">
                                                                            <span class="switch-label">Yes</span>
                                                                            <span class="switch-label">No</span>
                                                                            <span class="switch-handle"></span>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <%}%>
                                                                <div style="display: none; text-align: center;" id="displayregg2<%=vst.getVisitid()%>"><%
                                                                            if (mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                                                    <input class="input-mini decimal" style="text-align: right" type="text" id="regamountpaid" placeholder="0.00" name="secondarysupportreg" value=""/>      
                                                                    <%} else {
                                                                    %>
                                                                    <input class="input-mini decimal" style="text-align: right" type="text" id="regamountpaid" placeholder="0.00" name="secondarysupportreg" value=""/> <%}%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div id="displayregg1<%=vst.getVisitid()%>" style="display: block"> 
                                                                    <label class="switch-container">
                                                                        <input name="isprivateSupportreg" type="checkbox" value="<%=pRegg.getRegId()%>" onclick="displayRegOne()" id="regg2<%=vst.getVisitid()%>" style="width: 100px" class="switch-input  hide">
                                                                        <div class="switch">
                                                                            <span class="switch-label">Yes</span>
                                                                            <span class="switch-label">No</span>
                                                                            <span class="switch-handle"></span>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div style="display: none; text-align: center;" id="displayregg3<%=vst.getVisitid()%>">
                                                                    <input class="input-mini decimal" style="text-align: right" placeholder="0.00" type="text" id="regamountpaid1" name="privatesupportreg" value=""/>   
                                                                </div>
                                                            </td>
                                                            <% }%>

                                                        </tr>

                                                        <%  }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        %>
                                                        <tr>
                                                            <td class="consultation_row<%=vst.getVisitid()%>keys" style="text-transform: capitalize; text-align: left;">
                                                                <%=mgr.getConsultationId(patientconsultation.getTypeid()).getContype()%>
                                                            </td>

                                                            <td class="consultation_row<%=vst.getVisitid()%>value" style="text-align: right;"> 
                                                                <%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount())%>
                                                                <% if (pRegg != null) {%>

                                                                <input class="input-small amountdueinput<%=vst.getVisitid()%>" style="color: blue; display: none;"  type="text"  disabled="disabled" value="<%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount() + registrationFee)%> " /> 

                                                                <% } else {%>
                                                                <input class="input-small amountdueinput<%=vst.getVisitid()%>" style="color: blue; display: none;"  type="text"  disabled="disabled" value="<%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount())%> " /> 

                                                                <%  }%>
                                                            </td>
                                                            <td style="width: 100px"> 

                                                                <label class="switch-container">
                                                                    <input type="checkbox" id="consultation_check<%=vst.getVisitid()%>" checkvalue="<%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount())%>"  style="width: 100px" class="switch-input checkValue<%=vst.getVisitid()%> hide">
                                                                    <div class="switch">
                                                                        <span class="switch-label">Yes</span>
                                                                        <span class="switch-label">No</span>
                                                                        <span class="switch-handle"></span>
                                                                    </div>  
                                                                </label> 
                                                            </td>
                                                    <input name="secondarysupportcon" type="hidden" value="0.0" />
                                                    <input name="privatesupportcon" type="hidden" value="0.0" />
                                                    <%
                                                                if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                                    <td>
                                                        <%if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                                        <div style="display: block; text-align: center;" id="displaycon<%=vst.getVisitid()%>">
                                                            <label style="text-align: center;" class="switch-container">
                                                                <input type="checkbox" name="copay" value="<%=patientconsultation.getId()%>" onclick="displayCon()" id="con<%=vst.getVisitid()%>" style="width: 100px" class="switch-input  hide">
                                                                <div class="switch">
                                                                    <span class="switch-label">Yes</span>
                                                                    <span class="switch-label">No</span>
                                                                    <span class="switch-handle"></span>
                                                                </div>  
                                                            </label>
                                                        </div>
                                                        <%}%>
                                                        <div class="clearfix"></div>
                                                        <div style="display: none; text-align: center;" id="displaycon2<%=vst.getVisitid()%>"><%
                                                                    if (mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                                            <input  class="input-mini decimal decimal" style="text-align: right;" type="text" placeholder="0.00" id="conamountpaid" name="secondarysupportcon" value=""/>      <%} else {

                                                            %>

                                                            <input class="input-mini decimal decimal" style="text-align: right;" type="text" placeholder="0.00" id="conamountpaid" name="secondarysupportcon" value=""/><%}%>
                                                        </div>
                                                    </td>
                                                    <td><div style="display: block" id="displaycon1<%=vst.getVisitid()%>">
                                                            <label class="switch-container">
                                                                <input type="checkbox"  name="isprivateSupportcon" value="<%=patientconsultation.getId()%>" onclick="displayConOne()" id="con2<%=vst.getVisitid()%>"  style="width: 100px" class="switch-input  hide">
                                                                <div class="switch">
                                                                    <span class="switch-label">Yes</span>
                                                                    <span class="switch-label">No</span>
                                                                    <span class="switch-handle"></span>
                                                                </div>  
                                                            </label>
                                                        </div>
                                                        <div style="display: none; text-align: center;" id="displaycon3<%=vst.getVisitid()%>">
                                                            <input class="input-mini decimal decimal" style="text-align: right;" type="text" id="conamountpaid" placeholder="0.00" name="privatesupportcon" value=""/>
                                                        </div>
                                                    </td>
                                                    <% }%>

                                                    </tr>
                                                    <tr>
                                                        <td  style="text-align: left; border-top: solid 2px black;"> <b> Total Bill </b> </td>

                                                        <%
                                                            double amt = mgr.getConsultationId(patientconsultation.getTypeid()).getAmount();
                                                            double pamt = 0.0;
                                                            if (pRegg != null) {
                                                                pamt = amt + registrationFee;
                                                            } else {
                                                                pamt = amt;
                                                            }
                                                        %>                                                                             

                                                        <td style="text-align: right; border-top: solid 2px black;"> <span class="amountduetext<%=vst.getVisitid()%>"> <%=df.format(pamt)%> </span> <input id="amountdueinput<%=vst.getVisitid()%>" class="amountdueinput<%=vst.getVisitid()%>" style="color: blue;"  type="hidden" disabled="disabled" value="<%=df.format(pamt)%>" /></td>
                                                        <td  style="border-top: solid 2px black;"></td>  
                                                        <%
                                                                    if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                                        <td style=" border-top: solid 2px black;"></td>
                                                        <td style=" border-top: solid 2px black;"></td>

                                                        <% }%>
                                                    </tr>
                                                    <tr>
                                                        <td class="discount_row<%=vst.getVisitid()%> hide" style="text-align: left;">  
                                                            <b>
                                                                Discount
                                                            </b>
                                                        </td>
                                                        <td class="discount_row<%=vst.getVisitid()%> hide">
                                                            <span style="text-align: right; float: right;" class="discount_row_amount<%=vst.getVisitid()%>"></span>
                                                        </td>

                                                        <td class="discount_row<%=vst.getVisitid()%> hide">
                                                            <span style="text-align: right; float: right" class="discount_row_percent<%=vst.getVisitid()%>"></span>
                                                        </td>

                                                    </tr>

                                                    <tr>
                                                        <td class="discount_row<%=vst.getVisitid()%> hide text-success" style="text-align: left;">  
                                                            <b>
                                                                Bill Due to Discount
                                                            </b>
                                                        </td>
                                                        <td class="discount_row<%=vst.getVisitid()%> text-success hide">
                                                            <span style="text-align: right; float: right;" class="bill_after_discount<%=vst.getVisitid()%>"></span>
                                                        </td>

                                                        <td class="discount_row<%=vst.getVisitid()%> hide">

                                                        </td>

                                                    </tr>

                                                    <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                    <tr style="display: none;">
                                                        <td style="text-align: left;"> <b> Amount Paid </b> </td>
                                                        <td> </td>
                                                        <td style="text-align: right;"> <input  class="input-mini decimal decimal amountpaidinput<%=vst.getVisitid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" value="0.00"/></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <% } else {%> 
                                                    <tr>
                                                        <td  style="text-align: left;"> <b> Amount Paid </b> </td>

                                                        <td style="text-align: right;"> 
                                                            <input  class="input-mini decimal decimal amountpaidinput<%=vst.getVisitid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" value="0.00"/>
                                                        </td>
                                                        <td style="text-align: center;">

                                                            <div id="password_link<%=vst.getVisitid()%>" title='Confirm Authorization'>
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
                                                                                    <i class="icon-white icon-check"></i> Give Discount
                                                                                </button>  
                                                                            </td>
                                                                        </tr>
                                                                    </table>

                                                                </form>
                                                            </div>
                                                            <div  id="discount_links<%=vst.getVisitid()%>" title="Discounting Medical Bill">
                                                                <form action="" class="form-horizontal" method="post">
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputEmail">Percentage Discount</label> 
                                                                        <div class="controls">
                                                                            <input class="input-mini decimal" type="text" name="percentagediscount" id="percentagediscount<%=vst.getVisitid()%>" />
                                                                            <p class="help-inline"> % </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputEmail">Actual Discount</label>  
                                                                        <div class="controls">
                                                                            <input class="input-mini decimal" type="text" name="actualdiscount" id="actualdiscount<%=vst.getVisitid()%>" />  
                                                                            <p class="help-inline"> GHS </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputEmail">
                                                                            New Credited Price</label> 
                                                                        <div class="controls"> 
                                                                            <input  class="input-mini decimal" type="text" name="newamount" id="newamount<%=vst.getVisitid()%>" />
                                                                            <p class="help-inline"> GHS </p>
                                                                        </div>
                                                                    </div>
                                                                    <input type="hidden" name="status" id="statusdis<%=vst.getVisitid()%>" value="Medical Bills" />
                                                                    <input type="hidden" name="visitid" id="visitiddis<%=vst.getVisitid()%>" value="<%=vst.getVisitid()%>" />
                                                                    <input type="hidden" name="staffid" id="staffiddis<%=vst.getVisitid()%>" value="" />
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputEmail">
                                                                            Reason</label>
                                                                        <div class="controls"> 
                                                                            <textarea name="reasondis" id="reasondis<%=vst.getVisitid()%>"></textarea>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-actions">
                                                                        <button class="btn btn-danger btn-small" id="<%=vst.getVisitid()%>_discount" onclick="return false;">
                                                                            <i class="icon-white icon-check"></i> Confirm Discount
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </td>


                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left;">  <b class="balancetextcolour<%=vst.getVisitid()%>">Balance Due </b>  </td>

                                                        <td style="text-align: right;"> <div class="control-group">

                                                                <div class="controls">

                                                                    <span style="margin: 0px;" class="balancetext<%=vst.getVisitid()%>">

                                                                    </span>
                                                                    <input disabled="disabled"  class="balanceinput<%=vst.getVisitid()%>" type="hidden"   value=""/>

                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="paymentstatus<%=vst.getVisitid()%>"> </td>




                                                    </tr>

                                                    <% }%>
                                                    <tr>
                                                        <td>

                                                            <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=vst.getVisitid()%>" style="display: none">
                                                                <section class="hide" id="dashboard">

                                                                    <!-- Headings & Paragraph Copy -->
                                                                    <div class="container">

                                                                        <div style="margin-bottom: -15px;" class="row">
                                                                            <div class="span3" style="float: left;">
                                                                                <img src="images/danpongclinic.png" width="100px;" style="margin-top: 30px;" />
                                                                            </div>

                                                                            <img src="images/danpongaddress.png" width="100px;" style="float: right; margin-top: 20px;" /> 


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
                                                                                    <%= formatter.format(vst.getDate())%>
                                                                                </td>
                                                                            </tr>

                                                                            <!--  <tr>
                                                                                  <td style="line-height: 25px;">
                                                                                      Invoice No.
                                                                                  </td>
                                                                                  <td style="line-height: 25px;">
                                                                                      INV<%=vst.getVisitid()%>
                                                                                  </td>
                                                                              </tr> -->

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
                                                                                    Folder Number
                                                                                </td>
                                                                                <td style="line-height: 25px; text-transform: uppercase">
                                                                                    <%= vst.getPatientid()%>
                                                                                </td>
                                                                            </tr>


                                                                        </table>



                                                                        <div style="clear: both;"></div>

                                                                        <hr class="row" style="border-top: 2px solid  #000;
                                                                            margin-top: 5px;" >
                                                                        <div class="row center">

                                                                            <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing: 2px;">
                                                                                <% if (registrationFee > 0) {%>REGISTRATION  & <% }%>CONSULTATION</h3>

                                                                        </div>

                                                                        <table style="width: 100%" cellspacing="0">
                                                                            <thead>
                                                                                <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                                    <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: underline;">Description </th>

                                                                                    <th style="text-align: right;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px; padding-right: 5px;  border-left: none; text-decoration: underline;">
                                                                                        Total
                                                                                    </th>

                                                                                </tr>
                                                                            </thead>
                                                                            <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                                <% if (pRegg != null) {

                                                                                        double amountPaid = pRegg.getAmountPaid();
                                                                                        if (amountPaid == 0) {%>

                                                                                <tr>
                                                                                    <td class="registration_check<%=vst.getVisitid()%>keys" style="padding-left: 15px; line-height: 25px; text-transform: capitalize;">
                                                                                        Registration
                                                                                    </td>
                                                                                    <td class="registration_check<%=vst.getVisitid()%>value" style="text-align: right; font-weight: bold; margin-right: 20px;">
                                                                                        <%= df.format(registrationFee)%>
                                                                                    </td>
                                                                                </tr>

                                                                                <%   }

                                                                                    }

                                                                                %>
                                                                                <tr>
                                                                                    <td class="consultation_check<%=vst.getVisitid()%>keys" style="padding-left: 15px; line-height: 18px; text-transform: capitalize; " >
                                                                                        <%=mgr.getConsultationId(patientconsultation.getTypeid()).getContype()%>
                                                                                    </td>
                                                                                    <td class="consultation_check<%=vst.getVisitid()%>value" style="text-align: right; font-weight: bold;margin-right: 20px; " > 
                                                                                        <%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount())%>
                                                                                    </td>
                                                                                </tr>
                                                                                <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                                <tr>
                                                                                    <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                                        <b>   Total Amount Credited </b>
                                                                                    </td>
                                                                                    <td style="border-top: solid 1px black; text-align: right; font-weight: bold; " class="amountduetext<%=vst.getVisitid()%>">

                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                                                        Payment Status  
                                                                                    </td>
                                                                                    <td style="padding-top: 10px; text-align: right;  margin-right: 20px;" class="paymentstatus<%=vst.getVisitid()%>">
                                                                                        Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>
                                                                                    </td>
                                                                                </tr>
                                                                                <% } else {%> 

                                                                                <tr>
                                                                                    <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                                        <b>Total Bill </b>
                                                                                    </td>
                                                                                    <td style="border-top: solid 1px black; text-align: right; font-weight: bold; margin-right: 20px;" class="amountduetext<%=vst.getVisitid()%>">>

                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="print_discount_row<%=vst.getVisitid()%> hide " style="padding-left: 15px; line-height: 25px; display: none;">  

                                                                                        Discount

                                                                                    </td>
                                                                                    <td style="text-align: right;  margin-right: 20px; display: none;" class="print_discount_row<%=vst.getVisitid()%> hide discount_row_amount_percent<%=vst.getVisitid()%>">

                                                                                    </td>
                                                                                </tr>

                                                                                <tr>
                                                                                    <td class="print_discount_row<%=vst.getVisitid()%> hide text-success" style="padding-left: 15px; line-height: 25px; display: none;">  
                                                                                        <b>
                                                                                            Bill Due to Discount
                                                                                        </b>
                                                                                    </td>
                                                                                    <td  style="text-align: right;  margin-right: 20px; display: none;" class="print_discount_row<%=vst.getVisitid()%> text-success hide bill_after_discount<%=vst.getVisitid()%>">

                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-left: 15px; line-height: 25px;">
                                                                                        Amount Paid 
                                                                                    </td>
                                                                                    <td style="text-align: right;  margin-right: 20px;" class="amountpaidtext<%=vst.getVisitid()%>">

                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                                                        Balance Tendered
                                                                                    </td>
                                                                                    <td style="text-align: right;  margin-right: 20px;" class="balancetext<%=vst.getVisitid()%>">

                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;" >
                                                                                        Payment Status  
                                                                                    </td>
                                                                                    <td style="text-align: right;" class="paymentstatus<%=vst.getVisitid()%>">
                                                                                        Not Paid
                                                                                    </td>
                                                                                </tr>
                                                                                <% }%> 
                                                                            </tbody>
                                                                        </table>

                                                                    </div>
                                                                    <div style="clear: both"></div>

                                                                    <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                                                        Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                                                        Wishing You Speedy Recovery <br /> Thank you
                                                                    </div>
                                                                    <!--  <img src="images/danpongfooter.png" width="100%" style="position: absolute; bottom: 0px; "/>   -->    
                                                                </section> 
                                                            </div>  
                                                        </td>
                                                        <td>

                                                        </td>
                                                        <td>

                                                        </td>
                                                        <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%>

                                                        <td>

                                                        </td>
                                                        <td>

                                                        </td>
                                                        <% }%>
                                                    </tr>

                                                    <%}
                                                    %>
                                                    </tbody>
                                                </table>
                                                <div style="text-align: center;" class="form-actions">
                                                    <button style="width: 40%" class="btn btn-info pull-left" type="button" onclick='printSelection(document.getElementById("print<%=vst.getVisitid()%>")); return false'>
                                                        <i class="icon-print icon-white"></i> Print Now
                                                    </button>
                                                    <!-- <input type="hidden" name="unitid" value="Accounts"/>-->
                                                    <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                    <input type="hidden" name="cid" value="<%=patientconsultation.getId()%>"/>
                                                    <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                    <input type="hidden" name="unitid" value="vitals"/>

                                                    <button style="float: right; width: 40%" type="submit" name="action"  value="Consultation Receipt" class="btn btn-danger pull-right">
                                                        <i class="icon-white icon-arrow-right"> </i> Forward
                                                    </button>

                                                    <div class="clearfix">

                                                    </div>
                                                    <br />
                                                    <br />
                                                    <div style="text-align: center;">

                                                        <a class ="btn btn-inverse" style="color: white; width: 40%" href="#" onclick='showdiscount("discount<%=vst.getVisitid()%>");return false' id="discount<%=vst.getVisitid()%>">
                                                            <i class="icon icon-white icon-arrow-down"></i>
                                                            Discount</a>

                                                    </div>

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
                            </tr>

                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                <td><%=formatter.format(vst.getDate())%> </td>

                                <td>
                                    <button class="btn btn-info btn-small" id="<%=vst.getVisitid()%>_link">
                                        Payment
                                    </button></td>
                            </tr>
                            <% }
                                        }%> 

                        </tbody>
                    </table>

                </div>


                <div class="clearfix"></div>



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

                    <button  type="button" class="btn btn-danger">Confirm</button>
                </div>

            </form>

        </div>

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
<script type="text/javascript" src="js/demo.js"></script>

<script type="text/javascript" src="js/jquery.filter_input.js "></script>
<!--initiate accordion-->
<script type="text/javascript">
    
    
    function printSelection(node){

        var content=node.innerHTML
        var pwin=window.open('','print_content','width=400,height=900');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
    
    function inputControl(input,format)
    {
        var value=input.val();
        var values=value.split("");
        var update="";
        var transition="";
        if (format=='int'){
            expression=/^([0-9])$/;
            finalExpression=/^([1-9][0-9]*)$/;
        }
        else if (format=='float')
        {
            var expression=/(^\d+$)|(^\d+\.\d+$)|[,\.]/;
            var finalExpression=/^([1-9][0-9]*[,\.]?\d{0,3})$/;
        }   
        for(id in values)
        {           
            if (expression.test(values[id])==true && values[id]!='')
            {
                transition+=''+values[id].replace(',','.');
                if(finalExpression.test(transition)==true)
                {
                    update+=''+values[id].replace(',','.');
                }
            }
        }
        input.val(update);
    }
    $(function() {
        
        $('.decimal').live("keyup",function(){inputControl($(this),'float');});
        
        $("#override_action").dialog({
            autoOpen : false,
            width : 500,
            modal :true

        });
        
        
        $("input:checkbox").attr("checked", true);
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        //menu_ul.hide();

        $(".menu").fadeIn();
        $(".main-c").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
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
            "sScrollY" : 400

        }); 
        
         $('#sidebar-toggle').click(function(e) {
                e.preventDefault();
                $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                $('.menu').animate({width: 'toggle'}, 0);
                $('.menu').toggleClass('span3 hide');
                $('.main-c').toggleClass('span8');
                
            });
        $(".patient").popover({

            placement : 'right',
            animation : true

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
        autoOpen : true,
        width : "90%",
        modal :true
    });
    
    $("#<%= vst.getVisitid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true
    });
  
    $("#<%= vst.getVisitid()%>_link").click(function(){
        $("#<%=vst.getVisitid()%>_dialog").dialog('open');   
    })
    $("#discount_links<%=vst.getVisitid()%>").dialog({
        autoOpen : false,
        width : 500,
        modal :true
    });
    /* $("#discount<%=vst.getVisitid()%>").click(function(){
        $("#discount_link<%=vst.getVisitid()%>").dialog('open');
        return false;
    
    })*/
    $("#password_link<%=vst.getVisitid()%>").dialog({
        autoOpen : false,
        width : 400,
        modal :true
    });
    $("#discount<%=vst.getVisitid()%>").click(function(){
        $("#password_link<%=vst.getVisitid()%>").dialog('open');
        $(".discount_row<%=vst.getVisitid()%>").show()
         
        return false; 
    }) 
   
    $("#<%= vst.getVisitid()%>_adddrug_link").click(function(){
        //alert("");
        $("#<%=vst.getVisitid()%>_adddrug_dialog").dialog('open');   
    }) 
    $(function(){
        var amountdue = parseFloat($(".amountdueinput<%= vst.getVisitid()%>").attr("value")).toFixed(2);
        
        $(".amountduetext<%= vst.getVisitid()%>").html(amountdue);
        var checkedValue = 0;
        $(".balanceinput<%= vst.getVisitid()%>").attr("value",parseFloat(0).toFixed(2));
        $(".balancetext<%= vst.getVisitid()%>").html("0.00");
        
        $(".amountpaidinput<%= vst.getVisitid()%>").attr("value",parseFloat(0).toFixed(2))
        $(".amountpaidtext<%= vst.getVisitid()%>").html($(".amountpaidinput<%= vst.getVisitid()%>").attr("value"))
        
        $(".amountpaidinput<%= vst.getVisitid()%>").live('keyup',function(){
           
            var amountdue = $(".amountdueinput<%= vst.getVisitid()%>").attr("value");
            var amountpaid = $(".amountpaidinput<%= vst.getVisitid()%>").attr("value");
            $(".amountpaidtext<%= vst.getVisitid()%>").html($(".amountpaidinput<%= vst.getVisitid()%>").attr("value"))
            
            if(amountpaid == ""){
                amountpaid = 0;
            }
            var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
            if(amountpaid > 0 &&balance < 0){
                $(".paymentstatus<%= vst.getVisitid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                $('.balanceinput<%= vst.getVisitid()%>').closest('.control-group').addClass('error').removeClass('success')
                $('.balancetext<%= vst.getVisitid()%>').addClass('text-error').removeClass('text-success')
                $('.balancetextcolour<%= vst.getVisitid()%>').addClass('text-error').removeClass('text-success')            
            } else if (amountpaid == 0){
                $(".paymentstatus<%= vst.getVisitid()%>").html("").removeClass('text-success').removeClass('text-error')
                $('.balanceinput<%= vst.getVisitid()%>').closest('.control-group').removeClass('success').removeClass('error')
                $('.balancetext<%= vst.getVisitid()%>').removeClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= vst.getVisitid()%>').removeClass('text-success').removeClass('text-error')             
            }         
            else if(amountpaid > 0 && balance >= 0){
                $(".paymentstatus<%= vst.getVisitid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                $('.balanceinput<%= vst.getVisitid()%>').closest('.control-group').addClass('success').removeClass('error')
                $('.balancetext<%= vst.getVisitid()%>').addClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= vst.getVisitid()%>').addClass('text-success').removeClass('text-error')
            }     
            $(".balanceinput<%= vst.getVisitid()%>").attr("value",parseFloat(balance).toFixed(2));
            $(".balancetext<%= vst.getVisitid()%>").html(parseFloat(balance).toFixed(2));
            $(".amountduetext<%= vst.getVisitid()%>").attr("value",$(".amountdue<%= vst.getVisitid()%>").attr("value"));         
        });
      
        var amounttoplimit = amountdue;
        var amountbottomlimit = 0;
        
        $(".checkValue<%=vst.getVisitid()%>").change(function(){
            var amountpaid = parseFloat($(".amountpaidinput<%=vst.getVisitid()%>").attr("value"));
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
                    $(".amountdueinput<%=vst.getVisitid()%>").attr("value",amountdue);
                    $(".amountduetext<%=vst.getVisitid()%>").html(parseFloat(amountdue).toFixed(2));   
                }             
                if ($(this).attr("id")=="consultation_check<%=vst.getVisitid()%>"){
                    $(".consultation_row<%=vst.getVisitid()%>keys").css('text-decoration','none')
                    $(".consultation_row<%=vst.getVisitid()%>value").css('text-decoration','none')                  
                    $(".consultation_check<%=vst.getVisitid()%>keys").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '25px' , 'text-transform': 'capitalize', 'border': 'solid 1px black' , 'float': 'left'});
                    $(".consultation_check<%=vst.getVisitid()%>value").css({'display':'block' ,'text-align' : 'right', 'font-weight' : 'bold' , 'margin-right': '20px', 'border': 'solid 1px black', 'width' : '80px' , 'float': 'right' }); 
                }else if($(this).attr("id")=="registration_check<%=vst.getVisitid()%>"){                
                    $(".registration_row<%=vst.getVisitid()%>keys").css('text-decoration','none');
                    $(".registration_row<%=vst.getVisitid()%>value").css('text-decoration','none');
                    
                    $(".registration_check<%=vst.getVisitid()%>keys").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '25px' , 'text-transform': 'capitalize', 'border': 'solid 1px black' , 'float': 'left'});
                    $(".registration_check<%=vst.getVisitid()%>value").css({'display':'block' ,'text-align' : 'right', 'font-weight' : 'bold' , 'margin-right': '20px', 'border': 'solid 1px black', 'width' : '80px' , 'float': 'right' }); 
                }           
            }else {
                checkedValue = parseFloat($(this).attr("checkvalue")); 
                if(amountdue > amountbottomlimit) { 
                    amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                    $(".amountdueinput<%=vst.getVisitid()%>").attr("value",amountdue);
                    $(".amountduetext<%=vst.getVisitid()%>").html(parseFloat(amountdue).toFixed(2));
                }            
                if ($(this).attr("id")=="consultation_check<%=vst.getVisitid()%>"){
                    $(".consultation_row<%=vst.getVisitid()%>keys").css('text-decoration','line-through')
                    $(".consultation_row<%=vst.getVisitid()%>value").css('text-decoration','line-through')
                    $(".consultation_check<%=vst.getVisitid()%>keys").css('display','none');
                    $(".consultation_check<%=vst.getVisitid()%>value").css('display','none'); 
                    //alert("consultation unchecked");
                }else if($(this).attr("id")=="registration_check<%=vst.getVisitid()%>"){
                    $(".registration_row<%=vst.getVisitid()%>keys").css('text-decoration','line-through');
                    $(".registration_row<%=vst.getVisitid()%>value").css('text-decoration','line-through');
                    $(".registration_check<%=vst.getVisitid()%>keys").css('display','none');
                    $(".registration_check<%=vst.getVisitid()%>value").css('display','none');
                }
                $("#override_action").dialog("open")
            }
            if (amountpaid > 0 && amountdue > 0){ 
                balance = parseFloat(amountdue).toFixed(2) - parseFloat(amountpaid).toFixed(2);
                $(".balancetext<%=vst.getVisitid()%>").html(parseFloat(balance).toFixed(2));
            }
            if(amountpaid > 0 && balance < 0){
                $(".paymentstatus<%=vst.getVisitid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                $('.balanceinput<%=vst.getVisitid()%>').closest('.control-group').addClass('error').removeClass('success')
                $('.balancetext<%=vst.getVisitid()%>').addClass('text-error').removeClass('text-success')
                $('.balancetextcolour<%=vst.getVisitid()%>').addClass('text-error').removeClass('text-success')
            } else if (amountpaid == 0.00){
                $(".paymentstatus").html("").removeClass('text-success').removeClass('text-error')
                $('.balanceinput<%=vst.getVisitid()%>').closest('.control-group').removeClass('success').removeClass('error')
                $('.balancetext<%=vst.getVisitid()%>').removeClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%=vst.getVisitid()%>').removeClass('text-success').removeClass('text-error')
            }
            else if(amountpaid > 0 && balance >= 0){
                $(".paymentstatus").html("Full Payment").addClass('text-success').removeClass('text-error')
                $('.balanceinput<%=vst.getVisitid()%>').closest('.control-group').addClass('success').removeClass('error')
                $('.balancetext<%=vst.getVisitid()%>').addClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%=vst.getVisitid()%>').addClass('text-success').removeClass('text-error')
            }
        });
        $("#regg<%=vst.getVisitid()%>").attr("checked", false);  
        $("#regg2<%=vst.getVisitid()%>").attr("checked", false);
        $("#con<%=vst.getVisitid()%>").attr("checked", false);  
        $("#con2<%=vst.getVisitid()%>").attr("checked", false);      
        $("#regg<%=vst.getVisitid()%>").change(function(){
            if($("#regg<%=vst.getVisitid()%>").is(':checked')){
                $("#displayregg2<%=vst.getVisitid()%>").css("display", "block")
            }else{
                $("#displayregg2<%=vst.getVisitid()%>").css("display", "none")
            }
        });        
        $("#regg2<%=vst.getVisitid()%>").change(function(){
            if($("#regg2<%=vst.getVisitid()%>").is(':checked')){
                $("#displayregg3<%=vst.getVisitid()%>").css("display", "block")
            }else{
                $("#displayregg3<%=vst.getVisitid()%>").css("display", "none")
            }
        });      
        $("#con<%=vst.getVisitid()%>").change(function(){
            if($("#con<%=vst.getVisitid()%>").is(':checked')){
                $("#displaycon2<%=vst.getVisitid()%>").css("display", "block")
            }else{
                $("#displaycon2<%=vst.getVisitid()%>").css("display", "none")
            }
        });      
        $("#con2<%=vst.getVisitid()%>").change(function(){
            if($("#con2<%=vst.getVisitid()%>").is(':checked')){
                $("#displaycon3<%=vst.getVisitid()%>").css("display", "block")
            }else{
                $("#displaycon3<%=vst.getVisitid()%>").css("display", "none")
            }
        });
    })
    
    var amountduebeforediscount<%= vst.getVisitid()%> = $("#amountdueinput<%= vst.getVisitid()%>").attr("value");
   
    $("#newamount<%= vst.getVisitid()%>").attr("value",amountduebeforediscount<%= vst.getVisitid()%>);
    var amountdueafterdiscount<%= vst.getVisitid()%>;
    var discountpercentage;
    var discountamount;
    
    $("#actualdiscount<%= vst.getVisitid()%>").live('keyup',function(){
        if( $(this).attr("value") >= 0){ 
            discountamount = $("#actualdiscount<%= vst.getVisitid()%>").attr("value");
            discountpercentage = (parseFloat(discountamount)/parseFloat(amountduebeforediscount<%= vst.getVisitid()%>))*100
            amountdueafterdiscount<%= vst.getVisitid()%> = parseFloat(amountduebeforediscount<%= vst.getVisitid()%>).toFixed(2) - parseFloat(discountamount).toFixed(2);
            $("#percentagediscount<%= vst.getVisitid()%>").attr("value",parseFloat(discountpercentage).toFixed(2));
            $("#newamount<%= vst.getVisitid()%>").attr("value",parseFloat(amountdueafterdiscount<%= vst.getVisitid()%>).toFixed(2));       
            $(".discount_row_percent<%=vst.getVisitid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%") 
            $(".discount_row_amount<%=vst.getVisitid()%>").html(parseFloat(discountamount).toFixed(2))
            $(".bill_after_discount<%=vst.getVisitid()%>").html(parseFloat(amountdueafterdiscount<%= vst.getVisitid()%>).toFixed(2));
            $(".discount_row_amount_percent<%=vst.getVisitid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
        }else {
            alert("Please Enter a Positive Decimal Value, Only")
        }
        
    });
    
    $("#percentagediscount<%= vst.getVisitid()%>").live('keyup',function(){
        if( $(this).attr("value") >= 0){ 
            discountpercentage = $("#percentagediscount<%= vst.getVisitid()%>").attr("value");
                
            var discountamount = (parseFloat(discountpercentage)*parseFloat(amountduebeforediscount<%= vst.getVisitid()%>))/100
            var amountdueafterdiscount<%= vst.getVisitid()%> = amountduebeforediscount<%= vst.getVisitid()%> - discountamount;
        
            $("#actualdiscount<%= vst.getVisitid()%>").attr("value",discountamount);
            $("#newamount<%= vst.getVisitid()%>").attr("value",amountdueafterdiscount<%= vst.getVisitid()%>);         
       
            $(".discount_row_percent<%=vst.getVisitid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%"); 
            $(".discount_row_amount<%=vst.getVisitid()%>").html(parseFloat(discountamount).toFixed(2));
            $(".bill_after_discount<%=vst.getVisitid()%>").html(parseFloat(amountdueafterdiscount<%= vst.getVisitid()%>).toFixed(2));
            $(".discount_row_amount_percent<%=vst.getVisitid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
        }else {
            alert("Please Enter a Positive Decimal Value, Only")
        }
        
    });
    
    
    $("#verify<%=vst.getVisitid()%>").click(function(){
        
        var username = $("#username<%=vst.getVisitid()%>").attr("value");
        var password = $("#password<%=vst.getVisitid()%>").attr("value");
        $.post('patientcount.jsp', {action : "patientdiscount", username : username, password : password}, function(data) {
            //alert(data);
            var bool = data;
            if(bool=="false"){
                alert("Permission Granted!")
            }
            else{
                alert("Permission Denied!, Contact System Administrator")
                $("#password_link<%=vst.getVisitid()%>").dialog('close')
                $("#discount_links<%=vst.getVisitid()%>").dialog('open');
                return false;
            }
        });
    });
    
    
    $("#<%=vst.getVisitid()%>_discount").click(function(){     
        var percentage = $("#percentagediscount<%=vst.getVisitid()%>").attr("value");
        var actual = $("#actualdiscount<%=vst.getVisitid()%>").attr("value");
        var newcharge = $("#newamount<%=vst.getVisitid()%>").attr("value");
        var status = $("#statusdis<%=vst.getVisitid()%>").attr("value");
        var staff = $("#staffiddis<%=vst.getVisitid()%>").attr("value");
        var reason = $("#reasondis<%=vst.getVisitid()%>").attr("value");
        var visit = $("#visitiddis<%=vst.getVisitid()%>").attr("value");
        $(".amountdueinput<%=vst.getVisitid()%>").attr("value",newcharge);
        $(".print_discount_row<%=vst.getVisitid()%>").show()
        $("#discount_links<%=vst.getVisitid()%>").dialog('close')
        //alert(staff);
        $.post('patientcount.jsp', {action : "savediscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit}, function(data) {
            // alert(data);      
        });
        //  return false;
    }); 
</script>
<% }%>
</body>
</html>