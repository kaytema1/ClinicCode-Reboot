<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%            
            HMSHelper mgr = new HMSHelper();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            List patients = mgr.listPatients();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            List visits = mgr.listRecentVisits(dateFormat.format(date));
            //String patientid = request.getParameter("patientid")== null ? "" : request.getParameter("patientid");
            try {
            } catch (Exception e) {
                session.setAttribute("lasterror", "patient does not exist please try again");
                response.sendRedirect("index.jsp");
            }
            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            //Patient patient = mgr.getPatientByID(patientid);
            %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <%@include file="widgets/header.jsp" %> 



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">

                    <li>
                        <a href="records.jsp">Records</a><span class="divider"></span>
                    </li>
                    <li class="active">
                        <a href="#">All Patients</a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <div style="position: absolute; left: 30%; top: 200px; text-align: center;" class="progress1">
            <img src="images/logoonly.png" width="136px;" style="margin-bottom: 20px;" />
            <a href="#"> <h3 class="segoe" style="text-align: center; font-weight: lighter;"> Your page is taking longer than expected to load.....
                    <br />
                    Please be patient!</h3>
                <br />
            </a>
            <div  class="progress progress-striped active span5">

                <div class="bar"
                     style="width: 100%;"></div>
            </div>
        </div>
        <div id="sidebar-toggle-container" class="container-fluid hide">
            <div class="row-fluid">
                <a href="#" class="btn" id="sidebar-toggle"><i class="icon-chevron-right"></i></a>
            </div>
        </div>
        <div class="clearfix">

        </div>

        <section class="container-fluid" style="margin-top: -50px;" id="dashboard">
            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert  <%=session.getAttribute("class")%> span12 center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>
            <!-- Headings & Paragraph Copy -->
            <div style="padding-right: 2%;" class="row-fluid">
                <%@include file="widgets/leftsidebar.jsp" %>
                <div style="display: none;" class="thumbnail main-c">

                    <table class="example display table-striped">
                        <thead>
                            <tr>
                                <th> Folder Number </th>
                                <th> Patient Name</th>
                                <th> Payment Type </th>
                                <th> Date of Birth</th>
                                <th> Registered On</th>

                                <th style="width: 15%"></th>

                                <!-- <th></th>  -->
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int r = 0; r < patients.size(); r++) {
                                    Patient patient = (Patient) patients.get(r);
                            %>
                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 20px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%=patient.getFname()%> <%=patient.getLname()%></h5> <h5><b> Date of Birth :</b>  <%=formatter.format(patient.getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=patient.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=patient.getEmployer()%> </td>  </tr> 
                                    </table> "> <% if(patient.getEmergencyPatient()==1){ %> 
                                                <%=patient.getPatientid()%>EMG 
                                                <% } else { %>
                                                <%=patient.getPatientid()%>
                                                <%} %>
                                                </td>

                                <td><%=patient.getFname()%> <%=patient.getMidname()%> <%=patient.getLname()%></td>
                                <td> <%=  mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(patient.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                <td> <%=formatter.format(patient.getDateofbirth())%> </td>

                                <td> <%=formatter.format(patient.getDateofregistration())%> </td>

                                <td>

                                    <form style="padding: 0px; margin: 0px;" class="form-horizontal" id="search_dialog" action="searchresults.jsp" method="post">
                                        <input type="hidden" name="searchid"  value="patientid" />
                                        <input type="hidden" placeholder="Please Enter Search Query" class="input-xlarge" value="<%=patient.getPatientid()%>"  name="searchquery"/>

                                        <!--   <button class="btn btn-danger btn-small">
   
                                               <i class="icon-arrow-right icon-white"></i> Start  Visit 
                                           </button>  -->

                                        <div class="btn-group">
                                            
                                            <button class="btn dropdown-toggle btn-danger btn-small" data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <button class="btn btn-danger btn-small">Start Visit</button>
                                            <ul class="dropdown-menu">
                                                <li> <a href="viewclinicpatient.jsp?patientid=<%=patient.getPatientid() %>"> View Details </a> </li>
                                                <li> <a href="updateclinicpatient.jsp?patientid=<%=patient.getPatientid() %>"> Update Details</a> </li>
                                                <li> <a href="printid.jsp?patientid=<%=patient.getPatientid() %>"> Print ID Card</a> </li>
                                            </ul>
                                        </div>
                                    </form>
                                </td>

                            </tr>
                            <%}%>
                        </tbody>
                    </table>

                </div>


                <div class="clearfix"></div>

            </div>

        </section>

        <footer style="display: none; margin-top: 50px;" class="footer">
            <p style="text-align: center" class="pull-right">
                <img src="images/logo.png" width="100px;" />
            </p>
        </footer>





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
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/jquery-ui-autocomplete.js"></script>
        <script src="js/jquery.select-to-autocomplete.min.js"></script>

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
        <script type="text/javascript" charset="utf-8" src="media/js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="media/js/TableTools.js"></script>

        <script type="text/javascript" src="js/demo.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript">
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();

                $(".menu").addClass("hide");
                $("#sidebar-toggle-container").fadeIn();
                $(".main-c").fadeIn();
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

        
            $(document).ready(function() {
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : 500,
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "aButtons": [
                            {
                                "sExtends": "print",
                                "sButtonText": "Print Table"
                            },
                            {
                                "sExtends": "pdf",
                                "sButtonText": "Export As Pdf"
                            },
                            {
                                "sExtends": "xls",
                                "sButtonText": "Export As Excel"
                            }
                        ]
                    }

                });
                
               
                
                $('#sidebar-toggle').click(function(e) {
                    e.preventDefault();
                    $('#sidebar-toggle i').toggleClass('icon-chevron-right icon-chevron-left');
                    $('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('hide span3');
                    $('.menu').toggleClass('span3');
                    $('.main-c').toggleClass('span8');
                
                });
                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
               
            });
               
        
            

        </script>

    </body>
</html>
