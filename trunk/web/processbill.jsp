<%-- 
    Document   : accounts
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : ClaimSync
--%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
                        <a href="#">Current Bills</a><span class="divider"></span>
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
                    <table style="width: 100%" class="example display table-striped ">
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
                            <%    for (String patientid : combinedList) {%>

                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(patientid).getFname()%> <%=mgr.getPatientByID(patientid).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(patientid).getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(patientid).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(patientid).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()) == null ? mgr.sponsorshipDetails(patientid).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(patientid).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(patientid).getBenefitplan()%> </td> </tr>  </table> "> <%=patientid%>   </td>
                                <td><%=mgr.getPatientByID(patientid).getFname()%> <%=mgr.getPatientByID(patientid).getMidname()%> <%=mgr.getPatientByID(patientid).getLname()%></td>
                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()) == null ? mgr.sponsorshipDetails(patientid).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()).getSponsorname()%> </td>

                                <td><%=formatter.format(mgr.getPatientByID(patientid).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(patientid).getMembershipid()%>   </td>  -->

                                <td><%=formatter.format(new Date())%> </td>

                                <td>
                                    <a id="<%= patientid%>_patientidlink"  class="btn btn-info btn-small" style="color: #fff;">
                                        Process Payment
                                    </a>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>

                    </table>
                </div>
            </div>
        </section>

        <%  for (String patientid : combinedList) {%> 
        <div class="dialog" style="display: none; " id="<%=patientid%>_dialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%; text-transform: uppercase;'> CURRENT BILL FOR | <%= mgr.getPatientByID(patientid).getFname()%> <%= mgr.getPatientByID(patientid).getLname()%>  |  <%= mgr.getPatientByID(patientid).getPatientid()%> </span>">
            <span class="span4">
                <dl class="dl-horizontal">


                    <dt style="text-align: left;" >Patient ID:</dt>
                    <dd style="text-transform: uppercase;"><%= patientid%></dd>
                    <dt style="text-align: left;" >Patient Name:</dt>
                    <dd><%= mgr.getPatientByID(patientid).getFname()%>
                        <%= mgr.getPatientByID(patientid).getMidname()%>
                        <%= mgr.getPatientByID(patientid).getLname()%>
                    </dd>
                    <dt style="text-align: left;" >Sponsor:</dt>
                    <dd><%=mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()) == null ? mgr.sponsorshipDetails(patientid).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()).getSponsorname()%></dd>
                </dl>
            </span>
            <div class="clearfix">
            </div>    
            <div class="center">
                <span style="font-weight: bolder;" class="lead">CURRENT BILL SUMMARY</span>
                <br />
                <br />
                <%
                    List patientmedicalbills = mgr.listUnitVisitationsByPatient("account", patientid);
                    List patientdispensingbills = mgr.listPharmordersByStatusByPatient("Approved", patientid);
                    List patientprocedurebills = mgr.listPatientProceduresByStatusandPatient("Cashier", patientid);

                %>

                <% if (patientmedicalbills.size() > 0) {

                        Visitationtable vst = (Visitationtable) patientmedicalbills.get(0);
                %>

                <div class="thumbnail">
                    <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                        <li><b> MEDICAL</b> </li>
                    </ul>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th style="text-align: left; color: #fff; font-size: 14px;">DETAILS </th>
                                <th style="width: 30px; color: #fff; font-size: 14px;"> PRICE </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List l = mgr.listPatientConsultationByVisitid(vst.getVisitid());
                                Patientconsultation patientconsultation = (Patientconsultation) l.get(0);
                                if (patientconsultation != null && l.size() > 0) {%>


                            <% List registrations = mgr.getPatientReg(vst.getPatientid());
                                PatientRegistration pRegg = null;
                                RegFee rFee = null;
                                List curRFees;


                                if (registrations != null && registrations.size() > 0) {
                                    System.out.println("herehrehrherhe " + registrations.size());
                                    pRegg = (PatientRegistration) registrations.get(0);

                                    if (pRegg != null) {

                                        double amountPaid = pRegg.getAmountPaid();
                                        if (amountPaid == 0) {
                                            curRFees = mgr.listCurrentRegFee("Yes");
                                            if (!curRFees.isEmpty()) {
                                                rFee = (RegFee) curRFees.get(0);
                                                if (rFee != null) {
                                                    registrationFee = rFee.getRegFee();


                            %>
                            <tr>
                                <td class="registration_row<%=vst.getVisitid()%>keys" style="text-transform: capitalize; text-align: left;">Registration</td>
                                <td class="registration_row<%=vst.getVisitid()%>value" style="text-align: right;"><%=df.format(registrationFee)%></td>


                            </tr>




                            <% }
                                            }
                                        }
                                    }
                                }
                            %>

                            <tr>
                                <td class="consultation_row<%=vst.getVisitid()%>keys" style="text-transform: capitalize; text-align: left;">
                                    <%=mgr.getConsultationId(patientconsultation.getTypeid()).getContype()%>
                                </td>

                                <td class="consultation_row<%=vst.getVisitid()%>value" style="text-align: right;"> 
                                    <%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount())%>
                                    <% if (pRegg != null) {%>

                                    <input class="input-small amountdueinput<%=vst.getVisitid()%>" style="color: blue; display: none;"  type="text"  disabled="disabled" value="<%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount() + registrationFee)%> " /> 

                                    <% } else {%>
                                    <input class="input-small amountdueinput<%=vst.getVisitid()%>" style="color: blue; display: none;"  type="text"  disabled="disabled" value="<%=df.format(mgr.getConsultationId(patientconsultation.getTypeid()).getAmount())%> " /> 

                                    <%  }%>
                                </td>
                                <%
                                    }
                                %>            
                        </tbody>
                    </table>
                </div>

                <% }%>  
                <div class="clearfix"></div>
                <% if (patientdispensingbills.size() > 0) {

                        Pharmorder vst = (Pharmorder) patientdispensingbills.get(0);
                %>
                <div class="thumbnail">
                    <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                        <li><b> DISPENSING</b> </li>
                    </ul>






                </div>
                <% }%> 
                <div class="clearfix"></div>

                <% if (patientprocedurebills.size() > 0) {

                        Procedureorders vst = (Procedureorders) patientprocedurebills.get(0);
                %>
                <div class="thumbnail">
                    <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                        <li><b> PROCEDURES</b> </li>
                    </ul>
                    <table class="table">
                        <thead>
                            <tr style="color: #fff;">
                                <th style="color: #fff; text-align: left; font-size: 14px;"> PROCEDURE </th>
                                <th style="color: #fff; text-align: right; font-size: 14px;" > PRICE </th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List procedures = mgr.listPatientProcdureByOrderid(vst.getOrderid());
                                double total = 0.0;
                                for (int r = 0; r < procedures.size(); r++) {
                                    PatientProcedure procedure = (PatientProcedure) procedures.get(r);
                                    total = total + mgr.getProcedure(procedure.getProcedureCode()).getPrice();
                            %>
                            <tr>
                                <td class="procedure_row<%=procedure.getProcedureCode()%>" style="padding-left: 5px;"><%=mgr.getProcedure(procedure.getProcedureCode()).getDescription()%> </td>
                                <td class="procedure_row<%=procedure.getProcedureCode()%>" style="text-align: right;"><%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> 
                                    <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" value="<%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%>" />
                                </td>

                            </tr>
                            
                            <% } %>

                        </tbody>

                    </table>





                </div>






                <% }%> 
                <div class="clearfix"></div>



            </div>

        </div>
        <% }%>
    </body>
    <%@include file="widgets/javascripts.jsp" %>


    <script type="text/javascript">
        
        $(document).ready(function(){
        <%  for (String patientid : combinedList) {%> 
                $("#<%= patientid%>_dialog").dialog({
                    autoOpen : false,
                    width : "90%",
                    modal :true,
                    position: "top"

                });
        
             
                
                $("#<%= patientid%>_patientidlink").click(function(){
                    
                    $("#<%=patientid%>_dialog").dialog('open');
    
                })
            
        <% }%>
            
            })
        
        
    </script>

</html>
