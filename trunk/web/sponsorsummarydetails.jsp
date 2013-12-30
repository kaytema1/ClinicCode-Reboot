<%--
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
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
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E dd MMM. yyyy HH:mm a");
            Date date = new Date();
            //   List listorders = null;
            // get all payments that have been made through payment object
            List<PaymentObject> allPayments = null;


            boolean correctDateFound = false;
            boolean singleDateValue = true;
            SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateUtilDate = new java.util.Date();
            java.sql.Date dateSqlDate = null;


            SimpleDateFormat rangeformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date rangeUtilDate = new java.util.Date();
            java.sql.Date rangeSqlDate = null;


            String dateValue = "";
            String dateRange = "";
            String splittedDateDuration[] = new String[2];
            String[] splittedDate = new String[3];
            String[] splittedDateRange = new String[3];

            //    System.out.println("telling");
            //    dateRange = request.getParameter("daterange");
            //    System.out.println("dateRange : " + dateRange);
            //Stafftable staffToUse = null;
            Sponsorship sponsorToUse = null;
            String staffid = request.getParameter("staffid") == null ? "" : request.getParameter("staffid");
            String incomingDateValue = request.getParameter("datevalue") == null ? "" : request.getParameter("datevalue");
            String sponsorId = request.getParameter("sponsorid") == null ? "" : request.getParameter("sponsorid");

            // use sponsor id to check for valid sponsor

            if (!sponsorId.isEmpty()) {
                sponsorToUse = mgr.getSponsor(sponsorId);

                if (sponsorToUse == null) {
                    response.sendRedirect("insurancesummarybystaff.jsp");
                    return;
                }
            } else {
                response.sendRedirect("insurancesummarybystaff.jsp");
                return;
            }


            // use staffId to check for valid staff

            

            if (incomingDateValue.isEmpty()) {
                response.sendRedirect("insurancesummarybystaff.jsp");
                return;
            }

            String displayedDate = incomingDateValue;
            dateValue = incomingDateValue;

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


            if (correctDateFound) {
                if (singleDateValue) {
                    allPayments = mgr.listLabPaymentsByStaffForDate(staffid, dateSqlDate);
                } else {
                    allPayments = mgr.listLabPaymentsByStaffForDuration(staffid, dateSqlDate, rangeSqlDate);
                }
            } else {
                allPayments = mgr.listLabPaymentsByStaffForDate(staffid, mgr.getCurrentDate());
            }


            System.out.println("allPayments.size : " + allPayments.size());
            System.out.print("dateValue : " + dateValue);

            int count = 0;
            double price = 0.0, amntActualyPaid = 0.0;
            String sponsorid = "";
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);


            // get all sponsors
            //   List<Sponsorship> allSponsors = mgr.listSponsors();




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
                            <a href="#">Sales Analysis Details For <%= sponsorToUse.getSponsorname() %></a><span class="divider"></span>
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
                            <form action="labsponsorshipreports.jsp" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Sales Analysis Details For <%= sponsorToUse.getSponsorname() %> | <%=displayedDate%> </a>
                                    </li>
                                </ul>
                            </form>
                            <table class="example display table">
                                <thead>
                                    <tr>
                                        
                                        <th style="text-align: left;"> Lab Order ID</th>
                                        <th style="text-align: left;"> Patient Name</th>
                                        <th style="text-align: left;"> Amount Paid</th>
                                        <th style="text-align: left;"> Outstanding Bill</th>
                                        <th style="text-align: left;"> Total Amount</th>
                                        
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <% double totalAmount = 0;
                                            double totalOutstanding = 0;
                                            double totalLabAmount = 0;
                                        double primSponsorPayment = 0, secSponsorPayment = 0, outOfPocketPayment = 0, outstanding = 0;
                                        double totalAmountPaid = 0, totalLabPayment = 0;
                                        Set<String> numberOfLabsSet = new HashSet<String>();
                                        HashMap<String, String> hashMap = new HashMap<String, String>();

                                        for (PaymentObject payment : allPayments) {

                                            double pmnt = 0;
                                            totalLabPayment = 0;
                                            price = 0;
                                            String patientName = "", timePaid = "", labOrderId = "", patientId = "";
                                            LabPatient patient;

                                            primSponsorPayment = 0;
                                            secSponsorPayment = 0;
                                            outOfPocketPayment = 0;
                                            outstanding = mgr.getLabOrdersByOrderId(payment.getTransactionId()).getOutstanding();
                                            if (payment.getPrimarySponsorId() != null && !payment.getPrimarySponsorId().isEmpty()) {
                                                if (payment.getPrimarySponsorId().equalsIgnoreCase(sponsorId)) {
                                                    primSponsorPayment = payment.getPrimarySponsorAmount();
                                                    if (primSponsorPayment > 0) {
                                                        totalLabPayment += primSponsorPayment;
                                                        numberOfLabsSet.add(payment.getTransactionId());
                                                    }
                                                }
                                            }
                                            if (payment.getSecSponsorId() != null && !payment.getSecSponsorId().isEmpty()) {
                                                if (payment.getSecSponsorId().equalsIgnoreCase(sponsorId)) {
                                                    secSponsorPayment = payment.getSecSponsorAmount();
                                                    if (secSponsorPayment > 0) {
                                                        totalLabPayment += secSponsorPayment;
                                                        numberOfLabsSet.add(payment.getTransactionId());
                                                    }
                                                }
                                            }
                                            if (payment.getOutOfPocketId() != null && !payment.getOutOfPocketId().isEmpty()) {
                                                if (payment.getOutOfPocketId().equalsIgnoreCase(sponsorId)) {
                                                    outOfPocketPayment = payment.getOutOfPocketAmount();
                                                    if (outOfPocketPayment > 0) {
                                                        totalLabPayment += outOfPocketPayment;
                                                        numberOfLabsSet.add(payment.getTransactionId());
                                                    }
                                                }

                                            }

                                            patientName = "";

                                            try {
                                                patient = mgr.getLabPatientByID(payment.getPatientId());
                                                patientName = patient.getFname() + " " + patient.getLname();
                                                patientId = patient.getPatientid();
                                            } catch (Exception e) {
                                                patientName = "Clinic Patient";
                                                patientId = "PatientID";
                                            }

                                            totalAmountPaid = totalLabPayment + outstanding;
                                            if (totalLabPayment > 0) {

                                                pmnt = totalLabPayment;
                                                labOrderId = payment.getTransactionId();
                                                timePaid = payment.getTimePaid() + "";

                                                if (hashMap.containsKey(labOrderId)) {
                                                    String string = hashMap.get(labOrderId);
                                                    hashMap.remove(labOrderId);
                                                    String[] arr = string.split("_");
                                                    count = Integer.parseInt(arr[0]) + 1;
                                                    price += Double.parseDouble(arr[1]) + pmnt;
                                                    hashMap.put(labOrderId, "" + count + "_" + price + "_" + patientName + "_" + outstanding);

                                                } else {
                                                    price = pmnt;
                                                    hashMap.put(labOrderId, "1_" + price + "_" + patientName
                                                            + "_" + outstanding);
                                                }

                                            }
                                        }

                                    %>

                                    <%
                                        if (!hashMap.isEmpty()) {
                                            totalAmountPaid = 0;
                                            
                                            Collection<?> keys = hashMap.keySet();
                                            for (Object key : keys) {
                                                String string = hashMap.get(key);
                                                String[] stringArray = string.split("_");

                                                System.out.println("stringArray[1] : " + stringArray[1]);
                                                double amntPaid = Double.parseDouble(stringArray[1]);

                                                totalAmountPaid = Double.parseDouble(stringArray[3]) + amntPaid;
                                                totalAmount += (amntPaid + Double.parseDouble(stringArray[3]));
                                                totalOutstanding += Double.parseDouble(stringArray[3]);
                                                totalLabAmount += amntPaid;
                                    %>
                                    <tr>
                                        <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=key%></td>
                                        <td style="text-align: left;"><%=stringArray[2]%></td>
                                        <td style="text-align: right;"><%=df.format(amntPaid)%></td>
                                        <td style="text-align: right;" ><%=df.format(Double.parseDouble(stringArray[3]))%></td>                                       
                                        <td style="text-align: right;"><%=df.format(totalAmountPaid)%></td>
                                    </tr>


                                    <%
                                            }
                                        }

                                    %>


                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td style="font-size: larger;">

                                        </td>
                                        <td style="font-size: larger; text-align: right;"><b>

                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right;">
                                            <b>
<%=df.format(totalLabAmount)%>
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right;">
                                            <b>
<%=df.format(totalOutstanding)%>
                                            </b>

                                        </td>
                                        <td style="font-size: larger; text-align: right;">
                                            <b>
<%=df.format(totalAmount)%>
                                            </b>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    

    </div>
</div>
<!--end static dialog-->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
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
            "sTitle" : "Outstanding Lab Report",        
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 400,
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
    

</script>


</body>
</html>