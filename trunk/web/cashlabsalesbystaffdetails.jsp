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
            Stafftable staffToUse = null;
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E dd MMM. yyyy HH:mm a");
            Date date = new Date();
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);

            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            List<PaymentObject> payments = null;
            String staffid = request.getParameter("staffid") == null ? "" : request.getParameter("staffid");
            String incomingDateValue = request.getParameter("datevalue") == null ? "" : request.getParameter("datevalue");

            // use staffId to check for valid staff

            if (!staffid.isEmpty()) {
                staffToUse = mgr.getStafftableByid(staffid);

                if (staffToUse == null) {
                    response.sendRedirect("labsalesbystaff.jsp");
                    return;
                }
            } else {
                response.sendRedirect("labsalesbystaff.jsp");
                return;
            }

            if (incomingDateValue.isEmpty()) {
                response.sendRedirect("labsalesbystaff.jsp");
                return;
            }

            List listorders = null;


            boolean correctDateFound = false;
            boolean singleDateValue = true;
            SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateUtilDate = new java.util.Date();
            java.sql.Date dateSqlDate = null;


            SimpleDateFormat rangeformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date rangeUtilDate = new java.util.Date();
            java.sql.Date rangeSqlDate = null;

            String displayedDate = incomingDateValue;
            String dateValue = "";
            String dateRange = "";
            String splittedDateDuration[] = new String[2];
            String[] splittedDate = new String[3];
            String[] splittedDateRange = new String[3];

            System.out.println("telling");
            dateRange = request.getParameter("daterange");
            System.out.println("dateRange : " + dateRange);


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
            } else {
                response.sendRedirect("labsalesbystaff.jsp");
                return;
            }

            System.out.println("dateSqlDate : " + dateSqlDate + ",  rangeSqlDate : " + rangeSqlDate);

            if (correctDateFound) {
                if (singleDateValue) {
                    payments = mgr.listLabPaymentsByStaffForDate(staffid, dateSqlDate);
                } else {
                    payments = mgr.listLabPaymentsByStaffForDuration(staffid, dateSqlDate, rangeSqlDate);
                }
            } else {
                payments = mgr.listLabPaymentsByStaffForDate(staffid, dateSqlDate);
            }
            double totalOutOfPocketAmount = 0;

            System.out.println("payments.size : " + payments.size());
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
                            <a href="#">Laboratory Staff Sales Report for <%=mgr.getStafftableByid(staffid).getOthername()%> Patients</a><span class="divider"></span>
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
                                        <a style="font-size: 15px;">Laboratory Staff Sales Summary | <%=displayedDate%></a>
                                    </li>

                                </ul>
                            </form>
                            <table class="example display table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;"> Patient ID</th>
                                               <th style="text-align: left;"> Lab Order ID</th>
                                        <th style="text-align: left;"> Patient Name</th>
                                         <th style="text-align: left;"> Time Paid</th>
                                        <th style="text-align: left;"> Amount Paid</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (!payments.isEmpty()) {
                                            double pmnt = 0;
                                            String patientName = "", timePaid = "", labOrderId = "";
                                            LabPatient patient;
                                            for (PaymentObject payment : payments) {
                                                patientName = "";

                                                try {
                                                    patient = mgr.getLabPatientByID(payment.getPatientId());
                                                    patientName = patient.getFname() + " " + patient.getLname();
                                                } catch (Exception e) {
                                                    patientName = "Clinic Patient";
                                                }

                                                if (payment.getOutOfPocketAmount() > 0) {
                                                    pmnt = payment.getOutOfPocketAmount();
                                                    labOrderId = payment.getTransactionId();
                                                    timePaid = payment.getTimePaid() + "";
                                                    totalOutOfPocketAmount += payment.getOutOfPocketAmount();%>
                                    <tr>
                                        <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=payment.getPatientId()%></td>
                                         <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=labOrderId %></td>
                                        <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=patientName%></td>
                                        <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=timePaid %></td>
                                        <td style="text-align: right;"><%=df.format(pmnt)%></td>
                                    </tr> 

                                    <%            }
                                            }
                                        }
                                    %>               
                                </tbody>
                                <tfoot>
                                <td>TOTAL</td>
                                <td></td>
                                <td><%=totalOutOfPocketAmount%></td>
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