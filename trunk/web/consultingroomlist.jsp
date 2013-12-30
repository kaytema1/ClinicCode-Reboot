<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<%
    Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    String patientVisit = request.getParameter("visitId");
    
    if(patientVisit == null || patientVisit == "") {
        
        session.setAttribute("lasterror", "Please Select a Patient!");
        response.sendRedirect("consultingroom.jsp");
    }
    
    int visitId = Integer.parseInt(patientVisit);
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("EEEE dd MMM, yyyy");
    
    
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
      <!--  <link rel="stylesheet" href="docsupport/style.css">
        <link rel="stylesheet" href="docsupport/prism.css">   -->
        <link rel="stylesheet" href="css/chosen.css">
        <style type="text/css" media="all">
            /* fix rtl for demo */
            .chosen-rtl .chosen-drop { left: -9000px; }
        </style>
        <style type="text/css">
            .consult th {
                border-top: 1px solid #DDDDDD;
                line-height: 18px;
                text-align: center;
                vertical-align: top;
                color: #FFFFFF;
                font-size: 12px;
            }
        </style>
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
            
            
            function addNHISPrintCheckboxes(id1,id3,id4,id5,id7){
                 
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
                tr.style.cssText = 'line-height: 25px; padding-left: 10px; font-size:12px;'
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
                //var btn = document.createElement( "button" );
                //btn.innerHTML = 'Remove';
                // alert(text);
                //tr.appendChild(td);
                //var cb = document.createElement( "input" );
                //cb.type = "checkbox";
                //cb.id = "id";
                
                tr.id = "tr2_"+addcount;
                //cb.name = "data";
                
                //Injection Diazopam 10mg Daily for 2 weeks 
                var spl = t1.split("><");
                var dosage = t4.split("_");
                var prescription = "•   "+spl[0]+" "+dosage[1]+" for "+t5;
                var presctext = document.createTextNode(prescription);
                var ttt = ""+t1+"><"+" "+"><"+t3+"><"+t4;
                //cb.value = ttt;
                //cb.checked = true;
                td1.appendChild(presctext);
                //td2.appendChild(text2);
                td3.appendChild(text3);
                td4.appendChild(text4);
                td5.appendChild(text5);
                //td6.appendChild(text6);
                
                
                //td7.appendChild(cb);
                //td8.appendChild(btn);
                // td.appendChild(text);
                tr.appendChild(td1);
                tr.appendChild(td7);
                tr.appendChild(td8);
                
                document.getElementById( id7 ).appendChild( tr );
                //return false;
                // tr.appendChild(td8);
                
                /*
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
                 */
            
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
            
            
            function addPrintCheckboxes (id9,id10,id11,id12,id13,id14,id15){
                addcount++;
                var t1 = document.getElementById(id9).value;
                var t2 = document.getElementById(id10).value;
                var t3 = document.getElementById(id11).value;
                var t4 = document.getElementById(id12).value;
                var t5 = document.getElementById(id13).value;
                var t6 = document.getElementById(id14).value;
                if(t1 =="Select"){
                    alert("Please select treatment before adding");
                    document.getElementById(id9).focus();
                    return;
                }
                if(t2 =="Select"){
                    alert("Please select drug form before adding");
                    document.getElementById(id10).focus();
                    return;
                }
                if(t3 =="0"){
                    alert("Quantity cannot be 0");
                    document.getElementById(id11).focus();
                    return;
                }
                if(t4 =="Select"){
                    alert("Please add dosage");
                    document.getElementById(id12).focus();
                    return;
                }
                if(t5 =="duration"){
                    alert("Please add duration");
                    document.getElementById(id13).focus();
                    return;
                }
                if(t6 =="Select"){
                    alert("Please select drug strength");
                    document.getElementById(id14).focus();
                    return;
                }
                
                var tr = document.createElement("tr");
                tr.style.cssText = 'line-height: 25px; padding-left: 10px; font-size:12px;'
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var text = document.createTextNode(document.getElementById(id9).value);
                var text2 = document.createTextNode(document.getElementById(id10).value);
                var text3= document.createTextNode(document.getElementById(id11).value);
                var text4 = document.createTextNode(document.getElementById(id12).value);
                var text5 = document.createTextNode(document.getElementById(id13).value);
                var text6 = document.createTextNode(document.getElementById(id14).value);
                // Comment by Emma var btn = document.createElement( "button" );
                // Comment by Emma btn.innerHTML = 'Remove';
                // alert(text);
                //tr.appendChild(td);
                // Comment by Emma var cb = document.createElement( "input" );
                // Comment by Emma cb.type = "checkbox";
                // Comment by Emma cb.id = "id";
                
                tr.id = "tr2_"+addcount;
                // Comment by Emma cb.name = "data";
                
                //Injection Diazopam 10mg Daily for 2 weeks 
                var spl = t1.split("><");
                var dosage = t4.split("_");
                var prescription = "•   "+t2+" "+spl[0]+" "+t6+" "+dosage[1]+" for "+t5;
                var presctext = document.createTextNode(prescription);
                var ttt = ""+t1+"><"+t2+"><"+t3+"><"+t4;
                // Comment by Emma cb.value = ttt;
                // Comment by Emma cb.checked = true;
                td1.appendChild(presctext);
                td2.appendChild(text2);
                td3.appendChild(text3);
                td4.appendChild(text4);
                td5.appendChild(text5);
                td6.appendChild(text6);
                
                
                // Comment by Emma td7.appendChild(cb);
                // Comment by Emma td8.appendChild(btn);
                // td.appendChild(text);
                tr.appendChild(td1);
               
                tr.appendChild(td7);
                tr.appendChild(td8);
                
                document.getElementById( id15 ).appendChild( tr );
                //return false;
                // tr.appendChild(td8);
                
               
                /* Comment by Emma btn.onclick = function(){
    
                    var tbl = document.getElementById(id7);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                }; */
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
                //alert("here"+id.value);
                id.value=""; 
                var rem = document.removeChild(id);
                alert("here"+rem.value)
            }
            function verifyavailability(id1,id2,id3,id4,id5,id6,id7,id9,id10,id11,id12,id13,id14,id15){
                var batch = document.getElementById(id1).value;
                $.post('patientcount.jsp', {action : "treatment", id : batch}, function(data) {
                    alert(data);
                    if(data>0){ 
                        addCheckboxes (id1,id2,id3,id4,id5,id6,id7);
                        // addPrintCheckboxes (id9,id10,id11,id12,id13,id14,id15);
                    }else{
                        alert("Not enough in stock please request an alternative");
                        return false;
                    }  
                });
                
            }
        </script>



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
                            <a href="#">Consulting Patients</a><span class="divider"></span>
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
                                    <th style="text-align: left;">Folder Number </th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>

                                    <th style="text-align: left;" >Registered On</th>
                                    <th style="text-transform: capitalize;"> <%--(String) session.getAttribute("unit")--%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    //HMSHelper mgr = new HMSHelper();
                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                                    Visitationtable vs = null;
                                    List investigations = null;
                                    List nhisinvestigations = null;
                                    List treatments = null;
                                    List dosages = null;

                                    Date date = new Date();

                                    //System.out.println(dateFormat.format(date));
                                    String conroom = (String) session.getAttribute("unit");
                                    String ls = conroom.split("_")[0];
                                    System.out.println(ls);
                                    // out.print(ls);
                                    
                                    
                                    List visits = mgr.listUnitVisitations("consultation");
                                    
                                            Visitationtable visit = mgr.currentVisitations(visitId);
                                            
                                %>
                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder ; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getGender()%></td> </tr> <tr> <td> Employer </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getEmployer()%>  </td>  </tr> <tr> <td> Payment Type </td> <td>
                                        <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>">
                                        <a style="text-transform: uppercase;" class="patientid"><%= visit.getPatientid()%> </a> 
                                    </td>

                                    <td>
                                        <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>
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
                                    <td class="center">
                                        <a id="<%=visit.getPatientid()%><%=visit.getVisitid()%>link"  class="visitlink btn btn-info"> <i class="icon-pencil icon-white"> </i> Patient Care </a>
                                    </td>
                                </tr>
                                
                            </tbody>
                        </table>
                    </div>
                </div> 
            </section>

        </div>
        <%@include file="widgets/footer.jsp" %>

    </div><!-- /container -->


    <%@include file="widgets/javascripts.jsp" %>
    
    <script src="js/chosen.jquery.js" type="text/javascript"></script>
   <!-- <script src="docsupport/prism.js" type="text/javascript" charset="utf-8"></script>  -->
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
    </script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("input:checkbox").attr("checked", false);
        });
        
        function printSelection(node){

            var content=node.innerHTML
            var pwin=window.open('','print_content','width=800,height=1000');

            pwin.document.open();
            pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
            pwin.document.close();
 
            setTimeout(function(){pwin.close();},1000);

        }
        
        function printSelectionSmall(node){

            var content=node.innerHTML
            var pwin=window.open('','print_content','width=350,height=800');

            pwin.document.open();
            pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
            pwin.document.close();
 
            setTimeout(function(){pwin.close();},1000);

        }
    </script>

    <% 
                List patientHistory = mgr.patientHistory(visit.getPatientid());
    %>
    <script type="text/javascript">
        $(document).ready(function(){
                                                      
               alert("Hello")
            $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog({
                autoOpen : true,
                width : "95%",
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
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
           
            
            });
            
            $(".complaints_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
               
                $(".complaints<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
    
            $(".medical_history_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                $(".medical_history<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
            
            
            $(".family_history_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                $(".family_history<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
            
            
            $(".social_history_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                $(".social_history<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
               
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
    
            $(".system_review_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                
                $(".system_review<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
    
            $(".laboratory_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                
                $(".laboratory<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
    
            $(".diagnosis_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                
                $(".diagnosis<%=visit.getPatientid()%>").slideDown("slow"); 
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
    
            $(".treatment_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                
                $(".treatment<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
   
        
            $(".previous_visit_link<%=visit.getPatientid()%>").click(function(){
        
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                
                $(".previous_visit<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow");
                $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            
            });
    
            $(".summary_link<%=visit.getPatientid()%>").click(function(){
                $(".bar").addClass("btn-info")
                $(".bar").removeClass("btn-inverse")
                
                
                $(".summary<%=visit.getPatientid()%>").slideDown("slow");
                $(".vital<%=visit.getPatientid()%>").slideUp("slow");
                $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
                $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
                $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
                $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
                $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
                $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
                $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
                
            });
            
            
            var counter = 0;
            var labtestpricetotal = 0;
            
            $(".selected_result<%=visit.getPatientid()%>").change(function(){
                // alert($(this).attr("value"))
                var labtestname =  $(this).attr("labtestname");
                // var labtestprice = $(this).attr("labtestprice");
                // var labtestpricevalue = $(this).attr("labtestpricevalue");
                var labid = $(this).attr("labid");
                   
                    
                    
                   
                if($(this).is(':checked')){ 
                    counter = counter + 1;
                    $(this).addClass("counter"+counter)
                    //  labtestpricetotal = parseInt(labtestpricetotal) + parseInt(labtestpricevalue)
                    //$("#labtestpricetotal").html("<b> GH&#162;"+parseFloat(labtestpricetotal).toFixed(2)+ "</b>")
                    $('#selected_tests<%=visit.getPatientid()%> tbody').append("<tr ><td  class="+labid+">"+labtestname +"</td><td class="+labid+ "> </td></tr>");
                        
                    return false;
                        
                   
                }else{
                    //  labtestpricetotal = parseInt(labtestpricetotal) - parseInt(labtestpricevalue)
                    $("."+labid).hide();
                    //$("#labtestpricetotal").html("<b> GH&#162;"+parseFloat(labtestpricetotal).toFixed(2)+ "</b>")
                        
                }
                    
                    
                    
            });
           
            
        });
    </script>
    <% for (int q = 0; q < patientHistory.size(); q++) {
            Visitationtable vts = (Visitationtable) patientHistory.get(q);
    %>

    <script type="text/javascript">
        
        $(document).ready(function(){
            
            $('#visit_history<%=vts.getVisitid()%>').dialog({
                autoOpen : false,
                width : "87%",
                modal :true,
                position : "top"
		
            });
            
            $('#visit_history<%=vts.getVisitid()%>link').click(function(){
            
                $('#visit_history<%=vts.getVisitid()%>').dialog('open');
                
            });
        
        });
        
    </script>

    <% }%>

    <div style="max-height: 600px; overflow-y: scroll; overflow-x: hidden;" class="visit" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>"  title="Consultation for <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>  <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>   ">

        <div class="span12">
            <form class="form-inline" action="action/labnpharmactions.jsp" method="post" id="frm">
                <div style="margin-left: -30px; " class="span3">
                    <ul class="menu">
                        <li> <a style="font-size: 12px !important;" class="vital_link<%=visit.getPatientid()%> active"> <i class="icon icon-check"> </i> Vitals Review </a></li>
                        <li> <a style="font-size: 12px !important;"class="complaints_link<%=visit.getPatientid()%>"> <i class="icon  icon-question-sign"> </i> Chief Complaints </a></li>
                        <li> <a style="font-size: 12px !important;"class="medical_history_link<%=visit.getPatientid()%>"> <i class="icon  icon-time"> </i> Past Medical History </a></li>
                        <li> <a style="font-size: 12px !important;"class="family_history_link<%=visit.getPatientid()%>"> <i class="icon  icon-heart"> </i> Family History </a></li>
                        <li> <a style="font-size: 12px !important;"class="social_history_link<%=visit.getPatientid()%>"> <i class="icon  icon-globe"> </i> Social History </a></li>
                        <li> <a style="font-size: 12px !important;"class="system_review_link<%=visit.getPatientid()%>"> <i class="icon  icon-refresh"> </i> Systemic Review </a></li>
                        <li> <a style="font-size: 12px !important;"class="laboratory_link<%=visit.getPatientid()%>"> <i class="icon  icon-search"> </i> Laboratory </a></li>
                        <li> <a style="font-size: 12px !important;"class="diagnosis_link<%=visit.getPatientid()%>"> <i class="icon  icon-adjust"> </i> Diagnoses </a></li>
                        <li> <a style="font-size: 12px !important;"class="treatment_link<%=visit.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Treatment </a></li>
                        <li> <a style="font-size: 12px !important;"class="previous_visit_link<%=visit.getPatientid()%>"> <i class="icon  icon-file"> </i> Previous Visits </a></li>

                    </ul>


                    <table style="margin-left: 20px; padding: 0px;" class="pull-left table-condensed">
                        <tr>
                            <th style="color: #000;" colspan="2">

                                Patient Actions

                            </th>
                        </tr>
                        <tr>
                            <td>
                                <label style="margin-top: 8px;" class="pull-left">Admit </label>
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
                                <label style="margin-top: 8px;" class="pull-left">Detain </label>
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
                                <label style="margin-top: 8px;" class="pull-left">Refer</label>
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
                            <td colspan="2" style="text-align: left;">
                                <input type="hidden" name="patientid" value="<%=visit.getPatientid()%>"/>
                                <input type="hidden" name="id" value="<%=visit.getVisitid()%>"/> 
                                <input type="hidden" name="unitid" value="records"/>

                                <button type="submit" name="action" value="Forward" class="btn btn-danger btn-large">

                                    <i class="icon-white icon-arrow-right"> </i> Save & Forward
                                </button>

                            </td>
                        </tr>
                    </table>
                </div>
                <div class="span9">

                    <div  class="thumbnail center vital<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a style="text-align: center;"> <b> Vitals Review </b></a>
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
                    <div style="display: none; "  class="complaints<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb center">
                            <li>
                                <a style="text-align: center;"> <b> Chief Complaints </b></a>
                            </li>
                        </ul>
                        <div class="pull-left thumbnail" style="width: 100%; line-height: 18px; padding-left: 10px; ">

                            <form class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> CURRENT CONDITION: </a><br/> WHAT BRINGS THE PATIENT TO THE CONSULTING ROOM? </lead></label>
                                    <div class="controls">

                                        <div>
                                            <em>Into This</em>
                                            <select data-placeholder="Choose a Country..." class="chosen-select" multiple style="width:350px;" tabindex="4">
                                                <option value=""></option>
                                                <option value="United States">United States</option>
                                                <option value="United Kingdom">United Kingdom</option>
                                                <option value="Afghanistan">Afghanistan</option>
                                                <option value="Aland Islands">Aland Islands</option>
                                                <option value="Albania">Albania</option>
                                                <option value="Algeria">Algeria</option>
                                                <option value="American Samoa">American Samoa</option>
                                                <option value="Andorra">Andorra</option>
                                                <option value="Angola">Angola</option>
                                                <option value="Anguilla">Anguilla</option>
                                                <option value="Antarctica">Antarctica</option>
                                                <option value="Antigua and Barbuda">Antigua and Barbuda</option>
                                                <option value="Argentina">Argentina</option>
                                                <option value="Armenia">Armenia</option>
                                                <option value="Aruba">Aruba</option>
                                                <option value="Australia">Australia</option>
                                                <option value="Austria">Austria</option>
                                                <option value="Azerbaijan">Azerbaijan</option>
                                                <option value="Bahamas">Bahamas</option>
                                                <option value="Bahrain">Bahrain</option>
                                                <option value="Bangladesh">Bangladesh</option>
                                                <option value="Barbados">Barbados</option>
                                                <option value="Belarus">Belarus</option>
                                                <option value="Belgium">Belgium</option>
                                                <option value="Belize">Belize</option>
                                                <option value="Benin">Benin</option>
                                                <option value="Bermuda">Bermuda</option>
                                                <option value="Bhutan">Bhutan</option>
                                                <option value="Bolivia, Plurinational State of">Bolivia, Plurinational State of</option>
                                                <option value="Bonaire, Sint Eustatius and Saba">Bonaire, Sint Eustatius and Saba</option>
                                                <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                                                <option value="Botswana">Botswana</option>
                                                <option value="Bouvet Island">Bouvet Island</option>
                                                <option value="Brazil">Brazil</option>
                                                <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
                                                <option value="Brunei Darussalam">Brunei Darussalam</option>
                                                <option value="Bulgaria">Bulgaria</option>
                                                <option value="Burkina Faso">Burkina Faso</option>
                                                <option value="Burundi">Burundi</option>
                                                <option value="Cambodia">Cambodia</option>
                                                <option value="Cameroon">Cameroon</option>
                                                <option value="Canada">Canada</option>
                                                <option value="Cape Verde">Cape Verde</option>
                                                <option value="Cayman Islands">Cayman Islands</option>
                                                <option value="Central African Republic">Central African Republic</option>
                                                <option value="Chad">Chad</option>
                                                <option value="Chile">Chile</option>
                                                <option value="China">China</option>
                                                <option value="Christmas Island">Christmas Island</option>
                                                <option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
                                                <option value="Colombia">Colombia</option>
                                                <option value="Comoros">Comoros</option>
                                                <option value="Congo">Congo</option>
                                                <option value="Congo, The Democratic Republic of The">Congo, The Democratic Republic of The</option>
                                                <option value="Cook Islands">Cook Islands</option>
                                                <option value="Costa Rica">Costa Rica</option>
                                                <option value="Cote D'ivoire">Cote D'ivoire</option>
                                                <option value="Croatia">Croatia</option>
                                                <option value="Cuba">Cuba</option>
                                                <option value="Curacao">Curacao</option>
                                                <option value="Cyprus">Cyprus</option>
                                                <option value="Czech Republic">Czech Republic</option>
                                                <option value="Denmark">Denmark</option>
                                                <option value="Djibouti">Djibouti</option>
                                                <option value="Dominica">Dominica</option>
                                                <option value="Dominican Republic">Dominican Republic</option>
                                                <option value="Ecuador">Ecuador</option>
                                                <option value="Egypt">Egypt</option>
                                                <option value="El Salvador">El Salvador</option>
                                                <option value="Equatorial Guinea">Equatorial Guinea</option>
                                                <option value="Eritrea">Eritrea</option>
                                                <option value="Estonia">Estonia</option>
                                                <option value="Ethiopia">Ethiopia</option>
                                                <option value="Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
                                                <option value="Faroe Islands">Faroe Islands</option>
                                                <option value="Fiji">Fiji</option>
                                                <option value="Finland">Finland</option>
                                                <option value="France">France</option>
                                                <option value="French Guiana">French Guiana</option>
                                                <option value="French Polynesia">French Polynesia</option>
                                                <option value="French Southern Territories">French Southern Territories</option>
                                                <option value="Gabon">Gabon</option>
                                                <option value="Gambia">Gambia</option>
                                                <option value="Georgia">Georgia</option>
                                                <option value="Germany">Germany</option>
                                                <option value="Ghana">Ghana</option>
                                                <option value="Gibraltar">Gibraltar</option>
                                                <option value="Greece">Greece</option>
                                                <option value="Greenland">Greenland</option>
                                                <option value="Grenada">Grenada</option>
                                                <option value="Guadeloupe">Guadeloupe</option>
                                                <option value="Guam">Guam</option>
                                                <option value="Guatemala">Guatemala</option>
                                                <option value="Guernsey">Guernsey</option>
                                                <option value="Guinea">Guinea</option>
                                                <option value="Guinea-bissau">Guinea-bissau</option>
                                                <option value="Guyana">Guyana</option>
                                                <option value="Haiti">Haiti</option>
                                                <option value="Heard Island and Mcdonald Islands">Heard Island and Mcdonald Islands</option>
                                                <option value="Holy See (Vatican City State)">Holy See (Vatican City State)</option>
                                                <option value="Honduras">Honduras</option>
                                                <option value="Hong Kong">Hong Kong</option>
                                                <option value="Hungary">Hungary</option>
                                                <option value="Iceland">Iceland</option>
                                                <option value="India">India</option>
                                                <option value="Indonesia">Indonesia</option>
                                                <option value="Iran, Islamic Republic of">Iran, Islamic Republic of</option>
                                                <option value="Iraq">Iraq</option>
                                                <option value="Ireland">Ireland</option>
                                                <option value="Isle of Man">Isle of Man</option>
                                                <option value="Israel">Israel</option>
                                                <option value="Italy">Italy</option>
                                                <option value="Jamaica">Jamaica</option>
                                                <option value="Japan">Japan</option>
                                                <option value="Jersey">Jersey</option>
                                                <option value="Jordan">Jordan</option>
                                                <option value="Kazakhstan">Kazakhstan</option>
                                                <option value="Kenya">Kenya</option>
                                                <option value="Kiribati">Kiribati</option>
                                                <option value="Korea, Democratic People's Republic of">Korea, Democratic People's Republic of</option>
                                                <option value="Korea, Republic of">Korea, Republic of</option>
                                                <option value="Kuwait">Kuwait</option>
                                                <option value="Kyrgyzstan">Kyrgyzstan</option>
                                                <option value="Lao People's Democratic Republic">Lao People's Democratic Republic</option>
                                                <option value="Latvia">Latvia</option>
                                                <option value="Lebanon">Lebanon</option>
                                                <option value="Lesotho">Lesotho</option>
                                                <option value="Liberia">Liberia</option>
                                                <option value="Libya">Libya</option>
                                                <option value="Liechtenstein">Liechtenstein</option>
                                                <option value="Lithuania">Lithuania</option>
                                                <option value="Luxembourg">Luxembourg</option>
                                                <option value="Macao">Macao</option>
                                                <option value="Macedonia, The Former Yugoslav Republic of">Macedonia, The Former Yugoslav Republic of</option>
                                                <option value="Madagascar">Madagascar</option>
                                                <option value="Malawi">Malawi</option>
                                                <option value="Malaysia">Malaysia</option>
                                                <option value="Maldives">Maldives</option>
                                                <option value="Mali">Mali</option>
                                                <option value="Malta">Malta</option>
                                                <option value="Marshall Islands">Marshall Islands</option>
                                                <option value="Martinique">Martinique</option>
                                                <option value="Mauritania">Mauritania</option>
                                                <option value="Mauritius">Mauritius</option>
                                                <option value="Mayotte">Mayotte</option>
                                                <option value="Mexico">Mexico</option>
                                                <option value="Micronesia, Federated States of">Micronesia, Federated States of</option>
                                                <option value="Moldova, Republic of">Moldova, Republic of</option>
                                                <option value="Monaco">Monaco</option>
                                                <option value="Mongolia">Mongolia</option>
                                                <option value="Montenegro">Montenegro</option>
                                                <option value="Montserrat">Montserrat</option>
                                                <option value="Morocco">Morocco</option>
                                                <option value="Mozambique">Mozambique</option>
                                                <option value="Myanmar">Myanmar</option>
                                                <option value="Namibia">Namibia</option>
                                                <option value="Nauru">Nauru</option>
                                                <option value="Nepal">Nepal</option>
                                                <option value="Netherlands">Netherlands</option>
                                                <option value="New Caledonia">New Caledonia</option>
                                                <option value="New Zealand">New Zealand</option>
                                                <option value="Nicaragua">Nicaragua</option>
                                                <option value="Niger">Niger</option>
                                                <option value="Nigeria">Nigeria</option>
                                                <option value="Niue">Niue</option>
                                                <option value="Norfolk Island">Norfolk Island</option>
                                                <option value="Northern Mariana Islands">Northern Mariana Islands</option>
                                                <option value="Norway">Norway</option>
                                                <option value="Oman">Oman</option>
                                                <option value="Pakistan">Pakistan</option>
                                                <option value="Palau">Palau</option>
                                                <option value="Palestinian Territory, Occupied">Palestinian Territory, Occupied</option>
                                                <option value="Panama">Panama</option>
                                                <option value="Papua New Guinea">Papua New Guinea</option>
                                                <option value="Paraguay">Paraguay</option>
                                                <option value="Peru">Peru</option>
                                                <option value="Philippines">Philippines</option>
                                                <option value="Pitcairn">Pitcairn</option>
                                                <option value="Poland">Poland</option>
                                                <option value="Portugal">Portugal</option>
                                                <option value="Puerto Rico">Puerto Rico</option>
                                                <option value="Qatar">Qatar</option>
                                                <option value="Reunion">Reunion</option>
                                                <option value="Romania">Romania</option>
                                                <option value="Russian Federation">Russian Federation</option>
                                                <option value="Rwanda">Rwanda</option>
                                                <option value="Saint Barthelemy">Saint Barthelemy</option>
                                                <option value="Saint Helena, Ascension and Tristan da Cunha">Saint Helena, Ascension and Tristan da Cunha</option>
                                                <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                                                <option value="Saint Lucia">Saint Lucia</option>
                                                <option value="Saint Martin (French part)">Saint Martin (French part)</option>
                                                <option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
                                                <option value="Saint Vincent and The Grenadines">Saint Vincent and The Grenadines</option>
                                                <option value="Samoa">Samoa</option>
                                                <option value="San Marino">San Marino</option>
                                                <option value="Sao Tome and Principe">Sao Tome and Principe</option>
                                                <option value="Saudi Arabia">Saudi Arabia</option>
                                                <option value="Senegal">Senegal</option>
                                                <option value="Serbia">Serbia</option>
                                                <option value="Seychelles">Seychelles</option>
                                                <option value="Sierra Leone">Sierra Leone</option>
                                                <option value="Singapore">Singapore</option>
                                                <option value="Sint Maarten (Dutch part)">Sint Maarten (Dutch part)</option>
                                                <option value="Slovakia">Slovakia</option>
                                                <option value="Slovenia">Slovenia</option>
                                                <option value="Solomon Islands">Solomon Islands</option>
                                                <option value="Somalia">Somalia</option>
                                                <option value="South Africa">South Africa</option>
                                                <option value="South Georgia and The South Sandwich Islands">South Georgia and The South Sandwich Islands</option>
                                                <option value="South Sudan">South Sudan</option>
                                                <option value="Spain">Spain</option>
                                                <option value="Sri Lanka">Sri Lanka</option>
                                                <option value="Sudan">Sudan</option>
                                                <option value="Suriname">Suriname</option>
                                                <option value="Svalbard and Jan Mayen">Svalbard and Jan Mayen</option>
                                                <option value="Swaziland">Swaziland</option>
                                                <option value="Sweden">Sweden</option>
                                                <option value="Switzerland">Switzerland</option>
                                                <option value="Syrian Arab Republic">Syrian Arab Republic</option>
                                                <option value="Taiwan, Province of China">Taiwan, Province of China</option>
                                                <option value="Tajikistan">Tajikistan</option>
                                                <option value="Tanzania, United Republic of">Tanzania, United Republic of</option>
                                                <option value="Thailand">Thailand</option>
                                                <option value="Timor-leste">Timor-leste</option>
                                                <option value="Togo">Togo</option>
                                                <option value="Tokelau">Tokelau</option>
                                                <option value="Tonga">Tonga</option>
                                                <option value="Trinidad and Tobago">Trinidad and Tobago</option>
                                                <option value="Tunisia">Tunisia</option>
                                                <option value="Turkey">Turkey</option>
                                                <option value="Turkmenistan">Turkmenistan</option>
                                                <option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
                                                <option value="Tuvalu">Tuvalu</option>
                                                <option value="Uganda">Uganda</option>
                                                <option value="Ukraine">Ukraine</option>
                                                <option value="United Arab Emirates">United Arab Emirates</option>
                                                <option value="United Kingdom">United Kingdom</option>
                                                <option value="United States">United States</option>
                                                <option value="United States Minor Outlying Islands">United States Minor Outlying Islands</option>
                                                <option value="Uruguay">Uruguay</option>
                                                <option value="Uzbekistan">Uzbekistan</option>
                                                <option value="Vanuatu">Vanuatu</option>
                                                <option value="Venezuela, Bolivarian Republic of">Venezuela, Bolivarian Republic of</option>
                                                <option value="Viet Nam">Viet Nam</option>
                                                <option value="Virgin Islands, British">Virgin Islands, British</option>
                                                <option value="Virgin Islands, U.S.">Virgin Islands, U.S.</option>
                                                <option value="Wallis and Futuna">Wallis and Futuna</option>
                                                <option value="Western Sahara">Western Sahara</option>
                                                <option value="Yemen">Yemen</option>
                                                <option value="Zambia">Zambia</option>
                                                <option value="Zimbabwe">Zimbabwe</option>
                                            </select>
                                        </div>




                                        <select type="text" style="width:75%;"  placeholder="CONDITION">
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
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="condition_notes" class="hide " type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>

                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> ONSET: </a><br/> WHEN DID PATIENT FIRST NOTICE CONDITION? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="ONSET">
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
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea class="hide" id="onset_notes" type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> LOCATION: </a><br/> WHERE DOES PATIENT EXPERIENCE DISCOMFORT? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="LOCATION">
                                            <option value="">LOCATION</option>
                                            <% List location = mgr.listBodyPartsOptions();

                                                for (int x = 0; x < location.size(); x++) {
                                                    BodyPartOptions bodyPartOption = (BodyPartOptions) location.get(x);
                                            %>

                                            <option value="<%=bodyPartOption.getBodyPartId()%>"><%=bodyPartOption.getBodyPart()%></option>

                                            <% }%>
                                        </select>
                                        <span class="help-inline "><button type="button" id="bodypart_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="bodypart_notes" class="hide"type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> DURATION: </a><br/> HOW LONG DOES DISCOMFORT LAST? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="DURATION">
                                            <option value="">DURATION</option>
                                            <% List durations = mgr.listDurationOptions();

                                                for (int x = 0; x < durations.size(); x++) {
                                                    DurationOptions durationOption = (DurationOptions) durations.get(x);
                                            %>

                                            <option value="<%=durationOption.getDurationId()%>"><%=durationOption.getDuration()%></option>

                                            <% }%>
                                        </select> <span class="help-inline "><button type="button" id="duration_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="duration_notes" class="hide" type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> CHARACTERISTIC: </a><br/> DESCRIPTION OF DISCOMFORT? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="CHARACTERISTIC">
                                            <option value="">CHARACTERISTIC</option>
                                            <% List characteristics = mgr.listCharacteristicsOptions();

                                                for (int x = 0; x < durations.size(); x++) {
                                                    CharacteristicOptions characteristicOption = (CharacteristicOptions) characteristics.get(x);
                                            %>

                                            <option value="<%=characteristicOption.getCharacteristicId()%>"><%=characteristicOption.getCharacteristic()%></option>

                                            <% }%>
                                        </select> 
                                        <span class="help-inline "><button type="button" id="characteristic_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>

                                    </div>
                                </div>
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="characteristic_notes" class="hide" type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> AGGRAVATION: </a><br/> WHAT MAKES THE CONDITION WORSE? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="AGGRAVATION">
                                            <option value="">AGGRAVATION</option>
                                            <% List aggravations = mgr.listAggrevationOptions();

                                                for (int x = 0; x < aggravations.size(); x++) {
                                                    AggrevationOptions aggravationOption = (AggrevationOptions) aggravations.get(x);
                                            %>

                                            <option value="<%=aggravationOption.getAggrevationId()%>"><%=aggravationOption.getAggrevation()%></option>

                                            <% }%>
                                        </select> 


                                        <span class="help-inline "><button type="button" id="aggravation_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="aggravation_notes" class="hide" type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> RELIEF: </a><br/> WHAT MAKES THE CONDITION BETTER? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="RELIEF">
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
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="relief_notes" class="hide" type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> TREATMENT: </a><br/> PRIOR TREATMENT(S) FOR THIS CONDITION? </lead></label>
                                    <div class="controls">
                                        <select type="text" style="width:75%;"  placeholder="TREATMENT">
                                            <option value="">RELIEF</option>
                                            <% List treatmentOptions = mgr.listTreatmentOptions();

                                                for (int x = 0; x < treatmentOptions.size(); x++) {
                                                    TreatmentOptions treatmentOption = (TreatmentOptions) treatmentOptions.get(x);
                                            %>

                                            <option value="<%=treatmentOption.getTreatmentId()%>"><%=treatmentOption.getTreatment()%></option>

                                            <% }%>
                                        </select> 
                                        <span class="help-inline "><button type="button" id="treatment_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <div class="controls">
                                        <textarea id="treatment_notes" class="hide" type="text" style="width:75%;"></textarea>
                                    </div>

                                </div>

                            </form>
                        </div>

                    </div>
                    <div style="display: none;"  class="thumbnail center medical_history<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a style="text-align: center;"> <b>Medical History </b></a>
                            </li>
                        </ul>
                        <div class="tabs">
                            <ul>
                                <li><a href="#tabs-1">Allergies / Drug History</a></li>
                                <li><a href="#tabs-3">Symptoms</a></li>
                                <li><a href="#tabs-2">Presenting Complaints</a></li>

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

                                <!--  </tbody>
                                  </table>  -->
                            </div>
                            <div id="tabs-2">
                                <textarea style="width: 95%; height: 100px" placeholder="Fill in Patient's Complaints" name="complaints"></textarea>
                            </div>
                            <div id="tabs-3">
                                <table class="table  right table table-bordered">
                                    <thead>
                                        <tr>
                                            <th><b style="color: #fff;">Symptoms</b></th> 
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List visitSymptoms = mgr.listVisistSymptomsByVisitid(vs.getVisitid());
                                            VisitSymptoms symptoms = null;
                                            if (visitSymptoms != null && visitSymptoms.size() > 0) {
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
                                    </tbody>
                                </table>
                                <table>
                                    <% if (visitSymptoms != null) {%>   
                                    <thead>
                                    <th><b style="color: #fff;">Remarks </b></th>
                                    </thead>
                                    <% }%>

                                    <tbody>
                                        <tr>    
                                            <td>
                                                <% if (visitSymptoms != null && visitSymptoms.size() > 0) {
                                                        symptoms = (VisitSymptoms) visitSymptoms.get(0);
                                                        if (symptoms != null) {%>
                                                <%= symptoms.getNote()%>
                                                <%}
                                                    }%>
                                            </td>
                                        <tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div style="display: none;"  class="thumbnail center family_history<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a style="text-align: center;"> <b> Family History </b></a>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none;"  class="thumbnail center social_history<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a style="text-align: center;"> <b> Social History </b></a>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none;" class="thumbnail center system_review<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a style="text-align: center;"><b> Systemic Review </b></a>
                            </li>
                        </ul>



                    </div>
                    <div style="display: none; font-size: 12px;" class="thumbnail center laboratory<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a href="#"><b> Laboratory</b></a>
                            </li>
                        </ul>
                        <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Investigations</a></li>
                                <li><a href="#tabs-2">Results</a></li>
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
                                                    tabNum = y + 1;
                                        %>
                                        <li><a style="text-transform: capitalize; font-size: 11px;" href="#tabs-<%=tabNum%>"><%=labType.getLabType()%></a></li>
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
                                            <% %>
                                            <table>
                                                <tr>
                                                    <td>

                                                        <%

                                                            investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                            if (investigations != null) {
                                                        %>
                                                        <% for (int p = 0; p < investigations.size(); p++) {
                                                                Investigation investigation = (Investigation) investigations.get(p);
                                                                if (investigation != null) {%>
                                                        <div style="float: left"  class="radioset">
                                                            <input class="selected_result<%= visit.getPatientid()%>"  style="margin-top: 10px; width: 200px;"  type="checkbox" name="labtest" id="test<%= investigation.getDetailedInvId()%>" labid="<%=investigation.getCode()%>" labtestname="<%=investigation.getName()%>" labtestpricevalue="<%=df.format(investigation.getRate())%>" labtestprice="GH&#162;<%=df.format(investigation.getRate())%>"  value="<%=investigation.getRate()%>><<%= investigation.getDetailedInvId()%>"/>
                                                            <label style="width: max-content; font-size: 12px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; " for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%> </label>
                                                        </div> 
                                                        <% }
                                                            }%>


                                                        <% }%>

                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <% }
                                        }%>
                                </div>
                                <div class="clearfix"></div>
                                <div>
                                    <table  class="table">
                                        <thead>
                                            <tr>
                                                <th style="color: #FFF; text-align: left; font-size: 13px;">
                                                    Selected Investigation
                                                </th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div style=" text-align: center; max-height:  150px; overflow-y: scroll; padding: 10px 20px; border: 1px solid #CCC;">

                                    <table class="table table-condensed" id="selected_tests<%=visit.getPatientid()%>">

                                        <tbody>

                                        </tbody>

                                    </table> 
                                </div>
                                <div style="padding-bottom: 20px;" class="clearfix">
                                </div>
                            </div>
                            <div id="tabs-2">
                                <div id="results">
                                    <table cellpadding="0" cellspacing="0" border="0" class="table">

                                        <thead>
                                            <tr>
                                                <th>
                                                    <label style="color: white; "> Ordered By</label>
                                                </th>
                                                <th>
                                                    <label style="color: white; "> Ordered Date </label>
                                                </th>
                                                <th>
                                                    <label style="color: white; " >Completed On </label>
                                                </th>
                                                <th>
                                                    <label style="color: white; "> </label>
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

                                            </td>

                                            <td style="text-align: center">
                                                <button  value="view" class="btn btn-info btn-small" onclick="updateLaborders();return false;">
                                                    View Lab Report
                                                </button>
                                            </td>
                                        </tr>
                                        <%         }
                                                }
                                            }%>
                                        </tbody>

                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div style="display: none;" class=" thumbnail center diagnosis<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                            <li>
                                <a style="text-align: center;"><b> Diagnosis </b></a>
                            </li>
                        </ul>

                        <table class="table"> 

                            <tr>
                                <td>
                                    <%if (mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {%>
                                    <label class="control-label pull-left" style="line-height: 25px; padding-right: 15px;"  for="input01"> Select Diagnoses  </label>  <select class="input-xxlarge select" id="diagnosis<%=visit.getVisitid()%>" onchange =''>

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

                                    <label class="control-label pull-left" style="line-height: 25px; padding-right: 15px;"  for="input01"> Select Diagnoses  </label>  
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
                                        <i class="icon-white icon-plus-sign"> </i>   Add
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
                                                        // String replacedString = "";
                                                        // String[] treatmentString = null;
                                                        if (treatments != null) {
                                                            for (int v = 0; v < treatments.size(); v++) {
                                                                Treatment treatment = (Treatment) treatments.get(v);
                                                                /* treatmentString = treatment.getTreatment().split(",");
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
                                                                 */
                                                    %>
                                                    <option value="<%=treatment.getTreatment()%>><<%=treatment.getBatchNumber()%>"focus ><%=treatment.getTreatment()%></option> 
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
                                                        100mg
                                                    </option>
                                                    <option value="200MG">
                                                        300mg
                                                    </option>
                                                    <option value="300MG">
                                                        300mg
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
                                                    <option value="11">
                                                        11
                                                    </option>
                                                    <option value="12">
                                                        12
                                                    </option>
                                                    <option value="13">
                                                        13
                                                    </option>
                                                    <option value="14">
                                                        14
                                                    </option>
                                                    <option value="15">
                                                        15
                                                    </option>
                                                    <option value="16">
                                                        16
                                                    </option>
                                                    <option value="17">
                                                        17
                                                    </option>
                                                    <option value="18">
                                                        18
                                                    </option>
                                                    <option value="19">
                                                        19
                                                    </option>
                                                    <option value="20">
                                                        20
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
                                                <button id="addCheckBoxes" class="btn btn-info " onclick='verifyavailability("treatment<%=visit.getVisitid()%>","drugtype<%=visit.getVisitid()%>","qty<%=visit.getVisitid()%>","dosage<%=visit.getVisitid()%>","duration<%=visit.getVisitid()%>","strength<%=visit.getVisitid()%>","append_<%=visit.getVisitid()%>","treatment<%=visit.getVisitid()%>","drugtype<%=visit.getVisitid()%>","qty<%=visit.getVisitid()%>","dosage<%=visit.getVisitid()%>","duration<%=visit.getVisitid()%>","strength<%=visit.getVisitid()%>","append_<%=visit.getVisitid()%>"); addPrintCheckboxes("treatment<%=visit.getVisitid()%>","drugtype<%=visit.getVisitid()%>","qty<%=visit.getVisitid()%>","dosage<%=visit.getVisitid()%>","duration<%=visit.getVisitid()%>","strength<%=visit.getVisitid()%>","append_prescription<%=visit.getVisitid()%>");return false;'>
                                                    <i class="icon-white icon-plus-sign"> </i>   Add Treatment
                                                </button>
                                            </td>
                                        </tr>


                                    </tbody>
                                </table>

                                <table class="table" id="append_<%=visit.getVisitid()%>">
                                    <thead>
                                        <tr style="padding: 12px 0px 12px 0px;">
                                            <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                                Selected Prescription
                                            </th>
                                        </tr>
                                    </thead>

                                </table>
                                <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="prescription<%=visit.getVisitid()%>" style="display: none">
                                    <section class="hide" id="dashboard">

                                        <!-- Headings & Paragraph Copy -->
                                        <div class="container">

                                            <div style="margin-bottom: -15px;" class="row">
                                                <div class="span3" style="float: left;">
                                                    <img src="images/danpongclinic.png" width="100px;" style="margin-top: 30px;" />
                                                </div>

                                                <img src="images/danpongaddress.png" width="100px;" style="float: right; margin-top: 20px;" /> 


                                            </div>
                                        </div>

                                        <div style="clear: both;"></div>

                                        <hr style="border: solid #000000 0.5px ;"  />

                                        <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                            <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> 

                                                PRESCRIPTION FORM</h3>

                                        </div>
                                        <hr class="row" style="border-top: 2px solid #000;;margin-top: 0px;" >


                                        <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">
                                            <table style="width: 300px; float: left; margin-left: 6px; font-size:  12px;">
                                                <tr>
                                                    <td style="line-height: 25px;">
                                                        Name:
                                                    </td>
                                                    <td style="line-height: 25px;">
                                                        <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>
                                                        <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%>
                                                        <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="line-height: 25px;">
                                                        Date
                                                    </td>
                                                    <td style="line-height: 25px;">
                                                        <%= formatter.format(visit.getDate())%>
                                                    </td>
                                                </tr>



                                                <tr>
                                                    <td style="line-height: 25px;">
                                                        Card No.
                                                    </td>
                                                    <td style="line-height: 25px; text-transform: uppercase">
                                                        <%= visit.getPatientid()%>
                                                    </td>
                                                </tr>


                                            </table>



                                            <div style="clear: both;"></div>

                                            <hr class="row" style="border-top: 2px solid  #000;
                                                margin-top: 5px;" >

                                            <table   style="width: 100%; font-size: 12px; " cellspacing="0" class="table" id="append_prescription<%=visit.getVisitid()%>">
                                                <thead>
                                                    <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                        <th style="font-weight: bolder; border: solid 1px black ; border-spacing: 0px; text-align: center; padding-bottom:  7px; padding-top: 5px;  padding-left: 15px; ">Prescribed Medications </th>



                                                    </tr>
                                                </thead>
                                                <tbody style="padding-left: 20px;">
                                                    <tr>
                                                <div style="text-align: left;" class="row center">
                                                    <img style="float: left;" src="images/Rx_symbol.svg" width="30px;">   
                                                    <!-- <h3 style="font-weight:400; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing: ">PRESCRIPTION FORM</h3>  -->

                                                </div>
                                                </tr>

                                                </tbody>

                                            </table>
                                        </div>
                                        <div style="clear: both"></div>

                                        <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <span style="letter-spacing: 5px;" >************</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Prescription</span> <span style="letter-spacing: 5px;" >************</span>

                                            Prescribed & Electronically Signed by: <br /><%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                            Wishing You Speedy Recovery <br /> Thank you
                                        </div>
                                    </section>
                                </div>

                                <table>
                                    <tr>
                                        <td class="center">
                                            <button  class="btn btn-primary " onclick='printSelectionSmall(document.getElementById("prescription<%=visit.getVisitid()%>")); return false;'>
                                                <i class="icon-white icon-print"> </i>   Print Prescription
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <thead>

                                        <tr>
                                            <th colspan="5" style="text-align: center; color: #fff;">
                                                Prescription Note
                                            </th>
                                        </tr>
                                    </thead>

                                </table>
                                <textarea style="width: 95%; height: 100px"   name="prescription_notes" ></textarea>

                                <!-- <button class="btn btn-info btn-small center" style="text-align: center; margin-top: 10px;" type="button">
                                     <i class="icon icon-print icon-white"></i> Print Prescription
                                 </button>  -->

                            </div>
                            <div id="tabs-2">
                                <label class="control-label pull-left" style="line-height: 25px;"  for="input01"> Select Procedure : </label>
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



                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="text-align: left; color: #FFF;" > Date of Visit</th>
                                    <th>  </th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int r = 0; r < patientHistory.size(); r++) {
                                        Visitationtable vps = (Visitationtable) patientHistory.get(r);

                                        List pdiagnosis = mgr.patientDiagnosis(vps.getVisitid());
                                        List pInvestigation = mgr.patientInvestigation(vps.getVisitid());
                                        List pTreatment = mgr.patientTreatment(vps.getVisitid());
                                        String today = formatter.format(date);
                                        String thatdate = formatter.format(vps.getDate());
                                        if (!thatdate.equalsIgnoreCase(today)) {
                                %>
                                <tr>
                                    <td>
                                        <b style="color: #4183C4"><%=datetimeformat.format(vps.getDate())%> </b>
                                    </td>
                                    <td style="text-align: center;">
                                        <button id="visit_history<%=vps.getVisitid()%>link" type="button" class="btn btn-small btn-info ">
                                            <i class="icon-white icon-eye-open"></i> View Visit Summary
                                        </button>
                                        <div title="Visit Summary | <%=datetimeformat.format(vps.getDate())%> | <%= mgr.getPatientByID(vps.getPatientid()).getFname()%> <%= mgr.getPatientByID(vps.getPatientid()).getLname()%>" id="visit_history<%=vps.getVisitid()%>" style="max-height: 600px; overflow-y: scroll; overflow-x: hidden;  display: none;" class="thumbnail center ">
                                            <ul style="margin-left: 0px;" class="breadcrumb">
                                                <li style="text-align: left;">
                                                    <b> <a> Visit Summary</a> </b>
                                                </li>
                                                <li class="pull-right">
                                                    <button type="button" class="btn btn-mini btn-info pull-right" onclick='printSelection(document.getElementById("visit_history_print<%=vps.getVisitid()%>")); return false'>
                                                        <i class="icon-print icon-white"></i> Print
                                                    </button>
                                                </li>
                                            </ul>
                                            <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="visit_history_print<%=vps.getVisitid()%>">            
                                                <div class="row" style="padding-left: 0px; margin-left: 0px;">
                                                    <div  style="float: left;">
                                                        <img src="images/danpongclinic.png" width="250px;" style="margin-top: 30px;" />
                                                    </div>

                                                    <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" /> 

                                                </div>

                                                <div style="clear: both;"></div>

                                                <hr style="border: solid #000000 0.5px ;"  />

                                                <div style="text-align: center;  margin-top: 0px;" class="row center ">


                                                    <h2 style="letter-spacing: 2px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;"> <u> VISIT SUMMARY </u> </h2>
                                                    <h3 style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 0px; font-size: 12px;"> 
                                                        <%=datetimeformat.format(vps.getDate())%>
                                                    </h3>

                                                </div>
                                                <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px; width: 100%">
                                                    <tr>
                                                        <td style="width: 20px;">
                                                            <b>RE: </b>
                                                        </td>
                                                        <td style="width:80%">
                                                            <%= mgr.getPatientByID(vps.getPatientid()).getFname()%>  <%= mgr.getPatientByID(vps.getPatientid()).getMidname()%> <%= mgr.getPatientByID(vps.getPatientid()).getLname()%>
                                                        </td>

                                                        <% String yr = mgr.getPatientByID(vps.getPatientid()).getDateofbirth() + "";

                                                            String tt = yr.split("-")[0];
                                                            //String tyr = new Date()+"";
                                                            SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                                            String tyr = dateFormat1.format(new Date()) + "";
                                                            String t = tyr.split("-")[0];%>
                                                        <td style="float: right; padding-left: 20px;">
                                                            <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years 
                                                        </td>
                                                        <td style="width: 20px; float: right">
                                                            <b> Age: </b>
                                                        </td>

                                                    </tr>
                                                </table>
                                                <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                                    <tr>
                                                        <td colspan="4">
                                                            <br />
                                                            <b> <u> BRIEF MEDICAL HISTORY </u> </b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <b> Patient has the following allergies :  </b>
                                                            <% List allergies1 = mgr.listAllergiessByPatientid(vps.getPatientid());
                                                                if (allergies1 != null) {
                                                                    for (int dex = 0; dex < allergies1.size(); dex++) {
                                                                        PatientAllergies allergy1 = (PatientAllergies) allergies1.get(dex);
                                                                        if (allergy1 != null) {
                                                            %>

                                                            <%=mgr.getAllergyByid(allergy1.getAllergyid()).getName()%> <%}
                                                                    }
                                                                }%> 
                                                            <br /> <br />
                                                            <b> Complained of the following : </b> 
                                                            <%= mgr.getVisitById(vps.getVisitid()).getNotes()%>
                                                            <br /> <br />
                                                            <b> Displayed the following symptoms :  </b> 


                                                            <% List visitSymptoms2 = mgr.listVisistSymptomsByVisitid(vps.getVisitid());
                                                                VisitSymptoms symptoms2 = null;
                                                                if (visitSymptoms2 != null) {
                                                                    for (int ind = 0; ind < visitSymptoms2.size(); ind++) {
                                                                        symptoms2 = (VisitSymptoms) visitSymptoms2.get(ind);
                                                                        if (symptoms2 != null) {
                                                            %>

                                                            <%=mgr.getSymptomById(symptoms2.getSymptomid()).getSymptomname()%>,

                                                            <%}
                                                                    }
                                                                }%>
                                                            <br /> <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <br />
                                                            <b> <u>RELEVANT CLINICAL FINDINGS </u> </b>
                                                        </td>
                                                    </tr>

                                                </table>

                                                <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                                    <tr>
                                                        <td colspan="4">
                                                            <br />
                                                            <b> Possible diagnosis </b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <div >
                                                                <ol>
                                                                    <%  List visit_diagnosis = mgr.listPatientDiagnosisForVisit(vps.getPatientid(), vps.getVisitid());
                                                                        Patientdiagnosis diagnosis = null;
                                                                        if (visit_diagnosis != null) {
                                                                            for (int k = 0; k < visit_diagnosis.size(); k++) {
                                                                                diagnosis = (Patientdiagnosis) visit_diagnosis.get(k);
                                                                    %>
                                                                    <li><%= mgr.sponsorshipDetails(vps.getPatientid()).getType().equalsIgnoreCase("NHIS") ? mgr.getDiagnosis(diagnosis.getDiagnosisid()).getDiagnosis() : mgr.getDiagnosis(diagnosis.getDiagnosisid()).getDiagnosis()%> </li> 
                                                                    <%
                                                                            }
                                                                        }

                                                                    %>
                                                                </ol>



                                                        </td>
                                                    </tr>

                                                </table>
                                                <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                                    <tr>
                                                        <td colspan="4">
                                                            <br />
                                                            <b>Treatment given </b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <ol style="width: 95%; color: black;"><% for (int s = 0; s < pTreatment.size(); s++) {
                                                                    Patienttreatment pt = (Patienttreatment) pTreatment.get(s);
                                                                    if (pt != null) {
                                                                %>
                                                                <li> <%= mgr.getTreatment(pt.getTreatmentid()).getTreatment() + "\n"%> </li>
                                                                <% }
                                                                    }%>
                                                            </ol>
                                                        </td>
                                                    </tr>

                                                </table>
                                                <div style="clear: both;">
                                                </div>

                                                <div style="clear: both"></div>
                                            </div>
                                            <div style="text-align: center; width: 100%">
                                                <button style="text-align: center" type="button" class="btn btn-mini btn-info pull-right" onclick='printSelection(document.getElementById("visit_history_print<%=vps.getVisitid()%>")); return false'>
                                                    <i class="icon-print icon-white"></i> Print
                                                </button>
                                            </div>
                                        </div>


                                    </td>
                                </tr>

                                <% }
                                    }%>
                            </tbody>
                        </table>

                    </div>
                    <div style="display: none;" class="thumbnail center summary<%=visit.getPatientid()%> printSummary<%=visit.getPatientid()%>">
                        <ul style="margin-left: 0px;" class="breadcrumb">
                            <li style="text-align: left;">
                                <b> <a> Current Visit Summary</a> </b>
                            </li>
                            <li class="pull-right">
                                <button class="btn btn-mini btn-info pull-right" onclick='printSelection(document.getElementById("current_visit_history_print<%=visit.getVisitid()%>")); return false'>
                                    <i class="icon-print icon-white"></i> Print
                                </button>
                            </li>
                        </ul>

                        <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="current_visit_history_print<%=visit.getVisitid()%>">            
                            <div class="row" style="padding-left: 0px; margin-left: 0px;">
                                <div  style="float: left;">
                                    <img src="images/danpongclinic.png" width="250px;" style="margin-top: 30px;" />
                                </div>

                                <img src="images/danpongaddress.png" width="180px;" style="float: right; margin-top: 20px;" /> 

                            </div>

                            <div style="clear: both;"></div>

                            <hr style="border: solid #000000 0.5px ;"  />

                            <div style="text-align: center;  margin-top: 0px;" class="row center ">


                                <h2 style="letter-spacing: 2px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;"> <u> CURRENT VISIT SUMMARY </u> </h2>
                                <h3 style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 0px; font-size: 12px;"> 
                                    <%=datetimeformat.format(visit.getDate())%>
                                </h3>

                            </div>
                            <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px; width: 100%">
                                <tr>
                                    <td style="width: 20px;">
                                        <b>RE: </b>
                                    </td>
                                    <td style="width:80%">
                                        <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>  <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>
                                    </td>

                                    <% String yr = mgr.getPatientByID(visit.getPatientid()).getDateofbirth() + "";

                                        String tt = yr.split("-")[0];
                                        //String tyr = new Date()+"";
                                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                        String tyr = dateFormat1.format(new Date()) + "";
                                        String t = tyr.split("-")[0];%>
                                    <td style="float: right; padding-left: 20px;">
                                        <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years 
                                    </td>
                                    <td style="width: 20px; float: right">
                                        <b> Age: </b>
                                    </td>

                                </tr>
                            </table>
                            <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                <tr>
                                    <td colspan="4">
                                        <br />
                                        <b> <u> BRIEF MEDICAL HISTORY </u> </b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <b> Patient has the following allergies : 


                                        </b>

                                        <ol>
                                            <% List allergiesSummary = mgr.listAllergiessByPatientid(vs.getPatientid());
                                                if (allergiesSummary != null) {
                                                    for (int dex = 0; dex < allergiesSummary.size(); dex++) {
                                                        PatientAllergies allergy = (PatientAllergies) allergies.get(dex);
                                                        if (allergy != null) {
                                            %>
                                            <li><%=mgr.getAllergyByid(allergy.getAllergyid()).getName()%></li>
                                            <%}
                                                    }
                                                }%>
                                        </ol>
                                        <br /> <br />
                                        <b> Complained of the following : </b>


                                        <br /> <br />
                                        <b> Displayed the following symptoms :  </b> 


                                        <br /> <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <br />
                                        <b> <u>RELEVANT CLINICAL FINDINGS </u> </b>
                                    </td>
                                </tr>

                            </table>

                            <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                <tr>
                                    <td colspan="4">
                                        <br />
                                        <b>Possible results of any investigations done </b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <ol style="width: 95%; color: black;">
                                        </ol>
                                    </td>
                                </tr>

                            </table>
                            <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                <tr>
                                    <td colspan="4">
                                        <br />
                                        <b> Possible diagnosis </b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <ol style="width: 95%; color: black;">

                                        </ol>


                                    </td>
                                </tr>

                            </table>
                            <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                <tr>
                                    <td colspan="4">
                                        <br />
                                        <b>Treatment given </b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <ol style="width: 95%; color: black;">
                                        </ol>
                                    </td>
                                </tr>

                            </table>
                            <div style="clear: both;">
                            </div>

                            <div style="clear: both"></div>
                        </div>


                        <button class="btn btn-small btn-info" type="button" onclick='printSelection(document.getElementById("current_visit_history<%=visit.getVisitid()%>")); return false'>
                            <i class="icon-print icon-white"></i> Print
                        </button>

                    </div>



                </div>
            </form>
            <div class="clear"></div>
        </div>
    </div>
    
  

</body>

<script type="text/javascript">
    
    $(document).ready(function(){
        
        $("#condition_notes_link").click(function(){
            $("#condition_notes").slideToggle("slow");
        })
        
        
        
        
        
        
        
        
        
    })
    
    
</script>



</html>

