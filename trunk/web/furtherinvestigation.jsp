<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

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
        <meta charset="utf-8">
        <title>ClaimSync Extended</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <link href="css/docs.css" rel="stylesheet">
        <link rel="stylesheet" href="css/styles.css">
        <style type="text/css" title="currentStyle">
            @import "css/jquery.dataTables_themeroller.css";
            @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
            body {
                /*    overflow: hidden; */
            }

            .large_button {
                background-color: #35AFE3;
                background-image: -moz-linear-gradient(center top , #45C7EB, #2698DB);
                box-shadow: 0 1px 0 0 #6AD2EF inset;
                color: #FFFFFF;
                text-decoration: none;
                font-weight: lighter;
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
                font-size: 36px;
            }

            .large_button:hover {
                background-color: #FBFBFB;
                background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
                background-repeat: repeat-x;
                border: 1px solid #DDDDDD;
                border-radius: 3px 3px 3px 3px;
                box-shadow: 0 1px 0 #FFFFFF inset;
                list-style: none outside none;
                color: #777777;
                /* padding: 7px 14px; */
            }
        </style>

        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />

        <%
            HMSHelper mgr = new HMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            //Patient p = (Patient)session.getAttribute("patient");
            //get current date time with Date()
            Date date = new Date();
            //System.out.println(dateFormat.format(date));
            List visits = mgr.listSecondaryConsultation((String) session.getAttribute("unit"));
            List treatments = null;
            // for (int i = 0; i < visits.size(); i++) {
            //   Visitationtable visit = (Visitationtable) visits.get(i);
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

                        <li class="active">
                            <a href="#">Further Investigation</a><span class="divider"></span>
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

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th> Patient No </th>
                                        <th> Patient Name </th>
                                        <th> Date of Birth  </th>
                                        <th> Sponsor </th>
                                        <th> Membership ID </th>
                                        <th> Request Date </th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (visits != null) {
                                            for (int i = 0; i < visits.size(); i++) {
                                                Visitationtable vst = (Visitationtable) visits.get(i);
                                    %>
                                    <tr>
                                        <td colspan="7">
                                            <div class="dialog" id="<%=vst.getVisitid()%>_dialog" title="Enter Results">

                                                <div class="well thumbnail">
                                                    <ul style="margin-left: 0px;" class="breadcrumb">
                                                        <li>
                                                            <span class="divider"></span> 
                                                        </li>

                                                    </ul>
                                                    <form action="action/forwardaction.jsp" method="post">
                                                        <table class="table table-bordered table-condensed example display">
                                                            <thead>
                                                                <tr style="color: #000;">
                                                                    <th> Test </th>
                                                                    <th> Result </th>
                                                                    <th> Price</th>
                                                                    <th> Can Afford</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%

                                                                    List ptreatmentss = mgr.patientInvestigation(vst.getVisitid());
                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                        Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                                                                        List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                                                        Laborders laborder = (Laborders) laborders.get(0);
                                                                %>
                                                                <tr>
                                                                    <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> </h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></td> </tr> <tr>
                                                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><%=mgr.getInvestigation(ptPatienttreatments.getInvestigationid()).getName()%> </td>
                                                                    <%if (ptPatienttreatments.getPerformed().equalsIgnoreCase("paid")) {%>
                                                                    <td> Result: <input type="text" name="results<%=ptPatienttreatments.getId()%>" value=""/><br/>
                                                                        Con'tn: <input type="text" name="concentration<%=ptPatienttreatments.getId()%>" value=""/><br/>
                                                                        Range: <input type="text" name="range<%=ptPatienttreatments.getId()%>" value=""/>
                                                                        <input type="hidden" name="ids[]" value="<%=ptPatienttreatments.getId()%>"/>
                                                                    </td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td>Paid</td>
                                                                    <%}
                                                                        if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Afford")) {%>

                                                                    <td>Unpaid</td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td>Pending Payment</td>

                                                                    <%}
                                                                        if (ptPatienttreatments.getPerformed().equals("No")) {%>
                                                                    <td>Unpaid</td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td><input type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"/></td>
                                                                        <%}
                                                                            if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Yes")) {%>
                                                                    <td><%=ptPatienttreatments.getResult()%></td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td>Paid</td>

                                                                    <%}%> 
                                                                   <!-- <td><%=ptPatienttreatments.getPrice()%></td>-->
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="labid" value="<%=laborder.getOrderid()%>"/>
                                                            </tr>

                                                            <%}%>
                                                            <!-- </form>

                                                           end-->
                                                            <tr>
                                                                <td>

                                                                    <select name="unitid">
                                                                        <%
                                                                            List consultingrooms = mgr.listConRooms();
                                                                            List units = mgr.listUnits();
                                                                            String previous = vst.getPreviouslocstion();
                                                                            String[] strs = previous.split("_");
                                                                            for (int j = 0; j < units.size(); j++) {
                                                                                Units unit = (Units) units.get(j);

                                                                                if (strs[0].equalsIgnoreCase("account")) {
                                                                                    if (unit.getType().equalsIgnoreCase("records")) {
                                                                        %>
                                                                        <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option> 
                                                                        <% }
                                                                            }
                                                                            if (strs[0].equalsIgnoreCase("consultation")) {
                                                                                if (unit.getType().equalsIgnoreCase("account")) {
                                                                        %>
                                                                        <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option> 
                                                                        <% }
                                                                                }
                                                                            }
                                                                        %>
                                                                    </select>


                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <button class="btn btn-info" name="laboratory" value="Forward" id="">
                                                                        <i class="icon-white icon-check"></i> Forward 
                                                                    </button>
                                                                </td>
                                                            </tr>      
                                                            </tbody>

                                                        </table>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%> </td>

                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>

                                        <td><%=vst.getDate()%> </td>

                                        <td>
                                            <button class="btn btn-info" id="<%=vst.getVisitid()%>_link">
                                                <i class="icon-white icon-check"></i> Update 
                                            </button></td>
                                    </tr>
                                    <%}
                                        }%> 

                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <footer style="display: none; margin-top: 50px;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

        </div><!-- /container -->    

    </div>
</div>
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

<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

<script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
<script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

<script type="text/javascript" src="js/tablecloth.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
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


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
            
            

        $(".patient").popover({

            placement : 'right',
            animation : true

        });

    });

</script>
<% for (int i = 0;
            i < visits.size();
            i++) {
        Visitationtable vst = (Visitationtable) visits.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getVisitid()%>_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
    $("#<%= vst.getVisitid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
   
    
    $("#<%= vst.getVisitid()%>_link").click(function(){
      
        $("#<%=vst.getVisitid()%>_dialog").dialog('open');
    
    })
   
    $("#<%= vst.getPatientid()%>_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
   
    
    $("#<%= vst.getVisitid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getVisitid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>




<% }%>

</body>
</html>
