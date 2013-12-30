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
                   // System.out.println("very single");
                    System.out.println(" dateValue : " + dateValue);
                    labPayments = mgr.listLabPaymentsForDate(dateSqlDate);
                } else {
                 //   System.out.println("not very single");
                    labPayments = mgr.listLabPaymentsForDuration(dateSqlDate, rangeSqlDate);
                }
            } else {
                System.out.println("in here with date  : " + mgr.getCurrentDate());
                labPayments = mgr.listLabPaymentsForDate(mgr.getCurrentDate());
            }


            System.out.print("dateValue : " + dateValue);
            
            System.out.println("labPayments.size : " + labPayments.size());
            
            
            
            HashMap<String, String> hashMap = new HashMap<String, String>();
            int count = 0;
            double outOfPocketAmount = 0.0, primarySponsorAmount = 0.0, secondarySponsorAmount = 0.0, totalSponsoredAmount = 0.0;
            String staffid = "";
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);
            double totalRate = 0.0, totalAmntPaid = 0.0;
            int totalCount = 0;
           
            

            for (int i = 0; i < labPayments.size(); i++) {
                PaymentObject vst = labPayments.get(i);
            //    System.out.println("vst " + vst);
                staffid = vst.getStaffId();
            //    System.out.println("staffid : " + staffid);
                
                outOfPocketAmount = 0.0; primarySponsorAmount = 0.0; secondarySponsorAmount = 0.0;
                
                if(vst.getOutOfPocketAmount() != null) {
                outOfPocketAmount = vst.getOutOfPocketAmount();
                               }
                if(vst.getPrimarySponsorAmount() != null) {
                primarySponsorAmount = vst.getPrimarySponsorAmount();
                               }
                if(vst.getSecSponsorAmount() != null) {
                    secondarySponsorAmount = vst.getSecSponsorAmount();
                }
                
                if (hashMap.containsKey(staffid)) {
                    String string = hashMap.get(staffid);
                    hashMap.remove(staffid);
                    String[] arr = string.split("_");
             /*       System.out.println("arr.length : " + arr.length);
                    System.out.println("arr[0] : " + arr[0]);
                    System.out.println("arr[1] : " + arr[1]);
                    System.out.println("arr[2] : " + arr[2]);
                    */
                    count = Integer.parseInt(arr[0]) + 1;
                  //  System.out.println("outOfPocketAmount : " + outOfPocketAmount + "existing amount : " + arr[1]);
                    outOfPocketAmount = outOfPocketAmount + Double.parseDouble(arr[1]);
                //    System.out.println("outofpockettotal : " + outOfPocketAmount);
                //    System.out.println("primarySponsorAmount : " + primarySponsorAmount );
                //     System.out.println("secondarySponsorAmount : " + secondarySponsorAmount );
                //     System.out.println("incomingtotalsponsored : " + ( primarySponsorAmount + secondarySponsorAmount ) );
                    
                    
                    totalSponsoredAmount = (primarySponsorAmount + secondarySponsorAmount) + Double.parseDouble(arr[2]);
                    
             //       System.out.println("totalSponsoredAmount : " + totalSponsoredAmount + "existing amount : " + arr[2]);
            //        System.out.println("staffid : " + staffid + " count : " + count + " price : " + price + " amntActualyPaid : " + amntActualyPaid);
                    hashMap.put(staffid, "" + count + "_" + outOfPocketAmount + "_" + totalSponsoredAmount);
                } else {
                    outOfPocketAmount = outOfPocketAmount;
             //       System.out.println("primarySponsorAmount : " + primarySponsorAmount );
             //        System.out.println("secondarySponsorAmount : " + secondarySponsorAmount );
             //        System.out.println("incomingtotalsponsored : " + ( primarySponsorAmount + secondarySponsorAmount ) );
                     
                    totalSponsoredAmount = primarySponsorAmount + secondarySponsorAmount;
             //       System.out.println("leaving totalsponsored : " + totalSponsoredAmount );
                    hashMap.put(staffid, "1_" + outOfPocketAmount + "_" + totalSponsoredAmount);
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
                            <a href="#">Payment Type Sales Report</a><span class="divider"></span>
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
                                        <a style="font-size: 15px;">Payment Type Sales Report | <%=displayedDate%></a>
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
                                        <th style="text-align: left;"> Cash Sales</th>
                                        <th style="text-align: left;"> Credit Sales</th>
                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    System.out.println("here safely");
                                        if (!hashMap.isEmpty()) {
                                            Collection<?> keys = hashMap.keySet();
                                            for (Object key : keys) {
                                                String string = hashMap.get(key);
                                                String[] stringArray = string.split("_");
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4;  font-weight: bold; font-size: 14px;"><%=mgr.getStafftableByid(key + "").getOthername()%> <%=mgr.getStafftableByid(key + "").getLastname()%></td>
                                        <td style="text-align: right;"><%= stringArray[0]%>
                                            <% totalCount = totalCount + Integer.parseInt(stringArray[0]); %>
                                        </td>
                                        <td style="text-align: right;"><%=stringArray[1]%>0 
                                             <% totalRate = totalRate + Double.parseDouble(stringArray[1]); %>
                                        </td>
                                        
                                        <td style="text-align: right;"><%=stringArray[2]%>0 
                                             <% totalAmntPaid = totalAmntPaid + Double.parseDouble(stringArray[2]); %>
                                        </td>
                                        <td style="text-align: center;"> 
                                            <a class="btn btn-info btn-small" href="paymenttypesalesdetails.jsp?staffid=<%=key%>&datevalue=<%=displayedDate  %>">View Details </a> 
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
                                                <%= totalCount %>
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right">
                                            <b > 
                                                <%= df.format(totalRate) %>
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right">
                                            <b > 
                                                <%= df.format(totalAmntPaid) %>
                                            </b>
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

<!--
mysql queries

SELECT SUM( `out_of_pocket_amount` )
FROM payment_object
WHERE `date_paid` >= '2013-08-20'
AND `date_paid` <= '2013-08-21'
AND `staff_id` = 'dl008'

SELECT SUM( `primary_sponsor_amount` ) + SUM( `sec_sponsor_amount` )
FROM payment_object
WHERE `date_paid` >= '2013-08-20'
AND `date_paid` <= '2013-08-21'
AND `staff_id` = 'dl008'

Derrick191 and Password: 1998_Derrick 

-->

</body>
</html>