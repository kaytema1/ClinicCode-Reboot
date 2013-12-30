<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Formatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("index.jsp");


    }%>

<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
    Date date = new Date();
    // List visits = mgr.listUnitVisitations("pharmacy", dateFormat.format(date));
    List visits = mgr.listPharmordersByStatus("Not Done");
    List treatments = null;

%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li >
                            <a href="#">Dispensary</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Prescription Orders</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>



                <div class="row-fluid">


                    <%@include file="widgets/leftsidebar.jsp" %>



                    <div style="display: none;" class="span8 thumbnail main-c">

                        <table class="example display table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;"> Folder Number</th>
                                    <th style="text-align: left;"> Patient Name </th>
                                    <th style="text-align: left;"> Payment Type </th>
                                    <th style="text-align: left;"> Date of Birth  </th>
                                    <th style="text-align: left;"> Requested On </th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (visits != null) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            Pharmorder vst = (Pharmorder) visits.get(i);
                                %>
                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                    <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>

                                    <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  </td>
                                    <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                    <td><%= formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                    <td><%=formatter.format(vst.getOrderdate())%> </td>

                                    <td>
                                        <a href="approveprescriptionorder.jsp?orderid=<%=vst.getOrderid() %>" class="btn btn-info btn-small" id="<%=vst.getPatientid()%>_link">
                                            <i class="icon-white icon-check"></i> Approve Dispensing
                                        </a>
                                    </td>
                                </tr>
                                <%}
                                    }%> 

                            </tbody>
                        </table>

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
<%@include file="widgets/javascripts.jsp" %>

</body>
</html>
