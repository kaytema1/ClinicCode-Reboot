<%--
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

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
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E dd MMM, yyyy HH:mm a");
            Date date = new Date();

            String invid = request.getParameter("invid");
            ////System.out.println(dateFormat.format(date));
            int InvestigationId = Integer.parseInt(invid);
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            //List dispatch = mgr.listLabordersByStatus("Dispatched");
            List listorders = mgr.patientInvestigationByInvestigationid(Integer.parseInt(invid));

            //listorders.addAll(dispatch);
            //System.out.println("laborders+++++++++++++++++++++++++++ " + listorders.size());

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
                            <a href="#">Test Details for <%= mgr.getLabTypeByid(mgr.getInvestigation(InvestigationId).getLabTypeId()).getLabType()%></a><span class="divider"></span>
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
                            <form action="anballdepartments.jsp" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;"><b>Laboratory Test Details for <%= mgr.getLabTypeByid(mgr.getInvestigation(InvestigationId).getLabTypeId()).getLabType()%></a>
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
                                        <th style="text-align: left;"> Requested On </th>
                                        <th style="text-align: left;"> Completed On </th>
                                        <th style="text-align: left;"> Requested By </th>
                                        <th style="text-align: left;"> Status </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (listorders != null) {

                                            for (int i = 0; i < listorders.size(); i++) {
                                                Patientinvestigation vst = (Patientinvestigation) listorders.get(i);
                                    %>

                                    <tr>
                                        <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                        
                                         <td style="text-transform: uppercase; line-height: 25px;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getMembershipid() : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getBenefitplan() : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <a href="print.jsp?labOrderId=<%=vst.getOrderid()%>"><%=vst.getOrderid()%></a></td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=formatter.format(vst.getDate())%></td>
                                        <td><%=mgr.getLaborders(vst.getOrderid()).getDonedate() == null ? "Not Completed" : datetimeformat.format(mgr.getLaborders(vst.getOrderid()).getDonedate())%></td>
                                        <td><%=mgr.getLaborders(vst.getOrderid()) == null ? "" : mgr.getLaborders(vst.getOrderid()).getFromdoc()%></td>
                                        <td><%=mgr.getLaborders(vst.getOrderid()) == null ? "" : mgr.getLaborders(vst.getOrderid()).getDone()%></td>
                                       
                                        
                                        <% } else { %> 
                                        <td style="text-transform: uppercase; line-height: 25px;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getBenefitplan() : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? mgr.sponsorshipDetails(mgr.getLabPatientByID(vst.getPatientid()).getFolderNumber()).getBenefitplan() : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <a href="print.jsp?labOrderId=<%=vst.getOrderid()%>"><%=vst.getOrderid()%></a></td>
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=formatter.format(vst.getDate())%></td>
                                        <td><%=mgr.getLaborders(vst.getOrderid()).getDonedate() == null ? "Not Completed" : datetimeformat.format(mgr.getLaborders(vst.getOrderid()).getDonedate())%></td>
                                        <td><%=mgr.getLaborders(vst.getOrderid()) == null ? "" : mgr.getLaborders(vst.getOrderid()).getFromdoc()%></td>
                                        <td><%=mgr.getLaborders(vst.getOrderid()) == null ? "" : mgr.getLaborders(vst.getOrderid()).getDone()%></td>
                                        <% } %>
                                    </tr>

                                    <%}
                                            // }
                                        }%> 

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
