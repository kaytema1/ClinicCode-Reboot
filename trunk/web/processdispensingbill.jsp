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

            SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy hh:mm a");
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");

            Date date = new Date();



            String orderid = request.getParameter("orderid");
            Pharmorder vst = mgr.getPharmorder(orderid);
            

            if (vst == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Select Prescription Order");
                response.sendRedirect("billing.jsp");
            }

            double price = 0;


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

                    <li class="active">
                        <a href="#">Dispensing Bill | <%= vst.getPatientid()%> </a><span class="divider"></span>
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
                    <table style="width: 100%" class="example display table-striped">
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
                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="vst.getPatientid()" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                <td> <%= formatter.format(vst.getOrderdate())%> </td>

                                <td>
                                    <a id="<%=vst.getOrderid()%>_link" class="btn btn-info btn-small" style="color: #fff;">
                                        Process Payment
                                    </a></td>
                            </tr>

                        </tbody>

                    </table>
                </div>

            </div>


        </section>

        <div  class="hide" id="<%= vst.getOrderid()%>" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> DISPENSARY BILL PAYMENT | <%= vst.getPatientid()%> </span>">

            <div class="lead center ">
                PROCESS DISPENSARY BILL PAYMENT
            </div>
            <span class="pull-left">
                <dl class="dl-horizontal">
                    <dt style="text-align: left;" >Date:</dt>
                    <dd><%= formatter.format(vst.getOrderdate())%> </dd>
                    <dt style="text-align: left;" >Invoice No.</dt>
                    <dd style="text-transform: uppercase;">INV<%=vst.getOrderid()%></dd>
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
                    <dt style="text-align: left;" >Folder Number:</dt>
                    <dd style="text-transform: uppercase;">
                        <b> <%= vst.getPatientid()%> </b>
                    </dd>

                </dl>

            </span>

            <form id="prescriptionbill" action="action/prescriptionaction.jsp" method="post">
                <input type="hidden" name="orderid" value="<%=vst.getOrderid()%>" />
                <input type="hidden" name="patientid" value="<%=vst.getPatientid()%>" />
                <table id="appendx_3<%=vst.getPatientid()%>" class="table table-bordered table-condensed">

                    <thead>
                        <tr>
                            <th rowspan="2" style="color: white; text-align: left; font-size: 14px; width: 50%" >
                                Prescribed Treatment
                            </th>

                            <th rowspan="2" style="color: #fff; text-align: right; font-size: 14px; width: 5%">
                                Qty
                            </th>                                                                
                            <th rowspan="2" style="color: #fff; text-align: right; font-size: 14px; width: 10%"> 
                                Price GH&#162; 
                            </th>
                            <th rowspan="2" style="color: #fff; text-align: right; font-size: 14px;  width: 10%"> 
                                Total GH&#162; 
                            </th>

                            <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  


                            <th <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                colspan="3"
                                <% } else {%>
                                colspan="2"<% }%>

                                style="color: #fff;"> Co-Payment

                            </th>

                            <% }%>


                        </tr>
                        <tr>
                            <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                            <th style="color: #fff;">
                    <u> Primary Sponsor </u> <br />
                    <%=  mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>
                    </th>

                    <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                    <th style="color: #fff;">
                    <u> Secondary Sponsor </u> <br />
                    <%=  mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

                    </th>
                    <th style="color: #fff;">
                    <u> Tertiary Sponsor </u> <br />
                    Out of Pocket
                    </th>

                    <% } else {%>
                    <th style="color: #fff;">
                    <u> Secondary Sponsor </u> <br />
                    Out Pocket
                    </th>

                    <% }%>
                    </tr>
                    <% }%>
                    </thead>
                    <tbody>
                        <%
                            List ptreatmentss = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());

                            double totalPrice = 0.0;
                            for (int r = 0; r < ptreatmentss.size(); r++) {
                                Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);

                                if (ptPatienttreatments.getDispensed().equalsIgnoreCase("Approved")) {

                                    price = 0.0;
                        %>
                        <tr>
                            <td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>">
                                <%=mgr.getTreatment(ptPatienttreatments.getTreatmentid()).getTreatment()%> 
                            </td>
                            <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-align: center;"> 
                                <%=ptPatienttreatments.getQuantity()%> 
                            </td>
                            <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;">
                                <%=df.format(ptPatienttreatments.getPrice())%> 
                            </td>
                            <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getTreatmentid()%>" style="text-align: right;">
                                <% price = ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice();%>
                                <%= df.format(price)%>
                                <%  totalPrice = totalPrice + price;%>
                                <input type="hidden" id="copayment<%=ptPatienttreatments.getTreatmentid()%>source" value="<%= price%>" />
                            </td>
                            <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                            <td style="width: 5%">
                                <label class="switch-container">
                                    <input type="radio" checked="checked" source="copayment<%=ptPatienttreatments.getTreatmentid()%>source" linkup="copaymentprimary<%=ptPatienttreatments.getTreatmentid()%>input" id="copaymentprimary<%=ptPatienttreatments.getTreatmentid()%>"  name="copayment<%=ptPatienttreatments.getTreatmentid()%>" for="copaymentprimary<%=ptPatienttreatments.getTreatmentid()%>"  style="width: 5%" class="switch-input hide copayment"/>
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div> 
                                    <input type="hidden" id="copaymentprimary<%=ptPatienttreatments.getTreatmentid()%>input" class="amountduepiece<%=vst.getOrderid()%> input-mini copaymentinput copaymentprimary" value="<%= df.format(price)%>" />
                                </label>
                            </td>
                            <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                            <td style="width: 5%">
                                <label class="switch-container">
                                    <input type="radio" source="copayment<%=ptPatienttreatments.getTreatmentid()%>source" linkup="copaymentsecondary<%=ptPatienttreatments.getTreatmentid()%>input" id="copaymentsecondary<%=ptPatienttreatments.getTreatmentid()%>" name="copayment<%=ptPatienttreatments.getTreatmentid()%>" value="" for="copaymentsecondary<%=ptPatienttreatments.getTreatmentid()%>"   style="width: 5%" class="switch-input hide copayment"/>
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div>
                                </label>
                                <input type="hidden" id="copaymentsecondary<%=ptPatienttreatments.getTreatmentid()%>input" class="input-mini copaymentinput copaymentsecondary" value="0.00" />

                            </td>
                            <% }%>
                            <td style="width: 5%">
                                <label class="switch-container">
                                    <input type="radio" source="copayment<%=ptPatienttreatments.getTreatmentid()%>source" linkup="copaymentcash<%=ptPatienttreatments.getTreatmentid()%>input" id="copaymentcash<%=ptPatienttreatments.getTreatmentid()%>" name="copayment<%=ptPatienttreatments.getTreatmentid()%>" value="" for="copaymentcash<%=ptPatienttreatments.getTreatmentid()%>"   style="width: 5%" class="switch-input hide copayment"/>
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div>  
                                </label>
                                <input type="hidden" id="copaymentcash<%=ptPatienttreatments.getTreatmentid()%>input" class="input-mini copaymentinput copaymentcash" value="0.00" />

                            </td>
                            <% }%>

                        </tr>


                        <% }
                            }%>




                    </tbody>

                    <tfoot>
                        <tr>
                            <td colspan="3" style="font-size: 15px; font-weight: bolder;">
                                TOTAL BILL
                            </td>
                            <td style="text-align: right;">
                                <%= df.format(totalPrice)%>
                                <input type="hidden"  name="amountdueinput" id="amountdueinput" value="<%= df.format(totalPrice)%>" class="input-mini copaymentinput"  />
                            </td>
                            <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>  
                            <td>

                            </td>
                            <% if (!mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                            <td>

                            </td>
                            <% }%>
                            <td>

                            </td>
                            <% }%>

                        </tr>
                        <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("CASH")) {%>
                        <tr>
                            <td colspan="3" style="font-size: 15px; font-weight: bolder;">
                                AMOUNT PAID
                            </td>
                            <td style="padding: 0px; margin: 0px;">
                                <div style="padding: 0px; margin: 0px;" class="control-group success">
                                    <div style="padding: 0px; margin: 0px;"  class="controls">
                                        <input  name="amountpaidinput" id="amountpaidinput" class="input-mini" type="text" style="text-align: right; float: right;" />
                                    </div>
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="font-size: 15px; font-weight: bolder;">
                                BALANCE
                            </td>
                            <td style="padding: 0px; margin: 0px;">
                                <div style="padding: 0px; margin: 0px;" class="control-group text-success">
                                    <div style="padding: 0px; margin: 0px; font-size: 15px; font-weight: bold; text-align: right;" id="balancetext"  class="controls">

                                    </div>
                                </div>

                            </td>
                        </tr>



                        <% }%>
                    </tfoot>


                </table>
                <div class="clearfix">

                </div>
                <div class="form-actions center">

                    <button type="button" onclick="printSelection1(document.getElementById('print_receipt')); return false" class="btn-info btn pull-left"  style="width: 40%; color: #fff;">
                        <i class="icon-white icon-print"></i>  Print Receipt
                    </button> 

                    <button class="btn-danger btn pull-right" onclick="printSelection1(document.getElementById('print_receipt')); document.form.submit(); return false" style="width: 40%" type="submit" name="action" value="dispensingbillpayment">
                        <i class="icon-white icon-arrow-right"></i>  Make Payment & Forward For Dispensing
                    </button>

                </div>

            </form>

        </div>

        <div class="regular_receipt" style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt"> 

            <section class="hide" id="dashboard">

                <table style="width: 100%">
                    <thead style="display: table-header-group; width: 100%">
                        <tr>
                            <th colspan="4">
                                
                    <div class="container">

                        <div style="margin-bottom: -15px;" class="row">
                            <div class="span3" style="float: left;">
                                <img src="images/danpongclinic.png" width="120px;" style="margin-top: 30px;" />
                            </div>

                            <img src="images/danpongaddress.png" width="140px;" style="float: right; margin-top: 20px;" />        

                        </div>

                        <div style="clear: both;"></div>

                        <hr style="border: solid #000000 0.5px ;"/>




                        <div style="text-align: center;  margin-top: 0px;" class="row center ">

                            <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> DISPENSARY NO.: <%= vst.getOrderid()%> </h3>

                        </div>
                        <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                        <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                            <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


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
                                            <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: none;">Description of Treatment(s) </th>

                                            <th style="width: 80px; text-align: right; padding-right: 50px; border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: none;">
                                                Price GH &#162;
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                        <% List newlist = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
                                            double total1 = 0.0;
                                            if (newlist.size() > 0 && newlist != null) {
                                                for (int sz = 0; sz < newlist.size(); sz++) {
                                                    Patienttreatment patienttreatment = (Patienttreatment) newlist.get(sz);
                                                    total1 = total1 + patienttreatment.getPrice();
                                                    if (patienttreatment.getDispensed().equalsIgnoreCase("Approved") && patienttreatment.getPrice() > 0) {
                                        %>

                                        <tr>
                                            
                                            <td  style="padding-left: 15px; line-height: 25px; text-transform: capitalize; ">
                                                <span class="receipt_name"> <%=mgr.getTreatment(patienttreatment.getTreatmentid()).getTreatment().toLowerCase()%>  </span>
                                            </td>
                                            <td style="text-align: right;  margin-right: 0px; padding-right: 50px;" >
                                                <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%>
                                                <%= df.format(patienttreatment.getPrice())%>
                                                <%} else {%>
                                                <%= df.format(patienttreatment.getPrice())%> 
                                                <%}%>
                                            </td>
                                        </tr>
                                        <%
                                                    }
                                                }
                                            }%>

                                        <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                        <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                <b>Total Bill Credited </b>
                                            </td>
                                            <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=vst.getPatientid()%>" >

                                                <span style="font-weight: bolder; text-align: center; padding-left: 20px;" class="sika_show">


                                                </span>

                                            </td>
                                        </tr>
                                        <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style="padding-top: 10px; padding-left: 15px;">
                                                Payment Status  
                                            </td>
                                            <td style="padding-top: 10px;   margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=vst.getPatientid()%> ">

                                                Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

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
                                            <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=vst.getPatientid()%>">

                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="print_discount_row<%=vst.getPatientid()%> hide " style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">  

                                                Discount

                                            </td>
                                            <td style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=vst.getPatientid()%> hide discount_row_amount_percent<%=vst.getPatientid()%>">

                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="print_discount_row<%=vst.getPatientid()%> hide text-success" style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">   
                                                <b>
                                                    Bill Due to Discount
                                                </b>
                                            </td>
                                            <td  style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=vst.getPatientid()%> text-success hide bill_after_discount<%=vst.getPatientid()%>">

                                            </td>
                                        </tr>
                                        <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style=" padding-left: 15px; line-height: 25px;">
                                                Balance Due
                                            </td>
                                            <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=vst.getPatientid()%>">

                                            </td>

                                        </tr>
                                        <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                Payment Status  
                                            </td>
                                            <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=vst.getPatientid()%>">

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




        <div class="copayment_receipt" style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt3"> 

            <section class="hide" id="dashboard">

                <table style="width: 100%">
                    <thead style="display: table-header-group; width: 100%">
                        <tr>
                            <th colspan="4">
                                <!-- Headings & Paragraph Copy -->
                    <div class="container">

                        <div style="margin-bottom: -15px;" class="row">
                            <div class="span3" style="float: left;">
                                <img src="images/danpongclinic.png.png" width="120px;" style="margin-top: 30px;" />
                            </div>

                            <img src="images/danpongaddress.png" width="140px;" style="float: right; margin-top: 20px;" />        

                        </div>

                        <div style="clear: both;"></div>

                        <hr style="border: solid #000000 0.5px ;"/>




                        <div style="text-align: center;  margin-top: 0px;" class="row center ">

                            <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> DISPENSARY NO.: <%= vst.getOrderid()%> </h3>

                        </div>
                        <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                        <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                            <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


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
                                            <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: none;">Description of Treatment(s) </th>

                                            <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: none;">
                                                Price GH &#162;
                                            </th>

                                        </tr>
                                    </thead>  
                                    <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                        <%List list2 = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
                                            double total2 = 0.0;
                                            int patientTreatmentId = 0;
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
                                                    Patienttreatment patienttreatment = (Patienttreatment) list2.get(sz);

                                                    patientTreatmentId = patienttreatment.getTreatmentid();
                                                    total2 = total2 + price;
                                                    
                                                    if (patienttreatment.getDispensed().equalsIgnoreCase("Approved") && patienttreatment.getPrice() > 0) {
                                        %>

                                        <tr>
                                            <td colspan="2"  style="padding-left: 15px; padding-top: 10px; line-height: 15px; text-transform: capitalize; ">
                                                <span class="receipt_name"> <b> <%=mgr.getTreatment(patienttreatment.getTreatmentid()).getTreatment().toLowerCase()%> </b> </span>
                                            </td>

                                        </tr>



                                        <tr style="width: 100%;">
                                            <td> 

                                                <span id="showorhide1description<%=patienttreatment.getTreatmentid()%>" class="showorhide1<%=patienttreatment.getTreatmentid()%>" style="padding-left: 15px; line-height: 15px; ">
                                                    <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>
                                                </span>
                                            </td>  
                                            <td style="padding-right: 50px;">
                                                <span id="showorhide1price<%=patienttreatment.getTreatmentid()%>" class="showorhide1<%=patienttreatment.getTreatmentid()%>" style="text-align: right; float: right;">

                                                </span>
                                            </td>
                                        </tr>

                                        <tr style="width: 100%">
                                            <td> 
                                                <span id="showorhide2description<%=patienttreatment.getTreatmentid()%>" class="showorhide2<%=patienttreatment.getTreatmentid()%>" style="padding-left: 15px; line-height: 15px; display: none;" >
                                                    <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname()%>
                                                </span>
                                            </td>  
                                            <td style="padding-right: 50px;">
                                                <span id="showorhide2price<%=patienttreatment.getTreatmentid()%>" 
                                                      class="showorhide2<%=patienttreatment.getTreatmentid()%>" style="text-align: right; float: right;">

                                                </span>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td> <span id="showorhide3description<%=patienttreatment.getTreatmentid()%>" class="showorhide3<%=patienttreatment.getTreatmentid()%>" style="padding-left: 15px; line-height: 15px; display: none;"> Out of Pocket </span> </td>  
                                            <td style="padding-right: 50px;"> 
                                                <span id="showorhide3price<%=patienttreatment.getTreatmentid()%>" class="showorhide3<%=patienttreatment.getTreatmentid()%>" style="text-align: right; float: right; ">

                                                </span>
                                            </td>
                                        </tr>




                                        <%


                                                    }
                                                }
                                            }%>


                                        <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                        <tr style=" padding-top: 10px; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                <b>Total Bill </b>
                                            </td>
                                            <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=vst.getPatientid()%> sika_show">


                                                <!--  <%= df.format(total2)%>  -->
                                            </td>
                                        </tr>
                                        <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style="padding-top: 10px; padding-left: 15px;">
                                                Payment Status  
                                            </td>
                                            <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=vst.getPatientid()%> ">
                                                <span class="primary_sponsor_desc_amount">

                                                </span> 
                                                <br />
                                                <span class="secondary_sponsor_desc_amount">

                                                </span> 
                                                <br />
                                                <span class="tetiary_sponsor_desc_amount">

                                                </span>
                                                <!-- Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  -->

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
                                            <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=vst.getPatientid()%>">




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
                                            <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=vst.getPatientid()%>">

                                            </td>

                                        </tr>


                                        <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                Payment Status  
                                            </td>
                                            <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=vst.getPatientid()%>">

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

    </body>
    <%@include file="widgets/javascripts.jsp" %>
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
        
        $('#<%=vst.getOrderid()%>').dialog({
            autoOpen : true,
            width : "95%",
            modal : true,
            position: "top"
       

        });
    
        $('#<%=vst.getOrderid()%>_link').click(function() {
            $('#<%=vst.getOrderid()%>').dialog('open');
            return false;
        });
        
        $(document).ready(function(){
            $("#amountpaidinput").focus();
            
            
            $('#prescriptionbill').validate({
                rules: {
                    
                    amountpaidinput: {
                        minlength: 2,
                        required: true,
                        decimal: true
                    }
            
                },
                highlight: function(label) {
                    $(label).closest('.control-group').addClass('error');
                },
                success: function(label) {
                    label
                    .text('OK!').addClass('valid')
                    .closest('.control-group').addClass('success');
                }
            });
        })
    
    
        $(function(){
            $("#amountpaidinput").live('keyup',function(){
                
                var amountdue = $("#amountdueinput").attr("value");
                var amountpaid = $("#amountpaidinput").attr("value");
                
                $(".amountpaidtext").html($("#amountpaidinput").attr("value"))
                    
                if(amountpaid == ""){
                    amountpaid = 0;
                }
                var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
                if(balance < 0){
                    $('#balancetext').html("0.00");
                    $('.control-group').addClass('error').removeClass('success');
                    $('#balancetext').addClass('text-error').removeClass('text-success');
                   
                } else {
                    $('#balancetext').html(parseFloat(balance).toFixed(2));
                    //$("#amountpaidinput").attr("value",amountdue);
                    $('.control-group').removeClass('error').addClass('success');
                    $('#balancetext').removeClass('text-error').addClass('text-success');
                }
       
            });
            var is_copayment = false;
            
            $(".copayment").change(function(){
                
                is_copayment = true;
                
                var linkup = $(this).attr("linkup");
                var sourceId = $(this).attr("source");
                var sourceValue = $("#"+sourceId).attr("value");
                $(".copaymentinput").attr("value","0.00");
                $("#"+linkup).attr("value",parseFloat(sourceValue).toFixed(2));
                if($(this).is(':checked')){ 
                    is_copayment = true;
                
                
                }
                
                if(is_copayment){
                       
                       
                       
                    $(".copayment_receipt").attr("id","print_receipt")
                    $(".regular_receipt").attr("id","print_receipt3")
            
            
        <%
            ptreatmentss = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
            for (int r = 0; r < ptreatmentss.size(); r++) {
                Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
                if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No")) {

        %>
                                    
                        var input_1 = parseFloat($("#1_copaymentsecondarycashdefault_input_value").attr("value"));
                        var input_2 = parseFloat($("#2_copaymentsecondarycashdefault_input_value").attr("value"));
                        var input_3 = parseFloat($("#copaymentsecondarycashdefault_input_value").attr("value"));
                            
                        if(isNaN(input_1)){
                            input_1 = 0.00;
                        }
                            
                        if(isNaN(input_2)){
                            input_2 = 0.00;
                        }
                        if(isNaN(input_3)){
                            input_3 = 0.00;
                        }                   
                                    
                                    
        <%      }
            }%>
                            
                        } else{
                            $(".regular_receipt").attr("id","print_receipt")
                            $(".copayment_receipt").attr("id","print_receipt3")
                        
                        } 
                        
                    })
        
        
                })
    
    </script>

</html>
