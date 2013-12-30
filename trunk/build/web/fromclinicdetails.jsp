<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String patient = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
    String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");

    Patient p = mgr.getPatientByID(patient);
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
                            <a href="#">Clinic Lab Request</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">
                    <%@include file="widgets/laboratorywidget.jsp" %>

                    <div style="display: none; " class="span8 thumbnail main-c">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table table-striped">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Laboratory No. </th>
                                    <th style="text-align: left;">Full Name </th>
                                    <th style="text-align: left;">Sponsor</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                   <!-- <th>Location</th>  -->
                                    <th style="text-align: left;">Requested On</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr class="odd gradeX">
                                    <td style="font-size: 20px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= p.getFname()%>, <%= p.getLname()%> <%= p.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>"><b><a class="patientid"> <%=labid%></a></b></td>
                                    <td><%= p.getFname()%>  <%= p.getMidname()%> <%= p.getLname()%>
                                    </td>
                                    <td><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                    <td>  <%= formatter.format(p.getDateofbirth())%> </td>
                                    <td><%=formatter.format(mgr.getLabOrdersByOrderId(labid).getOrderdate()) %> </td>
                                  <!--  <td><%=mgr.getPatientFolder(p.getPatientid()).getStatus() == null ? "" : mgr.getPatientFolder(p.getPatientid()).getStatus()%>  -->
                                    </td>
                                    <td>
                                        <div id="d_<%=p.getPatientid()%>" style="display: block">
                                            <a  id="<%=p.getPatientid()%>_patientidlink"  class="btn btn-info btn-mini" onclick='getType()'> <i class="icon-pencil icon-white"> </i> New Lab Test </a>
                                        </div>
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

        <div style="max-height: 600px; y-overflow: scroll; display: none;" class="hide" id="<%= p.getPatientid()%>_dialog"  title="Lab Processing for <%= p.getFname() %> <%= p.getLname()%>">
            <div class=" thumbnail">

                <!--div style="display: none;" class="well thumbnail center laboratory"-->

                <div class="center" id="lab">

                    <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=p.getPatientid()%>"> 

                        <section class="hide" id="dashboard">

                            <!-- Headings & Paragraph Copy -->
                            <div class="container">

                                <div style="margin-bottom: -15px;" class="row">
                                    <div class="span3" style="float: left;">
                                        <img src="images/danponglab.png" width="180px;" style="margin-top: 30px;" />
                                    </div>

                                    <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" /> 

                                    <div style="clear: both">

                                    </div>

                                    <hr style="border: solid #000000 0.5px ;"/>

                                    <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                        <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= labid%> </h3>

                                    </div>
                                    <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >
                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">

                                        <table style="width: 45%; float: left; margin-left: 6px; font-size:  11px; text-transform: uppercase;">

                                            <tr>
                                                <td style="line-height: 18px; width: 120px;">
                                                    LABORATORY NO.: 
                                                </td>
                                                <td style="line-height: 18px; text-transform: uppercase">
                                                    <b><%=labid%></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT NAME: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                     <%=p.getFname()%>
                                                        <%=p.getMidname()%>
                                                        <%=p.getLname()%> 
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT SEX: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <%=p.getGender()%>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT AGE & DOB: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <% String yr = p.getDateofbirth() + "";
                                                        String tt = yr.split("-")[0];
                                                        //String tyr = new Date()+"";
                                                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                        String tyr = dateFormat1.format(new Date()) + "";
                                                        String t = tyr.split("-")[0];
                                                    %>

                                                    <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years / <%=formatter.format(p.getDateofbirth())%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT TEL NO.: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <%=p.getContact()%>
                                                </td>
                                            </tr>
                                        </table>

                                        <table style="width: 50%; float: left; margin-left: 22px; font-size:  11px; text-transform: uppercase;">
                                            <tr>
                                                <td style="line-height: 18px;">
                                                    REFERRED BY:
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <%Laborders laborders = mgr.getLaborders(labid);
                                                        out.print(mgr.getStafftableByid(laborders.getFromdoc()).getLastname());
                                                    %>
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
                                                    SPECIMEN 
                                                </td>
                                                <td style="line-height: 18px; text-transform: uppercase">

                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="line-height: 18px;">
                                                    COLLECTION DATE: 
                                                </td>
                                                <td style="line-height: 18px;">

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

                                        <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;"">LABORATORY REQUEST</h3>
                                        <br />
                                    </div>
                                </div>

                                <table style="width: 100%" cellspacing="0">
                                    <thead>
                                        <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: underline;">Description </th>

                                            <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: underline;">
                                                Price
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                        <%List list = mgr.patientInvestigationByOrderId(labid);
                                            double total = 0.0;
                                            double primary=0;
                                            if (list.size() > 0 && list != null) {
                                                for (int sz = 0; sz < list.size(); sz++) {
                                                    Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                    total = total + patientinvestigation.getPrice();
                                                    if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {
                                                    primary = primary+patientinvestigation.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(patientinvestigation.getPatientid()).getSponsorid()).getLabmarkup();
                                                    }
                                                    if (patientinvestigation.getPrice() > 0) {

                                        %>
                                        <tr>
                                            <td style=" padding-left: 15px; line-height: 25px; text-transform: capitalize;">
                                                <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%>
                                            </td>
                                            <td>
                                                <span style="text-align: right;  margin-right: 20px;" ><%if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%>
                                                   <%= df.format(patientinvestigation.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(patientinvestigation.getPatientid()).getSponsorid()).getLabmarkup())%> </span>
                                           <%}else{%><%= df.format(patientinvestigation.getPrice())%><%}%>
                                            </td>

                                        </tr>
                                        <%}
                                                }
                                            }%>

                                        <%  if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 

                                        <tr>
                                            <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                <b>   Total Amount Credited </b>
                                            </td>
                                            <td style="border-top: solid 1px black">
                                                <span style="text-align: right; font-weight: bold; margin-right: 20px;" class="amountduetext<%=p.getPatientid()%>"> <%=df.format(primary)%></span>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                Payment Status  
                                            </td>
                                            <td style="padding-top: 10px;">
                                                <span style="text-align: right;  margin-right: 20px;" class="paymentstatus<%=p.getPatientid()%>">
                                                    Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>
                                                </span>
                                            </td>
                                        </tr>
                                        <% } else {%> 

                                        <tr>
                                            <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                <b>   Total Bill </b>
                                            </td>
                                            <td style="border-top: solid 1px black">
                                                <span style="text-align: right; font-weight: bold; margin-right: 20px;" class="amountduetext<%=p.getPatientid()%>">

                                                    <%=df.format(total)%> </span>
                                            </td>
                                            <td style="border-top: solid 1px black">

                                            </td>


                                        </tr>
                                        <tr>
                                            <td style="padding-left: 15px; line-height: 25px;">
                                                Amount Paid 
                                            </td>
                                            <td>
                                                <span style="text-align: right;  margin-right: 20px;" class="amountpaidtext<%=p.getPatientid()%>" id="herepaid"> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="print_discount_row<%=p.getPatientid()%> hide " style="padding-left: 15px; line-height: 25px; display: none;">  

                                                Discount

                                            </td>
                                            <td>
                                                <span style="text-align: right;  margin-right: 20px; display: none;" class="print_discount_row<%=p.getPatientid()%> hide discount_row_amount_percent<%=p.getPatientid()%>">

                                                </span>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="print_discount_row<%=p.getPatientid()%> hide text-success" style="padding-left: 15px; line-height: 25px; display: none;">  
                                                <b>
                                                    Bill Due to Discount
                                                </b>
                                            </td>
                                            <td> 
                                                <span  style="text-align: right;  margin-right: 20px; display: none;" class="print_discount_row<%=p.getPatientid()%> text-success hide bill_after_discount<%=p.getPatientid()%>">

                                                </span>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style=" padding-left: 15px; line-height: 25px;">
                                                Balance Due
                                            </td>
                                            <td>
                                                <span style="text-align: right;  margin-right: 20px;" class="balancetext<%=p.getPatientid()%>" id="heredue"> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                Payment Status  
                                            </td>
                                            <td style="padding-top: 10px;">
                                                <span style="text-align: right;  margin-right: 20px;" class="paymentstatus<%=p.getPatientid()%>"> </span>
                                            </td>
                                        </tr>
                                        <% }%> 
                                    </tbody>
                                </table>

                                <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                    <br />
                                    <br />
                                    <span style="letter-spacing: 5px;" >******************</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Request</span> <span style="letter-spacing: 5px;" >******************</span>
                                    <br />

                                </div> 
                                <div style=" width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                    Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                    Thank you for doing business with us <br /> Wishing you the best of health.
                                </div>     </section>
                    </div>


                    <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt<%=p.getPatientid()%>"> 

                        <section class="hide" id="dashboard">

                            <!-- Headings & Paragraph Copy -->
                            <div class="container">

                                <div style="margin-bottom: -15px;" class="row">
                                    <div class="span3" style="float: left;">
                                        <img src="images/danponglab.png" width="100px;" style="margin-top: 30px;" />
                                    </div>

                                    <img src="images/danpongaddress.png" width="80px;" style="float: right; margin-top: 20px;" /> 

                                    <div style="clear: both">

                                    </div>

                                    <hr style="border: solid #000000 0.5px ;"/>
                                    <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                        <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= labid%> </h3>

                                    </div>
                                    <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >
                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">

                                        <table style="width: 100%; float: left; margin-left: 6px; font-size:  11px; text-transform: uppercase;">
                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT NAME: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <b> <%=p.getFname()%>
                                                        <%=p.getMidname()%>
                                                        <%=p.getLname()%> </b>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="line-height: 18px;">
                                                    ISSUED ON: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <% Date date = new Date();%>

                                                    <%=formatter.format(date)%>

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
                                            <div style="font-size: 12px; font-weight: light;">  PLEASE PRODUCE THIS RECEIPT <br /> FOR COLLECTION OF LAB. REPORT </div>

                                        </div>
                                        <br />
                                    </div>


                                    <table style="width: 100%" cellspacing="0">
                                        <thead>
                                            <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: underline;">Description </th>

                                                <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: underline;">
                                                    Price
                                                </th>

                                            </tr>
                                        </thead>
                                        <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <%list = mgr.patientInvestigationByOrderId(labid);
                                                total = 0.0;
                                                double sec= 0;
                                                if (list.size() > 0 && list != null) {
                                                    for (int sz = 0; sz < list.size(); sz++) {
                                                        Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                        total = total + patientinvestigation.getPrice();
                                                        if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {
                                                    sec = sec+patientinvestigation.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(patientinvestigation.getPatientid()).getSponsorid()).getLabmarkup();
                                                    } if (patientinvestigation.getPrice() > 0) {

                                            %>
                                            <tr>
                                                <td style=" padding-left: 15px; line-height: 25px; text-transform: capitalize;">
                                                    <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%>
                                                </td>
                                                <td>
                                                    <span style="text-align: right; ; margin-right: 20px;"><%= df.format(patientinvestigation.getPrice())%> </span>
                                                </td>

                                            </tr>
                                            <%}
                                                    }
                                                }%>

                                            <%  if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 

                                            <tr>
                                                <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                    <b>   Total Amount Credited </b>
                                                </td>
                                                <td style="border-top: solid 1px black">
                                                    <span style="text-align: right; font-weight: bold; margin-right: 20px;" class="amountduetext<%=p.getPatientid()%>"> <%=df.format(total)%></span>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                    Payment Status  
                                                </td>
                                                <td style="padding-top: 10px;">
                                                    <span style="text-align: right;  margin-right: 20px;" class="paymentstatus<%=p.getPatientid()%>">
                                                        Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>
                                                    </span>
                                                </td>
                                            </tr>
                                            <% } else {%> 

                                            <tr>
                                                <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                    <b>   Total Bill </b>
                                                </td>
                                                <td style="border-top: solid 1px black">
                                                    <span style="text-align: right; font-weight: bold; margin-right: 20px;" class="amountduetext<%=p.getPatientid()%>"><%=df.format(total)%> </span>
                                                </td>
                                                <td style="border-top: solid 1px black">

                                                </td>


                                            </tr>
                                            <tr>
                                                <td style="padding-left: 15px; line-height: 25px;">
                                                    Amount Paid 
                                                </td>
                                                <td>
                                                    <span style="text-align: right;  margin-right: 20px;" class="amountpaidtext<%=p.getPatientid()%>" id="herepaid"> </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="print_discount_row<%=p.getPatientid()%> hide " style="padding-left: 15px; line-height: 25px; display: none;">  

                                                    Discount

                                                </td>
                                                <td> <span style="text-align: right;  margin-right: 20px; display: none;" class="print_discount_row<%=p.getPatientid()%> hide discount_row_amount_percent<%=p.getPatientid()%>">
                                                    </span>

                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="print_discount_row<%=p.getPatientid()%> hide text-success" style="padding-left: 15px; line-height: 25px; display: none;">  
                                                    <b>
                                                        Bill Due to Discount
                                                    </b>
                                                </td>
                                                <td> 
                                                    <span  style="text-align: right;  margin-right: 20px; display: none;" class="print_discount_row<%=p.getPatientid()%> text-success hide bill_after_discount<%=p.getPatientid()%>">
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style=" padding-left: 15px; line-height: 25px;">
                                                    Balance Due
                                                </td>
                                                <td>
                                                    <span style="text-align: right;  margin-right: 20px;" class="balancetext<%=p.getPatientid()%>" id="heredue"> </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                    Payment Status  
                                                </td>
                                                <td style="padding-top: 10px;">
                                                    <span style="text-align: right;  margin-right: 20px;" class="paymentstatus<%=p.getPatientid()%>"> </span>
                                                </td>
                                            </tr>
                                            <% }%> 
                                        </tbody>
                                    </table>

                                    <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                                        <br />
                                        <br />
                                        <span style="letter-spacing: 5px;" >*********</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Receipt</span> <span style="letter-spacing: 5px;" >*********</span>
                                        <br />

                                    </div> 
                                    <div style=" width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                        Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                        Thank you for doing business with us <br /> Wishing you the best of health.
                                    </div>    
                                    </section>
                                </div>
                                <form  action="action/labaction.jsp" method="post">

                                    <table id="appendx_3<%=p.getPatientid()%>" class="table">

                                        <thead>
                                            <tr>
                                                <th style="color: white; text-align: left;" >
                                                    Description
                                                </th>

                                                <th style="color: white; text-align: right;">
                                                    Price
                                                </th>
                                                <th style="color: #fff; width: 100px;"> Co Payment</th>
                                                <th style="color: #fff; width: 100px;"> Out of Pocket</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% List l = mgr.patientInvestigationByOrderId(labid);
                                                double totall = 0;
                                                for (int c = 0; c < l.size(); c++) {
                                                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(c);
                                                    totall = totall + patientinvestigation.getPrice();
                                                    if (patientinvestigation.getPrice() > 0) {
                                            %>
                                            <tr>
                                                <td style="text-transform: capitalize;"><%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%></td>
                                                <td style="text-align: right;"><%=df.format(patientinvestigation.getPrice())%></td>
                                                <%if (patientinvestigation.isCopaid() && patientinvestigation.isIsPrivate()) {%>
                                                <td><%=df.format((patientinvestigation.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getLabmarkup()))%>
                                                    Amount Credited <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor())==null?"":mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponshorshipid()%><br/>
                                                    <input type="text" name="secondarysupport<%=patientinvestigation.getId()%>" value="0.0"/></td>
                                                <td>Amount Paid<input type="text" name="privatesupport<%=patientinvestigation.getId()%>" value="0.0"/></td>
                                                    <%} else if (patientinvestigation.isCopaid() && !patientinvestigation.isIsPrivate()) {%>
                                                <td><%=df.format((patientinvestigation.getPrice()+mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getLabmarkup()))%>
                                                    Amount Credited <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor())==null?"":mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSecondarySponsor()).getSponshorshipid()%><br/><input type="text" name="secondarysupport<%=patientinvestigation.getId()%>" value="0.0"/></td><td>&nbsp;</td>
                                                    <%} else if (!patientinvestigation.isCopaid() && patientinvestigation.isIsPrivate()) {%>
                                                <td>&nbsp;</td> <td>Amount Paid<br/><input type="text" name="privatesupport<%=patientinvestigation.getId()%>" value="0.0"/></td>

                                                <%  } else {%>
                                                <td style="text-align: center;" colspan="2">Fully Sponsored</td>

                                                <%}%> 
                                            </tr>
                                            <% }
                                                }%>
                                            <tr>
                                                <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                    <b>Total Bill </b>
                                                </td>
                                                <td style="border-top: solid 1px black; text-align: right;">
                                                    <%=df.format(totall)%>



                                                    <input type="hidden" id="amountdueinput<%=p.getPatientid()%>" class="amountdueinput<%=p.getPatientid()%>" name="useme" value="<%=totall%>" id="useme"/>


                                                </td>
                                                <td style="border-top: solid 1px black">

                                                </td>
                                                <td style="border-top: solid 1px black">

                                                </td>
                                            </tr>

                                            <%if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                                            <tr>
                                                <td style="padding-left: 15px; line-height: 25px;">
                                                    <b>Amount Paid </b>
                                                </td>
                                                <td style="text-align: right;">
                                                    <input style="text-align: right;" type="text" class="input-mini amountpaidinput<%=p.getPatientid()%>" name="amountpaid" value="" id="paid"/>
                                                </td>
                                                <td></td>
                                                <td>  
                                                    <div class="hide" id="password_link<%=p.getPatientid()%>" title='Confirm Authorization'>
                                                        <form class="form-horizontal">
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

                                                        </form>
                                                    </div>
                                                    <div class="hide"  id="discount_links<%=p.getPatientid()%>" title="Discounting Medical Bill">
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
                                                            <%
                                                             String year = "" + Calendar.getInstance().get(Calendar.YEAR);
                                                                String y = year.substring(2);
                                                                FolderNumbering folderNumbering = (FolderNumbering) mgr.getFolderNumbering(1);
                                                                int toadd = folderNumbering.getDiagnosticStartNumber() + folderNumbering.getDiagnosticCounter() + 1;
                                                                String orderid = y + "" + folderNumbering.getFolderAbbreviationDiagnostics() + "" + toadd;

                                                            %>
                                                            <input type="hidden" name="status" id="statusdis<%=p.getPatientid()%>" value="Medical Bills" />
                                                            <input type="hidden" name="visitid" id="visitiddis<%=p.getPatientid()%>" value="<%=labid%>" />
                                                            <input type="hidden" name="patid" id="patientiddis<%=p.getPatientid()%>" value="<%=p.getPatientid()%>" />
                                                            <input type="hidden" name="staffid" id="staffiddis<%=p.getPatientid()%>" value="" />
                                                            <div class="control-group">
                                                                <label class="control-label" for="inputEmail">
                                                                    Reason</label>
                                                                <div class="controls"> 
                                                                    <textarea name="reasondis" id="reasondis<%=p.getPatientid()%>"></textarea>
                                                                </div>
                                                            </div>
                                                            <div class="form-actions">
                                                                <button class="btn btn-danger btn-small" id="<%=p.getPatientid()%>_discount" onclick="return false;">
                                                                    <i class="icon-white icon-check"></i> Confirm Discount
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div></td>
                                            </tr>
                                            <tr>
                                                <td class="discount_row<%=p.getPatientid()%> hide"  style="padding-left: 15px; line-height: 25px; text-align: left;">  
                                                    <b>
                                                        Discount
                                                    </b>
                                                </td>
                                                <td class="discount_row<%=p.getPatientid()%> hide">
                                                    <span style="text-align: right; float: right;" class="discount_row_amount<%=p.getPatientid()%>">

                                                    </span>
                                                </td>

                                                <td colspan="2" class="discount_row<%=p.getPatientid()%> hide">
                                                    <span style="text-align: right; float: right" class="discount_row_percent<%=p.getPatientid()%>"></span>
                                                </td>

                                            </tr>

                                            <tr>
                                                <td class="discount_row<%=p.getPatientid()%> hide text-success" style="padding-left: 15px; line-height: 25px; text-align: left;">  
                                                    <b>
                                                        Bill Due to Discount
                                                    </b>
                                                </td>
                                                <td class="discount_row<%=p.getPatientid()%> text-success hide">
                                                    <span style="text-align: right; float: right;" class="bill_after_discount<%=p.getPatientid()%>"></span>
                                                </td>

                                                <td colspan="2" class="discount_row<%=p.getPatientid()%> hide">

                                                </td>

                                            </tr>
                                            <tr>
                                                <td style="padding-left: 15px; line-height: 25px; text-align: left;">  <b class="balancetextcolour<%=p.getPatientid()%>">Balance Due </b>  </td>

                                                <td style="text-align: right;"> 
                                                    <div class="control-group">

                                                        <div class="controls">

                                                            <span style="margin: 0px;" class="balancetext<%=p.getPatientid()%>">

                                                            </span>
                                                            <input disabled="disabled"  class="balanceinput<%=p.getPatientid()%>" type="hidden"   value=""/>

                                                        </div>
                                                    </div>
                                                </td>
                                                <td colspan="2" class="paymentstatus<%=p.getPatientid()%>"> </td>
                                            </tr>
                                            <tr>


                                                <% } else {%>
                                            <tr>
                                                <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                    Payment Status  
                                                </td>
                                                <td colspan="3" style="padding-top: 10px; text-align: right;  padding-right: 60px;" class="paymentstatus<%=p.getPatientid()%>">

                                                    Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>

                                                </td>
                                            </tr>


                                            <% }%>
                                        </tbody>
                                    </table>
                                    <table id="showrow2">

                                    </table>
                                    <div style="width: 100%">
                                        <button class="btn btn-danger" type="submit" id="action" name="action" value="actionforward">
                                            <i class="icon-arrow-right icon-white"> </i>Forward to Sample Collection Point
                                        </button>
                                    </div>

                                    <br />
                                    <br />

                                    <div class="clearfix">

                                    </div>

                                    <input type="hidden" name="patient" value="<%=p.getPatientid()%>"/>
                                    <input type="hidden" name="labid" value="<%=labid%>"/>
                                    <input type="hidden" name="refer" value="<%=request.getParameter("refer") == "" ? "" : request.getParameter("refer")%>"/>
                                    <input type="hidden" name="contype" id="contype" value=""/>


                                    <button type="button"  class="btn btn-info span3" onclick="printSelection(document.getElementById('print<%=p.getPatientid()%>'));pickvalue();return false">
                                        <i class="icon-print icon-white"></i> Print Laboratory Request Form
                                    </button>



                                    <button class="btn btn-inverse span3" onclick='showdiscount("discount");return false' id="discount<%=p.getPatientid()%>">
                                        <i class="icon-arrow-down icon-white"></i> Discount
                                    </button>

                                    <button type="button"  class="btn btn-info span3" onclick="printSelection1(document.getElementById('print_receipt<%=p.getPatientid()%>'));return false">
                                        <i class="icon-print icon-white"></i> Print Receipt
                                    </button>

                                    <br />
                                    <br />

                                </form>
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
                
                            alert($(this).val());
                            //$("#refertext").attr("value",$("refer").val());
                        });  
                
                    });
            
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
                        var pwin=window.open('','print_content','width=450,height=1000');

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
                        autoOpen : false,
                        width : 1000,
                        modal :true

                    });
                    $("#<%= p.getPatientid()%>_patientidlink").click(function(){
      
                        $("#<%=p.getPatientid()%>_dialog").dialog('open');
    
                    })    
   
            
                    $("#discount_links<%=p.getPatientid()%>").dialog({
                        autoOpen : false,
                        width : 700,
                        modal :true
                    });
   
                    $("#password_link<%=p.getPatientid()%>").dialog({
                        autoOpen : false,
                        width : 600,
                        modal :true
                    });
                    $("#discount<%=p.getPatientid()%>").click(function(){
                        
                        $("#password_link<%=p.getPatientid()%>").dialog('open');
                        $(".discount_row<%=p.getPatientid()%>").show()
                        return false; 
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
                            //alert(amountdue);
                            //alert(amountpaid);
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
                                if ($(this).attr("id")=="consultation_check<%=p.getPatientid()%>"){
                                    $(".consultation_row<%=p.getPatientid()%>keys").css('text-decoration','none')
                                    $(".consultation_row<%=p.getPatientid()%>value").css('text-decoration','none')                  
                                    $(".consultation_check<%=p.getPatientid()%>keys").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '25px' , 'text-transform': 'capitalize', 'border': 'solid 1px black' , 'float': 'left'});
                                    $(".consultation_check<%=p.getPatientid()%>value").css({'display':'block' ,'text-align' : 'right', 'font-weight' : 'bold' , 'margin-right': '20px', 'border': 'solid 1px black', 'width' : '80px' , 'float': 'right' }); 
                                }else if($(this).attr("id")=="registration_check<%=p.getPatientid()%>"){                
                                    $(".registration_row<%=p.getPatientid()%>keys").css('text-decoration','none');
                                    $(".registration_row<%=p.getPatientid()%>value").css('text-decoration','none');
                    
                                    $(".registration_check<%=p.getPatientid()%>keys").css({'display': 'block' ,'padding-left' : '15px', 'line-height' : '25px' , 'text-transform': 'capitalize', 'border': 'solid 1px black' , 'float': 'left'});
                                    $(".registration_check<%=p.getPatientid()%>value").css({'display':'block' ,'text-align' : 'right', 'font-weight' : 'bold' , 'margin-right': '20px', 'border': 'solid 1px black', 'width' : '80px' , 'float': 'right' }); 
                                }           
                            }else {
                                checkedValue = parseFloat($(this).attr("checkvalue")); 
                                if(amountdue > amountbottomlimit) { 
                                    amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                                    $(".amountdueinput<%=p.getPatientid()%>").attr("value",amountdue);
                                    $(".amountduetext<%=p.getPatientid()%>").html(parseFloat(amountdue).toFixed(2));
                                }            
                                if ($(this).attr("id")=="consultation_check<%=p.getPatientid()%>"){
                                    $(".consultation_row<%=p.getPatientid()%>keys").css('text-decoration','line-through')
                                    $(".consultation_row<%=p.getPatientid()%>value").css('text-decoration','line-through')
                                    $(".consultation_check<%=p.getPatientid()%>keys").css('display','none');
                                    $(".consultation_check<%=p.getPatientid()%>value").css('display','none'); 
                                    //alert("consultation unchecked");
                                }else if($(this).attr("id")=="registration_check<%=p.getPatientid()%>"){
                                    $(".registration_row<%=p.getPatientid()%>keys").css('text-decoration','line-through');
                                    $(".registration_row<%=p.getPatientid()%>value").css('text-decoration','line-through');
                                    $(".registration_check<%=p.getPatientid()%>keys").css('display','none');
                                    $(".registration_check<%=p.getPatientid()%>value").css('display','none');
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
                        });
                        $("#regg<%=p.getPatientid()%>").attr("checked", false);  
                        $("#regg2<%=p.getPatientid()%>").attr("checked", false);
                        $("#con<%=p.getPatientid()%>").attr("checked", false);  
                        $("#con2<%=p.getPatientid()%>").attr("checked", false);      
                        $("#regg<%=p.getPatientid()%>").change(function(){
                            if($("#regg<%=p.getPatientid()%>").is(':checked')){
                                $("#displayregg2<%=p.getPatientid()%>").css("display", "block")
                            }else{
                                $("#displayregg2<%=p.getPatientid()%>").css("display", "none")
                            }
                        });        
                        $("#regg2<%=p.getPatientid()%>").change(function(){
                            if($("#regg2<%=p.getPatientid()%>").is(':checked')){
                                $("#displayregg3<%=p.getPatientid()%>").css("display", "block")
                            }else{
                                $("#displayregg3<%=p.getPatientid()%>").css("display", "none")
                            }
                        });      
                        $("#con<%=p.getPatientid()%>").change(function(){
                            if($("#con<%=p.getPatientid()%>").is(':checked')){
                                $("#displaycon2<%=p.getPatientid()%>").css("display", "block")
                            }else{
                                $("#displaycon2<%=p.getPatientid()%>").css("display", "none")
                            }
                        });      
                        $("#con2<%=p.getPatientid()%>").change(function(){
                            if($("#con2<%=p.getPatientid()%>").is(':checked')){
                                $("#displaycon3<%=p.getPatientid()%>").css("display", "block")
                            }else{
                                $("#displaycon3<%=p.getPatientid()%>").css("display", "none")
                            }
                        });
                    })
   
                    var amountpaid = $("#useme<%=p.getPatientid()%>").attr("value");
                    $("#newamount<%=p.getPatientid()%>").attr("value",amountpaid);
                    $("#actualdis<%=p.getPatientid()%>").live('keyup',function(){
                        //alert("hello")
                        var amountdue = $("#actualdis<%=p.getPatientid()%>").attr("value");
                        var amountpaid = $("#useme<%=p.getPatientid()%>").attr("value");
                        var newamount = (parseFloat(amountdue)/parseFloat(amountpaid))*100
                        var newfig = parseFloat(newamount).toFixed(2);           
                        var total = amountpaid - amountdue;
                        total = total.toFixed(2)
                        $("#percentagedis<%=p.getPatientid()%>").attr("value",newfig);
                        $("#newamount<%=p.getPatientid()%>").attr("value",total);       
                        if(amountpaid == ""){
                            amountpaid = 0;
                        }
                    });
                    $("#percentagedis<%=p.getPatientid()%>").live('keyup',function(){
                        //alert("hello")
                        var amountdue = $("#percentagedis<%=p.getPatientid()%>").attr("value");
                        var amountpaid = $("#useme<%=p.getPatientid()%>").attr("value");         
                        var newamount = (parseFloat(amountpaid)*parseFloat(amountdue))/100
                        var newfig = parseFloat(newamount).toFixed(2);            
                        var total = amountpaid - newfig;
                        total = total.toFixed(2);
                        $("#actualdis<%=p.getPatientid()%>").attr("value",newfig);
                        $("#newamount<%=p.getPatientid()%>").attr("value",total);         
                        if(amountpaid == ""){
                            amountpaid = 0;
                        }
                    });
                    $("#verify<%=p.getPatientid()%>").click(function(){
                        // alert("hello");
                        var username = $("#username<%=p.getPatientid()%>").attr("value");
                        var password = $("#password<%=p.getPatientid()%>").attr("value");
                        $.post('patientcount.jsp', {action : "patientdiscount", username : username, password : password}, function(data) {
                            //alert(data);
                            var bool = data;
                            if(bool=="false"){
                                alert("You are eligible please go ahead")
                            }
                            else{
                                alert("You don't qualify to give discount please talk to a senior staff")
                                $("#discount_links<%=p.getPatientid()%>").dialog('open');
                                return false;
                            }
                        });
                    });
                    $("#_discount<%=p.getPatientid()%>").click(function(){     
                        var percentage = $("#percentagedis<%=p.getPatientid()%>").attr("value");
                        var actual = $("#actualdis<%=p.getPatientid()%>").attr("value");
                        var newcharge = $("#newamount<%=p.getPatientid()%>").attr("value");
                        var status = $("#statusdis<%=p.getPatientid()%>").attr("value");
                        var staff = $("#staffiddis<%=p.getPatientid()%>").attr("value");
                        var reason = $("#reasondis<%=p.getPatientid()%>").attr("value");
                        var visit = $("#visitiddis<%=p.getPatientid()%>").attr("value");
                       // alert(staff);
                        $.post('patientcount.jsp', {action : "labdiscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit}, function(data) {
                            alert(data);      
                        });
                        //  return false;
                    }); 
                    
                    
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
                            $(".discount_row_percent<%=p.getPatientid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%") 
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
       
                            $(".discount_row_percent<%=p.getPatientid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%"); 
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
                            if(bool=="false"){
                                alert("Permission Granted!")
                            }
                            else{
                                alert("Permission Denied!, Contact System Administrator")
                                $("#password_link<%=p.getPatientid()%>").dialog('close')
                                $("#discount_links<%=p.getPatientid()%>").dialog('open');
                                return false;
                            }
                        });
                    });
    
    
                    $("#<%=p.getPatientid()%>_discount").click(function(){     
                        var percentage = $("#percentagediscount<%=p.getPatientid()%>").attr("value");
                        var actual = $("#actualdiscount<%=p.getPatientid()%>").attr("value");
                        var newcharge = $("#newamount<%=p.getPatientid()%>").attr("value");
                        var status = $("#statusdis<%=p.getPatientid()%>").attr("value");
                        var staff = $("#staffiddis<%=p.getPatientid()%>").attr("value");
                        var reason = $("#reasondis<%=p.getPatientid()%>").attr("value");
                        var visit = $("#visitiddis<%=p.getPatientid()%>").attr("value");
                        var patid = $("#patientiddis<%=p.getPatientid()%>").attr("value");
                        $(".amountdueinput<%=p.getPatientid()%>").attr("value",newcharge);
                        $(".print_discount_row<%=p.getPatientid()%>").show()
                        $("#discount_links<%=p.getPatientid()%>").dialog('close')
                        //alert(staff);
                        $.post('patientcount.jsp', {action : "labdiscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit, patid : patid}, function(data) {
                            // alert(data);      
                        });
                        //  return false;
                    }); 
                </script>


                </body>
                </html>
