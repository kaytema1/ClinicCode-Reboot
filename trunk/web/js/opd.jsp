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
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">
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
            <section id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="span9 offset3 thumbnail well content hide">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th>Folder Number </th>
                                    <th>Full Name </th>
                                    <th>Date of Birth</th>
                                    <th>Sponsor</th>
                                    <th>Registered On</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    //Patient p = (Patient)session.getAttribute("patient");
                                    //get current date time with Date()
                                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                                    Date date = new Date();
                                    //System.out.println(dateFormat.format(date));
                                    List visits = mgr.listUnitVisitations("vitals", dateFormat.format(date));
                                    // List patients = mgr.listPatients();
                                    for (int i = 0; i < visits.size(); i++) {
                                        visit = (Visitationtable) visits.get(i);


                                %>

                                <tr>
                                    <td style="text-transform: uppercase; font-weight: bold" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>  </h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr> <tr>
                                        <td> Policy Number </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getBenefitplan()%> </td> </tr>  </table> ">
                                        <a href="vital.jsp?patientid=<%=visit.getPatientid()%>&id=<%=visit.getVisitid()%>"><%= visit.getPatientid()%> </a> 
                                    </td>
                                    <td>
                                        <%=mgr.getPatientByID(visit.getPatientid()).getFname()%> <%=mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()).getLname()%>
                                    </td>
                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>
                                    </td>
                                    <td>
                                        <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> 
                                    </td>
                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofregistration())%>
                                    </td>

                                    <td>
                                        <a id="<%=visit.getPatientid()%><%=visit.getVisitid()%>link"  class="visitlink btn btn-info btn-small"> <i class="icon-pencil icon-white"> </i> New Records </a>
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

        </div><!-- /container -->



        <%@include file="widgets/javascripts.jsp" %>

        <%   for (int i = 0; i < visits.size(); i++) {
                visit = (Visitationtable) visits.get(i);%>
        <script type="text/javascript">
            $(document).ready(function(){
                                                      
               
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog({
                    autoOpen : false,
                    width : 750,
                    modal :true,
                    position : "top"
		
                });
                
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>link').click(function(){
                   
                    $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog('open');
                    return false;
                });
                
                                                        
                
            });
            
        </script>

        <div style="max-height: 600px;  display: none;" class="visit hide" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>"  title=" <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%> 's Vitals | Folder No: <span style='text-transform: uppercase;'> <%= mgr.getPatientByID(visit.getPatientid()).getPatientid()%> </span>">
            <div class="span7">

                <div style="margin-left: -50px;" class="span2 ">
                    <ul class="menu">
                        <li> <a class="active opd_vital_link "> <i class="icon  icon-list-alt"> </i> Vitals </a></li>
                        <li> <a class="opd_symptoms_link"> <i class="icon icon-check"> </i> Symptoms </a></li>
                        <li> <a class="opd_allergies_link"> <i class="icon icon-check"> </i> Allergies </a></li>
                        <li> <a class="opd_procedures_link"> <i class="icon icon-check"> </i> Procedures </a></li>

                    </ul>
                </div>

                <form action="action/vitalaction.jsp" method="post" class="form-horizontal">
                    <fieldset>
                        <div class="opd_vital span5 thumbnail ">
                            <ul style="margin-left: 0px; text-align: center;" class="breadcrumb">
                                <li>
                                    <b style="text-align: center;">  Vitals </b>
                                </li>
                            </ul>
                            <div class="control-group">
                                <label class="control-label" for="input01">Temperature : </label>
                                <div class="controls">
                                    <input type="text" name="temp" class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline">( &#176; C)</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Weight : </label>
                                <div class="controls">
                                    <input type="text" name="weight"  class="input-mini decimal weight<%=visit.getPatientid()%> bmiweight" placeholder="" value=""/>
                                    <p class="help-inline">(kg)</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Height: </label>
                                <div class="controls">
                                    <input type="text" name="height" class="input-mini decimal height<%=visit.getPatientid()%> bmiheight" placeholder="" value=""/>
                                    <p class="help-inline">(cm)</p>
                                </div>
                            </div>

                      <!--      <div class="control-group">
                                <label class="control-label"> BMI: </label>
                                <div class="controls " style="font-size: 20px;">
                                    <span class="bmivalue<%=visit.getPatientid()%>"> </span>
                                    <p class="help-inline " > <span style="font-weight: bold;" class="bmidesc<%=visit.getPatientid()%>">  </span> </p>
                                    <br />
                                    <br />
                                </div>
                            </div>  -->
                            <div class="clearfix"></div>
                            <div style="text-align: center; padding-bottom: 15px; "><b style=" text-decoration: underline;">  Blood Pressure </b></div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Systolic </label>
                                <div class="controls">

                                    <input type="text" name="systolic" class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline"> mmHg</p>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="input01">Diastolic </label>
                                <div class="controls">

                                    <input type="text" name="diatolic" class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline"> mmHg</p>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="input01">Pulse: </label>
                                <div class="controls">
                                    <input type="text" name="pulse"class="input-mini decimal" placeholder="" value=""/>
                                    <p class="help-inline">BPM</p>
                                </div>
                            </div>

                        </div>


                        <div class="opd_symptoms span5 thumbnail hide ">
                            <ul style="margin-left: 0px; text-align: center;"class="breadcrumb">
                                <li>
                                    <b>  Symptoms </b>
                                </li>
                            </ul>
                            <%  List list = mgr.listAllergiessByPatientid(visit.getPatientid());
                                List symptoms = mgr.listSymptoms();
                                if (list != null && symptoms.size() > 0) {%>
                            <div class="control-group">
                                <label class="control-label" for="input01">Select Symptom : </label>
                                <div class="controls">
                                    <select id="symptom<%=visit.getVisitid()%>" name="symptoms" onchange="">
                                        <%
                                            for (int index = 0; index < symptoms.size(); index++) {
                                                Symptoms allergies = (Symptoms) symptoms.get(index);
                                        %>
                                        <option value="<%=allergies.getSymptomname()%>><<%=allergies.getSymptomid()%>"><%=allergies.getSymptomname()%></option>
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
                                <label class="control-label" for="input01">Symptom Notes </label>
                                <div class="controls">
                                    <textarea class="medium"  id="message"  name="symptomnote"></textarea><br/>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                        </div>

                        <div class="opd_allergies span5 thumbnail hide">
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
                                                Allergies allergies = (Allergies) l.get(index);
                                        %>
                                        <option value="<%=allergies.getName()%>><<%=allergies.getAllergyid()%>"><%=allergies.getName()%></option>
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
                        <div class="opd_procedures span5 thumbnail hide">
                            <ul style="margin-left: 0px; text-align: center;"class="breadcrumb">
                                <li>
                                    <b>  Procedure </b>
                                </li>
                            </ul>
                            <div class="control-group">
                                <label class="control-label" for="input01">Select Procedure : </label>
                                <div class="controls">
                                    <select id="procedure_<%=visit.getVisitid()%>" name="allergy" onchange="">
                                        <%List procedures = mgr.listProcedure();
                                            for (int index = 0; index < procedures.size(); index++) {
                                                Procedure allergies = (Procedure) procedures.get(index);
                                        %>
                                        <option value="<%=allergies.getDescription()%>><<%=allergies.getCode()%>><<%=allergies.getPrice()%>"><%=allergies.getDescription()%></option>
                                        <%}%>
                                    </select>
                                    <div class="help-inline">
                                        <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addProcedure("procedure_<%=visit.getVisitid()%>","procedure<%=visit.getVisitid()%>");return false;'>
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
                    <div class="form-actions">
                       <!-- <button class="btn btn-info btn-small pull-left" type="button"  href="#" onclick='printSelection(document.getElementById("print<%= visit.getPatientid()%>")); return false'>
                            <i class="icon-print icon-white"> </i> Print Voucher
                        </button>  -->
                        <input type="hidden" name="patientid" value="<%= visit.getPatientid()%>"/>
                        <input type="hidden" name="conroom" value="consultation"/>
                        <input type="hidden" name="id" value="<%=visit.getVisitid()%>"/>
                        <button class="btn btn-danger btn-small pull-right" type="submit" name="action" value="Forward">
                            <i class="icon-arrow-right icon-white"> </i> Forward for Consultation 
                        </button>

                    </div>

                </form>

            </div>
        </div>


        <div class="clear"></div>

        <% }%>

    </body>
    <script>
        var addcount=0;
        function addAllergy(id1,id2){
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
        function addProcedure(id1,id2){
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

    <%
        visits = mgr.listUnitVisitations("vitals", dateFormat.format(date));
        // List patients = mgr.listPatients();
        for (int i = 0; i < visits.size(); i++) {
            visit = (Visitationtable) visits.get(i);

    %>
    <script type="text/javascript">
        $(document).ready(function(){
            
            
            
            
            
            $(".weight<%= visit.getPatientid()%>").live('focusout',function(){
                
               
                if( $(".weight<%= visit.getPatientid()%>").attr("value") !=  "" && $(".height<%= visit.getPatientid()%>").attr("value") != "" ){
                    var weight = $(".weight<%= visit.getPatientid()%>").attr("value");
                    var height = $(".height<%= visit.getPatientid()%>").attr("value") / 100;
                    var bmi = weight / (height * height);
                    $(".bmivalue<%=visit.getPatientid()%>").html(bmi.toFixed(1)+ "( cm/kg<sup>2</sup> )");
                    
                     if(bmi < 18.5){
                        
                        $(".bmidesc<%=visit.getPatientid()%>").html("Underweight");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                    }else if( bmi >= 18.5 && bmi <= 24.9  ){
                        
                        $(".bmidesc<%=visit.getPatientid()%>").html("Healthy Weight");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-success').removeClass('text-warning').removeClass('text-error')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-success').removeClass('text-warning')..removeClass('text-error')
                        
                    }else if( bmi >= 25 && bmi <= 29.9){
                        
                        $(".bmidesc<%=visit.getPatientid()%>").html("Overweight");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-warning').removeClass('text-success').removeClass('text-error')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-warning').removeClass('text-success').removeClass('text-error')
                        
                    }else if (bmi >= 30) {
                       
                        $(".bmidesc<%=visit.getPatientid()%>").html("Obese");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                        
                    }
            
                }
                
            })
            
            
            $(".height<%= visit.getPatientid()%>").live('focusout',function(){
                
                
                if( $(".weight<%= visit.getPatientid()%>").attr("value") !=  "" && $(".height<%= visit.getPatientid()%>").attr("value") != "" ){
                    var weight = $(".weight<%= visit.getPatientid()%>").attr("value");
                    var height = $(".height<%= visit.getPatientid()%>").attr("value") / 100;
                    var bmi = weight / (height * height);
                    $(".bmivalue<%=visit.getPatientid()%>").html(bmi.toFixed(1)+ " (cm/kg<sup>2</sup>)");
                    
                    if(bmi < 18.5){
                        
                        $(".bmidesc<%=visit.getPatientid()%>").html("Underweight");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                    }else if( bmi >= 18.5 && bmi <= 24.9  ){
                        
                        $(".bmidesc<%=visit.getPatientid()%>").html("Healthy Weight");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-success').removeClass('text-warning').removeClass('text-error')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-success').removeClass('text-warning')..removeClass('text-error')
                        
                    }else if( bmi >= 25 && bmi <= 29.9){
                      
                        $(".bmidesc<%=visit.getPatientid()%>").html("Overweight");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-warning').removeClass('text-success').removeClass('text-error')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-warning').removeClass('text-success').removeClass('text-error')
                        
                    }else if (bmi >= 30) {
                        
                        $(".bmidesc<%=visit.getPatientid()%>").html("Obese");
                        $(".bmidesc<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                        $(".bmivalue<%=visit.getPatientid()%>").addClass('text-error').removeClass('text-success').removeClass('text-warning')
                        
                    }
            
                }
                
            })
            
            
            
            
            
            
            
            
            
            
        });
        
        
    </script>



    <% }%>


</html>