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
                                int visitid = Integer.parseInt(request.getParameter("visitid"));
                                visit = mgr.getVisitById(visitid);



                            %>

                            <tr>
                                <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>  </h5> <span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getBenefitplan()%> </td> </tr>  </table> ">
                                    <% if (mgr.getPatientByID(visit.getPatientid()).getEmergencyPatient() == 1) {%> 
                                    <%=mgr.getPatientByID(visit.getPatientid()).getPatientid()%>EMG 
                                    <% } else {%>
                                    <%=mgr.getPatientByID(visit.getPatientid()).getPatientid()%>
                                    <%}%> 
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
                                    <a href="opdentry.jsp" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>link"  class="visitlink btn btn-info btn-small"> <i class="icon-pencil icon-white"> </i> Save Vitals </a>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div> 

                <div class="clear"></div>
            </div>

        </section>





        <div style="max-height: 600px;  display: none; overflow-x: hidden;" class="visit hide" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>"  title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%; text-transform: uppercase;'> NURSES ENQUIRY | <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>  |  <%= mgr.getPatientByID(visit.getPatientid()).getPatientid()%> </span>">
            <form id="vitals<%=visit.getVisitid()%>" action="action/vitalaction.jsp" method="post" class="form-horizontal">


                <div style=" width: 25%; float: left;">
                    <ul style="margin-left: 0px;" class="menu">
                        <li>  <a class="active opd_enquiry_link "> <i class="icon  icon-question-sign"> </i> Nurse's Enquiry </a> </li>
                        <li>  <a class="opd_vital_link "> <i class="icon  icon-list-alt"> </i> Vitals </a> </li>
                        <!--   <li> <a class="opd_symptoms_link"> <i class="icon icon-check"> </i> Symptoms </a></li>  
                           <li> <a class="opd_allergies_link"> <i class="icon icon-check"> </i> Allergies </a></li>
                           <li> <a class="opd_medical_histories_link"> <i class="icon icon-check"> </i> Medical History </a></li>
                           <li> <a class="opd_social_histories_link"> <i class="icon icon-check"> </i> Social History </a></li>
                           <li> <a class="opd_family_histories_link"> <i class="icon icon-check"> </i> Family History </a></li>  -->
                        <li> <a class="opd_procedures_link"> <i class="icon icon-check"> </i> Procedures </a></li>

                    </ul>
                </div>
                <div class="thumbnail" style="width: 65%; float: left; margin-left: 5%">
                    <fieldset>

                        <div class="opd_enquiry">
                            <ul style="margin-left: 0px; text-align: center;" class="breadcrumb">
                                <li>
                                    <b style="text-align: center;">  NURSE'S ENQUIRY </b>
                                </li>
                            </ul>


                            <div class="control-group">
                                <label class="control-label" style="width: 100%; float: left;">
                                    <lead style="float: left;" > 
                                        <a style="color: #0063DC; font-weight: bold; float: left; "> 
                                            CURRENT CONDITION: </a>  <br />WHAT BRINGS THE PATIENT TO THE CONSULTING ROOM? 
                                    </lead>
                                </label>
                                <div class="clearfix">

                                </div>
                                <div style="float: left; margin-left: 0px; width:100%;" class="controls">

                                    <select name="conditions" data-placeholder="CONDITION" class="chosen-select" multiple style="width:75%;" tabindex="4">
                                        <option value="">CONDITION</option>
                                        <% List problem = mgr.listProblemOptions();

                                            for (int x = 0; x < problem.size(); x++) {
                                                ProblemOptions problemOption = (ProblemOptions) problem.get(x);
                                        %>

                                        <option value="<%=problemOption.getProblemId()%>"><%=problemOption.getProblemName()%></option>

                                        <% }%>
                                    </select>
                                    <span class="help-inline "><button type="button" id="condition_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                </div>

                            </div>
                            <div style="float: left; margin-left: 0px; width:100%;" class="control-group ">
                                <div style="float: left; margin-left: 0px; width:100%;" class="controls">
                                    <textarea id="condition_notes" name="conditionnote" class="hide " type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div class="control-group">
                                <label class="control-label" style="width: 100%; float: left;">
                                    <lead style="float: left;" > 
                                        <a style="color: #0063DC; font-weight: bold; float: left; "> ONSET: </a><br/> WHEN DID PATIENT FIRST NOTICE CONDITION? </lead></label>
                                <div class="clearfix">

                                </div>
                                <div style="float: left; margin-left: 0px; width:100%;" class="controls">
                                    <select name="onsets" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4" data-placeholder="ONSET">
                                        <option value="">ONSET</option>
                                        <% List onset = mgr.listOnsetOptions();

                                            for (int x = 0; x < onset.size(); x++) {
                                                OnsetOptions onsetOption = (OnsetOptions) onset.get(x);
                                        %>

                                        <option value="<%=onsetOption.getOnsetId()%>"><%=onsetOption.getOnset()%></option>

                                        <% }%>
                                    </select>
                                    <span class="help-inline "><button type="button"id="onset_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                </div>
                            </div>
                            <div style="float: left; margin-left: 0px; width:100%;" class="control-group ">
                                <div  style="float: left; margin-left: 0px; width:100%;" class="controls">
                                    <textarea class="hide" id="onset_notes" name="onsetnote" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>

                            <div class="control-group">
                                <label class="control-label" style="width: 100%; float: left;">
                                    <lead style="float: left;" > 
                                        <a style="color: #0063DC; font-weight: bold; float: left; "> RELIEF: </a><br/> WHAT MAKES THE CONDITION BETTER? </lead></label>
                                <div class="clearfix">

                                </div>
                                <div style="float: left; margin-left: 0px; width:100%;" class="controls">
                                    <select name="reliefs" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4"  data-placeholder="RELIEF">
                                        <option value="">RELIEF</option>
                                        <% List reliefs = mgr.listReliefOptions();

                                            for (int x = 0; x < reliefs.size(); x++) {
                                                ReliefOptions reliefOption = (ReliefOptions) reliefs.get(x);
                                        %>

                                        <option value="<%=reliefOption.getReliefId()%>"><%=reliefOption.getRelief()%></option>

                                        <% }%>
                                    </select> 
                                    <span class="help-inline "><button type="button" id="relief_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                </div>
                            </div>
                            <div style="float: left; margin-left: 0px; width:100%;" class="control-group ">
                                <div style="float: left; margin-left: 0px; width:100%;" class="controls">
                                    <textarea id="relief_notes" name="reliefnote" class="hide" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>



                        </div>
                        <div class="opd_vital hide">
                            <ul style="margin-left: 0px; text-align: center;" class="breadcrumb">
                                <li>
                                    <b style="text-align: center;">  VITALS </b>
                                </li>
                            </ul>
                            <div style="margin-left: 20%" class="control-group">
                                <label class="control-label" for="input01">Temperature : </label>
                                <div class="controls">
                                    <input type="text" name="temp" class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline">( &#176; C)</p>
                                </div>
                            </div>
                            <div style="margin-left: 20%" class="control-group">
                                <label class="control-label" for="input01">Weight : </label>
                                <div class="controls">
                                    <input type="text" name="weight"  class="input-mini decimal weight<%=visit.getPatientid()%> bmiweight" placeholder="" value=""/>
                                    <p class="help-inline">(kg)</p>
                                </div>
                            </div>
                            <div style="margin-left: 20%" class="control-group">
                                <label class="control-label" for="input01">Height: </label>
                                <div class="controls">
                                    <input type="text" name="height" class="input-mini decimal height<%=visit.getPatientid()%> bmiheight" placeholder="" value=""/>
                                    <p class="help-inline">(cm)</p>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                            <div style="text-align: center; padding-bottom: 15px; "><b style=" text-decoration: underline;">  BLOOD PRESSURE </b></div>
                            <div style="margin-left: 20%" class="control-group">
                                <label class="control-label" for="input01">Systolic </label>
                                <div class="controls">

                                    <input type="text" name="systolic" class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline"> mmHg</p>
                                </div>
                            </div>

                            <div style="margin-left: 20%" class="control-group">
                                <label class="control-label" for="input01">Diastolic </label>
                                <div class="controls">

                                    <input type="text" name="diatolic" class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline"> mmHg</p>
                                </div>
                            </div>

                            <div style="margin-left: 20%" class="control-group">
                                <label class="control-label" for="input01">Pulse: </label>
                                <div class="controls">
                                    <input type="text" name="pulse"class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline">BPM</p>
                                </div>
                            </div>

                        </div>


                        <div class="opd_symptomsthumbnail hide ">
                            <ul style="margin-left: 0px; text-align: center;"class="breadcrumb">
                                <li>
                                    <b>  Symptoms </b>
                                </li>
                            </ul>
                            <%  List patientAllergies = mgr.listAllergiessByPatientid(visit.getPatientid());
                                List symptoms = mgr.listSymptoms();
                                if (patientAllergies != null && symptoms.size() > 0) {%>
                            <div class="control-group">
                                <label class="control-label" for="input01">Select Symptom : </label>
                                <div class="controls">
                                    <select id="symptom<%=visit.getVisitid()%>" name="symptoms" onchange="">
                                        <%
                                            for (int index = 0; index < symptoms.size(); index++) {
                                                Symptoms symptom = (Symptoms) symptoms.get(index);
                                        %>
                                        <option value="<%=symptom.getSymptomname()%>><<%=symptom.getSymptomid()%>"><%=symptom.getSymptomname()%></option>
                                        <%}%>
                                    </select>
                                    <div class="help-inline">
                                        <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addSymptom("symptom<%=visit.getVisitid()%>","symptoms<%=visit.getVisitid()%>");return false;'>
                                            <i class="icon-white icon-plus"> </i>   Add 
                                        </button>
                                    </div>
                                </div>
                            </div> 
                            <table id="symptoms<%=visit.getVisitid()%>" class="table table-bordered">
                                <tr style="padding: 12px 0px 12px 0px;">
                                    <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                        Selected Symptoms
                                    </th>
                                </tr>
                            </table>
                            </p>

                            <%}%>
                            <div class="control-group">
                                <label class="control-label" for="input01">Remarks </label>
                                <div class="controls">
                                    <textarea class="medium"  id="message"  name="symptomnote"></textarea><br/>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                        </div>

                        <div class="opd_allergies  hide">
                            <ul style="margin-left: 0px; text-align: center;"class="breadcrumb">
                                <li>
                                    <b>  Allergies </b>
                                </li>
                            </ul>
                            <div class="control-group">
                                <label class="control-label" for="input01">Select Allergy : </label>
                                <div class="controls">
                                    <select id="allergy<%=visit.getVisitid()%>" name="allergy" onchange="">
                                        <%List l = mgr.listAllergiess();
                                            for (int index = 0; index < l.size(); index++) {
                                                Allergies allergy = (Allergies) l.get(index);
                                        %>
                                        <option value="<%=allergy.getName()%>><<%=allergy.getAllergyid()%>"><%=allergy.getName()%></option>
                                        <%}%>
                                    </select>
                                    <div class="help-inline">

                                        <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addAllergy("allergy<%=visit.getVisitid()%>","selected<%=visit.getVisitid()%>");return false;'>
                                            <i class="icon-white icon-plus-sign"> </i>   Add 
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <table id="selected<%=visit.getVisitid()%>" class="table table-bordered">
                                <tr style="padding: 12px 0px 12px 0px;">
                                    <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                        Selected Allergies
                                    </th>
                                </tr>
                            </table>
                        </div>

                        <div class="opd_procedures  hide">
                            <ul style="margin-left: 0px; text-align: center;"class="breadcrumb">
                                <li>
                                    <b>  PROCEDURES </b>
                                </li>
                            </ul>
                            <div class="control-group">
                                <label class="control-label" for="input01">Select Procedure : </label>
                                <div class="controls">
                                    <select style="width: 80%" id="procedure_<%=visit.getVisitid()%>" name="allergy" onchange="">
                                        <option value=""> Select </option>  
                                        <%List procedures = mgr.listProcedure();
                                            for (int index = 0; index < procedures.size(); index++) {
                                                Procedure procedure = (Procedure) procedures.get(index);
                                        %>
                                        <option value="<%=procedure.getDescription()%>><<%=procedure.getCode()%>><<%=procedure.getPrice()%>"><%=procedure.getDescription()%></option>
                                        <%}%>
                                    </select>
                                    <div class="help-inline">
                                        <button id="addCheckBoxes" type="button" class="btn btn-info btn-small" onclick='addProcedure("procedure_<%=visit.getVisitid()%>","procedure<%=visit.getVisitid()%>");return false;'>
                                            <i class="icon-white icon-plus-sign"> </i>   Add 
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <table id="procedure<%=visit.getVisitid()%>" class="table table-bordered">
                                <tr style="padding: 12px 0px 12px 0px;">
                                    <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                        Selected Procedures
                                    </th>
                                </tr>
                            </table>
                        </div>


                    </fieldset>

                </div>
                <div class="clearfix">

                </div>
                <div style="padding-left: 0px;" class="form-actions center">

                    <div class="clearfix">

                    </div>



                    <button class="btn btn-danger btn-large" style="width: 80%" type="submit" name="action" value="Forward">
                        <i class="icon-arrow-right icon-white"> </i> Forward for Consultation 
                    </button>
                   <!-- <button class="btn btn-info btn-small pull-left" type="button"  href="#" onclick='printSelection(document.getElementById("print<%= visit.getPatientid()%>")); return false'>
                        <i class="icon-print icon-white"> </i> Print Voucher
                    </button>  -->
                    <input type="hidden" name="patientid" value="<%= visit.getPatientid()%>"/>
                    <input type="hidden" name="conroom" value="consultation"/>
                    <input type="hidden" name="id" value="<%=visit.getVisitid()%>"/>


                </div>
            </form>
        </div>
        <div class="clear"></div>


        <%@include file="widgets/footer.jsp" %>s
    </body>
    <%@include file="widgets/javascripts.jsp" %>

    <script src="js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        var config = {
            '.chosen-select'           : {},
            '.chosen-select-deselect'  : {allow_single_deselect:true},
            '.chosen-select-no-single' : {disable_search_threshold:10},
            '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
            '.chosen-select-width'     : {width:"95%"}
        }
        for (var selector in config) {
            $(selector).chosen(config[selector]);
        }
        
        
        $(".chosen-container-multi").css("width","75%")
        $(".default").css("width","100%")
        
    </script>
    <script type="text/javascript">
        $(document).ready(function(){
                                                      
               
            $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog({
                autoOpen : true,
                width : "90%",
                modal :true,
                position : "top"
		
            });
                
            $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>link').click(function(){
                   
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog('open');
                return false;
            });
                
                
                
            $('#vitals<%=visit.getVisitid()%>').validate({
                rules: {
                    temp: {
                        required: true,
                        number: true,
                            
                            
                        range: [14, 45]
                    },
                    weight: {
                        required: true,
                        number: true,
                            
                        range: [0, 500]
                    },
                    height: {
                        required: true,
                        number: true,
                           
                        range: [50, 300]
                    }
                    ,
                    systolic: {
                        required: true,
                        number: true,
                            
                        range: [50, 300]
                        
                    },
                    diatolic: {
                        required: true,
                        number: true,
                            
                        range: [30, 200]
                    },
                    pulse: {
                        required: true,
                        number: true,
                           
                        range: [30, 200]
                        
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
            
    
        
        $(document).ready(function(){
        
        
            $("#condition_notes_link").click(function(){
                $("#condition_notes").slideToggle();
            })
            
            $("#onset_notes_link").click(function(){
                $("#onset_notes").slideToggle();
            })
            
            $("#relief_notes_link").click(function(){
                $("#relief_notes").slideToggle();
            })
            
            
            
           
            $('#sidebar-toggle').click(function(e) {
                
                e.preventDefault();
                $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                $('.menu').animate({width: 'toggle'}, 0);
                $('.menu').toggleClass('span3 hide');
                $('.main-c').toggleClass('span8');
                
            }); 
            
        });
        var addcount=0;
        function addAllergy(id1,id2){
            //alert(id1);
            addcount++;
            var t1 = document.getElementById(id1).value;
            if( t1 != ""){
                var tr = document.createElement("tr");
                var td1 = document.createElement("td"); 
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                // var text = document.createTextNode(document.getElementById(id1).value);
                var cb = document.createElement( "input" );
                var btn = document.createElement( "button" );
                btn.innerHTML = 'Remove';
                cb.type = "checkbox";
                cb.id = "id";
                cb.name = "allergies";
                var ttt = t1;
                var str = t1.split("><");
                var text = document.createTextNode(str[0]);
                cb.value = ttt;
                cb.checked = true;
                td1.appendChild(text);
                td6.appendChild(btn);
                
                td5.appendChild(cb);
                tr.appendChild(td1);
                tr.id = "tr1_"+addcount;
                tr.appendChild(td5);
                tr.appendChild(td6);
                document.getElementById( id2 ).appendChild( tr );
            }else {
                alert("Please Select a Procedure!")
            }    
            btn.onclick = function(){
    
                var tbl = document.getElementById(id2);
                var rem = confirm("Are You Sure You Want To Remove This Allergy");
                if(rem){
                    tbl.removeChild(document.getElementById(tr.id));
                    alert("Removed Successfully");
                    return false;
                }else{
                    return false;
                }
            }
        }
        function addProcedure(id1,id2){
            //alert(id1);
            addcount++;
            var t1 = document.getElementById(id1).value;
            if( t1 != ""){
                var tr = document.createElement("tr");
                var td1 = document.createElement("td"); 
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                // var text = document.createTextNode(document.getElementById(id1).value);
                var cb = document.createElement( "input" );
                var btn = document.createElement( "button" );
                btn.innerHTML = 'Remove';
                cb.type = "checkbox";
                cb.id = "id";
                cb.name = "procedures";
                var ttt = t1;
                var str = t1.split("><");
                var text = document.createTextNode(str[0]);
                cb.value = ttt;
                cb.checked = true;
                td1.appendChild(text);
                td6.appendChild(btn);
                
                td5.appendChild(cb);
                tr.appendChild(td1);
                tr.id = "tr1_"+addcount;
                tr.appendChild(td5);
                tr.appendChild(td6);
                document.getElementById( id2 ).appendChild( tr );
            }else {
                alert("Please Select a Procedure!")
            }    
            btn.onclick = function(){
    
                var tbl = document.getElementById(id2);
                var rem = confirm("Are You Sure You Want To Remove The Procedure");
                if(rem){
                    tbl.removeChild(document.getElementById(tr.id));
                    alert("Removed Successfully");
                    return false;
                }else{
                    return false;
                }
            }
        }
        
        function addSymptom(id1,id2){
            //alert(id1);
            addcount++;
            var t1 = document.getElementById(id1).value;
            var tr = document.createElement("tr");
            var td1 = document.createElement("td"); 
            var td5 = document.createElement("td");
            var td6 = document.createElement("td");
            // var text = document.createTextNode(document.getElementById(id1).value);
            var cb = document.createElement( "input" );
            var btn = document.createElement( "button" );
            btn.innerHTML = 'Remove';
            cb.type = "checkbox";
            cb.id = "id";
            cb.name = "symptoms";
            var ttt = t1;
            var str = t1.split("><");
            var text = document.createTextNode(str[0]);
            cb.value = ttt;
            cb.checked = true;
            td1.appendChild(text);
            td6.appendChild(btn);
                
            td5.appendChild(cb);
            tr.appendChild(td1);
            tr.id = "tr1_"+addcount;
            tr.appendChild(td5);
            tr.appendChild(td6);
            document.getElementById( id2 ).appendChild( tr );
                
            btn.onclick = function(){
    
                var tbl = document.getElementById(id2);
                var rem = confirm("Are you sure you to remove this allergy");
                if(rem){
                    tbl.removeChild(document.getElementById(tr.id));
                    alert("Removed Successfully");
                    return false;
                }else{
                    return false;
                }
            }
        }
        
        function printSelection(node){

            var content=node.innerHTML
            var pwin=window.open('','print_content','width=400,height=900');

            pwin.document.open();
            pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
            pwin.document.close();
 
            setTimeout(function(){pwin.close();},1000);

        }
    
        
    </script>






</html>