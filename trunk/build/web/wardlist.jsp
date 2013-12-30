<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="entities.ExtendedHMSHelper"%>

<%@page import="java.util.TreeMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    Visitationtable visit = null;
    HMSHelper itm = new HMSHelper();
    String type = request.getParameter("type");
    List visits = mgr.listUnitVisitations(request.getParameter("type"));
    String array[] = type.split("_");
    String wardid = array[1];
    int wardId  = Integer.parseInt(wardid);
    Ward myward = mgr.getWardById(wardId);
    
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>


    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">
        <%@include file="widgets/header.jsp" %>
        <div class="container-fluid">
            <header class="jumbotron subhead" id="overview">
                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="#">Ward</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">In Patient Care | <%= myward.getWardname() %></a><span class="divider"></span>
                        </li>
                    </ul>
                </div>
            </header>

            <%@include file="widgets/loading.jsp" %>
            <section style="margin-top: -50px;" class="container-fluid" id="dashboard"> 
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <div class="row-fluid">
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="thumbnail main-c span8">
                        <table cellpadding="0" cellspacing="0" border="0" class="table-striped example display ">
                            <thead>
                                <tr>
                                    <th>Folder Number </th>
                                    <th>Full Name </th>
                                    <th>Date of Birth </th>
                                    <th>Payment Type </th>
                                    <th>Admission On</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                                    SimpleDateFormat formatter1 = new SimpleDateFormat("EEEE, dd MMMM, yyyy");

                                    List investigations = null;
                                    List nhisinvestigations = null;
                                    List treatments = null;
                                    List nhistreatments = null;
                                    List dosages = null;
                                    Date date = new Date();



                                    if (visits.size() > 0) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            visit = (Visitationtable) visits.get(i);
                                            // vs = mgr.currentVisitations(visit.getVisitid());
%>
                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getGender()%></td> </tr> <tr> <td> Employer </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td>
                                        <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>">
                                        <a style="text-transform: uppercase;" class="patientid"><%= visit.getPatientid()%> </a> 
                                    </td>
                                    <td>
                                        <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>
                                    </td>
                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>
                                    </td>
                                    <td>
                                        <%= mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>
                                    </td>
                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofregistration())%>
                                    </td>
                                    <td>
                                        <a href="inpatientconsultation.jsp?visitid=<%= visit.getVisitid() %>"  class="btn btn-info"> <i class="icon-pencil icon-white"> </i> Patient Care </a>
                                    </td>
                                </tr>
                                <% }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div> 
            </section>
        </div>
        <%@include file="widgets/footer.jsp" %>

        <%@include file="widgets/javascripts.jsp" %>


        <div class="clear"></div>


    </body>
</html>

