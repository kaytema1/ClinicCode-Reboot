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
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);

            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            String staffid = request.getParameter("staffid") == null ? "" : request.getParameter("staffid");
            String incomingDateValue = request.getParameter("datevalue") == null ? "" : request.getParameter("datevalue");

            List<PaymentObject> labPayments = null;


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
                    labPayments = mgr.listLabPaymentsForDate(dateSqlDate);
                } else {
                    labPayments = mgr.listLabPaymentsForDuration(dateSqlDate, rangeSqlDate);
                }
            } else {
                labPayments = mgr.listLabPaymentsForDate(mgr.getCurrentDate());
            }


            System.out.print("dateValue : " + dateValue);
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
                            <a href="#">Payment Type Sales Report Details by <%=mgr.getStafftableByid(staffid).getLastname()%> <%=mgr.getStafftableByid(staffid).getOthername()%> Patients</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <%if (session.getAttribute(
                            "lasterror") != null) {%>
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
                            <form action="" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Payment Type Sales Report Details by <%=mgr.getStafftableByid(staffid).getLastname()%> <%=mgr.getStafftableByid(staffid).getOthername()%> | <%=displayedDate%></a>
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
                            <table class="example display table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;"> Laboratory Number </th>
                                        <th style="text-align: left;"> Patient Name </th>
                                        <th style="text-align: left;"> Cash Sales</th>
                                        <th style="text-align: left;"> Credit Sales</th>
                                        <th style="text-align: left;"> Date Paid</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% double totalAmout = 0.0;
                                        double totalPaid = 0.0;
                                        double totalOutstanding = 0.0;
                                        double outOfPocketPayment = 0, primarySponsorAmount = 0, secSponsorAmount = 0, totalSponsoredAmount = 0;
                                        double overallOutOfPocketPayment = 0, overallSponsoredPayment = 0;
                                        if (labPayments != null) {
                                            for (int i = 0; i < labPayments.size(); i++) {
                                                outOfPocketPayment = 0;
                                                primarySponsorAmount = 0;
                                                secSponsorAmount = 0;
                                                totalSponsoredAmount = 0;
                                                PaymentObject paymentObjct = labPayments.get(i);
                                                if (paymentObjct.getStaffId().equalsIgnoreCase(staffid)) {
                                                    outOfPocketPayment = 0;
                                                    primarySponsorAmount = 0;
                                                    secSponsorAmount = 0;
                                                    if (paymentObjct.getOutOfPocketAmount() != null) {
                                                        outOfPocketPayment = paymentObjct.getOutOfPocketAmount();
                                                    }
                                                    if (paymentObjct.getPrimarySponsorAmount() != null) {
                                                        primarySponsorAmount = paymentObjct.getPrimarySponsorAmount();
                                                    }
                                                    if (paymentObjct.getSecSponsorAmount() != null) {
                                                        secSponsorAmount = paymentObjct.getSecSponsorAmount();
                                                    }
                                                    totalSponsoredAmount = primarySponsorAmount + secSponsorAmount;
                                                    
                                                    overallOutOfPocketPayment += outOfPocketPayment; 
                                                    overallSponsoredPayment += totalSponsoredAmount;
                                                    //                       totalAmout = totalAmout + laborders.getTotalAmount();
                                                    //                        totalPaid = totalPaid + laborders.getAmountpaid();
                                                    //                       totalOutstanding = totalOutstanding + laborders.getOutstanding();
%>
                                    <tr>
                                        <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=paymentObjct.getTransactionId()%></td>
                                        <td><%=paymentObjct.getPatientId().contains("C") || paymentObjct.getPatientId().contains("c") ? mgr.getPatientByID(paymentObjct.getPatientId()).getFname() + " " + mgr.getPatientByID(paymentObjct.getPatientId()).getLname() + " " + mgr.getPatientByID(paymentObjct.getPatientId()).getMidname() : mgr.getLabPatientByID(paymentObjct.getPatientId()).getFname() + " " + mgr.getLabPatientByID(paymentObjct.getPatientId()).getLname() + " " + mgr.getLabPatientByID(paymentObjct.getPatientId()).getMidname()%></td>
                                        <td style="text-align: right;"><%=df.format(outOfPocketPayment)%></td>
                                        <td style="text-align: right;"><%=df.format(totalSponsoredAmount)%></td> 
                                        <td ><%=formatter.format(paymentObjct.getDatePaid())%></td>
                                    </tr>
                                    <%}
                                            }
                                        }%> 

                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td style="line-height: 25px; font-size: larger"><b>TOTAL</b></td>
                                        <td></td>
                                        
                                        <td style="text-align: right; font-size: larger"><b><%=df.format(overallOutOfPocketPayment)%></b></td>
                                        <td style="text-align: right; font-size: larger"><b><%=df.format(overallSponsoredPayment)%></b></td>
                                        <td style="text-align: right; font-size: larger"></td>
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
            "sPaginationType" : "full_numbers",
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