<%@page import="entities.Patienttreatment"%>
<%@page import="entities.Patientinvestigation"%>
<%@page import="entities.Patientdiagnosis"%>
<%@page import="entities.Claimtable"%>
<%@page import="java.util.List"%>
<%@page import="entities.ExtendedHMSHelper"%>
<%@page import="entities.Users"%>
<%
    Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();

    String patientid = request.getParameter("id");
    Double total = 0.0;
    Double ccost = 0.0;
    Double tcost = 0.0;
    Double incost = 0.0;
    Claimtable claim = null;
    int visitid = 0;
    try {
        patientid = request.getParameter("id");
        visitid = Integer.parseInt(request.getParameter("sid"));

        ccost = Double.parseDouble(request.getParameter("ccost"));
        tcost = Double.parseDouble(request.getParameter("tcost"));
        incost = Double.parseDouble(request.getParameter("incost"));
        total = ccost + tcost + incost;
        List claims = mgr.listClaimsWithVisitId(visitid);
        claim = (Claimtable) claims.get(0);
        mgr.updateClaim(claim.getTableid(), total);
    } catch (NullPointerException ne) {
        session.setAttribute("lasterror", "Sorry you cannot access this page");
        response.sendRedirect("index.jsp");
        return;
    } catch (NumberFormatException nf) {
        session.setAttribute("lasterror", "Sorry you cannot access this page");
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>NHIS CLAIM FORM</title>
        <!--   <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <meta name="description" content="">
           <meta name="author" content="">  -->
        <!-- Le styles -->
        <link href="css/bootstrap.css" media="screen" rel="stylesheet">
        <!-- <link href="css/form_style.css" media="screen" rel="stylesheet">   -->

        <style>
            body {
                padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
                font: 12px/1.2 Verdana, sans-serif;
            }
        </style>
        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Le fav and touch icons -->

    </head>
    <body id="nhis_scheme">
        <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" >

            <div class="navbar navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
                        <div class="nav-collapse">
                            <ul class="nav">
                                <li  class="active">
                                    <a  href="#nhis_scheme">NHIS</a>
                                </li>
                                <li>
                                    <a href="#client_information">Client Information</a>
                                </li>
                                <li>
                                    <a href="#services_provided">Services Provided</a>
                                </li>
                                <li>
                                    <a href="#procedures">Procedures</a>
                                </li>
                                <li>
                                    <a href="#diagnoses">Diagnosis</a>
                                </li>
                                <li>
                                    <a href="#investigations">Investigations</a>
                                </li>
                                <li>
                                    <a href="#medicines">Medicines</a>
                                </li>
                                <li>
                                    <a href="#claim_summary">Claim Summary</a>
                                </li>
                                <li>
                                    <a href="#" onclick='printSelection(document.getElementById("print"));return false' ><i class="icon-print"></i>Print this page</a>
                                </li>
                            </ul>
                        </div><!--/.nav-collapse -->
                    </div>
                </div>
            </div>

            <div id="print"  style="padding-bottom: 400px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" class="container">
                <div style="margin-bottom: 10px;" class="row">
                    <div style="width:60px; margin-left: 40px; float: left;">
                        <img src="NHIS LOGO.jpg" />
                    </div>
                    <div style="width:870px; margin-left: 130px; float: left; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" >
                        <h2> NATIONAL HEALTH INSURANCE SCHEME </h2>
                        <div  style="padding-left: 40px;width:170px; margin-left: 30px; float: left;">
                            <br />
                            <u> Claim Form </u>
                            <br />
                            <br />
                            <div style="margin-top: 6px; " class="form-inline">
                                (Regulation 62)
                            </div>
                        </div>
                        <div class="span5 " style="padding-left: 40px; width:470px; margin-left: 30px; float: left; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif">
                            <br />
                            Form no.
                            <br />
                            <br />
                            <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-align: left" class="form-inline">
                                HI Code
                                <input type="text" style="width: 360px; display: inline-block; margin-bottom: 0px; float: none; margin-left: 0px;"  placeholder="">
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <br />
                <div style="text-align: center; clear: both; margin-left: -30px; background-color: #F5F5F5;
                     border: 1px solid rgba(0, 0, 0, 0.05);
                     border-radius: 4px 4px 4px 4px;
                     box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
                     margin-bottom: 20px;
                     min-height: 20px;
                     padding: 19px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif ">
                    <span style="font-size: 10px; font-style: italic;"> Important! this for should be completed in CAPITAL LETTERS using BLACK OR DARK BLUE ball point / fountain pen. Characters and Marks used should be similar in the style to the following
                        <br />
                    </span>
                    <span style="font-weight: bold; font-size: 15px; letter-spacing: 4px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif"> A B C D E F G H I J K L M N O P Q R S T U V W X Y Z  | 1 2 3 4 5 6 7 8 9 0
                        <input style="margin-top: -4px;" type="checkbox"  readonly="readonly" />
                        <input style="margin-top: -4px;" type="checkbox" checked="checked" readonly="readonly" />
                    </span>
                </div>
                <div class="row-fluid" style="padding-top: 20px; clear: both; width: 100%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif">
                    <span style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-align: center;" class="form-inline">
                        <div class="span2 labels" style="padding-top: 0px; padding-left: 40px; width: 150px; float: left; margin-left: 30px;  ">
                            Name of Scheme
                        </div>
                        <input style="width: 660px; display: inline-block; margin-left: 0px; font-weight: normal;" type="text" class="span9">
                    </span>
                    <br />
                    <br />
                    <span style="padding-top: 20px; clear: both; width: 100%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="form-inline span12">
                        <div class="span2 labels" style="padding-top: 0px; padding-left: 40px; width: 150px; float: left; margin-left: 30px; ">
                            Claim Number
                        </div>
                        <div class="span4" style="margin-left: 0px;" >
                            <input type="text" style=" display: inline-block; margin-left: 0px; font-weight: normal;"  class="span3 pull-left" disabled="disabled" value="<%=claim.getClaimid()%>">
                        </div>
                        <div class="input-small labels pull-left" style="padding-top: 0px; padding-left: 0px; width: 150px; float: left; ">
                            Date of Claim
                        </div>
                        <div style="padding-top: 0px; padding-left: 0px; width: 270px;" class="span4">

                            <input style="margin-bottom: 0px; float: left; margin-left: 0px;" type="type" name="claimdate" disabled="disabled" value=" <%=claim.getClaimDate()%>"  />
                        </div>
                    </span>
                </div>
                <hr  />
                <div class="row-fluid " style="padding-top: 20px;">
                    <ul class="breadcrumb">
                        <li>
                            <a href="#">Client Information</a></span>
                        </li>
                    </ul>
                    <div style="margin-left: 0px;" class="span8">
                        <span style="margin-left: 0px;" class="form-inline span7">
                            <div class="span2 labels" style="padding-top: 7px;">
                                Surname
                            </div>
                            <input type="text" class="span5" disabled="disabled" value="<%=mgr.getPatientByID(patientid).getLname()%>">
                        </span>
                        <span style="margin-left: 0px; margin-top: 15px;" class="form-inline span7">
                            <div class="span2 labels" style="padding-top: 7px;">
                                Other Names
                            </div>
                            <input type="text" class="span5" disabled="disabled" value="<%=mgr.getPatientByID(patientid).getMidname()%> <%=mgr.getPatientByID(patientid).getFname()%>">
                        </span>
                    </div>
                    <div class="span3 ">
                        <fieldset style="padding-top: 15px; height: 45px; margin-bottom: 5px;" class="span2" >
                            <legend>
                                Gender
                            </legend>
                            <%if (mgr.getPatientByID(patientid).getGender().equalsIgnoreCase("male")) {%>
                            <table style="margin-left: 20px; margin-top: -14px; ">
                                <tr>
                                    <td>
                                        <input style="margin-bottom: 0px;" type="radio" name="gender" checked="checked"/>
                                    </td>
                                    <td><label style="margin-left: 10px;">Male</label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input  style="margin-bottom: 0px;"  type="radio" name="gender"  />
                                    </td>
                                    <td><label style="margin-left: 10px;">Female</label></td>
                                </tr>
                            </table>
                            <%}
                                if (mgr.getPatientByID(patientid).getGender().equalsIgnoreCase("female")) {%>
                            <table style="margin-left: 20px; margin-top: -14px; ">
                                <tr>
                                    <td>
                                        <input style="margin-bottom: 0px;" type="radio" name="gender"/>
                                    </td>
                                    <td><label style="margin-left: 10px;">Male</label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input  style="margin-bottom: 0px;"  type="radio" name="gender" checked="checked"/>
                                    </td>
                                    <td><label style="margin-left: 10px;">Female</label></td>
                                </tr>
                            </table>
                            <%}%>
                        </fieldset>
                    </div>
                </div>
                <div class="row-fluid" style="padding-top: 10px;">
                    <div style="margin-left: 0px;" class="span12">
                        <span style="margin-left: 0px;" class="form-inline span11">
                            <div class="span2 labels pull-left" style="padding-top: 7px;">
                                Date of Birth
                            </div>
                            <div style="margin-left: 0px;"  class="span4">
                                <input style="margin-bottom: 0px;" type="type" name="claimdate" disabled="disabled" value=" <%=mgr.getPatientByID(patientid).getDateofbirth()%>"  />

                            </div>
                            <div class="span1 labels pull-left" style="padding-top: 7px;">
                                Age
                            </div>
                            <div class="span1">
                                <input type="text" class="span1 pull-left"  disabled="disabled" value="<%=claim.getPatientage()%>">
                            </div>
                            <div class="span1 labels pull-left" style="padding-top: 7px;">
                                NHIS No.
                            </div>
                            <div id="services_provided" class="span2">
                                <input type="text" class="span2" disabled="disabled" value="<%=mgr.sponsorshipDetails(patientid).getMembershipid()%>" />
                            </div> </span>
                    </div>
                </div>
                <hr  />
                <div class="row-fluid">
                    <ul class="breadcrumb">
                        <li>
                            <a > Services Provided </a> (to be filled by all health care providers)
                        </li>
                    </ul>
                    <div class="span6 pull-left" style=" display:block; margin-left: 0px;">
                        <fieldset style=" display:block; padding-top: 15px; margin-bottom: 5px;" class="span6" >
                            <legend>
                                Type of Services
                            </legend>
                            <table class="span5">
                                <tr>
                                    <td colspan="2">
                                        <table style="border-right: 1px solid black; " class="span4">
                                            <tr>
                                                <td><span style="float: left;">(a) </span></td>
                                                <td align="center" colspan="2"><label> <b> <i> select only one</i> </b></label></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td><span class="form-inline">
                                                        <input type="radio" disabled <%=mgr.getVisitById(visitid).getPatientstatus() == "Out Patient" ? "checked" : ""%>/>

                                                        <label>Out-patient</label>
                                                    </span></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td><span class="form-inline">
                                                        <input type="radio" disabled/>
                                                        <label>Diagnostic</label> </span></td>
                                                <td><span class="form-inline">
                                                        <input type="radio" disabled/>
                                                        <label>In-patient</label> </span></td>
                                            </tr>
                                        </table></td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td ><span class="form-inline">
                                                        <input type="radio" disabled/>
                                                        <label>Pharmacy </label> </span></td>
                                            </tr>
                                        </table></td>
                                </tr>
                                <tr style="border-top: 1px solid black; padding-top: 10px;" >
                                    <td colspan="3">
                                        <table class="span4">
                                            <tr>
                                                <td><span style="float: left;">(a) </span></td>
                                                <td align="center" colspan="2"><b> <i> </i> </b></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td><span class="form-inline">
                                                        <input type="radio" disabled/>
                                                        <label> All Inclusive </label> </span></td>
                                                <td><span class="form-inline">
                                                        <input type="radio" disabled/>
                                                        <label>Unbundled</label> </span></td>
                                            </tr>
                                        </table></td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style=" display:block; float: left;" class="span6	" >
                            <legend>
                                Outcome
                            </legend>
                            <table class="span5">
                                <tr>
                                    <td><span class="form-inline">
                                            <input type="radio" disabled/>
                                            <label> Discharged</label> </span></td>
                                    <td><span class="form-inline">
                                            <input type="radio" disabled/>
                                            <label> Died </label> </span></td>
                                    <td><span class="form-inline">
                                            <input type="radio" disabled/>
                                            <label> Transfered Out</label> </span></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><span class="form-inline">
                                            <input type="radio" />
                                            <label> Absconded/ Discharged against medical advice </label> </span></td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="display:block; float: left; margin-top: 10px;" class="span11" >
                            <legend>
                                Type of Attendance
                            </legend>
                            <table class="span11">
                                <tr>
                                    <td><span class="form-inline">
                                            <input type="radio" />
                                            <label> Chronic Follow Up</label> </span></td>
                                    <td><span class="form-inline">
                                            <input type="radio" />
                                            <label>Emergency/ Acute episode </label> </span></td>
                                    <td><span class="form-inline"> <label> Specialty Code </label>
                                            <input type="text" class="span1" />
                                        </span></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><span class="form-inline"> <label id="procedures" class="span3"> Specialty Description </label>
                                            <input type="text" class="span8" />
                                        </span></td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="span5">
                        <fieldset style="padding-bottom: 38px;" class="span5" >
                            <legend>
                                Date(s) of Service Provision
                            </legend>
                            <label for="firstname" style="text-align: left;"  class="span2" accesskey="f">1st Visit/Admission: </label>
                            <input type="text" id="firstname" class="span3" disabled="" name="firstname" tabindex="1" value="<%=claim.getFirstVisit() == null ? "" : claim.getFirstVisit()%>" title="first name">
                            <br>
                            <label for="firstname" class="span2" accesskey="f">2nd Visit/Discharge: </label>
                            <input type="text" id="lastname" class="span3" disabled name="lastname" tabindex="2" value="<%=claim.getSecondVisit() == null ? "" : claim.getSecondVisit()%>" title="last name">
                            <br>
                            <label for="firstname" class="span2" accesskey="f">3rd Visit: </label>
                            <input type="text" id="email" class="span3" disabled name="email" tabindex="3" value="<%=claim.getThirdVisit() == null ? "" : claim.getThirdVisit()%>" title="email">
                            <br>
                            <label for="firstname" class="span2" accesskey="f">4th Visit: </label>
                            <input type="text" id="email" class="span3" disabled name="email" tabindex="3" value="<%=claim.getFourthVisit() == null ? "" : claim.getFourthVisit()%>" title="email">
                            <br>
                            <label for="firstname" class="span2" accesskey="f">Duration of Spell(days) </label>
                            <input type="text" id="email"class="span1" disabled name="email" tabindex="3" title="email">
                            <br>
                        </fieldset>
                    </div>
                </div>
                <hr />
                <div class="row-fluid" >
                    <ul class="breadcrumb">
                        <li>
                            <a href="#"> Procedure(s) </a> (to be filled by health care providers who have provided out or in patient services)
                        </li>
                    </ul>
                    <table class="span12 table-striped table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Description</th>
                                <th>Date </th>
                                <th>G-DRG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="span3"><span > Procedure 1 </span></td>
                                <td align="center">
                                    <input type="text" class="span5" />
                                </td>
                                <td align="center">
                                    <input type="text" class="span3" />
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" />
                                </td>
                            </tr>
                            <tr>
                                <td class="span3"><span > Procedure 2 </span></td>
                                <td align="center">
                                    <input type="text" class="span5" />
                                </td>
                                <td align="center">
                                    <input type="text" class="span3" />
                                </td>
                                <td  align="center">
                                    <input type="text" class="span2" />
                                </td>
                            </tr>
                            <tr>
                                <td class="span3"><span > Procedure 3 </span></td>
                                <td align="center">
                                    <input type="text" class="span5" />
                                </td>
                                <td align="center">
                                    <input type="text" class="span3" />
                                </td>
                                <td   align="center">
                                    <input type="text" class="span2" />
                                </td>
                            </tr>
                            <tr>
                                <td class="span3"><span > Procedure 4 </span></td>
                                <td align="center">
                                    <input type="text" class="span5" />
                                </td>
                                <td align="center">
                                    <input type="text" class="span3" />
                                </td>
                                <td id="diagnoses"  align="center">
                                    <input type="text" class="span2" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <hr />
                <div class="row-fluid" >
                    <ul class="breadcrumb">
                        <li>
                            <a>Diagnosis(es)</a> (to be filled by healthcare providers who have provided  out or in-patient services)
                        </li>
                    </ul>
                    <table class="span12 table-striped table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Description</th>
                                <th>ICD-10 </th>
                                <th>G-DRG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%List diagnoses = mgr.patientDiagnosis(visitid);
                                if (diagnoses != null) {
                                    for (int z = 0; z < diagnoses.size(); z++) {
                                        Patientdiagnosis patientdiagnosis = (Patientdiagnosis) diagnoses.get(z);
                                        if(patientdiagnosis!=null){
                            %>
                            <tr>
                                <td class="span3"><span > Diagnosis <%=z + 1%> </span></td>
                                <td align="center">
                                    <input type="text" class="span5" Patientinvestigation disabled="" value="<%=mgr.getNHISdiagnosis(patientdiagnosis.getDiagnosisid()).getDescription()%>"/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span3" Patientinvestigation disabled="" value="<%=mgr.getNHISdiagnosis(patientdiagnosis.getDiagnosisid()).getIcd10()%>"/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=mgr.getNHISdiagnosis(patientdiagnosis.getDiagnosisid()).getGdrg()%>"/>
                                </td>
                            </tr>
                            <%}}
                                }%>
                        </tbody>
                    </table>
                </div>
                <hr />
                <div class="row-fluid" >
                    <ul class="breadcrumb">
                        <li>
                            <a>Investigations</a> (to be filled by healthcare providers providing diagnostic services only)
                        </li>
                    </ul>
                    <table class="span12 table-striped table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Description</th>
                                <th>ICD-10 </th>
                                <th>G-DRG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List investigations = mgr.patientInvestigation(visitid);
                                if (investigations != null) {
                                    for (int z = 0; z < investigations.size(); z++) {
                                        Patientinvestigation investigation = (Patientinvestigation) investigations.get(z);
                            %>
                            <tr>
                                <td class="span3"><span > Investigation <%=z + 1%> </span></td>
                                <td align="center">
                                    <input type="text" class="span5" disabled="" value="<%=mgr.getInvestigation(investigation.getInvestigationid()).getName()%>"/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span3" disabled="" value=""/>
                                </td>
                                <td align="center">
                                    <input  type="text" class="span2" disabled="" value="<%=mgr.getInvestigation(investigation.getInvestigationid()).getCode()%>"/>
                                </td>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
                </div>
                <hr />
                <div class="row-fluid" >
                    <ul class="breadcrumb">
                        <li>
                            <a>Medicines </a> (to be filled by healthcare providers who have dispensed medicines)
                        </li>
                    </ul>
                    <table class="span12 table-striped table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Description</th>
                                <th>Price</th>
                                <th>Qty</th>
                                <th>Total Cost</th>
                                <th>Date</th>
                                <th>Code</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List treatments = mgr.patientTreatment(visitid);
                                if (treatments != null) {
                                    for (int z = 0; z < treatments.size(); z++) {
                                        Patienttreatment treatment = (Patienttreatment) treatments.get(z);
                                        tcost = +treatment.getPrice() * treatment.getQuantity();
                            %>
                            <tr>

                                <td class="span1"><span>Medicine <%=z + 1%> </span></td>
                                <td align="center">
                                    <input type="text" class="span4" disabled="" value="<%=mgr.getTreatment(treatment.getTreatmentid()).getTreatment()%>"/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=treatment.getPrice()%>" />
                                </td>
                                <td align="center">
                                    <input type="text" class="span1" disabled="" value="<%=treatment.getQuantity()%>"/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=(treatment.getPrice() * treatment.getQuantity())%>"/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=treatment.getDate()%>"/>
                                </td>
                                <td align="center">
                                    <input  type="text" class="span1" disabled="" value="<%=mgr.getTreatment(treatment.getTreatmentid()).getGdrg()%>"/>
                                </td>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
                </div>
                <hr />
                <div class="row-fluid" >
                    <ul class="breadcrumb">
                        <li>
                            <a>Client Claim Summary </a>
                        </li>
                    </ul>
                    <table class="span8 table-striped table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Type of Service</th>
                                <th>G-DRG/Code</th>
                                <th>Tarrif Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="span1"><span> A </span></td>
                                <td align="center"> In-Patient </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value=""/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled/>
                                </td>
                            </tr>
                            <tr>
                                <td class="span1"><span> B </span></td>
                                <td align="center"> Out-Patient </td>

                                <td align="center">
                                    <input type="text" class="span2" disabled/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=ccost%>" />
                                </td>
                            </tr>
                            <tr>
                                <td class="span1"><span> C </span></td>
                                <td align="center"> Investigations </td>

                                <td align="center">
                                    <input type="text" class="span2" disabled/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=incost%>"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="span1"><label> D </label></td>
                                <td align="center"> Pharmacy </td>

                                <td align="center">
                                    <input type="text" class="span2" disabled/>
                                </td>
                                <td align="center">
                                    <input type="text" class="span2" disabled="" value="<%=tcost%>"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div style=" text-align:center; border: solid 1px #000;" class="span3">
                        Signature
                        <br />
                        <input type="text" class="span2" />
                        <br />
                        Name
                        <br />
                        <input type="text" class="span2" />
                    </div>
                </div>
            </div>
        </div>
       


        <button class="btn btn-info btn-small pull-left" href="" onclick='printSelection(document.getElementById("print"));return false'>
            <i class="icon-white icon-print"></i> Print Invoice
        </button>
        <!-- /container -->
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <%@include file="widgets/javascripts.jsp" %>
    </body>
</html>
<script type="text/javascript">
    
    function printSelection(node){

        var content=node.innerHTML
        
        var pwin=window.open('','print_content','width=1250,height=1000');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
</script>