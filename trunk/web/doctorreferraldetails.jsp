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
            String doctorid = request.getParameter("doctorid") == null ? "" : request.getParameter("doctorid");
            //List dispatch = mgr.listLabordersByStatus("Dispatched");
            List listorders = mgr.listLabordersByDoctorid(doctorid);
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);
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
                            <a href="#">Doctor Referral Details</a><span class="divider"></span>
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
                                        <a style="font-size: 15px;"> Doctor's Referral Summary</a>
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
                                        <th style="text-align: left;"> Payment Type </th>
                                        <th style="text-align: left;"> Requested On</th>
                                        <th style="text-align: left;"> Requested By</th>
                                        <th style="text-align: left;"> Total Amount</th>
                                        <th style="text-align: left;"> Amount Paid</th>
                                        <th style="text-align: left;"> Outstanding Bill</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% double totalAmout = 0.0;
                                        double totalPaid = 0.0;
                                        double totalOutstanding = 0.0;
                                        if (listorders != null) {
                                            for (int i = 0; i < listorders.size(); i++) {
                                                Laborders laborders = (Laborders) listorders.get(i);
                                                totalAmout = totalAmout + laborders.getTotalAmount();
                                                totalPaid = totalPaid + laborders.getAmountpaid();
                                                totalOutstanding = totalOutstanding + laborders.getOutstanding();
                                    %>
                                    <tr>
                                        <td style="line-height: 25px; text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 18px;"><%=laborders.getOrderid()%></td>
                                        <td><%=laborders.getPatientid().contains("C") || laborders.getPatientid().contains("c") ? mgr.getPatientByID(laborders.getPatientid()).getFname() + " " + mgr.getPatientByID(laborders.getPatientid()).getLname() + " " + mgr.getPatientByID(laborders.getPatientid()).getMidname() : mgr.getLabPatientByID(laborders.getPatientid()).getFname() + " " + mgr.getLabPatientByID(laborders.getPatientid()).getLname() + " " + mgr.getLabPatientByID(laborders.getPatientid()).getMidname()%></td>
                                        <td><%= mgr.getSponsor(mgr.sponsorshipDetails(laborders.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(laborders.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(laborders.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                        <td><%=laborders.getOrderdate() == null ? " " : formatter.format(laborders.getOrderdate())%></td> 
                                        <td><%=laborders.getFromdoc()%></td>
                                        <td style="text-align: right;"><%=df.format(laborders.getTotalAmount())%></td>
                                        <td style="text-align: right;"><%=df.format(laborders.getAmountpaid())%></td>
                                        <td style="text-align: right;"><%=df.format(laborders.getOutstanding())%></td>
                                    </tr>
                                    <%}
                                            // }
                                        }%> 
                                    <tr>
                                        <td style="font-size: larger;"><b>TOTAL</b></td><td></td><td></td><td></td><td></td>
                                        <td style="text-align: right; font-size: larger;"><b><%=df.format(totalAmout)%></b></td><td style="text-align: right; font-size: larger;"><b><%=df.format(totalPaid)%></b></td><td style="text-align: right; font-size: larger;"><b><%=df.format(totalOutstanding)%></b></td>
                                    </tr>
                                </tbody>
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

    
</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 500,
            "sDom": '<"H"Tfr>t<"F"ip>',
            "oTableTools": {
                "aButtons": [
                            
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