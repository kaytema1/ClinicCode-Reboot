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

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat smallformatter = new SimpleDateFormat("dd-MM-yy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();
            //System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            List first = mgr.listLabordersByStatus("Completed");
            //List second = mgr.listLabordersByStatus("Incomplete");
            List listorders = mgr.listLabordersByStatus("Incomplete");
            if (first.size() > 0) {
                listorders.addAll(first);
            }
            System.out.println("laborders " + listorders.size());
            String newOrderId = request.getParameter("labid");
            Laborders labOrder = mgr.getLabOrdersByOrderId(newOrderId);
            Laborders vst = labOrder;

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
                            <a href="#">Labs Awaiting Scrutiny</a><span class="divider"></span>
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
                                        <th style="text-align: left;"> Laboratory Number </th>
                                        <th style="text-align: left;"> Patient Name </th>
                                        <th style="text-align: left;"> Payment Type</th>
                                        <th style="text-align: left;"> Date of Birth  </th>

                                        <th style="text-align: left;"> Requested On</th>
                                        <th style="text-align: left;"> Time</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <tr>
                                        <td>
                                            <div style="overflow-y: hidden; max-height: 850px;"  class="dialog" id="<%=vst.getOrderid()%>_dialog" title="Laboratory Results Scrutiny for  <% if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                                 <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                 <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                 <%=mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                 <%} else {%>
                                                 <%=mgr.getLabPatientByID(vst.getPatientid()).getFname()%>
                                                 <%=mgr.getLabPatientByID(vst.getPatientid()).getMidname()%>
                                                 <%=mgr.getLabPatientByID(vst.getPatientid()).getLname()%>
                                                 <%}%> | <span style='text-transform: uppercase;'> <%=vst.getOrderid()%> <span>">
                                                <span class="span4">
                                                    <dl class="dl-horizontal">
                                                        <dt style="text-align: left;" >Date:</dt>
                                                        <dd> <%= formatter.format(vst.getOrderdate())%></dd>
                                                        <dt style="text-align: left;" >Laboratory No:</dt>
                                                        <dd style="text-transform: uppercase;"><%=vst.getOrderid()%></dd>
                                                        <dt style="text-align: left;" >Patient Name:</dt>
                                                        <dd>
                                                            <b>  <% if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                                <%} else {%>
                                                                <%=mgr.getLabPatientByID(vst.getPatientid()).getFname()%>
                                                                <%=mgr.getLabPatientByID(vst.getPatientid()).getMidname()%>
                                                                <%=mgr.getLabPatientByID(vst.getPatientid()).getLname()%>
                                                                <%}%>
                                                            </b>
                                                        </dd>

                                                    </dl>

                                                </span>

                                                <div class="clearfix">
                                                </div>   
                                                <div  style="font-weight: bolder; text-align: center;" class="lead"> <u> LABORATORY RESULTS SCRUTINY </u>   </div>
                                                <div  style="font-weight: bolder; text-align: center;"> Double-click Text Field to Activate </div>  
                                                <div  style="font-weight: bolder; text-align: center; color: #FF1923" > Only Confirmed Results are Available for Scrutiny </div>
                                                <form action="action/labaction.jsp" method="post">
                                                    <div style="overflow-y: scroll; max-height: 500px;" class="center thumbnail">

                                                        <table class="table table-condensed">
                                                            <thead>
                                                                <tr >
                                                                    <th style="color: #FFF; text-align: left; width: 250px;"> Test(s) </th>
                                                                    <th style="color: #FFF; text-align: left; width: 150px;"> Result(s) </th>
                                                                    <th style="color: #FFF; text-align: left; width: 150px;"> Previous Result(s)</th>
                                                                    <th style="color: #FFF; width: 80px; text-align: left;">Unit(s)</th>
                                                                    <th style="color: #FFF; width: 120px;">Reference Range(s)</th>
                                                                    <th style="color: #FFF; width: 110px; text-align: left;"> Comment(s) </th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%     List ptreatmentss = mgr.patientInvestigationByOrderId(vst.getOrderid());
                                                                    String invName = "", mainInvName = "";
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

                                                                        hasResultOptions = false;
                                                                        foundSubTests = false;

                                                                %>


                                                                <%     if (invType == 1) {
                                                                        mainInvSubInvs = mgr.listSubInvUnderMainInv(invId);

                                                                        if (mainInvSubInvs.isEmpty()) {  // no subtests found under it  
                                                                            foundSubTests = false;
                                                                %>
                                                                <tr>
                                                                    <%if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Performed")) {%> 
                                                                    <td><b><%=invName%></b></td>
                                                                    <td style="line-height: 25px;">

                                                                        <%if (ptPatienttreatments.getResult().length() > 25) {%>
                                                                        <textarea name="vetted_<%=ptPatienttreatments.getId()%>"><%=ptPatienttreatments.getResult()%></textarea>
                                                                        <% } else {%>
                                                                        <input class="input-large" type="text" value="<%=ptPatienttreatments.getResult()%>" name="vetted_<%=ptPatienttreatments.getId()%>"/>
                                                                        <%}%> 


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
                                                                    <td style="text-align: left;">
                                                                        <%
                                                                            List l = mgr.listPatientPreviousTest(ptPatienttreatments.getInvestigationid(), ptPatienttreatments.getPatientid());
                                                                            if (l != null && l.size() > 1) {
                                                                                System.out.println("more then 1 " + ptPatienttreatments.getId() + " " + l.size());
                                                                                for (int g = 0; g < l.size(); g++) {
                                                                                    System.out.println("hhhhhhh dispatch");
                                                                                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(g);

                                                                                    if ((patientinvestigation.getId() + "").equals("" + ptPatienttreatments.getId())) {
                                                                                        System.out.println("hhhhhhh dispatch " + mgr.compareTo(patientinvestigation, ptPatienttreatments) + "");
                                                                                        int index = l.indexOf(patientinvestigation);
                                                                                        System.out.println(index);
                                                                                        if ((index + 1) < l.size()) {
                                                                                            Patientinvestigation patientinvestigation1 = (Patientinvestigation) l.get(index + 1);
                                                                                            if (patientinvestigation != null) {%>
                                                                        <b style="font-size: 9px; font-weight: normal; float: left; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : patientinvestigation1.getResult()%></b>&nbsp;<b style="font-size: 8px; font-weight: normal; float: right; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : smallformatter.format(patientinvestigation1.getDate())%></b>
                                                                        <%}
                                                                                        }
                                                                                    }
                                                                                    //break;

                                                                                }
                                                                            }%>    </td>
                                                                    <td>
                                                                        <%=invUnits%>
                                                                    </td>
                                                                    <td style="text-align: center;">
                                                                        <% if (invRefRangeType.equalsIgnoreCase("uni")) {
                                                                                if (refRange.length() <= 25) {%>
                                                                        <% if (refRange.length() <= 25) {%>                                                
                                                                        <%=refRange%>                                                
                                                                        <% } else {%>                                                
                                                                        <span class="label label-info">  <a  href="#"  rel="tooltip" style="color: #fff" title="<%=refRange%>">View</a> </span>                                          
                                                                        <% }%>
                                                                        <% } else {%>
                                                                        <span class="label label-info">  <a  href="#"  rel="tooltip" style="color: #fff" title="<%
                                                                            if (refRange.length() <= 25) {%>            
                                                                                                             <%=refRange%>">View</a> </span>
                                                                            <% } else {%>         
                                                                        <span class="label label-info">  <a  href="#"  rel="tooltip" style="color: #fff" title="<%=refRange%>">View</a> </span> 
                                                                        <% }%>  
                                                                        <% }
                                                                            }
                                                                            if (invRefRangeType.equalsIgnoreCase("det")) {
                                                                                out.print(genlower + " - " + genupper);
                                                                            }%>
                                                                    </td>

                                                                    <td style="text-align: left;">
                                                                        <% if (ptPatienttreatments.getNote() != null && ptPatienttreatments.getNote().length() > 0) {%>
                                                                        <textarea  type="text" name="note_<%=ptPatienttreatments.getId()%>"><%=ptPatienttreatments.getNote()%></textarea>
                                                                        <% }%>
                                                                    </td>



                                                                </tr>
                                                                <% }
                                                                } else {
                                                                    foundSubTests = true;
                                                                %>
                                                                <%if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Performed")) {%> 

                                                                <tr>      
                                                                    <td colspan="6">
                                                                        <b><%=invName%></b>
                                                                    </td>
                                                                </tr>
                                                                <% }
                                                                    }
                                                                    if (foundSubTests) {
                                                                        String orderId;
                                                                        for (int j = 0; j < mainInvSubInvs.size(); j++) {
                                                                            //     subTestHasResultOptions = false;
                                                                            inv = (Investigation) mainInvSubInvs.get(j);
                                                                            orderId = laborder.getOrderid();
                                                                            invId = inv.getDetailedInvId();

                                                                            Patientinvestigation ptPatienttreatmentsTemp = (Patientinvestigation) mgr.listPatientInvByInvIdNOrderId(invId, vst.getOrderid()).get(0);
                                                                            invName = inv.getName();
                                                                %>

                                                                <!--table-->
                                                                <%if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Performed")) {%> 
                                                                <tr>

                                                                    <% List list = mgr.listInvestigationSuscByInvestigationId(ptPatienttreatmentsTemp.getId());%>
                                                                    <% List list1 = mgr.listInvestigationSuscByInvestigationId(ptPatienttreatmentsTemp.getId());%>
                                                                    <td style="padding-left: 35px;"><%=invName%></td>
                                                                    <td style="text-align: left; line-height: 25px;"> 

                                                                        <%if (!inv.isIsSubheading()) {
                                                                                if (inv.isAntibiotic()) {%>



                                                                        <% }%>
                                                                        <%if (ptPatienttreatmentsTemp.getResult().length() > 25) {%>
                                                                        <textarea name="vetted_<%=ptPatienttreatmentsTemp.getId()%>"><%=ptPatienttreatmentsTemp.getResult()%></textarea><br/>
                                                                        <% } else {%>
                                                                        <input class="input-large" type="text" value="<%=ptPatienttreatmentsTemp.getResult()%>" name="vetted_<%=ptPatienttreatmentsTemp.getId()%>"/><br/>
                                                                        <%}%>   <%if (inv.isAntibiotic()) {%>
                                                                        <div title="Antimicrobial Susceptibility Results">

                                                                            <div class="clearfix">

                                                                            </div>
                                                                            <div style="width: 55%; float: left; text-align: left; ">
                                                                                <ul class="nav nav-list">
                                                                                    <% if (list.size() > 0 && list1.size() > 0) {%>
                                                                                    <li style="padding-left: 5px;" class="nav-header"> Susceptible to: <li>

                                                                                        <%  for (int z = 0; z < list.size(); z++) {
                                                                                                InvestigationResistantSusc investigationResistantSusc = (InvestigationResistantSusc) list.get(z);
                                                                                                if (investigationResistantSusc.getSusceptibleTo() > 0) {
                                                                                        %>
                                                                                    <li><%=mgr.getLabAntibiotic(investigationResistantSusc.getSusceptibleTo()).getName()%></li>

                                                                                    <%}
                                                                                            }
                                                                                        }%>
                                                                                </ul>
                                                                            </div>
                                                                            <div style="width: 45%; float: left; text-align: left;">
                                                                                <ul  class="nav nav-list">
                                                                                    <% if (list.size() > 0 && list1.size() > 0) {%>
                                                                                    <li style="padding-left: 5px;" class="nav-header">Resistant to:</li>

                                                                                    <%  for (int z = 0; z < list1.size(); z++) {
                                                                                            InvestigationResistantSusc investigationResistantSusc = (InvestigationResistantSusc) list1.get(z);
                                                                                            if (investigationResistantSusc.getResistantTo() > 0) {
                                                                                    %>
                                                                                    <li><%=mgr.getLabAntibiotic(investigationResistantSusc.getResistantTo()).getName()%></li>

                                                                                    <%}
                                                                                            }
                                                                                        }%>
                                                                                </ul>

                                                                            </div>
                                                                        </div>
                                                                        <%}
                                                                            }
                                                                        %>
                                                                    </td>

                                                                    <%

                                                                        String invUnits = inv.getUnits();
                                                                        RefRangeUni uniRange = null;
                                                                        RefRangeDet detRange = null;
                                                                        String lower = "";
                                                                        String upper = "";
                                                                        String genlower = "";
                                                                        String genupper = "";
                                                                        String refRange = "";
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
                                                                    <td style="text-align: left;">
                                                                        <%
                                                                            List l = mgr.listPatientPreviousTest(ptPatienttreatmentsTemp.getInvestigationid(), ptPatienttreatmentsTemp.getPatientid());
                                                                            if (l != null && l.size() > 1) {
                                                                                System.out.println("more then 1 " + ptPatienttreatmentsTemp.getId() + " " + l.size());
                                                                                for (int g = 0; g < l.size(); g++) {
                                                                                    System.out.println("hhhhhhh dispatch");
                                                                                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(g);

                                                                                    if ((patientinvestigation.getId() + "").equals("" + ptPatienttreatmentsTemp.getId())) {
                                                                                        System.out.println("hhhhhhh dispatch " + mgr.compareTo(patientinvestigation, ptPatienttreatmentsTemp) + "");
                                                                                        int index = l.indexOf(patientinvestigation);
                                                                                        System.out.println(index);
                                                                                        if ((index + 1) < l.size()) {
                                                                                            Patientinvestigation patientinvestigation1 = (Patientinvestigation) l.get(index + 1);
                                                                                            if (patientinvestigation != null) {%>
                                                                        <b style="font-size: 9px; font-weight: normal; float: left; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : patientinvestigation1.getResult()%></b>&nbsp;<b style="font-size: 8px; font-weight: normal; float: right; "><%=mgr.getInvestigation(patientinvestigation1.getInvestigationid()).isIsSubheading() ? "" : smallformatter.format(patientinvestigation1.getDate())%></b>
                                                                        <%}
                                                                                        }
                                                                                    }
                                                                                    //break;

                                                                                }
                                                                            }%>    </td>
                                                                    <td>
                                                                        <%=invUnits%>
                                                                    </td>
                                                                    <td style="text-align: center;">
                                                                        <%if (invRefRangeType.equalsIgnoreCase("uni")) {
                                                                                if (refRange.length() <= 25) {%>                                                
                                                                        <%=refRange%> 
                                                                        <% } else {%>  
                                                                        <span class="label label-info">  <a  href="#"  rel="tooltip" style="color: #fff" title="<%=refRange%>">View</a> </span>  
                                                                        <% }
                                                                            }
                                                                            if (invRefRangeType.equalsIgnoreCase("det")) {
                                                                                out.print(genlower + " - " + genupper);
                                                                            }%>
                                                                    </td>

                                                                    <td style="text-align: left;">
                                                                        <% if (ptPatienttreatmentsTemp.getNote() != null && ptPatienttreatmentsTemp.getNote().length() > 0) {%>
                                                                        <textarea type="text" name="note_<%=ptPatienttreatmentsTemp.getId()%>"><%=ptPatienttreatmentsTemp.getNote()%></textarea>
                                                                        <% }%>
                                                                    </td>

                                                                </tr>

                                                                <% }
                                                                    }%>
                                                                <%}
                                                                    }%>


                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="labid" value="<%=vst.getOrderid()%>"/>

                                                            <%}

                                                            %>

                                                            </tbody>



                                                        </table>
                                                    </div>
                                                    <input type="hidden" name="vettedby" value="<%=user.getStaffid()%>"/>
                                                    <div class="form-actions center">
                                                        <button class="btn btn-danger" name="labvetted" value="Forward" id="">
                                                            <i class="icon-white icon-check"></i> Confirm Results for Printing
                                                        </button>     
                                                    </div>
                                                </form>

                                            </div>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <!-- <td>
                                         </td> -->
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>

                                    <tr>


                                        <%if (vst.getPatientid().contains("c") || vst.getPatientid().contains("C")) {%>
                                        <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=vst.getOrderid()%> </a>  </td>
                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 

                                        <td><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
                                          <!--  <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td> -->
                                        <td><%=formatter.format(vst.getOrderdate())%> </td>
                                        <td><%=time.format(vst.getOrderdate())%> </td>
                                        <%} else {%>
                                        <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=vst.getOrderid()%> </a>  </td>
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

<!--   <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td> -->
                                        <td><%=formatter.format(vst.getOrderdate())%> </td>
                                        <td><%=time.format(vst.getOrderdate())%> </td>
                                        <%}%>
                                        <td>
                                            <button class="btn btn-info btn-small" id="<%=vst.getOrderid()%>_link">
                                                <i class="icon-white icon-check"></i> Scrutinize Results 
                                            </button>
                                        </td>

                                    </tr>


                                </tbody>
                            </table>

                        </div>

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

</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        
        $(":input[type=text]").attr("readonly","readonly");
        
        $(":input[type=text]").dblclick(function() {
          
            $(this).removeAttr("readonly");
    
        });
        
        
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 500

        });
            
        $("a[rel='tooltip']").tooltip()

        $(".patient").popover({

            placement : 'right',
            animation : true

        });

    });

</script>



<script type="text/javascript">
   
   
   
    
    $("#<%= vst.getOrderid()%>_link").click(function(){
      
        $("#<%=vst.getOrderid()%>_dialog").dialog('open');
    
    })
   
    $("#<%= vst.getOrderid()%>_dialog").dialog({
        autoOpen : true,
        width : "90%",
        modal :true,
        position : "top"

    });
    
   
    
    
   
    
</script>






</body>
</html>
