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
    if (patientVisit == null || patientVisit == "") {

        session.setAttribute("lasterror", "Please Select a Patient!");
        response.sendRedirect("consultingroom.jsp");
    }

    int visitId = Integer.parseInt(patientVisit);
    DecimalFormat df = new DecimalFormat();
    TransactionEntityManager mg = new TransactionEntityManager();
    df.setMinimumFractionDigits(2);
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("EEEE dd MMM, yyyy");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="widgets/stylesheets.jsp" %>
        <link rel="stylesheet" href="css/chosen.css"/>

    </script>
    <style type="text/css" media="all">
        /* fix rtl for demo */
        .chosen-rtl .chosen-drop { left: -9000px; }
        input, select { vertical-align: middle; }


        ui-tabs-vertical { width: 95%; }
        .ui-tabs-vertical .ui-tabs-nav { float: left; width: 10%; }
        .ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px 2% 0; }
        .ui-tabs-vertical .ui-tabs-nav li a { display:block; }
        .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: 1%; border-right-width: 1px; border-right-width: 1px; }
        .ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 80%;}
        .ui-tabs-vertical .ui-tabs-nav { border-color: #DDD;}
        .ui-tabs-vertical .ui-tabs-nav { border-style: none;}
        .ui-tabs-vertical .ui-tabs-nav { border-width: 0 0 1px;}

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
            alert("Hello")
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
        function addImmunization(id2){
            //alert("Hello");
            addcount++;
            //alert(addcount)
            var tr = document.createElement("tr");
            var td1 = document.createElement("td"); 
            var td5 = document.createElement("td");
            var td6 = document.createElement("td");
           
            var cb = document.createElement( "input" );
            var btn = document.createElement( "button" );
            btn.innerHTML = 'Remove';
            cb.type = "text";
            cb.id = "id";
            cb.name = "immunizations";
            
            td6.appendChild(btn);
                
            td5.appendChild(cb);
            tr.appendChild(td1);
            tr.id = "tr1_"+addcount;
            tr.appendChild(td5);
            tr.appendChild(td6);
            document.getElementById( id2 ).style.display='block';
            document.getElementById( id2 ).appendChild( tr );
                
            btn.onclick = function(){
    
                var tbl = document.getElementById(id2);
                var rem = confirm("Are you sure you to remove this Immunization");
                if(rem){
                    tbl.removeChild(document.getElementById(tr.id));
                    alert("Removed Successfully");
                    return false;
                }else{
                    return false;
                }
            }
        }
        
        function addSurgery(id2){
            //alert("Hello");
            addcount++;
            
            var tr = document.createElement("tr");
            var td1 = document.createElement("td"); 
            var td5 = document.createElement("td");
            var td6 = document.createElement("td");
           
            var cb = document.createElement( "input" );
            var btn = document.createElement( "button" );
            btn.innerHTML = 'Remove';
            cb.type = "text";
            cb.id = "id";
            cb.name = "surgeries";
            
            td6.appendChild(btn);
                
            td5.appendChild(cb);
            tr.appendChild(td1);
            tr.id = "tr1_"+addcount;
            tr.appendChild(td5);
            tr.appendChild(td6);
            document.getElementById( id2 ).style.display='block';
            document.getElementById( id2 ).appendChild( tr );
                
            btn.onclick = function(){
    
                var tbl = document.getElementById(id2);
                var rem = confirm("Are you sure you to remove this Surgery");
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
            
        function addCheckTreatment(id1,id4,id5,id7){
            addcount++;
            // alert("Hello!");
                
            var t1 = document.getElementById(id1).value
            var t4 = document.getElementById(id4).value;
            var t5 = document.getElementById(id5).value;
            if(t1 =="Select"){
                alert("Please Select Treatment before Clicking");
                document.getElementById(id1).focus();
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
            var td4 = document.createElement("td");
            var td5 = document.createElement("td");
            var td7 = document.createElement("td");
            var td8 = document.createElement("td");
            var text = document.createTextNode(document.getElementById(id1).value);
            var text4 = document.createTextNode(document.getElementById(id4).value);
            var text5 = document.createTextNode(document.getElementById(id5).value);
            var btn = document.createElement( "button" );
            btn.innerHTML = 'Remove';
            // alert(text);
            //alert(t4);
            // alert(text5);
            //tr.appendChild(td);
            var cb = document.createElement( "input" );
            cb.type = "checkbox";
            cb.id = "id";
                
            tr.id = "tr2_"+addcount;
            cb.name = "data";
                
            //Injection Diazopam 10mg Daily for 2 weeks 
            //var spl = t1.split("><");
            var dosage = t4.split("-");
            var drugname = t1.split("_");
                
            var prescription = drugname[1]+" "+dosage[1]+" for "+t5;
            //alert(prescription+ dosage[1] )
            //alert(prescription)
            var presctext = document.createTextNode(prescription);
            var ttt = drugname[0]+"><"+t4+"><"+t5;
            cb.value = ttt;
            cb.checked = true;
            td1.appendChild(presctext);
            td4.appendChild(text4);
            td5.appendChild(text5);
                
                
            td7.appendChild(cb);
            td8.appendChild(btn);
            //td.appendChild(text);
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
            
            
        function addPrintCheckTreatment(id1,id4,id5,id7){
            addcount++;
            // alert("Hello!");
            var t1 = document.getElementById(id1).value;
            var t4 = document.getElementById(id4).value;
            var t5 = document.getElementById(id5).value;
            if(t1 =="Select"){
                alert("Please Select Treatment before Clicking");
                document.getElementById(id1).focus();
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
            var td4 = document.createElement("td");
            var td5 = document.createElement("td");
            var td7 = document.createElement("td");
            var td8 = document.createElement("td");
            var text = document.createTextNode(document.getElementById(id1).value);
            var text4 = document.createTextNode(document.getElementById(id4).value);
            var text5 = document.createTextNode(document.getElementById(id5).value);
            //  var btn = document.createElement( "button" );
            //  btn.innerHTML = 'Remove';
            // alert(text);
            // alert(text4);
            // alert(text5);
            //tr.appendChild(td);
            // var cb = document.createElement( "input" );
            // cb.type = "checkbox";
            // cb.id = "id";
                
            tr.id = "tr2_"+addcount;
            //  cb.name = "data";
                
            //Injection Diazopam 10mg Daily for 2 weeks 
            //var spl = t1.split("><");
            var dosage = t4.split("-");
            var drugname = t1.split("_");
                
            var prescription = drugname[1]+" "+dosage[1] +" for "+t5;
            // alert(prescription)
            var presctext = document.createTextNode(prescription);
            var ttt = t1+"><"+t4+"><"+t5;
            //  cb.value = ttt;
            //  cb.checked = true;
            td1.appendChild(presctext);
            td4.appendChild(text4);
            //td5.appendChild(text5);
                
                
            // td7.appendChild(cb);
            //  td8.appendChild(btn);
            //td.appendChild(text);
            tr.appendChild(td1);
               
            tr.appendChild(td7);
            tr.appendChild(td8);
                
            document.getElementById( id7 ).appendChild( tr );
            //return false;
            // tr.appendChild(td8);
                
               
            /*    btn.onclick = function(){
    
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
            
            
        function addCheckboxes (id1,id2,id3,id4,id5,id6,id7){
            addcount++;
            var t1 = document.getElementById(id1).value;
            var t2 = document.getElementById(id2).value;
            var t3 = document.getElementById(id3).value;
            var t4 = document.getElementById(id4).value;
            var t5 = document.getElementById(id5).value;
            var t6 = document.getElementById(id6).value;
            if(t1 =="Select"){
                alert("Please Select Treatment before Clicking");
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
            var dosage = t4.split("-");
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
                // alert("Please select treatment before adding");
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
        function printSelection(node){

            var content=node.innerHTML
            var pwin=window.open('','print_content','width=400,height=900');

            pwin.document.open();
            pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
            pwin.document.close();
 
            setTimeout(function(){pwin.close();},1000);

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
            /*  var batch = document.getElementById(id1).value;
            $.post('patientcount.jsp', {action : "treatment", id : batch}, function(data) {
                //alert(data);
                if(data>0){ 
                    addCheckboxes (id1,id2,id3,id4,id5,id6,id7);
                    // addPrintCheckboxes (id9,id10,id11,id12,id13,id14,id15);
                }else{
                    alert("Not enough in stock please request an alternative");
                    return false;
                }  
            });
             */
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
                    <% Visitationtable visit = mgr.currentVisitations(visitId);%>
                    <li style="margin-left: -5px;" class="active">
                        <a href="#">Consultation for <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>  <%= mgr.getPatientByID(visit.getPatientid()).getLname()%> | <%= visit.getPatientid()%> </a><span class="divider"></span>
                    </li>
                    <li style="margin-left: 0px; float: right;" class="danger">
                        <a href="consultingroom.jsp"><i class=" icon-white icon-arrow-left"></i> Back to Consultation Room </a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>


        <div class="clearfix">

        </div>
        <section class="container-fluid" style="margin-top: -50px;" id="dashboard"> 
            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%> center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>
            <br/>
            <div class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>
            <div class="row-fluid">
                <%
                    //HMSHelper mgr = new HMSHelper();
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                    boolean isReview = visit.isReview();
                    List investigations = null;
                    List allergies = null;
                    List medical_histories = null;
                    List social_histories = null;
                    List duration_options = null;
                    List systemic_review = null;
                    List previous_visits = null;
                    List patient_allergies = null;
                    List patient_medical_histories = null;
                    List patient_family_histories = null;
                    List patient_social_histories = null;
                    List nurses_patient_conditions = null;
                    List nurses_condition_notes = null;
                    List nurses_patient_onsets = null;
                    List nurses_onset_notes = null;
                    List nurses_patient_reliefs = null;
                    List nurses_relief_notes = null;
                    List patient_immunizations = null;
                    List patient_surgeries = null;

                    List patient_diagnosis = null;
                    List patient_treatments = null;
                    List laborders = null;


                    investigations = mgr.listInvestigation();
                    allergies = mgr.listAllergiess();
                    medical_histories = mgr.listMedicalHistoryOptions();
                    social_histories = mgr.listSocialHistoryOptions();
                    duration_options = mgr.listDurationOptions();
                    previous_visits = mgr.listPatientVisits(visit.getPatientid());
                    patient_immunizations = mgr.listPatientImmunizationsByPatientid(visit.getPatientid());
                    patient_surgeries = mgr.listPatientSurgeriesByPatientid(visit.getPatientid());


                    patient_diagnosis = mgr.listPatientDiagnosisByVisit(visitId);
                    patient_treatments = mgr.listPatientTreatmentsByVisitId(visitId);
                    laborders = mgr.listLabordersByVisitid(visitId);

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


                    String patientid = visit.getPatientid();
                    patient_medical_histories = mgr.listPatientMedicalHistoryByPatientId(patientid);
                    patient_family_histories = mgr.listPatientFamilyHistoryByPatientId(patientid);
                    patient_social_histories = mgr.listPatientSocialHistoryByPatientId(patientid);
                    patient_allergies = mgr.listPatientAllergiesByPatientId(patientid);


                %>
                <%@include file="widgets/loading.jsp" %>
                <br />
                <br />
                <form id="patientconsultation" class="form-inline" action="action/labnpharmactions.jsp" method="post" id="frm">



                    <ul style="display: none; margin-top: -3%; margin-left:  2%" class="menu span2">
                        <li> <a style="font-size: 12px !important;"class="previous_visit_link<%=visit.getPatientid()%> active"> <i class="icon  icon-file"> </i> Previous Visits </a></li>

                        <li> <a style="font-size: 12px !important;"class="complaints_link<%=visit.getPatientid()%>"> <i class="icon  icon-question-sign"> </i> Chief Complaints </a></li>
                        <li> <a style="font-size: 12px !important;"class="system_review_link<%=visit.getPatientid()%>"> <i class="icon  icon-refresh"> </i> Systemic Review </a></li>

                        <li> <a style="font-size: 12px !important;"class="medical_history_link<%=visit.getPatientid()%>"> <i class="icon  icon-time"> </i> Past Medical History </a></li>
                        <li> <a style="font-size: 12px !important;"class="family_history_link<%=visit.getPatientid()%>"> <i class="icon  icon-heart"> </i> Family History </a></li>
                        <li> <a style="font-size: 12px !important;"class="social_history_link<%=visit.getPatientid()%>"> <i class="icon  icon-globe"> </i> Social History </a></li>
                        <li> <a style="font-size: 12px !important;"class="medical_examination_link<%=visit.getPatientid()%>"> <i class="icon  icon-search"> </i> Major Examination Findings </a></li>
                        <li> <a style="font-size: 12px !important;"class="diagnosis_link<%=visit.getPatientid()%>"> <i class="icon  icon-adjust"> </i> Diagnoses </a></li>

                        <li> <a style="font-size: 12px !important;"class="laboratory_link<%=visit.getPatientid()%>"> <i class="icon  icon-search"> </i> Laboratory </a></li>
                        <li> <a style="font-size: 12px !important;"class="treatment_link<%=visit.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Treatment </a></li>
                        <li> <a style="font-size: 12px !important;"class="completed_link<%=visit.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Action </a></li>

                    </ul>





                    <div style="display: none; margin-top: -3%" class="main-c span9">

                        <% if (previous_visits.size() > 0) {%>
                        <div class="thumbnail center previous_visit<%=visit.getPatientid()%>" style="width: 100%; line-height: 18px; padding-left: 1%;  ">
                            <ul style="margin-left: 0px; text-transform: uppercase; margin-bottom: 0px;" class="breadcrumb">
                                <li>
                                    <a style="text-align: center;"> <b> Visit Summaries Summary </b></a>
                                </li>
                                <li class="pull-right">
                                    <button type="button" style="margin-top: -6%" class=" btn btn-small complaints_link<%=visit.getPatientid()%>">
                                        Presenting Complaints <i class="icon-arrow-right"></i>
                                    </button>
                                </li>
                            </ul>

                            <div class="clearfix"></div>
                            <div id="verticaltabs">
                                <ul>

                                    <% for (int x = previous_visits.size() - 1; x >= 0; x--) {

                                            Visitationtable vis = (Visitationtable) previous_visits.get(x);
                                    %>
                                    <li>

                                        <% if (previous_visits.size() == x + 1) {%>   

                                        <a href="#tabs-<%=x + 1%> "> CURRENT VISIT </a>

                                        <% } else {%>
                                        <a href="#tabs-<%=x + 1%> "> VISIT NO.<%=x + 1%></a>
                                        <% }%> 
                                    </li>


                                    <% }%>
                                </ul>

                                <% for (int x = previous_visits.size() - 1; x >= 0; x--) {

                                        Visitationtable vis = (Visitationtable) previous_visits.get(x);
                                %>
                                <div  id="tabs-<%=x + 1%>"> 
                                    <lead style="color: #0063DC; font-weight: 200; text-transform: uppercase;" class="control-label pull-right">

                                        <%= datetimeformat.format(vis.getDate())%>

                                    </lead>
                                    <div class="clearfix">

                                    </div>
                                    <br />


                                    <div style="border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%">
                                        <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                            <b> NURSES ENQUIRY </b> 
                                        </lead>

                                        <% List visitVitals = mgr.listVitalTableVisitid(vis.getVisitid());



                                            Vitaltable myVitals = (Vitaltable) visitVitals.get(0);
                                        %>

                                        <table style="font-size: 12px;" class="table table-striped">
                                            <tr>
                                                <td><b style="color: #4183C4; font-size: 12px;">Temperature</b></td>

                                                <td style="font-size: 12px;"><%=myVitals.getTemperature()%>&nbsp;&nbsp;(°C)
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><b style="color: #4183C4; font-size: 12px;">Weight </b></td>

                                                <td style="font-size: 12px;"><%=myVitals.getWeight()%>&nbsp;&nbsp;(Kg)</td>
                                            </tr>

                                            <tr>
                                                <td><b style="color: #4183C4; font-size: 12px;">Height </b> </td>

                                                <td style="font-size: 12px;"><%=myVitals.getHeight()%>&nbsp; &nbsp;(cm)</b></td>
                                            </tr>
                                            <tr>
                                                <td><b style="color: #4183C4; font-size: 12px;">Blood Pressure </b> </td>
                                                <td style="font-size: 12px;">
                                                    <%=myVitals.getSistolic()%> / <%=myVitals.getDiatolic()%>&nbsp;&nbsp;(mmHg)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 12px; color: #4183C4; font-weight: bold;">
                                                    Pulse
                                                </td>

                                                <td style="font-size: 12px;">
                                                    <%=myVitals.getPulse()%>&nbsp; &nbsp;(BPM)
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div style="width: 100%">
                                        <% List patientVisitConditions = mgr.listPatientConditionsByVisitid(vis.getVisitid());
                                            int count1 = patientVisitConditions.size();
                                            List patientVisitConditionNotes = mgr.listPatientConditionNotesByVisitid(vis.getVisitid());
                                            int count2 = patientVisitConditionNotes.size();
                                            List patientVisitSystemicReviews = mgr.listPatientSystemicReviewsByVisitid(vis.getVisitid());
                                            int count3 = patientVisitSystemicReviews.size();
                                            List major_findings = mgr.listPatientMajorExaminationByVisitid(vis.getVisitid());
                                            int count4 = major_findings.size();
                                            List patientDiagnosis = mgr.listPatientDiagnosisByVisit(visitId);
                                            int count5 = patientDiagnosis.size();
                                            List patientInvestigations = mgr.listPatientLabForVisit(vis.getPatientid(), vis.getVisitid());
                                            int count6 = patientInvestigations.size();


                                            nurses_patient_conditions = mgr.listNursesPatientConditionsByVisitid(visit.getVisitid());
                                            int count7 = nurses_patient_conditions.size();
                                            nurses_condition_notes = mgr.listNursesPatientConditionNotesByVisitid(visit.getVisitid());
                                            int count8 = nurses_condition_notes.size();
                                            nurses_patient_onsets = mgr.listNursesPatientOnsetsByVisitid(visit.getVisitid());
                                            int count9 = nurses_patient_onsets.size();
                                            nurses_onset_notes = mgr.listNursesPatientOnsetNotesByVisitid(visit.getVisitid());
                                            int count10 = nurses_onset_notes.size();
                                            nurses_patient_reliefs = mgr.listNursesPatientReliefsByVisitid(visit.getVisitid());
                                            int count11 = nurses_patient_reliefs.size();
                                            nurses_relief_notes = mgr.listNursesPatientReliefNotesByVisitid(visit.getVisitid());
                                            int count12 = nurses_relief_notes.size();
                                        %>
                                        <%

                                            if (count7 > 0 || count8 > 0 || count9 > 0 || count10 > 0 || count11 > 0 || count12 > 0) {
                                        %>
                                        <div style=" padding: 1%; margin-right: 2%;  margin-bottom: 2%">
                                            <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                NURSES REVIEW  
                                            </lead>

                                            <div class="clearfix"></div>
                                            <br />


                                            <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    PRESENTING COMPLAINTS 
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />
                                                <% if (nurses_patient_conditions.size() > 0) {%>



                                                <table style="width: 95%" class="table table-striped">
                                                    <%  for (int y = 0; y < nurses_patient_conditions.size(); y++) {
                                                            NursesPatientConditions condition = (NursesPatientConditions) nurses_patient_conditions.get(y);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= mgr.getProblemOption(condition.getConditionId()).getProblemName()%>
                                                        </td>
                                                    </tr>
                                                    <% }%>
                                                </table>
                                                <% }%>
                                                <% if (nurses_condition_notes.size() > 0) {%>



                                                <table style="width: 95%" class="table table-striped">
                                                    <%
                                                        NursesPatientConditionNotes note = (NursesPatientConditionNotes) nurses_condition_notes.get(0);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= note.getConditionNote()%>
                                                        </td>
                                                    </tr>

                                                </table>
                                                <% }%>
                                            </div>

                                            <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    PRESENTING COMPLAINTS ONSET
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />
                                                <% if (nurses_patient_onsets.size() > 0) {%>
                                                <table style="width: 95%" class="table table-striped">
                                                    <%  for (int y = 0; y < nurses_patient_onsets.size(); y++) {
                                                            NursesPatientOnsets onset = (NursesPatientOnsets) nurses_patient_onsets.get(y);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= mgr.getOnsetOption(onset.getOnsetId()).getOnset()%>
                                                        </td>
                                                    </tr>
                                                    <% }%>
                                                </table>
                                                <% }%>
                                                <% if (nurses_onset_notes.size() > 0) {%>



                                                <table style="width: 95%" class="table table-striped">
                                                    <%
                                                        NursesPatientOnsetNotes note = (NursesPatientOnsetNotes) nurses_onset_notes.get(0);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= note.getOnsetNote()%>
                                                        </td>
                                                    </tr>

                                                </table>
                                                <% }%>
                                            </div>   

                                            <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    PRESENTING COMPLAINTS RELIEF
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />
                                                <% if (nurses_patient_reliefs.size() > 0) {%>
                                                <table style="width: 95%" class="table table-striped">
                                                    <%  for (int y = 0; y < nurses_patient_reliefs.size(); y++) {
                                                            NursesPatientReliefs relief = (NursesPatientReliefs) nurses_patient_reliefs.get(y);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= mgr.getReliefOption(relief.getReliefId()).getRelief()%>
                                                        </td>
                                                    </tr>
                                                    <% }%>
                                                </table>
                                                <% }%>
                                                <% if (nurses_relief_notes.size() > 0) {%>



                                                <table style="width: 95%" class="table table-striped">
                                                    <%
                                                        NursesPatientReliefNotes note = (NursesPatientReliefNotes) nurses_relief_notes.get(0);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= note.getReliefNote()%>
                                                        </td>
                                                    </tr>

                                                </table>
                                                <% }%>
                                            </div>






                                        </div>




                                        <% }%>






                                        <% if (count1 > 0 || count2 > 0 || count3 > 0 || count4 > 0 || count5 > 0 || count6 > 0) {%>
                                        <div class="clearfix">

                                        </div>
                                        <div style="width: 100%">
                                            <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                CONSULTATION SUMMARY  
                                            </lead>

                                            <div class="clearfix"></div>
                                            <br />

                                            <% if (patientVisitConditions.size() > 0) {%>    
                                            <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%; margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    PRESENTING COMPLAINTS 
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />




                                                <table style="width: 95%" class="table table-striped">
                                                    <% for (int y = 0; y < patientVisitConditions.size(); y++) {
                                                            PatientConditions condition = (PatientConditions) patientVisitConditions.get(y);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= mgr.getProblemOption(condition.getConditionId()).getProblemName()%>
                                                        </td>
                                                    </tr>
                                                    <% }%>
                                                </table>

                                                <% if (patientVisitConditionNotes.size() > 0) {
                                                        PatientConditionNotes note = (PatientConditionNotes) patientVisitConditionNotes.get(0);

                                                %>
                                                <table>
                                                    <tr>
                                                        <td><%= note.getConditionNote()%> </td>
                                                    </tr>

                                                </table>


                                                <% }%>





                                            </div>
                                            <% }%>
                                            <%

                                                if (patientVisitSystemicReviews.size() > 0) {%>
                                            <div style="width: 45%; font-size: 10px;  border: solid 1px #DDD; padding: 1%;margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    SYSTEMIC REVIEW
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />

                                                <table style="width: 95%" class="table table-striped">
                                                    <% for (int y = 0; y < patientVisitSystemicReviews.size(); y++) {
                                                            PatientSystemicReviews review = (PatientSystemicReviews) patientVisitSystemicReviews.get(y);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= mgr.getClerkingQuestionByid(review.getSystemicReviewId()).getQuestion()%>
                                                        </td>
                                                    </tr>
                                                    <% }%>
                                                </table>
                                            </div>
                                            <%}%>


                                            <%
                                                if (major_findings.size() > 0) {%>
                                            <div style="width: 45%; font-size: 12px;  border: solid 1px #DDD; padding: 1%;margin-right: 2%;  margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    MAJOR EXAMINATION FINDINGS
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />
                                                <% PatientMajorExaminations exam = (PatientMajorExaminations) major_findings.get(0);%>

                                                <%= exam.getExaminationNote()%>
                                            </div>


                                            <% }%>

                                            <%

                                                if (patientDiagnosis.size() > 0) {%>
                                            <div style="width: 45%; font-size: 12px;  border: solid 1px #DDD; padding: 1%;margin-right: 2%; margin-bottom: 2%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase;" class="control-label" >
                                                    DIAGNOSES
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />
                                                <table style="width: 95%" class="table table-striped">
                                                    <% for (int y = 0; y < patientDiagnosis.size(); y++) {
                                                            Patientdiagnosis patientDiag = (Patientdiagnosis) patientDiagnosis.get(y);
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <%= mgr.getDiagnosis(patientDiag.getDiagnosisid()).getDiagnosis()%>
                                                        </td>
                                                    </tr>
                                                    <% }%>
                                                </table>

                                            </div>

                                            <% }%>

                                            <%

                                                if (patientInvestigations.size() > 0) {
                                            %>
                                            <div style="width: 45%; font-size: 10px; border: solid 1px #DDD; padding: 1%" class="pull-left center">
                                                <lead style="color: #000; font-weight: bold; font-size: 12px; text-transform: uppercase; " class="control-label" >
                                                    INVESTIGATIONS
                                                </lead> 
                                                <div class="clearfix"></div>
                                                <br />
                                                <table class="table table-striped">

                                                    <tbody>
                                                        <% for (int y = 0; y < patientInvestigations.size(); y++) {
                                                                Patientinvestigation patientInv = (Patientinvestigation) patientInvestigations.get(y);
                                                                Investigation investigation = mgr.getInvestigation(patientInv.getInvestigationid());
                                                                if (investigation.getRate() > 0) {
                                                        %>
                                                        <tr>
                                                            <td>
                                                                <%= mgr.getInvestigation(patientInv.getInvestigationid()).getName()%>
                                                            </td>

                                                            <td>
                                                                <%= patientInv.getResult()%>
                                                            </td>
                                                        </tr>

                                                        <% }
                                                            }%>
                                                    </tbody>
                                                </table>



                                            </div>

                                        </div>




                                        <% }
                                            }%>

                                    </div>




                                </div>

                                <% }%>

                            </div>

                        </div>
                        <% }%>


                        <div class=" complaints<%=visit.getPatientid()%> hide pull-left thumbnail" style="width: 100%; line-height: 18px; padding-left: 10px; ">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb center">
                                <li class="pull-left">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small previous_visit_link<%=visit.getPatientid()%>">
                                        <i class="icon-arrow-left"></i> Visit Summary
                                    </button>
                                </li>
                                <li>
                                    <a style="text-align: center;"> <b> Presenting Complaints </b></a>
                                </li>

                                <li class="pull-right">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small system_review_link<%=visit.getPatientid()%>">
                                        Systemic Review <i class="icon-arrow-right"></i>
                                    </button>

                                </li>



                            </ul>

                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> CURRENT CONDITION: </a><br/> WHAT BRINGS THE PATIENT TO THE CONSULTING ROOM? </lead></label>
                                <div class="controls">

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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="condition_notes" name="conditionnote" class="hide " type="text" style="width:75%;"></textarea>
                                </div>

                            </div>

                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> ONSET: </a><br/> WHEN DID PATIENT FIRST NOTICE CONDITION? </lead></label>
                                <div class="controls">
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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea class="hide" id="onset_notes" name="onsetnote" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> LOCATION: </a><br/> WHERE DOES PATIENT EXPERIENCE DISCOMFORT? </lead></label>
                                <div class="controls">
                                    <select name="bodyparts" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4"  data-placeholder="LOCATION">
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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="bodypart_notes" name="bodypartnote" class="hide"type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> DURATION: </a><br/> HOW LONG DOES DISCOMFORT LAST? </lead></label>
                                <div class="controls">
                                    <select name="durations" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4"  data-placeholder="DURATION">
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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="duration_notes" name="durationnote" class="hide" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> CHARACTERISTIC: </a><br/> DESCRIPTION OF DISCOMFORT? </lead></label>
                                <div class="controls">
                                    <select name="characteristics" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4"  data-placeholder="CHARACTERISTIC">
                                        <option value="">CHARACTERISTIC</option>
                                        <% List characteristics = mgr.listCharacteristicsOptions();

                                            for (int x = 0; x < characteristics.size(); x++) {
                                                CharacteristicOptions characteristicOption = (CharacteristicOptions) characteristics.get(x);
                                        %>

                                        <option value="<%=characteristicOption.getCharacteristicId()%>"><%=characteristicOption.getCharacteristic()%></option>

                                        <% }%>
                                    </select> 
                                    <span class="help-inline "><button type="button" id="characteristic_notes_link" class="btn btn-info"><i class="icon icon-white icon-plus-sign"></i> Add Notes</button> </span>

                                </div>
                            </div>
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="characteristic_notes" name="characteristicnote" class="hide" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> AGGRAVATION: </a><br/> WHAT MAKES THE CONDITION WORSE? </lead></label>
                                <div class="controls">
                                    <select name="aggravations" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4"  data-placeholder="AGGRAVATION">
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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="aggravation_notes" name="aggravationnote" class="hide" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> RELIEF: </a><br/> WHAT MAKES THE CONDITION BETTER? </lead></label>
                                <div class="controls">
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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="relief_notes" name="reliefnote" class="hide" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>
                            <div style="padding-left: 10%" class="control-group">
                                <label class="control-label" ><lead> <a style="color: #0063DC; font-weight: bold"> TREATMENT: </a><br/> PRIOR TREATMENT(S) FOR THIS CONDITION? </lead></label>
                                <div class="controls">
                                    <select name="treatments" type="text" class="chosen-select" multiple style="width:75%;" tabindex="4"  data-placeholder="TREATMENT">
                                        <option value="">TREATMENT</option>
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
                            <div style="padding-left: 10%" class="control-group ">
                                <div class="controls">
                                    <textarea id="treatment_notes" name="treatmentnote" class="hide" type="text" style="width:75%;"></textarea>
                                </div>

                            </div>


                        </div>


                        <div class="medical_history<%=visit.getPatientid()%> pull-left hide thumbnail" style="width: 100%; line-height: 18px; padding-left: 5px; padding-right: 5px; ">
                            <ul style="margin-left: 0px; text-transform: uppercase; text-align: center;" class="breadcrumb">

                                <li class="pull-left">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small system_review_link<%=visit.getPatientid()%>">
                                        <i class="icon-arrow-left"></i> Systemic Review
                                    </button>

                                </li>

                                <li>
                                    <a style="text-align: center;"> <b>Medical History </b></a>
                                </li>

                                <li class="pull-right">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small family_history_link<%=visit.getPatientid()%>">
                                        Family History <i class="icon-arrow-right"></i>
                                    </button>

                                </li>
                            </ul>
                            <div class="tabs">
                                <ul>
                                    <li><a href="#medtabs-1">ALLERGIES</a></li>
                                    <li><a href="#medtabs-2">DISEASE HISTORY</a></li>
                                    <li><a href="#medtabs-3">OTHER MEDICAL HISTORY</a></li>

                                </ul>
                                <div style="padding-left: 5px; padding-right: 5px;" id="medtabs-1">
                                    <a style="color: #0e90d2; font-weight: bold"> <BR/> <lead> IS THE PATIENT TRIGGERED BY ANY OF THE FOLLOWING ALLERGENS?: </lead> </a>
                                        <% if (patient_allergies.size() > 0) {%> 

                                    <table class="table table-striped">

                                        <thead>
                                            <tr>
                                                <th style="color: #FFF; font-size: 14px; text-align: left;">
                                                    PATIENT'S ALLERGIES
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (int y = 0; y < patient_allergies.size(); y++) {
                                                    PatientAllergies allergy = (PatientAllergies) patient_allergies.get(y);
                                                    if (allergy != null) {%>
                                            <tr>
                                                <td style="text-transform: capitalize; color: #0e90d2; font-size: 14px; font-weight: bold">
                                                    <%=mgr.getAllergyByid(allergy.getAllergyid()).getName().toLowerCase()%>
                                                </td>
                                            </tr>
                                            <% }
                                                }%>



                                        </tbody>



                                    </table>
                                    <button style="margin-left: 40%" class="btn" id="addMoreAllergies" type="button">
                                        <i class="icon icon-plus-sign"></i>
                                        Add More Allergies
                                    </button>



                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset hide moreAllergies">

                                        <% for (int y = 0; y < allergies.size(); y++) {
                                                Allergies allergy = (Allergies) allergies.get(y);
                                                if (allergy != null) {%>

                                        <input class="selected_alergy pre-selected_allergy"  style="margin-top: 10px; width: 200px; "  type="checkbox" name="patient_allergies" id="allergy<%= allergy.getAllergyid()%>"  value="<%= allergy.getAllergyid()%>"/>
                                        <label class="pre-selected_allergy" style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="allergy<%= allergy.getAllergyid()%>"><%=allergy.getName().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div>
                                    <BR />
                                    <% } else {%>

                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset">
                                        <% for (int y = 0; y < allergies.size(); y++) {
                                                Allergies allergy = (Allergies) allergies.get(y);
                                                if (allergy != null) {%>

                                        <input class="selected_alergy"  style="margin-top: 10px; width: 200px; "  type="checkbox" name="patient_allergies" id="allergy<%= allergy.getAllergyid()%>"  value="<%= allergy.getAllergyid()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="allergy<%= allergy.getAllergyid()%>"><%=allergy.getName().toLowerCase()%> </label>

                                        <% }
                                            }%>

                                    </div>
                                    <%  }%>



                                </div>
                                <div style="padding-left: 5px; padding-right: 5px;"  id="medtabs-2">
                                    <lead> <a style="color: #0e90d2; font-weight: bold"> <BR/> DOES THE PATIENT HAVE ANY OF THE FOLLOWING CHRONIC CONDITIONS ? <BR /> </a> </lead>
                                    <div class="clearfix">
                                    </div>
                                    <% if (patient_medical_histories.size() > 0) {%>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th style="color: #FFF; font-size: 14px; text-align: left;">
                                                    PATIENT'S MEDICAL HISTORY <!-- <%=patient_medical_histories.size()%>  -->
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <% for (int y = 0; y < patient_medical_histories.size(); y++) {
                                                    PatientMedicalHistory patient_medical_history = (PatientMedicalHistory) patient_medical_histories.get(y);
                                                    if (patient_medical_history != null) {%>
                                            <tr>

                                                <td style="text-transform: capitalize; color: #0e90d2; font-size: 14px; font-weight: bold">
                                                    <%= mgr.getMedicalHistoryById(patient_medical_history.getHistoryId()).getHistory().toLowerCase()%>
                                                </td>
                                            </tr>


                                            <% }
                                                }%>
                                        </tbody>

                                    </table>


                                    <button style="margin-left: 40%" class="btn" id="addMoreMedicalHistory" type="button">
                                        <i class="icon icon-plus-sign"></i>
                                        Add More Medical History
                                    </button>

                                    <div  style="float: left; width: 100%; margin-top: 20px;" class="radioset hide moreMedicalHistory"> 
                                        <% for (int y = 0; y < medical_histories.size(); y++) {
                                                MedicalHistories medical_history = (MedicalHistories) medical_histories.get(y);
                                                if (medical_history != null) {%>

                                        <input class="selected_medical_history"  style="margin-top: 10px;"  type="checkbox" name="patient_medical_histories" id="medical_history<%= medical_history.getHistory()%>"  value="<%= medical_history.getHistoryId()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="medical_history<%= medical_history.getHistory()%>"><%=medical_history.getHistory().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div> 




                                    <% } else {%>

                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset"> 
                                        <% for (int y = 0; y < medical_histories.size(); y++) {
                                                MedicalHistories medical_history = (MedicalHistories) medical_histories.get(y);
                                                if (medical_history != null) {%>

                                        <input class="selected_medical_history"  style="margin-top: 10px;  "  type="checkbox" name="patient_medical_histories" id="medical_history<%= medical_history.getHistory()%>"  value="<%= medical_history.getHistoryId()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="medical_history<%= medical_history.getHistory()%>"><%=medical_history.getHistory().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div> 

                                    <% }%>
                                </div>
                                <div style="width: 100%; padding-left: 5px; padding-right: 5px;"  text-align: center;" id="medtabs-3">

                                     <a style="color: #0e90d2;  font-weight: bold"> <BR/> <lead> HAS THE PATIENT BEING INVOLVED IN ANY OF THE FOLLOWING </lead> </a>
                                    <br />
                                    <br />
                                    <div class="clearfix">

                                    </div>

                                    <div class="thumbnail pull-left" style="width: 45%;">
                                        <ul class="breadcrumb">
                                            <li>
                                                PAST SURGERIES
                                            </li>
                                            <li style="float: right;">
                                                <button style="margin-top: -6px;" onclick="addSurgery('surgery_<%=visit.getVisitid()%>'); return false;" type="button" class="btn btn-info"><i class="icon icon-plus icon-white"></i> Add</button>
                                            </li>
                                        </ul>
                                        <% if (patient_surgeries.size() > 0) {%>
                                        <table>
                                            <% for (int x = 0; x < patient_surgeries.size(); x++) {

                                                    PatientSurgeries surgery = (PatientSurgeries) patient_surgeries.get(x);
                                            %>

                                            <tr>
                                                <td>
                                                    <%= surgery.getSurgery()%>
                                                </td>
                                            </tr>

                                            <% }%>
                                        </table>

                                        <% }%>
                                        <table style="display: none;" id="surgery_<%=visit.getVisitid()%>" class="table table-bordered">

                                        </table>



                                    </div>

                                    <div class="thumbnail pull-left" style="width: 45%; margin-left: 5%">

                                        <ul class="breadcrumb">
                                            <li>
                                                IMMUNIZATIONS
                                            </li>
                                            <li style="float: right;">
                                                <button onclick="addImmunization('immunization_<%=visit.getVisitid()%>'); return false;" style="margin-top: -6px;" type="button" class="btn btn-info"><i class="icon icon-plus icon-white"></i> Add</button>
                                            </li>
                                        </ul>
                                        <% if (patient_immunizations.size() > 0) {%>
                                        <table>
                                            <% for (int x = 0; x < patient_immunizations.size(); x++) {

                                                    PatientImmunizations immunization = (PatientImmunizations) patient_immunizations.get(x);
                                            %>

                                            <tr>
                                                <td>
                                                    <%= immunization.getImmunization()%>
                                                </td>
                                            </tr>

                                            <% }%>
                                        </table>

                                        <% }%>
                                        <table style="display: none;" id="immunization_<%=visit.getVisitid()%>" class="table table-bordered">

                                        </table>


                                    </div>



                                </div>

                            </div>
                        </div>


                        <div class="family_history<%=visit.getPatientid()%> pull-left hide thumbnail" style="width: 100%; line-height: 18px; padding-left: 10px; ">
                            <ul style="margin-left: 0px; text-transform: uppercase; text-align: center;" class="breadcrumb">

                                <li class="pull-left">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small medical_history_link<%=visit.getPatientid()%>">
                                        <i class="icon-arrow-left"></i> Past Medical History
                                    </button>

                                </li>
                                <li>
                                    <a style="text-align: center;"> <b>Family History </b></a>
                                </li>
                                <li class="pull-right">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small social_history_link<%=visit.getPatientid()%>">
                                        Social History  <i class="icon-arrow-right"></i> 
                                    </button>

                                </li>
                            </ul>
                            <div class="tabs">
                                <ul>

                                    <li><a href="#tabs-1">FAMILY CHRONIC DISEASE HISTORY</a></li>


                                </ul>
                                <div style="padding-left: 5px; padding-right: 5px;"  id="tabs-1">
                                    <lead> <a style="color: #0e90d2; font-weight: bold"> <BR/>  HAS ANY RELATIVE EVER HAD OR SUFFERED FROM ANY OF THE FOLLOWING?: <BR /> </a> </lead>

                                    <% if (patient_family_histories.size() > 0) {%>

                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Condition
                                                </th>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Relative
                                                </th>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Duration
                                                </th>
                                            </tr>
                                        </thead>
                                        <% for (int y = 0; y < patient_family_histories.size(); y++) {
                                                PatientFamilyHistory patientFamilyHistory = (PatientFamilyHistory) patient_family_histories.get(y);
                                        %>

                                        <tr>
                                            <td style="text-transform: capitalize">
                                                <%= mgr.getMedicalHistoryById(patientFamilyHistory.getHistoryId()).getHistory()%>

                                            </td>
                                            <td style="text-transform: capitalize">
                                                <%= patientFamilyHistory.getFamilyMember()%>
                                            </td>
                                            <td style="text-transform: capitalize">
                                                <%= mgr.getDurationById(patientFamilyHistory.getDurationId()).getDuration()%>
                                            </td>
                                        </tr>
                                        <% }%>

                                    </table>

                                    <button style="margin-left: 40%" class="btn" id="addMoreFamilyMedicalHistory" type="button">
                                        <i class="icon icon-plus-sign"></i>
                                        Add More Family Medical History
                                    </button>

                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset hide moreFamilyMedicalHistory"> 
                                        <% for (int y = 0; y < medical_histories.size(); y++) {
                                                MedicalHistories medical_history = (MedicalHistories) medical_histories.get(y);
                                                if (medical_history != null) {%>

                                        <input class="family_history" name="patient_family_histories"  style="margin-top: 10px;"  type="checkbox" name="family_history" id="family_history<%= medical_history.getHistoryId()%>" attribute="<%= medical_history.getHistory()%>"  value="<%= medical_history.getHistoryId()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="family_history<%= medical_history.getHistoryId()%>"><%=medical_history.getHistory().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div>


                                    <table class="moreFamilyMedicalHistory" border="0" align="center" cellpadding="2" cellspacing="1" id="family">
                                        <input type="hidden" value="" name="family_history_counter" id="family_history_counter" /> 
                                        <tbody  class="clone_source">
                                            <tr style='display:none'>
                                                <td  style="width: 20px;">

                                                </td>
                                                <td style="width: 200px;">
                                                    <input style="width: 96%" type="text" />
                                                </td>
                                                <td style="width: 40%">
                                                    <select name="family_history_relations" style="width: 96%" type="text" >
                                                        <option value="">Select</option>
                                                        <option value="Siblings">Siblings</option>
                                                        <option value="Mother">Mother</option>
                                                        <option value="Father">Father</option>
                                                        <option value="Grand Mother">Grand Mother</option>
                                                        <option value="Grand Father">Grand Father</option>
                                                    </select>
                                                </td>
                                                <td style="width: 30%">
                                                    <select name="family_history_durations" style="width: 96%" type="text" >
                                                        <option value="">Select</option>
                                                        <% for (int y = 0; y < duration_options.size(); y++) {
                                                                DurationOptions duration_option = (DurationOptions) duration_options.get(y);
                                                                if (duration_option != null) {%>

                                                        <option value="<%= duration_option.getDurationId()%>"><%= duration_option.getDuration()%> </option>


                                                        <% }
                                                            }%>
                                                    </select>
                                                </td>

                                            </tr>
                                        </tbody>


                                    </table>

                                    <% } else {%>

                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset"> 
                                        <% for (int y = 0; y < medical_histories.size(); y++) {
                                                MedicalHistories medical_history = (MedicalHistories) medical_histories.get(y);
                                                if (medical_history != null) {%>

                                        <input class="family_history" name="patient_family_histories"  style="margin-top: 10px;"  type="checkbox" name="family_history" id="family_history<%= medical_history.getHistoryId()%>" attribute="<%= medical_history.getHistory()%>"  value="<%= medical_history.getHistoryId()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="family_history<%= medical_history.getHistoryId()%>"><%=medical_history.getHistory().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div> 


                                    <table border="0" align="center" cellpadding="2" cellspacing="1" id="family">
                                        <input type="hidden" value="" name="family_history_counter" id="family_history_counter" /> 
                                        <tbody  class="clone_source">
                                            <tr style='display:none'>
                                                <td  style="width: 20px;">

                                                </td>
                                                <td style="width: 200px;">
                                                    <input style="width: 96%" type="text" />
                                                </td>
                                                <td style="width: 40%">
                                                    <select name="family_history_relations" style="width: 96%" type="text" >
                                                        <option value="">Select</option>
                                                        <option value="Siblings">Siblings</option>
                                                        <option value="Mother">Mother</option>
                                                        <option value="Father">Father</option>
                                                        <option value="Grand Mother">Grand Mother</option>
                                                        <option value="Grand Father">Grand Father</option>
                                                    </select>
                                                </td>
                                                <td style="width: 30%">
                                                    <select name="family_history_durations" style="width: 96%" type="text" >
                                                        <option value="">Select</option>
                                                        <% for (int y = 0; y < duration_options.size(); y++) {
                                                                DurationOptions duration_option = (DurationOptions) duration_options.get(y);
                                                                if (duration_option != null) {%>

                                                        <option value="<%= duration_option.getDurationId()%>"><%= duration_option.getDuration()%> </option>


                                                        <% }
                                                            }%>
                                                    </select>
                                                </td>

                                            </tr>
                                        </tbody>


                                    </table>

                                    <% }%>

                                </div>


                            </div>
                        </div>


                        <div class="social_history<%=visit.getPatientid()%> hide pull-left thumbnail" style="width: 100%; line-height: 18px; padding-left: 10px; ">
                            <ul style="margin-left: 0px; text-transform: uppercase; text-align: center;" class="breadcrumb">

                                <li class="pull-left">
                                    <button type="button" style="margin-top: -6%" class="family_history_link<%=visit.getPatientid()%> btn">
                                        <i class="icon-arrow-left">

                                        </i>
                                        Family History
                                    </button> 

                                </li>

                                <li>
                                    <a style="text-align: center;"> <b>Social History </b></a>
                                </li>

                                <li class="pull-right">
                                    <button type="button" style="margin-top: -6%" class="medical_examination_link<%=visit.getPatientid()%> btn">
                                        Major Examination Findings <i class="icon-arrow-right"></i>
                                    </button>

                                </li>
                            </ul>
                            <div  class="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Occupation</a></li>
                                    <li><a href="#tabs-2">Social Behaviors</a></li>


                                </ul>
                                <div style="padding-left: 5px; padding-right: 5px;"  id="tabs-1">
                                    <lead> <a style="color: #0e90d2; font-weight: bold"> <BR/>  KINDLY STATE PATIENT'S OCCUPATION & RELEVANCE: <BR /> </a> </lead>


                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th style="width: 100%; font-size: 14px; color: #fff;">
                                                    Occupation
                                                </th>

                                            </tr>

                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="width: 100%; font-size: 15px; text-align: center ">
                                                    <input style="width: 95%" name="occupation" value="<%= mgr.getPatientByID(visit.getPatientid()).getOccupation()%>" type="text"/>

                                                </td>


                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div style="padding-left: 5px; padding-right: 5px;"  id="tabs-2">
                                    <lead> <a style="color: #0e90d2; font-weight: bold"> <BR/>  IS PATIENT INVOLVED IN ANY OF THE FOLLOWING?: <BR /> </a> </lead>
                                            <% if (patient_social_histories.size() > 0) {%>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Social Behavior
                                                </th>

                                                <th style="text-align: left; font-size: 14px; color: #FFF;">
                                                    Duration
                                                </th>
                                            </tr>
                                        </thead>
                                        <% for (int y = 0; y < patient_social_histories.size(); y++) {
                                                PatientSocialHistory patientSocialHistory = (PatientSocialHistory) patient_social_histories.get(y);
                                        %>

                                        <tr>
                                            <td style="text-transform: capitalize">
                                                <%= mgr.getSocialHistoryById(patientSocialHistory.getSocialHistoryId()).getSocialHistory()%>

                                            </td>

                                            <td style="text-transform: capitalize">
                                                <%= mgr.getDurationById(patientSocialHistory.getDurationId()).getDuration()%>
                                            </td>
                                        </tr>
                                        <% }%>

                                    </table>

                                    <button style="margin-left: 40%" class="btn" id="addMoreSocialHistory" type="button">
                                        <i class="icon icon-plus-sign"></i>
                                        Add More Social History
                                    </button>

                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset hide moreSocialHistory"> 
                                        <% for (int y = 0; y < social_histories.size(); y++) {
                                                SocialHistories social_history = (SocialHistories) social_histories.get(y);
                                                if (social_history != null) {%>

                                        <input class="selected_social_history"  style="margin-top: 10px; width: 200px; "  type="checkbox" name="patient_social_histories" id="social_history<%= social_history.getSocialHistoryId()%>"  value="<%= social_history.getSocialHistoryId()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="social_history<%= social_history.getSocialHistoryId()%>"><%=social_history.getSocialHistory().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div> 


                                    <table border="0" align="center" cellpadding="2" cellspacing="1" id="social">
                                        <input type="hidden" value="" name="social_history_counter" id="social_history_counter" /> 

                                        <tbody class="clone_source">
                                            <tr style='display:none'>
                                                <td  style="width: 5px; text-align: left;">

                                                </td>
                                                <td style="width: 250px;">
                                                    <input style="width: 250px;" type="text" />
                                                </td>

                                                <td style="width: 250px;">
                                                    <select name="social_history_durations" style="width: 250px;" type="text" >
                                                        <option value="">Select</option>
                                                        <% for (int y = 0; y < duration_options.size(); y++) {
                                                                DurationOptions duration_option = (DurationOptions) duration_options.get(y);
                                                                if (duration_option != null) {%>

                                                        <option value="<%= duration_option.getDurationId()%>"><%= duration_option.getDuration()%> </option>


                                                        <% }
                                                            }%>
                                                    </select>
                                                </td>

                                            </tr>
                                        </tbody>


                                    </table>
                                    <% } else {%>

                                    <div style="float: left; width: 100%; margin-top: 20px;" class="radioset"> 
                                        <% for (int y = 0; y < social_histories.size(); y++) {
                                                SocialHistories social_history = (SocialHistories) social_histories.get(y);
                                                if (social_history != null) {%>

                                        <input class="selected_social_history"  style="margin-top: 10px; width: 200px; "  type="checkbox" name="patient_social_histories" id="social_history<%= social_history.getSocialHistoryId()%>"  value="<%= social_history.getSocialHistoryId()%>"/>
                                        <label style="width: 25%; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; text-transform: capitalize; "  for="social_history<%= social_history.getSocialHistoryId()%>"><%=social_history.getSocialHistory().toLowerCase()%> </label>

                                        <% }
                                            }%>
                                    </div> 


                                    <table border="0" align="center" cellpadding="2" cellspacing="1" id="social">
                                        <input type="hidden" value="" name="social_history_counter" id="social_history_counter" /> 

                                        <tbody  class="clone_source">
                                            <tr style='display:none'>
                                                <td  style="width: 5px; text-align: left;">

                                                </td>
                                                <td style="width: 250px;">
                                                    <input style="width: 250px;" type="text" />
                                                </td>

                                                <td style="width: 250px;">
                                                    <select name="social_history_durations" style="width: 250px;" type="text" >
                                                        <option value="">Select</option>
                                                        <% for (int y = 0; y < duration_options.size(); y++) {
                                                                DurationOptions duration_option = (DurationOptions) duration_options.get(y);
                                                                if (duration_option != null) {%>

                                                        <option value="<%= duration_option.getDurationId()%>"><%= duration_option.getDuration()%> </option>


                                                        <% }
                                                            }%>
                                                    </select>
                                                </td>

                                            </tr>
                                        </tbody>


                                    </table>

                                    <% }%>

                                </div>


                            </div>
                        </div>

                        <div class=" system_review<%=visit.getPatientid()%> hide pull-left thumbnail" style="width: 100%; line-height: 18px; padding-left: 10px; ">
                            <ul style="margin-left: 0px; text-transform: uppercase; text-align: center;" class="breadcrumb">
                                <li class="pull-left">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small complaints_link<%=visit.getPatientid()%>">
                                        <i class="icon-arrow-left"></i> Presenting Complaints
                                    </button>

                                </li>
                                <li>
                                    <a style="text-align: center;"> <b>Systemic Review </b></a>
                                </li>
                                <li class="pull-right">

                                    <button type="button" style="margin-top: -6%" class=" btn btn-small medical_history_link<%=visit.getPatientid()%>">
                                        Past Medical History <i class="icon-arrow-right"></i>
                                    </button>

                                </li>
                            </ul>     


                            <div id="tabs">
                                <ul>

                                    <% List systemCategories = mgr.listClerkCategories();
                                        for (int y = 0; y < systemCategories.size(); y++) {
                                            ClerkingCategories systemCategory = (ClerkingCategories) systemCategories.get(y);
                                            if (systemCategory != null) {
                                                List systemReviewOptions = mgr.listClerkQuestionsbyCategoryId(systemCategory.getId());
                                                if (systemReviewOptions.size() > 0) {
                                    %>
                                    <li><a href="#tabs-<%= systemCategory.getId()%>"><%= systemCategory.getCategoryName()%></a></li>


                                    <% }
                                            }
                                        }%>
                                </ul>




                                <% systemCategories = mgr.listClerkCategories();
                                    for (int y = 0; y < systemCategories.size(); y++) {
                                        ClerkingCategories systemCategory = (ClerkingCategories) systemCategories.get(y);
                                        if (systemCategory != null) {
                                            List systemReviewOptions = mgr.listClerkQuestionsbyCategoryId(systemCategory.getId());
                                            if (systemReviewOptions.size() > 0) {
                                %>



                                <div style="padding-left: 5px; padding-right: 5px;"  id="tabs-<%= systemCategory.getId()%>">
                                    <div style="float: left; width: 100%;" class="radioset center"> 

                                        <% for (int x = 0; x < systemReviewOptions.size(); x++) {
                                                Clerkingquestion systemReviewOption = (Clerkingquestion) systemReviewOptions.get(x);
                                                if (systemReviewOption != null) {
                                        %>
                                        <input class="selected_review"  style="margin-top: 2px;"  type="checkbox" name="systemic_reviews" id="review<%= systemReviewOption.getQuestion()%>"  value="<%= systemReviewOption.getClerkid()%>"/>
                                        <label style="width: 27%; font-size: 14px;  float: left; margin-right: 30px; margin-bottom: 10px; text-transform: capitalize; "  for="review<%= systemReviewOption.getQuestion()%>"><%=systemReviewOption.getQuestion().toLowerCase()%></label>

                                        <%          }
                                            }%>
                                    </div>
                                </div>
                                <% }
                                        }
                                    }%>


                            </div>
                        </div>


                        <div style="display: none;" class=" thumbnail center medical_examination<%=visit.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">

                                <li class="pull-left">
                                    <button style="margin-top: -6%" type="button" class="social_history_link<%=visit.getPatientid()%> btn">
                                        <i class="icon-arrow-left"></i> Social History
                                    </button>

                                </li>

                                <li>
                                    <a style="text-align: center;"><b> Major Examination Findings </b></a>
                                </li>

                                <li class="pull-right">
                                    <button style="margin-top: -6%" type="button" class="diagnosis_link<%=visit.getPatientid()%> btn">
                                        Diagnoses <i class="icon-arrow-right"></i>
                                    </button>

                                </li>
                            </ul>
                            <br />

                            <textarea name="majorexaminationfindings" style="width: 90%; height: 200px;">
                            
                            
                            </textarea>

                        </div>

                        <div style="display: none;" class="thumbnail center laboratory<%=visit.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li class="pull-left">
                                    <button style="margin-top: -6%" type="button" class="diagnosis_link<%=visit.getPatientid()%> btn">
                                        <i class="icon-arrow-left"></i> Diagnoses
                                    </button>
                                </li>
                                <li>
                                    <a href="#"><b> Laboratory</b></a>
                                </li>
                                <li class="pull-right">
                                    <button style="margin-top: -6%" type="button" class="treatment_link<%=visit.getPatientid()%> btn">
                                        Treatment <i class="icon-arrow-right"></i>
                                    </button>
                                </li>
                            </ul>
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
                                <div style="padding-left: 5px; padding-right: 5px;"  id="tabs-1">

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
                                        <div style="padding-left: 5px; padding-right: 5px;"  id="tabs-<%=colNum%>">
                                            <div style="float: left; width : 100%; padding: 0px;"  class="radioset">
                                                <%
                                                    investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                    if (investigations != null) {
                                                %>
                                                <% for (int p = 0; p < investigations.size(); p++) {
                                                        Investigation investigation = (Investigation) investigations.get(p);
                                                        if (investigation != null) {%>

                                                <input class="selected_result<%= visit.getPatientid()%>" type="checkbox" name="labtest" id="test<%= investigation.getDetailedInvId()%>" labid="<%=investigation.getCode()%>" labtestname="<%=investigation.getName()%>" labtestpricevalue="<%=df.format(investigation.getRate())%>" labtestprice="GH&#162;<%=df.format(investigation.getRate())%>"  value="<%=investigation.getRate()%>><<%= investigation.getDetailedInvId()%>"/>
                                                <label style="width: 27%; font-size: 14px; text-align: center; float: left;  margin-bottom: 10px;margin-left:  2%; " for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%> </label>

                                                <% }
                                                    }%>


                                                <% }%>

                                            </div> 

                                        </div>
                                        <% }
                                            }%>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div>
                                        <% if (isReview && laborders.size() > 0) {%>
                                        <table class="table"> 
                                            <thead>
                                                <tr>
                                                    <th style="font-size: 14px; font-weight: bold; color: ">
                                                        Previously Selected Investigations
                                                    </th>

                                                </tr>
                                            </thead>

                                            <% for (int x = 0; x < laborders.size(); x++) {
                                                    Laborders order = (Laborders) laborders.get(x);

                                            %>
                                            <tr>
                                                <td>
                                                    <% if (order.getDone().equalsIgnoreCase("Dispatched") || order.getDone().equalsIgnoreCase("Out-Complete")) {%>
                                                    <a href="viewreadyresult.jsp?labOrderId=<%= order.getOrderid()%>">
                                                        View Lab Results
                                                    </a>
                                                    <% } else {%>

                                                    <label class="label-important label">
                                                        Not Ready
                                                    </label>>

                                                    <% }%>
                                                </td>
                                            </tr>

                                            <% }%>

                                        </table>


                                        <% }%>

                                        <table  class="table">
                                            <thead>
                                                <tr>
                                                    <th style="color: #FFF; text-align: left; font-size: 14px;">
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

                            </div>
                        </div>

                        <div style="display: none;" class=" thumbnail center diagnosis<%=visit.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li class="pull-left">
                                    <button style="margin-top: -3%" type="button" class="medical_examination_link<%=visit.getPatientid()%> btn">
                                        <i class="icon-arrow-left"></i> Major Examination Findings
                                    </button>

                                </li>

                                <li>
                                    <a style="text-align: center;"><b> Diagnosis </b></a>
                                </li>
                                <li class="pull-right">
                                    <button style="margin-top: -6%" type="button" class="laboratory_link<%=visit.getPatientid()%> btn">
                                        Laboratory <i class="icon-arrow-right"></i>
                                    </button>

                                </li>
                            </ul>
                            <% if (isReview && patient_diagnosis.size() > 0) {%>
                            <table class="table"> 
                                <thead>
                                    <tr>
                                        <th style="font-size: 14px; font-weight: bold; color: #FFF">
                                            Previously Selected Diagnoses
                                        </th>

                                    </tr>
                                </thead>

                                <% for (int x = 0; x < patient_diagnosis.size(); x++) {
                                        Patientdiagnosis diag = (Patientdiagnosis) patient_diagnosis.get(x);
                                %>
                                <tr>
                                    <td style="font-size: 16px; font-weight: bold">
                                        <%= mgr.getDiagnosis(diag.getDiagnosisid()).getDiagnosis()%>
                                    </td>
                                </tr>

                                <% }%>

                            </table>


                            <% }%>

                            <table class="table"> 
                                <tr>
                                    <td style="font-size: 14px; font-weight: " colspan="2">
                                        Select Diagnoses
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%if (mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {%>

                                        <select style="width: 95%" class="select" id="diagnosis<%=visit.getVisitid()%>">

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


                                        <select style="width: 95%" class="select" id="diagnosis<%=visit.getVisitid()%>" onchange =''>

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
                                    <td style="margin: 0px; padding: 0px;">
                                        <button style="width: 95%" id="addCheckBoxes" class="btn btn-info " onclick='addDiadChecks("diagnosis<%=visit.getVisitid()%>","appendd_<%=visit.getVisitid()%>" );return false;'>
                                            <i class="icon-white icon-plus-sign"> </i>   Add
                                        </button>
                                    </td>
                                </tr>

                            </table> 
                            <table id="appendd_<%=visit.getVisitid()%>" class="table">
                                <thead>
                                    <tr style="padding: 12px 0px 12px 0px;">
                                        <th style="color: white; padding: 10px 0px 10px 0px; font-size: 14px;" colspan="8">
                                            Selected Diagnosis
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tbody">
                                <input type="hidden" class="input-xxlarge" id="nonexistant" value="" name="nonexistant"/>
                                </tbody>
                            </table>
                            <br/>

                        </div>


                        <div style="display: none;" class="thumbnail center treatment<%=visit.getPatientid()%>">
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li class="pull-left">
                                    <button style="margin-top: -6%" type="button" class="laboratory_link<%=visit.getPatientid()%> btn">
                                        <i class="icon-arrow-left"></i> Laboratory
                                    </button>

                                </li>

                                <li>
                                    <b> <a>Treatment</a> </b>
                                </li>

                                <li class="pull-right">
                                    <button style="margin-top: -6%; color: #fff"  type="button" class="completed_link<%=visit.getPatientid()%> btn btn-danger">
                                        Completed <i class="icon-arrow-right icon-white"></i>
                                    </button>

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
                                                <th style="text-align: left; color: #FFF; font-size: 14px;">
                                                    Name of Drug
                                                </th>
                                                <th style="text-align: left; color: #FFF; font-size: 14px;">
                                                    Dosage
                                                </th>
                                                <th style="text-align: left; color: #FFF; font-size: 14px;">
                                                    Duration 
                                                </th>
                                            </tr>

                                        </thead>
                                        <tbody style="max-height: 100px; overflow-y: auto;"> 
                                            <tr>
                                                <td>
                                                    <select class="" style="width: 100%"  name="treatment" id="treatment<%=visit.getVisitid()%>">

                                                        <%

                                                            treatments = mg.listObjects("from DispensaryItems");
                                                            List pharmitems = mg.listObjects("from PharmacyItem");

                                                            if (treatments != null) {
                                                                for (int v = 0; v < treatments.size(); v++) {
                                                                    DispensaryItems treatment = (DispensaryItems) treatments.get(v);

                                                        %>
                                                        <option  value="<%=treatment.getItemCode()%>_<%=treatment.getItemDescription() + " " + treatment.getStrength() + " " + treatment.getItemForm().getFormDescription()%>_dispensary" onclick='getDosagess("<%=treatment.getItemCode()%>")'><%=treatment.getItemDescription()%> <%=treatment.getItemForm().getFormDescription()%>  <%= treatment.getStrength()%></option> 
                                                        <% }

                                                            }
                                                            if (pharmitems != null) {
                                                                for (int v = 0; v < pharmitems.size(); v++) {
                                                                    PharmacyItem treatment = (PharmacyItem) pharmitems.get(v);
                                                        %>
                                                        <option  value="<%=treatment.getItemCode()%>_<%=treatment.getItemDescription() + " " + treatment.getStrength() + " " + treatment.getItemForm().getFormDescription()%>_pharmacy" onclick='getDosagess("<%=treatment.getItemCode()%>")'> <%=treatment.getItemDescription()%> <%=treatment.getItemForm().getFormDescription()%> <%= treatment.getStrength()%></option> 
                                                        <% }

                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                                <td style="width: 40%"> 
                                                    <select class="" style="width: 100%"  name="dosage" id="dosage<%=visit.getVisitid()%>">
                                                        <option value="Select">Select</option>

                                                    </select>
                                                </td>
                                                <td style="width: 15%">
                                                    <input type="text" value="" style="width: 100%" name="duration" id="duration<%=visit.getVisitid()%>"/>
                                                </td> 

                                            </tr>
                                        </tbody>
                                    </table>
                                    <table>

                                        <tbody style="max-height: 100px; overflow-y: auto;">
                                            <tr>
                                                <td class="center">
                                                    <button style="width: 95%" type="button" id="addCheckBoxes" class="btn btn-info" onclick='addCheckTreatment("treatment<%=visit.getVisitid()%>","dosage<%=visit.getVisitid()%>","duration<%=visit.getVisitid()%>","append_<%=visit.getVisitid()%>"); addPrintCheckTreatment("treatment<%=visit.getVisitid()%>","dosage<%=visit.getVisitid()%>","duration<%=visit.getVisitid()%>","append_prescription<%=visit.getVisitid()%>");return false; '>
                                                        <i class="icon-white icon-plus-sign"> </i>   Add Treatment
                                                    </button>


                                                </td>
                                            </tr>


                                        </tbody>
                                    </table>

                                    <table class="table" id="append_<%=visit.getVisitid()%>">
                                        <thead>
                                            <tr style="padding: 12px 0px 12px 0px;">
                                                <th style="color: white; padding: 10px 0px 10px 0px; font-size: 14px;" colspan="8">
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
                                                        <!--   <tr><td>
                                                                   <div style="text-align: left;" class="row center">
                                                                       <img style="float: left;" src="images/Rx_symbol.svg" width="30px;">   
                                                                       <h3 style="font-weight:400; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing: ">PRESCRIPTION FORM</h3>  
                                                                       </td>
                                                                   </div>
                                                           </tr>  -->

                                                    </tbody>

                                                </table>
                                            </div>
                                            <div style="clear: both"></div>

                                            <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <span style="letter-spacing: 5px;" >*******</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Prescription</span> <span style="letter-spacing: 5px;" >*******</span>
                                                <div class="clearfix"></div>
                                                Prescribed & Electronically Signed by: <br /><%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                                Wishing You Speedy Recovery <br /> Thank you
                                            </div>
                                        </section>
                                    </div>

                                    <table>
                                        <tr>
                                            <td class="center">
                                                <button type="button"  class="btn btn-primary " onclick='printSelection(document.getElementById("prescription<%=visit.getVisitid()%>")); return false;'>
                                                    <i class="icon-white icon-print"> </i>   Print Prescription
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <thead>

                                            <tr>
                                                <th colspan="5" style="text-align: center; color: #fff; font-size: 14px;">
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
                        <div class="clearfix"></div>
                        <div style="display: none;" class="thumbnail center completed<%=visit.getPatientid()%>"> 
                            <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                <li class="pull-left">
                                    <button style="margin-top: -6%" type="button" class="treatment_link<%=visit.getPatientid()%> btn">
                                        <i class="icon-arrow-left"></i> Treatment
                                    </button>

                                </li>

                                <li>
                                    <a> <b> Patient Actions </b> </a>
                                </li>


                            </ul>

                            <div style="width: 20%; margin-left: 40%" >           
                                <div class="pull-left center" style="width: 95%; padding-left: 15%">
                                    <label style="margin-top: 8px; font-size: 14px; width: 40%" class="pull-left">Admit</label>

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

                                </div>
                                <br />
                                <br />

                                <div class="pull-left center" style="width: 95%; padding-left: 15%">
                                    <label style="margin-top: 8px; font-size: 14px; width: 40%" class="pull-left">Detain </label>
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
                                </div>
                                <br />
                                <br />
                                <div class="pull-left center" style="width: 95%; padding-left: 15%">
                                    <label style="margin-top: 8px; font-size: 14px; width: 40%" class="pull-left">Refer</label>

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
                                </div>
                            </div>

                            <div class="clearfix">

                            </div>    

                            <br />
                            <br />
                            <br />
                            <div class="center" style="width: 100%">
                                <input type="hidden" name="patientid" value="<%=visit.getPatientid()%>"/>
                                <input type="hidden" name="id" value="<%=visit.getVisitid()%>"/> 
                                <input type="hidden" name="unitid" value="records"/>

                                <button style="width: 90%" type="submit" name="action" value="Forward" class="btn btn-danger btn-large">
                                    <i class="icon-white icon-arrow-right"> </i> Save & Forward
                                </button>

                            </div>
                        </div>

                    </div>


                </form>
            </div>

        </section>


    </div>
</body>
<%@page import="entities.Vitalcheck"%>
<%@page import="java.util.List"%>
<%@page import="entities.ExtendedHMSHelper"%>
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

<!-- <script type="text/javascript" src="js/tablecloth.js"></script>   --->
<script type="text/javascript" src="js/demo.js"></script>    
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/jquery.numeric.js"></script>
<script type="text/javascript" src="js/jquery.filter_input.js"></script>
<script type="text/javascript" src="js/chosen.jquery.js"></script>
<script type="text/javascript" src="js/jquery.ui.combify.js"></script>
<!--initiate accordion-->


<script type="text/javascript">
        
    $(function() {
       
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();
             
        $(".numeric").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
        $('.decimal').live("keyup",function(){inputControl($(this),'float');});
        $('.text_input').filter_input({regex:'[a-zA-Z]'});
        $(".menu").fadeIn();
        //$(".menu").addClass("hide");
        $(".content").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
        $(".main-c").fadeIn();
        $(".main").fadeIn();
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
    
        $('.select').selectToAutocomplete();
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sScrollY": "400px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true
            

        });
        
        $(':input').attr('autocomplete', 'off');
        
        // var forms = $("form");
        //forms.each(function(i) {
        //    i.attr('autocomplete', 'off');
        //});
            
        
        var currentValue = "";
        $("#addSup").click(function(){
            currentValue = $("#nonexistantsource").attr("value");
            if(currentValue != ""){ 
            
                $("#nonexistant").val($("#nonexistant").val() + currentValue + ', ');
                $("#tbody").append("<tr> <td>"+currentValue+"</td><td> </td></tr>")
           
                currentValue = $("#nonexistantsource").attr("value","");
            }
            
        });

        
        $('.close_dialog').click(function() {

            $('#dialog').dialog('close');

        });
        
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-right icon-chevron-left');
            $('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('hide span2');
            $('.menu').toggleClass('span2');
            $('.main-c').toggleClass('span9');
                
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
            
        $("#sponsor").change(function(){
                
                
            if ($('#sponsor').attr('value')!="Select"){
                $('#sponsor').closest('.control-group').addClass('success').removeClass('error')
            }else{
                $('#sponsor').closest('.control-group').addClass('error').removeClass('success')
            }
           
        });
            
            
        $(".dob").change(function(){
                
                
            if (($('#day').attr('value')!="D") && ($('#month').attr('value')!="M") && ($('#year').attr('value')!="Y")){
                $('#year').closest('.control-group').addClass('success').removeClass('error')
            }else{
                $('#year').closest('.control-group').addClass('error').removeClass('success')
            }
           
        });
                
                
        $(".updatebilling").click(function(){
            $(".updatebillingdiv").slideToggle("slow");
        })
        
        
     
    });
    
       	
           
</script>
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
        //$(".treatmentquantity").
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
            
        $("#addMoreAllergies").click(function(){
                
            $(".moreAllergies").toggle();
        })
            
        $("#addMoreMedicalHistory").click(function(){
                
            $(".moreMedicalHistory").toggle();
        })
            
        $("#addMoreFamilyMedicalHistory").click(function(){
                
            $(".moreFamilyMedicalHistory").toggle();
        })
            
        $("#addMoreSocialHistory").click(function(){
                
            $(".moreSocialHistory").toggle();
        })
            
        $(".vital_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
            
            $(".menu li a").removeClass("active");
            $(".vital_link<%=visit.getPatientid()%>").addClass("active");
            
            $(".vital<%=visit.getPatientid()%>").slideDown("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
           
            
        });
            
        $(".complaints_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".complaints_link<%=visit.getPatientid()%>").addClass("active");
            
            $(".complaints<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
    
        $(".medical_history_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
            
            $(".menu li a").removeClass("active");
            $(".medical_history_link<%=visit.getPatientid()%>").addClass("active");
                
            $(".medical_history<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
            
            
        $(".family_history_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".family_history_link<%=visit.getPatientid()%>").addClass("active");    
                
            $(".family_history<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
            
            
        $(".social_history_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".social_history_link<%=visit.getPatientid()%>").addClass("active");  
            $(".social_history<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
               
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
    
        $(".system_review_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".system_review_link<%=visit.getPatientid()%>").addClass("active"); 
            
            $(".system_review<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
    
        $(".laboratory_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".laboratory_link<%=visit.getPatientid()%>").addClass("active"); 
            
            $(".laboratory<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
    
        $(".diagnosis_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".diagnosis_link<%=visit.getPatientid()%>").addClass("active"); 
            
            $(".diagnosis<%=visit.getPatientid()%>").slideDown("slow"); 
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
    
        $(".treatment_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
           
            $(".menu li a").removeClass("active");
            $(".treatment_link<%=visit.getPatientid()%>").addClass("active"); 
                
            $(".treatment<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
            
            
        $(".medical_examination_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
            $(".menu li a").removeClass("active");
            $(".medical_examination_link<%=visit.getPatientid()%>").addClass("active");
            
            $(".medical_examination<%=visit.getPatientid()%>").slideDown("slow");
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
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
   
        
        $(".previous_visit_link<%=visit.getPatientid()%>").click(function(){
        
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
              
            $(".menu li a").removeClass("active");
            $(".previous_visit_link<%=visit.getPatientid()%>").addClass("active");
                
            $(".previous_visit<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
            
        });
    
        $(".summary_link<%=visit.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
             
            $(".menu li a").removeClass("active");
            $(".summary_link<%=visit.getPatientid()%>").addClass("active");
            
            $(".summary<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow"); 
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            $(".completed<%=visit.getPatientid()%>").slideUp("slow");
                
        });
        
        
        $(".completed_link<%=visit.getPatientid()%>").click(function(){
            $(".menu li a").removeClass("active");
            $(".completed_link<%=visit.getPatientid()%>").addClass("active");
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
                
                
            $(".completed<%=visit.getPatientid()%>").slideDown("slow");
            $(".vital<%=visit.getPatientid()%>").slideUp("slow");
            $(".complaints<%=visit.getPatientid()%>").slideUp("slow");
            $(".system_review<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".family_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".social_history<%=visit.getPatientid()%>").slideUp("slow");
            $(".laboratory<%=visit.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visit.getPatientid()%>").slideUp("slow");
            $(".medical_examination<%=visit.getPatientid()%>").slideUp("slow");
            $(".diagnosis<%=visit.getPatientid()%>").slideUp("slow");
            $(".summary<%=visit.getPatientid()%>").slideUp("slow");
            $(".previous_visit<%=visit.getPatientid()%>").slideUp("slow");
            
        });
            
        $("#condition_notes_link").click(function(){
            $("#condition_notes").slideToggle();
        })
            
        $("#onset_notes_link").click(function(){
            $("#onset_notes").slideToggle();
        })
            
        $("#bodypart_notes_link").click(function(){
            $("#bodypart_notes").slideToggle();
        })
            
            
        $("#characteristic_notes_link").click(function(){
            $("#characteristic_notes").slideToggle();
        })
            
        $("#duration_notes_link").click(function(){
            $("#duration_notes").slideToggle();
        })
            
        $("#aggravation_notes_link").click(function(){
            $("#aggravation_notes").slideToggle();
        })
            
        $("#relief_notes_link").click(function(){
            $("#relief_notes").slideToggle();
        })
            
            
        $("#treatment_notes_link").click(function(){
            $("#treatment_notes").slideToggle();
        })
            
            
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
            
            
            
    <% for (int y = 0; y < medical_histories.size(); y++) {
            MedicalHistories medical_history = (MedicalHistories) medical_histories.get(y);
            if (medical_history != null) {%>
                    var family_counter = 0;
                    $("#family_history<%= medical_history.getHistoryId()%>").change(function(){
                            
                        //alert("<%= medical_history.getHistory()%>");
                        if ($(this).is(":checked")){ 
                            family_counter = family_counter + 1;
                            var clone = $('#family > tbody.clone_source:last').clone().css("display","block");
                            clone.removeClass("clone_source");
                            clone.children().css("display","block");
                            clone.addClass("family_selected"+family_counter);
                            clone.children().addClass("family_selected"+family_counter);
                            clone.children().children().addClass("family_selected"+family_counter);
                            clone.insertBefore('#family > tbody.clone_source:last');
                            $(this).addClass("family_select_checked"+family_counter);
                            $(this).attr("counter",family_counter);
                            clone.find("button").addClass("remove_family_selected"+family_counter)
                            clone.find("td:first").next().html("<%= medical_history.getHistory()%>");
                            clone.find("td:first").append("<input type='hidden' value='<%= medical_history.getHistory()%>' /> ")
                            clone.find("td:first input").attr("class","family_counter"+family_counter);
                        }else{
                            var counter  = $(this).attr("counter");
                            $(".family_selected"+counter).remove();
                            family_counter = family_counter - 1;
                                
                        }
                        $("#family_history_counter").val(family_counter);
                    });                                        
                                                                
                                                                
    <% }
        }%>
                    
    <% for (int y = 0; y < social_histories.size(); y++) {
            SocialHistories social_history = (SocialHistories) social_histories.get(y);
            if (social_history != null) {%>    
                    
                    var social_counter = 0;
                    $("#social_history<%= social_history.getSocialHistoryId()%>").change(function(){
                            
                        //alert("<%= social_history.getSocialHistory()%>");
                        if ($(this).is(":checked")){ 
                            social_counter = social_counter + 1;
                            var clone = $('#social > tbody.clone_source:last').clone().css("display","block");
                            clone.removeClass("clone_source");
                            clone.children().css("display","block");
                            clone.addClass("social_selected"+social_counter);
                            clone.children().addClass("social_selected"+social_counter);
                            clone.children().children().addClass("social_selected"+social_counter);
                            clone.insertBefore('#social > tbody.clone_source:last');
                            $(this).addClass("social_select_checked"+social_counter);
                            $(this).attr("counter",social_counter);
                            clone.find("button").addClass("remove_social_selected"+social_counter)
                            clone.find("td:first").next().html("<%= social_history.getSocialHistory()%>");
                            clone.find("td:first").append("<input type='hidden' value='<%= social_history.getSocialHistory()%>' /> ")
                            clone.find("td:first input").attr("class","social_counter"+social_counter);
                        }else{
                            var counter  = $(this).attr("counter");
                            $(".social_selected"+counter).remove();
                            social_counter = social_counter - 1;
                                
                        }
                            
                    })  ;
                    
                    
    <% }
        }%>
                /* $('#treatment<%=visit.getVisitid()%>').blur(function(){
                    alert("here")
                    //alert(('#treatment<%=visit.getVisitid()%>').attr("value"));
                });    */     
            })
            
            
            function getDosagess(id){ //var id = document.getElementById(id).value; 
                // alert(id) 
                $.ajax({ 
                    url:"ajaxcalls/listdosage.jsp?action=getdosages&itemcode="+id, 
                    dataType:'json', success:function(resp){
                        //alert(resp) 
                        $("#dosage<%=visit.getVisitid()%>").empty(); 
                        $("#dosage<%=visit.getVisitid()%>").html(""); 
                        if(resp && resp.success=="1"){ 
                            //alert(resp.success) 
                            var dosages=resp.data; 
                            for(var i=0;i<dosages.length;i++){ 
                                var id=dosages[i].id; 
                                var name=dosages[i].name; 
                                //alert(dosages[i].name)
                                $("#dosage<%=visit.getVisitid()%>").append('<option value="Select">Select</option><option value="'+dosages[i].name+'">'+id+'</option>'); 
                            } 
                        } 
                    } 
                }); 
            }
           
</script>

</html>