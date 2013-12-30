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

    String visitString = request.getParameter("visitid");
    if (visitString.equalsIgnoreCase("")) {

        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("inpatients.jsp");
    }

    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    Visitationtable visit = null;

    visit = (Visitationtable) mgr.getVisitById(Integer.parseInt(visitString));
    HMSHelper itm = new HMSHelper();
    // List itmss = itm.listAppointment();
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <link rel='stylesheet' type='text/css' href='fullcalendar/fullcalendar.css' />
        <link rel='stylesheet' type='text/css' href='fullcalendar/fullcalendar.print.css' media='print' />
        <script type="text/javascript">
            
            
            function addVital(id,temp,systolic,diatolic,pulse){
                //  var id = document.getElementById(id).value;
                var temp = document.getElementById(temp).value;
                var systolic = document.getElementById(systolic).value;
                var diatolic = document.getElementById(diatolic).value;
                var pulse = document.getElementById(pulse).value;
              
                $.post('action/labnpharmactions.jsp', { action : "addvital", id : id, temp : temp, systolic : systolic, diatolic : diatolic, pulse : pulse}, function(data) {
                    $('#success').dialog('open');
                    $(".vitalinputs").attr("value","");
                    location.reload();
                } );
            }
            
        </script>
    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">
        <%@include file="widgets/header.jsp" %>
        <div class="container-fluid">
            <header class="jumbotron subhead" id="overview">
                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="#">Ward</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Nursing Care</a><span class="divider"></span>
                        </li>
                    </ul>
                </div>
            </header>

            <%@include file="widgets/loading.jsp" %>
            <section style="margin-top: -50px;" class="container-fluid" id="dashboard"> 
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <div class="row-fluid">
                    <%

                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                        SimpleDateFormat formatter1 = new SimpleDateFormat("EEEE, dd MMMM, yyyy");

                        List investigations = null;
                        List nhisinvestigations = null;
                        //List treatments = null;
                        List nhistreatments = null;
                        List dosages = null;
                        Date date = new Date();
                        Visitationtable visitObject = visit;
                        List patientHistory = mgr.patientHistory(visitObject.getPatientid());
                        List adminssionHistory = mgr.patientAdmissionHistory(visitObject.getPatientid());
                        List itmss = itm.listDosageMonitor(visitObject.getVisitid());




                    %>



                    <form action="action/admissionaction.jsp" method="post">
                        <div class="span3">
                            <ul class="menu">
                                <li> <a class="vital_link<%=visitObject.getPatientid()%> active"> <i class="icon icon-check"> </i> Vitals Signs </a></li>
                             <!--   <li> <a class="history_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-list-alt"> </i> History </a></li>
                                <li> <a class="physical_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-user"> </i> Examinations </a></li>
                                <li> <a class="laboratory_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-search"> </i> Laboratory </a></li>
                                <li> <a class="diagnosis_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-adjust"> </i> Diagnoses </a></li>  -->
                                <li> <a class="treatment_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-tasks"> </i> Treatment </a></li>
                               <!-- <li> <a class="previous_visit_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-file"> </i> Previous Visits </a></li>
                                <li> <a class="admission_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-folder-open"> </i> Admission Notes </a></li>
                                <li> <a class="summary_link<%=visitObject.getPatientid()%>"> <i class="icon  icon-folder-open"> </i> Summary </a></li>  -->

                            </ul>



                        </div>
                        <div class="span8">

                            <div style="display: block;"  class="thumbnail center vital<%=visitObject.getPatientid()%>">
                                <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                    <li>
                                        <a style="text-align: center;"> <b> Vitals </b></a>
                                    </li> 

                                    <li class="pull-right">
                                        <a style="margin-top: -4%"  href="#" class="treatment_link<%=visitObject.getPatientid()%> btn"> 
                                            <i class="icon-arrow-right"></i>   Treatment
                                        </a>
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
                                                <div id="chart<%=visitObject.getPatientid()%>" style="min-width: 920px; height: 400px; margin: 0 auto">

                                                </div>
                                            </div>
                                            <div id="tabs-1-2">
                                                <div id="chart1<%=visitObject.getPatientid()%>" style="min-width: 920px; height: 400px; margin: 0 auto">

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
                                        <table class="table-bordered table-striped">
                                            <thead>
                                                <tr>

                                                    <th style="text-align: center; font-size: 15px;" rowspan="2">
                                                        Temperature ( &#176; C)
                                                    </th>
                                                    <th style="text-align: center; font-size: 15px;" colspan="3">
                                                        Blood Pressure
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: center; font-size: 15px;">
                                                        Systolic (mm Hg)
                                                    </th>
                                                    <th style="text-align: center; font-size: 15px;">
                                                        Diastolic (mm Hg)
                                                    </th>
                                                    <th style="text-align: center; font-size: 15px;">
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
                                        <div class="form-actions">
                                            <button id="addCheckBoxes" style="width: 90%" class="btn btn-info btn-large" onclick='addVital("<%=visitObject.getVisitid()%>","temp_<%=visitObject.getVisitid()%>","systolic_<%=visitObject.getVisitid()%>","diatolic_<%=visitObject.getVisitid()%>","pulse_<%=visitObject.getVisitid()%>");return false;'>
                                                <i class="icon-white icon-plus-sign"> </i>   Add Vital
                                            </button>
                                        </div>


                                    </div>
                                </div>
                            </div>

                            <div  class="thumbnail center treatment<%=visitObject.getPatientid()%> hide">
                                <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                    <li class="pull-left">
                                        <a style="margin-top: -4%"  href="#" class="vital_link<%=visitObject.getPatientid()%> btn"> 
                                            <i class="icon-arrow-left"></i>  Vitals 
                                        </a>
                                    </li>

                                    <li>
                                        <a style="text-align: center;"> <b> Treatment </b></a>
                                    </li> 

                                    <li class="pull-right">
                                        <a style="margin-top: -4%"  href="#" class="completion_link<%=visitObject.getPatientid()%> btn"> 
                                            <i class="icon-arrow-right"></i>   Completed
                                        </a>
                                    </li>
                                </ul>
                            </div>


                            <div class="clearfix"></div>
                            <div style="padding-left: 0px; padding-right: 0px;" class="form-actions center completion<%=visitObject.getPatientid()%> hide   ">

                                <a   href="#" class="treatment_link<%=visitObject.getPatientid()%> btn pull-left"> 
                                    <i class="icon-arrow-left"></i>   Treatment
                                </a>

                                <input type="hidden" name="patientid" id="patientid" value="<%=visitObject.getPatientid()%>"/>
                                <input type="hidden" name="visitid" id="visitid" value="<%=visitObject.getVisitid()%>"/>
                                <input type="hidden" name="userid" id="userid" value="<%=user.getStaffid()%>"/>
                                <!--input type="hidden" name="bedid" id="bedid" value="<%%>"/-->
                                <input type="hidden" name="type" id="userid" value="<%=request.getParameter("type")%>"/>

                                <div class="center" style="width: 30%; margin-left: 45%; margin-bottom: 20px;">

                                    <div style="width: 100%">
                                        <label style="margin-top: 8px;" class="pull-left">Discharge</label>

                                        <label style="margin-right: 40%" class="switch-container pull-right">

                                            <input style="vertical-align: middle;" type="checkbox" checked="checked" name="admission" value="Discharge"style="width: 100px" class="switch-input checkValue hide"/>
                                            <div class="switch">
                                                <span class="switch-label">Yes</span>
                                                <span class="switch-label">No</span>
                                                <span class="switch-handle"></span>
                                            </div>  
                                        </label> 
                                    </div>
                                    <div class="clearfix">

                                    </div>
                                    <div style="width: 100%">
                                        <label style="margin-top: 8px;" class="pull-left">Refer</label>

                                        <label style="margin-right: 40%" class="switch-container pull-right">
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
                                    </div>
                                    <div class="clearfix">

                                    </div>
                                </div>
                                <button style="width: 80%" type="submit" name="action" value="NursesFoward" class="btn btn-danger btn-large">
                                    <i class="icon-white icon-arrow-right"> </i> Forward
                                </button>

                            </div>


                        </div>


                    </form>        


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


        <%

            // vs = mgr.currentVisitations(visit.getVisitid());

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
            $(".main-c").fadeIn();
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
            
            var chart = new Highcharts.Chart({
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
                    
        $("input:checkbox").attr("checked", false);
               
        $('#dialog<%=visitObject.getVisitid()%>').dialog({
            autoOpen : true,
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
            autoOpen : true,
            width : "95%",
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
            $(".completion<%=visitObject.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
        });
    
        $(".treatment_link<%=visitObject.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
            $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
            $(".completion<%=visitObject.getPatientid()%>").slideUp("slow");
            $(".treatment<%=visitObject.getPatientid()%>").slideDown("slow");
            
            
        });
        
        $(".completion_link<%=visitObject.getPatientid()%>").click(function(){
            $(".bar").addClass("btn-info")
            $(".bar").removeClass("btn-inverse")
            $(".vital<%=visitObject.getPatientid()%>").slideUp("slow");
            $(".completion<%=visitObject.getPatientid()%>").slideDown("slow");
            $(".treatment<%=visitObject.getPatientid()%>").slideUp("slow");
            
            
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


        <div class="clear"></div>

        <% }%>
        <%
        %>

    </body>
</html>
<div title="Success" class="center hide" id="success">
    <span class="lead center">Vital Saved Successfully</span>
</div>
