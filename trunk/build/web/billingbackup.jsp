<%-- 
    Document   : accounts
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : ClaimSync
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> list = (ArrayList<Integer>) session.getAttribute("staffPermission");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            /*  List medbillpatients = mgr.listUnitVisitations("account");
             List dispensingpatients = mgr.listPharmordersByStatus("Account");
             List procedurepatients = mgr.listPatientProcedures("Cashier");
             List outstandingbills = mgr.listDebtors(); */


            //   Visitationtable visit = (Visitationtable) visits.get(i);
            double registrationFee = 0;
            List medicalbills = mgr.listUnitVisitations("account");
            List dispensingbills = mgr.listPharmordersByStatus("Approved");
            List procedurebills = mgr.listPatientProcedures("Cashier");
            List outstandingpayments = mgr.listDebtors();
            List treatments = null;
        %>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">

                    <li class="active">
                        <a href="#">Billing</a><span class="divider"></span>
                    </li>


                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%>  center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>
            <br/>
            <div class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>

            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span8 thumbnail main-c">
                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs-1">Medical Bills <span class="badge badge-inverse"><%= medicalbills.size() %></span> </a></li>
                            <li><a href="#tabs-2">Dispensing Bills <span class="badge badge-inverse"><%= dispensingbills.size() %></span></a></li>
                            <li><a href="#tabs-3">Procedure Bills <span class="badge badge-inverse"><%= procedurebills.size() %></span></a></li>
                            <li><a href="#tabs-4">Outstanding Bills <span class="badge badge-inverse"><%= outstandingpayments.size() %></span></a></li>
                        </ul>
                        <div id="tabs-1">
                            <table style="width: 100%" class="example display table-striped">
                                <thead>
                                    <tr>
                                        <th style="font-size: 12px;"> Folder Number</th>
                                        <th style="font-size: 12px;"> Patient Name </th>
                                        <th style="font-size: 12px;"> Payment Type </th>
                                        <th style="font-size: 12px;"> Date of Birth  </th>
                                        <th style="font-size: 12px;"> Requested On </th>
                                        <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <% for (int x = 0; x < medicalbills.size(); x++) {
                                            Visitationtable vst = (Visitationtable) medicalbills.get(x);
                                    %>

                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                        <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                        <td><%=formatter.format(vst.getDate())%> </td>

                                        <td>
                                            <a href="processmedicalbill.jsp?visitid=<%=vst.getVisitid()%>" class="btn btn-info btn-small" style="color: #fff;">
                                                Process Payment
                                            </a></td>
                                    </tr>
                                    <% }%>
                                </tbody>

                            </table>


                        </div>
                        <div id="tabs-2">
                            <table style="width: 100%" class="example display table-striped">
                                <thead>
                                    <tr>
                                        <th style="font-size: 12px;"> Folder Number</th>
                                        <th style="font-size: 12px;"> Patient Name </th>
                                        <th style="font-size: 12px;"> Payment Type </th>
                                        <th style="font-size: 12px;"> Date of Birth  </th>
                                        <th style="font-size: 12px;"> Requested On </th>
                                        <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int x = 0; x < dispensingbills.size(); x++) {
                                            Pharmorder vst = (Pharmorder) dispensingbills.get(x);
                                    %>

                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                        <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                        <td><%=formatter.format(vst.getOrderdate() )%> </td>

                                        <td>
                                            <a href="processdispensingbill.jsp?orderid=<%=vst.getOrderid() %>" class="btn btn-info btn-small" style="color: #fff;">
                                                Process Payment
                                            </a></td>
                                    </tr>
                                    <% }%>
                                </tbody>

                            </table>


                        </div>
                        <div id="tabs-3">
                            <table style="width: 100%" class="example display table-striped">
                                <thead>
                                    <tr>
                                        <th style="font-size: 12px;"> Folder Number</th>
                                        <th style="font-size: 12px;"> Patient Name </th>
                                        <th style="font-size: 12px;"> Payment Type </th>
                                        <th style="font-size: 12px;"> Date of Birth  </th>
                                        <th style="font-size: 12px;"> Requested On </th>
                                        <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int x = 0; x < procedurebills.size(); x++) {
                                            Procedureorders vst = (Procedureorders) procedurebills.get(x);
                                    %>

                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                        <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                        <td><%=formatter.format(vst.getOrderdate())%> </td>

                                        <td>
                                            <a href="processprocedurebill.jsp?orderid=<%=vst.getOrderid() %>" class="btn btn-info btn-small" style="color: #fff;">
                                                Process Payment
                                            </a></td>
                                    </tr>
                                    <% }%>
                                </tbody>

                            </table>
                        </div>
                        <div id="tabs-4">
                            <table style="width: 100%" class="example display table-striped">
                                <thead>
                                    <tr>
                                        <th style="font-size: 12px;"> Folder Number</th>
                                        <th style="font-size: 12px;"> Patient Name </th>
                                        <th style="font-size: 12px;"> Payment Type </th>
                                        <th style="font-size: 12px;"> Date of Birth  </th>
                                        <th style="font-size: 12px;"> Requested On </th>
                                        <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int x = 0; x < outstandingbills.size(); x++) {
                                            PatientBills vst = (PatientBills) outstandingbills.get(x);
                                    %>

                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                        <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                        <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                        <td> </td>

                                        <td>
                                            <a href="processoutstandingbill.jsp?patientid=<%=vst.getPatientid()%>?visitid=<%=vst.getVisitid()%>" class="btn btn-info btn-small" style="color: #fff;">
                                                Process Payment
                                            </a></td>
                                    </tr>
                                    <% }%>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>

            </div>


        </section>

    </body>
    <%@include file="widgets/javascripts.jsp" %>
</html>
