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
    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
    String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");


    List nhisinvestigations = null;
    List investigations = null;
    LabPatient p = null;
    List list = null;

    try {

        if (searchid.equalsIgnoreCase("fullname")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }
            list = mgr.getLabPatientByName(searchquery.trim());
            //System.out.println("patient " + list.size());

        }


        if (searchid.equalsIgnoreCase("patientid")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }
            p = mgr.getLabPatientByID(searchquery.trim());

        }
        /* if (searchid.equalsIgnoreCase("memberdshipnumber")) {
        if (searchquery.equals("")) {
        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("records.jsp");
        return;
        }
        // Sponsorhipdetails spd = mgr.getSearchedSpID(searchquery.trim());
        List l = mgr.getSearchedSpID(searchquery.trim());
        Sponsorhipdetails spd = (Sponsorhipdetails) l.get(0);
        
        p = (LabPatient) mgr.getLabPatientByID(spd.getPatientid());
        
        }
        
        if (searchid.equalsIgnoreCase("dob")) {
        if (searchquery.equals("")) {
        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
        session.setAttribute("class", "alert");
        response.sendRedirect("records.jsp");
        return;
        }
        System.out.println(searchquery);
        list = mgr.listPatientByDob(searchquery.trim());
        System.out.println("here " + list.size());
        
        } */
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
                            <a href="labreception.jsp">Laboratory Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Search Results</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>
            <%if (p != null) {%>
            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->

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


                    <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">



                        <table  class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Patient Number</th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Registered On</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="odd gradeX">

                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td>
                                        <%=  mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>"><b>
                                            <a style="text-transform: uppercase;" class="patientid"><%= p.getPatientid()%></a></b>
                                    </td>
                                    <td><%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%></td>
                                    <td><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                    <td>  <%= formatter.format(p.getDateofbirth())%> </td>
                                    <td>
                                    <%= formatter.format(p.getDateofregistration())%><td>

                                        <div class="center" id="d_<%=p.getPatientid()%>" style="display: block;">
                                            <a  id="new_dialog_link"  class="btn btn-info center" onclick='getContype()'> <i class="icon-pencil icon-white"> </i> New Lab Test </a>
                                        </div></td>
                                </tr>

                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->

        <div style="max-height: 700px; overflow-y: scroll; display: none;" id="new_dialog"  title="Laboratory Processing for  <%= p.getFname()%> <% if (p.getMidname() != null) {%> <%=p.getMidname()%> <% }%> <%= p.getLname()%>">
            <form id="select_labs"  class="form-inline"  action="action/labaction.jsp" method="post">
                <div class="well thumbnail">

                    <!--div style="display: none;" class="well thumbnail center laboratory"-->

                    <div class="center" id="lab">

                        <table>
                            <tr>
                                <td style="text-align: center;">


                                    <div id="tabs">
                                        <ul>
                                            <li><a href="#tabs-1">Investigations</a></li>

                                        </ul>
                                        <%
                                            List labTypes = mgr.listLabTypes();
                                            Labtypes labType;
                                            int labTypesNum = 0;
                                            TreeMap<Integer, String> labTypesMap = new TreeMap<Integer, String>();
                                            TreeMap<Integer, Labtypes> labTypesObjectMap = new TreeMap<Integer, Labtypes>();

                                            if (!labTypes.isEmpty()) {
                                                labTypesNum = labTypes.size();
                                            }
                                        %>
                                        <div id="tabs-1">

                                            <div class="tabs">
                                                <ul>
                                                    <%
                                                        if (labTypesNum > 0) {
                                                            int tabNum = 0;
                                                            for (int y = 0; y < labTypes.size(); y++) {
                                                                labType = (Labtypes) labTypes.get(y);
                                                                System.out.println(labType.getActive() + "+++++++++++++++++++++++++++++!!!!!!!!!!!!!!!!!");
                                                                if (labType.getActive() == 1) {

                                                                    tabNum = y + 1;
                                                    %>
                                                    <li><a style="text-transform: capitalize;" href="#tabs-<%=tabNum%>"><%=labType.getLabType()%></a></li>
                                                    <%        labTypesMap.put(tabNum, labType.getLabType());
                                                                }
                                                            }
                                                        }%>
                                                </ul>

                                                <% if (!labTypes.isEmpty()) {
                                                        int colNum = 0;
                                                        int labTypeId = 0;
                                                        for (int h = 0; h < labTypes.size(); h++) {
                                                            labType = (Labtypes) labTypes.get(h);
                                                            labTypeId = labType.getLabTypeId();
                                                            if (labType.getActive() == 1) {
                                                                colNum = h + 1;
                                                %>
                                                <div id="tabs-<%=colNum%>">
                                                    <div class="center" id="lab">

                                                        <table>
                                                            <tr>
                                                                <td>

                                                                    <%

                                                                        investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                                        if (investigations != null) {
                                                                    %>


                                                                    <div style="float: left"  class="radioset"> 
                                                                        <% for (int y = 0; y < investigations.size(); y++) {
                                                                                Investigation investigation = (Investigation) investigations.get(y);
                                                                                if (investigation != null) {%>

                                                                        <input class="selected_result" style="margin-top: 10px; width: 200px; "  type="checkbox" name="labtest1" id="test<%= investigation.getDetailedInvId()%>" labid="<%=investigation.getDetailedInvId()%>" labtestname="<%=investigation.getName()%>" labtestpricevalue="<%=df.format(investigation.getRate())%>" labtestprice="GH&#162;<%=df.format(investigation.getRate())%>" value="<%=investigation.getRate()%>><<%= investigation.getDetailedInvId()%>"  
                                                                               />
                                                                        <label style="width: 270px; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px;text-transform: capitalize; "  for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName().toLowerCase()%> 
                                                                            <span class='pull-right brand'>GH&#162;<%=mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS") ? df.format(investigation.getRate()) : df.format(investigation.getRate())%></span>
                                                                        </label>

                                                                        <% }
                                                                            }%>
                                                                    </div> 

                                                                    <% }%>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                                <% }
                                                        }
                                                    }%>
                                            </div>
                                        </div>


                                    </div>


                                </td> 
                            </tr>

                        </table>
                        <div class="clearfix"></div>
                        <table>
                            <tr>
                                <td style="width: 50%; vertical-align: top;">
                                    <div  style="width: 100%; padding: 0px; margin: 0px; float: left;">
                                        <table  class="table">
                                            <thead>
                                                <tr>
                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Selected Investigation
                                                    </th>

                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Price
                                                    </th>
                                                    <th>

                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <div style=" text-align: center; max-height:  150px; overflow-y: scroll; padding: 10px 20px; border: 1px solid #CCC;">

                                        <table class="table table-condensed" id="selected_tests">

                                            <tbody>

                                            </tbody>

                                        </table> 
                                    </div>
                                    <table style=" text-align: center; ">
                                        <tfoot>
                                            <tr>
                                                <th>
                                                    <b style="padding-left: 25px; font-size: 15px;"> Total Bill </b>

                                                </th>
                                                <th style="text-align: right;padding-right: 45px; font-size: 15px;" id="labtestpricetotal">

                                                </th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </td>
                                <td style="width: 50%; vertical-align: top;">
                                    <div style="width: 100%; padding: 0px; margin: 0px; float: left;">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th style="color: #FFF; text-align: left;font-size: 13px;">
                                                        Referred By
                                                    </th>
                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Facility
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <td>
                                                <select name="refer">
                                                    <option value="">Select</option>
                                                    <%List doctors = mgr.listDoctors();
                                                        for (int i = 0; i < doctors.size(); i++) {
                                                            ReferringDoctors doctors1 = (ReferringDoctors) doctors.get(i);
                                                    %>

                                                    <option value="<%=doctors1.getNameName()%>"><%=doctors1.getNameName()%></option>
                                                    <%}%>
                                                </select>

                                            </td>
                                            <td>
                                                <select name="hospital">
                                                    <option value="">Select</option>
                                                    <%List facilities = mgr.listFacilities();
                                                        for (int i = 0; i < facilities.size(); i++) {
                                                            Facility facility = (Facility) facilities.get(i);
                                                    %>

                                                    <option value="<%=facility.getFacilityName()%>"><%=facility.getFacilityName()%></option>
                                                    <%}%>
                                                </select>

                                            </td>
                                            <tr>
                                                <td>

                                                </td>
                                                <td style="padding-top: 50px;">
                                                    <input type="hidden" name="patient" value="<%=p.getPatientid()%>"/>
                                                    <input type="hidden" name="contype" id="contype" value=""/>
                                                    <!--button class="btn btn-danger" type="submit" id="action" name="action" value="forward">
                                                        <i class="icon-arrow-right icon-white"> </i> Forward to Main Laboratory
                                                    </button-->
                                                    <button class="btn btn-danger btn-large" type="submit" id="action" name="action" value="forward">
                                                        <i class="icon-arrow-right icon-white"> </i> Proceed & Assign Laboratory No..
                                                    </button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>



                    </div>
                    <div class="clearfix"></div>
                    <!--/div-->
                </div>
            </form>
        </div>


        <%}%>
        <%if (list != null) {%>

        <div class="container-fluid">
            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>

                    <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Patient Number </th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Registered On</th>
                                    <th style="text-align: center;"></th>

                                </tr>
                            </thead>
                            <tbody>
                                <%for (int i = 0; i < list.size(); i++) {
                                        LabPatient pp = (LabPatient) list.get(i);
                                        System.out.println("test " + list.size());
                                %>
                                <tr class="odd gradeX">
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= pp.getFname()%>, <%= pp.getLname()%> <%= pp.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(pp.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= pp.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= pp.getEmployer()%>  </td>  </tr> <tr> <td> Payment </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>"><b><a class="patientid"><%= pp.getPatientid()%></a></b></td>
                                    <td style="text-align: left;"><%= pp.getFname()%>  <%= pp.getMidname()%> <%= pp.getLname()%> 
                                    </td>
                                    <td style="text-align: left;"><%= mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                    <td style="text-align: left;">  <%= formatter.format(pp.getDateofbirth())%> </td>
                                    <td style="text-align: left;"> <%=formatter.format(mgr.getLabPatientByID(pp.getPatientid()).getDateofregistration())%>
                                    </td>
                                    <td style="text-align: center;">
                                        <div style="text-align: center;" id="d_<%=pp.getPatientid()%>" style="display: block">
                                            <a  id="<%=pp.getPatientid()%>_patientidlink"  class="btn btn-info btn-small" onclick='getType()'> <i class="icon-pencil icon-white"> </i> New Lab Test </a>
                                        </div>
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
        </div>

        <%for (int i = 0; i < list.size(); i++) {
                LabPatient ppp = (LabPatient) list.get(i);
        %>
        <div style="max-height: 90%; overflow-y: scroll; display: none;" class=" hide" id="<%= ppp.getPatientid()%>_dialog"  title="Laboratory Processing for  <%= mgr.getLabPatientByID(ppp.getPatientid()).getFname()%> <%if (mgr.getLabPatientByID(ppp.getPatientid()).getLname() != null) {%> <%= mgr.getLabPatientByID(ppp.getPatientid()).getMidname()%> <% }%> <%= mgr.getLabPatientByID(ppp.getPatientid()).getLname()%>  ">
            <div class="well thumbnail">
                <form id="select_labs"  class="form-inline"  action="action/labaction.jsp" method="post">
                    <div class="center" id="lab">
                        <table>
                            <tr>
                                <td style="text-align: center;">
                                    <div id="tabs">
                                        <ul>
                                            <li><a href="#tabs-1">Investigations</a></li>

                                        </ul>
                                        <%
                                            List labTypes = mgr.listLabTypes();
                                            Labtypes labType;
                                            int labTypesNum = 0;
                                            TreeMap<Integer, String> labTypesMap = new TreeMap<Integer, String>();
                                            TreeMap<Integer, Labtypes> labTypesObjectMap = new TreeMap<Integer, Labtypes>();

                                            if (!labTypes.isEmpty()) {
                                                labTypesNum = labTypes.size();
                                            }
                                        %>
                                        <div id="tabs-1">

                                            <div class="tabs">
                                                <ul>
                                                    <%
                                                        if (labTypesNum > 0) {
                                                            int tabNum = 0;
                                                            for (int y = 0; y < labTypes.size(); y++) {
                                                                labType = (Labtypes) labTypes.get(y);
                                                                if (labType.getActive() == 1) {
                                                                    tabNum = y + 1;
                                                    %>
                                                    <li><a style="text-transform: capitalize;" href="#tabs-<%=tabNum%>"><%=labType.getLabType()%></a></li>
                                                    <%        labTypesMap.put(tabNum, labType.getLabType());
                                                                }
                                                            }
                                                        }%>
                                                </ul>

                                                <% if (!labTypes.isEmpty()) {
                                                        int colNum = 0;
                                                        int labTypeId = 0;
                                                        for (int h = 0; h < labTypes.size(); h++) {
                                                            labType = (Labtypes) labTypes.get(h);
                                                            labTypeId = labType.getLabTypeId();
                                                            if (labType.getActive() == 1) {
                                                                colNum = h + 1;
                                                %>
                                                <div id="tabs-<%=colNum%>">
                                                    <div class="center" id="lab">

                                                        <table>
                                                            <tr>
                                                                <td>

                                                                    <%

                                                                        investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                                        if (investigations != null) {
                                                                    %>
                                                                    <div style="float: left"  class="radioset"> 
                                                                        <% for (int y = 0; y < investigations.size(); y++) {
                                                                                Investigation investigation = (Investigation) investigations.get(y);
                                                                                if (investigation != null) {%>

                                                                        <input class="selected_result"  style="margin-top: 10px; width: 200px; "  type="checkbox" name="labtest1" id="test<%= investigation.getDetailedInvId()%>" labid="<%=investigation.getDetailedInvId()%>" labtestname="<%=investigation.getName()%>" labtestpricevalue="<%=df.format(investigation.getRate())%>" labtestprice="GH&#162;<%=df.format(investigation.getRate())%>"  value="<%=investigation.getRate()%>><<%= investigation.getDetailedInvId()%>"/>
                                                                        <label style="width: 270px; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName().toLowerCase()%> <span class='pull-right brand'>GH&#162;<%=df.format(investigation.getRate())%></span></label>

                                                                        <% }
                                                                            }%>
                                                                    </div> 

                                                                    <% }%>


                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                                <% }
                                                        }
                                                    }%>
                                            </div>
                                        </div>


                                    </div>


                                </td> 
                            </tr>
                        </table>


                        <table>
                            <tr>
                                <td style="width: 50%; vertical-align: top;">
                                    <div  style="width: 100%; padding: 0px; margin: 0px; float: left;">
                                        <table  class="table">
                                            <thead>
                                                <tr>
                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Selected Investigation
                                                    </th>

                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Price
                                                    </th>
                                                    <th>

                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <div style=" text-align: center; max-height:  150px; overflow-y: scroll; padding: 10px 20px; border: 1px solid #CCC;">

                                        <table class="table table-condensed" id="selected_tests">

                                            <tbody>

                                            </tbody>

                                        </table> 
                                    </div>
                                    <table style=" text-align: center; ">
                                        <tfoot>
                                            <tr>
                                                <th>
                                                    <b style="padding-left: 25px;font-size: 15px;"> Total Bill </b>

                                                </th>
                                                <th style="text-align: right; padding-right: 45px;" id="labtestpricetotal">

                                                </th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </td>
                                <td style="width: 50%; vertical-align: top;">
                                    <div style="width: 100%; padding: 0px; margin: 0px; float: left;">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Referred By
                                                    </th>
                                                    <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                        Facility
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <select name="refer">
                                                            <option value="">Select</option>
                                                            <%List doctors = mgr.listDoctors();
                                                                for (int r = 0; r < doctors.size(); r++) {
                                                                    ReferringDoctors doctors1 = (ReferringDoctors) doctors.get(r);
                                                            %>

                                                            <option value="<%=doctors1.getNameName()%>"><%=doctors1.getNameName()%></option>
                                                            <%}%>
                                                        </select>

                                                    </td>
                                                    <td>
                                                        <select name="hospital">
                                                            <option value="">Select</option>
                                                            <%List facilities = mgr.listFacilities();
                                                                for (int r = 0; r < facilities.size(); r++) {
                                                                    Facility facility = (Facility) facilities.get(r);
                                                            %>

                                                            <option value="<%=facility.getFacilityName()%>"><%=facility.getFacilityName()%></option>
                                                            <%}%>
                                                        </select>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>

                                                    </td>
                                                    <td style="padding-top: 50px;">
                                                        <input type="hidden" name="patient" value="<%=ppp.getPatientid()%>"/>
                                                        <input type="hidden" name="contype" id="contype" value=""/>
                                                        <!--button class="btn btn-danger" type="submit" id="action" name="action" value="forward">
                                                            <i class="icon-arrow-right icon-white"> </i> Forward to Main Laboratory
                                                        </button-->
                                                        <button class="btn btn-danger btn-large" type="submit" id="action" name="action" value="forward">
                                                            <i class="icon-arrow-right icon-white"> </i> Proceed & Assign Laboratory No..
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>











                    </div>
                    <div class="clearfix"></div>
                    <!--/div-->
                </form>
            </div>
        </div>

        <% }
        } else {

        %>

        <br/>
        <br/>
        <br/>

        <div class="alert hide alert-info container center">
            <b> No Results Found!  </b>
        </div>
        <br/>
        <div class="container-fluid center">


            <!--    <img id="bgimage"  class="center hide" width="40%" src="images/logoonly.png" /> --->

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
        <script src="js/jquery.validate.min.js"></script>

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
            
            (function($) {
                if ($.ui && $.ui.dialog && $.browser.webkit) {
                    $.ui.dialog.overlay.events = $.map(['focus', 'keydown', 'keypress'], function(event) { 
                        return event + '.dialog-overlay';
                    }).join(' ');
                }
            }(jQuery));
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();

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
                
                
            
                var counter = 0;
                var labtestpricetotal = 0;
            
                $(".selected_result").change(function(){
                    var labtestname =  $(this).attr("labtestname");
                   
                    var labtestprice = $(this).attr("labtestprice");
                    var labtestpricevalue = $(this).attr("labtestpricevalue");
                    var labid = $(this).attr("labid");
                    
                    
                    
                   
                    if($(this).is(':checked')){ 
                        
                        counter = counter + 1;
                        $(this).addClass("counter"+counter)
                        labtestpricetotal = parseInt(labtestpricetotal) + parseInt(labtestpricevalue)
                        $("#labtestpricetotal").html("<b> GH&#162;"+parseFloat(labtestpricetotal).toFixed(2)+ "</b>")
                        $('#selected_tests tbody').append("<tr class="+labid+"><td style='text-transform: capitalize;'  class="+labid+">"+labtestname+"</td><td style='text-align: right;' class="+labid+">"+ labtestprice +" </td></tr>");
                        
                        
                        
                        //    alert("labtestname="+labtestname);
                        // alert("labid="+labid);
                        // alert("labtestprice="+labtestprice);
                        // alert("labtestpricevalue="+labtestpricevalue);
                        //return false;
                        
                   
                    }else{
                      
                        
                        labtestpricetotal = parseInt(labtestpricetotal) - parseInt(labtestpricevalue)
                        $("."+labid).hide();
                        $("#labtestpricetotal").html("<b> GH&#162;"+parseFloat(labtestpricetotal).toFixed(2)+ "</b>")
                     
                        
                    }
                    
                    
                    
                });
                
                
                $('#select_labs').validate({
                    rules: {
                        
                        labtest1: {
                            required: true 
                        },
                        
                        refer: {
                        
                            required: true
                        },
                        hospital: {
                            
                            required: true
                        }
                                
            
                    },
                    highlight: function(label) {
                        $(label).closest('.control-group').addClass('error');
                    },
                    success: function(label) {
                        label
                        .text('OK!').addClass('valid')
                        .closest('.control-group').addClass('success');
                    }
                });
                
                 
                

            });

        </script>
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8">
            var addcount = 0;
            var tt =0;
            $(document).ready(function() {
                $("input:checkbox").attr("checked", false);
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
                
                $("#refer").live('keyup', function(){
                
                    alert($(this).val());
                    //$("#refertext").attr("value",$("refer").val());
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
            
            /* function getContype(){
                var show = document.getElementById("ty").value
                document.getElementById("contype").value = show;
                var t = document.getElementById("contype").value;
            }
             */
            function getType(i,d){
                var show = document.getElementById(i).value
                document.getElementById(d).value = show;
                var t = document.getElementById("contype").value;
            }
            
            function addInvestigationCheck(id1,id2,id3,id4){
                // alert(id1);
                addcount++;
                var t1 = document.getElementById(id1).value;
                // var text = document.getElementById(id1);
                // alert(t1);
                var tr = document.createElement("tr");
                var td1 = document.createElement("td"); 
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                
                var tr1 = document.createElement("tr");
                var td7 = document.createElement("td"); 
                var td8 = document.createElement("td");
                var td9 = document.createElement("td");
                
                var tr2 = document.createElement("tr");
                
                var cb = document.createElement( "input" );
                var input = document.createElement( "input" );
                var btn = document.createElement( "button" );
                var btn1 = document.createElement( "button" );
                btn.innerHTML = 'Remove';
                btn1.innerHTML = 'Remove';
                cb.type = "checkbox";
                input.type = "text";
                cb.id = "id";
                input.id ="in_"+addcount;
                cb.name = "labtest1";
                var ttt = t1;
                var str = t1.split("><");
                
                var text = document.createTextNode(str[0]+" ---  "+str[2]+"0");
                var text1 = document.createTextNode(str[0]);
                var text2 = document.createTextNode(str[2]);
                //var price = document.createTextNode(str[2]);
                cb.value = ttt;
                cb.checked = true;
                td1.appendChild(text);
                td6.appendChild(btn);
                
                td5.appendChild(cb);
                tr.id = "tr1_"+addcount;
                tr.appendChild(td1);
                tr.appendChild(td5);
                tr.appendChild(td6);
                
                tr1.id = "tr1_"+addcount;
                td7.appendChild(text1);
                td8.id = "td_"+addcount;
            
              
                input.value = ttt;
                input.name="labtest[]"
                // input.value = input.name;
                //input.disabled = "disabled";
                
                td9.appendChild(input);
                tr1.appendChild(td7);
                // tr1.appendChild(td9);
                tr2.id = "tr1_"+addcount;
                tr1.appendChild(td8);
                tr2.appendChild(td9);
                document.getElementById(id2).appendChild(tr);
                document.getElementById(id3).appendChild(tr1);
                document.getElementById(id4).appendChild(tr2);
                //  document.getElementById(id3).appendChild(total);
                //var ch = document.getElementById("labtest");
               
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id2);
                    var tb2 = document.getElementById(id3);
                    var tb3 = document.getElementById(id4);
                    
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        tb2.removeChild(document.getElementById(tr1.id));
                        tb3.removeChild(document.getElementById(tr2.id));
                        addcount--;
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
            }
            
            function getTotal(){
                var vl="";
                for(var i=1;i<= addcount;i++){
                    vl = document.getElementById("in_"+i).value;
                    tt = tt + parseInt(vl, 0);
                }
                return tt;
                //alert(tt);
            }
            
            function printSelection(node){

                var content=node.innerHTML
                var pwin=window.open('','print_content','width=800,height=1000');

                pwin.document.open();
                pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                pwin.document.close();
 
                setTimeout(function(){pwin.close();},1000);

            }
            $(document).ready(function(){ 
                $("#new_dialog").dialog({
                    autoOpen : true,
                    width : "90%",
                    modal :true

                });
    
                $("#new_dialog_link").click(function(){
      
                    $("#new_dialog").dialog('open');
    
                })   
            
            })
        </script>
        <% if (list != null) {
                for (int i = 0;
                        i < list.size();
                        i++) {
                    LabPatient vst = (LabPatient) list.get(i);
        %>
        <script type="text/javascript">
   
            $(document).ready(function(){   
                
                
            <%  if (list.size() == 1) {%>  
                    $("#<%= vst.getPatientid()%>_dialog").dialog({
                        autoOpen : true,
                        width : "90%",
                        modal :true,
                        position : 'top'

                    });
                
            <% } else {%>
                    
                    $("#<%= vst.getPatientid()%>_dialog").dialog({
                        autoOpen : false,
                        width : "90%",
                        modal :true,
                        position : 'top'

                    });
                    
                    
            <% }%>
                })     
    
                $("#<%= vst.getPatientid()%>_patientidlink").click(function(){
      
                    $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
                })    
   
        
   
    
        </script>
        <% }
            }%>



    </body>
</html>
