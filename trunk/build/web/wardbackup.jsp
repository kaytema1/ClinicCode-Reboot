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
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    Visitationtable visit = null;
    HMSHelper itm = new HMSHelper();
    // List itmss = itm.listAppointment();
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <link rel='stylesheet' type='text/css' href='fullcalendar/fullcalendar.css' />
        <link rel='stylesheet' type='text/css' href='fullcalendar/fullcalendar.print.css' media='print' />
        <script type="text/javascript">
            function updateLaborders(){
                alert("Processing");
            }
            var diagnosis = "";
            var treatment = "";
            var investigation = "";
            var addcount = 0;
            
            function showdetails(id){
                var show = document.getElementById(id);
                if(show.style.display == "none"){
                    show.style.display="block";
                }else{
                    // show.style.display = "block"
                    show.style.display="none";             
                }
            }
            function showdTreatment(){
                var show = document.getElementById("treat");
                if(show.style.display == "none"){
                    show.style.display="block";
                }else{
                    // show.style.display = "block"
                    show.style.display="none";             
                }
            }
            function showdInvestigation(){
                var show = document.getElementById("lab");
                if(show.style.display == "none"){
                    show.style.display="block";
                }else{
                    // show.style.display = "block"
                    show.style.display="none";             
                }
            }
            function addDiagnosis(id,dd){               
                var diag = document.getElementById(id).value;
                diagnosis = diagnosis+"<>"+diag;
                document.getElementById(dd).value = diagnosis;
            }
            function addTreatment(id,dd){               
                var treat = document.getElementById(id).value;                
                treatment = treatment+"<>"+treat;                
                document.getElementById(dd).value=treatment;
            }
            function addDosage(id,dd,dr){ 
                var treat = document.getElementById(id).value;  
                var duration = document.getElementById(dr).value;  
                treatment = treatment+"><"+treat+"><"+duration;                
                document.getElementById(dd).value=treatment;
            }
            function addType(id,dd){  
                var treat = document.getElementById(id).value;                
                treatment = treatment+"><"+treat;                
                document.getElementById(dd).value=treatment;
            }
            function addQuantity(id,dd){ 
                var treat = document.getElementById(id).value;                
                treatment = treatment+"><"+treat;                
                document.getElementById(dd).value=treatment;
                 
            }
            function addInvestigation(id,dd){                
                var treat = document.getElementById(id).value;             
                investigation = investigation+"<>"+treat;               
                document.getElementById(dd).value=investigation;
            }
            function addDiadChecks(id1,id2){
                addcount++;
                //alert("here");
                var t1 = document.getElementById(id1).value;
                var tr = document.createElement("tr");
                var td1 = document.createElement("td"); 
                var td5 = document.createElement("td"); 
                var td6 = document.createElement("td"); 
                //var text = document.createTextNode(document.getElementById(id1).value);
                var cb = document.createElement( "input" );
                var btn = document.createElement("button")
                //var btn.type = "button";
                btn.innerHTML = 'Remove';
               
                cb.type = "checkbox";
                cb.id = "id_"+addcount;
                cb.name = "diaglist";
                var ttt = t1;
                var str = t1.split("><");
                var text = document.createTextNode(str[0]);
                cb.value = ttt;
                cb.checked = true;
                tr.id = "tr_"+addcount;
                td1.appendChild(text);
                td6.appendChild(btn);
                
                td5.appendChild(cb);
                tr.appendChild(td1);
                tr.appendChild(td5);
                tr.appendChild(td6);
                
                document.getElementById( id2 ).appendChild( tr );
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id2);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
            }
            function addInvestigationCheck(id1,id2){
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
                cb.name = "labtest";
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
                var ch = document.getElementById("labtest");
               
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id2);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
            }
            function addNHISCheckboxes(id1,id3,id4,id5,id7){
                addcount++;
                var t1 = document.getElementById(id1).value;
                //var t2 = document.getElementById(id2).value;
                var t3 = document.getElementById(id3).value;
                var t4 = document.getElementById(id4).value;
                var t5 = document.getElementById(id5).value;
                //var t6 = document.getElementById(id6).value;
                if(t1 =="Select"){
                    alert("Please select treatment before adding");
                    document.getElementById(id1).focus();
                    return;
                }
                
                if(t3 =="0"){
                    alert("Quantity cannot be 0");
                    document.getElementById(id3).focus();
                    return;
                }
                if(t4 =="Select"){
                    alert("Please add dosage");
                    document.getElementById(id4).focus();
                    return;
                }
                if(t5 =="duration"){
                    alert("Please add duration");
                    document.getElementById(id5).focus();
                    return;
                }
                var tr = document.createElement("tr");
               
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var text = document.createTextNode(document.getElementById(id1).value);
                // var text2 = document.createTextNode(document.getElementById(id2).value);
                var text3= document.createTextNode(document.getElementById(id3).value);
                var text4 = document.createTextNode(document.getElementById(id4).value);
                var text5 = document.createTextNode(document.getElementById(id5).value);
                // var text6 = document.createTextNode(document.getElementById(id6).value);
                var btn = document.createElement( "button" );
                btn.innerHTML = 'Remove';
                // alert(text);
                //tr.appendChild(td);
                var cb = document.createElement( "input" );
                cb.type = "checkbox";
                cb.id = "id";
                
                tr.id = "tr2_"+addcount;
                cb.name = "data";
                
                //Injection Diazopam 10mg Daily for 2 weeks 
                var spl = t1.split("><");
                var dosage = t4.split("_");
                var prescription = ""+spl[0]+" "+dosage[1]+" for "+t5;
                var presctext = document.createTextNode(prescription);
                var ttt = ""+t1+"><"+" "+"><"+t3+"><"+t4;
                cb.value = ttt;
                cb.checked = true;
                td1.appendChild(presctext);
                //td2.appendChild(text2);
                td3.appendChild(text3);
                td4.appendChild(text4);
                td5.appendChild(text5);
                //td6.appendChild(text6);
                
                
                td7.appendChild(cb);
                td8.appendChild(btn);
                // td.appendChild(text);
                tr.appendChild(td1);
                tr.appendChild(td7);
                tr.appendChild(td8);
                
                document.getElementById( id7 ).appendChild( tr );
                //return false;
                // tr.appendChild(td8);
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id7);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
            
            }
            function addCheckboxes (id1,id2,id3,id4,id5,id6,id7){
                addcount++;
                var t1 = document.getElementById(id1).value;
                var t2 = document.getElementById(id2).value;
                var t3 = document.getElementById(id3).value;
                var t4 = document.getElementById(id4).value;
                var t5 = document.getElementById(id5).value;
                var t6 = document.getElementById(id6).value;
                if(t1 =="Select"){
                    alert("Please select treatment before adding");
                    document.getElementById(id1).focus();
                    return;
                }
                if(t2 =="Select"){
                    alert("Please select drug form before adding");
                    document.getElementById(id2).focus();
                    return;
                }
                if(t3 =="0"){
                    alert("Quantity cannot be 0");
                    document.getElementById(id3).focus();
                    return;
                }
                if(t4 =="Select"){
                    alert("Please add dosage");
                    document.getElementById(id4).focus();
                    return;
                }
                if(t5 =="duration"){
                    alert("Please add duration");
                    document.getElementById(id5).focus();
                    return;
                }
                if(t6 =="Select"){
                    alert("Please select drug strength");
                    document.getElementById(id6).focus();
                    return;
                }
                
                var tr = document.createElement("tr");
               
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var text = document.createTextNode(document.getElementById(id1).value);
                var text2 = document.createTextNode(document.getElementById(id2).value);
                var text3= document.createTextNode(document.getElementById(id3).value);
                var text4 = document.createTextNode(document.getElementById(id4).value);
                var text5 = document.createTextNode(document.getElementById(id5).value);
                var text6 = document.createTextNode(document.getElementById(id6).value);
                var btn = document.createElement( "button" );
                btn.innerHTML = 'Remove';
                // alert(text);
                //tr.appendChild(td);
                var cb = document.createElement( "input" );
                cb.type = "checkbox";
                cb.id = "id";
                
                tr.id = "tr2_"+addcount;
                cb.name = "data";
                
                //Injection Diazopam 10mg Daily for 2 weeks 
                var spl = t1.split("><");
                var dosage = t4.split("_");
                var prescription = ""+t2+" "+spl[0]+" "+t6+" "+dosage[1]+" for "+t5;
                var presctext = document.createTextNode(prescription);
                var ttt = ""+t1+"><"+t2+"><"+t3+"><"+t4;
                cb.value = ttt;
                cb.checked = true;
                td1.appendChild(presctext);
                td2.appendChild(text2);
                td3.appendChild(text3);
                td4.appendChild(text4);
                td5.appendChild(text5);
                td6.appendChild(text6);
                
                
                td7.appendChild(cb);
                td8.appendChild(btn);
                // td.appendChild(text);
                tr.appendChild(td1);
               
                tr.appendChild(td7);
                tr.appendChild(td8);
                
                document.getElementById( id7 ).appendChild( tr );
                //return false;
                // tr.appendChild(td8);
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id7);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
            }
            
            function addSelect(id){
                var sel = document.getElementById(id).value;
                var sels = document.getElementById("pid");
                var opttext = document.createTextNode(sel);
                var opt = document.createElement("option");
                opt.appendChild(opttext);
                opt.value=sel;
                // alert(sel);
                sels.appendChild(opt);
                var visitid = document.getElementById("nid").value;
                var notes = document.getElementById("adminnotes").value;
                var doctorsid = document.getElementById("doctorsid").value;
                $.post('action/admissionaction.jsp', { value : "addnotes", visitid : visitid, notes : notes, doctorsid : doctorsid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function addInvestigationSelect(id){
                var sel = document.getElementById(id).value;
                var sels = document.getElementById("inid");
                var opttext = document.createTextNode(sel);
                var opt = document.createElement("option");
                opt.appendChild(opttext);
                opt.value=sel;
                // alert(sel);
                sels.appendChild(opt);
            }
            
            function addTreatmentSelect(id){
                var sel = document.getElementById(id).value;
                var sels = document.getElementById("trid");
                var opttext = document.createTextNode(sel);
                var opt = document.createElement("option");
                opt.appendChild(opttext);
                opt.value=sel;
                // alert(sel);
                sels.appendChild(opt);
            }
            
            function echoAdded(){
                var echo = document.getElementById("pid").value;
                //alert(echo);
            }
            
            function removeMe(id){
                id.value=""; 
                var rem = document.removeChild(id);
                alert("here"+rem.value)
            }
            
            function addVital(id,temp,systolic,diatolic,pulse){
                //  var id = document.getElementById(id).value;
                var temp = document.getElementById(temp).value;
                var systolic = document.getElementById(systolic).value;
                var diatolic = document.getElementById(diatolic).value;
                var pulse = document.getElementById(pulse).value;
              
                $.post('action/labnpharmactions.jsp', { action : "addvital", id : id, temp : temp, systolic : systolic, diatolic : diatolic, pulse : pulse}, function(data) {
                    $('#success').dialog('open');
                    $(".vitalinputs").attr("value","");
                   
                    
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function addDiagnosis(){
                var diagnoses = document.getElementsByName("diaglist");
                var patientid = document.getElementById("patientid").value;
                var visitid = document.getElementById("visitid").value;
                var diags = [];
                for(var t=0;t<diagnoses.length;t++){
                    diags.push((diagnoses[t]).value);
                }
                //alert(visitid);
                $.post('action/admissionaction.jsp', { action : "addiagnosis", "diag[]" : diags, patientid : patientid, visitid : visitid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function addPrescription(){
                var prescriptions = document.getElementsByName("data");
                var patientid = document.getElementById("patientid").value;
                var visitid = document.getElementById("visitid").value;
                var medicines = [];
                for(var t=0;t<prescriptions.length;t++){
                    medicines.push((prescriptions[t]).value);
                }
                // alert(visitid);
                $.post('action/admissionaction.jsp', { action : "addtreatment", "medicines[]" : medicines, patientid : patientid, visitid : visitid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function addlaboratory(){
                var labs = document.getElementsByName("labtest");
                var patientid = document.getElementById("patientid").value;
                var visitid = document.getElementById("visitid").value;
                var laboratories = [];
                for(var t=0;t<labs.length;t++){
                    laboratories.push((labs[t]).value);
                }
                //alert(laboratories[0]);
                $.post('action/admissionaction.jsp', { action : "addlaboratory", "laboratories[]" : laboratories, patientid : patientid, visitid : visitid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function addMoreProcedure(){
                var procedures = document.getElementsByName("procedures");
                var patientid = document.getElementById("patientid").value;
                var visitid = document.getElementById("visitid").value;
                var procs = [];
                for(var t=0;t<procedures.length;t++){
                    procs.push((procedures[t]).value);
                }
                //alert(visitid);
                $.post('action/admissionaction.jsp', { action : "addprocedure", "procs[]" : procs, patientid : patientid, visitid : visitid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
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
            function addComplaints(content){
                var content = document.getElementById(content).value;
                var visitid = document.getElementById("visitid").value;
                var doctorid = document.getElementById("userid").value;
                alert(doctorid);
                $.post('action/admissionaction.jsp', { action : "addcomplaints", content: content, visitid : visitid, doctorid : doctorid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function addExamination(name){
                var answers = document.getElementsByName(name);
                var visitid = document.getElementById("visitid").value;
                var answer = [];
                for(var t=0;t<answers.length;t++){
                    answer.push((answers[t]).value);
                }
                $.post('action/admissionaction.jsp', { action : "addexamination", "answers[]": answer, visitid : visitid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function showTransfer(){
                var show = document.getElementById("trans");
                if(show.style.display == "none"){
                    show.style.display="block";
                }else{
                    // show.style.display = "block"
                    show.style.display="none";             
                }
                //showBig();
                
            }
        </script>
    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">
        <%@include file="widgets/header.jsp" %>
        <div class="container-fluid">
            <header  class="jumbotron subhead" id="overview">
                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="#">Ward</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">In Patient Care</a><span class="divider"></span>
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
                <div class="row">
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="span9 offset3 thumbnail well content hide">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th>Folder Number </th>
                                    <th>Full Name </th>
                                    <th>Date of Birth </th>
                                    <th>Diagnosis</th>
                                    <th>Admission Date</th>
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

                                    List visits = mgr.listUnitVisitations(request.getParameter("type"));
                                    // List visits = mgr.listVisitations(request.getParameter("type"));
                                    String bed = request.getParameter("type");
                                    String[] beds = bed.split("_");
                                    //int bedid = Integer.parseInt(beds[1]);
                                    if (visits.size() > 0) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            visit = (Visitationtable) visits.get(i);
                                            // vs = mgr.currentVisitations(visit.getVisitid());
                                %>
                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bold;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%></h5> <span>"
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
                                        <a id="dialog<%=visit.getVisitid()%>link"  class="btn btn-info"> <i class="icon-pencil icon-white"> </i> Patient Care </a>
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

        <script src="js/jquery.js"></script>

        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>

        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltip.js"></script>

        <script src="js/bootstrap-popover.js"></script>
        <script src="js/application.js"></script>
        <script src="js/jquery.select-to-autocomplete.js"></script>
        <script src="js/jquery.select-to-autocomplete.min.js"></script>

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
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <!--initiate accordion-->
        <script src="js/highcharts.js"></script>
        <script type='text/javascript' src='fullcalendar/fullcalendar.min.js'></script>


        <% if (visits.size() > 0 || visits != null) {
                for (int counter = 0; counter < visits.size(); counter++) {
                    Visitationtable visitObject = (Visitationtable) visits.get(counter);
                    // vs = mgr.currentVisitations(visit.getVisitid());
                    List patientHistory = mgr.patientHistory(visitObject.getPatientid());
                    List adminssionHistory = mgr.patientAdmissionHistory(visitObject.getPatientid());
                    List itmss = itm.listDosageMonitor(visitObject.getVisitid());
                    if (visitObject != null) {
        %>

        <script type="text/javascript">
            $(document).ready(function(){  
           
                $(function() {
                    temps = [];
                    diatolics = [];
                    systolics = [];
                    pulses = [];
                    dt = [];
                    times = [];
   
            <%  List ls = mgr.listVitalCheckByVisitid(visitObject.getVisitid());
                if (ls != null) {
                    for (int z = 0; z < ls.size(); z++) {
                        Vitalcheck vcheck = (Vitalcheck) ls.get(z);
                        if (vcheck != null) {
            %>
                          
                        temps.push(<%=vcheck.getTemperature()%>)    
                        diatolics.push(<%=vcheck.getDiatolic()%>) 
                        systolics.push(<%=vcheck.getSystolic()%>) 
                        pulses.push(<%=vcheck.getPressure()%>) 
                        times.push("<%=vcheck.getTime()%>")
            <%  }
                    }
                }
                //}
            %>
                        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                        // menu_ul.hide();
       
                        $(".menu").fadeIn();
                        $(".content").fadeIn();
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
                    $(document).ready(function() {
            
                        $('#success').dialog({
                            autoOpen : false,
                            width : 350,
                            modal : true
                        });
           
                        $('.select').selectToAutocomplete();
                        $('.example').dataTable({
                            "bJQueryUI" : true,
                            "sScrollY": "300px",
                            "sPaginationType" : "full_numbers",
                            "iDisplayLength" : 25,
                            "aaSorting" : [],
                            "bSort" : true

                        });
        
                        var currentValue = "";
                        $("#addSup").click(function(){
                            currentValue = $("#nonexistantsource").attr("value");
                            if(currentValue != ""){ 
            
                                $("#nonexistant").val($("#nonexistant").val() + currentValue + ', ');
                                $("#tbody").append("<tr> <td>"+currentValue+"</td><td> </td></tr>")
           
                                currentValue = $("#nonexistantsource").attr("value","");
                            }
            
                        });

                        $(".continue").click(function() {

                            $(".first_half").slideUp();

                            $(".second_half").slideDown();

                            $(".pre_first_half").find("div").addClass("success");

                        });
       

                        $(".proceed").click(function() {

                            $(".second_half").slideUp();

                            $(".third_half").slideDown();

                        });

                        $(".back").click(function() {

                            $(".first_half").slideDown();

                            $(".second_half").slideUp();

                            $(".third_half").slideUp();

                            $(".pre_first_half").find("div").removeClass("success");

                        });

                        $(".previous").click(function() {

                            $(".second_half").slideDown();

                            $(".third_half").slideUp();

                            $(".first_half").slideUp();
                        });

                        $('.close_dialog').click(function() {

                            $('#dialog').dialog('close');

                        });

                        $(".patient").popover({

                            placement : 'right',
                            animation : true

                        });

                        $(".patient_visit").popover({

                            placement : 'top',
                            animation : true

                        });

                        $(".btn").tooltip({

                            placement : 'bottom',
                            animation : true

                        });

                        $(".update_sponsor").click(function() {
                            $(".sponsor_panel").slideToggle();
                            $(".vitals_panel").slideUp();
                            $(".history_panel").slideUp();
                        });

                        $(".update_vitals").click(function() {
                            $(".sponsor_panel").slideUp();
                            $(".vitals_panel").slideToggle();
                            $(".history_panel").slideUp();
                        });

                        $(".update_history").click(function() {
                            $(".sponsor_panel").slideUp();
                            $(".vitals_panel").slideUp();
                            $(".history_panel").slideToggle();
                        });
        
                        $(".slideup").click(function() {
                            $(".sponsor_panel").slideUp();
                            $(".vitals_panel").slideUp();
                            $(".history_panel").slideUp();      
                        })
                        var chart<%=visitObject.getPatientid()%>;
                        
                        
            
               
                        chart<%=visitObject.getPatientid()%> = new Highcharts.Chart({
                            chart: {
                                renderTo: 'chart<%=visitObject.getPatientid()%>',
                                type: 'line',
                                marginRight: 130,
                                marginBottom: 25
                            },
                            title: {
                                text: '<%= mgr.getPatientByID(visitObject.getPatientid()).getFname()%> <%= mgr.getPatientByID(visitObject.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visitObject.getPatientid()).getLname()%> \'s Temperature Chart',
                                x: -20 //center
                            },
                
                            xAxis: {
                                categories: times
                            },
                            yAxis: {
                                title: {
                                    text: 'Temperature (°C)'
                                },
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                            },
                            tooltip: {
                                formatter: function() {
                                    return '<b>'+ this.series.name +'</b><br/>'+
                                        this.x +': '+ this.y +'°C';
                                }
                            },
                            legend: {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'top',
                                x: -10,
                                y: 100,
                                borderWidth: 0
                            },
                            series: [{
                                    name: 'Temperature ',
                                    data: temps
                                }]
                        });
                        var chart1<%=visitObject.getPatientid()%>;
                        chart1<%=visitObject.getPatientid()%> = new Highcharts.Chart({
                            
                            chart: {
                                renderTo: 'chart1<%=visitObject.getPatientid()%>',
                                type: 'line',
                                marginRight: 130,
                                marginBottom: 25
                            },
                            title: {
                                text: '<%= mgr.getPatientByID(visitObject.getPatientid()).getFname()%> <%= mgr.getPatientByID(visitObject.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visitObject.getPatientid()).getLname()%> \'s Blood Pressure & Pulse Chart'  ,
                                x: -20 //center
                            },
                
                            xAxis: {
                                categories: times
                            },
                            yAxis: {
                                title: {
                                    text: 'Blood Pressure (mmHg) <br /> Pulse (BPM)',
                                    x: -20 
                                },
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                            },
                            tooltip: {
                                formatter: function() {
                                    if (this.series.name=="Pulse"){ 
                                        return '<b>'+ this.series.name +'</b><br/>'+
                                            this.y +' BPM at '+ this.x;
                                    }else{
                                        return '<b>'+ this.series.name +'</b><br/>'+
                                            this.y +' mmHg at '+ this.x;
                                    }
                                }
                            },
                            legend: {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'top',
                                x: -10,
                                y: 100,
                                borderWidth: 0
                            },
                            series: [{
                                    name: 'Systolic',
                                    data: systolics
                                }, {
                                    name: 'Diastolic',
                                    data: diatolics
                                }, {
                                    name: 'Pulse',
                                    data: pulses
                                }]
                        });
            
           
                    });
                    function updateView() {
                
                        var str = document.getElementById("unitid").value;

                        if (str=="")
                        {
                            document.getElementById("tt").innerHTML="";
                            return;
                        } 
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                            xmlhttp=new XMLHttpRequest();
                        }
                        else
                        {// code for IE6, IE5
                            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        xmlhttp.onreadystatechange=function()
                        {
                            if (xmlhttp.readyState==4 && xmlhttp.status==200)
                            { 
                                if(xmlhttp.responseText > 0){
                                    $('#success').dialog('open');
                                }else{
                                    $('#success').dialog('open');
                                }
                       
                            }
                        }
                        xmlhttp.open("GET","action/forward.jsp?action=forward.jsp&unitid="+str,true);
                        xmlhttp.send();
            
                    }
                    $("input:checkbox").attr("checked", false);
               
                    $('#dialog<%=visitObject.getVisitid()%>').dialog({
                        autoOpen : false,
                        width : 1200,
                        modal :true,
                        position : "top"
		
                    });
            
                    $('#transcript<%=visitObject.getVisitid()%>').dialog({
                        autoOpen : false,
                        width : 850,
                        modal :true,
                        position : "top"
		
                    });
        
                    $('#dialog<%=visitObject.getVisitid()%>dosage').dialog({
                        autoOpen : false,
                        width : 1200,
                        modal :true,
                        position : "top"
		
                    });
            
                    $('#transcript<%=visitObject.getVisitid()%>link').click(function(){
                   
                        $('#transcript<%=visitObject.getVisitid()%>').dialog('open');
                        return false;
                    });
                
                    $('#dialog<%=visitObject.getVisitid()%>link').click(function(){
                   
                        $('#dialog<%=visitObject.getVisitid()%>').dialog('open');
                        return false;
                    }); 
                    $('#dosage<%=visitObject.getVisitid()%>link').click(function(){
                   
                        $('#dialog<%=visitObject.getVisitid()%>dosage').dialog('open');
                        return false;
                    });
            
                    $(".vital_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
        
                        $(".vital<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
                    });
    
                    $(".history_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".history<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
            
                    });
    
                    $(".physical_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
            
                    });
    
                    $(".laboratory_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
            
                    });
    
                    $(".diagnosis_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideDown("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
            
                    });
    
                    $(".treatment_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
            
                    });
   
        
                    $(".previous_visit_link<%=visitObject.getPatientid()%>").click(function(){
        
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
            
                    });
    
                    $(".summary_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideDown("slow");
                    });
            
                    $(".admission_link<%=visitObject.getPatientid()%>").click(function(){
                        $(".bar").addClass("btn-info")
                        $(".bar").removeClass("btn-inverse")
                
                        $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".physical<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".history<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".laboratory<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".diagnosis<%=visitObject.getPatientid()%>").slideUp("slow"); 
                        $(".previous_visit<%=visitObject.getPatientid()%>").slideUp("slow");
                        $(".admission_notes<%=visitObject.getPatientid()%>").slideDown("slow");
                        $(".summary<%=visitObject.getPatientid()%>").slideUp("slow");
                    });
            
                    $("#dialog").dialog({
                        autoOpen: false,
                        title: "Dosage Monitoring",
                        width: "500",
                        height: "400"
                    
                    })
       
                });
                
                function saveevent(nurseid,visitid,qty,medicine){
            
                    var nurse  = document.getElementById(nurseid).value;
                    var visit  = document.getElementById(visitid).value;
                    var quantity  = document.getElementById(qty).value;
                    var ptreatmentid  = document.getElementById(medicine).value;
        
                    var submit = confirm("Are you want to give this dose");
                    if(submit){
                        $.post('action/admissionaction.jsp', {action : "dosagemonitor", nurse : nurse, visitid : visit, quantity : quantity, medicine : ptreatmentid}, function(data) {
                            alert(data);
                        });
                    }else{
                        alert("Successfully cancelled");
                    }    
                
                }   
                function deleteevent(dosageid){
                    //var dosage  = document.getElementById(dosageid).value;
                    var submit = confirm("Are you sure you want remove this dose");
                    if(submit){
                        $.post('action/admissionaction.jsp', {action : "deletedosagemonitor", dosageid : dosageid}, function(data) {
                            alert(data);
                        });
                    }else{
                        alert("Successfully cancelled");
                    }    
                }
        </script>

        <div style="max-height: 720px;  overflow-y: scroll; overflow-x: hidden; display: none;" id="dialog<%=visitObject.getVisitid()%>"  title="Patient Care for <%= mgr.getPatientByID(visitObject.getPatientid()).getFname()%>  <%= mgr.getPatientByID(visitObject.getPatientid()).getLname()%> | <span style='text-transform:uppercase;'><%=visitObject.getPatientid()%> </span>">

            <div class="span12">
                <form action="action/admissionaction.jsp" method="post">
                    <div style="margin-left: -50px;" class="span2 ">
                        <ul class="menu">
                            <li> <a class="vital_link<%=visitObject.getPatientid()%> active"> <i class="icon icon-check"> </i> Vitals Signs </a></li>
                            <li> <a class="history_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-list-alt"> </i> History </a></li>
                            <li> <a class="physical_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-user"> </i> Examinations </a></li>
                            <li> <a class="laboratory_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-search"> </i> Laboratory </a></li>
                            <li> <a class="diagnosis_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-adjust"> </i> Diagnoses </a></li>
                            <li> <a class="treatment_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Treatment </a></li>
                            <li> <a class="previous_visit_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-file"> </i> Previous Visits </a></li>
                            <li> <a class="admission_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-folder-open"> </i> Admission Notes </a></li>
                            <li> <a class="summary_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-folder-open"> </i> Summary </a></li>

                        </ul>


                        <input type="hidden" name="patientid" id="patientid" value="<%=visitObject.getPatientid()%>"/>
                        <input type="hidden" name="visitid" id="visitid" value="<%=visitObject.getVisitid()%>"/>
                        <input type="hidden" name="userid" id="userid" value="<%=user.getStaffid()%>"/>
                        <!--input type="hidden" name="bedid" id="bedid" value="<%%>"/-->
                        <input type="hidden" name="type" id="userid" value="<%=request.getParameter("type")%>"/>
                        <table style="margin: 0px; padding: 0px; margin-left: 10px;" class="span2 pull-left table-condensed">
                            <tr>
                                <td>
                                    <label style="margin-top: 8px;" class="pull-left">Discharge</label>
                                </td>
                                <td>
                                    <label class="switch-container">

                                        <input style="vertical-align: middle;" type="checkbox" checked="checked" name="admission" value="Discharge"style="width: 100px" class="switch-input checkValue hide"/>
                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div>  
                                    </label> 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label style="margin-top: 8px;" class="pull-left">Refer</label>
                                </td>
                                <td>
                                    <label class="switch-container">
                                        <input style="vertical-align: middle;" type="checkbox" onclick="showTransfer()" name="admission" value="Transfer"style="width: 100px" class="switch-input checkValue hide"/>

                                        <div class="switch">
                                            <span class="switch-label">Yes</span>
                                            <span class="switch-label">No</span>
                                            <span class="switch-handle"></span>
                                        </div>  
                                        <div id="bigtrans" style="display: none"> 
                                            <div id="trans" style="display: none">
                                                Transferred to: <input type="text" name="location"/><br/>
                                                Transfer Notes:<br/>
                                                <textarea name="notes"></textarea>
                                            </div>
                                        </div>
                                    </label> 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <button type="submit" name="action" value="Forward" class="btn btn-danger btn-small pull-right">
                                        <i class="icon-white icon-arrow-right"> </i> Forward
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="span10">

                        <div style="display: block;"  class="thumbnail center vital<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b> Vitals </b></a>
                                </li> 
                            </ul>
                            <div class="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Vital Signs Charts</a></li>
                                    <li><a href="#tabs-3">Enter New Vital Signs</a></li>
                                    <li><a href="#tabs-2">OPD Vital Signs</a></li>
                                </ul>
                                <div id="tabs-1">

                                    <div class="tabs">
                                        <ul>
                                            <li><a href="#tabs-1-1">Temperature</a></li>
                                            <li><a href="#tabs-1-2">Blood Pressure & Pulse</a></li>
                                        </ul>
                                        <div id="tabs-1-1" >
                                            <div id="chart<%=visitObject.getPatientid() %>" style="min-width: 920px; height: 400px; margin: 0 auto">

                                            </div>
                                        </div>
                                        <div id="tabs-1-2">
                                            <div id="chart1<%=visitObject.getPatientid() %>" style="min-width: 920px; height: 400px; margin: 0 auto">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tabs-2">
                                    <% Vitaltable vitaltable = mgr.getVitaltableByid(visitObject.getVisitid());
                                        if (vitaltable == null) {%>
                                    <%="No Vitals Recorded for Today"%>
                                    <%} else {

                                    %>
                                    <table class="table  right table table-bordered">
                                        <tr>
                                            <td><b style="color: #4183C4">Temperature</b></td>

                                            <td><%=vitaltable.getTemperature()%>&nbsp;&nbsp;(°C)
                                            </td>
                                        </tr>

                                        <tr>
                                            <td><b style="color: #4183C4">Weight </b></td>

                                            <td><%=vitaltable.getWeight()%>&nbsp;&nbsp;(Kg)</td>
                                        </tr>

                                        <tr>
                                            <td><b style="color: #4183C4">Height </b> </td>

                                            <td><%=vitaltable.getHeight()%>&nbsp; &nbsp;(cm)</b></td>
                                        </tr>
                                        <tr>
                                            <td><b style="color: #4183C4">Blood Pressure </b> </td>
                                            <td>
                                                <%=vitaltable.getSistolic()%> / <%=vitaltable.getDiatolic()%>&nbsp;&nbsp;(mmHg)
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <b style="color: #4183C4">Pulse</b>
                                            </td>

                                            <td>
                                                <%=vitaltable.getPulse()%>&nbsp; &nbsp;(BPM)
                                            </td>
                                        </tr>
                                    </table>

                                    <%}%>
                                </div>
                                <div id="tabs-3">
                                    <table>
                                        <thead>
                                            <tr>

                                                <th style="text-align: center;" rowspan="2">
                                                    Temperature ( &#176; C)
                                                </th>
                                                <th style="text-align: center;" colspan="3">
                                                    Blood Pressure
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: center;">
                                                    Systolic (mm Hg)
                                                </th>
                                                <th style="text-align: center;">
                                                    Diastolic (mm Hg)
                                                </th>
                                                <th style="text-align: center;">
                                                    Pulse (BPM)
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="text-align: center">
                                                    <input type="text" name="temp" class="input-mini vitalinputs" id="temp_<%=visitObject.getVisitid()%>"  value=""/>

                                                </td>
                                                <td style="text-align: center">
                                                    <input type="text" name="systolic" class="input-mini vitalinputs" id="systolic_<%=visitObject.getVisitid()%>"value=""/>

                                                </td>
                                                <td style="text-align: center">
                                                    <input type="text" name="diatolic" class="input-mini vitalinputs" id="diatolic_<%=visitObject.getVisitid()%>"  value=""/>

                                                </td>
                                                <td style="text-align: center">
                                                    <input type="text" name="pulse"class="input-mini vitalinputs" id="pulse_<%=visitObject.getVisitid()%>"  value=""/>

                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="help-inline">
                                        <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addVital("<%=visitObject.getVisitid()%>","temp_<%=visitObject.getVisitid()%>","systolic_<%=visitObject.getVisitid()%>","diatolic_<%=visitObject.getVisitid()%>","pulse_<%=visitObject.getVisitid()%>");return false;'>
                                            <i class="icon-white icon-plus-sign"> </i>   Add Vital
                                        </button>
                                    </div>


                                </div>
                            </div>
                        </div>
                        <div style="display: none;"  class="thumbnail center history<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b> History </b></a>
                                </li>
                            </ul>
                            <div class="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Allergies</a></li>
                                    <li><a href="#tabs-2">Presenting Complaints</a></li>
                                    <li><a href="#tabs-3">Symptoms</a></li>
                                </ul>
                                <div id="tabs-1">

                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="color: #fff;">Allergy</th>
                                                <th style="color: #fff;">Possible Reactions </th>
                                                <th style="color: #fff;">Suggested Treatment</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% List allergies = mgr.listAllergiessByPatientid(visitObject.getPatientid());
                                                if (allergies != null) {
                                                    for (int dex = 0; dex < allergies.size(); dex++) {
                                                        PatientAllergies allergy = (PatientAllergies) allergies.get(dex);
                                                        if (allergy != null) {
                                            %>
                                            <tr>
                                                <td><%=mgr.getAllergyByid(allergy.getAllergyid()).getName()%></td>

                                                <td><%=mgr.getAllergyByid(allergy.getAllergyid()).getPossibleRxns()%></td>

                                                <td><%=mgr.getAllergyByid(allergy.getAllergyid()).getSuggestedTreatment()%></td>
                                            </tr>
                                            <% }
                                                    }
                                                }%>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="tabs-2">
                                    <textarea  name="complaints" style="width: 95%; height: 100px;"><%=visitObject.getVitals()%></textarea>
                                </div>
                                <div id="tabs-3">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="color: #fff;"><b>Symptoms</b></th> 
                                            </tr>

                                        </thead>  
                                        <tbody> 
                                            <% List visitSymptoms = mgr.listVisistSymptomsByVisitid(visitObject.getVisitid());
                                                VisitSymptoms symptoms = null;
                                                if (visitSymptoms != null) {
                                                    for (int ind = 0; ind < visitSymptoms.size(); ind++) {
                                                        symptoms = (VisitSymptoms) visitSymptoms.get(ind);
                                                        if (symptoms != null) {
                                            %>
                                            <tr>
                                                <td><%=mgr.getSymptomById(symptoms.getSymptomid()).getSymptomname()%></td>
                                            </tr>
                                            <%}
                                                    }
                                                }%>


                                        </tbody>

                                    </table>
                                    <table class="table table-bordered">
                                        <thead>
                                        <th style="color: #fff;"><b>Symptom notes </b></th>
                                        </thead>
                                        <tbody>

                                            <% if (visitSymptoms != null) {
                                                    symptoms = (VisitSymptoms) visitSymptoms.get(0);
                                                    if (symptoms != null) {%>

                                            <tr> 
                                                <td>
                                                    <%= symptoms.getNote()%>
                                                </td>
                                            </tr>
                                            <%}
                                                }%>

                                        </tbody>

                                    </table>
                                </div>
                            </div>
                        </div>
                        <div style="display: none;"  class="thumbnail center physical<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b>Examination </b></a>
                                </li>
                            </ul>
                            <div class="tabs">
                                <ul>
                                    <li><a href="#tabs-2">Examination </a></li>
                                    <!--<li><a href="#tabs-2">Medical Examination</a></li>-->
                                    <li><a href="#tabs-1">Previous Answers</a></li>

                                </ul>
                                <div id="tabs-2">
                                    <table>
                                        <%List questions = mgr.listClerkQuestions();
                                            for (int w = 0; w < questions.size(); w++) {
                                                Clerkingquestion clerkingquestion = (Clerkingquestion) questions.get(w);
                                        %>
                                        <tr>
                                            <td>
                                                <b style="color: #4183C4"><%=clerkingquestion.getQuestion()%> ?</b>
                                            </td>
                                            <td>
                                                <div class="radioset">
                                                    <% List answers = mgr.listClerkAnswersByQuestionid(clerkingquestion.getClerkid());
                                                        for (int y = 0; y < answers.size(); y++) {
                                                            Clerkinganswer clerkinganswer = (Clerkinganswer) answers.get(y);
                                                    %>
                                                    <input type="radio" id="age1<%=clerkinganswer.getAnswerid()%>" name="ans_<%=visitObject.getVisitid()%>" value="<%=clerkingquestion.getClerkid()%>_<%=clerkinganswer.getAnswerid()%> "/><label for="age1<%=clerkinganswer.getAnswerid()%>"><%=clerkinganswer.getAnswer()%></label>
                                                   <!-- <input type="radio" id="age2<%=visit.getPatientid()%>" name="age" /><label for="age2<%=visit.getPatientid()%>"><%=clerkinganswer.getAnswer()%></label>
                                                    <input type="radio" id="age3<%=visit.getPatientid()%>" name="age" /><label for="age3<%=visit.getPatientid()%>"><%=clerkinganswer.getAnswer()%></label>-->
                                                    <%}%>
                                                </div>
                                            </td>

                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                                <div id="tabs-1">
                                    <p>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>
                                                    Question
                                                </th>
                                                <th>
                                                    Answer
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%List l = mgr.listPatientClerkingByVisitid(visitObject.getVisitid());
                                                for (int c = 0; c < l.size(); c++) {
                                                    Patientclerking patientclerking = (Patientclerking) l.get(c);

                                            %>
                                            <tr>
                                                <td style="width: 60%">
                                                    <b style="color: #4183C4"><%=mgr.getClerkingQuestionByid(patientclerking.getQuestionid()).getQuestion()%> ?</b>
                                                </td>
                                                <td style="width: 40%">
                                                    <b style="color: #000"><%=mgr.getClerkingAnswerByid(patientclerking.getAnswerid()).getAnswer()%> </b>
                                                </td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                    </p> 
                                </div>

                            </div>
                        </div>
                        <div style="display: none;"  class="thumbnail center admission_notes<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b>Admission Notes </b></a>
                                </li>
                            </ul>
                            <div class="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Previous Notes </a></li>
                                    <li><a href="#tabs-2">Add Notes</a></li>

                                </ul>
                                <div id="tabs-1">
                                    <table>
                                        <%List notes = mgr.listPatientAdmissionNote(visitObject.getVisitid());
                                            for (int w = 0; w < notes.size(); w++) {
                                                Admissionnotes clerkingquestion = (Admissionnotes) notes.get(w);
                                        %>
                                        <tr>
                                            <td>
                                                <b style="color: #4183C4"><%=clerkingquestion.getDate()%></b>
                                            </td>
                                            <td>
                                                <b style="color: #4183C4"><%=mgr.getStafftableByid(clerkingquestion.getDoctorsid()).getLastname() + " " + mgr.getStafftableByid(clerkingquestion.getDoctorsid()).getOthername()%></b>
                                            </td>
                                            <td>
                                                <b style="color: #4183C4"><%=clerkingquestion.getNote()%></b>
                                            </td>

                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                                <div id="tabs-2">
                                    <p> <textarea style="width: 95%; height: 50px"  name="complaints" id="complaints_<%=visitObject.getVisitid()%>"></textarea></p>
                                    <br/>

                                    <button id="adddiagnosis" class="btn btn-info btn-small" onclick='addComplaints("complaints_<%=visitObject.getVisitid()%>");return false;'>
                                        <i class="icon-white icon-pencil"> </i>   Add 
                                    </button>
                                </div>

                            </div>
                        </div>
                        <div style="display: none;"  class="thumbnail center laboratory<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b> Laboratory </b></a>
                                </li>
                            </ul>

                            <div id="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Investigations</a></li>
                                    <li><a href="#tabs-2">Results</a></li>
                                </ul>
                                <div id="tabs-1">
                                    <div class="center" id="lab">
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
                                                                tabNum = y + 1;
                                                    %>
                                                    <li><a style="text-transform: capitalize;" href="#tabs-<%=tabNum%>"><%=labType.getLabType()%></a></li>
                                                    <%        labTypesMap.put(tabNum, labType.getLabType());
                                                            }
                                                        }%>
                                                </ul>

                                                <% if (!labTypes.isEmpty()) {
                                                        int colNum = 0;
                                                        int labTypeId = 0;
                                                        for (int h = 0; h < labTypes.size(); h++) {
                                                            labType = (Labtypes) labTypes.get(h);
                                                            labTypeId = labType.getLabTypeId();
                                                            colNum = h + 1;
                                                %>
                                                <div id="tabs-<%=colNum%>">
                                                    <div class="center" id="lab">
                                                        <% if (mgr.sponsorshipDetails(visitObject.getPatientid()).getType().equalsIgnoreCase("NHIS")) {%>
                                                        <%
                                                            nhisinvestigations = mgr.listNhisinvestigation();
                                                            if (nhisinvestigations != null) {
                                                                for (int p = 0; p < nhisinvestigations.size(); p++) {

                                                                    Nhisinvestigation investigation = (Nhisinvestigation) nhisinvestigations.get(p);
                                                                    if (investigation != null) {
                                                        %>
                                                        <!--
                                                          <option value="<%=investigation.getName()%>><<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></option> 
                                                        -->
                                                        <% }
                                                            }%>
                                                        <!--  </select> -->
                                                        <div  style="float: left"  class="radioset">
                                                            <% for (int p = 0; p < nhisinvestigations.size(); p++) {
                                                                    Nhisinvestigation investigation = (Nhisinvestigation) nhisinvestigations.get(p);
                                                                    if (investigation != null) {

                                                            %>
                                                            <input  style="margin-top: 10px; width: 180px;"   name="labtest" type="checkbox" id="test<%= investigation.getDetailedInvId()%>" value="<%=investigation.getName()%>><<%= investigation.getDetailedInvId()%>"  onclick='addInvestigationCheck("test<%=visitObject.getVisitid()%>","appendx_<%=visitObject.getVisitid()%>");return false;' /><label  for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></label> <br /><br />

                                                            <% }
                                                                }%>
                                                        </div>
                                                        <%}
                                                        } else {%>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                 <!--   <select class="input-xxlarge select"  id="test<%=visit.getVisitid()%>" onchange = ''>
                                                                        <option value="Select">Select Investigation</option>
                                                                    <%

                                                                        investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                                        if (investigations != null) {
                                                                            for (int p = 0; p < investigations.size(); p++) {
                                                                                Investigation investigation = (Investigation) investigations.get(p);
                                                                                if (investigation != null) {
                                                                    %>
                                                                    <option value="<%=investigation.getName()%>><<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></option> 
                                                                    <% }
                                                                        }%>
                                                                </select> -->

                                                                    <div style="float: left"  class="radioset"> 
                                                                        <% for (int p = 0; p < investigations.size(); p++) {
                                                                                Investigation investigation = (Investigation) investigations.get(p);
                                                                                if (investigation != null) {%>

                                                                        <input style="margin-top: 10px; width: 180px;"  type="checkbox" name="labtest" id="test<%= investigation.getDetailedInvId()%>" value="<%=investigation.getName()%>><<%= investigation.getDetailedInvId()%>"  onclick='addInvestigationCheck("test<%=visit.getVisitid()%>","appendx_<%=visit.getVisitid()%>");return false;' /><label style="width: 220px; font-size: 14px; text-align: center; float: left; margin-right: 15px; margin-bottom: 20px; "  for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></label> 

                                                                        <% }
                                                                            }%>
                                                                    </div> 

                                                                    <% }%>

                                                                    <% }%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                                <% }
                                                    }%>
                                            </div>
                                        </div>

                                        <!--          <table>
                                                      <tr>
                                                          <td>   -->

                                        <% // }%>
                                        <!--                </td>
            
                                                        <td>
                                                            <button id="addCheckBoxes" class="btn btn-info" onclick='addInvestigationCheck("test<%=visitObject.getVisitid()%>","appendx_<%=visitObject.getVisitid()%>");return false;'>
                                                                <i class="icon-white icon-pencil"> </i>   Add Investigation
                                                            </button>
                                                        </td>  
                                                    </tr>
                                                </table>  -->
                                            <!--    <table id="appendx_<%=visitObject.getVisitid()%>" class="table">
            
                                                    <thead>
                                                        <tr style="padding: 12px 0px 12px 0px;">
                                                            <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                                                Selected Investigations
                                                            </th>
                                                        </tr>
                                                    </thead>
            
                                                </table>  -->
                                        Investigation Note <br />  <br />
                                        <textarea style="width: 95%; height: 100px;" name="investigation_note"></textarea>
                                        <button id="adddiagnosis" class="btn btn-info btn-small" onclick='addlaboratory();return false;'>
                                            <i class="icon-white icon-pencil"> </i>   Add 
                                        </button>
                                        <br/>
                                        <!-- <button class="btn btn-info btn-small center" style="text-align: center; margin-top: 10px;" type="button">
                                             <i class="icon icon-print icon-white"></i> Print Lab Request
                                         </button> -->
                                    </div>
                                </div>
                                <div id="tabs-2">
                                    <div id="results">
                                        <table cellpadding="0" cellspacing="0" border="0" class="table">

                                            <thead>
                                                <tr >
                                                    <th>
                                                        <label style="color: white; text-align: left;"> Order By</label>
                                                    </th>
                                                    <th>
                                                        <label style="color: white; text-align: left; "> Ordered Date </label>
                                                    </th>
                                                    <th>
                                                        <label style="color: white; text-align: left;" > Done On </label>
                                                    </th>
                                                    <th>
                                                        <label style="color: white; text-align: left;">  </label>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% List labids = mgr.listLabordersByVisitid(visitObject.getVisitid());
                                                    if (labids.size() > 0) {
                                                        System.out.println(labids.size());
                                                        Laborders laborder = (Laborders) labids.get(0);
                                                        if (laborder != null && laborder.getVisitid() == visitObject.getVisitid()) {
                                                %>
                                                <tr>
                                                    <td>
                                                        <%=mgr.getStafftableByid(laborder.getFromdoc()) == null ? "" : mgr.getStafftableByid(laborder.getFromdoc()).getLastname() + " " + mgr.getStafftableByid(laborder.getFromdoc()) == null ? "" : mgr.getStafftableByid(laborder.getFromdoc()).getOthername()%>
                                                    </td>
                                                    <td >
                                                        <%=formatter1.format(laborder.getOrderdate())%> 
                                                    </td>
                                                    <td>
                                                        <%if (laborder.getDonedate() == null) {%>
                                                        <span class="label label-important"> Not Completed</span>
                                                        <%} else {%>
                                                        <%= formatter1.format(laborder.getDonedate())%>   
                                                        <% }%>
                                                    </td>

                                                    <td style="text-align: center">
                                                        <%if (laborder.getDonedate() == null) {%>

                                                        <%} else {%>
                                                        <button  value="view" class="btn btn-info btn-small" onclick="updateLaborders();return false;">
                                                            View Lab Report
                                                        </button>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <% }
                                                } else {%>
                                            <div style=" padding: 20px;" > <h3> No Laboratory Results for Today's Visit
                                                </h3>

                                            </div>
                                            <%}%>

                                            </tbody>

                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div style="display: none;" class="well thumbnail center diagnosis<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"><b> Diagnoses </b></a>
                                </li>

                            </ul>
                            <div id="tabs">
                                <ul>
                                    <li><a href="#tabs-5">Previous Diagnosis</a></li>
                                    <li><a href="#tabs-6">Add Diagnosis</a></li>
                                </ul>
                                <div id="tabs-6">
                                    <table class="table"> 
                                        <tr>
                                            <td>
                                                <%if (mgr.getSponsor(mgr.sponsorshipDetails(visitObject.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {%>
                                                <label class="control-label pull-left" style="line-height: 25px; padding-right: 15px;"  for="input01"> Select Diagnoses  </label>  <select class="input-xxlarge select" id="diagnosis<%=visitObject.getVisitid()%>" onchange =''>

                                                    <%
                                                        List diagnoses = mgr.listNHISDiagnosis();
                                                        if (diagnoses != null) {
                                                            for (int t = 0; t < diagnoses.size(); t++) {
                                                                DetailsDiagnosis diagnosis = (DetailsDiagnosis) diagnoses.get(t);

                                                                if (diagnosis != null) {
                                                    %>
                                                    <option value="<%=diagnosis.getDescription()%>><<%=diagnosis.getDetailid()%>"><%=diagnosis.getDescription()%></option> 
                                                    <% }
                                                            }
                                                        }
                                                    %>
                                                </select>
                                                <%} else {%>

                                                <label class="control-label pull-left" style="line-height: 25px; padding-right: 15px;"  for="input01"> Select Diagnoses  </label> <select class="input-xxlarge select" id="diagnosis<%=visitObject.getVisitid()%>" onchange =''>

                                                    <%
                                                        List diagnoses = mgr.listDiagnosis();
                                                        for (int t = 0; t < diagnoses.size(); t++) {
                                                            Diagnosis diagnosis = (Diagnosis) diagnoses.get(t);
                                                    %>
                                                    <option value="<%=diagnosis.getDiagnosis()%>><<%=diagnosis.getId()%>"><%=diagnosis.getDiagnosis()%></option> 
                                                    <% }

                                                    %>
                                                </select>
                                                <%}%>
                                            </td>
                                            <td>
                                                <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addDiadChecks("diagnosis<%=visitObject.getVisitid()%>","appendd_<%=visitObject.getVisitid()%>" );return false;'>
                                                    <i class="icon-white icon-plus-sign"> </i>   Add
                                                </button>
                                            </td>
                                        </tr>

                                    </table> 
                                    <table id="appendd_<%=visitObject.getVisitid()%>" class="table">
                                        <thead>
                                            <tr style="padding: 12px 0px 12px 0px;">
                                                <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                                    Selected Diagnosis
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbody">
                                        <input type="hidden" class="input-xxlarge" id="nonexistant" value="" name="nonexistant"/>

                                    </table>
                                    <br/>
                                    <button id="adddiagnosis" class="btn btn-info btn-small" onclick='addDiagnosis();return false;'>
                                        <i class="icon-white icon-plus-sign"> </i>   Add 
                                    </button>  
                                </div>
                                <div id="tabs-5">
                                    <table class="table-bordered">
                                        <thead>
                                            <tr>
                                                <th>
                                                    Previous Diagnosis
                                                </th>
                                            </tr>
                                        </thead>
                                        <%
                                            if (mgr.getSponsor(mgr.sponsorshipDetails(visitObject.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {
                                                List diagnoses = mgr.patientDiagnosis(visitObject.getVisitid());
                                                if (diagnoses != null) {
                                                    for (int p = 0; p < diagnoses.size(); p++) {
                                                        Patientdiagnosis patientProcedure = (Patientdiagnosis) diagnoses.get(p);
                                                        if (patientProcedure != null) {
                                        %>
                                        <tr style="padding-top:0px">
                                            <td style="line-height: 25px; font-weight: bold; padding-top:0px;">
                                                <%=patientProcedure.getDiagnosisid()%>
                                            </td>
                                        </tr>
                                        <%}
                                                }
                                            }
                                        } else {
                                            System.out.println("here");
                                            List diagnoses = mgr.patientDiagnosis(visitObject.getVisitid());
                                            if (diagnoses != null) {
                                                for (int p = 0; p < diagnoses.size(); p++) {
                                                    Patientdiagnosis patientProcedure = (Patientdiagnosis) diagnoses.get(p);
                                                    if (patientProcedure != null) {
                                        %>
                                        <tr>
                                            <td style="line-height: 25px; font-weight: bold;">
                                                <%=mgr.getDiagnosis(patientProcedure.getDiagnosisid()) == null ? "" : mgr.getDiagnosis(patientProcedure.getDiagnosisid()).getDiagnosis()%>
                                            </td>
                                        </tr>
                                        <%}
                                                    }
                                                }
                                            }%>
                                    </table>

                                </div>
                            </div>
                        </div>
                        <div style="display: none;" class="thumbnail center treatment<%=visitObject.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <b> <a>Treatment</a> </b>
                                </li>
                            </ul>
                            <div id="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Monitor Dosage</a></li>
                                    <li><a href="#tabs-2">Prescribe</a></li>
                                    <li><a href="#tabs-3">Procedures</a></li>
                                </ul>
                                <div id="tabs-2">

                                    <%  if (mgr.sponsorshipDetails(visitObject.getPatientid()).getType().equalsIgnoreCase("NHIS")) {%>
                                    <table class="consult table"> 

                                        <thead>

                                            <tr>
                                                <th style="color: #fff;">
                                                    Name of Drug
                                                </th>

                                                <th style="color: #fff;">
                                                    Dosage
                                                </th>
                                                <th style="color: #fff;">
                                                    Duration 
                                                </th>
                                                <th style="color: #fff;">
                                                    Quantity 
                                                </th>
                                            </tr>

                                        </thead>
                                        <tbody style="max-height: 100px; overflow-y: auto;">                     

                                            <tr>

                                                <td> 
                                                    <select class="input-xlarge select"  id="treatment<%=visitObject.getVisitid()%>" onchange = 'addTreatment("treatment<%=visitObject.getVisitid()%>","tt<%=visitObject.getVisitid()%>")'>
                                                        <option value="Select">Select</option>
                                                        <%
                                                            treatments = mgr.listNhistreatment();

                                                            if (treatments != null) {
                                                                for (int v = 0; v < treatments.size(); v++) {
                                                                    Nhistreatment treatment = (Nhistreatment) treatments.get(v);

                                                        %>
                                                        <option value="<%=treatment.getMedicine()%>><<%=treatment.getTreatmentid()%>"><%=treatment.getMedicine()%></option> 
                                                        <% }

                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select class="input-small"  name="dosage" id="dosage<%=visitObject.getVisitid()%>">
                                                        <option value="Select">Select</option>
                                                        <%
                                                            dosages = mgr.listDosages();
                                                            if (dosages != null) {
                                                                for (int v = 0; v < dosages.size(); v++) {
                                                                    Dosage dosage = (Dosage) dosages.get(v);
                                                        %>
                                                        <option value="<%=dosage.getMapped()%>_<%=dosage.getShortcut()%>"><%=dosage.getShortcut()%></option> 
                                                        <% }
                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                                <td>

                                                    <input type="text" value="" class="input-medium" name="duration" id="duration<%=visitObject.getVisitid()%>"/>
                                                </td>
                                                </td>
                                                <td>                                   
                                                    <select class="input-mini" name="qty" id="qty<%=visitObject.getVisitid()%>" onchange=addQuantity("qty<%=visitObject.getVisitid()%>","tt<%=visitObject.getVisitid()%>")>
                                                        <option value="0">
                                                            0
                                                        </option>
                                                        <option value="1">
                                                            1
                                                        </option>
                                                        <option value="2">
                                                            2
                                                        </option>
                                                        <option value="3">
                                                            3
                                                        </option>
                                                        <option value="4">
                                                            4
                                                        </option>
                                                        <option value="5">
                                                            5
                                                        </option>
                                                        <option value="6">
                                                            6
                                                        </option>
                                                        <option value="7">
                                                            7
                                                        </option>
                                                        <option value="8">
                                                            8
                                                        </option>
                                                        <option value="9">
                                                            9
                                                        </option>
                                                        <option value="10">
                                                            10
                                                        </option>

                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table>
                                        <tbody style="max-height: 100px; overflow-y: auto;">
                                            <tr>
                                                <td class="center">
                                                   <!-- <button id="addCheckBoxes" class="btn btn-info span2" onclick='addTreatmentSelect("treatment<%=visitObject.getVisitid()%>");addCheckboxes("treatment<%=visitObject.getVisitid()%>","drugtype<%=visitObject.getVisitid()%>","qty<%=visitObject.getVisitid()%>","dosage<%=visitObject.getVisitid()%>");return false;'>
                                                        <i class="icon-white icon-pencil"> </i>   Add Treatment
                                                    </button>-->
                                                    <button id="addCheckBoxes" class="btn btn-info " onclick='addNHISCheckboxes("treatment<%=visitObject.getVisitid()%>","qty<%=visitObject.getVisitid()%>","dosage<%=visitObject.getVisitid()%>","duration<%=visitObject.getVisitid()%>","append_<%=visitObject.getVisitid()%>");return false;'>
                                                        <i class="icon-white icon-plus-sign"> </i>   Add
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <%} else {%>
                                    <table class="consult table"> 

                                        <thead>

                                            <tr>
                                                <th style="color: #fff;">
                                                    Name of Drug
                                                </th>
                                                <th style="color: #fff;">
                                                    Strength 
                                                </th>
                                                <th style="color: #fff;">
                                                    Form 
                                                </th>
                                                <th style="color: #fff;">
                                                    Dosage
                                                </th>
                                                <th style="color: #fff;">
                                                    Duration 
                                                </th>
                                                <th style="color: #fff;">
                                                    Quantity 
                                                </th>
                                            </tr>

                                        </thead>
                                        <tbody style="max-height: 100px; overflow-y: auto;">                     

                                            <tr>

                                                <td> 
                                                    <select class="input-large select"  id="treatment<%=visitObject.getVisitid()%>" onchange = 'addTreatment("treatment<%=visitObject.getVisitid()%>","tt<%=visitObject.getVisitid()%>")'>
                                                        <option value="Select">Select</option>
                                                        <%
                                                            treatments = mgr.listTreatments();
                                                            String replacedString = "";
                                                            String[] treatmentString = null;
                                                            if (treatments != null) {
                                                                for (int v = 0; v < treatments.size(); v++) {
                                                                    Treatment treatment = (Treatment) treatments.get(v);
                                                                    treatmentString = treatment.getTreatment().split(",");
                                                                    if (treatmentString[0].contains("Injection")) {
                                                                        replacedString = treatmentString[0].replaceAll("Injection", " ");
                                                                    }
                                                                    if (treatmentString[0].contains("Tablet")) {
                                                                        replacedString = treatmentString[0].replaceAll("Tablet", " ");
                                                                    }
                                                                    if (treatmentString[0].contains("Suppository")) {
                                                                        replacedString = treatmentString[0].replaceAll("Suppository", " ");
                                                                    }
                                                                    if (treatmentString[0].contains("Capsule")) {
                                                                        replacedString = treatmentString[0].replaceAll("Capsule", " ");
                                                                    }
                                                                    if (treatmentString[0].contains("Syrup")) {
                                                                        replacedString = treatmentString[0].replaceAll("Syrup", " ");
                                                                    }
                                                                    if (treatmentString[0].contains("Cream")) {
                                                                        replacedString = treatmentString[0].replaceAll("Cream", " ");
                                                                    }

                                                        %>
                                                        <option value="<%=replacedString%>><<%=treatment.getTreatmentid()%>"><%=replacedString%></option> 
                                                        <% }

                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select class="input-small" name="strength" id="strength<%=visitObject.getVisitid()%>" onchange=addType("drugtype<%=visitObject.getVisitid()%>","tt<%=visitObject.getVisitid()%>")>
                                                        <option value="Select">
                                                            Select
                                                        </option>
                                                        <option value="100MG">
                                                            100MG
                                                        </option>
                                                        <option value="300MG">
                                                            300MG
                                                        </option>
                                                        <option value="10 mg/ml">
                                                            10 mg/ml
                                                        </option>
                                                        <option value="250 m">
                                                            250 m
                                                        </option>
                                                        <option value="5 mg/ml">
                                                            5 mg/ml
                                                        </option>
                                                        <option value="10 % B1/M">
                                                            10 % B1/M
                                                        </option>
                                                        <option value="1% A/M ">
                                                            1% A/M 
                                                        </option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select class="input-small" name="drugtype" id="drugtype<%=visitObject.getVisitid()%>" onchange=addType("drugtype<%=visitObject.getVisitid()%>","tt<%=visitObject.getVisitid()%>")>
                                                        <option value="Select">
                                                            Select
                                                        </option>
                                                        <option value="Tablet">
                                                            Tablet
                                                        </option>
                                                        <option value="Syrup">
                                                            Syrup
                                                        </option>
                                                        <option value="Capsule">
                                                            Capsule
                                                        </option>
                                                        <option value="Cream">
                                                            Cream
                                                        </option>
                                                        <option value="Injection">
                                                            Injection
                                                        </option>
                                                        <option value="Supp">
                                                            Suppository
                                                        </option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select class="input-small"  name="dosage" id="dosage<%=visitObject.getVisitid()%>">
                                                        <option value="Select">Select</option>
                                                        <%
                                                            dosages = mgr.listDosages();
                                                            if (dosages != null) {
                                                                for (int v = 0; v < dosages.size(); v++) {
                                                                    Dosage dosage = (Dosage) dosages.get(v);
                                                        %>
                                                        <option value="<%=dosage.getShortcut()%>_<%=dosage.getMapped()%>"><%=dosage.getShortcut()%></option> 
                                                        <% }
                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                                <td>

                                                    <input type="text" value="" class="input-small" name="duration" id="duration<%=visitObject.getVisitid()%>"/>
                                                </td>
                                                </td>
                                                <td>                                   
                                                    <select class="input-mini" name="qty" id="qty<%=visitObject.getVisitid()%>" onchange=addQuantity("qty<%=visitObject.getVisitid()%>","tt<%=visitObject.getVisitid()%>")>
                                                        <option value="0">
                                                            0
                                                        </option>
                                                        <option value="1">
                                                            1
                                                        </option>
                                                        <option value="2">
                                                            2
                                                        </option>
                                                        <option value="3">
                                                            3
                                                        </option>
                                                        <option value="4">
                                                            4
                                                        </option>
                                                        <option value="5">
                                                            5
                                                        </option>
                                                        <option value="6">
                                                            6
                                                        </option>
                                                        <option value="7">
                                                            7
                                                        </option>
                                                        <option value="8">
                                                            8
                                                        </option>
                                                        <option value="9">
                                                            9
                                                        </option>
                                                        <option value="10">
                                                            10
                                                        </option>

                                                    </select>
                                                </td>


                                            </tr>
                                        </tbody>
                                    </table>
                                    <table>
                                        <tbody style="max-height: 100px; overflow-y: auto;">
                                            <tr>
                                                <td class="center">
                                                   <!-- <button id="addCheckBoxes" class="btn btn-info span2" onclick='addTreatmentSelect("treatment<%=visitObject.getVisitid()%>");addCheckboxes("treatment<%=visitObject.getVisitid()%>","drugtype<%=visitObject.getVisitid()%>","qty<%=visitObject.getVisitid()%>","dosage<%=visitObject.getVisitid()%>");return false;'>
                                                        <i class="icon-white icon-pencil"> </i>   Add Treatment
                                                    </button>-->
                                                    <button id="addCheckBoxes" class="btn btn-info " onclick='addCheckboxes("treatment<%=visitObject.getVisitid()%>","drugtype<%=visitObject.getVisitid()%>","qty<%=visitObject.getVisitid()%>","dosage<%=visitObject.getVisitid()%>","duration<%=visitObject.getVisitid()%>","strength<%=visitObject.getVisitid()%>","append_<%=visitObject.getVisitid()%>");return false;'>
                                                        <i class="icon-white icon-plus-sign"> </i>   Add
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <%}%>
                                    <div id="" style="display: none;">
                                    </div>

                                    <table class="table" id="append_<%=visitObject.getVisitid()%>">
                                        <thead>
                                            <tr style="padding: 12px 0px 12px 0px;">
                                                <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                                    Selected Prescription
                                                </th>
                                            </tr>
                                        </thead>

                                    </table>
                                    <table >
                                        <thead>
                                            <tr>
                                                <th colspan="5" style="text-align: center;">
                                                    Prescription Note
                                                </th>
                                            </tr>
                                        </thead>

                                    </table>
                                    <textarea style="width: 95%; height: 100px;"  name="prescription_notes" ></textarea>
                                    <button id="adddiagnosis" class="btn btn-info btn-small" onclick='addPrescription();return false;'>
                                        <i class="icon-white icon-plus-sign"> </i>   Add 
                                    </button>
                                    <br/>

                                    <!--   <button class="btn btn-info btn-small center" style="text-align: center; margin-top: 10px;" type="button">
                                           <i class="icon icon-print icon-white"></i> Print Prescription
                                       </button>  -->

                                </div>
                                <div id="tabs-3">
                                    <label class="control-label" for="input01">Select Procedure : </label>
                                    <div class="controls">
                                        <select class="input-xxlarge"id="procedures<%=visitObject.getVisitid()%>" name="procedures" onchange="">

                                            <%List procedures = mgr.listProcedure();
                                                for (int index = 0; index < procedures.size(); index++) {
                                                    Procedure procedure = (Procedure) procedures.get(index);
                                            %>
                                            <option value="<%=procedure.getDescription()%>><<%=procedure.getCode()%>><<%=procedure.getPrice()%>"><%=procedure.getDescription()%></option>
                                            <%}%>
                                        </select>
                                        <div class="help-inline">
                                            <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addProcedure("procedures<%=visitObject.getVisitid()%>","procedure_<%=visitObject.getVisitid()%>");return false;'>
                                                <i class="icon-white icon-plus-sign"> </i>   Add 
                                            </button>
                                        </div>
                                    </div>
                                    <table id="procedure_<%=visitObject.getVisitid()%>" class="table table-bordered">
                                        <tr style="padding: 12px 0px 12px 0px;">
                                            <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                                Selected Procedures
                                            </th>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr style="padding: 12px 0px 12px 0px;">
                                            <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                                Previously Selected Procedures
                                            </th>
                                        </tr>
                                        <%
                                            List listProcedures = mgr.listProcdureordersByVisitid(visitObject.getVisitid());
                                            if (listProcedures.size() > 0 && listProcedures != null) {
                                                Procedureorders procedureOrder = (Procedureorders) listProcedures.get(0);
                                                List listPatientProcedure = mgr.listPatientProcdureByOrderid(procedureOrder.getOrderid());
                                                for (int p = 0; p < listPatientProcedure.size(); p++) {
                                                    PatientProcedure patientProcedure = (PatientProcedure) listPatientProcedure.get(p);

                                        %>
                                        <tr>
                                            <td>
                                                <%=mgr.getProcedure(patientProcedure.getProcedureCode()).getDescription()%>
                                            </td>
                                        </tr>
                                        <%}
                                            }%>
                                    </table>
                                    <br/>
                                    <button id="adddiagnosis" class="btn btn-info btn-small" onclick='addMoreProcedure();return false;'>
                                        <i class="icon-white icon-plus-sign"> </i>   Add 
                                    </button>  
                                </div>
                                <div id="tabs-1">

                                    <div class="controls">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Patient Prescriptions
                                                    </th>
                                                    <th>
                                                        Quantity
                                                    </th>
                                                    <th>
                                                        Dosage
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List prescriptions = mgr.patientTreatment(visitObject.getVisitid());
                                                    for (int p = 0; p < prescriptions.size(); p++) {
                                                        Patienttreatment patienttreatment = (Patienttreatment) prescriptions.get(p);
                                                        String paString[] = patienttreatment.getDosage().split("_");
                                                        String pastring = mgr.getTreatment(patienttreatment.getTreatmentid()).getTreatment().trim();
                                                        String print = pastring.substring(0, pastring.length() - 10);
                                                %>

                                            <script type="text/javascript">
                                                $('#dialog<%=patienttreatment.getId()%>dosage').dialog({
                                                    autoOpen : false,
                                                    width : 1200,
                                                    modal :true,
                                                    position : "top"
		
                                                });
                                                $('#dosage<%=patienttreatment.getId()%>link').click(function(){
                   
                                                    $('#dialog<%=patienttreatment.getId()%>dosage').dialog('open');
                                                    return false;
                                                });
                                            </script>
                                            <tr>
                                                <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                    <a href="" onclick ="return false" id="dosage<%=patienttreatment.getId()%>link"> <%=print%><a>
                                                            <div class="hide" id="dialog<%=patienttreatment.getId()%>dosage">
                                                                <form class="form-horizontal" action="" name="mainForm" id="mainForm">

                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputPassword">Quantity</label>
                                                                        <div class="controls">
                                                                            <input type="text" name="quantity" id="quantity<%=patienttreatment.getId()%>" value="" />
                                                                            <input type="hidden" name="nurse" id="nurse<%=patienttreatment.getId()%>" value="<%=user.getStaffid()%>" />
                                                                            <input type="hidden" name="visitid" id="visitid<%=patienttreatment.getId()%>" value="<%=visitObject.getVisitid()%>" />
                                                                            <input type="hidden" name="visitid" id="medicine<%=patienttreatment.getId()%>" value="<%=print%>" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-actions">
                                                                        <div class="controls">
                                                                            <button type="submit" class="btn btn-info btn-large" name="saveEvent" id="saveEvent" onclick='saveevent("nurse<%=patienttreatment.getId()%>","visitid<%=patienttreatment.getId()%>","quantity<%=patienttreatment.getId()%>","medicine<%=patienttreatment.getId()%>");return false;'>Save </button>
                                                                        </div>
                                                                    </div>
                                                                </form>

                                                            </div>
                                                            </td>
                                                            <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                <%=patienttreatment.getQuantity()%>
                                                            </td>
                                                            <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                <%=patienttreatment.getDosage().split("_")[1]%>
                                                            </td>

                                                            </tr>
                                                            <%}%>
                                                            </tbody>
                                                            </table>
                                                            <br/>
                                                            <table>
                                                                <thead>
                                                                    <tr>
                                                                        <th></th>
                                                                        <th>Patient Prescriptions</th>
                                                                        <th>Quantity</th>
                                                                        <th>Date Given</th>
                                                                        <th>Time</th>

                                                                        <th>Given By</th>
                                                                    </tr>

                                                                    <%
                                                                        List monitors = mgr.listDosagesMonitorByVisitid(visitObject.getVisitid());
                                                                        for (int p = 0; p < monitors.size(); p++) {
                                                                            Dosagemonitor dosagemonitor = (Dosagemonitor) monitors.get(p);
                                                                            if (dosagemonitor != null) {
                                                                    %>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td><a href="" id="" onclick='deleteevent("<%=dosagemonitor.getId()%>");return false'><img src="images/button_cancel.png" width="10px" height="10px"/></a></td>
                                                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                            <%=dosagemonitor.getTreatmentId()%>
                                                                        </td>
                                                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                            <%=dosagemonitor.getQuantity()%>
                                                                        </td>
                                                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                            <% SimpleDateFormat dateFormat1 = new SimpleDateFormat("EEEE DD MMMM, YYYY");
                                                                            %>
                                                                            <%=dateFormat1.format(dosagemonitor.getDate())%> 
                                                                        </td>
                                                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                            <%=dosagemonitor.getTime()%> 
                                                                        </td>

                                                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; word-spacing: 5px;">
                                                                            <%=mgr.getStafftableByid(dosagemonitor.getNurse()).getLastname()%> <%=mgr.getStafftableByid(dosagemonitor.getNurse()).getOthername()%>
                                                                        </td>
                                                                    </tr>
                                                                    <%}
                                                                        }%>
                                                                </tbody>
                                                            </table>

                                                            <!--      <table>
                                                            <%

                                                                if (listProcedures.size() > 0 && listProcedures != null) {
                                                                    Procedureorders procedureOrder = (Procedureorders) listProcedures.get(0);
                                                                    List listPatientProcedure = mgr.listPatientProcdureByOrderid(procedureOrder.getOrderid());
                                                                    for (int p = 0; p < listPatientProcedure.size(); p++) {
                                                                        PatientProcedure patientProcedure = (PatientProcedure) listPatientProcedure.get(p);

                                                            %>
                                                            <tr>
                                                                <td>
                                                            <%=mgr.getProcedure(patientProcedure.getProcedureCode()).getDescription()%>
                                                        </td>
                                                    </tr>
                                                            <%}
                                                                }%>
                                                        </table>   -->
                                                            <!--    <div class="help-inline">
                            
                                                                    <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addAllergy("allergy<%=visitObject.getVisitid()%>","selected<%=visitObject.getVisitid()%>");return false;'>
                                                                        <i class="icon-white icon-plus-sign"> </i>   Add 
                                                                    </button>
                                                                </div>
                                                            </div>  -->
                                                            </div>


                                                            <div class="hide" id="dialog<%=visitObject.getVisitid()%>dosage">
                                                                <form class="form-horizontal" action="" name="mainForm" id="mainForm">

                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputPassword">Quantity</label>
                                                                        <div class="controls">
                                                                            <input type="text" name="quantity" id="quantity<%=visitObject.getVisitid()%>" value="" />
                                                                            <input type="hidden" name="nurse" id="nurse<%=visitObject.getVisitid()%>" value="<%=user.getStaffid()%>" />
                                                                            <input type="hidden" name="visitid" id="visitid<%=visitObject.getVisitid()%>" value="<%=visitObject.getVisitid()%>" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputPassword">Select Medicine</label>
                                                                        <div class="controls">
                                                                            <select name="medicine" id="medicine<%=visitObject.getVisitid()%>">
                                                                                <% if (mgr.sponsorshipDetails(visitObject.getPatientid()).getType().equalsIgnoreCase("NHIS")) {
                                                                                        List ll = mgr.patientTreatment(visitObject.getVisitid());
                                                                                        for (int i = 0; i < ll.size(); i++) {
                                                                                            Patienttreatment patienttreatment = (Patienttreatment) ll.get(i);

                                                                                %>
                                                                                <option value="<%=mgr.getNhistreatment(patienttreatment.getTreatmentid()).getMedicine()%>">
                                                                                    <%=mgr.getNhistreatment(patienttreatment.getTreatmentid()).getMedicine()%>
                                                                                </option>
                                                                                <%}
                                                                                } else {
                                                                                    List ll = mgr.patientTreatment(visitObject.getVisitid());
                                                                                    for (int i = 0; i < ll.size(); i++) {
                                                                                        Patienttreatment patienttreatment = (Patienttreatment) ll.get(i);

                                                                                %>
                                                                                <option value="<%=mgr.getTreatment(patienttreatment.getTreatmentid()).getTreatment()%>">
                                                                                    <%=mgr.getTreatment(patienttreatment.getTreatmentid()).getTreatment()%>
                                                                                </option>
                                                                                <%}
                                                                                    }%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-actions">
                                                                        <div class="controls">
                                                                            <button type="submit" class="btn btn-info btn-large" name="saveEvent" id="saveEvent" onclick='saveevent("nurse<%=visitObject.getVisitid()%>","visitid<%=visitObject.getVisitid()%>","quantity<%=visitObject.getVisitid()%>","medicine<%=visitObject.getVisitid()%>");return false;'>Save </button>
                                                                        </div>
                                                                    </div>
                                                                </form>

                                                            </div>
                                                            </div>

                                                            </div>
                                                            </div>
                                                            <div style="display: none;"  class="thumbnail center previous_visit<%=visitObject.getPatientid()%>">
                                                                <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                                                    <li>
                                                                        <a style="text-align: center;"> <b> Previous Visits </b></a>
                                                                    </li>
                                                                </ul>
                                                                <table class="table table-bordered">

                                                                    <thead>
                                                                        <tr>
                                                                            <th style="color: #fff;">
                                                                                Admitted on 
                                                                            </th>
                                                                            <th style="color: #fff;">
                                                                                Discharged on 
                                                                            </th>
                                                                            <th style="color: #fff;">
                                                                                Diagnoses
                                                                            </th>
                                                                            <th style="color: #fff;">
                                                                                Action
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <% for (int r = 0; r < adminssionHistory.size(); r++) {
                                                                                Visitationtable vps = (Visitationtable) adminssionHistory.get(r);
                                                                                if (vps != null) {
                                                                        %>
                                                                        <tr>
                                                                            <td>
                                                                                <b style="color: #4183C4"> <%=formatter.format(vps.getAdmissiondate())%> </b>
                                                                            </td>

                                                                            <td>
                                                                                <% if (vps.getDischargedate() != null) {%>
                                                                                <b style="color: #4183C4"><%=vps.getDischargedate()%></b>

                                                                                <% } else {%>
                                                                                <label style="line-height: 18px;" class="label label-important center ">On Admission</label>
                                                                                <% }%>
                                                                            </td>
                                                                            <td style="vertical-align: middle; padding-left: 30px;">
                                                                                <%List diagnosesList = mgr.patientDiagnosis(vps.getVisitid());
                                                                                    for (int d = 0; d < diagnosesList.size(); d++) {
                                                                                        Patientdiagnosis patientdiagnosis = (Patientdiagnosis) diagnosesList.get(d);

                                                                                %>
                                                                                <%=mgr.getDiagnosis(patientdiagnosis.getDiagnosisid()) == null ? "" : mgr.getDiagnosis(patientdiagnosis.getDiagnosisid()).getDiagnosis()%> 

                                                                                <% if (d > 0) {%>
                                                                                <br />   
                                                                                <%}

                                                                                    }%>
                                                                            </td>
                                                                            <td style="text-align: center;">

                                                                                <button id="transcript<%=vps.getVisitid()%>link" type="button" class="btn btn-small btn-info">
                                                                                    View Transcript
                                                                                </button>
                                                                                <div id="transcript<%=vps.getVisitid()%>" class="">
                                                                                    <div style="margin-bottom: -15px;" class="row">
                                                                                        <div class="span3" style="float: left;">
                                                                                            <img src="images/danpongclinic.png" width="200px;" style="margin-top: 30px;" />
                                                                                        </div>
                                                                                        <img src="images/danpongaddress.png" width="200px;" style="float: right; margin-top: 20px;" /> 
                                                                                    </div>

                                                                                    <div style="clear: both;"></div>

                                                                                    <hr style="border: solid #000000 0.5px ;"  />

                                                                                    <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                                                                        <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 0px; margin-top: 2px; font-size: 14px; ">VISIT TRANSCRIPT </h3>
                                                                                        <%= formatter1.format(vps.getDate())%>

                                                                                    </div>
                                                                                    <hr style="border: solid #000000 0.5px ;"  />
                                                                                    <span class="span4"><b> RE:  &nbsp; &nbsp; </b>    <%= mgr.getPatientByID(vps.getPatientid()).getFname()%> <%= mgr.getPatientByID(vps.getPatientid()).getMidname()%> <%= mgr.getPatientByID(vps.getPatientid()).getLname()%> </span> <span class="pull-right span3">  <b>Date of Birth :</b> <%= mgr.getPatientByID(vps.getPatientid()).getDateofbirth()%> </span> <br />
                                                                                    <span class="span4"><b> Brief Medical History: </b> </span> 
                                                                                    <div class="clearfix"></div>
                                                                                    <table class="span8">


                                                                                        <thead>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <b> Relevant Clinical Findings </b>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <b> TEMPERATURE </b>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <b> PULSE </b>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <b> BP </b>
                                                                                                </td>

                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <tr>

                                                                                            </tr>

                                                                                        </tbody>
                                                                                    </table>  
                                                                                    <span class="span4"><b> Possible results of any investigations done: </b> </span> 
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="span8">
                                                                                        <%
                                                                                            List pInvestigations = mgr.patientInvestigation(vps.getVisitid());
                                                                                            for (int d = 0; d < pInvestigations.size(); d++) {
                                                                                                Patientinvestigation pInvestigation = (Patientinvestigation) pInvestigations.get(d);

                                                                                        %>
                                                                                        <%=mgr.getInvestigation(pInvestigation.getInvestigationid()).getName()%> <br/>
                                                                                        <%}%>
                                                                                    </span>
                                                                                    <span class="span4"><b> Provisional Diagnosis: </b> </span> 
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="span8"><% diagnosesList = mgr.patientDiagnosis(vps.getVisitid());
                                                                                        for (int d = 0; d < diagnosesList.size(); d++) {
                                                                                            Patientdiagnosis patientdiagnosis = (Patientdiagnosis) diagnosesList.get(d);
                                                                                        %>
                                                                                        <%=mgr.getDiagnosis(patientdiagnosis.getDiagnosisid()) == null ? "" : mgr.getDiagnosis(patientdiagnosis.getDiagnosisid()).getDiagnosis()%> <br/>
                                                                                        <%}%>
                                                                                    </span>
                                                                                    <span class="span4"><b> Treatment given </b> </span> 
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="span8"> <%List dmonitors = mgr.listDosageMonitor(vps.getVisitid());
                                                                                        for (int t = 0; t < dmonitors.size(); t++) {
                                                                                            Dosagemonitor dosagemonitor = (Dosagemonitor) dmonitors.get(t);
                                                                                        %>
                                                                                        <%=dosagemonitor.getTreatmentId()%> <br/>
                                                                                        <%}%>
                                                                                    </span>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <%}
                                                                            }%>
                                                                    </tbody>

                                                                </table>
                                                            </div>
                                                            <div style="display: none;"  class="thumbnail center summary<%=visitObject.getPatientid()%>">
                                                                <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                                                    <li>
                                                                        <a style="text-align: center;"> <b> Visit Summary </b></a>
                                                                    </li>

                                                                </ul>
                                                            </div>

                                                            </div>
                                                            </form>        
                                                            </div>
                                                            </div>
                                                            <div class="clear"></div>

                                                            <% }%>
                                                            <%     }
                                                                }
                                                            %>

                                                            </body>
                                                            </html>
                                                            <div title="Success" class="center hide" id="success">
                                                                <span class="lead center">Vital Saved Successfully</span>
                                                            </div>
