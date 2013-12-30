<%-- 
Document   : pharmacy
Created on : Jul 26, 2012, 8:55:54 AM
Author     : dependable
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <style type="text/css">
            body {
                overflow-y: scroll;
            }
        </style>

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            //Patient p = (Patient)session.getAttribute("patient");
            //get current date time with Date()
            Date date = new Date();
            //System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            List listorders = mgr.listLabordersByStatus("Not Done");
            // for (int i = 0; i < visits.size(); i++) {
            //   Visitationtable visit = (Visitationtable) visits.get(i);
        %>


    </head>



    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Main Laboratory</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">

                            <table class="example display table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left"> Laboratory Number </th>
                                        <th style="text-align: left"> Patient Name </th>
                                        <th style="text-align: left"> Payment Type</th>
                                        <th style="text-align: left"> Date of Birth  </th>


                                        <th style="text-align: left"> Requested On </th>
                                        <th style="text-align: left"> Time </th>

                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (listorders != null) {
                                            for (int i = 0; i < listorders.size(); i++) {
                                                Laborders vst = (Laborders) listorders.get(i);
                                                if (vst != null) {
                                    %>
                                    <tr>


                                        <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>

                                        <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=vst.getOrderid()%> </a>   </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>

                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>
                                      <!--  <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
                                        <td><%=formatter.format(vst.getOrderdate())%> </td>
                                        <td><%=time.format(vst.getOrderdate())%> </td>

                                        <%} else {%>

                                        <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <a href="#"> <%=vst.getOrderid()%> </a>  </td>
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%> </td>

                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
<!--   <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                        <td><%=formatter.format(vst.getOrderdate())%> </td>
                                        <td><%=time.format(vst.getOrderdate())%> </td>
                                        <%}%>

                                        <td>
                                            <button class="btn btn-info btn-small" id="<%=vst.getOrderid()%>_link">
                                                <i class="icon-white icon-check"></i> Enter Lab Result 
                                            </button>
                                        </td>

                                    </tr>
                                    <%}
                                            }
                                        }%>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <% if (listorders != null) {
                        for (int i = 0; i < listorders.size(); i++) {
                            Laborders vst = (Laborders) listorders.get(i);
                            if (vst != null) {
                %>
                <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                <div style="display: none; max-height: 800px; overflow-y: scroll;" class="dialog" id="<%=vst.getOrderid()%>_dialog" title="LABORATORY RESULTS ENTRY FOR <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>
                     <% if (mgr.getPatientByID(vst.getPatientid()).getMidname() != null) {%>
                     <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                     <% }%>

                     <%=mgr.getPatientByID(vst.getPatientid()).getLname()%> | <span style='text-transform: capitalize;'> <%=vst.getOrderid()%></span>">

                    <%} else {%>
                    <div style="display: none; max-height: 650px; overflow-y: scroll;" class="dialog" id="<%=vst.getOrderid()%>_dialog" title="LABORATORY RESULTS ENTRY FOR <%=mgr.getLabPatientByID(vst.getPatientid()).getFname()%> 
                         <% if (mgr.getLabPatientByID(vst.getPatientid()).getMidname() != null) {%>
                         <%= mgr.getLabPatientByID(vst.getPatientid()).getMidname()%>
                         <% }%>
                         <%=mgr.getLabPatientByID(vst.getPatientid()).getLname()%> | <span style='text-transform: capitalize;'> <%=vst.getOrderid()%></span>">

                        <% }%><div class="well thumbnail">
                            <form action="action/labaction.jsp" method="post">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="color: #FFF; text-align: left; width: 250px;"> Test(s) </th>
                                            <th style="color: #FFF; text-align: left; width: 250px;"> Result(s) </th>
                                            <th style="color: #FFF; width: 80px; text-align: left;">Unit(s)</th>
                                            <th style="color: #FFF; width: 120px;">Reference Range(s)</th>
                                            <th style="color: #FFF; width: 110px;"> </th>
                                            <th style="color: #FFF; text-align: center; width: 100px;"> Confirmation(s) </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List ptreatmentss = mgr.patientInvestigationByOrderId(vst.getOrderid());
                                            String invName = "", mainInvName = "", hasAntibiotics = "";
                                            int invType = 0, groupedUnderId = 0, invId, posInvResultId;

                                            Investigation inv = null, mainInv = null;
                                            DetailedinvPosinvresults detInvPosRes = null;
                                            PossibleinvResults posInvRes = null;
                                            boolean hasResultOptions = false, foundSubTests = false, subTestHasResultOptions = false;
                                            List detailedInvPosResults, mainInvSubInvs;
                                            List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                            Laborders laborder = (Laborders) laborders.get(0);
                                            for (int r = 0; r < ptreatmentss.size(); r++) {
                                                Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);

                                                //    System.out.println("ppt +++++ " + ptPatienttreatments.getInvestigationid());

                                                inv = mgr.getInvestigation(ptPatienttreatments.getInvestigationid());
                                                invId = inv.getDetailedInvId();

                                                invName = inv.getName();
                                                invType = inv.getTypeOfTestId();

                                                // test of whether investigation has antibiotics
                                                // if yes, no display either of
                                                hasAntibiotics = inv.getLowBound();

                                                System.out.println("qwerpo invId : " + invId + " " + invName);

                                                hasResultOptions = false;
                                                foundSubTests = false;

                                        %>
                                        <tr>
                                            <%     if (invType == 1) {
                                                    mainInvSubInvs = mgr.listSubInvUnderMainInv(invId);

                                                    if (mainInvSubInvs.isEmpty()) {  // no subtests found under it  
                                                        foundSubTests = false;
                                            %>
                                            <td><b><%=invName%></b></td>
                                            <td>

                                                <%
                                                    // find if it has results associated
                                                    hasResultOptions = inv.isResultOptions();
                                                    System.out.println("qwerpo invname and its results : " + invName + " " + hasResultOptions);

                                                    if (hasResultOptions) {  //go ahead and populate a dropdown of those

                                                        // first, get the result options
                                                        detailedInvPosResults = mgr.listDetailedInvPosResults(invId);

                                                        if (!detailedInvPosResults.isEmpty()) {%>
                                                <div class="control-group error">
                                                    <div class="controls">
                                                        <select id="results<%=ptPatienttreatments.getId()%>" class="MustSelectOpt" name="results<%=ptPatienttreatments.getId()%>" >

                                                            <option  value="">Select Result</option>


                                                            <%            for (int q = 0; q < detailedInvPosResults.size(); q++) {
                                                                    //     System.out.println("qqqq : " + detailedInvPosResults.get(q));
                                                                    detInvPosRes = (DetailedinvPosinvresults) detailedInvPosResults.get(q);
                                                                    posInvResultId = detInvPosRes.getPosinvresultId();
                                                                    posInvRes = mgr.getPossibleInvResultById(posInvResultId);
                                                            %>

                                                            <option><%=posInvRes.getPosinvResult()%></option>

                                                            <%                       }%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <%         } else {%>
                                                <input type="text" name="results<%=ptPatienttreatments.getId()%>" />                  
                                                <%           }
                                                } else {%>
                                                <input type="text" name="results<%=ptPatienttreatments.getId()%>" />                 
                                                <%         }%>

                                            </td>
                                            <%

                                                String invUnits = inv.getUnits();
                                                RefRangeUni uniRange = null;
                                                RefRangeDet detRange = null;
                                                String lower = "";
                                                String upper = "";
                                                String refRange = "";
                                                String genlower = "";
                                                String genupper = "";


                                                int refRangeSelected = 0;

                                                if (invUnits.isEmpty() || invUnits.equalsIgnoreCase("NA")) {
                                                    invUnits = "";
                                                }

                                                String invRefRangeType = inv.getRefRangeType();


                                                if (invRefRangeType.equals("uni")) {
                                                    // get ref range


                                                    uniRange = (RefRangeUni) (mgr.getUniRefRangeByDetInvId(inv.getDetailedInvId()).get(0));

                                                    refRangeSelected = uniRange.getSelected();

                                                    if (refRangeSelected == 2) {
                                                        lower = uniRange.getLowerRefRange();
                                                        upper = uniRange.getUpperRefRange();

                                                        refRange = lower + " - " + upper;
                                                    } else if (refRangeSelected == 1) {
                                                        refRange = uniRange.getParagraphic();
                                                    }
                                                }
                                                if (invRefRangeType.equals("det")) {

                                                    detRange = (RefRangeDet) (mgr.getDetRefRangeByDetInvId(inv.getDetailedInvId()).get(0));
                                                    System.out.println("successful successful successful");
                                                    if (detRange != null) {

                                                        if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {
                                                            if (mgr.getPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Male")) {
                                                                genlower = detRange.getMLower();
                                                                genupper = detRange.getMUpper();
                                                            } else {
                                                                genlower = detRange.getFLower();
                                                                genupper = detRange.getFUpper();
                                                            }
                                                        } else {
                                                            if (mgr.getLabPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Female")) {
                                                                genlower = detRange.getFLower();
                                                                genupper = detRange.getFUpper();
                                                            } else {
                                                                genlower = detRange.getMLower();
                                                                genupper = detRange.getMUpper();
                                                            }
                                                        }
                                                    }

                                                }


                                                if (refRange.isEmpty() || refRange.equalsIgnoreCase("NA") || refRange.trim().equals("-")) {
                                                    refRange = "";
                                                }


                                            %>
                                            <td>
                                                <%=invUnits%>
                                            </td>
                                            <td style="text-align: center;">
                                                <% if (invRefRangeType.equalsIgnoreCase("uni")) {
                                                        if (refRange.length() <= 25) {%>
                                                <%=refRange%>
                                                <% } else {%>
                                                <a  href="#"  rel="tooltip" style="color: #fff" title="<%=refRange%>"> <span class="label label-info">  View </span> </a>
                                                <% }
                                                    }
                                                    if (invRefRangeType.equalsIgnoreCase("det")) {
                                                        out.print(genlower + " - " + genupper);
                                                    }%>
                                            </td>
                                            <td style="text-align: center;">
                                                <button type="button" id="comment<%=ptPatienttreatments.getId()%><%=vst.getOrderid()%>" class="btn btn-success addcomment btn-mini">
                                                    <i class="icon-white icon-plus"></i>Comment
                                                </button>
                                                <textarea  type="text" class="comment<%=ptPatienttreatments.getId()%><%=vst.getOrderid()%> hide" name="comment<%=ptPatienttreatments.getId()%>"></textarea>
                                            </td>


                                            <td>
                                                <label class="switch-container">
                                                    <input  type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"  style="width: 100px" class="switch-input checkValue hide">
                                                    <div class="switch">
                                                        <span class="switch-label">Yes</span>
                                                        <span class="switch-label">No</span>
                                                        <span class="switch-handle"></span>
                                                    </div>  
                                                </label>

                                            </td>

                                            <%} else {
                                                foundSubTests = true;
                                            %>
                                            <td colspan="5"><b><%=invName%></b></td>
                                            <td>
                                                <label class="switch-container">
                                                    <input  type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"  style="width: 100px" class="switch-input checkValue hide">
                                                    <div class="switch">
                                                        <span class="switch-label">Yes</span>
                                                        <span class="switch-label">No</span>
                                                        <span class="switch-handle"></span>

                                                    </div>  
                                                </label>
                                            </td>
                                            <%}
                                                if (foundSubTests) {
                                                    String orderId;
                                                    List patInvsByInvIdNOrderId;
                                                    for (int j = 0; j < mainInvSubInvs.size(); j++) {
                                                        //     subTestHasResultOptions = false;
                                                        inv = (Investigation) mainInvSubInvs.get(j);
                                                        orderId = laborder.getOrderid();
                                                        invId = inv.getDetailedInvId();
                                                        patInvsByInvIdNOrderId = mgr.listPatientInvByInvIdNOrderId(invId, vst.getOrderid());

                                                        if (!patInvsByInvIdNOrderId.isEmpty()) {

                                                            ptPatienttreatments = (Patientinvestigation) patInvsByInvIdNOrderId.get(0);
                                                            invName = inv.getName();
                                            %>

                                            <!--table-->
                                        <tr>
                                            <td><span style="padding-left: 25px;"><%
                                                if (!inv.isIsSubheading()) {%><%=invName%><%} else {%><b><%=invName%></b><%}%> </span></td>
                                            <td>
                                                <%
                                                    if (!inv.isIsSubheading()) {
                                                        // find if it has results associated
                                                        hasResultOptions = inv.isResultOptions();

                                                        if (hasResultOptions) {  //go ahead and populate a dropdown of those

                                                            // first, get the result options
                                                            detailedInvPosResults = mgr.listDetailedInvPosResults(invId);

                                                            if (!detailedInvPosResults.isEmpty()) {%>
                                                <div class="control-group error">
                                                    <div class="controls">
                                                        <select id="results<%=ptPatienttreatments.getId()%>" class="MustSelectOpt" name="results<%=ptPatienttreatments.getId()%>" >

                                                            <option value="">Select Result</option>


                                                            <%            for (int q = 0; q < detailedInvPosResults.size(); q++) {
                                                                    //     System.out.println("qqqq : " + detailedInvPosResults.get(q));
                                                                    detInvPosRes = (DetailedinvPosinvresults) detailedInvPosResults.get(q);
                                                                    posInvResultId = detInvPosRes.getPosinvresultId();
                                                                    posInvRes = mgr.getPossibleInvResultById(posInvResultId);
                                                            %>
                                                            <option><%=posInvRes.getPosinvResult()%></option>
                                                            <%                       }%>
                                                        </select>
                                                    </div>

                                                </div>
                                                <%         } else {%>
                                                <input type="text" name="results<%=ptPatienttreatments.getId()%>"/>                  
                                                <%           }
                                                %>

                                                <%} else {%>
                                                <input type="text" name="results<%=ptPatienttreatments.getId()%>" id="isolate<%=ptPatienttreatments.getId()%>"/>                 
                                                <%         }
                                                    }%>
                                            </td>
                                            <%

                                                String invUnits = inv.getUnits();
                                                RefRangeUni uniRange = null;
                                                RefRangeDet detRange = null;
                                                String lower = "";
                                                String upper = "";
                                                String refRange = "";
                                                String genlower = "";
                                                String genupper = "";

                                                int refRangeSelected = 0;

                                                if (invUnits.isEmpty() || invUnits.equalsIgnoreCase("NA")) {
                                                    invUnits = "";
                                                }

                                                String invRefRangeType = inv.getRefRangeType();


                                                if (invRefRangeType.equals("uni")) {
                                                    // get ref range
                                                    uniRange = (RefRangeUni) (mgr.getUniRefRangeByDetInvId(inv.getDetailedInvId()).get(0));

                                                    refRangeSelected = uniRange.getSelected();

                                                    if (refRangeSelected == 2) {
                                                        lower = uniRange.getLowerRefRange();
                                                        upper = uniRange.getUpperRefRange();

                                                        refRange = lower + " - " + upper;
                                                    } else if (refRangeSelected == 1) {
                                                        refRange = uniRange.getParagraphic();
                                                    }
                                                }
                                                if (invRefRangeType.equals("det")) {

                                                    detRange = (RefRangeDet) (mgr.getDetRefRangeByDetInvId(inv.getDetailedInvId()).get(0));
                                                    System.out.println("successful successful successful");
                                                    if (detRange != null) {

                                                        if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {
                                                            if (mgr.getPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Male")) {
                                                                genlower = detRange.getMLower();
                                                                genupper = detRange.getMUpper();
                                                            } else {
                                                                genlower = detRange.getFLower();
                                                                genupper = detRange.getFUpper();
                                                            }
                                                        } else {
                                                            if (mgr.getLabPatientByID(vst.getPatientid()).getGender().equalsIgnoreCase("Female")) {
                                                                genlower = detRange.getFLower();
                                                                genupper = detRange.getFUpper();
                                                            } else {
                                                                genlower = detRange.getMLower();
                                                                genupper = detRange.getMUpper();
                                                            }
                                                        }
                                                    }

                                                }

                                                if (refRange.isEmpty() || refRange.equalsIgnoreCase("NA") || refRange.trim().equals("-")) {
                                                    refRange = "";
                                                }
                                            %>
                                            <td>
                                                <%=invUnits%>
                                            </td>
                                            <td style="text-align: center;">
                                                <% if (invRefRangeType.equalsIgnoreCase("uni")) {
                                                        if (refRange.length() <= 25) {%>
                                                <%=refRange%>
                                                <% } else {%>

                                                <a  href="#" rel="tooltip" style="color: #fff" title="<%=refRange%>"> <span class="label label-info" >  View </span> </a>
                                                <% }
                                                    }
                                                    if (invRefRangeType.equalsIgnoreCase("det")) {
                                                        out.print(genlower + " - " + genupper);
                                                    }%>
                                                <%if (inv.isAntibiotic()) {%>
                                                <button type="button" id="antibiotic<%=ptPatienttreatments.getId()%>" class="btn btn-inverse addcomment btn-mini" onclick='setptid("<%=ptPatienttreatments.getId()%>")'>
                                                    Show Antibiotics
                                                </button>
                                                <script type="text/javascript">
                                                    $(document).ready(function(){ 
                                                    
                                                        $("#antibiotic<%=ptPatienttreatments.getId()%>").click(function(){
                                                            var id = <%=ptPatienttreatments.getId()%>;
                                                            $("#ptid").attr("value",id);
                                                            var ptid = $("#ptid").attr("value");
                                                            //alert(ptid)
                                                            $("#antibiotic_div").dialog('open');
                                                        })
                                                    
                                                    })
                                                   
                                                </script>

                                                <%}%>
                                            </td>
                                            <%if (!inv.isIsSubheading()) {%>
                                            <td style="text-align: center;">
                                                <button type="button" id="comment<%=ptPatienttreatments.getId()%><%=vst.getOrderid()%>" class="btn btn-success addcomment btn-mini">
                                                    <i class="icon-white icon-plus"></i>Comment
                                                </button> <br/>
                                                <textarea class="comment<%=ptPatienttreatments.getId()%><%=vst.getOrderid()%> hide" type="text" name="comment<%=ptPatienttreatments.getId()%>"></textarea>
                                            </td>
                                            <%}%>
                                            <td>
                                                <label style="display: none;" class="switch-container ">
                                                    <input checked="checked"  type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"  style="width: 100px; display: none; " class="switch-input checkValue hide">
                                                    <div style="display: none;" class="switch">
                                                        <span class="switch-label">Yes</span>
                                                        <span class="switch-label">No</span>
                                                        <span class="switch-handle"></span>
                                                    </div>  
                                                </label><br/>
                                            </td>
                                        </tr>
                                        <%}%>
                                        <%}
                                                }
                                            }%>

                                        </tr>
                                    <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                    <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                    <input type="hidden" name="labid" value="<%=vst.getOrderid()%>"/>
                                    <input type="hidden" name="ids[]" value="<%=ptPatienttreatments.getId()%>"/>
                                    <%}
                                    %>

                                    </tbody>
                                </table>


                                <div class="form-actions">
                                    <button class="btn btn-danger pull-right" type="submit" id="action" name="laboratory" value="Forward">
                                        <i class="icon-arrow-right icon-white"> </i> Save & Forward for Scrutiny
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>



                    <%}
                            }
                        }%> 
                    <div style="max-height: 500px; overflow-y: scroll;" class="dialog hide" id="antibiotic_div" title="Antimicrobial Susceptibility Testing">
                        <div class="lead">
                            The Above Isolate Is:
                        </div>
                        <form action="action/labaction.jsp" method="post" id="anitbiotic" name="anitbiotic">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <th style="color: #FFF;" >Antibiotic</th><th style="color: #FFF; text-align: center;">Susceptible To</th><th style="color: #FFF; text-align: center;    ">Resistant To</th>
                                </thead>
                                <tbody>
                                    <% List antibiotics = mgr.listAllAntibiotics();
                                        for (int z = 0; z < antibiotics.size(); z++) {
                                            LabAntibiotic antibiotic = (LabAntibiotic) antibiotics.get(z);%>
                                    <tr>
                                        <td><%=antibiotic.getName()%></td>
                                        <td style="text-align: center; width: 100px;">
                                            <label  class="switch-container">
                                                <input type="checkbox" name="resistant[]" value="<%=antibiotic.getId()%>"class="switch-input antibiotic_check  hide">
                                                <div class="switch">
                                                    <span class="switch-label">Yes</span>
                                                    <span class="switch-label">No</span>
                                                    <span class="switch-handle"></span>
                                                </div> 

                                            </label>
                                        </td>

                                        <td  style="text-align: center; width: 100px;">
                                            <label class="switch-container">
                                                <input type="checkbox" name="sensitive[]" value="<%=antibiotic.getId()%>"class="switch-input antibiotic_check  hide">
                                                <div class="switch">
                                                    <span class="switch-label">Yes</span>
                                                    <span class="switch-label">No</span>
                                                    <span class="switch-handle"></span>
                                                </div> 

                                            </label>
                                        </td>
                                    </tr>
                                    <%}%>
                                    <tr style="text-align: center;">

                                        <td colspan="3">
                                            &nbsp;
                                            <input type="hidden" name="pinvestigation" id="ptid" />

                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="form-actions">
                                <button class="btn btn-danger pull-right" type="submit" id="sub" name="action" value="antibiotictreatment" onclick="submitform();return false">
                                    <i class="icon-check icon-white"> </i> Save  
                                </button>
                            </div>
                        </form>
                    </div>
            </section>  
            <%@include file="widgets/footer.jsp" %>

        </div>
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

        <!-- <script type="text/javascript" src="js/tablecloth.js"></script>  -->
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
                $(".alert").fadeIn();
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
            function setptid(id){
                document.getElementById("ptid").value=id;
            }
            function submitform(){
                var resistants = new Array();
                var ptid = document.getElementById("ptid").value;
                
                $("input[name='resistant[]']:checked").each(function(i) {
                    resistants.push($(this).val());
                });
                
                var sensitives = new Array();;
                $("input[name='sensitive[]']:checked").each(function(i) {
                    sensitives.push($(this).val());
                });
                $.post('action/labaction.jsp', { action : "antibiotictreatment", "resistant[]": resistants, "sensitive[]" : sensitives, "pinvestigation" : ptid}, function(data) {
                    alert("Antibiotics Saved Successfully");
                    $("#antibiotic_div").dialog("close");
                    
                    $("input[name='resistant[]']").each(function(){
                        $(this).attr("checked",false);
                    })
                    
                    $("input[name='sensitive[]']").each(function(){
                        $(this).attr("checked",false);
                    })
                    
                } );
                
            }

        </script>


        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                
                $("a[rel='tooltip']").tooltip()
                
                
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "bPaginate" : false,
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sScrollY" : 400
                    

                });
            
                $("#antibiotic_div").dialog({
                    autoOpen : false,
                    width : 500,
                    modal :true
                });
                
                

                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
                
                
                $(".addcomment").click(function(){
                    //alert($(this).attr("id"))
                    var commentid = $(this).attr("id");
                    $("."+commentid).slideToggle();
                });
                
                
                $(".MustSelectOpt").change(function(){
                
                    var selectedvalue = $(this).attr('value')
                    var selectedid = $(this).attr('id');    
                    //alert(selectedvalue);
                    //alert(selectedid);
                    if($("#"+selectedid).attr("value")==""){
                    
                        $('#'+selectedid).closest('.control-group').addClass('error').removeClass('success')
                        // $('.MustSel').closest('.control-group').addClass('error').removeClass('success')
                        
                    }else{
                        $('#'+selectedid).closest('.control-group').addClass('success').removeClass('error');        
                        //  $('.MustSel').closest('.control-group').addClass('success').removeClass('error');
                    }
                        
                  
                    
                })
                
              
                

            });
           
        </script>
        <% for (int i = 0;
                    i < listorders.size();
                    i++) {
                Laborders vst = (Laborders) listorders.get(i);
        %>


        <script type="text/javascript">
   
            $("#<%= vst.getOrderid()%>_link").click(function(){
      
                $("#<%=vst.getOrderid()%>_dialog").dialog('open');
    
            })
   
            $("#<%= vst.getOrderid()%>_dialog").dialog({
                autoOpen : false,
                width : 1200,
                modal :true

            });
           
        </script>
        <% }%>

    </body>
</html>