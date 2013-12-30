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
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("EEEE dd MMM, yyyy");
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
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
                var prescription = "â€¢   "+spl[0]+" "+dosage[1]+" for "+t5;
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
                var prescription = "â€¢   "+t2+" "+spl[0]+" "+t6+" "+dosage[1]+" for "+t5;
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
                                    List visits = mgr.listUnitVisitations("consultation", dateFormat.format(date));
                                    if (visits != null) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            Visitationtable visit = (Visitationtable) visits.get(i);
                                            vs = mgr.currentVisitations(visit.getVisitid());
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

    </div><!-- /container -->


    <%@include file="widgets/javascripts.jsp" %>
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

        String file = "";
        String file2 = "";

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
                width : 800,
                modal :true,
                position : "top"
		
            });
            
            $('#visit_history<%=vts.getVisitid()%>link').click(function(){
            
                $('#visit_history<%=vts.getVisitid()%>').dialog('open');
                
            });
        
        });
        
    </script>

    <% }%>

    <div style="max-height: 600px; overflow-y: scroll; overflow-x: hidden; display: none;" class="visit hide" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>"  title="Consultation for <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>,  <%= mgr.getPatientByID(visit.getPatientid()).getLname()%>   ">

        <div class="span10">
            <form class="form-inline" action="action/labnpharmactions.jsp" method="post" id="frm">
                <div style="margin-left: -50px;" class="span2 ">
                    <ul class="menu">
                        <li> <a class="vital_link<%=visit.getPatientid()%> active"> <i class="icon icon-check"> </i> Vitals Signs </a></li>
                        <li> <a class="history_link<%=visit.getPatientid()%>"> <i class="icon  icon-list-alt"> </i> History </a></li>
                        <li> <a class="physical_link<%=visit.getPatientid()%>"> <i class="icon  icon-user"> </i> Physical Exam </a></li>
                        <li> <a class="laboratory_link<%=visit.getPatientid()%>"> <i class="icon  icon-search"> </i> Laboratory </a></li>
                        <li> <a class="diagnosis_link<%=visit.getPatientid()%>"> <i class="icon  icon-adjust"> </i> Diagnoses </a></li>
                        <li> <a class="treatment_link<%=visit.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Treatment </a></li>
                        <li> <a class="previous_visit_link<%=visit.getPatientid()%>"> <i class="icon  icon-file"> </i> Previous Visits </a></li>

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
                <div class="span8">

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

                                <td><%=vitaltable.getTemperature()%>&nbsp;&nbsp;(Â°C)
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
                                  
                                    </div>
                                </td>
                            </tr>
                            <%}%>
                        </table>

                    </div>
                    <div style="display: none;" class="thumbnail center laboratory<%=visit.getPatientid()%>">
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
                                                            <label style="width: 240px; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; " for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%> </label>
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
                                            } %>
                                       
                                        <%
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
                                                        <td style="80%">
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
                                                <!--     <table  class="table-bordered table-striped" style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px; width: 100%;">
                                                         <tr>
                                                             <th style="width: 200px; color: #000;">
                                                                 DATE
                                                             </th>
                                                             <th style="width: 80px; color: #000;">
                                                                 TEMPERATURE ( &#176; C)
                                                             </th>
                                                             <th style="width: 80px; color: #000;">
                                                                 PULSE (BPM)
                                                             </th>
                                                             <th style="width: 80px; color: #000;">
                                                                 BP 
                                                             </th>
                                                         </tr>
     
                                                <% List visitVitals = mgr.listVitalCheckByVisitid(vps.getVisitid());
                                                    Vitaltable vitals2 = null;
                                                    if (visitVitals != null) {
                                                        for (int ind = 0; ind < visitVitals.size(); ind++) {
                                                            vitals2 = (Vitaltable) visitVitals.get(ind);
                                                            if (vitals2 != null) {

                                                %>
                                                <tr>
                                                    <td>
                                                <%=vitals2.getDate()%>
                                            </td>
                                            <td>
                                                <%=vitals2.getTemperature()%>

                                            </td>
                                            <td>
                                                <%=vitals2.getSistolic()%> / <%=vitals2.getDiatolic()%>

                                            </td>
                                            <td>
                                                <%=vitals2.getPulse()%>

                                            </td>
                                        </tr>

                                                <% }
                                                        }
                                                    }%>

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


                                                        <table class="table-bordered table-striped" style="width: 95%; color: black;"> 
                                                            <thead>
                                                                <tr>
                                                                    <th style="text-align: left; width: 350px">
                                                                        Test Name(s)
                                                                    </th>
                                                                    <th style="text-align: left; width: 150px"> 
                                                                        Result(s)
                                                                    </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                <% for (int s = 0; s < pInvestigation.size(); s++) {
                                                        Patientinvestigation pi = (Patientinvestigation) pInvestigation.get(s);
                                                        if (pi != null) {
                                                            if (mgr.getInvestigation(pi.getInvestigationid()).getRate() > 0) {
                                                %>
                                                <tr> 
                                                    <td style="text-align: left; width: 60%; font-size: 13px; padding-left: 10px;" >
                                                <%= mgr.getInvestigation(pi.getInvestigationid()) == null ? "" : mgr.getInvestigation(pi.getInvestigationid()).getName() + "\n"%> 
                                            </td>
                                            <td style="text-align: left; width: 60%; font-size: 13px; padding-left: 10px;">
                                                
                                                <%= pi.getResult()%>
                                            </td>
                                        </tr>
                                                <%}
                                                        }
                                                    }%>
                                            </tbody>
                                        </table>

                                    </td>
                                </tr>
                            </table>  --->
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
                                    <td style="80%">
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
                            <!--  <table style=" font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 13px;">
                                  <tr>
                                      <th style="width: 200px; color: #000;">
                                          DATE
                                      </th>
                                      <th style="width: 80px; color: #000;">
                                          TEMPERATURE ( &#176; C)
                                      </th>
                                      <th style="width: 80px; color: #000;">
                                          PULSE (BPM)
                                      </th>
                                      <th style="width: 80px; color: #000;">
                                          BP 
                                      </th>
                                  </tr>

                            
                            <tr>
                                <td>
                                    20-12-2012
                                </td>
                                <td>
                                    37.0
                                </td>
                                <td>
                                    150/90
                                </td>
                                <td>
                                    110
                                </td>
                            </tr>

                            
                            
                        </table> -->
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
    <% //}%>
    <%     }
        }
    %>

</body>
</html>

