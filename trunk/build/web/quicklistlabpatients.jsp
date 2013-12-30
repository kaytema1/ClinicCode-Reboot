<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            HMSHelper mgr = new HMSHelper();
            ArrayList<Integer> list = (ArrayList<Integer>) session.getAttribute("staffPermission");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            List patients = mgr.listLabPatients();
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
            //LabPatient patient = mgr.getLabPatientByID(patientid);
        %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <%@include file="widgets/header.jsp" %> 

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="labreception.jsp">Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">All Laboratory Patients</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert  <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px; " class="span9 thumbnail well content">
                            <!--        <ul style="margin-left: 0px;" class="breadcrumb">
                                        <li style=" font-size: 14px; font-weight: bold">
                                            <a>All LabPatients</a>
                                        </li>
                                    </ul>  -->
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th> Patient Number </th>
                                        <th> Patient Name</th>
                                        <th> Payment Type </th>
                                        <th> Date of Birth</th>
                                        <th> Registered On</th>
                                        
                                        <th></th>
                                        <!-- <th></th>  -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int r = 0; r < patients.size(); r++) {


                                            LabPatient patient = (LabPatient) patients.get(r);
                                    %>
                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Lab Patient Information Summary </h3> <h5> <%=patient.getFname()%> <%=patient.getLname()%></h5> <h5><b> Date of Birth :</b>  <%=formatter.format(patient.getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=patient.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=patient.getEmployer()%> </td>  </tr> 
                                            </table> "> <%=patient.getPatientid()%> </td>

                                        <td><%=patient.getFname()%> <%=patient.getMidname()%> <%=patient.getLname()%></td>
                                        <td> <%=  mgr.sponsorshipDetails(patient.getPatientid()) == null ? mgr.sponsorshipDetails(patient.getFolderNumber()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getType()%></td>

                                        <td> <%=formatter.format(patient.getDateofbirth())%> </td>



                                        <td> <%=formatter.format(patient.getDateofregistration())%> </td>
                                       
                                        <td>
                                            <form style="padding: 0px; margin: 0px;" class="form-horizontal" id="search_dialog" action="labpatientsearch.jsp" method="post">
                                                <input type="hidden" name="searchid"  value="patientid" />
                                                <input type="hidden" placeholder="Please Enter Search Query" class="input-xlarge" value="<%=patient.getPatientid()%>"  name="searchquery"/>
                                                <button class="btn btn-danger btn-small">
                                                    <%if (permissions.contains(6)) {%>
                                                    <i class="icon-arrow-right icon-white"></i> Start Visit 
                                                    <%}%>
                                                </button>
                                            </form>
                                        </td>

                                    </tr>
                                    <%

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
                
                for (i = new Date().getFullYear(); i > 1900; i--)
                {                       
                    $('#year').append($('<option />').val(i).html(i));
                }

            });

        </script>

        <script type="text/javascript" charset="utf-8">
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
                
                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
               
           
            });
        
            

        </script>


        
    </body>
</html>
