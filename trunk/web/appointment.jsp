<%-- 
    Document   : index
    Created on : Jul 17, 2012, 5:08:57 PM
    Author     : lisandro
--%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="entities.*"%>
<%@page import="java.util.List"%>
<%@page import="entities.HMSHelper"%>
<%@page import="helper.HibernateUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }%>
<html>
    <%
        HMSHelper mgr = new HMSHelper();
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        HMSHelper itm = new HMSHelper();

        List itmss = itm.listAppointment();
        String patientId = request.getParameter("patientId");

    %>
    <head>

        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta charset="utf-8"/>
        <title>ClaimSync EMR</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="description" content=""/>
        <meta name="author" content=""/>

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
        <link href="css/bootstrap-responsive.css" rel="stylesheet"/>
        <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <link href="css/docs.css" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styles.css"/>
        <link rel="stylesheet" href="css/switch.css"/>
        <style type="text/css" title="currentStyle">
            @import "css/jquery.dataTables_themeroller.css";
            @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
            body{
                overflow: hidden; 
            }
        </style>



        <link rel='stylesheet' type='text/css' href='fullcalendar/fullcalendar.css' />
        <link rel='stylesheet' type='text/css' href='fullcalendar/fullcalendar.print.css' media='print' />



    </head>   
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead " id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide ">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="records.jsp">Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Appointments</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>



            <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->

                <%@include file="widgets/loading.jsp" %>

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert  <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>



                <div class="row-fluid">


                    <%@include file="widgets/leftsidebar.jsp" %>


                    <div class="hide span8" id='calendar'>

                    </div>
                    <div class="hide" id="dialog">
                        <form id="saveAppointment" class="form-horizontal" action="action/saveAppointment.jsp" name="mainForm" onkeyup="ddd();">

                            <div class="control-group">
                                <label class="control-label" for="inputPassword">Patient ID</label>
                                <div class="controls">
                                    <% if (patientId != null) {%>
                                    <input id="patientId" style="text-transform: uppercase; color: #418692;"  type="text" name="patientId" value="<%=patientId%>"  />
                                    <% } else {%>
                                    <input id="patientId" style="text-transform: uppercase; color: #418692;"  type="text" name="patientId" placeholder="Please Enter Folder ID"   />
                                    <% }%>

                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="inputPassword">Appointment Type</label>
                                <div class="controls">
                                    <select  name="title" id="titleId">
                                        <option value="">Select</option>
                                        <%
                                            List types = mgr.listAppointmentTypes();
                                            for (int j = 0; j < types.size(); j++) {
                                                AppointmentType apType = (AppointmentType) types.get(j);
                                        %>
                                        <option style="text-transform: capitalize;" value="<%=apType.getId()%>"><%=apType.getName()%></option> 
                                        <% }%>
                                    </select>
                                </div>

                            </div>
                            <!--  <div class="control-group">
                                  <label class="control-label" for="inputEmail">Purpose of Appointment</label>
                                  <div class="controls">
                                      <input type="text" name="title" id="titleId"/>
                                  </div>
                              </div>  -->


                            <!--   <div class="control-group">
                                   <label class="control-label" for="inputPassword">Enter Doctor Id</label>
                                   <div class="controls">
                                       <input type="text" name="doctorId" id="doctorId"/>
                                   </div>
                               </div> -->
                            <input type="hidden" name="doctorId" id="doctorId" value="D1"/>
                            <!--                <div class="control-group">
                                               <label class="control-label" for="inputPassword">Enter Patient Id</label>
                                               <div class="controls">
                                                   <input type="text" name="patientId" id="patientId"/>
                                               </div>
                                           </div>
                            -->

                            <div class="control-group">
                                <label class="control-label" for="inputPassword">Appointment Detail</label>
                                <div class="controls">
                                    <textarea  name="content" id="content"></textarea>
                                </div>
                                <input type="hidden" name="start" id="startId"/>
                                <input type="hidden" name="end" id="endId"/>
                                <input type="hidden" name="allday" id="allDayId"/>
                            </div>
                            <div class="form-actions">
                                <div class="controls">

                                    <button type="submit" id="saveEvent" class="btn btn-info btn-large">Save </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="hide">
                        <form method="post" action="action/updatetitle.jsp" name="updateTitle">
                            <input type="text" name="newtitle" id="titleId4"/>
                            <input type="text" name="start" id="startId4"/>
                        </form>
                    </div>
                    <div class="hide">
                        <form method="post" action="action/honored.jsp" name="deleteForm">

                            <input type="hidden" name="title" id="titleId2"/>
                            <input type="hidden" name="id" id="eventdelete"/>

                        </form>
                    </div>
                    <div class="hide">
                        <form method="post" id="update" action="action/update.jsp" name="update">
                            <input type="hidden" name="id" id="eventId"/>

                            <input type="hidden" name="title" id="titleId1"/>

                            <input type="hidden" name="start" id="startId1"/>

                            <input type="hidden" name="end" id="endId1"/>

                            <input type="hidden" name="allday" id="allDayId1"/>
                        </form>
                    </div>
                    <div>
                        <form action="action/honored.jsp" name="honored">
                            <input type="hidden" name="id" id="id"/>
                        </form>
                    </div>


                    <div id="edit-confirm" title="Edit Options" align="center"  class="hide center">
                        <h3> What would you like to do? </h3>
                        <div style="margin-left: 20px; margin-top: 50px;" class="btn-group center">
                            <button id="cancelevent" class="btn btn-danger">
                                <i class="icon icon-white icon-remove"> </i>
                                Cancel
                            </button>
                            <button id="updateevent" class="btn "> 
                                <i class="icon  icon-edit"> </i> Update
                            </button>
                            <button id="honorevent" class="btn btn-success">
                                <i class="icon icon-white icon-check"> </i>
                                Honor
                            </button>
                        </div>

                    </div>

                </div>  


            </section>

            <%@include file="widgets/footer.jsp" %>
        </div>Ï
        <!-- /container -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltip.js"></script>
        <script src="js/bootstrap-popover.js"></script>
        <script src="js/application.js"></script>
        <script src="js/jquery.validate.min.js"></script>


        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

        <script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

        <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
        <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

        <!--  <script type="text/javascript" src="js/tablecloth.js"></script>  -->
        <script type="text/javascript" src="js/demo.js"></script>

        <script type='text/javascript' src='fullcalendar/fullcalendar.min.js'></script>
    </body>


    <script type='text/javascript'>

   

        $(document).ready(function() {
            var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
            
            //  alert("<%= session.getAttribute("appointmentPatientID")%>")
            //  var patientId = "<%= session.getAttribute("appointmentPatientID")%>"
            //`  $("#patientId").attr("value", patientId);
            
            //menu_ul.hide();

            $(".menu").fadeIn();
            $(".content1").fadeIn();
            $(".navbar").fadeIn();
            $(".footer").fadeIn();
            $(".subnav").fadeIn();
            $(".alert").fadeIn();
            $(".progress1").hide();
            $("#calendar").fadeIn();
                
                
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
            
            
                
            $("#dialog").dialog({
                autoOpen: false,
                title: "Schedule Appointment",
                width: "500",
                height: "400"
                    
            })
            
            
            $('#saveAppointment').validate({
                            
                rules: {
                    patientId: {
                        required: true
                                    
                    },
                    title: {
                        required: true
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
            })
                           
            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();
		
            var calendar = $('#calendar').fullCalendar({
                defaultView: 'agendaDay',
                theme: true,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'agendaDay,agendaWeek,month'
                        
                    //month ,agendaDay
                },
                droppable:true,
                selectable: true,
                selectHelper: true,
                firstDay: 1,
                height: 550,
                allDayText   : "All Day",
                axisFormat : 'h:mm tt',
                defaultEventMinutes: '30',
                firstHour: 7,
                agenda: 'h:mm { - h:mm }tt',
                buttonText : {
                    prev:     '&nbsp;&#9668;&nbsp;',  // left triangle
                    next:     '&nbsp;&#9658;&nbsp;',  // right triangle
                    prevYear: '&nbsp;&lt;&lt;&nbsp;', 
                    nextYear: '&nbsp;&gt;&gt;&nbsp;', 
                    today:    'Today',
                    month:    'Month',
                    week:     'Week',
                    day:      'Day'
                },
              
                eventBackgroundColor : "#35AFE3",
                eventTextColor: "#EEE",
                
               
                     
                           
                select: function(start, end, allDay, view) {
                    $("#dialog").dialog('open'); 
                    //   var title = prompt('Appointment Title');            
                    //   var doctorId1 = prompt('Doctor Id');
                    //  var patientId1 = prompt('Patient Id');
                    //  var content1 = prompt('Appointment Detail');  
                    
                     
                        
                    // var showform = document.getElementById("frm");
                    //showform.style.display='';
                    var title =  $("#titleId").attr("value");
                    var doctorId1 =   $("#doctorId").attr("value")
                    var patientId1 = $("#patientId").attr("value")
                    //alert(patientId1)
                    var content1 = $("#content").attr("value")
                    $("#startId").attr("value",start)
                    $("#allDayId").attr("value",allDay)
                    $("#endId").attr("value",end)
                    
                    var startId= document.getElementById('startId').value = start;
                    var endId= document.getElementById('endId').value = end;
                    var allDayId = document.getElementById('allDayId').value = allDay;
                    var titleId=document.getElementById('titleId').value = title;
                    var doctorId = document.getElementById('doctorId').value = doctorId1;
                    var patientId = document.getElementById('patientId').value = patientId1
                    var content = document.getElementById('content').value = content1;
                     
                    $("#saveEvent").click(function(){
                       
                    });  
                    calendar.fullCalendar('unselect');
                },
                editable: true,
                eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
                        
                    var startId1= document.getElementById('startId1').value = event.start;
                    var endId1= document.getElementById('endId1').value = event.end;
                    var allDayId1 = document.getElementById('allDayId1').value = event.allDay;
                    var titleId1=document.getElementById('titleId1').value = event.title;
                    
                    $("#startId1").attr("value",event.start);
                    $("#endId1").attr("value",event.end);
                    $("#allDayId1").attr("value",event.allDay);
                    $("#titleId1").attr("value",event.title);
                    $("#eventId").attr("value",event.id);
                    var submit = confirm("Do You Want To Save Changes?");
                    if (submit==true)
                    {   
                       
                        $("#update").submit();
                        
                            
                    }
                    else
                    {   //alert("Nay its not true");
                        return;
                    } 

                },
                eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) {
                        
                    var startId1= document.getElementById('startId1').value = event.start;
                    var endId1= document.getElementById('endId1').value = event.end;
                    var allDayId1 = document.getElementById('allDayId1').value = event.allDay;
                    var titleId1=document.getElementById('titleId1').value = event.title;
                    
                    $("#startId1").attr("value",event.start);
                    $("#endId1").attr("value",event.end);
                    $("#allDayId1").attr("value",event.allDay);
                    $("#titleId1").attr("value",event.title);
                    $("#eventId").attr("value",event.id);
        
                    var submit = confirm("Do You Want To Save Changes?");
                    if (submit==true)
                    {   
                        
                        $("#update").submit();
                        var f=document.update.submit();
                        // f.method="post";
                        //f.action='updateItems.jsp?id='+id;
                        //f.submit();
                    }
                    else
                    {
                        return;  
                    } 
                },
                eventClick: function(calEvent, jsEvent, view) {
                        
                    var  titleId2=document.getElementById('titleId2').value = calEvent.title;
                    // alert(calEvent.title);
                    
                    $( "#dialog:ui-dialog" ).dialog( "destroy" );
                        
                    $("#eventdelete").attr("value",calEvent.id);
                    $( "#edit-confirm" ).dialog({
                        //resizable: false,
                        //height:140,
                        modal: true,
                        buttons: {
                            
                        } 
                    });
                    
                    $("#cancelevent").click(function(){
                        var deleteForm = document.deleteForm.submit();
                    });
                    
                    $("#updateevent").click(function(){
                        
                        var newTitleId = prompt('Update Title',titleId2);
                        var newTitleId1=document.getElementById('titleId4').value = newTitleId;
                        var start4= document.getElementById('startId4').value = calEvent.start;
                        var updateForm = document.updateTitle.submit();
                    
                    });
                    
                    $("#honorevent").click(function(){
                        var id= document.getElementById('id').value = calEvent.id;
                        var updateHonred = document.honored.submit();
                    });
	
         
                },

                events: [
        <%      for (int i = 1; i < itmss.size(); i++) {


                Appoint itt = (Appoint) itmss.get(i);
                if (!itt.isHonored()) {
                    String title = itt.getTitle();
                    String start = itt.getStart();
                    String end = itt.getEnd();
                    String allDay = itt.getAllday();
                    String patient = itt.getPatientId();
                    String doctor = itt.getDoctorId();
                    int id = itt.getId();




                    System.out.print("Title " + title + " " + start);
                    System.out.print("___________________________" + itmss.size() + "____________________________________________________");
        %> 
                           
                       
                       
                        {
                             
                            title:'<%=title%> '+'<%=patient%> '+' <%=doctor%>',
                            start: new Date('<%=start%>'),
                            end: new Date('<%=end%>'),
                            id: "<%=id%> ",    
                            allDay: <%=allDay%>
                            
                    
                
                        },
        <% System.out.print("allDay " + allDay + "");%>
        <% }
            }%>
                            {
                            
                            }
   
                        ]
                        
                      
         
                    });
		
                });
           
    </script>

    <%session.removeAttribute("appointmentPatientID");%>



</html>
