<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
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
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
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

                <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li class="active">
                            <a href="#">Patient Consulting (Reviews)  </a><span class="divider"></span>
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
                                    <th>Date of Birth</th>
                                    <th>Sponsor</th>
                                    <th>Registered On</th>
                                    <th style="text-transform: capitalize;"> <%=(String) session.getAttribute("unit")%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    Visitationtable vs = null;
                                    List investigations = null;
                                    List nhisinvestigations = null;
                                    List treatments = null;
                                    List dosages = null;

                                    Date date = new Date();
                                    //System.out.println(dateFormat.format(date));
                                    List visits = mgr.listSecondaryConsultation("consultation");
                                    if (visits != null) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            Visitationtable visit = (Visitationtable) visits.get(i);
                                            vs = mgr.currentVisitations(visit.getVisitid());
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
                                        <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> 
                                    </td>
                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofregistration())%>
                                    </td>
                                    <td class="center">
                                        <a id="<%=visit.getPatientid()%><%=visit.getVisitid()%>link"  class="visitlink btn btn-info"> <i class="icon-pencil icon-white"> </i> Consultation </a>
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
        <%@include file="widgets/javascripts.jsp" %>
        <script type="text/javascript">
            function updateLaborders(){
                //alert("here at least");
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
                //return false;
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
                /* if(t2 =="Select"){
                    alert("Please select drug form before adding");
                    document.getElementById(id2).focus();
                    return;
                }*/
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
                /*if(t6 =="Select"){
                    alert("Please select drug strength");
                    document.getElementById(id6).focus();
                    return;
                }
                 */
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
                // tr.appendChild(td2);
                // tr.appendChild(td3);
                // tr.appendChild(td4);
                // tr.appendChild(td5);
                // tr.appendChild(td6);
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
                // tr.appendChild(td2);
                // tr.appendChild(td3);
                // tr.appendChild(td4);
                // tr.appendChild(td5);
                // tr.appendChild(td6);
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
                alert(sel);
                sels.appendChild(opt);
            }
            
            function addInvestigationSelect(id){
                var sel = document.getElementById(id).value;
               
                var sels = document.getElementById("inid");
                var opttext = document.createTextNode(sel);
                var opt = document.createElement("option");
                opt.appendChild(opttext);
                opt.value=sel;
                alert(sel);
                sels.appendChild(opt);
            }
            
            function addTreatmentSelect(id){
                var sel = document.getElementById(id).value;
               
                var sels = document.getElementById("trid");
                var opttext = document.createTextNode(sel);
                var opt = document.createElement("option");
                opt.appendChild(opttext);
                opt.value=sel;
                alert(sel);
                sels.appendChild(opt);
            }
            
            function echoAdded(){
                var echo = document.getElementById("pid").value;
                
                alert(echo);
            }
            function removeMe(id){
                //alert("here"+id.value);
                id.value=""; 
                var rem = document.removeChild(id);
                alert("here"+rem.value)
            }
        </script>


        <%

            String file = "";
            String file2 = "";

            /*  if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("nhis")) {
             file = "gettreatment.jsp";
             } else {
             file = "getnhistreatment.jsp";
             }*/
            if (visits != null) {
                for (int i = 0; i < visits.size(); i++) {
                    Visitationtable visit = (Visitationtable) visits.get(i);
                    // vs = mgr.currentVisitations(visit.getVisitid());
                    List patientHistory = mgr.patientHistory(visit.getPatientid());
        %>
        <script type="text/javascript">
            $(document).ready(function(){
                
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog({
                    autoOpen : false,
                    width : 1000,
                    modal :true,
                    position : "top"
		
                });
                
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>link').click(function(){
                    
                    $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog('open');
                    return false;
                });
                
                $(".vital_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
        
                    $(".vital<%=visit.getPatientid()%>").slideDown("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
           
            
                });
    
                $(".history_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".history<%=visit.getPatientid()%>").slideDown("slow");
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
                });
    
                $(".physical_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideDown("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
                });
    
                $(".laboratory_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideDown("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
                });
    
                $(".diagnosis_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideDown("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
                });
    
                $(".treatment_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideDown("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
                });
   
        
                $(".previous_visit_link<%=visit.getPatientid()%>").click(function(){
        
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideDown("slow");
                    $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
                });
    
                $(".summary_link<%=visit.getPatientid()%>").click(function(){
                    $(".bar").addClass("btn-info")
                    $(".bar").removeClass("btn-inverse")
                
                    $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                    $(".physical<%=visit.getPatientid()%>").slideUp("slow");
                    $(".history<%=visit.getPatientid()%>").slideUp("slow");
                    $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                    $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                    $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                    $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                    $(".summary<%=visit.getPatientid()%>").slideDown("slow");
                });
                                                   
                
            });
        </script>

        <div style="max-height: 680px; overflow-y: scroll; overflow-x: hidden; display: none;" class="visit hide" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>"  title="Consultation for <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>,  <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>   ">
            <div class="span10">

                <div style="margin-left: -50px;" class="span2 ">
                    <ul class="menu">
                        <li> <a class="vital_link<%=visit.getPatientid()%> active"> <i class="icon icon-check"> </i> Vitals Signs </a></li>
                        <li> <a class="history_link<%=visit.getPatientid()%>"> <i class="icon  icon-list-alt"> </i> History </a></li>
                        <li> <a class="physical_link<%=visit.getPatientid()%>"> <i class="icon  icon-user"> </i> Physical Exam </a></li>
                        <li> <a class="laboratory_link<%=visit.getPatientid()%>"> <i class="icon  icon-search"> </i> Laboratory </a></li>
                        <li> <a class="diagnosis_link<%=visit.getPatientid()%>"> <i class="icon  icon-adjust"> </i> Diagnoses </a></li>
                        <li> <a class="treatment_link<%=visit.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Treatment </a></li>
                        <li> <a class="previous_visit_link<%=visit.getPatientid()%>"> <i class="icon  icon-file"> </i> Previous Visits </a></li>
                        <li> <a class="summary_link<%=visit.getPatientid()%>"> <i class="icon  icon-folder-open"> </i> Summary </a></li>

                    </ul>
                </div>
                <div class="span8">
                    <form class="form-inline" action="action/labnpharmactions.jsp" method="post" id="frm">
                        <div  class="thumbnail center vital<%=visit.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b> Patient Vitals </b></a>
                                </li>

                            </ul>
                            <% Vitaltable vitaltable = mgr.getVitaltableByid(vs.getVisitid());
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
                        <div style="display: none;"  class="thumbnail center history<%=visit.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b> History </b></a>
                                </li>

                            </ul>

                            <div class="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Allergies / Drug History</a></li>
                                    <li><a href="#tabs-2">Presenting Complaints</a></li>
                                    <li><a href="#tabs-3">Symptoms</a></li>
                                </ul>
                                <div id="tabs-1">
                                    <table class="table  right table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="color: #fff;">Allergy</th>
                                                <th style="color: #fff;">Possible Reactions </th>
                                                <th style="color: #fff;">Suggested Treatment</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% List allergies = mgr.listAllergiessByPatientid(vs.getPatientid());
                                                if (allergies != null) {
                                                    for (int dex = 0; dex < allergies.size(); dex++) {
                                                        PatientAllergies allergy = (PatientAllergies) allergies.get(dex);
                                                        if (allergy != null) {
                                            %>
                                            <tr>
                                                <td><%=mgr.getAllergyByid(allergy.getAllergyid()).getName()%></td>

                                                <td><%=mgr.getAllergyByid(allergy.getAllergyid()).getPossibleRxns()%></td>

                                                <td><%=mgr.getAllergyByid(allergy.getAllergyid()).getSuggestedTreatment()%></b></td>
                                            </tr>

                                        </tbody>
                                        <%}
                                                }
                                            }%>
                                    </table>
                                </div>
                                <div id="tabs-2">
                                    <textarea style="width: 95%; height: 50px" name="complaints"></textarea>
                                </div>
                                <div id="tabs-3">
                                    <table class="table  right table table-bordered">
                                        <tr>
                                            <td><b>Symptoms</b></td> <td><b>Symptom notes </b></td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <% List visitSymptoms = mgr.listVisistSymptomsByVisitid(vs.getVisitid());
                                                        VisitSymptoms symptoms = null;
                                                        if (visitSymptoms != null) {
                                                            for (int ind = 0; ind < visitSymptoms.size(); ind++) {
                                                                symptoms = (VisitSymptoms) visitSymptoms.get(ind);
                                                                if (symptoms != null) {
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%=mgr.getSymptomById(symptoms.getSymptomid()).getSymptomname()%>
                                                        </td>
                                                    </tr>
                                                    <%}
                                                            }
                                                        }%>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                            </div>

                    </form>
                </div>
                <div style="display: none;" class="thumbnail center physical<%=visit.getPatientid()%>">
                    <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                        <li>
                            <a style="text-align: center;"><b> Physical Examination </b></a>
                        </li>

                    </ul>

                    <table>
                        <%List questions = mgr.listClerkQuestions();
                            for (int w = 0; w < questions.size(); w++) {
                                Clerkingquestion clerkingquestion = (Clerkingquestion) questions.get(w);
                        %>
                        <tr>
                            <td>
                                <b style="color: #4183C4"><%=clerkingquestion.getQuestion()%></b>
                            </td>
                            <td>
                                <div class="radioset">
                                    <% List answers = mgr.listClerkAnswersByQuestionid(clerkingquestion.getClerkid());
                                        for (int y = 0; y < answers.size(); y++) {
                                            Clerkinganswer clerkinganswer = (Clerkinganswer) answers.get(y);
                                    %>
                                    <input type="radio" id="age1<%=clerkinganswer.getAnswerid()%>" name="ans" value="<%=clerkingquestion.getClerkid()%>_<%=clerkinganswer.getAnswerid()%> "/><label for="age1<%=clerkinganswer.getAnswerid()%>"><%=clerkinganswer.getAnswer()%></label>
                                   <!-- <input type="radio" id="age2<%=visit.getPatientid()%>" name="age" /><label for="age2<%=visit.getPatientid()%>"><%=clerkinganswer.getAnswer()%></label>
                                    <input type="radio" id="age3<%=visit.getPatientid()%>" name="age" /><label for="age3<%=visit.getPatientid()%>"><%=clerkinganswer.getAnswer()%></label>-->
                                    <%}%>
                                </div>
                            </td>

                        </tr>
                        <%}%>
                    </table>

                </div>
                <div style="display: none;" class="thumbnail center laboratory<%=visit.getPatientid()%>">
                    <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                        <li>
                            <a href="#" onclick="showdInvestigation()"><b> Laboratory</b></a>
                        </li>

                    </ul>

                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs-1">Investigations</a></li>
                            <li><a href="#tabs-2">Results</a></li>

                        </ul>
                        <div id="tabs-1">
                            <div class="center" id="lab">
                                <% %>
                                <table>
                                    <tr>
                                        <td>
                                            <select class="input-xxlarge select"  id="test<%=visit.getVisitid()%>" onchange = ''>
                                                <option value="Select">Select Investigation</option>
                                                <%

                                                    investigations = mgr.listMainInvestigation();
                                                    if (investigations != null) {
                                                        for (int p = 0; p < investigations.size(); p++) {
                                                            Investigation investigation = (Investigation) investigations.get(p);
                                                            if (investigation != null) {
                                                %>
                                                <option value="<%=investigation.getName()%>><<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></option> 
                                                <% }
                                                    }%>
                                            </select> 


                                            <% }
                                                %>
                                        </td>

                                        <td>
                                            <button id="addCheckBoxes" class="btn btn-info" onclick='addInvestigationCheck("test<%=visit.getVisitid()%>","appendx_<%=visit.getVisitid()%>");return false;'>
                                                <i class="icon-white icon-pencil"> </i>   Add Investigation
                                            </button>
                                        </td> 
                                    </tr>
                                </table>
                                <table id="appendx_<%=visit.getVisitid()%>" class="table">

                                    <thead>
                                        <tr style="padding: 12px 0px 12px 0px;">
                                            <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                                Selected Investigations
                                            </th>
                                        </tr>
                                    </thead>

                                </table>
                                Investigation Note <br />  <br />
                                <textarea style="width: 95%" name="investigation_note"></textarea>

                                <button class="btn btn-info btn-small center" style="text-align: center; margin-top: 10px;" type="button">
                                    <i class="icon icon-print icon-white"></i> Print Lab Request
                                </button>
                            </div>
                        </div>
                        <div id="tabs-2">
                            <div id="results">
                                <table cellpadding="0" cellspacing="0" border="0" class="table">

                                    <thead>
                                        <tr >
                                            <th>
                                                <label style="color: white; font-weight: bold"> Order By</label>
                                            </th>
                                            <th>
                                                <label style="color: white; font-weight: bold"> Ordered Date </label>
                                            </th>
                                            <th>
                                                <label style="color: white; font-weight: bold" > Done On </label>
                                            </th>
                                            <th>
                                                <label style="color: white; font-weight: bold"> View </label>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List labids = mgr.listLabordersByVisitid(visit.getVisitid());
                                            if (labids.size() > 0) {
                                                System.out.println(labids.size());
                                                Laborders laborder = (Laborders) labids.get(0);
                                                if (labids != null) {
                                        %>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <%=laborder.getOrderdate()%> 
                                            </td>
                                            <td>
                                                <%=laborder.getDonedate()%> 

                                            </td>

                                            <td style="text-align: center">
                                                <button  value="view" class="btn btn-info btn-small" onclick="updateLaborders();return false;">

                                                    </i> View Lab Report
                                                </button>
                                            </td>
                                        </tr>
                                        <% }
                                        } else {%>
                                    <div style=" padding: 20px;" > <h3> No Laboratory Results for Today's Visit
                                        </h3>

                                    </div>
                                    <%}
                                        List results = mgr.listLabordersByPatientid(visit.getPatientid());
                                        if (results != null) {
                                            for (int var = 0; var < results.size(); var++) {
                                                Laborders laborders = (Laborders) results.get(var);
                                                if (!laborders.getViewed()) {
                                    %>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <%=laborders.getOrderdate()%> 
                                        </td>
                                        <td>
                                            <%=laborders.getDonedate()%> 
                                           <!-- <input type="hidden" name="labid" value="<%=laborders.getOrderid()%>"/> -->
                                        </td>

                                        <td style="text-align: center">
                                            <button  value="view" class="btn btn-info btn-small" onclick="updateLaborders();return false;">

                                                View Lab Report
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
                </div>

                <div style="display: none;" class="thumbnail center diagnosis<%=visit.getPatientid()%>">
                    <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                        <li>
                            <a style="text-align: center;"><b> Diagnosis </b></a>
                        </li>

                    </ul>

                    <table class="table"> 
                        <tr>
                            <td>
                                <%if (mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {%>
                                <select class="input-xxlarge select" id="diagnosis<%=visit.getVisitid()%>" onchange =''>

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

                                <select class="input-xxlarge select" id="diagnosis<%=visit.getVisitid()%>" onchange =''>

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
                                <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addDiadChecks("diagnosis<%=visit.getVisitid()%>","appendd_<%=visit.getVisitid()%>" );return false;'>
                                    <i class="icon-white icon-pencil"> </i>   Add Diagnosis
                                </button>
                            </td>
                        </tr>

                    </table> 
                    <table id="appendd_<%=visit.getVisitid()%>" class="table">
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

                </div>
                <div style="display: none;" class="thumbnail center treatment<%=visit.getPatientid()%>">
                    <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                        <li>
                            <b> <a>Treatment</a> </b>
                        </li>
                    </ul>
                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs-1">Prescription</a></li>
                            <li><a href="#tabs-2">Procedures</a></li>

                        </ul>
                        <div id="tabs-1">

                            
                            <table class="consult table"> 

                                <thead>

                                    <tr>
                                        <th>
                                            Name of Drug
                                        </th>
                                        <th>
                                            Strength 
                                        </th>
                                        <th>
                                            Form 
                                        </th>
                                        <th>
                                            Dosage
                                        </th>
                                        <th>
                                            Duration 
                                        </th>
                                        <th>
                                            Quantity 
                                        </th>
                                    </tr>

                                </thead>
                                <tbody style="max-height: 100px; overflow-y: auto;">                     

                                    <tr>

                                        <td> 
                                            <select class="input-large select"  id="treatment<%=visit.getVisitid()%>" onchange = 'addTreatment("treatment<%=visit.getVisitid()%>","tt<%=visit.getVisitid()%>")'>
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
                                                <option value="<%=treatment.getBatchNumber()%>><<%=treatment.getBatchNumber()%>"><%=replacedString%></option> 
                                                <% }

                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="input-small" name="strength" id="strength<%=visit.getVisitid()%>" onchange=addType("drugtype<%=visit.getVisitid()%>","tt<%=visit.getVisitid()%>")>
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
                                            <select class="input-small" name="drugtype" id="drugtype<%=visit.getVisitid()%>" onchange=addType("drugtype<%=visit.getVisitid()%>","tt<%=visit.getVisitid()%>")>
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
                                            <select class="input-small"  name="dosage" id="dosage<%=visit.getVisitid()%>">
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

                                            <input type="text" value="" class="input-small" name="duration" id="duration<%=visit.getVisitid()%>"/>
                                        </td>
                                        </td>
                                        <td>                                   
                                            <select class="input-mini" name="qty" id="qty<%=visit.getVisitid()%>" onchange=addQuantity("qty<%=visit.getVisitid()%>","tt<%=visit.getVisitid()%>")>
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
                                            <button id="addCheckBoxes" class="btn btn-info " onclick='addCheckboxes("treatment<%=visit.getVisitid()%>","drugtype<%=visit.getVisitid()%>","qty<%=visit.getVisitid()%>","dosage<%=visit.getVisitid()%>","duration<%=visit.getVisitid()%>","strength<%=visit.getVisitid()%>","append_<%=visit.getVisitid()%>");return false;'>
                                                <i class="icon-white icon-pencil"> </i>   Add Treatment
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <div id="" style="display: none;">
                            </div>

                            <table class="table" id="append_<%=visit.getVisitid()%>">
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
                            <textarea style="width: 95%"  name="prescription_notes" ></textarea>

                            <button class="btn btn-info btn-small center" style="text-align: center; margin-top: 10px;" type="button">
                                <i class="icon icon-print icon-white"></i> Print Prescription
                            </button>

                        </div>
                        <div id="tabs-2">
                            <label class="control-label" for="input01">Select Procedure : </label>
                            <div class="controls">
                                <select class="input-xxlarge"id="procedures<%=visit.getVisitid()%>" name="procedures" onchange="">

                                    <%List procedures = mgr.listProcedure();
                                        for (int index = 0; index < procedures.size(); index++) {
                                            Procedure procedure = (Procedure) procedures.get(index);
                                    %>
                                    <option value="<%=procedure.getDescription()%>><<%=procedure.getCode()%>><<%=procedure.getPrice()%>"><%=procedure.getDescription()%></option>
                                    <%}%>
                                </select>
                                <div class="help-inline">
                                    <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addProcedure("procedures<%=visit.getVisitid()%>","procedure_<%=visit.getVisitid()%>");return false;'>
                                        <i class="icon-white icon-plus-sign"> </i>   Add 
                                    </button>
                                </div>
                            </div>
                            <table id="procedure_<%=visit.getVisitid()%>" class="table table-bordered">
                                <tr style="padding: 12px 0px 12px 0px;">
                                    <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                        Selected Procedures
                                    </th>
                                </tr>
                            </table>
                        </div>

                    </div>

                </div>

                <div style="display: none;" class="thumbnail center previous_visit<%=visit.getPatientid()%>">
                    <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                        <li>
                            <b> <a>Previous Visits</a> </b>
                        </li>
                    </ul>
                </div>

                <div style="display: none;" class="thumbnail center summary<%=visit.getPatientid()%>">
                    <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                        <li>
                            <b> <a>Visit Summary</a> </b>
                        </li>
                    </ul>

                </div>

                <div class="form-actions center" >
                    <table style="margin: 0px; padding: 0px;" class="span3 pull-left table-condensed">
                        <tr>
                            <td>
                                <label style="margin-top: 8px;" class="pull-left">Admit Patient</label>
                            </td>
                            <td>
                                <label class="switch-container">


                                    <%if (visit.getPatientstatus().equals("In Patient")) {%>
                                    <input style="vertical-align: middle;" type="checkbox" checked="checked" name="admission" value="In Patient"style="width: 100px" class="switch-input checkValue hide"/>
                                    <% } else {%> <input style="vertical-align: middle;" type="checkbox" name="admission" value="In Patient"style="width: 100px" class="switch-input checkValue hide"/>  <%}%>
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
                                <label style="margin-top: 8px;" class="pull-left">Detain Patient</label>
                            </td>
                            <td>
                                <label class="switch-container">


                                    <%if (visit.getPatientstatus().equals("In Patient")) {%>
                                    <input style="vertical-align: middle;" type="checkbox" checked="checked" name="admission" value="In Patient"style="width: 100px" class="switch-input checkValue hide"/>
                                    <% } else {%> <input style="vertical-align: middle;" type="checkbox" name="admission" value="In Patient"style="width: 100px" class="switch-input checkValue hide"/>  <%}%>
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
                                <label style="margin-top: 8px;" class="pull-left">Refer Patient</label>
                            </td>
                            <td>
                                <label class="switch-container">


                                    <%if (visit.getPatientstatus().equals("In Patient")) {%>
                                    <input style="vertical-align: middle;" type="checkbox" checked="checked" name="admission" value="In Patient"style="width: 100px" class="switch-input checkValue hide"/>
                                    <% } else {%> <input style="vertical-align: middle;" type="checkbox" name="admission" value="In Patient"style="width: 100px" class="switch-input checkValue hide"/>  <%}%>
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div>  
                                </label> 
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="patientid" value="<%=visit.getPatientid()%>"/>
                    <input type="hidden" name="id" value="<%=visit.getVisitid()%>"/> 
                    <input type="hidden" name="unitid" value="pharmacy"/> 

                    <button type="submit" name="action" value="Forward" class="btn btn-danger btn-small pull-right">

                        <i class="icon-white icon-arrow-right"> </i> Forward
                    </button>


                    <!-- <select class="input-medium pull-right" name="unitid">
                    <%
                        List lists = mgr.listUnits();

                        for (int r = 0; r < lists.size(); r++) {
                            Units unit = (Units) lists.get(r);
                    %>  
                    <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option>
                    <%}
                    %>
                    </select> -->





                </div>
                </form>
            </div>
        </div>
    </div>



    <%     }
        }
    %>
</body>

</html>