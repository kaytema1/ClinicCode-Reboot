<!DOCTYPE html>
<html lang="en">
    <meta charset="utf-8">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
    <%
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        HMSHelper mgr = new HMSHelper();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

        Date date = new Date();
        List visits = mgr.listRecentVisits(dateFormat.format(date));
        int totalVists = mgr.listVisitations().size();
        int inVisits = mgr.listVisitations("In Patient").size();
        int outvisits = mgr.listVisitations("Out Patient").size();

    %>
    <head>
        <meta charset="utf-8">
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">
                    <li class="active">
                        <a href="#">At-a-Glance Dashboard</a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section style="margin-top: -30px;" id="dashboard">

            <!-- Headings & Paragraph Copy -->
            <div class="row">

                <%@include file="widgets/leftsidebar.jsp" %>

                <div style="margin-top: 0px; "class="span12 offset3 content1 hide">
                    <ul class="breadcrumb span9 pull-right" style="padding-bottom: 0px; line-height: 27px;">
                        <li>
                            <h4><a href="#">At-a-Glance Dashboard</a></h4>
                        </li>
                        <li class="pull-right" style=" margin-left: 5px;">
                            <button class="btn btn-inverse">
                                <i class="icon icon-white icon-search"></i> Display
                            </button>
                        </li>
                        <li style="padding-left: 10px;" class="pull-right">
                            <input type="text" class="input-medium" placeholder="Select Date Range" value="4/23/99" id="rangeA" />

                        </li>
                        <li  class="active pull-right" style="padding-top: 5px;">
                            <!--	<select class="input-large" id="selectError">
                            <option>Emmanuel Addo-Yirenkyi & Dependants</option>
                            <option>Emmanuel Addo-Yirenkyi Only </option>
                            <option>All Dependants Only </option>

                            <option>Adwoa Mansah (Dependant 1)</option>
                            <option>Kofi Manu (Dependant 2)</option>
                            <option>Ama Brako (Dependant 3)</option>
                            </select>  -->
                            <h4> Select Date Range </h4>
                        </li>

                    </ul>

                    <div style="height: 200px; overflow: hidden; margin-bottom: 20px; padding: 0px; width: 420px;" class="box span4  pull-left " id="myModal">
                        <div class="modal-header" style="height: 12%; background-color: #F8F8F8;">

                            <img class="pull-left" src="img/glyphicons/png/glyphicons_043_group.png" /><a class="pull-left" style=" padding-left: 20px;"> <h3> Patient Attendance</h3> </a>

                        </div>
                        <div style="height: 240px; margin-top: 10px; padding: 20px; z-index: 1000; overflow: hidden;" class="box-body">

                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%=totalVists%> </h1>
                                <br />
                                <a> Total Visits </a></span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%=outvisits%> </h1>
                                <br />
                                <a>Outpatient Visits </a> </span>
                            <span style="width: 34%; text-align: center; float: left;"> <h1> <%=inVisits%> </h1>
                                <br />
                                <a>Inpatient Admissions </a> </span>

                        </div>

                    </div>

                    <div style="height: 200px; overflow: hidden; margin-bottom: 20px; width: 420px;" class="box span4  pull-left" id="myModal">
                        <div class="modal-header" style="height: 12%; background-color: #F8F8F8;">

                            <img class="pull-left" src="img/glyphicons/png/glyphicons_227_usd.png" /><a class="pull-left" style=" padding-left: 20px;"> <h3> Billing </h3> </a>

                        </div>
                        <div style="height: 240px; margin-top: 10px; padding: 20px; z-index: 1000; overflow: hidden;" class="box-body">

                            <span style="width: 33%; text-align: center; float: left;"> <h1> 200,000 </h1>
                                <br />
                                <a> Cash Receipts </a></span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> 10,000 </h1>
                                <br />
                                <a>Cash Payments </a> </span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> 13,000 </h1>
                                <br />
                                <a>Claims Submitted </a> </span>

                        </div>

                    </div>

                    <div style="height: 200px; overflow: hidden; width: 420px;" class="box span4 pull-left" id="myModal">
                        <div class="modal-header" style="height: 12%; background-color: #F8F8F8;">

                            <img class="pull-left" src="img/glyphicons/png/glyphicons_003_user.png" /><a class="pull-left" style=" padding-left: 20px;"> <h3>Staff on Duty</h3> </a>

                        </div>
                        <div style="height: 240px; margin-top: 10px; padding: 20px; z-index: 1000; overflow: hidden;" class="box-body">

                            <span style="width: 33%; text-align: center; float: left;"> <h1>  <%= mgr.listStaffWithThisRole(3).size()%> </h1>
                                <br />
                                <a> Doctors </a></span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%= mgr.listStaffWithThisRole(7).size()%> </h1>
                                <br />
                                <a>Nurses </a> </span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%= mgr.listAllStaff().size() - (mgr.listStaffWithThisRole(3).size() + mgr.listStaffWithThisRole(7).size())%></h1>
                                <br />
                                <a>Other Staff </a> </span>

                        </div>

                    </div>

                    <div style="height: 200px; overflow: hidden; width: 420px;" class="box span4 pull-left" id="myModal">
                        <div class="modal-header" style="height: 12%; background-color: #F8F8F8;">

                            <img class="pull-left" src="img/glyphicons/png/glyphicons_029_notes_2.png" /><a class="pull-left" style=" padding-left: 20px;"> <h3> Insurance & Claims</h3> </a>

                        </div>
                        <div style="height: 240px; margin-top: 10px; padding: 20px; z-index: 1000; overflow: hidden;" class="box-body">

                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%= mgr.listPatientsBySponsorType("NHIS").size()%> </h1>
                                <br />
                                <a> NHIS Patients </a></span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%= mgr.listPatientsBySponsorType("Private").size() + mgr.listPatientsBySponsorType("Cooperate").size()%> </h1>
                                <br />
                                <a>Private Patients </a> </span>
                            <span style="width: 33%; text-align: center; float: left;"> <h1> <%= mgr.listPatientsBySponsorType("CASH").size()%> </h1>
                                <br />
                                <a>Claims Processed </a> </span>

                        </div>

                    </div>

                </div>
                <div class="clearfix"></div>

            </div>

        </section>

        <footer style="display: none;" class="footer">
            <p style="text-align: center" class="pull-right">
                <img src="images/logo.png" width="100px;" />
            </p>
        </footer>

    </div><!-- /container -->

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

    <!--	<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
    <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
    <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

    <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
    <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

    <script type="text/javascript" src="js/tablecloth.js"></script>  -->
    <script type="text/javascript" src="js/demo.js"></script>
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
    <script type="text/javascript">
                   
        $("#rangeA").daterangepicker();

    </script>
</body>
</html>
