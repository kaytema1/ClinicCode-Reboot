<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            HMSHelper mgr = new HMSHelper();
            //     ExtendedHMSHelper exmgr = new ExtendedHMSHelper();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            DecimalFormat df = new DecimalFormat();
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy hh:mm a");

            df.setMinimumFractionDigits(2);
            LabDiscount discount = null;
            Date date = new Date();
            //     List patients = mgr.listLabPatients();
            //     System.out.print("patients.size : " + patients.size());

            // List to keep track of patients who made orders for specified date ( range )
            //List<LabPatient> orderPatients = new ArrayList<LabPatient>();
            //String patientid = request.getParameter("patientid")== null ? "" : request.getParameter("patientid");
            try {
            } catch (Exception e) {
                session.setAttribute("lasterror", "patient does not exist please try again");
                response.sendRedirect("index.jsp");
            }
            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }


            List orders = null;


            boolean correctDateFound = false;
            boolean singleDateValue = true;
            SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateUtilDate = new java.util.Date();
            java.sql.Date dateSqlDate = null;


            SimpleDateFormat rangeformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date rangeUtilDate = new java.util.Date();
            java.sql.Date rangeSqlDate = null;

            String displayedDate = "";
            String dateValue = "";
            String dateRange = "";
            String splittedDateDuration[] = new String[2];
            String[] splittedDate = new String[3];
            String[] splittedDateRange = new String[3];

            System.out.println("telling");
            dateRange = request.getParameter("daterange");
            System.out.println("dateRange : " + dateRange);

            if (request.getParameter("daterange") != null) {
                dateValue = request.getParameter("daterange");
                displayedDate = dateValue;

                if (!dateValue.isEmpty()) {
                    correctDateFound = true;
                    if (dateValue.contains("-")) {
                        singleDateValue = false;

                        splittedDateDuration = dateValue.split("-");
                        dateValue = splittedDateDuration[0];
                        dateRange = splittedDateDuration[1];

                        dateRange = dateRange.replace("/", "-");
                        splittedDateRange = dateRange.split("-");
                        dateRange = splittedDateRange[2].trim() + "-" + splittedDateRange[0].trim() + "-" + splittedDateRange[1].trim();

                        rangeUtilDate = rangeformatter.parse(dateRange);
                        rangeSqlDate = new java.sql.Date(rangeUtilDate.getTime());
                    } else {
                        singleDateValue = true;
                    }
                    dateValue = dateValue.replace("/", "-");
                    splittedDate = dateValue.split("-");
                    dateValue = splittedDate[2].trim() + "-" + splittedDate[0].trim() + "-" + splittedDate[1].trim();
                    dateUtilDate = dateformatter.parse(dateValue);
                    dateSqlDate = new java.sql.Date(dateUtilDate.getTime());
                }
            }

            if (correctDateFound) {
                if (singleDateValue) {
                    System.out.println("very single");
                    System.out.println(" dateValue : " + dateValue);
                    orders = mgr.listLabordersForDate(dateSqlDate);
                } else {
                    System.out.println("not very single");
                    orders = mgr.listLabordersForDuration(dateSqlDate, rangeSqlDate);
                }
            } else {
                orders = mgr.listLaborders();
            }

            String patientId = request.getParameter("patientId");
            System.out.println("incoming patientId : " + patientId);
            String transactionId = request.getParameter("transactionId");
            System.out.println("incoming transactionId : " + transactionId);
            orders = mgr.getPatientTransactionPayments(transactionId);

            System.out.print("dateValue : " + dateValue);
            System.out.print("orders.size : " + orders.size());


            // get all payment objects ( all payments ) made on the transactionid

            List<PaymentObject> allPaymentTransactions = mgr.getPatientTransactionPayments(transactionId);
            System.out.println("allPaymentTransactions.size : " + allPaymentTransactions.size());
            String outOfPocketSponsorId = "";

            boolean secSponsorPaidPart = false, outOfPocketSponsPaidPart = false;
            boolean primarySponsorPaidPart = false, moreThanOneSponsorPaid = false, onlyOneSponsorPaid = false;

            if (!allPaymentTransactions.isEmpty()) {
                for (PaymentObject po : allPaymentTransactions) {
                    outOfPocketSponsorId = po.getOutOfPocketId();

                    if (po.getSecSponsorId() != null && outOfPocketSponsorId != po.getSecSponsorId()) {
                        if (po.getSecSponsorAmount() != 0) {
                            secSponsorPaidPart = true;
                        }
                    }

                    if (outOfPocketSponsorId != null) {
                        if (po.getOutOfPocketAmount() != 0) {
                            outOfPocketSponsPaidPart = true;
                        }
                    }

                    if (po.getPrimarySponsorId() != null) {
                        if (po.getPrimarySponsorAmount() != 0) {
                            primarySponsorPaidPart = true;
                        }
                    }
                }

                if (outOfPocketSponsPaidPart) {
                    if (secSponsorPaidPart || primarySponsorPaidPart) {
                        moreThanOneSponsorPaid = true;
                    } else {
                        onlyOneSponsorPaid = true;
                    }
                } else {
                    if (primarySponsorPaidPart) {
                        if (secSponsorPaidPart) {
                            moreThanOneSponsorPaid = true;
                        } else {
                            onlyOneSponsorPaid = true;
                        }
                    } else {
                        if (secSponsorPaidPart) {
                            onlyOneSponsorPaid = true;
                        }
                    }
                }
                System.out.println("outOfPocketSponsPaidPart : " + outOfPocketSponsPaidPart);
                System.out.println("secSponsorPaidPart : " + secSponsorPaidPart);
                System.out.println("primarySponsorPaidPart : " + primarySponsorPaidPart);

                System.out.println("onlyOneSponsorPaid : " + onlyOneSponsorPaid);
                System.out.println("moreThanOneSponsorPaid : " + moreThanOneSponsorPaid);
            }

        %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <%@include file="widgets/header.jsp" %> 

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="labreception.jsp">Laboratory Reception</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Laboratory Patient History Report for <%= mgr.getLabPatientByID(patientId).getFname()%>  <%= mgr.getLabPatientByID(patientId).getLname()%>  </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 ">

                        <div style="padding-bottom: 80px; " class="span9 thumbnail well content hide">
                            <form action="labpatienthistory.jsp" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Laboratory Patient History | <%=patientId%> | <%=displayedDate%>  </a>  

                                        <%
                                            if (onlyOneSponsorPaid) {
                                                if (mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("CASH")) {%>
                                        <a class="btn btn-info btn-small" style="color: #FFF;" onclick="printSelection1(document.getElementById('print_receipt<%=patientId%>'));" href="#">Print Receipt </a>

                                        <% } else {%>  
                                        <a class="btn btn-info btn-small" style="color: #FFF;" onclick="printSelection1(document.getElementById('print_receipt2<%=patientId%>'));" href="#">Print Receipt </a>


                                        <% }
                                        } else {%>

                                        <a class="btn btn-info btn-small" style="color: #FFF;" onclick="printSelection1(document.getElementById('print_receipt3<%=patientId%>'));" href="#">Print Receipt </a>

                                        <% }%>
                                    </li>
                                    <li class="pull-right" style="margin-top: 7px; margin-left: 5px;">
                                        <button class="btn btn-inverse">
                                            <i class="icon icon-white icon-search"></i> Display
                                        </button>
                                    </li>
                                    <li class="pull-right">
                                        <input name="daterange" placeholder="Select Date Range" style="margin-top: 8px;" id="rangeA" type="text" class="input-large"  />
                                    </li>
                                </ul>
                            </form>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th> Transaction Type </th>
                                        <th> Date </th>
                                        <th> Time </th>
                                        <th> Received By</th>
                                        <th> Amount Paid</th>

                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        List<String> labOrdersIDs = new ArrayList<String>();
                                        if (orders != null && !orders.isEmpty()) {
                                            PaymentObject transaction;

                                            Stafftable paymentStaff;
                                            double amountPaid = 0, totalPaid = 0;

                                            for (int r = 0; r < orders.size(); r++) {
                                                transaction = (PaymentObject) orders.get(r);
                                                paymentStaff = mgr.getStafftableByid(transaction.getStaffId());
                                                amountPaid = transaction.getTotalAmountPaid();
                                                totalPaid += amountPaid;
                                                if (!labOrdersIDs.contains(transaction.getTransactionId())) {
                                                    labOrdersIDs.add(transaction.getTransactionId());
                                                }
                                    %>
                                    <tr>
                                        <td>
                                            <%=transaction.getTransactionType()%>
                                        </td>

                                        <!--    <td>%=transaction.getPrimarySponsorId()  %></td> -->
                                        <td><%= formatter.format(transaction.getDatePaid())%> </td> 
                                        <td> <%= time.format(transaction.getTimePaid())%></td>

                                        <td><%=paymentStaff.getOthername() + "  " + paymentStaff.getLastname()%></td>


                                        <td><%=df.format(amountPaid)%></td>
                                      <!--  <td><%=totalPaid%></td> -->


                                    </tr>

                                    <% }
                                        }%>




                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td style="font-size: larger;"><b>TOTAL</b>

                                        </td>
                                        <td style="font-size: larger; text-align: right;">
                                            <b>

                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right;">
                                            <b>

                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: center">


                                        </td>

                                    </tr>
                                </tfoot>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>
                    <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt<%= patientId%>"> 

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

                                        <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= transactionId%> </h3>

                                    </div>
                                    <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                        <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT NAME: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <b> <%=mgr.getLabPatientByID(patientId).getFname()%>
                                                        <%=mgr.getLabPatientByID(patientId).getMidname()%>
                                                        <%=mgr.getLabPatientByID(patientId).getLname()%> </b>
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
                                                    <%List list = mgr.patientInvestigationByOrderId(transactionId);
                                                        double total1 = 0.0;
                                                        if (list.size() > 0 && list != null) {
                                                            for (int sz = 0; sz < list.size(); sz++) {
                                                                Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(sz);
                                                                total1 = total1 + patientinvestigation.getPrice();
                                                                if (mgr.getInvestigation(patientinvestigation.getInvestigationid()).getLabTypeId() == 1) {
                                                    %>
                                                    <tr>
                                                        <td style="padding-left: 15px; line-height: 25px; text-transform: capitalize;">
                                                            <span class="receipt_name"> <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%>  </span>
                                                        </td>
                                                        <td style="text-align: right;  margin-right: 0px; padding-right: 50px;">
                                                            <%= df.format(patientinvestigation.getPrice())%> 
                                                        </td>
                                                    </tr>
                                                    <%
                                                                }
                                                            }
                                                        }%>


                                                    <%  if (mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("cooperate")) {%> 
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                            <b>Total Bill Credited </b>
                                                        </td>
                                                        <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=patientId%>">

                                                        </td>
                                                    </tr>
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="padding-top: 10px; padding-left: 15px;">
                                                            Payment Status  
                                                        </td>
                                                        <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=patientId%> ">

                                                            Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()) == null ? mgr.sponsorshipDetails(patientId).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()).getSponsorname()%>

                                                        </td>
                                                    </tr>



                                                    <% } else { %> 
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
                                                        <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=patientId%>">


                                                            <%

                                                                System.out.println("labordersid size :  " + labOrdersIDs.size());

                                                                double totalLabOrderCost = 0;
                                                                double totalLabOrderDue = 0;

                                                                if (!labOrdersIDs.isEmpty()) {
                                                                    for (String st : labOrdersIDs) {
                                                                        totalLabOrderCost += mgr.getLabOrdersByOrderId(st).getAmountpaid();
                                                                        totalLabOrderDue += mgr.getLabOrdersByOrderId(st).getOutstanding();
                                                                    }
                                                                }

                                                            %>
                                                            <%=df.format(totalLabOrderCost)%>
                                                        </td>

                                                    </tr>
                                                <!--    <tr>
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
                                                    </tr>  -->
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style=" padding-left: 15px; line-height: 25px;">
                                                            Balance Due
                                                        </td>
                                                        <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=patientId%>">
                                                            <%=df.format(totalLabOrderDue)%>
                                                        </td>

                                                    </tr>

                                                    <%
                                                        String paymentStatus = "Full Payment";
                                                        if (totalLabOrderDue != 0) {
                                                            paymentStatus = "Part Payment";
                                                        }
                                                    %>
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                            Payment Status  
                                                        </td>
                                                        <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=patientId%>">
                                                            <%=paymentStatus%>
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



                    <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt2<%= patientId%>"> 

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

                                        <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= transactionId%> </h3>

                                    </div>
                                    <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                        <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT NAME: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <b> <%=mgr.getLabPatientByID(patientId).getFname()%>
                                                        <%=mgr.getLabPatientByID(patientId).getMidname()%>
                                                        <%=mgr.getLabPatientByID(patientId).getLname()%> </b>
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
                                                    <%List list1 = mgr.patientInvestigationByOrderId(transactionId);
                                                        double total = 0.0;
                                                        if (list1.size() > 0 && list1 != null) {
                                                            for (int sz = 0; sz < list1.size(); sz++) {
                                                                Patientinvestigation patientinvestigation = (Patientinvestigation) list1.get(sz);
                                                                total = total + patientinvestigation.getPrice();
                                                                if (mgr.getInvestigation(patientinvestigation.getInvestigationid()).getLabTypeId() == 1) {
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

                                                    <%  if (mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("cooperate")) {%> 
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                            <b>Total Bill Credited </b>
                                                        </td>
                                                        <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=patientId%>" >
                                                            <%=df.format(total)%>
                                                        </td>
                                                    </tr>
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="padding-top: 10px; padding-left: 15px;">
                                                            Payment Status  
                                                        </td>
                                                        <td style="padding-top: 10px;   margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%= patientId%> ">

                                                            Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()) == null ? mgr.sponsorshipDetails(patientId).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()).getSponsorname()%>

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
                                                        <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=patientId%>">
                                                            <%=df.format(total1)%>
                                                        </td>

                                                    </tr>
                                                    
                                                    <%  %>
                                                    
                                       <!--             <tr>
                                                        <td class="print_discount_row<%=patientId%> hide " style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">  

                                                            Discount

                                                        </td>
                                                        <td style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=patientId%> hide discount_row_amount_percent<%=patientId%>">

                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="print_discount_row<%=patientId%> hide text-success" style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 15px; line-height: 25px; display:  none;">   
                                                            <b>
                                                                Bill Due to Discount
                                                            </b>
                                                        </td>
                                                        <td  style="line-height: 25px; text-align: right; padding-right: 50px; display: none;" class="print_discount_row<%=patientId%> text-success hide bill_after_discount<%=patientId%>">

                                                        </td>
                                                    </tr>   -->
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style=" padding-left: 15px; line-height: 25px;">
                                                            Balance Due
                                                        </td>
                                                        <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=patientId%>">

                                                        </td>

                                                    </tr>
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                            Payment Status  
                                                        </td>
                                                        <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=patientId%>">

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



                    <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print_receipt3<%= patientId%>"> 

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

                                        <h3 style=" margin-top: 5px;text-align: center; color: #000; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 15px;text-transform: uppercase; "> LABORATORY NO.: <%= transactionId%> </h3>

                                    </div>
                                    <hr class="row" style="border-top: 2px solid  #000; border-bottom: none; margin-top: 0px;" >


                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;" class="row center">

                                        <table style="width: 100%; float: left; margin-left: 16px; font-size:  11px;">


                                            <tr>
                                                <td style="line-height: 18px;">
                                                    PATIENT NAME: 
                                                </td>
                                                <td style="line-height: 18px;">
                                                    <b> <%=mgr.getLabPatientByID(patientId).getFname()%>
                                                        <%=mgr.getLabPatientByID(patientId).getMidname()%>
                                                        <%=mgr.getLabPatientByID(patientId).getLname()%> </b>
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
                                                <!--   <thead>
                                                       <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                           <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: none;">Description of Test(s) </th>
   
                                                           <th style="width: 80px; text-align: left;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none; text-decoration: none;">
                                                               Price GH &#162;
                                                           </th>
   
                                                       </tr>
                                                   </thead>  -->
                                                <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <%List list2 = mgr.patientInvestigationByOrderId(transactionId);
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
                                                                total2 = total2 + patientinvestigation.getPrice();
                                                                if (patientinvestigation.getPrice() > 0) {
                                                    %>

                                                    <tr>
                                                        <td colspan="2"  style="padding-left: 15px; padding-top: 10px; line-height: 15px; text-transform: capitalize; ">
                                                            <span class="receipt_name"> <b> <%=mgr.getInvestigation(patientinvestigation.getInvestigationid()).getName().toLowerCase()%> </b> </span>
                                                        </td>

                                                    </tr>
                                                    <%
                                                        List<PaymentObject> paymentObjectList = mgr.getPaymentObjectByTransactionIdTransactionTypeItemId(transactionId, "Lab Payment", patientInvestigationId);
                                                        System.out.println("returned paymentObject size : " + paymentObjectList.size());

                                                        if (paymentObjectList != null && !paymentObjectList.isEmpty()) {
                                                            PaymentObject samePaymentObject = paymentObjectList.get(0);
                                                            for (PaymentObject po : paymentObjectList) {
                                                                primSponsorAmountIsMoreThanZero = false;
                                                                secSponsorAmountIsMoreThanZero = false;
                                                                outOfPaymentAmountIsMoreThanZero = false;
                                                                if (po.getPrimarySponsorId() != null) {
                                                                    if (po.getPrimarySponsorAmount() != 0) {
                                                                        primSponsorAmount += po.getPrimarySponsorAmount();
                                                                        primSponsorAmountIsMoreThanZero = true;
                                                                    }
                                                                }
                                                                if (po.getSecSponsorId() != null) {
                                                                    if (po.getSecSponsorAmount() != 0) {
                                                                        secSponsorAmount += po.getSecSponsorAmount();
                                                                        secSponsorAmountIsMoreThanZero = true;
                                                                    }
                                                                }
                                                                if (po.getOutOfPocketId() != null) {
                                                                    if (po.getOutOfPocketAmount() != 0) {
                                                                        outOfPocketAmount += po.getOutOfPocketAmount();
                                                                        outOfPaymentAmountIsMoreThanZero = true;
                                                                    }
                                                                }
                                                            }
                                                    %>

                                                    <%
                                                        if (primSponsorAmount != 0) {
                                                    %>
                                                    <tr>
                                                        <td style="padding-left: 15px; line-height: 15px; width: 70%" > <%=mgr.getSponsor(samePaymentObject.getPrimarySponsorId()).getSponsorname()%></td>  
                                                        <td style="text-align: right; padding-right: 50px;"> <%= df.format(primSponsorAmount)%> </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>

                                                    <%
                                                        if (secSponsorAmount != 0) {
                                                    %>
                                                    <tr>
                                                        <td style="padding-left: 15px; line-height: 15px; width: 70%" > <%=mgr.getSponsor(samePaymentObject.getSecSponsorId()).getSponsorname()%></td>  
                                                        <td style="text-align: right; padding-right: 50px;" > <%= df.format(secSponsorAmount)%> </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (outOfPocketAmount != 0) {
                                                    %>
                                                    <tr>
                                                        <td style="padding-left: 15px; line-height: 15px; width: 70%" > <%=mgr.getSponsor(samePaymentObject.getOutOfPocketId()).getSponsorname()%></td>  
                                                        <td style="text-align: right; padding-right: 50px;"> <%= df.format(outOfPocketAmount)%> </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>



                                                    <%

                                                                    }
                                                                }
                                                            }
                                                        }%>


                                                    <%  if (mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("cooperate")) {%> 
                                                    <tr style=" padding-top: 10px; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="border-top: solid 1px black; border-bottom: solid 1px black; padding-left: 15px; ">
                                                            <b>Total Bill </b>
                                                        </td>
                                                        <td style="border-top: solid 1px black; border-bottom: solid 1px black; font-weight: bold; line-height: 25px; text-align: right; padding-right: 50px;" class="amountduetext<%=patientId%>">
                                                            <%= df.format(total2)%>
                                                        </td>
                                                    </tr>
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="padding-top: 10px; padding-left: 15px;">
                                                            Payment Status  
                                                        </td>
                                                        <td style="padding-top: 10px; text-align: right;  margin-right: 0px; line-height: 15px; text-align: right; padding-right: 50px;" class="paymentstatus<%=patientId%> ">
                                                            Full Payment
                                                           <!-- Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()) == null ? mgr.sponsorshipDetails(patientId).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()).getSponsorname()%>  -->
                                                         
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
                                                        <td style="text-align: right;  margin-right: 0px; line-height: 25px; text-align: right; padding-right: 50px;" class="amountpaidtext<%=patientId%>">


                                                            <%

                                                                System.out.println("labordersid size :  " + labOrdersIDs.size());

                                                                double totalLabOrderCost = 0;
                                                                double totalLabOrderDue = 0;

                                                                if (!labOrdersIDs.isEmpty()) {
                                                                    for (String st : labOrdersIDs) {
                                                                        totalLabOrderCost += mgr.getLabOrdersByOrderId(st).getAmountpaid();
                                                                        totalLabOrderDue += mgr.getLabOrdersByOrderId(st).getOutstanding();
                                                                    }
                                                                }

                                                            %>
                                                            <%=df.format(totalLabOrderCost)%>
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
                                                        <td style="line-height: 25px; text-align: right; padding-right: 50px;" class="balancetext<%=patientId%>">
                                                            <%=df.format(totalLabOrderDue)%>
                                                        </td>

                                                    </tr>

                                                    <%
                                                        String paymentStatus = "Full Payment";
                                                        if (totalLabOrderDue != 0) {
                                                            paymentStatus = "Part Payment";
                                                        }
                                                    %>
                                                    <tr style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <td style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                            Payment Status  
                                                        </td>
                                                        <td style="padding-top: 10px; text-align: right;  margin-right: 0px; padding-right: 50px;" class="paymentstatus<%=patientId%>">
                                                            <%=paymentStatus%>
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
                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



        <%@page import="entities.Vitalcheck"%>
        <%@page import="java.util.List"%>
        <%@page import="entities.ExtendedHMSHelper"%>
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <!--    <script src="js/jquery-1.9.1.js"></script>  -->

        <script type="text/javascript" charset="utf-8" src="js/jquery2.js"></script>
        <script type="text/javascript" charset="utf-8" src="js/jquery.dataTables2.js"></script>
        <script type="text/javascript" charset="utf-8" src="media/js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="media/js/TableTools.js"></script>

        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>

        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltip.js"></script>

        <script src="js/bootstrap-popover.js"></script>
        <script src="js/application.js"></script>  


        <script type="text/javascript" src="js/jquery-ui-1.10.2.custom.min.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script> 



        <script type="text/javascript">
    
    
     
    
    
            $(function() {
       
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();
             
                //$(".numeric").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
                //$('.decimal').live("keyup",function(){inputControl($(this),'float');});
                //$('.text_input').filter_input({regex:'[a-zA-Z]'});
                $(".menu").fadeIn();
                $(".content").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $(".alert").fadeIn();
                $(".progress1").hide();
                // 
        
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
                    "sScrollY": "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "aButtons": [
                            {
                                "sExtends": "print",
                                "sButtonText": "Print Table"
                            },
                            {
                                "sExtends": "pdf",
                                "sButtonText": "Export as PDF File"
                            },
                            {
                                "sExtends": "xls",
                                "sButtonText": "Export as Excel File"
                            }
                        ]
                    }
                    
            

                });
                
                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
        
                $("#rangeA").daterangepicker();
     
            });
            
            
            
            
            
            function printSelection1(node){

                var content=node.innerHTML
                var pwin=window.open('','print_content','width=400,height=1000');

                pwin.document.open();
                pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                pwin.document.close();
 
                setTimeout(function(){pwin.close();},1000);

            }
            

        </script>


    </body>
</html>
