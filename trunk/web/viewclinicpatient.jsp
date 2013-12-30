<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat nice = new SimpleDateFormat("d MMM. yyyy");

    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
    SimpleDateFormat day = new SimpleDateFormat("dd");
    SimpleDateFormat month = new SimpleDateFormat("MM");
    SimpleDateFormat year = new SimpleDateFormat("yyyy");

%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
    String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");
    String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");

    Patient patient = null;
    List patientVisits = null;





    try {
        if (patientid != "") {
            patient = mgr.getPatientByID(patientid);

            if (patient == null) {
                session.setAttribute("lasterror", "Please Select a Patient");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("listpatients.jsp");
                return;
            }
        }


    } catch (NullPointerException e) {
        session.setAttribute("lasterror", "Please Select a Patient");
        session.setAttribute("class", "alert");
        response.sendRedirect("records.jsp");
        return;
    }


    patientVisits = mgr.listPatientVisits(patient.getPatientid());

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body style="overflow-y: scroll;" data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="records.jsp">Records </a><span class="divider"></span>
                        </li>

                        <li class="active">
                           <a href="#"> Contact Details For <% if (patient.getEmergencyPatient() == 1) {%> 
                                <%=patient.getPatientid()%>EMG 
                                <% } else {%>
                                <%=patient.getPatientid()%>
                                <%}%>  </a><span class="divider"></span>
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

            <%if (patient != null) {%>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <div class="row-fluid">
                    <div style="padding-left: 4%; display: none;" class="span3 profile">

                        <div class="thumbnail">

                            <div class="center" style="width: 100%; padding-top: 5%">
                                <% if (patient.getGender().equalsIgnoreCase("Male")) {%>


                                <img src="img/default-facebook-avatar-male.gif"  />


                                <% } else {%>

                                <img src="img/default-facebook-avatar-female.gif"  />

                                <% }%>
                            </div>

                            <dl>
                                <dd style=" font-size: 15px; text-align: center; text-transform: uppercase"><%= patient.getFname()%> <%if (patient.getMidname() != null) {%> <%= patient.getMidname()%> <% }%> <%= patient.getLname()%></dt>


                                <dd style=" font-size: 15px; text-align: center; text-transform: uppercase;  "><a href="#"> <% if (patient.getEmergencyPatient() == 1) {%> 
                                        <%=patient.getPatientid()%>EMG 
                                        <% } else {%>
                                        <%=patient.getPatientid()%>
                                        <%}%> </a> </dt>

                            </dl>
                            <div class="clearfix">

                            </div>
                            <dl class="dl-horizontal">
                                <dt style="text-align: left; padding-left: 5%;">AGE</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getAgeDifference(format.format(patient.getDateofbirth()))%> YRS</dd>


                                <dt style="text-align: left; padding-left: 5%;">BIRTHDAY</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= nice.format(patient.getDateofbirth())%></dd>


                                <dt style="text-align: left; padding-left: 5%;">GENDER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= patient.getGender()%></dd>


                                <dt style="text-align: left; padding-left: 5%;">MARITAL STATUS</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= patient.getMaritalstatus()%></dd>

                                <dt style="text-align: left; padding-left: 5%;">NATIONALITY</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= patient.getCountry()%></dd>
                            </dl>
                            
                                <a style="width: 50%; margin-left: 22%;" href="updateclinicpatient.jsp?patientid=<%=patient.getPatientid()%>" class="btn btn-small">
                                        <i class="icon-edit"></i> Update Details
                                    </a>
                               
                        </div>


                        <div class="clearfix"></div>

                        

                        <div style="margin-bottom: 2%; width: 95%; float: left;  height: 150px;" class="thumbnail">
                            <ul style="padding: 3px; padding-left: 8px;" class="breadcrumb">

                                <li>
                                    <span  class="lead" style="font-size: 15px;"> <img src="img/glyphicons/png/glyphicons_227_usd.png"/> Billing Information </span>
                                </li>

                            </ul>

                            <dl class="dl-horizontal">

                                <% if (mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("Private")) {%>  
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>

                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%></dd>

                                <% }%>



                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getMembershipid()%></dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">BENEFIT PLAN</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getBenefitplan()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("Cooperate")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>
                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%></dd>

                                <% }%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">COMPANY ID</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getMembershipid()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("NHIS")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%> </dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getMembershipid()%></dd>



                                <% } else {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">PRIMARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%=mgr.sponsorshipDetails(patient.getPatientid()) == null ? mgr.sponsorshipDetails(patient.getPatientid()).getType() : mgr.sponsorshipDetails(patient.getPatientid()).getType()%></dd>



                                <% }%>






                                <% if (mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("Private")) {%>  
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname()%></dd>

                                <% }%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryMembership()%></dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">BENEFIT PLAN</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryBenefitplan()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("Cooperate")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <% if (mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname().length() > 15) {%>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname().substring(0, 15)%></dd>

                                <% } else {%>

                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname()%></dd>

                                <% }%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">COMPANY ID</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryMembership()%> </dd>


                                <% } else if (mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("NHIS")) {%>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSecondarySponsor()).getSponsorname()%> </dd>

                                <dt style="text-align: left; padding-left: 5%; width: 180px;">MEMBERSHIP NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%= mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryMembership()%></dd>



                                <% } else {%>

                                <% if (!mgr.sponsorshipDetails(patient.getPatientid()).getType().equals("CASH")) {%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">SECONDARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><%=mgr.sponsorshipDetails(patient.getPatientid()) == null ? mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType() : mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType()%></dd>

                                <% }
                                    }%>

                                <% if (!mgr.sponsorshipDetails(patient.getPatientid()).getSecondaryType().equals("CASH")) {%>
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">TERTIARY SPONSOR</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%">CASH</dd>



                                <% }%>



                            </dl>
                        </div>
                    </div>

                    <div style="display: none; " class="span8 main-c">

                        <div style="margin-bottom: 2%; width: 95%; float: left; margin-left: 1%; height: 150px;" class="thumbnail">
                            <ul style="padding: 3px; padding-left: 8px;" class="breadcrumb">

                                <li>
                                    <span  class="lead" style="font-size: 15px;"> <img src="img/glyphicons/png/glyphicons_264_vcard.png"/> Contact Information </span>
                                </li>
                                

                            </ul>

                            <dl class="dl-horizontal">
                                <dt style="text-align: left; padding-left: 5%; width: 200px;">PHONE NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getContact() != null) {%> <%= patient.getContact()%> <% }%></dd>


                                <dt style="text-align: left; padding-left: 5%; width: 200px;">OTHER PHONE NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getSecondContact() != null) {%> <%= patient.getSecondContact()%> <% }%></dd>


                                <dt style="text-align: left; padding-left: 5%; width: 200px;">PHYSICAL ADDRESS</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getAddress() != null) {%> <%= patient.getAddress()%> <% }%></dd>


                                <dt style="text-align: left; padding-left: 5%;width: 200px;">EMAIL ADDRESS</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getEmail() != null) {%> <%= patient.getEmail()%> <% }%></dd>

                                <dt style="text-align: left; padding-left: 5%; width: 200px;">OCCUPATION</dt>
                                <dd style="text-transform: uppercase; padding-left: 5%"><% if (patient.getOccupation() != null) {%> <%= patient.getOccupation()%> <% }%></dd>
                            </dl>
                        </div>

                        <div style="margin-bottom: 2%; width: 95%; float: left; margin-left: 1%; height: 150px;" class="thumbnail">
                            <ul style="padding: 3px; padding-left: 8px;" class="breadcrumb">

                                <li>
                                    <span  class="lead" style="font-size: 15px;"> <img src="img/glyphicons/png/glyphicons_006_user_add.png"/> Emergency Contact Information  </span>
                                </li>

                            </ul>

                            <dl class="dl-horizontal">
                                <dt style="text-align: left; padding-left: 5%; width: 180px;">EMERGENCY CONTACT</dt>
                                <dd style="text-transform: uppercase; padding-left: 0px;"><% if (patient.getEmergencyperson() != null) {%> <%= patient.getEmergencyperson()%> <% }%></dd>


                                <dt style="text-align: left; padding-left: 5%; width: 180px;">EMERGENCY NUMBER</dt>
                                <dd style="text-transform: uppercase; padding-left: 0px;"><% if (patient.getEmergencycontact() != null) {%> <%= patient.getEmergencycontact()%> <% }%></dd>



                            </dl>
                        </div>



                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>
        </div>



        <%}


        %>


        <!--end static dialog-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltipatient.js"></script>

        <script src="js/application.js"></script>
        <script src="js/jquery.validate.min.js"></script>

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

                menu_ul.hide();

                $(".menu").fadeIn();
                $(".alert").fadeIn();
                $(".main-c").fadeIn();
                $("#sidebar-toggle-container").fadeIn();
                $(".profile").fadeIn();
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
                
                $("input:checkbox").attr("checked", false);
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true

                });
                    
                    
                $('#sidebar-toggle').click(function(e) {
                    e.preventDefault();
                    $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                    $('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('span3 hide');
                    $('.main-c').toggleClass('span8');
                
                });

                   

                   
            
                

            });
        </script>




    </body>
</html>
