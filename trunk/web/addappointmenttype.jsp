

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">


        <%

            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            HMSHelper mgr = new HMSHelper();
            boolean appointmentTypesFound = false;
        %>
        <%@include file="widgets/stylesheets.jsp" %>

        <script type="text/javascript">
            /*
           
           function submitform(){
                
                
                    var name = document.getElementById("name").value;
                    $.post('action/labtypeaction.jsp', { action : "units", name : name}, function(data) {
                        alert(data);
                        location.reload();
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                
                 
                
            }
            
            function updateUnit(name,id){
             
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
               
                $.post('action/appointmenttypeaction.jsp', { action : "edit", uname : uname, uid : uid}, function(data) {
                    alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                if (con ==true)
                {
                    $.post('action/labtypeaction.jsp', { action : "delete", id : id}, function(data) {
                        alert(data);
                        location.reload();
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancelled!");
                    //return;
                }
                 
                
            }
            
             */
        </script>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <%if (session.getAttribute("lasterror") != null) {%>
            <div style="width: 100%" class="alert  <%=session.getAttribute("class")%> center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">New Appointment Type</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();



                        List appointmentTypes = mgr.listAppointmentTypes();

                        if (!appointmentTypes.isEmpty()) {
                            appointmentTypesFound = true;
                        }


                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail  content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <h4>Appointment Type</h4>

                                </li>
                                <li class="pull-right">
                                    <a id="new_link" href="#" class="btn btn-info">
                                        <i class="icon-white icon-plus-sign"> </i> New Appointment Type
                                    </a>
                                </li>

                            </ul>

                            <table class="example">
                                <thead>
                                    <tr>

                                        <th>
                                            Appointment Type
                                        </th>
                                        <th>
                                            Description
                                        </th>
                                        <th>

                                        </th>

                                        <th>

                                        </th>
                                    </tr>
                                </thead>
                                <tbody>


                                    <%
                                        int appointmentTypeId = 0;
                                        AppointmentType appointmentType;

                                        for (int p = 0; p < appointmentTypes.size(); p++) {
                                            appointmentType = (AppointmentType) appointmentTypes.get(p);
                                            appointmentTypeId = appointmentType.getId();
                                    %>
                                    <tr>


                                        <td>
                                            <%=appointmentType.getName()%>
                                        </td>

                                        <td>
                                            <%=appointmentType.getDescription()%>
                                        </td>

                                        <td style="padding: 0px; margin: 0px;">
                                            <button id="<%=appointmentTypeId%>_link" type="button" class="btn btn-inverse btn-small">
                                                <i class="icon-edit icon-white"> </i>  Edit 
                                            </button> 

                                            <div id="<%=appointmentTypeId%>_dialog" style="display: none;" title="Edit Appointment Type" id="new">
                                                <form id="editappointment<%=appointmentTypeId%>" class="form-horizontal" action="action/appointmenttypeaction.jsp" method="post" onsubmit="return validateForm();" name="items" >

                                                    <fieldset>

                                                        <div class="control-group">
                                                            <label class="control-label" for="input01"> Appointment Type: </label>
                                                            <div class="controls">
                                                                <input type="text" name="uname" value="<%=appointmentType.getName()%>" id="appointment_type">
                                                                <p class="help-block"></p>
                                                            </div>
                                                        </div>

                                                        <div class="control-group">
                                                            <label class="control-label" for="address">Description</label>
                                                            <div class="controls">
                                                                <textarea type="text" value="<%=appointmentType.getDescription()%>" name="udescription" id="description"><%=appointmentType.getDescription()%></textarea>

                                                            </div>
                                                        </div>

                                                    </fieldset>
                                                    <div class="form-actions">
                                                        <input type="hidden" name="uid" value="<%=appointmentTypeId%>" >
                                                        <button class="btn btn-small btn-info" type="submit" name="action" value="edit">
                                                            <i class="icon-check icon-white"> </i> Save Appointment Type 
                                                        </button>

                                                    </div>
                                                </form>
                                            </div>
                                        </td>

                                        <td style="padding: 0px; margin: 0px;">
                                            <form style="padding: 0px; margin: 0px;" action="action/appointmenttypeaction.jsp" method="post">
                                                <input type="hidden" name="id" id="id_<%=appointmentType.getId()%>" value="<%=appointmentType.getId()%>"/> 

                                                <button class="btn btn-danger btn-small" type="submit" name="action" value="delete" >
                                                    <i class="icon-remove icon-white"> </i> Delete  
                                                </button>
                                            </form>
                                        </td>

                                        <%
                                            }
                                        %>
                                </tbody>
                                <tr>
                            </table>
                            <div title="New Appointment Type" id="new">
                                <form id="new_appointment" class="form-horizontal" action="action/appointmenttypeaction.jsp" method="post"  name="items" >

                                    <fieldset>

                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Appointment Type: </label>
                                            <div class="controls">
                                                <input type="text" name="name" id="appointment_type">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label" for="address">Description</label>
                                            <div class="controls">
                                                <textarea type="text" name="desc" id="description"></textarea>

                                            </div>
                                        </div>

                                    </fieldset>
                                    <div class="form-actions">

                                        <button class="btn btn-small btn-info" type="submit" name="action" value="apType" onclick='submitform();return false;'>
                                            <i class="icon-check icon-white"> </i> Save Appointment Type 
                                        </button>

                                    </div>
                                </form>
                            </div>


                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>


            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    

    </div>
</div>
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

<script type="text/javascript" src="js/tablecloth.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/demo.js"></script>

<!--initiate accordion-->
<script type="text/javascript">
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();

        $(".menu").fadeIn();
        $(".content1").fadeIn();
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
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
        
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sScrollY" : "350px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 15,
            "aaSorting" : [],
            "bSort" : true

        });
        
        
        $('#new_appointment').validate({
            rules: {
                name: {
                    minlength: 2,
                    required: true
                },
                description: {
                    minlength: 2,
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
        });

    });
    
    
    
</script>
<% for (int i = 0;
            i < appointmentTypes.size();
            i++) {
        AppointmentType vst = (AppointmentType) appointmentTypes.get(i);
%>


<script type="text/javascript">
    
    

   
    $(document).ready(function(){ 
    
        $("#new_link").click(function(){
      
            $("#new").dialog('open');
    
        })
    
        $("#new").dialog({
            autoOpen : false,
            width : 600,
            modal :true

        });
    
        $('#editappointment<%= vst.getId()%>').validate({
            rules: {
                uname: {
                    minlength: 2,
                    required: true
                },
                udescription: {
                    minlength: 2,
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
        });    
    
    });
    $("#<%= vst.getId()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getId()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getId()%>_link").click(function(){
      
        $("#<%= vst.getId()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getId()%>_adddrug_link").click(function(){
        alert("");
        $("#<%= vst.getId()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>
<script type="text/javascript">
    
    $(document).ready(function(){
        
        
        
    
</script>
</body>
</html>