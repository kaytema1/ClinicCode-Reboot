<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("index.jsp");
    }

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy hh:mm a");
    SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat time = new SimpleDateFormat("h:mm a");

    Date date = new Date();

    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String patient = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
    String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");

    LabPatient p = mgr.getLabPatientByID(patient);
    String labtest[] = request.getParameterValues("labtest1");
    //out.print(p.getPatientid());

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
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

                        <li>
                            <a href="labreception.jsp">Laboratory Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Lab Request</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>

                    <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Laboratory Number</th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Requested On</th>
                                    <th style="text-align: left;">Time</th>
                                    <th style="text-align: center;"></th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr class="odd gradeX">
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px; text-align: left;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= p.getFname()%>, <%= p.getLname()%> <%= p.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Payment Type </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>"><b><a class="patientid"><%= labid%></a></b></td>
                                    <td style="text-align: left;"><%= p.getFname()%>  <%= p.getMidname()%> <%= p.getLname()%>
                                    </td>
                                    <td style="text-align: left;"><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                    <td style="text-align: left;">  <%= formatter.format(p.getDateofbirth())%> </td>
                                    <td style="text-align: left;"><%=formatter.format(mgr.getLabPatientByID(p.getPatientid()).getDateofregistration())%>

                                        <% Date newdate = new Date();

                                        %>
                                    <td style="text-align: left;"> <%= time.format(newdate)%> </td>
                                    </td>
                                    <td style="text-align: center;">
                                        <div id="d_<%=p.getPatientid()%>" style="display: block; text-align: center;">
                                            <a  id="<%=p.getPatientid()%>_patientidlink"  class="btn btn-info btn-small" onclick='getType()'> <i class="icon-pencil icon-white"> </i> Lab Payment </a>
                                        </div>
                                        <!--form class="span3" style="text-align: center; margin-left: 25%;"  action="action/labaction.jsp" method="post">

                                            <button type="button"  class="btn btn-info" onclick="printSelection(document.getElementById('print<%=p.getPatientid()%>'));" value="redirect" name="action">
                                                <i class="icon-print icon-white"></i> Print Laboratory Request
                                            </button-->
                                        </form>
                                    </td>
                                </tr>

                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container --> 

        <%
            String specimen = "";

            Investigation investigation = null;

            // String arr[]= null;

            List ptreatmentss = mgr.patientInvestigationByOrderId(labid);
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
            double price = 0;
            double secprice = 0;
        %>

        <div style="display: none;" class="hide" id="<%= p.getPatientid()%>_dialog"  
             title="Laboratory Payment for <%= mgr.getLabPatientByID(p.getPatientid()).getFname()%>

             <% if (mgr.getLabPatientByID(p.getPatientid()).getMidname() != null) {%>
             <%= mgr.getLabPatientByID(p.getPatientid()).getMidname()%>
             <% }%>
             <%= mgr.getLabPatientByID(p.getPatientid()).getLname()%>">
            <div style="max-height: 550px; overflow-y:scroll;" class=" thumbnail">
                <span class="span5">
                    <dl class="dl-horizontal">
                        <dt style="text-align: left;" >Laboratory Number:</dt>
                        <dd style="text-transform: uppercase;"><b><%=labid%> </b></dd>
                        <dt style="text-align: left;" >Patient Name:</dt>
                        <dd>
                            <b> <%= mgr.getLabPatientByID(patient).getFname()%>
                                <%= mgr.getLabPatientByID(patient).getMidname()%>
                                <%= mgr.getLabPatientByID(patient).getLname()%> </b>
                        </dd>
                        <dt style="text-align: left;" >Payment Type:</dt>
                        <dd style="text-transform: capitalize;">
                            <% if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("Cash")) {%>
                            Out of Pocket
                            <% } else if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS")) {%>
                            National Health Insurance
                            <% } else if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("Private")) {%>
                            <%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>
                            <% } else {%>
                            Corporate (<%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>)
                            <% }%>
                        </dd>

                    </dl>
                </span>
                <div class="clearfix">

                </div>
                <!--div style="display: none;" class="well thumbnail center laboratory"-->

                <div class="center" id="lab">
                    <form  action="action/labaction.jsp" method="post">
                        <table id="appendx_3<%=p.getPatientid()%>" class="table table-bordered">

                            <thead>
                                <tr>
                                    <th rowspan="2"  style="color: white; text-align: left;" >
                                        Description of Test(s)
                                    </th>
                                    <% if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                    <th rowspan="2" style="color: white; text-align: right;">
                                        Price GH&#162;
                                    </th>
                                    <% }%>

                                    <% if (!mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                    <th  colspan="3" style="color: #fff; width: 100px;"> Co-Payment

                                    </th>

                                    <% }%>
                                </tr>


                                <%
                                    if (!mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                <tr>
                                    <th  style="color: #fff; width: 100px;">
                                        <span style="font-size: 10px;"> 
                                            <u> <b>  Primary Sponsor </b> </u> <Br/>
                                            <%

                                                out.print(mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname());
                                            %> 
                                        </span>
                                    </th>
                                    <th  style="color: #fff; width: 100px;">
                                        <span style="font-size: 10px;"> 

                                            <% if (!mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponsorname().equalsIgnoreCase("Out of Pocket")) {%>
                                            <u> <b>Secondary Sponsor </b> </u> <Br/>
                                            <%  out.print(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor() == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponsorname());%>
                                            <%}%>
                                        </span>
                                    </th>
                                    <th style="color: #fff; width: 100px;">
                                        <span style="font-size: 10px;">
                                            <% if (!mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponsorname().equalsIgnoreCase("Out of Pocket")) {%>
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
                                <% List l = mgr.patientInvestigationByOrderId(labid);
                                    double totall = 0;
                                    double primary = 0;
                                    for (int c = 0; c < l.size(); c++) {
                                        Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(c);
                                        totall = totall + patientinvestigation.getPrice();

                                        if (patientinvestigation.getPrice() > 0) {
                                %>
                                <tr>
                                    <td style="text-transform: capitalize; font-size: 14px;">
                                        <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%>
                                    </td>

                                    <% if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                                    <td style="text-align: right;">
                                        <%=df.format(patientinvestigation.getPrice())%>
                                    </td>

                                    <% }%>

                                    <% if (!mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {
                                            List prices = mgr.listItemPriceList(patientinvestigation.getInvestigationid(), mgr.sponsorshipDetails(p.getPatientid()).getSponsorid());
                                            SponsorLabitemPrice labitemPrice = null;

                                            // if
                                            labitemPrice = prices == null || prices.size() < 1 ? null : (SponsorLabitemPrice) prices.get(0);
                                            price = labitemPrice == null ? patientinvestigation.getPrice() : labitemPrice.getPrice();

                                    %>
                            
                           
                            <% primary = primary + price;
                            %>

                            <td> 
                                <div style="display: block; text-align: center;">

                                    <%=df.format(price)%>
                                    
                                </div>
                                <div class="clearfix"></div>
                                <label  class="switch-container">

                                    <input type="radio" checked="checked" linkup="copayment<%=patientinvestigation.getInvestigationid()%>" id="1_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>" amount="<%=df.format(price)%>"  name="copaymentsecondarycashdefault<%=patientinvestigation.getInvestigationid()%>"  attribute="copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>"    style="width: 100px" class="switch-input hide copaymentsecondarycashdefault copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>   1_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>" checked />
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div> 


                                </label>
                                <div style="display: block; text-align: center;">
                                    <input   class="input-mini decimal sika  copayment<%=patientinvestigation.getInvestigationid()%> first<%=patientinvestigation.getInvestigationid()%>"  style=" text-align: right; vertical-align: bottom; display: none; " type="text" placeholder="0.00" id="1_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>_value" name="<%=patientinvestigation.getInvestigationid()%>_primarysponsor_<%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponshorshipid()%>" value="<%=df.format(price)%>"/>     
                              
                                </div>
                            </td>
                            <td>
                                <%if (!mgr.sponsorshipDetails(p.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                <div style="display: block;text-align: center" id="displaycon<%=p.getPatientid()%>">

                                    <%
                                        List pricess = mgr.listItemPriceList(patientinvestigation.getInvestigationid(), mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor());
                                        SponsorLabitemPrice labitemPrices = null;

                                        // if
                                        labitemPrice = pricess == null || pricess.size() < 1 ? null : (SponsorLabitemPrice) pricess.get(0);
                                        secprice = labitemPrices == null ? patientinvestigation.getPrice() : labitemPrices.getPrice();

                                        out.print(df.format(secprice));
                                    %>
                                </div>
                                <label style="text-align: center" class="switch-container">
                                    <input type="radio" linkup="copayment<%=patientinvestigation.getInvestigationid()%>" id="2_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>" amount="<%=df.format(secprice)%>"  name="copaymentsecondarycashdefault<%=patientinvestigation.getInvestigationid()%>" value="" attribute="copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>"   style="width: 100px" class="switch-input hide copaymentsecondarycashdefault copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%> 2_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>"/>
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
                                        if (!mgr.sponsorshipDetails(p.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>

                                    <% //primary = primary + secprice;
                                    %>
                                    <input  class="input-mini sika decimal copayment<%=patientinvestigation.getInvestigationid()%> second<%=patientinvestigation.getInvestigationid()%>" style="text-align: right; display: none;" type="text" 
                                            name="<%=patientinvestigation.getInvestigationid()%>_secondarysponsor_<%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponshorshipid()%>" placeholder="0.00" id="2_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>_value"  value=""/>
                           
                                    
                                    <%}%>
                                </div>
                            </td>
                            <td>
                                <div style="text-align: center;">
                                    <%out.print(df.format(patientinvestigation.getPrice()));%>
                                </div>
                                <label class="switch-container">
                                    <input type="radio" linkup="copayment<%=patientinvestigation.getInvestigationid()%>" id="copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>" amount="<%out.print(df.format(patientinvestigation.getPrice()));%>" name="copaymentsecondarycashdefault<%=patientinvestigation.getInvestigationid()%>" value="" attribute="copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>"   style="width: 100px" class="switch-input hide copaymentsecondarycashdefault copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%> 3_copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>"/>
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div>    
                                </label>

                                <div style="text-align: center; ">
                                    <input  class="input-mini sika decimal copayment<%=patientinvestigation.getInvestigationid()%> third<%=patientinvestigation.getInvestigationid()%>" style="text-align: right;display: none; " name="<%=patientinvestigation.getInvestigationid()%>_outofpocket" type="text" id="copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>_value" placeholder="0.00"  value=""/>
                                    

                                </div>
                            </td>
                            <!--    <td>
                                    <label class="switch-container">
    
                                        <input type="checkbox"  name="copaymentsecondarycashdefault" value="" attribute="copaymentsecondarycashdefault_input<%=patientinvestigation.getInvestigationid()%>"   style="width: 100px" class="switch-input hide copaymentsecondarycashdefault">
                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div>   
                                    </label>
    
                                </td>  -->

                            <% }%>

                            </tr>
                            <% }
                                }%>
                            <tr>
                                <td style="border-top: solid 1px black;  border-bottom: solid 1px black;  line-height: 25px;">
                                    <b>Total Bill </b>
                                </td>
                                <td style="border-top: solid 1px black;  border-bottom: solid 1px black;  line-height: 25px;">


                                    <%if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%>
                                    <input class="amountdueinput<%=p.getPatientid()%>" style="color: blue;"  type="hidden" name="useme"  value="<%=df.format(primary)%>" />
                                    <!--   
                                       Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>
                                      ---> 

                                    <%} else {%>

                                    <input  class="amountdueinput<%=p.getPatientid()%>" type="hidden" name="useme" value="<%=totall%>" id="useme"/>
                                    <span style="text-align: right; float: right;"> <%= df.format(totall)%> </span>
                                    <%}%>
                                </td>
                                <% if (!mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                <td style="border-top: solid 1px black;  border-bottom: solid 1px black;  text-align: right; font-weight: bolder;">



                                    <input type="hidden" id="primary_grand_total" value="<%=df.format(primary)%>" />
                                    <!-- <%=df.format(primary)%>  -->
                                </td>

                                <td style="border-top: solid 1px black; text-align: center;  border-bottom: solid 1px black;  line-height: 25px;">
                                    <span style="font-weight: bolder; text-align: center; padding-left: 20px;" class="sika_show">


                                    </span>
                                </td>

                                <%}%>
                            </tr>
                            <% if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("cooperate")) {%> 
                            <tr style="display: none;">
                                <td  style="text-align: left; border-top: solid 1px black;"> <b> Amount Paid </b> </td>

                                <td style="text-align: right; border-top: solid 1px black;"> 
                                    <input  class="input-mini amountpaidinput<%=p.getPatientid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" placeholder="0.00" value=""/>


                                </td>


                            </tr>
                            <% } else {%> 
                            <tr>
                                <td class="discount_row<%=p.getPatientid()%> hide" style="text-align: left;">  
                                    <b>
                                        Discount
                                    </b>
                                </td>


                                <td class="discount_row<%=p.getPatientid()%> hide">
                                    <span style="text-align: right; float: right;" class="discount_row_amount<%=p.getPatientid()%>"></span>
                                    <span style="text-align: right; float: right" class="discount_row_percent<%=p.getPatientid()%>"></span>
                                </td>

                            </tr>

                            <tr>
                                <td class="discount_row<%=p.getPatientid()%> hide " style="text-align: left;">  
                                    <b>
                                        Bill Due to Discount
                                    </b>
                                </td>
                                <td class="discount_row<%=p.getPatientid()%> text-success hide">
                                    <span style="text-align: right; float: right;" class="bill_after_discount<%=p.getPatientid()%>"></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; border-top: solid 1px black;"> <b> Amount Paid </b> </td>

                                <td style="text-align: right; border-top: solid 1px black;"> 
                                    <input  class="input-mini amountpaidinput<%=p.getPatientid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" value="0.00"/>



                                    <div id="password_link<%=p.getPatientid()%>" title='Confirm Authorization'>

                                        <table>
                                            <tr>
                                                <td>
                                                    Username
                                                </td>

                                                <td>
                                                    <input type="text" name="username" id="username<%=p.getPatientid()%>" /><br/>

                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    Password
                                                </td>

                                                <td>
                                                    <input type="password" name="password" id="password<%=p.getPatientid()%>" /><br/>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>

                                                </td>
                                                <td>
                                                    <button class="btn btn-info btn-small pull-right" id="verify<%=p.getPatientid()%>" onclick="return false">
                                                        <i class="icon-white icon-check"></i> Give Discount
                                                    </button>  
                                                </td>
                                            </tr>
                                        </table>


                                    </div>

                                    <div  id="discount_links<%=p.getPatientid()%>" title="Discounting Medical Bill">
                                        <form action="" class="form-horizontal" method="post">
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">Percentage Discount</label> 
                                                <div class="controls">
                                                    <input class="input-mini decimal" type="text" name="percentagediscount" id="percentagediscount<%=p.getPatientid()%>" />
                                                    <p class="help-inline"> % </p>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">Actual Discount</label>  
                                                <div class="controls">
                                                    <input class="input-mini decimal" type="text" name="actualdiscount" id="actualdiscount<%=p.getPatientid()%>" />  
                                                    <p class="help-inline"> GHS </p>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">
                                                    New Credited Price</label> 
                                                <div class="controls"> 
                                                    <input  class="input-mini decimal" type="text" name="newamount" id="newamount<%=p.getPatientid()%>" />
                                                    <p class="help-inline"> GHS </p>
                                                </div>
                                            </div>
                                            <% String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                                                String y = yr.substring(2);
                                                FolderNumbering folderNumbering = (FolderNumbering) mgr.getFolderNumbering(1);
                                                int toadd = folderNumbering.getDiagnosticStartNumber() + folderNumbering.getDiagnosticCounter() + 1;
                                                String orderid = y + "" + folderNumbering.getFolderAbbreviationDiagnostics() + "" + toadd;

                                            %>
                                            <input type="hidden" name="status" id="statusdis<%=p.getPatientid()%>" value="Medical Bills" />
                                            <input type="hidden" name="visitid" id="visitiddis<%=p.getPatientid()%>" value="<%=labid%>" />
                                            <input type="hidden" name="patid" id="patientdis<%=p.getPatientid()%>" value="<%=p.getPatientid()%>" />
                                            <input type="hidden" name="staffid" id="staffiddis<%=p.getPatientid()%>" value="" />
                                            <div class="control-group">
                                                <label class="control-label" for="inputEmail">
                                                    Reason</label>
                                                <div class="controls"> 
                                                    <textarea name="reasondis" id="reasondis<%=p.getPatientid()%>"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <button class="btn btn-success btn-small pull-left" id="<%=p.getPatientid()%>_discount" onclick="return false;">
                                                    <i class="icon-white icon-check"></i> Confirm Discount
                                                </button>


                                                <button class="btn btn-danger btn-small pull-right" id="<%=p.getPatientid()%>_discount_cancel" onclick="return false;">
                                                    <i class="icon-white icon-check"></i> Cancel
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </td>
                            </tr>


                            <tr>
                                <td style="text-align: left;">  <b class="balancetextcolour<%=p.getPatientid()%>">Balance Due </b>  </td>

                                <td style="text-align: right;"> 
                                    <div class="control-group">

                                        <div class="controls">

                                            <span style="margin: 0px;" class="balancetext<%=p.getPatientid()%>">

                                            </span>
                                            <input disabled="disabled"  class="balanceinput<%=p.getPatientid()%>" type="hidden"   value=""/>

                                        </div>
                                    </div></td>
                               <!-- <td class="paymentstatus<%=labid%>"> </td> -->

                            </tr>
                            <% }%>
                            <tr>
                                <td style="line-height: 18px; ">
                                    <b> Referred By </b>

                                    <span style="text-align: right; float: right;">
                                        <%=mgr.getLaborders(labid).getPhysician()%> of <%= mgr.getLaborders(labid).getFacility()%>
                                    </span>
                                </td>
                                <td >

                                </td>

                                <% if (!mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                <td>

                                </td>

                                <td>

                                </td>

                                <% }%>

                            </tr>
                            </tbody>
                        </table>
                        <table id="showrow2">

                        </table>

                        <input type="hidden" name="patient" value="<%=p.getPatientid()%>"/>
                        <input type="hidden" name="labid" value="<%=labid%>"/>
                        <input type="hidden" name="refer" value="<%=request.getParameter("refer") == "" ? "" : request.getParameter("refer")%>"/>
                        <input type="hidden" name="contype" id="contype" value=""/>

                        <div style="width: 100%; text-align: center;">
                            <button class="btn btn-danger" type="submit" onclick="printSelection1(document.getElementById('print_receipt<%=p.getPatientid()%>')); document.form.submit(); return false"   id="action" name="action" value="actionforward">
                                <i class="icon-arrow-right icon-white"> </i> Save & Forward to Sample Collection Point
                            </button>
                        </div>
                        <br /><br />
                        <br /><br />

                        <div class="clearfix">

                        </div>
                        <button type="button"  class="btn btn-info span3" onclick="printSelection(document.getElementById('print<%=p.getPatientid()%>'));pickvalue();return false">
                            <i class="icon-print icon-white"></i> Print Laboratory Request Form
                        </button>
                        <%if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%>

                        <% } else {%>
                        <button type="button" class ="btn  btn-inverse span3" style="color: white;" href="#" onclick='showdiscount("discount<%=p.getPatientid()%>");return false' id="discount<%=p.getPatientid()%>">
                            <i class="icon-white icon-arrow-down"></i> Discount
                        </button>
                        <% }%>

                        <button type="button" id="print_receipt_button"  class="btn btn-info
                                <%if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%>
                                offset3
                                <% }%>
                                span3" onclick="printSelection1(document.getElementById('print_receipt<%=p.getPatientid()%>'));return false">
                            <i class="icon-print icon-white"></i> Print Receipt
                        </button>

                    </form>

                    <br />
                    <br />
                </div>
                <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=p.getPatientid()%>"> 

                    <section class="hide" id="dashboard">

                        <table style="width: 100%">
                            <thead style="display: table-header-group; width: 100%">
                                <tr>
                                    <th colspan="4">
                                        <!-- Headings & Paragraph Copy -->
                            <div class="container">

                                <div style="margin-bottom: -15px;" class="row">
                                    <div class="span3" style="float: left;">
                                        <img src="images/danponglab.png" width="250px;" style="margin-top: 30px;" />
                                    </div>

                                    <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" />        

                                </div>

                                <div style="clear: both;"></div>

                                <hr style="border: solid #000000 0.5px ;"/>
                                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                    <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= labid%> </h3>

                                </div>
                                <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                    <table style="width: 45%; float: left; margin-left: 6px; font-size:  11px;">

                                        <tr>
                                            <td style="line-height: 18px; width: 120px;">
                                                LABORATORY NO.: 
                                            </td>
                                            <td style="line-height: 18px; text-transform: uppercase">
                                                <b> <%=labid%> </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT NAME: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <b> <%=mgr.getLabPatientByID(p.getPatientid()).getFname()%>
                                                    <%=mgr.getLabPatientByID(p.getPatientid()).getMidname()%>
                                                    <%=mgr.getLabPatientByID(p.getPatientid()).getLname()%> </b>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT SEX: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%=mgr.getLabPatientByID(p.getPatientid()).getGender()%>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT AGE & DOB: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <% String yr = mgr.getLabPatientByID(p.getPatientid()).getDateofbirth() + "";
                                                    String tt = yr.split("-")[0];
                                                    //String tyr = new Date()+"";
                                                    SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                    String tyr = dateFormat1.format(new Date()) + "";
                                                    String t = tyr.split("-")[0];
                                                %>

                                                <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years / <%=formatter.format(mgr.getLabPatientByID(p.getPatientid()).getDateofbirth())%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT TEL NO.: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%=mgr.getLabPatientByID(p.getPatientid()).getContact()%>
                                            </td>
                                        </tr>
                                    </table>

                                    <table style="width: 50%; float: left; margin-left: 22px; font-size:  11px;">
                                        <tr>
                                            <td style="line-height: 18px;">
                                                REFERRED BY:
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%Laborders laborders = mgr.getLaborders(labid);
                                                    out.print(laborders.getPhysician());
                                                %>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="line-height: 18px;">
                                                HOSPITAL / CLINIC: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%= laborders.getFacility()%>
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
                                            <td style="line-height: 18px;">
                                                COLLECTION DATE: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%=datetimeformat.format(date)%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px;">
                                                REPORT DATE: 
                                            </td>
                                            <td style="line-height: 18px; text-transform: uppercase">

                                            </td>
                                        </tr>

                                    </table>  
                                </div>

                                <div style="clear: both;"></div>

                                <hr class="row" style="border-top: 2px solid  #000;
                                    margin-top: 5px;" >
                                <div class="row center">


                                    <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;"><h3 style="font-weight:bold; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; text-transform: uppercase;  ">
                                            <b> LABORATORY REQUEST FORM</b></h3> </div>
                                    <br />
                                </div>
                            </div>

                            </th>
                            </tr>
                            </thead>
                            <tbody style="width: 100%">
                                <tr>
                                    <td colspan="4">

                                        <!-- thead end -->
                                        <!-- tbody start -->
                                        <table style="width: 100%" cellspacing="0">
                                            <thead>
                                                <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: none;">Description of Test(s) </th>

                                                    <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: none;">
                                                        <span style="text-align: right; float: right; padding-right: 50px; "> Price GH&#162; </span>
                                                    </th>

                                                </tr>
                                            </thead>
                                            <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <%List list = mgr.patientInvestigationByOrderId(labid);
                                                    double total = 0.0;
                                                    double secondary = 0.0;
                                                    if (list.size() > 0 && list != null) {
                                                        for (int sz = 0; sz < list.size(); sz++) {
                                                            Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                            total = total + patientinvestigation.getPrice();
                                                            if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("cooperate")) {
                                                                secondary = secondary + price;
                                                            }
                                                            if (patientinvestigation.getPrice() > 0) {
                                                %>

                                                <tr>
                                                    <td style="padding-left: 15px; line-height: 25px; text-transform: capitalize;">
                                                        <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%> 
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; padding-right: 50px;" >
                                                        <% if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("cooperate")) {%>
                                                        <%= price%>
                                                        <%} else {%>
                                                        <%= df.format(patientinvestigation.getPrice())%> 
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <%
                                                            }
                                                        }
                                                    }%>

                                                <%  if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("cooperate")) {%> 
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                        <b>Total Bill Credited </b>
                                                    </td>
                                            <input type="hidden" value="<%=df.format(secondary)%>" id="amountdueinput<%=p.getPatientid()%>" />
                                            <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=p.getPatientid()%>">
                                                <span style="font-weight: bolder; text-align: center; padding-left: 20px;" class="sika_show">


                                                </span>
                                                <!--  <%=df.format(secondary)%>  -->
                                            </td>
                                </tr>
                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                    <td style="padding-top: 10px; padding-left: 15px;">
                                        Payment Status  
                                    </td>
                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=p.getPatientid()%> ">

                                        Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()) == null ? mgr.sponsorshipDetails(patient).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()).getSponsorname()%>

                                    </td>
                                </tr>



                                <% } else {%> 

                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; line-height: 25px;">
                                        <b>Total Bill</b>
                                        <input type="hidden" value="<%=df.format(total)%>" id="amountdueinput<%=p.getPatientid()%>" />
                                    </td>
                                    <td style="border-top: solid 1px black;  border-bottom: solid 1px black; text-align: right; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" >

                                        <!-- <%=df.format(total)%>  -->
                                        <span class="amountduetext<%=p.getPatientid()%>">

                                        </span>
                                    </td>
                                </tr>
                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                    <td style=" padding-left: 15px; line-height: 25px;">
                                        Amount Paid 
                                    </td>
                                    <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=p.getPatientid()%>">

                                    </td>

                                </tr>

                                <tr>
                                    <td class="print_discount_row<%=p.getPatientid()%> hide " style="padding-left: 15px; line-height: 25px; display: none;">  

                                        Discount

                                    </td>
                                    <td style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=p.getPatientid()%> hide discount_row_amount_percent<%=p.getPatientid()%>">

                                    </td>
                                </tr>

                                <tr>
                                    <td class="print_discount_row<%=p.getPatientid()%> hide text-success" style="padding-left: 15px; line-height: 25px; display: none;">  
                                        <b>
                                            Bill Due to Discount
                                        </b>
                                    </td>
                                    <td  style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=p.getPatientid()%> text-success hide bill_after_discount<%=p.getPatientid()%>">

                                    </td>
                                </tr>
                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                    <td style=" padding-left: 15px; line-height: 25px;">
                                        Balance Due
                                    </td>
                                    <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=p.getPatientid()%>">

                                    </td>

                                </tr>
                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                    <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                        Payment Status  
                                    </td>
                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=p.getPatientid()%>">
                                        Fully Sponsored
                                    </td>
                                </tr>


                                <% }%> 


                            </tbody>
                        </table>
                        </td>
                        </tr>
                        </tbody>
                        <tfoot style="display: table-footer-group; width: 100px;">
                            <tr>
                                <th colspan="4">
                        <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                            <br />
                            <br />
                            <span style="letter-spacing: 5px;" >******************</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Request</span> <span style="letter-spacing: 5px;" >******************</span>
                            <br />

                        </div> 
                        <div style=" width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                            Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                            Thank you for doing business with us <br /> Wishing you the best of health.
                        </div>
                        </th>
                        </tr>
                        </tfoot>

                        </table>
                        <!-- tfoot end -->
                    </section>
                </div>



                <div class="regular_receipt" style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt<%=p.getPatientid()%>"> 

                    <section class="hide" id="dashboard">

                        <table style="width: 100%">
                            <thead style="display: table-header-group; width: 100%">
                                <tr>
                                    <th colspan="4">
                                        <!-- Headings & Paragraph Copy -->
                            <div class="container">

                                <div style="margin-bottom: -15px;" class="row">
                                    <div class="span3" style="float: left;">
                                        <img src="images/danponglab.png" width="120px;" style="margin-top: 30px;" />
                                    </div>

                                    <img src="images/danpongaddress.png" width="140px;" style="float: right; margin-top: 20px;" />        

                                </div>

                                <div style="clear: both;"></div>

                                <hr style="border: solid #000000 0.5px ;"/>




                                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                    <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= labid%> </h3>

                                </div>
                                <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                    <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT NAME: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <b> <%=mgr.getLabPatientByID(p.getPatientid()).getFname()%>
                                                    <%=mgr.getLabPatientByID(p.getPatientid()).getMidname()%>
                                                    <%=mgr.getLabPatientByID(p.getPatientid()).getLname()%> </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px;">
                                                ISSUED ON: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%=datetimeformat.format(date)%>
                                            </td>
                                        </tr>


                                    </table>  
                                </div>

                                <div style="clear: both;"></div>

                                <hr class="row" style="border-top: 2px solid  #000;
                                    margin-top: 5px;" >
                                <div class="row center">


                                    <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;"><h3 style="font-weight:bold; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; text-transform: uppercase;  ">
                                            <b> OFFICIAL RECEIPT</b></h3>
                                        <div style="font-size: 12px; font-weight: lighter;">  PLEASE PRODUCE THIS RECEIPT <br /> FOR COLLECTION OF LAB. REPORT </div>

                                    </div>
                                    <br />
                                </div>
                            </div>

                            </th>
                            </tr>
                            </thead>
                            <tbody style="width: 100%">
                                <tr>
                                    <td colspan="4">

                                        <!-- thead end -->
                                        <!-- tbody start -->
                                        <table style="width: 100%" cellspacing="0">
                                            <thead>
                                                <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: none;">Description of Test(s) </th>

                                                    <th style="width: 80px; text-align: right; padding-right: 50px; border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: none;">
                                                        Price GH &#162;
                                                    </th>

                                                </tr>
                                            </thead>
                                            <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <%list = mgr.patientInvestigationByOrderId(labid);
                                                    double total1 = 0.0;
                                                    if (list.size() > 0 && list != null) {
                                                        for (int sz = 0; sz < list.size(); sz++) {
                                                            Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                            total1 = total1 + patientinvestigation.getPrice();
                                                            if (patientinvestigation.getPrice() > 0) {
                                                %>

                                                <tr>
                                                    <td  style="padding-left: 15px; line-height: 25px; text-transform: capitalize; ">
                                                        <span class="receipt_name"> <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%>  </span>
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; padding-right: 50px;" >
                                                        <% if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("cooperate")) {%>
                                                        <%= df.format(price)%>
                                                        <%} else {%>
                                                        <%= df.format(patientinvestigation.getPrice())%> 
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <%
                                                            }
                                                        }
                                                    }%>

                                                <%  if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("cooperate")) {%> 
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                        <b>Total Bill Credited </b>
                                                    </td>
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=p.getPatientid()%>" >

                                                        <span style="font-weight: bolder; text-align: center; padding-left: 20px;" class="sika_show">


                                                        </span>
                                                        <!--  <%=df.format(secondary)%>  -->
                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="padding-top: 10px; padding-left: 15px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="padding-top: 10px;   margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=p.getPatientid()%> ">

                                                        Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()) == null ? mgr.sponsorshipDetails(patient).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()).getSponsorname()%>

                                                    </td>
                                                </tr>



                                                <% } else {%> 

                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                        <b>   Total Bill </b>
                                                    </td>
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; text-align: right; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" >
                                                        <%=df.format(total1)%>
                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Amount Paid 
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=p.getPatientid()%>">

                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="print_discount_row<%=p.getPatientid()%> hide " style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">  

                                                        Discount

                                                    </td>
                                                    <td style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=p.getPatientid()%> hide discount_row_amount_percent<%=p.getPatientid()%>">

                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="print_discount_row<%=p.getPatientid()%> hide text-success" style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">   
                                                        <b>
                                                            Bill Due to Discount
                                                        </b>
                                                    </td>
                                                    <td  style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=p.getPatientid()%> text-success hide bill_after_discount<%=p.getPatientid()%>">

                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Balance Due
                                                    </td>
                                                    <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=p.getPatientid()%>">

                                                    </td>

                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=p.getPatientid()%>">

                                                    </td>
                                                </tr>


                                                <% }%> 


                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot style="display: table-footer-group; width: 100px;">
                                <tr>
                                    <th colspan="4">
                            <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                <br />
                                <br />
                                <span style="letter-spacing: 5px;" >*********</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Receipt</span> <span style="letter-spacing: 5px;" >*********</span>
                                <br />

                            </div> 
                            <div style=" width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                Served & Electronically Signed by:  <%= mgr.getStafftableByid(user.getStaffid()).getOthername()%> <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                Thank you for doing business with us <br /> Wishing you the best of health.
                            </div>
                            </th>
                            </tr>
                            </tfoot>

                        </table>
                        <!-- tfoot end -->
                    </section>
                </div>




                <div class="copayment_receipt" style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt3<%= p.getPatientid()%>"> 

                    <section class="hide" id="dashboard">

                        <table style="width: 100%">
                            <thead style="display: table-header-group; width: 100%">
                                <tr>
                                    <th colspan="4">
                                        <!-- Headings & Paragraph Copy -->
                            <div class="container">

                                <div style="margin-bottom: -15px;" class="row">
                                    <div class="span3" style="float: left;">
                                        <img src="images/danponglab.png" width="120px;" style="margin-top: 30px;" />
                                    </div>

                                    <img src="images/danpongaddress.png" width="140px;" style="float: right; margin-top: 20px;" />        

                                </div>

                                <div style="clear: both;"></div>

                                <hr style="border: solid #000000 0.5px ;"/>




                                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                    <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= labid%> </h3>

                                </div>
                                <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                    <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT NAME: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <b> <%=mgr.getLabPatientByID(p.getPatientid()).getFname()%>
                                                    <%=mgr.getLabPatientByID(p.getPatientid()).getMidname()%>
                                                    <%=mgr.getLabPatientByID(p.getPatientid()).getLname()%> </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px;">
                                                ISSUED ON: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <%=datetimeformat.format(date)%>
                                            </td>
                                        </tr>


                                    </table>  
                                </div>

                                <div style="clear: both;"></div>

                                <hr class="row" style="border-top: 2px solid  #000;
                                    margin-top: 5px;" >
                                <div class="row center">


                                    <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;"><h3 style="font-weight:bold; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; text-transform: uppercase;  ">
                                            <b> OFFICIAL RECEIPT</b></h3>
                                        <div style="font-size: 12px; font-weight: lighter;">  PLEASE PRODUCE THIS RECEIPT <br /> FOR COLLECTION OF LAB. REPORT </div>

                                    </div>
                                    <br />
                                </div>
                            </div>

                            </th>
                            </tr>
                            </thead>
                            <tbody style="width: 100%">
                                <tr>
                                    <td colspan="4">

                                        <!-- thead end -->
                                        <!-- tbody start -->
                                        <table style="width: 100%" cellspacing="0">
                                               <thead>
                                                   <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                       <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: none;">Description of Test(s) </th>

                                                       <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: none;">
                                                           Price GH &#162;
                                                       </th>

                                                   </tr>
                                               </thead>  
                                            <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <%List list2 = mgr.patientInvestigationByOrderId(labid);
                                                    double total2 = 0.0;
                                                    int patientInvestigationId = 0;
                                                    String primSponsorId, secSponsorId, outOfPocketId;
                                                    double primSponsorAmount = 0, secSponsorAmount = 0, outOfPocketAmount = 0;
                                                    Sponsorship primarySponsor;
                                                    boolean primSponsorAmountIsMoreThanZero, secSponsorAmountIsMoreThanZero, outOfPaymentAmountIsMoreThanZero;

                                                    if (list2.size() > 0 && list2 != null) {
                                                        for (int sz = 0; sz < list2.size(); sz++) {
                                                            primSponsorAmount = 0;
                                                            secSponsorAmount = 0;
                                                            outOfPocketAmount = 0;
                                                            primSponsorAmountIsMoreThanZero = false;
                                                            secSponsorAmountIsMoreThanZero = false;
                                                            outOfPaymentAmountIsMoreThanZero = false;
                                                            Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                            patientInvestigationId = patientinvestigation.getInvestigationid();
                                                            total2 = total2 + price;
                                                            if (patientinvestigation.getPrice() > 0) {
                                                %>

                                                <tr>
                                                    <td colspan="2"  style="padding-left: 15px; padding-top: 10px; line-height: 15px; text-transform: capitalize; ">
                                                        <span class="receipt_name"> <b> <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%> </b> </span>
                                                    </td>

                                                </tr>



                                                <tr style="width: 100%;">
                                                    <td> 

                                                        <span id="showorhide1description<%=patientinvestigation.getInvestigationid()%>" class="showorhide1<%=patientinvestigation.getInvestigationid()%>" style="padding-left: 15px; line-height: 15px; ">
                                                            <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>
                                                        </span>
                                                    </td>  
                                                    <td style="padding-right: 50px;">
                                                        <span id="showorhide1price<%=patientinvestigation.getInvestigationid()%>" class="showorhide1<%=patientinvestigation.getInvestigationid()%>" style="text-align: right; float: right;">

                                                        </span>
                                                    </td>
                                                </tr>

                                                <tr style="width: 100%">
                                                    <td> 
                                                        <span id="showorhide2description<%=patientinvestigation.getInvestigationid()%>" class="showorhide2<%=patientinvestigation.getInvestigationid()%>" style="padding-left: 15px; line-height: 15px; display: none;" >
                                                            <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponsorname()%>
                                                        </span>
                                                    </td>  
                                                    <td style="padding-right: 50px;">
                                                        <span id="showorhide2price<%=patientinvestigation.getInvestigationid()%>" class="showorhide2<%=patientinvestigation.getInvestigationid()%>" style="text-align: right; float: right;">

                                                        </span>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td> <span id="showorhide3description<%=patientinvestigation.getInvestigationid()%>" class="showorhide3<%=patientinvestigation.getInvestigationid()%>" style="padding-left: 15px; line-height: 15px; display: none;"> Out of Pocket </span> </td>  
                                                    <td style="padding-right: 50px;"> 
                                                        <span id="showorhide3price<%=patientinvestigation.getInvestigationid()%>" class="showorhide3<%=patientinvestigation.getInvestigationid()%>" style="text-align: right; float: right; ">

                                                        </span>
                                                    </td>
                                                </tr>




                                                <%


                                                            }
                                                        }
                                                    }%>


                                                <%  if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                <tr style=" padding-top: 10px; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                        <b>Total Bill </b>
                                                    </td>
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=p.getPatientid()%> sika_show">


                                                        <!--  <%= df.format(total2)%>  -->
                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="padding-top: 10px; padding-left: 15px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=p.getPatientid()%> ">
                                                        <span class="primary_sponsor_desc_amount">

                                                        </span> 
                                                        <br />
                                                        <span class="secondary_sponsor_desc_amount">

                                                        </span> 
                                                        <br />
                                                        <span class="tetiary_sponsor_desc_amount">

                                                        </span>
                                                        <!-- Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  -->

                                                    </td>
                                                </tr>



                                                <% } else {%> 
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                        <b>   Total Bill </b>
                                                    </td>
                                                    <td class="sika_show" style="border-top: solid 1px black; border-bottom: solid 1px black; text-align: right; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" >
                                                        <!-- <%=df.format(total1)%>  -->
                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Amount Paid 
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=p.getPatientid()%>">




                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td  style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">  

                                                        Discount

                                                    </td>
                                                    <td style="line-height: 25px; text-align: right; padding-right: 50px;">

                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td  style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">   

                                                        Bill Due to Discount

                                                    </td>
                                                    <td  style="line-height: 25px; text-align: right; padding-right: 50px;" >

                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Balance Due
                                                    </td>
                                                    <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=p.getPatientid()%>">

                                                    </td>

                                                </tr>


                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=p.getPatientid()%>">

                                                    </td>
                                                </tr> 


                                                <% }%>


                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot style="display: table-footer-group; width: 100px;">
                                <tr>
                                    <th colspan="4">
                            <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                <br />
                                <br />
                                <span style="letter-spacing: 5px;" >*********</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Receipt</span> <span style="letter-spacing: 5px;" >*********</span>
                                <br />

                            </div> 
                            <div style=" width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                Served & Electronically Signed by:  <%= mgr.getStafftableByid(user.getStaffid()).getOthername()%> <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                Thank you for doing business with us <br /> Wishing you the best of health.
                            </div>
                            </th>
                            </tr>
                            </tfoot>

                        </table>
                        <!-- tfoot end -->
                    </section>
                </div>
                <div class="clearfix"></div>
                <!--/div-->
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

        <!--<script type="text/javascript" src="js/tablecloth.js"></script> -->
        <script type="text/javascript" src="js/demo.js"></script>
        <script type="text/javascript" src="js/jquery.numeric.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript">
            $(function() {
                $('.decimal').live("keyup",function(){inputControl($(this),'float');});
                $(".numeric").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
       
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();
                
                $(':input').attr('autocomplete', 'off');
                
                $(".menu").fadeIn();
                $(".alert").fadeIn();
                $(".content1").fadeIn();
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

            });

        </script>
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8">
            var addcount = 0;
            var tt =0;
            $(document).ready(function() {

                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true

                });

                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });

                $(".patient_visit").popover({

                    placement : 'top',
                    animation : true

                });
                
                $("#refer").live('keyup', function(){
                
                    //alert($(this).val());
                    //$("#refertext").attr("value",$("refer").val());
                });  
                
                var is_copayment = false; 
                $(".copaymentsecondarycashdefault").change(function(){
                    is_copayment = false;  
                   
                    var attrID =  $(this).attr("attribute");
                    var theId = $(this).attr("id");
                    
                   // alert(theId)
                    
                    
                    if($(this).is(':checked')){ 
                     var value = $(this).attr("amount");
                     var linkup = $(this).attr("linkup");
                     $("."+linkup).attr("value","0.00");
                     $("#"+theId+"_value").attr("value",value);
                      
                      
                        is_copayment = true;
                    } else {
                        
                        $("."+theClass).attr("checked",true)
                        $(this).attr("checked",false)
                   
                    }
                    
                    if(is_copayment){
                       
                       
                       
                        $(".copayment_receipt").attr("id","print_receipt<%= p.getPatientid()%>")
                        $(".regular_receipt").attr("id","print_receipt3<%= p.getPatientid()%>")
                        
                        $(document).mouseover(function(){
            <% List newl_2 = mgr.patientInvestigationByOrderId(labid);
                double newtotall_2 = 0;
                for (int c = 0; c < newl_2.size(); c++) {
                    Patientinvestigation patientinvestigation1_2 = (Patientinvestigation) newl_2.get(c);
                    newtotall_2 = newtotall_2 + patientinvestigation1_2.getPrice();
                    if (patientinvestigation1_2.getPrice() > 0) {
            %>
                    
                    
                    
                                var input_1 = parseFloat($("#1_copaymentsecondarycashdefault_input<%=patientinvestigation1_2.getInvestigationid()%>_value").attr("value"));
                                var input_2 = parseFloat($("#2_copaymentsecondarycashdefault_input<%=patientinvestigation1_2.getInvestigationid()%>_value").attr("value"));
                                var input_3 = parseFloat($("#copaymentsecondarycashdefault_input<%=patientinvestigation1_2.getInvestigationid()%>_value").attr("value"));
                            
                                if(isNaN(input_1)){
                                    input_1 = 0.00;
                                }
                            
                                if(isNaN(input_2)){
                                    input_2 = 0.00;
                                }
                                if(isNaN(input_3)){
                                    input_3 = 0.00;
                                }
                            
                                if(input_1 != 0.00 && input_2 == 0.00 && input_3 == 0.00){
                                    $("#showorhide1description<%=patientinvestigation1_2.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '80%', 'float': 'left'});
                                    $("#showorhide1price<%=patientinvestigation1_2.getInvestigationid()%>").html(parseFloat(input_1).toFixed(2));
                                    $("#showorhide1price<%=patientinvestigation1_2.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                       
                
                                }
                                
                                
                           
                            
            <% }
                }%>
                                })
                        
                            }else{
                                $(".regular_receipt").attr("id","print_receipt<%= p.getPatientid()%>")
                                $(".copayment_receipt").attr("id","print_receipt3<%= p.getPatientid()%>")
                        
                            }
                    
                    
            
                    
                    
                        })
                        
                        
                        $(document).mouseover(function(){
                            //alert("fdffdf")
                            var bigtotal = 0;
                
                            $(".sika").each(function(){
                                currentnumber = parseFloat($(this).attr("value"));
                                
                                
                                if(isNaN(currentnumber)){
                                    currentnumber = 0.00;
                                }
                                //alert(currentnumber)
                                
                                bigtotal =  bigtotal + currentnumber;
                            });
                            
                            //alert(bigtotal);
                            $(".sika_show").html((bigtotal).toFixed(2));
                            
                            
                
                        });
                        
                        
                        
                        $(".sika").live('keyup',function(){
                            //alert("fdffdf")
                            var bigtotal = 0;
                
                            $(".sika").each(function(){
                                currentnumber = parseFloat($(this).attr("value"));
                                
                                
                                if(isNaN(currentnumber)){
                                    currentnumber = 0.00;
                                }
                                //alert(currentnumber)
                                
                                bigtotal =  bigtotal + currentnumber;
                            });
                            
                            //alert(bigtotal);
                            $(".sika_show").html("GH&#162; "+(bigtotal).toFixed(2));
                            
                          
                        });
                        
                        
                        $(".sika").live('focusout',function(){
                            //alert("fdffdf")
                            var bigtotal = 0;
                
                            $(".sika").each(function(){
                                currentnumber = parseFloat($(this).attr("value"));
                                
                                
                                if(isNaN(currentnumber)){
                                    currentnumber = 0.00;
                                }
                                //alert(currentnumber)
                                
                                bigtotal =  bigtotal + currentnumber;
                            });
                            
                            //alert(bigtotal);
                            $(".sika_show").html((bigtotal).toFixed(2));
                            
                          
                        });
                
                
                
                    });
            
            
            
            <% List newl = mgr.patientInvestigationByOrderId(labid);
                double newtotall = 0;
                for (int c = 0; c < newl.size(); c++) {
                    Patientinvestigation patientinvestigation1 = (Patientinvestigation) newl.get(c);

                    if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {
                        newtotall = newtotall + patientinvestigation1.getPrice() + patientinvestigation1.getPrice() + mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getLabmarkup();
                    } else {
                        newtotall = newtotall + patientinvestigation1.getPrice();
                    }
                    if (patientinvestigation1.getPrice() > 0) {
            %>
            
                
                
                
                
                
                
                var primary_grand_total = $("#primary_grand_total").attr("value");
                // alert(primary_grand_total);
                var actualtotal = 0.00;
                
                
                $(document).mouseover(function(){
                    
                    var maxtotal  =  parseFloat($(".total<%=patientinvestigation1.getInvestigationid()%>").attr("value"));
                    var first  =  parseFloat($(".first<%=patientinvestigation1.getInvestigationid()%>").attr("value"));
                    
                    if(isNaN(first)){
                        first = 0.00;
                    }
                    
                    var second  =  parseFloat($(".second<%=patientinvestigation1.getInvestigationid()%>").attr("value"));
                    
                    if(isNaN(second)){
                        second = 0.00;
                    }
                    
                    var third  =  parseFloat($(".third<%=patientinvestigation1.getInvestigationid()%>").attr("value"));
                    
                    if(isNaN(third)){
                        third = 0.00;
                    }
                    
                    
                    
                    //alert(first);
                    //alert(second);
                    //alert(third);
                    actualtotal = first + second + third;
                    
                    //alert(actualtotal);
                    //alert(maxtotal);
                    
                    if(actualtotal < maxtotal  ){
                        $(".copayment<%=patientinvestigation1.getInvestigationid()%>").addClass("error");
                        $(".btn").attr("disabled","disabled");
                        
                    }else{
                        $(".copayment<%=patientinvestigation1.getInvestigationid()%>").addClass("success");
                        $(".btn").removeAttr("disabled")
                    }
                    
                       
                    
                })
                
                $(document).mouseover(function(){
                    
                    var input1_bool = false;
                    var input2_bool = false;
                    var input3_bool = false; 
                    
                    var input_1 = parseFloat($("#1_copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    var input_2 = parseFloat($("#2_copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    var input_3 = parseFloat($("#copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    
                    
                    
                    if (input_1 > 0){
                        
                        input1_bool = true;
                    }
                    
                    if (input_2 > 0){
                        
                        input2_bool = true;
                    }
                    
                    if (input_3 > 0){
                        
                        input3_bool = true;
                    }
                    
                    
                    if(input1_bool==true){
                        $("#showorhide1description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '80%', 'float': 'left'});
                        $("#showorhide1price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_1).toFixed(2));
                        $("#showorhide1price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                       
                        
                        
                    }else{
                        $(".showorhide1<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    if(input2_bool==true){
                        $("#showorhide2description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '60%'});
                        $("#showorhide2price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                        
                        $("#showorhide2price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_2).toFixed(2))
                        
                    }else{
                        $(".showorhide2<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    if(input3_bool==true){
                        $("#showorhide3description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '60%'});
                        $("#showorhide3price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                        
                        $("#showorhide3price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_3).toFixed(2))
                        
                    }else{
                        $(".showorhide3<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    
                });
                
                
                $(document).mouseover(function(){
                     
                    var input1_bool = false;
                    var input2_bool = false;
                    var input3_bool = false; 
                    
                    var input_1 = parseFloat($("#1_copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    var input_2 = parseFloat($("#2_copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    var input_3 = parseFloat($("#copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    
                    
                    if (input_1 > 0){
                        
                        input1_bool = true;
                    }
                    
                    if (input_2 > 0){
                        
                        input2_bool = true;
                    }
                    
                    if (input_3 > 0){
                        
                        input3_bool = true;
                    }
                    
                    
                    if(input1_bool==true){
                        $("#showorhide1description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '80%', 'float': 'left'});
                        $("#showorhide1price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_1).toFixed(2));
                        $("#showorhide1price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                       
                        
                        
                    }else{
                        $(".showorhide1<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    if(input2_bool==true){
                        $("#showorhide2description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '60%'});
                        $("#showorhide2price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                        
                        $("#showorhide2price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_2).toFixed(2));
                        
                    }else{
                        $(".showorhide2<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    if(input3_bool==true){
                        $("#showorhide3description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '60%'});
                        $("#showorhide3price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                        
                        $("#showorhide3price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_3).toFixed(2))
                        
                    }else{
                        $(".showorhide3<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    
                });
                
                
                $(document).mouseover(function(){
                    var input1_bool = false;
                    var input2_bool = false;
                    var input3_bool = false; 
                    
                    var input_1 = parseFloat($("#1_copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    var input_2 = parseFloat($("#2_copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    var input_3 = parseFloat($("#copaymentsecondarycashdefault_input<%=patientinvestigation1.getInvestigationid()%>_value").attr("value"));
                    
                    //alert(input_3)
                    if (input_1 > 0){
                        
                        input1_bool = true;
                    }
                    
                    if (input_2 > 0){
                        
                        input2_bool = true;
                    }
                    
                    if (input_3 > 0){
                        
                        input3_bool = true;
                    }
                    
                    
                    if(input1_bool==true){
                        $("#showorhide1description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '80%', 'float': 'left'});
                        $("#showorhide1price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_1).toFixed(2))
                        $("#showorhide1price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                       
                        
                        
                    }else{
                        $(".showorhide1<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    if(input2_bool==true){
                        $("#showorhide2description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '60%'});
                        $("#showorhide2price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                        
                        $("#showorhide2price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_2).toFixed(2))
                        
                    }else{
                        $(".showorhide2<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                    
                    if(input3_bool==true){
                        $("#showorhide3description<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '15px' , 'width': '60%'});
                        $("#showorhide3price<%=patientinvestigation1.getInvestigationid()%>").css({'display': 'block' ,'text-align' : 'right', 'padding-right' : '0px', 'float': 'right'});
                        
                        $("#showorhide3price<%=patientinvestigation1.getInvestigationid()%>").html(parseFloat(input_3).toFixed(2))
                        
                    }else{
                        $(".showorhide3<%=patientinvestigation1.getInvestigationid()%>").css("display","none");
                    }
                   
                    
                });
                
                
            
            <% }
                }%>
                    function showConType(id){
                        var show = document.getElementById(id);
                        //var shows = document.getElementById("nhis");
                        //if(show.style.display == "block"){
                        show.style.display="block";
                        //}else{
                
                        //  } if(show.style.display == "none"){ 
                        // shows.style.display="none";
                    }

                    function getContype(){
                        var show = document.getElementById("ty").value
                        document.getElementById("contype").value = show;
                        var t = document.getElementById("contype").value;
                    }
                    function getType(i,d){
                        var show = document.getElementById(i).value
                        document.getElementById(d).value = show;
                        var t = document.getElementById("contype").value;
                    }
            
                    function addInvestigationCheck(id1,id2,id3,id4){
                        // alert(id1);
                        addcount++;
                        var t1 = document.getElementById(id1).value;
                        // var text = document.getElementById(id1);
                        // alert(t1);
                        var tr = document.createElement("tr");
                        var td1 = document.createElement("td"); 
                        var td5 = document.createElement("td");
                        var td6 = document.createElement("td");
                
                        var tr1 = document.createElement("tr");
                        var td7 = document.createElement("td"); 
                        var td8 = document.createElement("td");
                        var td9 = document.createElement("td");
                
                        var tr2 = document.createElement("tr");
                
                        var cb = document.createElement( "input" );
                        var input = document.createElement( "input" );
                        var btn = document.createElement( "button" );
                        var btn1 = document.createElement( "button" );
                        btn.innerHTML = 'Remove';
                        btn1.innerHTML = 'Remove';
                        cb.type = "checkbox";
                        input.type = "text";
                        cb.id = "id";
                        input.id ="in_"+addcount;
                        cb.name = "labtest1";
                        var ttt = t1;
                        var str = t1.split("><");
                
                        var text = document.createTextNode(str[0]+" ---  "+str[2]+"0");
                        var text1 = document.createTextNode(str[0]);
                        var text2 = document.createTextNode(str[2]);
                        //var price = document.createTextNode(str[2]);
                        cb.value = ttt;
                        cb.checked = true;
                        td1.appendChild(text);
                        td6.appendChild(btn);
                
                        td5.appendChild(cb);
                        tr.id = "tr1_"+addcount;
                        tr.appendChild(td1);
                        tr.appendChild(td5);
                        tr.appendChild(td6);
                
                        tr1.id = "tr1_"+addcount;
                        td7.appendChild(text1);
                        td8.id = "td_"+addcount;
            
              
                        input.value = ttt;
                        input.name="labtest[]"
                        // input.value = input.name;
                        //input.disabled = "disabled";
                
                        td9.appendChild(input);
                        tr1.appendChild(td7);
                        // tr1.appendChild(td9);
                        tr2.id = "tr1_"+addcount;
                        tr1.appendChild(td8);
                        tr2.appendChild(td9);
                        document.getElementById(id2).appendChild(tr);
                        document.getElementById(id3).appendChild(tr1);
                        document.getElementById(id4).appendChild(tr2);
                        //  document.getElementById(id3).appendChild(total);
                        var ch = document.getElementById("labtest");
               
                        btn.onclick = function(){
    
                            var tbl = document.getElementById(id2);
                            var tb2 = document.getElementById(id3);
                            var tb3 = document.getElementById(id4);
                    
                            var rem = confirm("Are you sure you to remove this diagnosis");
                            if(rem){
                                tbl.removeChild(document.getElementById(tr.id));
                                tb2.removeChild(document.getElementById(tr.id));
                                tb3.removeChild(document.getElementById(tr.id));
                                addcount--;
                                alert("Removed Successfully");
                                return false;
                            }else{
                                return false;
                            }
                        };
                    }
            
                    function getTotal(){
                        var vl="";
                        for(var i=1;i<= addcount;i++){
                            vl = document.getElementById("in_"+i).value;
                            tt = tt + parseInt(vl, 0);
                        }
                        return tt;
                        //alert(tt);
                    }
                    function pickvalue(){
                        var paid = document.getElementById("paid").value;
                        var useme = document.getElementById("useme").value;
                        var heredue = document.getElementById("heredue");
                        document.getElementById("herepaid").value=paid;
                        var p = parseFloat(paid);
                        var u = parseFloat(useme);
                        var tt = u-p;
                        document.getElementById("heredue").value = tt;
                        // heredue.v
                    }
            
                    function printSelection(node){
                        
                        var content=node.innerHTML
                        var pwin=window.open('','print_content','width=800,height=1000');

                        pwin.document.open();
                        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                        pwin.document.close();
 
                        setTimeout(function(){pwin.close();},1000);

                    }
            
                    function printSelection1(node){
                       
                        var content=node.innerHTML
                        var pwin=window.open('','print_content','width=400,height=1000');

                        pwin.document.open();
                        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                        pwin.document.close();
 
                        setTimeout(function(){pwin.close();},1000);

                    }
                    $("#dialog").dialog({
                        autoOpen : false,
                        width : 1000,
                        modal :true

                    });
    
                    $("#patientidlink").click(function(){
      
                        $("#dialog").dialog('open');
    
                    })   
        </script>

        <script type="text/javascript">
            $("#<%= p.getPatientid()%>_dialog").dialog({
                autoOpen : true,
                width : "80%",
                modal :true,
                position: 'top'

            });
    
            $("#<%= p.getPatientid()%>_patientidlink").click(function(){
      
                $("#<%=p.getPatientid()%>_dialog").dialog('open');
    
            })    
   
            $("#<%= p.getPatientid()%>_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true,
                position: 'top'

            });
            
            $("#<%=p.getPatientid()%>_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true,
                position: 'top'
            });
    
            $("#<%=p.getPatientid()%>_adddrug_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true
            });
  
            $("#<%=p.getPatientid()%>_link").click(function(){
                $("#<%=p.getPatientid()%>_dialog").dialog('open');   
            })
            $("#discount_links<%=p.getPatientid()%>").dialog({
                autoOpen : false,
                width : 500,
                modal :true
            });
            /* $("#discount<%=p.getPatientid()%>").click(function(){
        $("#discount_link<%=p.getPatientid()%>").dialog('open');
        return false;
    
    })*/
            $("#password_link<%=p.getPatientid()%>").dialog({
                autoOpen : false,
                width : 400,
                modal :true
            });
            $("#discount<%=p.getPatientid()%>").click(function(){
                $("#password_link<%=p.getPatientid()%>").dialog('open');
                $(".discount_row<%=p.getPatientid()%>").show()
         
                return false; 
            }) 
            $("#<%=p.getPatientid()%>_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true
            }); 
            $("#<%=p.getPatientid()%>_adddrug_link").click(function(){
                //alert("");
                $("#<%=p.getPatientid()%>_adddrug_dialog").dialog('open');   
            }) 
   
            
            
            $(function(){
                var amountdue = parseFloat($(".amountdueinput<%=p.getPatientid()%>").attr("value")).toFixed(2);
        
                $(".amountduetext<%=p.getPatientid()%>").html(amountdue);
                var checkedValue = 0;
                $(".balanceinput<%=p.getPatientid()%>").attr("value",parseFloat(0).toFixed(2));
                $(".balancetext<%=p.getPatientid()%>").html("0.00");
        
                $(".amountpaidinput<%=p.getPatientid()%>").attr("value",parseFloat(0).toFixed(2))
                $(".amountpaidtext<%=p.getPatientid()%>").html($(".amountpaidinput<%=p.getPatientid()%>").attr("value"))
        
                $(".amountpaidinput<%=p.getPatientid()%>").live('keyup',function(){
                   
                    var amountdue = $(".amountdueinput<%=p.getPatientid()%>").attr("value");
                    var amountpaid = $(".amountpaidinput<%=p.getPatientid()%>").attr("value");
                    $(".amountpaidtext<%=p.getPatientid()%>").html($(".amountpaidinput<%=p.getPatientid()%>").attr("value"))
                    
                    if(amountpaid == ""){
                        amountpaid = 0;
                    }
                    var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
                    if(amountpaid > 0 &&balance < 0){
                        $(".paymentstatus<%=p.getPatientid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                        $('.balanceinput<%=p.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                        $('.balancetext<%=p.getPatientid()%>').addClass('text-error').removeClass('text-success')
                        $('.balancetextcolour<%=p.getPatientid()%>').addClass('text-error').removeClass('text-success')            
                    } else if (amountpaid == 0){
                        $(".paymentstatus<%=p.getPatientid()%>").html("").removeClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=p.getPatientid()%>').closest('.control-group').removeClass('success').removeClass('error')
                        $('.balancetext<%=p.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=p.getPatientid()%>').removeClass('text-success').removeClass('text-error')             
                    }         
                    else if(amountpaid > 0 && balance >= 0){
                        $(".paymentstatus<%=p.getPatientid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=p.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                        $('.balancetext<%=p.getPatientid()%>').addClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=p.getPatientid()%>').addClass('text-success').removeClass('text-error')
                    }     
                    $(".balanceinput<%=p.getPatientid()%>").attr("value",parseFloat(balance).toFixed(2));
                    $(".balancetext<%=p.getPatientid()%>").html(parseFloat(balance).toFixed(2));
                    $(".amountduetext<%=p.getPatientid()%>").attr("value",$(".amountdue<%=p.getPatientid()%>").attr("value"));         
                });
      
                var amounttoplimit = amountdue;
                var amountbottomlimit = 0;
        
                $(".checkValue<%=p.getPatientid()%>").change(function(){
                    var amountpaid = parseFloat($(".amountpaidinput<%=p.getPatientid()%>").attr("value"));
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
                            $(".amountdueinput<%=p.getPatientid()%>").attr("value",amountdue);
                            $(".amountduetext<%=p.getPatientid()%>").html(parseFloat(amountdue).toFixed(2));   
                        }             
                                  
                    }else {
                        checkedValue = parseFloat($(this).attr("checkvalue")); 
                        if(amountdue > amountbottomlimit) { 
                            amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                            $(".amountdueinput<%=p.getPatientid()%>").attr("value",amountdue);
                            $(".amountduetext<%=p.getPatientid()%>").html(parseFloat(amountdue).toFixed(2));
                        }            
                       
                        $("#override_action").dialog("open")
                    }
                    if (amountpaid > 0 && amountdue > 0){ 
                        balance = parseFloat(amountdue).toFixed(2) - parseFloat(amountpaid).toFixed(2);
                        $(".balancetext<%=p.getPatientid()%>").html(parseFloat(balance).toFixed(2));
                    }
                    if(amountpaid > 0 && balance < 0){
                        $(".paymentstatus<%=p.getPatientid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                        $('.balanceinput<%=p.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                        $('.balancetext<%=p.getPatientid()%>').addClass('text-error').removeClass('text-success')
                        $('.balancetextcolour<%=p.getPatientid()%>').addClass('text-error').removeClass('text-success')
                    } else if (amountpaid == 0.00){
                        $(".paymentstatus").html("").removeClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=p.getPatientid()%>').closest('.control-group').removeClass('success').removeClass('error')
                        $('.balancetext<%=p.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=p.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                    }
                    else if(amountpaid > 0 && balance >= 0){
                        $(".paymentstatus").html("Full Payment").addClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=p.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                        $('.balancetext<%=p.getPatientid()%>').addClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=p.getPatientid()%>').addClass('text-success').removeClass('text-error')
                    }
                });
                
            })
    
            var amountduebeforediscount<%=p.getPatientid()%> = $("#amountdueinput<%=p.getPatientid()%>").attr("value");
   
            $("#newamount<%=p.getPatientid()%>").attr("value",amountduebeforediscount<%=p.getPatientid()%>);
            var amountdueafterdiscount<%=p.getPatientid()%>;
            var discountpercentage;
            var discountamount;
    
            $("#actualdiscount<%=p.getPatientid()%>").live('keyup',function(){
                if( $(this).attr("value") >= 0){ 
                    discountamount = $("#actualdiscount<%=p.getPatientid()%>").attr("value");
                    discountpercentage = (parseFloat(discountamount)/parseFloat(amountduebeforediscount<%=p.getPatientid()%>))*100
                    amountdueafterdiscount<%=p.getPatientid()%> = parseFloat(amountduebeforediscount<%=p.getPatientid()%>).toFixed(2) - parseFloat(discountamount).toFixed(2);
                    $("#percentagediscount<%=p.getPatientid()%>").attr("value",parseFloat(discountpercentage).toFixed(2));
                    $("#newamount<%=p.getPatientid()%>").attr("value",parseFloat(amountdueafterdiscount<%=p.getPatientid()%>).toFixed(2));       
                    $(".discount_row_percent<%=p.getPatientid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)") 
                    $(".discount_row_amount<%=p.getPatientid()%>").html(parseFloat(discountamount).toFixed(2))
                    $(".bill_after_discount<%=p.getPatientid()%>").html(parseFloat(amountdueafterdiscount<%=p.getPatientid()%>).toFixed(2));
                    $(".discount_row_amount_percent<%=p.getPatientid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
                }else {
                    alert("Please Enter a Positive Decimal Value, Only")
                }
        
            });
    
            $("#percentagediscount<%=p.getPatientid()%>").live('keyup',function(){
                if( $(this).attr("value") >= 0){ 
                    discountpercentage = $("#percentagediscount<%=p.getPatientid()%>").attr("value");
                
                    var discountamount = (parseFloat(discountpercentage)*parseFloat(amountduebeforediscount<%=p.getPatientid()%>))/100
                    var amountdueafterdiscount<%=p.getPatientid()%> = amountduebeforediscount<%=p.getPatientid()%> - discountamount;
        
                    $("#actualdiscount<%=p.getPatientid()%>").attr("value",discountamount);
                    $("#newamount<%=p.getPatientid()%>").attr("value",amountdueafterdiscount<%=p.getPatientid()%>);         
       
                    $(".discount_row_percent<%=p.getPatientid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)"); 
                    $(".discount_row_amount<%=p.getPatientid()%>").html(parseFloat(discountamount).toFixed(2));
                    $(".bill_after_discount<%=p.getPatientid()%>").html(parseFloat(amountdueafterdiscount<%=p.getPatientid()%>).toFixed(2));
                    $(".discount_row_amount_percent<%=p.getPatientid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
                }else {
                    alert("Please Enter a Positive Decimal Value, Only")
                }
        
            });
    
    
            $("#verify<%=p.getPatientid()%>").click(function(){
        
                var username = $("#username<%=p.getPatientid()%>").attr("value");
                var password = $("#password<%=p.getPatientid()%>").attr("value");
                $.post('patientcount.jsp', {action : "patientdiscount", username : username, password : password}, function(data) {
                    //alert(data);
                    var bool = data;
                    if(bool==0){
                        alert("Permission Denied Please Contact System Administrator!")
                        $(".print_discount_row<%=p.getPatientid()%>").css("display","none")
                        $(".discount_row<%=p.getPatientid()%>").css("display","none")
                    }
                    if(bool==1){
                        alert("Permission Granted!")
                        $("#password_link<%=p.getPatientid()%>").dialog('close')
                        $("#discount_links<%=p.getPatientid()%>").dialog('open');
                        return false;
                    }
                });
            });
    
    
            $("#<%=p.getPatientid()%>_discount").click(function(){
                $(".print_discount_row<%=p.getPatientid()%>").css("display","block")
                $(".discount_row<%=p.getPatientid()%>").css("display","block")
                var percentage = $("#percentagediscount<%=p.getPatientid()%>").attr("value");
                var actual = $("#actualdiscount<%=p.getPatientid()%>").attr("value");
                var newcharge = $("#newamount<%=p.getPatientid()%>").attr("value");
                var status = $("#statusdis<%=p.getPatientid()%>").attr("value");
                var staff = $("#staffiddis<%=p.getPatientid()%>").attr("value");
                var reason = $("#reasondis<%=p.getPatientid()%>").attr("value");
                var visit = $("#visitiddis<%=p.getPatientid()%>").attr("value");
                var patid = $("#patientdis<%=p.getPatientid()%>").attr("value");
                $(".amountdueinput<%=p.getPatientid()%>").attr("value",newcharge);
                $(".print_discount_row<%=p.getPatientid()%>").show()
                $("#discount_links<%=p.getPatientid()%>").dialog('close')
                //alert(staff);
                $.post('patientcount.jsp', {action : "labdiscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit,patid : patid}, function(data) {
                    // alert(data);      
                });
                //  return false;
            });
            
            
            $("#<%=p.getPatientid()%>_discount_cancel").click(function(){ 
                $(".print_discount_row<%=p.getPatientid()%>").css("display","none")
                $(".discount_row<%=p.getPatientid()%>").css("display","none")
                $("#discount_links<%=p.getPatientid()%>").dialog('close')
                $("#amountdueinput<%=p.getPatientid()%>").attr("value")
                $(".discount_row_percent<%=p.getPatientid()%>").css("display","none") 
                $(".discount_row_amount<%=p.getPatientid()%>").css("display","none")
                $(".bill_after_discount<%=p.getPatientid()%>").css("display","none")
                $(".discount_row_amount_percent<%=p.getPatientid()%>").css("display","none")
                
                alert("Discount Cancelled Successfully")
            
                
            });
            
            
            
        </script>


    </body>
</html>


