
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%@page import="java.util.Calendar"%>
        <%@page import="java.util.Locale"%>
        <%
            HMSHelper mgr = new HMSHelper();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            List scheduledApps = mgr.listScheduledAppointments(0);
            String staffName = "";
            Date now = new Date();



            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            //Patient patient = mgr.getPatientByID(patientid);

            Stafftable loggedInStaff = mgr.getStafftableByid(user.getStaffid());

            if (loggedInStaff != null) {
                staffName = loggedInStaff.getLastname() + " " + loggedInStaff.getOthername();
            }

        %>

        <%@include file="widgets/stylesheets.jsp" %>


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
                            <a href="#">Appointments</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Booked Appointments</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section  class="container-fluid" style="margin-top: -50px; padding-left: 0px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="padding-bottom: 80px; display: none; " class="span8 thumbnail main-c">

                        <table class="example display">
                            <thead>
                                <tr>

                                    <th style="text-align: left;"> Folder Number</th>
                                    <th style="text-align: left;"> Patient Name </th>
                                    <th style="text-align: left;"> Appointment Date </th>
                                    <th style="text-align: left;"> From </th>
                                    <th style="text-align: left;"> To</th>

                                    <th></th>
                                    <th></th>
                                    <th></th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Appoint app;
                                    Patient p;
                                    for (int r = 0; r < scheduledApps.size(); r++) {
                                        app = (Appoint) scheduledApps.get(r);
                                        if (app != null) {
                                            // Note, MM is months, not mm
                                            
                                
                                           
                                            p = mgr.getPatientByID(app.getPatientId());
                                            if (p != null) {
                                                /* Date today = new Date();
                                                
                                                String dateStr = app.getStart();
                                                DateFormat newformatter = new SimpleDateFormat("E MMM dd HH:mm:ss Z yyyy");
                                                Date date = (Date) newformatter.parse(dateStr);
                                                System.out.println(date);
                                                
                                                Calendar cal = Calendar.getInstance();
                                                cal.setTime(date);
                                                String formatedDate = cal.get(Calendar.DATE) + "/" + (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.YEAR);
                                                 */



                                %>
                                <tr>
                                    <td style="text-align: left; font-weight:  bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td>
                                        <%=  mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>">
                                        <a style="text-transform: uppercase; font-weight: bold;" class="patientid"><%= p.getPatientid()%></a>
                                    </td>

                                    <td><%=p.getFname()%> <%=p.getMidname()%> <%=p.getLname()%></td>
                                    <td style="text-align: left;"><%=app.getStart().substring(0, 15)%> </td>
                                    <td style="text-align: left;"><%=app.getStart().substring(15, 21)%></td>
                                    <td style="text-align: left;"><%=app.getEnd().substring(15, 21)%></td>



                                    <td>
                                        <form style="margin: 0px;" action="searchresults.jsp" method="post">
                                            <button class="btn btn-info btn-small">
                                                Honor
                                            </button>
                                            <input type="hidden" name="searchid" value="patientid"/>
                                            <input type="hidden" name="searchquery" value="<%=p.getPatientid()%>"/>
                                            <input type="hidden" name="appPatient" value="<%=app.getId()%>"/>
                                        </form>
                                    </td>
                                    <td style=" margin-top: 0px;">
                                        <a href="appointment.jsp" class="btn btn-inverse btn-small">  Update </a>
                                    </td>
                                    <td style=" margin-top: 0px;">
                                        <form style="margin: 0px;" action="action/deleteappointmentaction.jsp" method="post">
                                            <input type="hidden" name="searchquery" value="<%=p.getPatientid()%>"/>
                                            <input type="hidden" name="appPatient" value="<%=app.getId()%>"/>

                                            <button type="submit" name="action" value="deleteappointment" class="btn btn-danger btn-small">
                                                Cancel

                                            </button>
                                        </form>
                                    </td>

                                </tr>
                                <%}
                                        }

                                    }%>
                            </tbody>
                        </table>

                    </div>


                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

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

                // menu_ul.hide();

                $(".menu").fadeIn();
                $(".main-c").fadeIn();
                $("#sidebar-toggle-container").fadeIn();
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
                    "sScrollY" : 400,
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
                    $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                    $('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('span3 hide');
                    $('.main-c').toggleClass('span8');
                
                });

                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });

            });
        
            function showMembershipbox(){
                var show = document.getElementById("privateid");
                var shows = document.getElementById("nhis");
               
                show.style.display="block";
                shows.style.display="none";
                
            }
            function showInsurance(){
                var show = document.getElementById("nhis");
                var shows = document.getElementById("privateid");
               
                show.style.display="block";
                shows.style.display="none";
                
            }
            function hideIt(){
                var show = document.getElementById("privateid");
                var shows = document.getElementById("nhis");
                //if(show.style.display == "block"){
                show.style.display="none";
                //}else{
                
                //  } if(show.style.display == "none"){ 
                shows.style.display="none";
            }
            
            function showConType(id){
                var show = document.getElementById(id);
                //var shows = document.getElementById("nhis");
                //if(show.style.display == "block"){
                show.style.display="block";
                //}else{
                
                //  } if(show.style.display == "none"){ 
                // shows.style.display="none";
            }

        </script>
        <% for (int i = 0; i < scheduledApps.size(); i++) {
                Appoint vst = (Appoint) scheduledApps.get(i);
        %>


        <script type="text/javascript">
   
                      
            $("#<%= vst.getId()%>_dialog").dialog({
                autoOpen : false,
                width : 850,
                modal :true

            });
            
            $("#<%= vst.getId()%>_dialog2").dialog({
                autoOpen : false,
                width : 850,
                modal :true

            });
    
            $("#<%= vst.getId()%>_adddrug_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
    
   
    
            $("#<%=vst.getId()%>_link").click(function(){
      
                $("#<%=vst.getId()%>_dialog").dialog('open');
    
            })
            
            $("#<%=vst.getId()%>_link2").click(function(){
      
                $("#<%=vst.getId()%>_dialog2").dialog('open');
    
            })
  
    
            $("#<%= vst.getId()%>_adddrug_link").click(function(){
                alert("");
                $("#<%=vst.getId()%>_adddrug_dialog").dialog('open');
        
            })
   
    
        </script>



        <% }%>
    </body>
</html>
