<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Formatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("index.jsp");


    }%>

<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
    Date date = new Date();
    // List visits = mgr.listUnitVisitations("pharmacy", dateFormat.format(date));
    List visits = mgr.listPharmordersByStatus("Not Done");
    List treatments = null;

%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li >
                            <a href="#">Dispensary</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Prescription Orders</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

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
                                <% if (visits != null) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            Pharmorder vst = (Pharmorder) visits.get(i);
                                %>
                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                    <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>

                                    <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  </td>
                                    <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                    <td><%= formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                    <td><%=formatter.format(vst.getOrderdate())%> </td>

                                    <td>
                                        <button class="btn btn-info btn-small" id="<%=vst.getPatientid()%>_link">
                                            <i class="icon-white icon-check"></i> Dispense
                                        </button>
                                    </td>
                                </tr>
                                <%}
                                    }%> 

                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

            <%

                if (visits != null) {
                    for (int i = 0; i < visits.size(); i++) {
                        Pharmorder vst = (Pharmorder) visits.get(i);
                        
            %>

            <div class="dialog hide" id="<%=vst.getPatientid()%>_dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> PRESCRIPTION ORDER </span>">

                <span class="span4">
                    <dl class="dl-horizontal">
                        <dt style="text-align: left;" >Date:</dt>
                        <dd><%= formatter.format(vst.getOrderdate())%> </dd>
                        <dt style="text-align: left;" >Folder Number:</dt>
                        <dd style="text-transform: uppercase; font-weight: bold;"><%= vst.getPatientid()%></dd>
                        <dt style="text-align: left;" >Patient Name:</dt>
                        <dd><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                            <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                            <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                        </dd>
                        <dt style="text-align: left;" >Payment Type:</dt>
                        <dd><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></dd>
                    </dl>
                </span>
                <div class="clearfix">
                </div>
                <div style="font-weight: bolder; font-size: 18px;" class=" center">  PRESCRIPTION ORDER  </div>


                <form class="center" action="action/forwardaction.jsp" method="post">
                    <table  class="table table-condensed table-striped table-bordered">
                        <thead>
                            <tr style="color: #fff; font-size: 15px;">
                                <th rowspan="2" style="color: #fff; text-align: left; font-size: 13px; width: 35%"> Drug </th>
                                <!--  <th  rowspan="2" style="color: #fff;"> Type </th>  -->
                                <th rowspan="2" style="color: #fff; text-align: left; font-size: 13px;"> Dosage </th>
                                <th rowspan="2" style="color: #fff; text-align: right; font-size: 13px; width: 5%"> Qty</th>                                                                
                                <th rowspan="2" style="color: #fff; text-align: right; font-size: 13px; width: 5%"> Unit </th>
                                <th rowspan="2" style="color: #fff; text-align: right; font-size: 13px;  width: 5%"> Total </th>
                                <th rowspan="2"  style="color: #fff; font-size: 13px; width: 5%">Approved</th>
                                <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                <th colspan="3" style="color: #fff; width: 100px;"> Co-Payment

                                </th>

                                <% }%>
                            </tr>
                            <%
                                if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                            <tr>
                                <th  style="color: #fff; width: 5%;">
                                    <span style="font-size: 10px;"> 
                                        <u> <b>  Primary Sponsor </b> </u> <Br/>
                                        <%

                                            out.print(mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname());
                                        %> 
                                    </span>
                                </th>
                                <th  style="color: #fff; width: 5%;">
                                    <span style="font-size: 10px;"> 

                                        <% if (!mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname().equalsIgnoreCase("Out of Pocket")) {%>
                                        <u> <b>Secondary Sponsor </b> </u> <Br/>
                                        <%  out.print(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor() == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname());%>
                                        <%}%>
                                    </span>
                                </th>
                                <th style="color: #fff; width: 5%;">
                                    <span style="font-size: 10px;">
                                        <% if (!mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname().equalsIgnoreCase("Out of Pocket")) {%>
                                        <u> <b> Tertiary Sponsor </b> </u> <br />
                                        <% } else {%>
                                        <u> <b> Secondary Sponsor </b> </u> <br/>

                                        <% }%>
                                        Out of Pocket
                                    </span>
                                </th>

                            </tr>
                            <% }%>
                        </thead>
                        <tbody>
                            <% %>

                            <%

                                List ptreatmentss = mgr.listPatientTreatmentsByVisitId(vst.getVisitid());
                                double totall = 0;
                                // double primary = 0;
                                for (int r = 0; r < ptreatmentss.size(); r++) {
                                    Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);

                                    if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No")) {
                                        totall = totall + ptPatienttreatments.getPrice();
                                        double price = 0.0;
                            %>
                            <tr>
                                <td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>">
                                    <%=mgr.getTreatment(ptPatienttreatments.getTreatmentid()).getTreatment()%> 
                                </td>
                              <!--  <td class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>"> <%--=ptPatienttreatments.getType()--%>  </td>  -->
                                <td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-transform: capitalize;">
                                    <%=ptPatienttreatments.getDosage().split("_")[1]%>  
                                </td>
                                <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-align: center;"> 
                                    <%=ptPatienttreatments.getQuantity()%> 
                                </td>
                                <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;">
                                    <%=df.format(ptPatienttreatments.getPrice())%> 
                                </td>
                                <td style="text-align: right; border-right: solid 2px black;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;">
                                    <% price =  ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice(); %>
                                    <%= df.format(price) %>
                                    <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" value="<%= df.format(price)%>" />
                                </td>


                                <td>

                                    <label style="margin-top: 18px;" class="switch-container">
                                        
                                        <input id="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" type="checkbox" name="afford[]" checkvalue="<%= df.format((ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%>" value="<%=ptPatienttreatments.getId()%>" style="width: 100px" class="switch-input checkValue<%=vst.getOrderid()%> hide">
                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div>  
                                    </label> 

                                </td>
                               <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) { %>
                                <td> 
                                    <div style="display: block; text-align: center;">

                                        <%=df.format(price)%>

                                    </div>
                                    <div class="clearfix"></div>
                                    <label  class="switch-container">

                                        <input type="radio" checked="checked" linkup="copayment<%=ptPatienttreatments.getTreatmentid()%>" id="1_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>" amount="<%=df.format(price)%>"  name="copaymentsecondarycashdefault<%=ptPatienttreatments.getTreatmentid()%>"  attribute="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>"    style="width: 100px" class="switch-input hide copaymentsecondarycashdefault copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>   1_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>" checked />
                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div> 


                                    </label>
                                    <div style="display: block; text-align: center;">
                                        <input   class="input-mini decimal sika  copayment<%=ptPatienttreatments.getTreatmentid()%> first<%=ptPatienttreatments.getTreatmentid()%>"  style=" text-align: right; vertical-align: bottom; display: none; " type="text" placeholder="0.00" id="1_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>_value" name="<%=ptPatienttreatments.getTreatmentid()%>_primarysponsor_<%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponshorshipid()%>" value="<%=df.format(price)%>"/>     

                                    </div>
                                </td>
                                <td>
                                    <%if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) { %>
                                    <div style="display: block;text-align: center" id="displaycon<%=vst.getPatientid()%>">

                                        
                                    </div>
                                    <label style="text-align: center" class="switch-container">
                                        <input type="radio" linkup="copayment<%=ptPatienttreatments.getTreatmentid()%>" id="2_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>" amount="<%=df.format(price)%>"  name="copaymentsecondarycashdefault<%=ptPatienttreatments.getTreatmentid()%>" value="" attribute="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>"   style="width: 100px" class="switch-input hide copaymentsecondarycashdefault copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%> 2_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>"/>
                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div> 
                                    </label>

                                    <%}%>
                                    <div class="clearfix"></div>
                                    <div style="display: block; text-align: center;">
                                        <%
                                                if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) { %>

                                        <% //primary = primary + secprice;
                                        %>
                                        <input  class="input-mini sika decimal copayment<%=ptPatienttreatments.getTreatmentid()%> second<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right; display: none;" type="text" 
                                                name="<%=ptPatienttreatments.getTreatmentid()%>_secondarysponsor_<%= mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponshorshipid()%>" placeholder="0.00" id="2_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>_value"  value=""/>


                                        <%}%>
                                    </div>
                                </td>
                                <td>
                                    <div style="text-align: center;">
                                        <%out.print(df.format(price));%>
                                    </div>
                                    <label class="switch-container">
                                        <input type="radio" linkup="copayment<%=ptPatienttreatments.getTreatmentid()%>" id="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>" amount="<%out.print(df.format(price));%>" name="copaymentsecondarycashdefault<%=ptPatienttreatments.getTreatmentid()%>" value="" attribute="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>"   style="width: 100px" class="switch-input hide copaymentsecondarycashdefault copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%> 3_copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>"/>
                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div>    
                                    </label>

                                    <div style="text-align: center; ">
                                        <input  class="input-mini sika decimal copayment<%=ptPatienttreatments.getTreatmentid()%> third<%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;display: none; " name="<%=ptPatienttreatments.getTreatmentid()%>_outofpocket" type="text" id="copaymentsecondarycashdefault_input<%=ptPatienttreatments.getTreatmentid()%>_value" placeholder="0.00"  value=""/>


                                    </div>
                                </td>






                                <% }
                                    }
                                %>

                            </tr>


                            <%}
                            %> 
                            <tr >
                                <td colspan="4" style="text-align: left; border-top: solid 2px black; font-size: 15px; line-height: 30px;"> 
                                    <b> TOTAL BILL </b> </td>

                                <td style="text-align: right; border-top: solid 2px black; border-right: solid 2px black; ">
                                    <span style="font-size: 15px; font-weight: bold;" class="amountduetext<%=vst.getOrderid()%>"> 
                                    </span>
                                    <input style="color: blue;" class="amountdueinput<%=vst.getOrderid()%>" type="hidden" disabled="disabled" value=""/>
                                </td>

                                <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                <th colspan="4" style="color: #fff; width: 100px;"> 

                                </th>

                                <% } else {%>
                                <td style="border-top: solid 2px black;"></td>
                                <%  }%>
                            </tr>
                           
                            <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                            <tr style="display: none;">
                                <td  style="text-align: left; border-top: solid 1px black;"> <b> Amount Paid </b> </td>

                                <td style="text-align: right; border-top: solid 1px black;"> 
                                    <input  class="input-mini amountpaidinput<%=vst.getPatientid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" placeholder="0.00" value=""/>


                                </td>


                            </tr>
                            <% } else {%> 
                            <tr>
                                <td class="discount_row<%=vst.getPatientid()%> hide" style="text-align: left;">  
                                    <b>
                                        Discount
                                    </b>
                                </td>


                                <td class="discount_row<%=vst.getPatientid()%> hide">
                                    <span style="text-align: right; float: right;" class="discount_row_amount<%=vst.getPatientid()%>"></span>
                                    <span style="text-align: right; float: right" class="discount_row_percent<%=vst.getPatientid()%>"></span>
                                </td>

                            </tr>

                            <tr>
                                <td class="discount_row<%=vst.getPatientid()%> hide " style="text-align: left;">  
                                    <b>
                                        Bill Due to Discount
                                    </b>
                                </td>
                                <td class="discount_row<%=vst.getPatientid()%> text-success hide">
                                    <span style="text-align: right; float: right;" class="bill_after_discount<%=vst.getPatientid()%>"></span>
                                </td>
                            </tr>
                            <tr class="hide">
                                <td style="text-align: left; border-top: solid 1px black;"> <b> Amount Paid </b> </td>

                                <td style="text-align: right; border-top: solid 1px black;"> 
                                    <input  class="input-mini amountpaidinput<%=vst.getPatientid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" value="0.00"/>



                                    <div id="password_link<%=vst.getPatientid()%>" title='Confirm Authorization'>

                                        <table>
                                            <tr>
                                                <td>
                                                    Username
                                                </td>

                                                <td>
                                                    <input type="text" name="username" id="username<%=vst.getPatientid()%>" /><br/>

                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    Password
                                                </td>

                                                <td>
                                                    <input type="password" name="password" id="password<%=vst.getPatientid()%>" /><br/>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>

                                                </td>
                                                <td>
                                                    <button class="btn btn-info btn-small pull-right" id="verify<%=vst.getPatientid()%>" onclick="return false">
                                                        <i class="icon-white icon-check"></i> Give Discount
                                                    </button>  
                                                </td>
                                            </tr>
                                        </table>


                                    </div>

                                    <div  id="discount_links<%=vst.getPatientid()%>" title="Discounting Medical Bill">
                                        <form action="" class="form-horizontal" method="post">
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">Percentage Discount</label> 
                                                <div class="controls">
                                                    <input class="input-mini decimal" type="text" name="percentagediscount" id="percentagediscount<%=vst.getPatientid()%>" />
                                                    <p class="help-inline"> % </p>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">Actual Discount</label>  
                                                <div class="controls">
                                                    <input class="input-mini decimal" type="text" name="actualdiscount" id="actualdiscount<%=vst.getPatientid()%>" />  
                                                    <p class="help-inline"> GHS </p>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">
                                                    New Credited Price</label> 
                                                <div class="controls"> 
                                                    <input  class="input-mini decimal" type="text" name="newamount" id="newamount<%=vst.getPatientid()%>" />
                                                    <p class="help-inline"> GHS </p>
                                                </div>
                                            </div>
                                            <% String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                                                String y = yr.substring(2);
                                                FolderNumbering folderNumbering = (FolderNumbering) mgr.getFolderNumbering(1);
                                                int toadd = folderNumbering.getDiagnosticStartNumber() + folderNumbering.getDiagnosticCounter() + 1;
                                                String orderid = y + "" + folderNumbering.getFolderAbbreviationDiagnostics() + "" + toadd;

                                            %>
                                            <input type="hidden" name="status" id="statusdis<%=vst.getPatientid()%>" value="Medical Bills" />
                                            <input type="hidden" name="visitid" id="visitiddis<%=vst.getPatientid()%>" value="<%=vst.getOrderid()%>" />
                                            <input type="hidden" name="patid" id="patientdis<%=vst.getPatientid()%>" value="<%=vst.getPatientid()%>" />
                                            <input type="hidden" name="staffid" id="staffiddis<%=vst.getPatientid()%>" value="" />
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">
                                                    Reason</label>
                                                <div class="controls"> 
                                                    <textarea name="reasondis" id="reasondis<%=vst.getPatientid()%>"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <button class="btn btn-success btn-small pull-left" id="<%=vst.getPatientid()%>_discount" onclick="return false;">
                                                    <i class="icon-white icon-check"></i> Confirm Discount
                                                </button>


                                                <button class="btn btn-danger btn-small pull-right" id="<%=vst.getPatientid()%>_discount_cancel" onclick="return false;">
                                                    <i class="icon-white icon-check"></i> Cancel
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </td>
                            </tr>


                            <tr class="hide">
                                <td style="text-align: left;">  <b class="balancetextcolour<%=vst.getPatientid()%>">Balance Due </b>  </td>

                                <td style="text-align: right;"> 
                                    <div class="control-group">

                                        <div class="controls">

                                            <span style="margin: 0px;" class="balancetext<%=vst.getPatientid()%>">

                                            </span>
                                            <input disabled="disabled"  class="balanceinput<%=vst.getPatientid()%>" type="hidden"   value=""/>

                                        </div>
                                    </div></td>


                            </tr>
                            <% }%>
                            

                        </tbody>
                    </table>







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

                                <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> DISPENSARY INVOICE</h3>

                            </div>
                            <hr class="row" style="border-top: 2px solid #45BF55;margin-top: 0px;" >


                            <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">
                                <table style="width: 100%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px; float: left;">
                                    <tr>
                                        <td> Date:</td> <td><%=formatter.format(vst.getOrderdate())%> </td>
                                    </tr>
                                    <tr>
                                        <td> Invoice No:</td> <td><%= vst.getOrderid()%> </td>
                                    </tr>
                                    <tr>
                                        <td> Account:</td> <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getType()%>  </td>
                                    </tr>
                                    <tr>
                                        <td> Name:</td> <td style="text-transform: uppercase;"><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                            <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                            <%= mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>
                                    </tr>
                                    <tr>
                                        <td> Card No:</td> <td style="text-transform: uppercase;"><%= vst.getPatientid()%> </td>
                                    </tr>

                                </table>

                                <div style="clear: both;"></div>

                                <hr class="row" style="border-top: 2px solid #45BF55;
                                    margin-top: 5px;" >
                                <div class="row center">

                                    <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing:  ">PRESCRIBED DRUGS</h3>

                                </div>

                                <table style="width: 100%" cellspacing="0">
                                    <thead>
                                        <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <th style="width: 300px; border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;">Details </th>
                                            <th style="width: 70px; text-align: right;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; border-right: none; text-align: center;">
                                                Quantity
                                            </th>
                                            <th style="width: 80px; text-align: right;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; border-right: none;">
                                                Unit Cost
                                            </th>
                                            <th style="width: 60px; text-align: right;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px; padding-right: 10px;  border-left: none;">
                                                Total
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                        <%

                                            List ptreatmentss2 = mgr.listPatientTreatmentsByVisitId(vst.getVisitid());
                                            for (int r = 0; r < ptreatmentss2.size(); r++) {
                                                Patienttreatment ptPatienttreatments2 = (Patienttreatment) ptreatmentss2.get(r);

                                        %>

                                        <tr>
                                            <td class="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments2.getTreatmentid()%>" style=" text-transform: uppercase;">
                                                <%=mgr.getTreatment(ptPatienttreatments2.getTreatmentid()).getTreatment()%>
                                            </td>
                                            <td class="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments2.getTreatmentid()%>" style="text-align: right">
                                                <%=ptPatienttreatments2.getQuantity()%>
                                            </td>
                                            <td class="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments2.getTreatmentid()%>" style="text-align: right">
                                                <%=df.format(ptPatienttreatments2.getPrice())%>
                                            </td>
                                            <td style="text-align: right; padding-right: 10px; font-weight: bold; " class="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments2.getTreatmentid()%>">
                                                <%= df.format((ptPatienttreatments2.getQuantity() * ptPatienttreatments2.getPrice()))%>
                                            </td>
                                        </tr>

                                        <% }
                                        %>

                                        <tr>
                                            <td colspan="3" style="border-top: solid 1px black">
                                                <b>   TOTAL BILL </b>
                                            </td>
                                            <td style="border-top: solid 1px black; text-align: right; font-weight: bold; padding-right: 10px;">
                                                <span class="amountduetext<%=vst.getOrderid()%>"> </span>
                                            </td>
                                            <td>

                                        </tr>

                                    </tbody>
                                </table>
                                <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                    Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                    Wishing You Speedy Recovery <br /> Thank you
                                </div>        

                        </section> 
                    </div>



                    <div style="text-align: center;" class="form-actions">
                        <button class="btn btn-info pull-left" style="width: 40%" href="" onclick='printSelection(document.getElementById("print<%=vst.getOrderid()%>"));return false'>
                            <i class="icon-white icon-print"></i> Print Invoice
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
                        <input type="hidden" name="unitid" value="<%=unitid%>"/>

                        <button class="btn btn-danger pull-right" style="width: 40%" name="action" value="Forward to Accounts">
                            <i class="icon-white icon-arrow-right"></i> Forward
                        </button>
                    </div>
                </form>

            </div>
            <% }
                }%>


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

<!-- <script type="text/javascript" src="js/tablecloth.js"></script>  -->
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
       
        $("#override_action").dialog({
            autoOpen : false,
            width : 500,
            
            modal :true

        });
       
        $("input:checkbox").attr("checked", true);
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        // menu_ul.hide();

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
            
         
        
        $(".patient").popover({

            placement : 'right',
            animation : true

        });
    
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "sScrollY" : "400px",
            "aaSorting" : [],
            "bSort" : true

        });

    });

</script>
<% for (int i = 0;
            i < visits.size();
            i++) {
        Pharmorder vst = (Pharmorder) visits.get(i);
%>


<script type="text/javascript">
    var amountdue<%=vst.getOrderid()%> = 0.0;
    
    $(".amountduepiece<%=vst.getOrderid()%>").each(function(){
         
        //alert("amountduepiece"+ $(".amountduepiece<%=vst.getOrderid()%>").attr("value"))
        amountdue<%=vst.getOrderid()%> = parseFloat(amountdue<%=vst.getOrderid()%>)  + parseFloat($(this).attr("value"));
        $(".amountduetext<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
    });
    
    // alert($(".amountdueinput<%=vst.getOrderid()%>").attr("value"));
                      
    $("#<%= vst.getPatientid()%>_dialog").dialog({
        autoOpen : true,
        width : "98%",
        modal :true,
        position : "top"

    });
    
   
    
   
    
    $("#<%= vst.getPatientid()%>_link").click(function(){
      
        $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
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
                    if ($(this).attr("id")=="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>"){
                        $(".treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>").css('text-decoration','none')
                        $(".treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>").css('display','block')
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
                    if ($(this).attr("id")=="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>"){
                        $(".treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>").css('text-decoration','line-through')
                        $(".treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>").css('display','none')
                    }
    
                    $("#regg<%=ptPatienttreatments.getId()%>").attr("checked", false);  
                    $("#regg2<%=ptPatienttreatments.getId()%>").attr("checked", false);
                    $("#con<%=ptPatienttreatments.getId()%>").attr("checked", false);  
                    $("#con2<%=ptPatienttreatments.getId()%>").attr("checked", false);
        
                    $("#con<%=ptPatienttreatments.getId()%>").change(function(){
                        if($("#con<%=ptPatienttreatments.getId()%>").is(':checked')){
                            $("#displaycon2<%=ptPatienttreatments.getId()%>").css("display", "block")
                        }else{
                            $("#displaycon2<%=ptPatienttreatments.getId()%>").css("display", "none")
                        }
                    });
        
                    $("#con2<%=ptPatienttreatments.getId()%>").change(function(){
                        if($("#con2<%=ptPatienttreatments.getId()%>").is(':checked')){
                            $("#displaycon3<%=ptPatienttreatments.getId()%>").css("display", "block")
                        }else{
                            $("#displaycon3<%=ptPatienttreatments.getId()%>").css("display", "none")
                        }
                    });
                        
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
    
</script>



<% }%>

</body>
</html>
