<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Formatter"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <% Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> lists = (ArrayList<Integer>) session.getAttribute("staffPermission");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);

        %>

        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
            String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            Patient p = null;

            Visitationtable vs = null;
            int lastVisitId = 0;
            

            try {


                if (searchid.equalsIgnoreCase("patientid")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("account_search.jsp");
                        return;
                    }

                    p = mgr.getPatientByID(searchquery.trim());
                    if (p == null) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("account_search.jsp");
                    }

                }



            } catch (Exception e) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("account_search.jsp");
                return;
            }
            
            
            List visits = mgr.patientHistory(p.getPatientid());

            for (int r = 0; r < visits.size(); r++) {
                vs = (Visitationtable) visits.get(r);
                lastVisitId = vs.getVisitid();
            }
            vs = mgr.getVisitById(lastVisitId);


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
                            <a href="account_search.jsp">Patient Bill Search</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Bill Search Results</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>
            <%if (p != null) {%>
            <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <%if (session.getAttribute("lasterror") != null) {%>
                    <div class="alert hide <%=session.getAttribute("class")%> center">
                        <b> <%=session.getAttribute("lasterror")%>  </b>
                    </div>
                    <br/>
                    <div style="margin-bottom: 20px;" class="clearfix"></div>
                    <%session.removeAttribute("lasterror");
                        }%>

                    <div style="display: none;" class="span8 main-c thumbnail">



                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Folder Number</th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Folder Location</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr class="odd gradeX">

                                    <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= p.getFname()%> <%= p.getMidname()%>  <%= p.getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td>
                                        <%=  mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>">
                                        <a class="patientid"><%= p.getPatientid()%></a>
                                    </td>
                                    <td><%= p.getFname()%>  <%= p.getMidname()%> <%= p.getLname()%></td><td><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td><td>  <%= formatter.format(p.getDateofbirth())%> </td>
                                    <td style="text-transform: capitalize;"><%= mgr.getPatientFolder(p.getPatientid()).getStatus()%></td>
                                    <td>
                                        <a href="processdepositpayment.jsp?visitid=<%=vs.getVisitid()%>" class="btn btn-info btn-small" id="<%=vs.getVisitid()%>_link">
                                            Make Deposit
                                        </a></td>
                                </tr>



                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container --> 




        <% }%>




        <%@include file="widgets/footer.jsp" %>


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

        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>

        <script type="text/javascript" src="js/tablecloth.js"></script>
        <script type="text/javascript" src="js/demo.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript">
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                //  menu_ul.hide();

                $(".menu").fadeIn();
                $(".alert").fadeIn();
                $(".main-c").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $("#bgimage").fadeIn();
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
                    "sScrollY" : "300px",
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


    </body>
</html>
