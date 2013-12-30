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
        <style type="text/css">
            body {
                overflow-y: scroll;
            }
        </style>

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

            SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy h:mm a");
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();

            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);

            //System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            List listorders = mgr.listLabordersByStatus("Phlem");
            String labid = null;
            String patient = null;
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

                        <li>
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Sample Collection Point</a><span class="divider"></span>
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
                                        <th style="text-align: left"> Laboratory Number </th>
                                        <th style="text-align: left"> Patient Name </th>
                                        <th style="text-align: left"> Payment Type</th>

                                        <th style="text-align: left"> Date of Birth  </th>

                                        <th style="text-align: left"> Requested On </th>
                                        <th style="text-align: left"> Time </th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (listorders != null) {

                                            for (int i = 0; i < listorders.size(); i++) {
                                                Laborders vst = (Laborders) listorders.get(i);
                                                if (vst != null) {

                                                    // labid = vst.getOrderid();
                                                    patient = vst.getPatientid();
                                    %>
                                    <tr>


                                        <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>

                                        <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=vst.getOrderid()%> </a>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 

                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
                                      <!--  <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getMembershipid() : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                        <td><%=formatter.format(vst.getOrderdate())%> </td>

                                        <td style="padding: 0px"><%=time.format(vst.getOrderdate())%> </td>
                                        <%} else {%>

                                        <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getMembershipid() : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getBenefitplan() : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <a href="#"> <%=vst.getOrderid()%> </a>  </td>
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 

                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
                                      <!--   <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getMembershipid() : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                        <td><%=formatter.format(vst.getOrderdate())%> </td>
                                        <td style="padding: 0px"><%=time.format(vst.getOrderdate())%> </td>
                                        <%}%>

                                        <td style="padding: 0px">
                                            <button class="btn btn-info btn-small" id="<%=vst.getOrderid()%>_link">
                                                <i class="icon-white icon-check"></i> View Sample(s)
                                            </button>
                                        </td>

                                    </tr>
                                    <%}
                                            }
                                        }%>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <%
                    String specimen = "";

                    Investigation investigation = null;

                    // String arr[]= null;



                %>


                <% if (listorders != null) {
                        for (int i = 0; i < listorders.size(); i++) {
                            Laborders vst = (Laborders) listorders.get(i);
                            if (vst != null) {
                                 labid = vst.getOrderid();
                                patient = vst.getPatientid();
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

                               


                %>
                <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                <div style="display: none; max-height: 650px; overflow-y: scroll;" class="dialog" id="<%=vst.getOrderid()%>_dialog" title="Laboratory Sample Collection for <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>
                     <% if (mgr.getPatientByID(vst.getPatientid()).getMidname() != null) {%>
                     <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                     <% }%>

                     <%=mgr.getPatientByID(vst.getPatientid()).getLname()%> | <span style='text-transform: capitalize;'> <%=vst.getOrderid()%></span>">

                    <%} else {%>
                    <div style="display: none; max-height: 650px; overflow-y: scroll;" class="dialog" id="<%=vst.getOrderid()%>_dialog" title="Laboratory Sample Collection for <%=mgr.getLabPatientByID(vst.getPatientid()).getFname()%> 
                         <% if (mgr.getLabPatientByID(vst.getPatientid()).getMidname() != null) {%>
                         <%= mgr.getLabPatientByID(vst.getPatientid()).getMidname()%>
                         <% }%>
                         <%=mgr.getLabPatientByID(vst.getPatientid()).getLname()%> | <span style='text-transform: capitalize;'> <%=vst.getOrderid()%></span>">

                        <% }%>
                        <div class=" thumbnail">
                            <span class="span5">
                                <dl class="dl-horizontal">
                                    <dt style="text-align: left;" >Laboratory Number:</dt>
                                    <dd style="text-transform: uppercase;"><b><%=labid%> </b></dd>
                                    <dt style="text-align: left;" >Patient Name:</dt>
                                    <dd>
                                        <b> 
                                            <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                            <%= mgr.getPatientByID(patient).getFname()%>
                                            <%= mgr.getPatientByID(patient).getMidname()%>
                                            <%= mgr.getPatientByID(patient).getLname()%> 
                                            <%} else {%>
                                            <%= mgr.getLabPatientByID(patient).getFname()%>
                                            <%= mgr.getLabPatientByID(patient).getMidname()%>
                                            <%= mgr.getLabPatientByID(patient).getLname()%> 
                                            <% }%>
                                        </b>
                                    </dd>
                                    <dt style="text-align: left;" >Payment Type:</dt>
                                    <dd style="text-transform: capitalize;">
                                        <% String type = mgr.sponsorshipDetails(patient) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getType() : mgr.sponsorshipDetails(patient).getType();
                                            if (type.equalsIgnoreCase("Cash")) {%>
                                        Out of Pocket
                                        <% } else if (type.equalsIgnoreCase("NHIS")) {%>
                                        National Health Insurance
                                        <% } else if (type.equalsIgnoreCase("Private")) {%>
                                        <%= mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>
                                        <% } else {%>
                                        Corporate (<%= mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>)
                                        <% }%>
                                    </dd>
                                    <dt style="text-align: left;" >Specimen</dt>
                                    <dd><b><%=specimen.substring(1)%></b>
                                    
                                    </dd>
                                </dl>
                            </span>
                            <div class="clearfix">

                            </div>
                            <!--div style="display: none;" class="well thumbnail center laboratory"-->

                            <div class="center" id="lab">
                                <form  action="action/labaction.jsp" method="post">
                                    <table id="appendx_3<%=vst.getPatientid()%>" class="table table-bordered">

                                        <thead>
                                            <tr>
                                                <th style="color: white; text-align: left;" >
                                                    Description of Test(s)
                                                </th>

                                                <th style="color: white; text-align: right;">
                                                     Price GH&#162;
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% List l = mgr.patientInvestigationByOrderId(labid);

                                                double totall = 0.0;
                                                double outstandingprice = vst.getOutstanding();
                                                double amountpaid = vst.getAmountpaid();
                                                double price = 0.0;
                                                for (int c = 0; c < l.size(); c++) {
                                                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(c);
                                                    totall = totall + patientinvestigation.getPrice();
                                                    if (patientinvestigation.getPrice() > 0) {

                                                        //amountpaid = patientinvestigation.getAmountpaid();
                                                        price = patientinvestigation.getPrice();
                                                        //outstandingprice = patientinvestigation.getPrice() - patientinvestigation.getAmountpaid();

                                            %>
                                            <tr>
                                                <td style="text-transform: capitalize;"><%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%></td>
                                                <td style="text-align: right;"><%=df.format(patientinvestigation.getPrice())%></td>
                                            </tr>
                                            <% }
                                                }%>


                                            <tr>
                                                <td style="border-top: solid 1px black; border-bottom: solid 1px black;   line-height: 25px;">
                                                    <b>Total Bill </b>
                                                </td>


                                                <td style="border-top: solid 1px black; border-bottom: solid 1px black;  text-align: right; font-weight: bolder;">
                                                    GH&#162;  <%=df.format(totall)%>
                                                    <input class="amountdueinput<%=vst.getPatientid()%>" style="color: blue;"  type="hidden" disabled="disabled" value="<%=df.format(totall)%>" />
                                                    <%if (type.equalsIgnoreCase("NHIS") || type.equalsIgnoreCase("private") || type.equalsIgnoreCase("cooperate")) {%>
                                                    Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>
                                                    <%} else {%>
                                                    <br/>
                                                    <input  class="amountdueinput<%=vst.getPatientid()%>" type="hidden" name="useme" value="<%=totall%>" id="useme"/>

                                                    <%}%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Amount Paid
                                                </td>
                                                <td style="text-align: right;">
                                                    <%= df.format(amountpaid)%>
                                                </td>
                                            </tr> 
                                            <% if (outstandingprice > 0.0) {%>
                                            <tr>
                                                <td>
                                                    Outstanding Bill
                                                </td>
                                                <td style="text-align: right;">
                                                    
                                                    <%= df.format(outstandingprice)%>
                                                </td>
                                            </tr> 
                                            <% }%>    



                                            <tr>
                                                <td style="line-height: 18px; border-top: solid 1px black; ">
                                                    <b> Referred By </b>
                                                </td>
                                                <td style="text-align: right; border-top: solid 1px black;">
                                                    <%=mgr.getLaborders(labid).getPhysician()%> of <%= mgr.getLaborders(labid).getFacility()%>
                                                </td>

                                            </tr>
                                        </tbody>
                                    </table>
                                    <table id="showrow2">

                                    </table>


                                    <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                    <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                    <input type="hidden" name="labid" value="<%=vst.getOrderid()%>"/>


                                    <div style="width: 100%; text-align: center;">



                                    </div>



                                    <br />

                                    <div class="clearfix">

                                    </div>
                                    <table>

                                        <tr>
                                            <td style="width: 50%; text-align: center">


                                                <button type="button"  class="btn btn-info " onclick="printSelection(document.getElementById('print<%=vst.getPatientid()%>'));pickvalue();return false">
                                                    <i class="icon-print icon-white"></i> Print Laboratory Request Form
                                                </button>
                                            </td>
                                            <td style="width: 50%; text-align: center">
                                                <button class="btn btn-danger " type="submit" id="action" name="action" value="phlembotomy">
                                                    <i class="icon-arrow-right icon-white"> </i> Save & Forward to Main Laboratory
                                                </button>

                                            </td>
                                        </tr>
                                    </table>
                                </form>

                                <br />
                                <br />
                            </div>



                            <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=vst.getPatientid()%>"> 

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
                                                            <%=labid%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 18px;">
                                                            PATIENT NAME: 
                                                        </td>
                                                        <td style="line-height: 18px;">
                                                            <b> <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                                                <%= mgr.getPatientByID(patient).getFname()%>
                                                                <%= mgr.getPatientByID(patient).getMidname()%>
                                                                <%= mgr.getPatientByID(patient).getLname()%> 
                                                                <%} else {%>
                                                                <%= mgr.getLabPatientByID(patient).getFname()%>
                                                                <%= mgr.getLabPatientByID(patient).getMidname()%>
                                                                <%= mgr.getLabPatientByID(patient).getLname()%> 
                                                                <% }%> </b>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td style="line-height: 18px;">
                                                            PATIENT SEX: 
                                                        </td>
                                                        <td style="line-height: 18px;">
                                                            <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                                            <%=mgr.getPatientByID(vst.getPatientid()).getGender()%>

                                                            <% } else {%>
                                                            <%=mgr.getLabPatientByID(vst.getPatientid()).getGender()%>

                                                            <% }%>



                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 18px;">
                                                            PATIENT AGE & DOB: 
                                                        </td>
                                                        <td style="line-height: 18px;">
                                                            <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                                            <% String yr = mgr.getPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                                                String tt = yr.split("-")[0];
                                                                //String tyr = new Date()+"";
                                                                SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                                String tyr = dateFormat1.format(new Date()) + "";
                                                                String t = tyr.split("-")[0];
                                                            %>

                                                            <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years / <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%>



                                                            <%} else {%>
                                                            <% String yr = mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                                                String tt = yr.split("-")[0];
                                                                //String tyr = new Date()+"";
                                                                SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                                String tyr = dateFormat1.format(new Date()) + "";
                                                                String t = tyr.split("-")[0];
                                                            %>

                                                            <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years / <%=formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%>




                                                            <% }%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 18px;">
                                                            PATIENT TEL NO.: 
                                                        </td>
                                                        <td style="line-height: 18px;">
                                                            <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                                            <%=mgr.getPatientByID(vst.getPatientid()).getContact()%>
                                                            <%} else {%>
                                                            <%=mgr.getLabPatientByID(vst.getPatientid()).getContact()%>
                                                            <%}%>
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
                                                            <%=specimen.split(",")[1] %>
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
                                                                    <span style="text-align: right; float: right; padding-right: 50px;">
                                                                    Price GH&#162;
                                                                    </span>
                                                                </th>

                                                            </tr>
                                                        </thead>
                                                        <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                            <%List list = mgr.patientInvestigationByOrderId(labid);
                                                                double total = 0.0;
                                                                double primary = 0;
                                                                if (list.size() > 0 && list != null) {
                                                                    for (int sz = 0; sz < list.size(); sz++) {
                                                                        Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                                        total = total + patientinvestigation.getPrice();
                                                                        if (type.equalsIgnoreCase("NHIS") || type.equalsIgnoreCase("private") || type.equalsIgnoreCase("cooperate")) {
                                                                            primary = primary + patientinvestigation.getPrice() + mgr.getSponsor(mgr.sponsorshipDetails(patientinvestigation.getPatientid()).getSponsorid()).getLabmarkup();
                                                                        }
                                                                        if (patientinvestigation.getPrice() > 0) {
                                                            %>

                                                            <tr>
                                                                <td style="padding-left: 15px; line-height: 25px; text-transform: capitalize;">
                                                                    <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%> 
                                                                </td>
                                                                <td style="text-align: right;  margin-right: 0px; padding-right: 50px;" >
                                                                    <span style="text-align: right;  margin-right: 20px;" ><%if (type.equalsIgnoreCase("NHIS") || type.equalsIgnoreCase("private") || type.equalsIgnoreCase("cooperate")) {%>
                                                                        <%= df.format(patientinvestigation.getPrice() + mgr.getSponsor(mgr.sponsorshipDetails(patientinvestigation.getPatientid()).getSponsorid()).getLabmarkup())%> </span>
                                                                        <%} else {%><%= df.format(patientinvestigation.getPrice())%><%}%>
                                                                </td>
                                                            </tr>
                                                            <%
                                                                        }
                                                                    }
                                                                }%>

                                                            <%  if (type.equalsIgnoreCase("nhis") || type.equalsIgnoreCase("private") || type.equalsIgnoreCase("cooperate")) {%> 
                                                            <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                                    <b>Total Bill Credited </b>
                                                                </td>
                                                                <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=vst.getPatientid()%>">
                                                                    <%=df.format(primary)%>
                                                                </td>
                                                            </tr>
                                                            <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                <td style="padding-top: 10px; padding-left: 15px;">
                                                                    Payment Status  
                                                                </td>
                                                                <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=vst.getPatientid()%> ">

                                                                    Credited to <%=mgr.sponsorshipDetails(patient) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()).getSponsorname()%>
                                                                    Credited to <%=mgr.sponsorshipDetails(patient) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()).getSponsorname()%>

                                                                    Credited to <%=mgr.sponsorshipDetails(patient) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(patient).getSponsorid()).getSponsorname()%>

                                                                </td>
                                                            </tr>
                                                            <% } else {%> 

                                                            <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                                <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                    <b>   Total Bill </b>
                                                                    <input type="hidden" value="<%=df.format(total)%>" id="amountdueinput<%=vst.getPatientid()%>" />
                                                                </td>
                                                                <td style="border-top: solid 1px black; border-bottom: solid 1px black;  font-weight: bold; line-height: 25px; " >
                                                                    <span style="text-align: right; padding-right: 70px; float: right; ">
                                                                    <%=df.format(total)%>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                                                <td style="border-top: solid 1px black;  padding-left: 15px; line-height: 25px;">
                                                                    Amount Paid 
                                                                </td>
                                                                <td style="border-top: solid 1px black;  line-height: 25px;" class="amountpaidtext<%=vst.getPatientid()%>">
                                                                   <span style="text-align: right; padding-right: 70px; float: right; ">
                                                                    <%= df.format(amountpaid)%>
                                                                   </span>
                                                                </td>

                                                            </tr>
                                                            <% if (outstandingprice > 0.0) {%>
                                                            <tr>
                                                                <td style="padding-left: 15px; line-height: 25px;">
                                                                    Outstanding Bill
                                                                </td>
                                                                <td style="text-align: right;  margin-right: 0px; line-height: 25px; ">
                                                                    <span style="text-align: right; padding-right: 70px; float: right; ">
                                                                    <%= df.format(outstandingprice)%>
                                                                    </span>
                                                                </td>
                                                            </tr> 
                                                            <% }%>



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

                                            Sample(s) Taken & Electronically Signed by:  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
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



                    <%}
                            }
                        }%> 

            </section>  
            <%@include file="widgets/footer.jsp" %>

        </div>
        <!--end static dialog-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltivst.js"></script>
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
            
        
            $(document).ready(function() {
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "bPaginate" : false,
                    
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sScrollY" : 500

                });
            
                $("#antibiotic_div").dialog({
                    autoOpen : false,
                    width : 500,
                    modal :true
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
                Laborders vst = (Laborders) listorders.get(i);
        %>


        <script type="text/javascript">
   
           
            $("#<%= vst.getOrderid()%>_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
    
            $("#<%= vst.getOrderid()%>_link").click(function(){
      
                $("#<%=vst.getOrderid()%>_dialog").dialog('open');
    
            })
   
            
            
            
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
        </script>



        <% }%>

    </body>
</html>