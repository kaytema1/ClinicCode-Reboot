<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

        <%
            Users user = (Users) session.getAttribute("staff");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);

            Date date = new Date();
            List visits = mgr.listPharmordersByStatus("Account");
            List treatments = null;
        %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                        <ul class="nav nav-pills">

                            <li>
                                <a href="#">Billing</a><span class="divider"></span>
                            </li>
                            <li  class="active">
                                <a href="#"> Dispensing Bills</a><span class="divider"></span>
                            </li>

                        </ul>
                    </div>
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
                                                Pharmorder vst = (Pharmorder) visits.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <div class="dialog" id="<%=vst.getOrderid()%>_dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-right' style='margin-top: 30px; padding: 0px;' />">
                                                <span class="span4">
                                                    <dl class="dl-horizontal">
                                                        <dt style="text-align: left;" >Date:</dt>
                                                        <dd><%= formatter.format(vst.getOrderdate())%> </dd>
                                                        <dt style="text-align: left;" >Reference:</dt>
                                                        <dd style="text-transform: uppercase;"><%= vst.getOrderid()%></dd>
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
                                                <div style="font-weight: bolder;" class="lead center"> <u> <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                        OFFICIAL INVOICE 
                                                        <% } else {%> OFFICIAL RECEIPT <% }%> </u> </div>

                                                <div style="max-height: 400px; overflow-y: scroll;" class="center thumbnail">

                                                    <form action="action/accountsaction.jsp" method="post">
                                                        <table class="table">

                                                            <thead>

                                                                <tr>
                                                                    <th rowspan="2" style="color: #fff; text-align: left;"> Drug </th>
                                                                    <th rowspan="2" style="color: #fff; width: 50px;"> Form </th>

                                                                    <th rowspan="2" style="color: #fff; width: 50px;" > Quantity</th>                                                                
                                                                    <th rowspan="2" style="color: #fff; width: 50px; text-align: right;"> Unit Cost </th>
                                                                    <th  rowspan="2" style="color: #fff; width: 50px; text-align: right;"> Total </th>
                                                                    <th rowspan="2" style="color: #fff; width: 100px;"> Approval</th>
                                                                    <th rowspan="2" style="color: #fff; width: 50px;"> Sponsorship Status</th>
                                                                    <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                                                    <th  colspan="2" style="color: #fff; width: 50px;"> Co-Payment
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
                                                                <% }%>
                                                            </thead>
                                                            <tbody>
                                                                <% %>

                                                                <%

                                                                    List ptreatmentss = mgr.patientTreatment(vst.getVisitid());
                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                        Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
                                                                %>
                                                                <tr>
                                                                    <td class="treatment_row<%=ptPatienttreatments.getTreatmentid()%>"><%=mgr.getTreatment(ptPatienttreatments.getTreatmentid()).getTreatment()%> </td>
                                                                    <td class="treatment_row<%=ptPatienttreatments.getTreatmentid()%>"  style="text-align: center;"> <%=ptPatienttreatments.getType()%>  </td>


                                                                    <td class="treatment_row<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: center;"> <%=ptPatienttreatments.getQuantity()%> </td>

                                                                    <td class="treatment_row<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;"><%=df.format(ptPatienttreatments.getPrice())%> </td>
                                                                    <td class="treatment_row<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;"><%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>
                                                                        <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" value="<%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>" />
                                                                    </td>
                                                                    <%if (ptPatienttreatments.getDispensed().equalsIgnoreCase("paid")) {%> 
                                                                    <td>
                                                                        <span class="label label-success">Paid </span>
                                                                        <label class="switch-container">
                                                                            <input id="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" type="checkbox" name="dispensed[]" checkvalue="<%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>" value="<%=ptPatienttreatments.getId()%>" style="width: 100px" class="switch-input checkValue<%=vst.getOrderid()%> hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label> 

                                                                    </td> 
                                                                    <%}
                                                                        if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No")) {%>
                                                                    <td>

                                                                        <label class="switch-container">
                                                                            <input id="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" type="checkbox" name="afford[]" checkvalue="<%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>" value="<%=ptPatienttreatments.getId()%>" style="width: 100px" class="switch-input checkValue<%=vst.getOrderid()%> hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label> 

                                                                    </td>
                                                                    <%}
                                                                        if (ptPatienttreatments.getDispensed().equalsIgnoreCase("Afford")) {%>
                                                                    <td>
                                                                        <label class="switch-container">
                                                                            <input id="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" type="checkbox" name="dispensed[]" checkvalue="<%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>" value="<%=ptPatienttreatments.getId()%>" style="width: 100px" class="switch-input checkValue<%=vst.getOrderid()%> hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label> 

                                                                    </td>

                                                                    <%if (ptPatienttreatments.isCopaid() && ptPatienttreatments.isIsPrivate()) {%>
                                                                    <td>Amount Credited<br/>
                                                                        <input type="text" name="secondarysupport<%=ptPatienttreatments.getId()%>" value="0.0"/></td>
                                                                    <td>Amount Paid<input type="text" name="privatesupport<%=ptPatienttreatments.getId()%>" value="0.0"/></td>
                                                                        <%} else if (ptPatienttreatments.isCopaid() && !ptPatienttreatments.isIsPrivate()) {%>
                                                                    <td>Amount Credited<br/><input type="text" name="secondarysupport<%=ptPatienttreatments.getId()%>" value="0.0"/></td><td>&nbsp;</td>
                                                                        <%} else if (!ptPatienttreatments.isCopaid() && ptPatienttreatments.isIsPrivate()) {%>
                                                                    <td>&nbsp;</td> <td>Amount Paid<br/><input type="text" name="privatesupport<%=ptPatienttreatments.getId()%>" value="0.0"/></td>

                                                                    <%} else {%>
                                                                    <td style="text-align: center;">
                                                                        Fully Sponsored
                                                                    </td>

                                                                    <%}%>


                                                                    <%}
                                                                        if (ptPatienttreatments.getDispensed().equalsIgnoreCase("Dispensed")) {%>
                                                                    <td>
                                                                        <span class="label label-success"> Dispensed</span>

                                                                    </td>
                                                                    <%}%>
                                                                    <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  

                                                                    <td>

                                                                    </td>
                                                                    <td>

                                                                    </td>
                                                                    <% }%>


                                                                </tr>

                                                                <%}
                                                                    %> 
                                                                <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                <tr>
                                                                    <td  colspan="4" style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                        <b>   Total Amount Credited </b>
                                                                    </td>
                                                                    <td style="border-top: solid 1px black ;padding-left: 0px; padding-right: 0px;">
                                                                        <span style="float: right; text-align: right; font-weight: bold; padding-right: 5px;" class="amountduetext<%=vst.getOrderid()%>"> </span>
                                                                        <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" />
                                                                    </td>
                                                                    <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                                                    <td style="border-top: solid 1px black; text-align: right; padding-right: 5px;">
                                                                    </td>
                                                                    <td style="border-top: solid 1px black; text-align: right; padding-right: 5px;">

                                                                    </td>
                                                                    <td style="border-top: solid 1px black; text-align: right; padding-right: 5px;">
                                                                    </td>
                                                                    <td style="border-top: solid 1px black; text-align: right; padding-right: 5px;">

                                                                    </td>

                                                                    <% }%>

                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                                        Amount Credited to  <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>
                                                                    </td>
                                                                    <td style="text-align: right;" id="primary<%=vst.getOrderid()%>">

                                                                    </td>
                                                                    <td colspan="4">
                                                                        
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                                        Amount Credited to  <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname()%>
                                                                    </td>
                                                                    <td  style="text-align: right;" id="secondary<%=vst.getOrderid()%>">

                                                                    </td>
                                                                    <td colspan="4">
                                                                        
                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                                        Amount Paid  
                                                                    </td>
                                                                    <td style="text-align: right;" id="paid<%=vst.getOrderid()%>">

                                                                    </td>
                                                                     <td colspan="4">
                                                                        
                                                                    </td>
                                                                </tr>



                                                                <%


                                                                } else {%> 

                                                                <tr>
                                                                    <td colspan="4" style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                        <b>   Total Bill </b>
                                                                    </td>
                                                                    <td style="border-top: solid 1px black; text-align: right">
                                                                        <span style="text-align: right; font-weight: bold; " class="amountduetext<%=vst.getOrderid()%>"> </span>
                                                                        <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" />
                                                                    </td>
                                                                    <td colspan="2" style="border-top: solid 1px black">

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="discount_row<%=vst.getOrderid()%> hide" style="text-align: left; padding-left: 15px;">  
                                                                        <b>
                                                                            Discount
                                                                        </b>
                                                                    </td>
                                                                    <td class="discount_row<%=vst.getOrderid()%> hide">
                                                                        <span style="text-align: right; float: right;" class="discount_row_amount<%=vst.getOrderid()%>"></span>
                                                                    </td>

                                                                    <td class="discount_row<%=vst.getOrderid()%> hide ">
                                                                        <span style="text-align: right; float: right" class="discount_row_percent<%=vst.getOrderid()%>"></span>
                                                                    </td>
                                                                    <td class="discount_row<%=vst.getOrderid()%> hide ">

                                                                    </td>

                                                                </tr>

                                                                <tr>
                                                                    <td colspan="4" class="discount_row<%=vst.getOrderid()%>  text-success hide" style="text-align: left; padding-left: 15px;">  
                                                                        <b>
                                                                            Bill Due to Discount
                                                                        </b>
                                                                    </td>
                                                                    <td class="discount_row<%=vst.getOrderid()%> text-success hide ">
                                                                        <span style="text-align: right; float: right;" class="bill_after_discount<%=vst.getOrderid()%>"></span>
                                                                    </td>

                                                                    <td class="discount_row<%=vst.getOrderid()%> hide">

                                                                    </td>
                                                                    <td class="discount_row<%=vst.getOrderid()%> hide ">

                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="padding-left: 15px; line-height: 25px;">
                                                                        Amount Paid 
                                                                    </td>
                                                                    <td style="text-align: right;">

                                                                        <input type="text" class="input-mini amountpaidinput<%=vst.getOrderid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" value="0.00"/>
                                                                    </td>

                                                                    <td style="text-align: center;">
                                                                        <a class="btn btn-mini btn-danger" style="color: white;" href="#" onclick='showdiscount("discount<%=vst.getOrderid()%>");return false' id="discount<%=vst.getOrderid()%>">Discount</a>
                                                                    </td>


                                                                    <td>  
                                                                        <div class="dialog" id="password_link<%=vst.getOrderid()%>" title="Discounting Medical Bills">
                                                                            <form action="" class="form-horizontal" method="post">
                                                                                <div class="control-group">
                                                                                    <label class="control-label" for="inputEmail">Username</label> 
                                                                                    <div class="controls">
                                                                                        <input type="text" name="username" id="username<%=vst.getOrderid()%>" /><br/>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label class="control-label" for="inputEmail">Password</label> 
                                                                                    <div class="controls">
                                                                                        <input type="password" name="password" id="password<%=vst.getOrderid()%>" /><br/>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-actions">
                                                                                    <button class="btn btn-info pull-right" id="verify<%=vst.getOrderid()%>" onclick="return false">
                                                                                        <i class="icon-white icon-check"></i> Give Discount
                                                                                    </button>   
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                        <div class="dialog" id="discount_links<%=vst.getOrderid()%>" title="Discounting Medical Bill">
                                                                            <form action="" class="form-horizontal" method="post">
                                                                                <div class="control-group">
                                                                                    <label class="control-label" for="inputEmail">Percentage Discount</label> 
                                                                                    <div class="controls">
                                                                                        <input class="input-mini decimal" type="text" name="percentagediscount" id="percentagediscount<%=vst.getOrderid()%>" />
                                                                                        <p class="help-inline"> % </p>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label class="control-label" for="inputEmail">Actual Discount</label>  
                                                                                    <div class="controls">
                                                                                        <input class="input-mini decimal" type="text" name="actualdiscount" id="actualdiscount<%=vst.getOrderid()%>" />  
                                                                                        <p class="help-inline"> GHS </p>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label class="control-label" for="inputEmail">
                                                                                        New Credited Price</label> 
                                                                                    <div class="controls"> 
                                                                                        <input  class="input-mini decimal" type="text" name="newamount" id="newamount<%=vst.getOrderid()%>" />
                                                                                        <p class="help-inline"> GHS </p>
                                                                                    </div>
                                                                                </div>
                                                                                <input type="hidden" name="status" id="statusdis<%=vst.getOrderid()%>" value="Medical Bills" />
                                                                                <input type="hidden" name="visitid" id="visitiddis<%=vst.getOrderid()%>" value="<%=vst.getOrderid()%>" />
                                                                                <input type="hidden" name="staffid" id="staffiddis<%=vst.getOrderid()%>" value="" />
                                                                                <div class="control-group">
                                                                                    <label class="control-label" for="inputEmail">
                                                                                        Reason</label>
                                                                                    <div class="controls"> 
                                                                                        <textarea name="reasondis" id="reasondis<%=vst.getOrderid()%>"></textarea>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-actions">
                                                                                    <button class="btn btn-info btn-small btn-danger" id="<%=vst.getOrderid()%>_discount" onclick="return false;">
                                                                                        <i class="icon-white icon-check"></i> Discount
                                                                                    </button>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style=" padding-left: 15px; line-height: 25px;">
                                                                        Balance Tendered
                                                                    </td>
                                                                    <td style="text-align: right;">
                                                                        <span style="text-align: right; " class="balancetext<%=vst.getOrderid()%>"> </span>
                                                                    </td>
                                                                    <td>

                                                                    </td>
                                                                    <td>

                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                                        Payment Status  
                                                                    </td>
                                                                    <td colspan="2"  style="padding-top: 10px; text-align: center;">
                                                                        <span style="text-align: center;"  class="paymentstatus<%=vst.getOrderid()%>"> </span>
                                                                    </td>
                                                                    <td>

                                                                    </td>

                                                                </tr>


                                                                <% }%> 
                                                                <tr>
                                                                    <td>
                                                                        <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=vst.getOrderid()%>" style="display: none">
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

                                                                                    <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                                        DISPENSARY INVOICE 
                                                                                        <% } else {%> DISPENSARY RECEIPT <% }%></h3>

                                                                                </div>
                                                                                <hr class="row" style="border-top: 2px solid #45BF55;margin-top: 0px;" >


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
                                                                                                INV<%=vst.getOrderid()%>
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
                                                                                                Card No.
                                                                                            </td>
                                                                                            <td style="line-height: 25px; text-transform: uppercase">
                                                                                                <%= vst.getPatientid()%>
                                                                                            </td>
                                                                                        </tr>


                                                                                    </table>
                                                                                    <div style="clear: both;"></div>

                                                                                    <hr class="row" style="border-top: 2px solid #45BF55;
                                                                                        margin-top: 5px;" >
                                                                                    <div class="row center">

                                                                                        <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing:  ">DISPENSED DRUGS</h3>

                                                                                    </div>

                                                                                    <table style="width: 100%" cellspacing="0">
                                                                                        <thead>
                                                                                            <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;">Details </th>
                                                                                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: center; padding-bottom:  7px; padding-top: 5px; border-right: none; border-left: none; padding-right: 5px; width: 70px;" > Quantity</th>                                                                
                                                                                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: right; padding-bottom:  7px; padding-top: 5px; border-right: none; border-left: none; padding-right: 5px; width: 80px;"> Unit Cost </th>
                                                                                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: right; padding-bottom:  7px; padding-top: 5px;   border-left: none;padding-right: 5px; width: 100px;"> Total </th>

                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                                            <tr>
                                                                                                <td  style="padding-left: 5px; line-height: 25px; text-transform: capitalize;">
                                                                                                    <% %>

                                                                                                <%

                                                                                                     ptreatmentss = mgr.patientTreatment(vst.getVisitid());
                                                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                                                        Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
                                                                                                %>
                                                                                            <tr>  

                                                                                                <td class="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" style="padding-left: 5px;"> <%=mgr.getTreatment(ptPatienttreatments.getTreatmentid()).getTreatment()%> </td>
                                                                                                <td class="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: center;"> <%=ptPatienttreatments.getQuantity()%> </td>

                                                                                                <td class="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right; padding-right: 5px;"><%=df.format(ptPatienttreatments.getPrice())%> </td>
                                                                                                <td class="treatment_check<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right; padding-right: 5px;"><%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>
                                                                                                    <input type="hidden"  value="<%= (df.format(ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>" />
                                                                                                </td>
                                                                                                <td>

                                                                                                </td>

                                                                                            </tr>
                                                                                            <% }
                                                                                                %>


                                                                                            </tr>
                                                                                            <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                                            <tr>
                                                                                                <td colspan="3" style="border-top: solid 1px black; padding-left: 5px; line-height: 25px;">
                                                                                                    <b>   Total Amount Credited </b>
                                                                                                </td>
                                                                                                <td  class="amountduetext<%=vst.getOrderid()%>" style="border-top: solid 1px black; text-align: right; padding-right: 5px;">

                                                                                                </td>

                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="2" style="padding-top: 10px; padding-left: 5px; line-height: 25px;">
                                                                                                    Payment Status  
                                                                                                </td>
                                                                                                <td colspan="2" style="padding-top: 10px; text-align: right;  margin-right: 5px;" class="paymentstatus<%=vst.getOrderid()%>">

                                                                                                    Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

                                                                                                </td>


                                                                                            </tr>




                                                                                            <% } else {%> 

                                                                                            <tr>
                                                                                                <td colspan="3" style="border-top: solid 1px black; padding-left: 5px; line-height: 25px;">
                                                                                                    <b>   Total Bill </b>
                                                                                                </td>
                                                                                                <td style="border-top: solid 1px black; text-align: right;">
                                                                                                    <span style="text-align: right; font-weight: bold; margin-right: 5px;" class="amountduetext<%=vst.getOrderid()%>"> </span>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="3" class="print_discount_row<%=vst.getOrderid()%>" style="padding-left: 5px; line-height: 25px; display: none;">  

                                                                                                    Discount

                                                                                                </td>
                                                                                                <td style="text-align: right;  margin-right: 5px; display: none;" class="print_discount_row<%=vst.getOrderid()%> hide discount_row_amount_percent<%=vst.getOrderid()%>">

                                                                                                </td>
                                                                                            </tr>

                                                                                            <tr>
                                                                                                <td colspan="3" class="print_discount_row<%=vst.getOrderid()%>  text-success" style="padding-left: 5px; line-height: 25px; display: none;">  
                                                                                                    <b>
                                                                                                        Bill Due to Discount
                                                                                                    </b>
                                                                                                </td>
                                                                                                <td  style="text-align: right;  margin-right: 5px; display: none;" class="print_discount_row<%=vst.getOrderid()%> text-success  bill_after_discount<%=vst.getOrderid()%>">

                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="3" style="padding-left: 5px; line-height: 25px;">
                                                                                                    Amount Paid 
                                                                                                </td>
                                                                                                <td style="text-align: right">
                                                                                                    <span style="text-align: right;  margin-right: 5px;" class="amountpaidtext<%=vst.getOrderid()%>"> </span>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="3" style=" padding-left: 5px; line-height: 25px;">
                                                                                                    Balance Tendered
                                                                                                </td>
                                                                                                <td style="text-align: right">
                                                                                                    <span style="text-align: right;  margin-right: 5px;" class="balancetext<%=vst.getOrderid()%>"> </span>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="2" style="padding-top: 10px; padding-left: 5px; line-height: 25px; text-align: left;">
                                                                                                    Payment Status  
                                                                                                </td>
                                                                                                <td  colspan="2" style="padding-top: 10px; text-align: right;">
                                                                                                    <span style="text-align: right;  margin-right: 5px;" class="paymentstatus<%=vst.getOrderid()%>"> </span>
                                                                                                </td>
                                                                                            </tr>


                                                                                            <% }%> 
                                                                                        </tbody>
                                                                                    </table>




                                                                                    <div style="clear: both"></div>

                                                                                    <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                                                                        Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                                                                        Wishing You Speedy Recovery <br /> Thank you
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
                                                                    <td>

                                                                    </td>
                                                                     <td colspan="2"
                                                                        
                                                                    </td>


                                                                </tr>

                                                            </tbody>

                                                        </table>

                                                        <div style="text-align: center;" class="form-actions">
                                                            <button class="btn btn-info btn-small pull-left" href="" onclick='printSelection(document.getElementById("print<%=vst.getOrderid()%>"));return false'>
                                                                <i class="icon-white icon-print"></i> Print
                                                            </button>

                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="orderid" value="<%=vst.getOrderid()%>"/>
                                                            <%
                                                                String unitid = "";
                                                                if (mgr.getVisitById(vst.getVisitid()).getPreviouslocstion().equalsIgnoreCase("consultation")) {
                                                                    unitid = "account";
                                                                } else {
                                                                    unitid = "records";
                                                                }
                                                            %>
                                                            <input type="hidden" name="from" value="Pharmacy"/>
                                                            <input type="hidden" name="unitid" value="pharmacy"/>

                                                            <button type="submit" name="action" value="Pharmacy Receipt" class="btn btn-danger btn-small pull-right">

                                                                <i class="icon-white icon-arrow-right"> </i> Forward
                                                            </button>
                                                        </div>
                                                    </form>
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

                                        <td><%=formatter.format(vst.getOrderdate())%> </td>

                                        <td>
                                            <button class="btn btn-info btn-small" id="<%=vst.getOrderid()%>_link">
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
<script type="text/javascript" src="js/demo.js"></script>

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
    
    
    $(function() {
        

        $("input:checkbox").attr("checked", true);
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
        
        
        
        
        

    });

</script>



<% for (int i = 0;
            i < visits.size();
            i++) {
        Pharmorder vst = (Pharmorder) visits.get(i);
%>


<script type="text/javascript">
    $(function(){
        $("#primary<%= vst.getOrderid()%>").append("0.00");
        $("#secondary<%= vst.getOrderid()%>").html("0.00");
        $("#paid<%= vst.getOrderid()%>").html("0.00");
    })
    var amountdue<%=vst.getOrderid()%> = 0.0;
    
    $(".amountduepiece<%=vst.getOrderid()%>").each(function(){
         
        //alert("amountduepiece"+ $(".amountduepiece<%=vst.getOrderid()%>").attr("value"))
        amountdue<%=vst.getOrderid()%> = parseFloat(amountdue<%=vst.getOrderid()%>)  + parseFloat($(this).attr("value"));
        $(".amountduetext<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
    });
    
    
    $("#<%= vst.getOrderid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

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
    
   
    
    $("#<%= vst.getOrderid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getOrderid()%>_adddrug_dialog").dialog('open');
        
    })
   
    $("#discount_links<%=vst.getOrderid()%>").dialog({
        autoOpen : false,
        width : 450,
        modal :true
    });
    /* $("#discount<%=vst.getOrderid()%>").click(function(){
        $("#discount_link<%=vst.getOrderid()%>").dialog('open');
        return false;
    
    })*/
    $("#password_link<%=vst.getOrderid()%>").dialog({
        autoOpen : false,
        width : 450,
        modal :true
    });
    $("#discount<%=vst.getOrderid()%>").click(function(){
        $("#password_link<%=vst.getOrderid()%>").dialog('open');
        $(".discount_row<%=vst.getOrderid()%>").show()
        return false; 
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

        List ptreatmentss = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
        for (int r = 0; r < ptreatmentss.size(); r++) {
            Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
    %>
                    if ($(this).attr("id")=="treatment_check<%=ptPatienttreatments.getTreatmentid()%>"){
                        $(".treatment_row<%=ptPatienttreatments.getTreatmentid()%>").css('text-decoration','none')
                        $(".treatment_check<%=ptPatienttreatments.getTreatmentid()%>").css('display','block')
                    }
    <%

        }
    %>                         
                   
                
            
                }else {
               
                    checkedValue = parseFloat($(this).attr("checkvalue")); 
                 
                    if(amountdue > amountbottomlimit) { 
                        amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                    
                        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue);
                        $(".amountduetext<%=vst.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    
                    
                    
                    }
               
    <%

        ptreatmentss = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
        for (int r = 0; r < ptreatmentss.size(); r++) {
            Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
    %>
                    if ($(this).attr("id")=="treatment_check<%=ptPatienttreatments.getTreatmentid()%>"){
                        $(".treatment_row<%=ptPatienttreatments.getTreatmentid()%>").css('text-decoration','line-through')
                        $(".treatment_check<%=ptPatienttreatments.getTreatmentid()%>").css('display','none')
                    }
    <%

        }
    %>  
                
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
        var amountduebeforediscount = $(".amountdueinput<%= vst.getOrderid()%>").attr("value");
        $("#newamount<%= vst.getOrderid()%>").attr("value",amountduebeforediscount);
        var amountdueafterdiscount;
        var discountpercentage;
        var discountamount;
    
        $("#actualdiscount<%= vst.getOrderid()%>").live('keyup',function(){
            if( $(this).attr("value") >= 0){ 
                discountamount = $("#actualdiscount<%= vst.getOrderid()%>").attr("value");
                discountpercentage = (parseFloat(discountamount)/parseFloat(amountduebeforediscount))*100
                amountdueafterdiscount = parseFloat(amountduebeforediscount).toFixed(2) - parseFloat(discountamount).toFixed(2);
                $("#percentagediscount<%= vst.getOrderid()%>").attr("value",parseFloat(discountpercentage).toFixed(2));
                $("#newamount<%= vst.getOrderid()%>").attr("value",parseFloat(amountdueafterdiscount).toFixed(2));       
                $(".discount_row_percent<%=vst.getOrderid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%") 
                $(".discount_row_amount<%=vst.getOrderid()%>").html(parseFloat(discountamount).toFixed(2))
                $(".bill_after_discount<%=vst.getOrderid()%>").html(parseFloat(amountdueafterdiscount).toFixed(2));
                $(".discount_row_amount_percent<%=vst.getOrderid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
            }else {
                alert("Please Enter a Positive Decimal Value, Only")
            }
        
        });
    
        $("#percentagediscount<%= vst.getOrderid()%>").live('keyup',function(){
            if( $(this).attr("value") >= 0){ 
                discountpercentage = $("#percentagediscount<%= vst.getOrderid()%>").attr("value");
                
                var discountamount = (parseFloat(discountpercentage)*parseFloat(amountduebeforediscount))/100
                var amountdueafterdiscount = amountduebeforediscount - discountamount;
        
                $("#actualdiscount<%= vst.getOrderid()%>").attr("value",discountamount);
                $("#newamount<%= vst.getOrderid()%>").attr("value",amountdueafterdiscount);         
       
                $(".discount_row_percent<%=vst.getOrderid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%"); 
                $(".discount_row_amount<%=vst.getOrderid()%>").html(parseFloat(discountamount).toFixed(2));
                $(".bill_after_discount<%=vst.getOrderid()%>").html(parseFloat(amountdueafterdiscount).toFixed(2));
                $(".discount_row_amount_percent<%=vst.getOrderid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
            }else {
                alert("Please Enter a Positive Decimal Value, Only")
            }
        
        });
        $("#verify<%=vst.getOrderid()%>").click(function(){
            // alert("hello");
            var username = $("#username<%=vst.getOrderid()%>").attr("value");
            var password = $("#password<%=vst.getOrderid()%>").attr("value");
            $.post('patientcount.jsp', {action : "patientdiscount", username : username, password : password}, function(data) {
                //alert(data);
                var bool = data;
                if(bool=="false"){
                    alert("You are eligible please go ahead")
                }
                else{
                    alert("You don't qualify to give discount please talk to a senior staff")
                    $("#discount_links<%=vst.getOrderid()%>").dialog('open');
                    return false;
                }
            });
        });
        $("#<%=vst.getOrderid()%>_discount").click(function(){     
            var percentage = $("#percentagedis<%=vst.getOrderid()%>").attr("value");
            var actual = $("#actualdis<%=vst.getOrderid()%>").attr("value");
            var newcharge = $("#newamount<%=vst.getOrderid()%>").attr("value");
            var status = $("#statusdis<%=vst.getOrderid()%>").attr("value");
            var staff = $("#staffiddis<%=vst.getOrderid()%>").attr("value");
            var reason = $("#reasondis<%=vst.getOrderid()%>").attr("value");
            var visit = $("#visitiddis<%=vst.getOrderid()%>").attr("value");
            alert(staff);
            $(".amountdueinput<%=vst.getOrderid()%>").attr("value",newcharge);
            $(".print_discount_row<%=vst.getOrderid()%>").show()
            $.post('patientcount.jsp', {action : "pharmdiscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit}, function(data) {
                alert(data);      
            });
            //  return false;
        }); 
    
</script>


<% }%>

</body>
</html>
