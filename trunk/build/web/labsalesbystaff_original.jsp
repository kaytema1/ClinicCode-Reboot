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
            List listorders = null;
            List payments = null;
            double cashAmount = 0;

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
                    listorders = mgr.listLabordersForDate(dateSqlDate);
                } else {
                    System.out.println("not very single");
                    listorders = mgr.listLabordersForDuration(dateSqlDate, rangeSqlDate);
                }
            } else {
                listorders = mgr.listLabordersForDate(mgr.getCurrentDate());
            }

            HashMap<String, String> hashMap = new HashMap<String, String>();
            int count = 0;
            double price = 0.0, amntActualyPaid = 0.0;
            
            double creditAmount = 0.0;
            double outstanding = 0.0;
            PaymentObject payment = null;
            String staffid = "";
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);
            double totalRate = 0.0, totalAmntPaid = 0.0, totalCashSales = 0.0, totalCreditSales = 0.0;
            int totalCount = 0;

            for (int i = 0; i < listorders.size(); i++) {
                Laborders vst = (Laborders) listorders.get(i);
                payments = mgr.getPatientTransactionPaymentsByStaff(vst.getOrderid(),vst.getReceivedBy());
                
                if (payments != null) {
                    System.out.println("Its not null");
                    for (int x = 0; x < payments.size(); x++) {
                        payment = (PaymentObject) payments.get(x);
                        
                        cashAmount = cashAmount + payment.getOutOfPocketAmount();
                      //  System.out.println(cashAmount);
                    }
                }
                staffid = vst.getReceivedBy();
                price = vst.getTotalAmount();
                amntActualyPaid = vst.getAmountpaid();
                //cashAmount = payment.getOutOfPocketAmount();

                if (hashMap.containsKey(staffid)) {
                    String string = hashMap.get(staffid);
                    hashMap.remove(staffid);
                    String[] arr = string.split("_");

                    System.out.println("arr.length : " + arr.length);
                    System.out.println("arr[0] : " + arr[0]);
                    System.out.println("arr[1] : " + arr[1]);
                    System.out.println("arr[2] : " + arr[2]);
                    System.out.println("arr[3] : " + arr[3]);

                    count = Integer.parseInt(arr[0]) + 1;
                    price = price + Double.parseDouble(arr[1]);
                    amntActualyPaid = amntActualyPaid + Double.parseDouble(arr[2]);
                    System.out.println(arr[3] + "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                    //cashAmount = cashAmount + Double.parseDouble(arr[3]);
                    //        System.out.println("staffid : " + staffid + " count : " + count + " price : " + price + " amntActualyPaid : " + amntActualyPaid);
                    hashMap.put(staffid, "" + count + "_" + price + "_" + amntActualyPaid + "_" + cashAmount);
                } else {
                    System.out.println("Yoooooo");
                    price = vst.getTotalAmount();
                    amntActualyPaid = vst.getAmountpaid();
                    cashAmount = payment.getOutOfPocketAmount();
                    hashMap.put(staffid, "1_" + price + "_" + amntActualyPaid + "_" + cashAmount);
                }

            }

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
                            <a href="#">Laboratory Staff Sales Summary</a><span class="divider"></span>
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
                            <form action="" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Laboratory Staff Sales Summary | <%=displayedDate%></a>
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
                                        <th style="text-align: left;"> Staff</th>
                                        <th style="text-align: left;"> Number of Labs</th>
                                        <th style="text-align: left;"> Actual Total Sales</th>
                                        <th style="text-align: left;"> Expected Total Sales</th>
                                        <th style="text-align: left;"> Cash Sales</th>

                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (!hashMap.isEmpty()) {
                                            Collection<?> keys = hashMap.keySet();
                                            for (Object key : keys) {
                                                String string = hashMap.get(key);
                                                String[] stringArray = string.split("_");
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4;  font-weight: bold; font-size: 14px;"><%=mgr.getStafftableByid(key + "").getOthername()%> <%=mgr.getStafftableByid(key + "").getLastname()%></td>
                                        <td style="text-align: right;"><%= stringArray[0]%>
                                            <% totalCount = totalCount + Integer.parseInt(stringArray[0]);%>
                                        </td>
                                        <td style="text-align: right;"><%=stringArray[2]%>0

                                            <% totalRate = totalRate + Double.parseDouble(stringArray[1]);%>
                                        </td>

                                        <td style="text-align: right;"> <%=stringArray[1]%>0 
                                            <% totalAmntPaid = totalAmntPaid + Double.parseDouble(stringArray[2]);%>
                                        </td>
                                        <% outstanding = totalRate - totalAmntPaid;%>
                                        <td  style="text-align: right;">
                                            <%=stringArray[3]%>0 
                                            <% totalCashSales = totalCashSales + Double.parseDouble(stringArray[3]);%>
                                        </td>
                                        <td style="text-align: center;"> 
                                            <a class="btn btn-info btn-small" href="labsalesbystaffdetails.jsp?staffid=<%=key%>">View Details </a> 
                                        </td>
                                    </tr>
                                    <%}%>

                                    <%    // }
                                        }%> 


                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>
                                            <b style="font-size: larger;"> TOTAL </b>
                                        </td>

                                        <td style="font-size: larger; text-align:right ">
                                            <b> 
                                                <%= totalCount%>
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right">
                                            <b > 
                                                <%= df.format(totalAmntPaid)%>

                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right">
                                            <b > 
                                                <%= df.format(totalRate)%>
                                            </b>
                                        </td>

                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b style="font-size: larger;"> 
                                                Amount Outstanding

                                            </b>
                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td style="text-align: right; font-weight: bold; font-size: larger;">
                                            <%= df.format(outstanding)%>
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            
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
