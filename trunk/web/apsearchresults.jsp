<!DOCTYPE html>
<html lang="en">
    <head>

        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <% Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }

            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        %> 
        <%
            HMSHelper mgr = new HMSHelper();
            String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
            String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");

            Patient p = null;
            List list = null;

            try {
                if (searchid.equalsIgnoreCase("memberdshipnumber")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    // Sponsorhipdetails spd = mgr.getSearchedSpID(searchquery.trim());
                    List l = mgr.getSearchedSpID(searchquery.trim());
                    Sponsorhipdetails spd = (Sponsorhipdetails) l.get(0);

                    p = (Patient) mgr.getPatientByID(spd.getPatientid());

                }
                if (searchid.equalsIgnoreCase("fullname")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    list = mgr.getPatientByName(searchquery);


                }
                if (searchid.equalsIgnoreCase("patientid")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    p = mgr.getPatientByID(searchquery.trim());

                }
                if (searchid.equalsIgnoreCase("dob")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    System.out.println(searchquery);

                    list = mgr.listPatientByDob(searchquery);
                    System.out.println("here " + list.size());

                }
            } catch (ArrayIndexOutOfBoundsException e) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            } catch (NullPointerException e) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }


        %>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <meta charset="utf-8"/>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="records.jsp">Appointments</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Patient Search Results</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <%if (p != null) {%>
            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/leftsidebar.jsp" %>


                    <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">

                        <%if (session.getAttribute("lasterror") != null) {%>
                        <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                            <b> <%=session.getAttribute("lasterror")%>  </b>
                        </div>
                        <br/>
                        <div style="margin-bottom: 20px;" class="clearfix"></div>
                        <%session.removeAttribute("lasterror");
                            }%>

                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Folder Number </th>
                                    <th style="text-align: left;">Patient Name </th>

                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Registered On</th>

                                    <th><!--Appointment Type--></th>

                                </tr>
                            </thead>
                            <tbody>

                                <tr class="odd gradeX">

                                    <td style="font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td>
                                        <%=  mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>">
                                        <a style="text-transform: uppercase; font-weight: bold;" class="patientid"><%= p.getPatientid()%></a>
                                    </td>
                                    <td><%= p.getFname()%> 

                                        <% if (p.getMidname() != null) {%>
                                        <%= p.getMidname()%>
                                        <% }%>

                                        <%= p.getLname()%> </td>

                                    <td><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                    <td>  <%= formatter.format(p.getDateofbirth())%> </td>
                                    <td>  <%= formatter.format(p.getDateofregistration())%> </td>

                                    <td>
                                        <a class="btn btn-info btn-small appointment_link<%=p.getPatientid()%>" href="appointment.jsp?patientId=<%=p.getPatientid()%>"><i class="icon-white icon-pencil"></i> New Appointment </a>
                                    </td>
                                </tr>

                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



        <%} else if (list != null) {%>
        <section style="margin-top: -30px;" id="dashboard">

            <!-- Headings & Paragraph Copy -->
            <div class="row">
                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">



                    <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                        <thead>
                            <tr>
                                <th style="text-align: left;">Folder Number </th>
                                <th style="text-align: left;">Patient Name </th>
                                <th style="text-align: left;">Payment Type</th>
                                <th style="text-align: left;">Date of Birth</th>
                                <th style="text-align: left;">Registered On</th>

                                <th></th>

                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < list.size(); i++) {
                                    Patient pp = (Patient) list.get(i);
                                    System.out.println("test " + list.size());
                            %>
                            <tr class="odd gradeX">
                                <td style="font-size: 18px; font-weight: bolder" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= pp.getFname()%>, <%= pp.getLname()%> <%= pp.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(pp.getDateofbirth())%></h5> <span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= pp.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= pp.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                    </table>"><a class="patientid"><%= pp.getPatientid()%></a>
                                </td>
                                <td><b><%= pp.getFname()%>  <%= pp.getMidname()%> <%= pp.getLname()%> </b></td>
                                <td><%= mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                <td><%= formatter.format(pp.getDateofbirth())%> </td>
                                <td>
                                    <%= formatter.format(pp.getDateofregistration())%>

                                </td>
                                <td>
                                     <a class="btn btn-info btn-small appointment_link<%=pp.getPatientid()%>" href="appointment.jsp?patientId=<%=pp.getPatientid()%>"><i class="icon-white icon-pencil"></i> New Appointment </a>
                               
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>

                </div>
                <div class="clearfix"></div>

            </div>

        </section>

        <%@include file="widgets/footer.jsp" %>

        <%

        } else {

        %>

        <br/> 

        <div class="alert hide alert-info container center">
            <b> No Results Found!  </b>
        </div>
        <br/>
        <div class="container-fluid center">


            <img id="bgimage"  class="center hide" width="40%" src="images/logoonly.png" />

        </div> 


        <%        }
        %>

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
        <script type="text/javascript" src="js/demo.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript">
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                // menu_ul.hide();

                $(".menu").fadeIn();
                $(".alert").fadeIn();
                $(".content1").fadeIn();
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

        </script>
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8">
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

                $(".patient_visit").popover({

                    placement : 'top',
                    animation : true

                });

            });
            
            function showConType(id){
                var show = document.getElementById(id);
                //var shows = document.getElementById("nhis");
                //if(show.style.display == "block"){
                show.style.display="block";
                //}else{
                
                //  } if(show.style.display == "none"){ 
                // shows.style.display="none";
            }

            function getContype(){
                var show = document.getElementById("ty").value
                document.getElementById("contype").value = show;
                var t = document.getElementById("contype").value;
            
            
                //alert(t);
            }
            function getType(i,d){
                var show = document.getElementById(i).value
                document.getElementById(d).value = show;
                var t = document.getElementById("contype").value;
            
            
            }
        
        
        
        
        
        
           
        
        
        </script>



    </body>
</html>
