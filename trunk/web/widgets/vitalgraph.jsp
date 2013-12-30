<%@page import="entities.VisitSymptoms"%>
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

<script type="text/javascript">
    
    $(function() {
        temps = [];
        diatolics = [];
        systolics = [];
        pulses = [];
        dt = [];
        times = [];
    <%if (visits.size() > 0) {
            List ls = mgr.listVitalCheckByVisitid(visit.getVisitid());
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
        }
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
     
        });
    
    
        $(function () {
            var chart;
            $(document).ready(function() {
                chart = new Highcharts.Chart({
                    chart: {
                        renderTo: 'chart',
                        type: 'line',
                        marginRight: 130,
                        marginBottom: 25
                    },
                    title: {
                        text: '<%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%> \'s Temperature Chart',
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
            });
    
        });
    
        $(function () {
            var chart;
            $(document).ready(function() {
                chart = new Highcharts.Chart({
                    chart: {
                        renderTo: 'chart1',
                        type: 'line',
                        marginRight: 130,
                        marginBottom: 25
                    },
                    title: {
                        text: '<%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%> \'s Blood Pressure & Pulse Chart'  ,
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
       	
           
</script>