<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    Laborders visit;
    DecimalFormat df = new DecimalFormat();
    SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy hh:mm a");
    SimpleDateFormat time = new SimpleDateFormat("h:mm a");
    df.setMinimumFractionDigits(2);
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">
            <header  class="jumbotron subhead" id="overview">
                <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Outstanding Laboratory Bills</a><span class="divider"></span>
                        </li>
                    </ul>
                </div>
            </header>
            <%@include file="widgets/loading.jsp" %>
            <section id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="display: none;" class="span9 offset3 thumbnail well content hide">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Laboratory Number </th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Requested On</th>
                                    <th style="text-align: left;">Time</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    //Patient p = (Patient)session.getAttribute("visit.getPatientid()");
                                    //get current date time with Date()
                                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                                    Date date = new Date();
                                    //System.out.println(dateFormat.format(date));
                                    List visits = mgr.listOutstanding();
                                    // List patients = mgr.listPatients();
                                    for (int i = 0; i < visits.size(); i++) {
                                        visit = (Laborders) visits.get(i);

                                %>

                                <tr>
                                    <%if (visit.getPatientid().contains("c") || visit.getPatientid().contains("C")) {%>

                                    <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="visit.getPatientid()" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getFname()%>, <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.sponsorshipDetails(visit.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.sponsorshipDetails(visit.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=visit.getOrderid()%> </a>   </td>
                                    <td><%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getFname()%>  <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : mgr.getPatientByID(visit.getPatientid()).getLname()%> </td>
                                    <td><%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                    <td><%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%> </td>
                                    <td><%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : formatter.format(visit.getOrderdate())%> </td>
                                    <td><%=mgr.getPatientByID(visit.getPatientid()) == null ? "" : time.format(visit.getOrderdate())%> </td>
                                    <%} else {%>

                                    <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="visit.getPatientid()" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(visit.getPatientid()).getDateofbirth())%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.sponsorshipDetails(visit.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.sponsorshipDetails(visit.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <a href="#"> <%=visit.getOrderid()%> </a>  </td>
                                    <td><%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : mgr.getLabPatientByID(visit.getPatientid()).getLname()%> </td>
                                    <td><%=mgr.sponsorshipDetails(visit.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> </td>
                                    <td><%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(visit.getPatientid()).getDateofbirth())%> </td>
                                    <td><%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : formatter.format(visit.getOrderdate())%> </td>
                                    <td><%=mgr.getLabPatientByID(visit.getPatientid()) == null ? "" : time.format(visit.getOrderdate())%> </td>
                                    <%}%>
                                    <td>
                                        <a id="<%=visit.getPatientid()%><%=visit.getOrderid()%>link"  class="visitlink btn btn-info btn-small"> <i class="icon-pencil icon-white"> </i> Make Payments </a>
                                    </td>
                                </tr>
                                <% }

                                %>
                            </tbody>
                        </table>
                    </div> 

                    <div class="clear"></div>
                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



        <%@include file="widgets/javascripts.jsp" %>

        <%   for (int i = 0; i < visits.size(); i++) {
                visit = (Laborders) visits.get(i);%>
        <script type="text/javascript">
            $(document).ready(function(){
                                                      
               
                $('#<%=visit.getPatientid()%><%=visit.getOrderid()%>').dialog({
                    autoOpen : false,
                    width : 1000,
                    modal :true
		
                });
                
                $('#<%=visit.getPatientid()%><%=visit.getOrderid()%>link').click(function(){
                  
                    $('#<%=visit.getPatientid()%><%=visit.getOrderid()%>').dialog('open');
                    return false;
                });
                
                                                        
                
            });
            
        </script>

        <div style="max-height: 600px;  display: none;" class="visit hide" id="<%=visit.getPatientid()%><%=visit.getOrderid()%>"  title="Laboratory Payment for <%= mgr.getLabPatientByID(visit.getPatientid()).getFname()%>

             <% if (mgr.getLabPatientByID(visit.getPatientid()).getMidname() != null) {%>
             <%= mgr.getLabPatientByID(visit.getPatientid()).getMidname()%>
             <% }%>
             <%= mgr.getLabPatientByID(visit.getPatientid()).getLname()%> ">
            <div class=" thumbnail">
                <span class="span5">
                    <dl class="dl-horizontal">
                        <dt style="text-align: left;" >Laboratory Number:</dt>
                        <dd style="text-transform: uppercase;"><b><%=visit.getOrderid()%> </b></dd>
                        <dt style="text-align: left;" >Patient Name:</dt>
                        <dd>
                            <b> <%= mgr.getLabPatientByID(visit.getPatientid()).getFname()%>
                                <%= mgr.getLabPatientByID(visit.getPatientid()).getMidname()%>
                                <%= mgr.getLabPatientByID(visit.getPatientid()).getLname()%> </b>
                        </dd>
                        <dt style="text-align: left;" >Payment Type:</dt>
                        <dd style="text-transform: capitalize;">
                            <% if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("Cash")) {%>
                            Out of Pocket
                            <% } else if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("NHIS")) {%>
                            National Health Insurance
                            <% } else if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("Private")) {%>
                            <%= mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>
                            <% } else {%>
                            Corporate (<%= mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>)
                            <% }%>
                        </dd>
                    </dl>
                </span>
                <div class="clearfix">

                </div>
                <form action="action/labaction.jsp" method="post" class="form-horizontal">
                    <table class="table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="color: white; text-align: left; font-size: 14px;" >
                                    Description of Test(s)
                                </th>

                                <th style="color: white; text-align: right; font-size: 14px;">
                                    <span style="float: right; text-align: right;">
                                        
                                        Price GH&#162;
                                        
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List l = mgr.patientInvestigationByOrderId(visit.getOrderid());
                                double totall = 0;
                                for (int c = 0; c < l.size(); c++) {
                                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(c);
                                    totall = totall + patientinvestigation.getPrice();
                                    if (patientinvestigation.getPrice() > 0) {
                            %>
                            <tr>
                                <td style="text-transform: capitalize;"><%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%></td>
                                <td style="text-align: right;"><%=df.format(patientinvestigation.getPrice())%></td>
                            </tr>
                            <% }
                                }%>
                            <tr>
                                <td style="border-top: solid 1px black; border-bottom: solid 1px black;  line-height: 25px;">
                                    <b> Total Bill </b>
                                </td>
                                <td style="border-top: solid 1px black; border-bottom: solid 1px black;  text-align: right; font-weight: bolder;"   >
                                    <b> <%=df.format(visit.getTotalAmount())%> </b>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: solid 1px black; ">
                                    Amount Deposited

                                </td>
                                <td style="border-top: solid 1px black; text-align: right; color: #2ba949; font-weight: bold;">
                                    <%=df.format(visit.getAmountpaid())%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Amount Outstanding
                                </td>
                                <td style="text-align: right; color: #b94a48; font-weight: bold;">
                                    <%=df.format(visit.getOutstanding())%>
                                    <input  class="amountdueinput<%=visit.getPatientid()%>" type="hidden" value="<%=df.format(visit.getOutstanding())%>"/>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <b>Amount Paid </b>
                                </td>
                                <td>
                                    <input type="hidden" name="" id="extra_<%=visit.getOrderid()%>" value="<%=visit.getOutstanding()%>"/>
                                    <input type="text" style="text-align: right; color: blue;"  class="pull-right input-mini amountpaidinput<%=visit.getPatientid()%>" name="extra_amount" id="extra_amount<%=visit.getOrderid()%>"/>
                                    <input type="hidden" name="orderid" id="<%=visit.getOrderid()%>" value="<%=visit.getOrderid()%>"/>
                                     <input type="hidden" name="patientId" value="<%=visit.getPatientid()%>"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Balance
                                </td>
                                <td  class="balancetext<%=visit.getPatientid()%>" style="text-align: right;  font-weight: bold;">

                                </td>
                            </tr>

                        </tbody>
                    </table> 
                    <div class="clearfix">
                    </div>
                    <button type="button"  class="btn btn-info span3" onclick="printSelection1(document.getElementById('print_receipt<%=visit.getPatientid()%>'));return false">
                        <i class="icon-print icon-white"></i> Print Receipt
                    </button>

                    <button type="submit" name="action" onclick=" printSelection1(document.getElementById('print_receipt<%=visit.getPatientid()%>')); document.form.submit(); return false" value="Outstanding Bills" class="btn btn-danger offset3 span3 pull-right" id="id_<%=visit.getOrderid()%>">
                        <i class="icon-white icon-arrow-right"> </i> Save Transaction
                    </button>
                    <div class="clearfix">
                    </div>
                </form>

                <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt<%=visit.getPatientid()%>"> 

                    <section class="hide" id="dashboard">

                        <table style="width: 100%">
                            <thead style="display: table-header-group; width: 100%">
                                <tr>
                                    <th colspan="4">
                                        <!-- Headings & Paragraph Copy -->
                            <div class="container">

                                <div style="margin-bottom: -15px;" class="row">
                                    <div class="span3" style="float: left;">
                                        <img src="images/danponglab.png" width="100px;" style="margin-top: 30px;" />
                                    </div>

                                    <img src="images/danpongaddress.png" width="80px;" style="float: right; margin-top: 20px;" />        

                                </div>

                                <div style="clear: both;"></div>

                                <hr style="border: solid #000000 0.5px ;"/>




                                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                    <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= visit.getOrderid()%> </h3>

                                </div>
                                <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                    <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


                                        <tr>
                                            <td style="line-height: 18px;">
                                                PATIENT NAME: 
                                            </td>
                                            <td style="line-height: 18px;">
                                                <b> <%=mgr.getLabPatientByID(visit.getPatientid()).getFname()%>
                                                    <%=mgr.getLabPatientByID(visit.getPatientid()).getMidname()%>
                                                    <%=mgr.getLabPatientByID(visit.getPatientid()).getLname()%> </b>
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
                                            <b> OFFICIAL RECEIPT <BR />(OUTSTANDING BILL)</b></h3>
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
                                                       <span style="text-align: right; float: right; padding-right: 50px;">
                                                        Price GH &#162;
                                                       </span>
                                                    </th>

                                                </tr>
                                            </thead>
                                            <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <%List list = mgr.patientInvestigationByOrderId(visit.getOrderid());
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
                                                        <%= df.format(patientinvestigation.getPrice())%> 
                                                    </td>
                                                </tr>
                                                <%
                                                            }
                                                        }
                                                    }%>

                                                <%  if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                        <b>Total Bill Credited </b>
                                                    </td>
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=visit.getPatientid()%>" >
                                                        <%=df.format(total1)%>
                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="padding-top: 10px; padding-left: 15px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="padding-top: 10px;   margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=visit.getPatientid()%> ">

                                                        Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>

                                                    </td>
                                                </tr>



                                                <% } else {%> 

                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                        <b>   Total Bill </b>
                                                    </td>
                                                    <td style="border-top: solid 1px black;border-bottom: solid 1px black; text-align: right; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" >
                                                        <%=df.format(total1)%>
                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Amount Deposited 
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" >
                                                        <%=df.format(visit.getAmountpaid())%>
                                                    </td>

                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Amount Outstanding 
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;">
                                                        <%=df.format(visit.getOutstanding())%>
                                                    </td>

                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Amount Paid 
                                                    </td>
                                                    <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=visit.getPatientid()%>">

                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="print_discount_row<%=visit.getPatientid()%> hide " style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">  

                                                        Discount

                                                    </td>
                                                    <td style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=visit.getPatientid()%> hide discount_row_amount_percent<%=visit.getPatientid()%>">

                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="print_discount_row<%=visit.getPatientid()%> hide text-success" style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">   
                                                        <b>
                                                            Bill Due to Discount
                                                        </b>
                                                    </td>
                                                    <td  style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=visit.getPatientid()%> text-success hide bill_after_discount<%=visit.getPatientid()%>">

                                                    </td>
                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Balance Due
                                                    </td>
                                                    <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=visit.getPatientid()%>">

                                                    </td>

                                                </tr>
                                                <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=visit.getPatientid()%>">

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

                                Served & Electronically Signed by :<%= mgr.getStafftableByid(user.getStaffid()).getOthername() %>   <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                Thank you for doing business with us <br /> Wishing you the best of health.
                            </div>
                            </th>
                            </tr>
                            </tfoot>

                        </table>
                        <!-- tfoot end -->
                    </section>
                </div>

            </div>
        </div>


        <div class="clear"></div>

        <% }%>

    </body>

    <script type="text/javascript">
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
    <%
        visits = mgr.listOutstanding();
        // List patients = mgr.listPatients();
        for (int i = 0; i < visits.size(); i++) {
            visit = (Laborders) visits.get(i);

    %>
    <script type="text/javascript">
        $(document).ready(function(){
           
            $(function(){
                var amountdue = parseFloat($(".amountdueinput<%=visit.getPatientid()%>").attr("value")).toFixed(2);
        
                $(".amountduetext<%=visit.getPatientid()%>").html(amountdue);
                var checkedValue = 0;
                $(".balanceinput<%=visit.getPatientid()%>").attr("value",parseFloat(0).toFixed(2));
                $(".balancetext<%=visit.getPatientid()%>").html("0.00");
        
                $(".amountpaidinput<%=visit.getPatientid()%>").attr("value",parseFloat(0).toFixed(2))
                $(".amountpaidtext<%=visit.getPatientid()%>").html(parseFloat($(".amountpaidinput<%=visit.getPatientid()%>").attr("value")).toFixed(2))
        
                $(".amountpaidinput<%=visit.getPatientid()%>").live('keyup',function(){
                    
                    var amountdue = $(".amountdueinput<%=visit.getPatientid()%>").attr("value");
                    
                    var amountpaid = $(".amountpaidinput<%=visit.getPatientid()%>").attr("value");
                    $(".amountpaidtext<%=visit.getPatientid()%>").html($(".amountpaidinput<%=visit.getPatientid()%>").attr("value"))
                    
                    if(amountpaid == ""){
                        amountpaid = 0;
                    }
                    var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
                    if(amountpaid > 0 &&balance < 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                        $('.balancetext<%=visit.getPatientid()%>').addClass('text-error').removeClass('text-success')
                        $('.balancetextcolour<%=visit.getPatientid()%>').addClass('text-error').removeClass('text-success')            
                    } else if (amountpaid == 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("").removeClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').removeClass('success').removeClass('error')
                        $('.balancetext<%=visit.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=visit.getPatientid()%>').removeClass('text-success').removeClass('text-error')             
                    }         
                    else if(amountpaid > 0 && balance >= 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                        $('.balancetext<%=visit.getPatientid()%>').addClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=visit.getPatientid()%>').addClass('text-success').removeClass('text-error')
                    }     
                    $(".balanceinput<%=visit.getPatientid()%>").attr("value",parseFloat(balance).toFixed(2));
                    $(".balancetext<%=visit.getPatientid()%>").html(parseFloat(balance).toFixed(2));
                    $(".amountduetext<%=visit.getPatientid()%>").attr("value",$(".amountdue<%=visit.getPatientid()%>").attr("value"));         
                });
      
                var amounttoplimit = amountdue;
                var amountbottomlimit = 0;
        
                $(".checkValue<%=visit.getPatientid()%>").change(function(){
                    var amountpaid = parseFloat($(".amountpaidinput<%=visit.getPatientid()%>").attr("value"));
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
                            $(".amountdueinput<%=visit.getPatientid()%>").attr("value",amountdue);
                            $(".amountduetext<%=visit.getPatientid()%>").html(parseFloat(amountdue).toFixed(2));   
                        }             
                                  
                    }else {
                        checkedValue = parseFloat($(this).attr("checkvalue")); 
                        if(amountdue > amountbottomlimit) { 
                            amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                            $(".amountdueinput<%=visit.getPatientid()%>").attr("value",amountdue);
                            $(".amountduetext<%=visit.getPatientid()%>").html(parseFloat(amountdue).toFixed(2));
                        }            
                       
                        $("#override_action").dialog("open")
                    }
                    if (amountpaid > 0 && amountdue > 0){ 
                        balance = parseFloat(amountdue).toFixed(2) - parseFloat(amountpaid).toFixed(2);
                        $(".balancetext<%=visit.getPatientid()%>").html(parseFloat(balance).toFixed(2));
                    }
                    if(amountpaid > 0 && balance < 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                        $('.balancetext<%=visit.getPatientid()%>').addClass('text-error').removeClass('text-success')
                        $('.balancetextcolour<%=visit.getPatientid()%>').addClass('text-error').removeClass('text-success')
                    } else if (amountpaid == 0.00){
                        $(".paymentstatus").html("").removeClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').removeClass('success').removeClass('error')
                        $('.balancetext<%=visit.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=visit.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                    }
                    else if(amountpaid > 0 && balance >= 0){
                        $(".paymentstatus").html("Full Payment").addClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                        $('.balancetext<%=visit.getPatientid()%>').addClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=visit.getPatientid()%>').addClass('text-success').removeClass('text-error')
                    }
                });
                
            })
            
        });
        $("#extra_<%=visit.getOrderid()%>").live(function(){
            var amount = $("#extra_<%=visit.getOrderid()%>").attr("values")
            var extra_amount = $("#extra_amount<%=visit.getOrderid()%>").attr("values")
            alert(amount)
        });
        
        
    </script>



    <% }%>


</html>