<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    Visitationtable visit;

    List allergies = null;
    List medical_histories = null;
    List social_histories = null;
    List duration_options = null;

    List patient_allergies = null;
    List patient_medical_histories = null;
    List patient_family_histories = null;
    List patient_social_histories = null;




%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>


        <header  class="jumbotron subhead" id="overview">
            <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">
                    <!--<li>
                        <a href="#">Records</a><span class="divider"></span>
                    </li>-->
                    <li class="active">
                        <a href="#">Nurses Station</a><span class="divider"></span>
                    </li>
                </ul>
            </div>
        </header>
        <%@include file="widgets/loading.jsp" %>
        <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%> row-fluid center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <%session.removeAttribute("lasterror");
                }%>
            <!-- Headings & Paragraph Copy -->
            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>
                <div style="display: none;" class="span8 main-c thumbnail  content">
                    <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                        <thead>
                            <tr>
                                <th style="text-align: left;">Folder Number </th>
                                <th style="text-align: left;">Patient Name </th>
                                <th style="text-align: left;">Payment Type</th>
                                <th style="text-align: left;">Date of Birth</th>

                                <th style="text-align: left;">Registered On</th>
                                <th> </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // investigations = mgr.listInvestigation();
                                allergies = mgr.listAllergiess();

                                medical_histories = mgr.listMedicalHistoryOptions();
                                social_histories = mgr.listSocialHistoryOptions();
                                //duration_options = mgr.listDurationOptions();
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                //Patient p = (Patient)session.getAttribute("patient");
                                //get current date time with Date()
                                SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                                Date date = new Date();
                                //System.out.println(dateFormat.format(date));
                                List visits = mgr.listUnitVisitations("vitals");
                                // List patients = mgr.listPatients();
                                for (int i = 0; i < visits.size(); i++) {
                                    visit = (Visitationtable) visits.get(i);


                            %>

                            <tr>
                                <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px; color: #4183C4;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>  </h5> <span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getBenefitplan()%> </td> </tr>  </table> ">
                                    <% if(mgr.getPatientByID(visit.getPatientid()).getEmergencyPatient()==1){ %> 
                                                <%=mgr.getPatientByID(visit.getPatientid()).getPatientid()%>EMG 
                                                <% } else { %>
                                                <%=mgr.getPatientByID(visit.getPatientid()).getPatientid()%>
                                                <%} %> 
                                </td>
                                <td>
                                    <%=mgr.getPatientByID(visit.getPatientid()).getFname()%> <%=mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()).getLname()%>
                                </td>
                                <td>
                                    <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> 
                                </td>
                                <td>
                                    <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>
                                </td>

                                <td>
                                    <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofregistration())%>
                                </td>

                                <td>
                                    <a href="opdentry.jsp?visitid=<%=visit.getVisitid()%>" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>link"  class="visitlink btn btn-info btn-small"> <i class="icon-pencil icon-white"> </i> Save Vitals </a>
                                </td>
                            </tr>
                            <% }

                            %>
                        </tbody>
                    </table>
                </div> 

                <div class="clear"></div>
            </div>

        </section>

        <%@include file="widgets/footer.jsp" %>





    </body>

    <%@include file="widgets/javascripts.jsp" %>





</html>