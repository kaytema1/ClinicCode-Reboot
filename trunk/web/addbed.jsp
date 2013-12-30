<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                
                var name = document.getElementById("name").value;
                var beds = document.getElementById("beds").value;
                //var ty = document.getElementById("beds").value;
                $.post('action/wardaction.jsp', { action : "beds", name : name, beds : beds}, function(data) {
                    alert(data);
                    location.reload();
                        
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
                
            }
            
            function updateUnit(name,id,bed,occ){
                
               
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
                var beds = document.getElementById(bed).value;
                var occupied = document.getElementById(occ).value;
                // var roledescription = document.getElementById("roledescription").value;
              
                // alert(uname);
                $.post('action/wardaction.jsp', { action : "editbed", uname : uname, uid : uid, beds : beds, occupied : occupied}, function(data) {
                    //alert(data);
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
                    $.post('action/wardaction.jsp', { action : "deletebed", id : id}, function(data) {
                        //alert(data);
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
        </script>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Bed Management</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <%if (session.getAttribute("lasterror") != null) {%>
                
                <div style="width: 100%" class="alert  <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>


                <%session.removeAttribute("lasterror");
                }%>
                <div class="row">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        // HMSHelper mgr = new HMSHelper();

                        List itmss = mgr.listBed();




                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Beds</a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Bed
                                    </a>

                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Description (Name)
                                        </th>

                                        <th>
                                            Room or Ward
                                        </th>
                                        <th>
                                            Status
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Bed bed = (Bed) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold;">
                                            <%=bed.getDescription()%>
                                        </td>
                                        <td>
                                            <% String str = bed.getWardOrRoom();
                                                int code = Integer.parseInt(str.split("_")[1]);
                                                if (str.split("_")[0].equals("room")) {%>
                                            <%=mgr.getRoom(code) == null ? "" : mgr.getRoom(code).getDescription()%>

                                            <% }
                                                if (str.split("_")[0].equals("ward")) {%>
                                            <%=mgr.getWardById(code) == null ? "" : mgr.getWardById(code).getWardname()%>

                                            <%}
                                            %>
                                        </td>
                                        <td> <%=bed.isOccuppied() == Boolean.FALSE ? "<label class='label label-success center'>Free </label>" : "<label class='label label-important center'>Occupied </label>"%></td>
                                        <td style="text-align: center;">
                                            <button class="btn btn-inverse" id="<%=bed.getBedid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=bed.getBedid()%>_dialog" title="Editing <%=bed.getDescription()%>">
                                                <form id="editbed<%=bed.getBedid()%>" class="form-horizontal" action="action/wardaction.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Bed Description </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=bed.getBedid()%>" value="<%=bed.getDescription()%>">
                                                            <input type="hidden" name="uid" id="unitid_<%=bed.getBedid()%>" value="<%=bed.getBedid()%>">

                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Room or Ward: </label>
                                                        <div class="controls">
                                                            <select name="wardRoom" id="ubeds<%=bed.getBedid()%>">
                                                                <option value="">Select Room or Ward</option>
                                                                <optgroup label="Rooms">
                                                                    <%
                                                                        List rooms = mgr.listRoom();
                                                                        for (int c = 0; c < rooms.size(); c++) {
                                                                            Room room = (Room) rooms.get(c);

                                                                    %>
                                                                    Rooms
                                                                    <% if (bed.getWardOrRoom().equalsIgnoreCase("room_" + room.getRoomid())) {%>
                                                                    <option selected="selected" value="room_<%=room.getRoomid()%>"><%=room.getDescription()%></option>
                                                                    <% } else {%>
                                                                    <option value="room_<%=room.getRoomid()%>"><%=room.getDescription()%></option>

                                                                    <% }
                                                                        }%>
                                                                </optgroup>
                                                                <optgroup label="Wards">

                                                                    <%    List wards = mgr.listWard();
                                                                        for (int d = 0; d < wards.size(); d++) {
                                                                            Ward ward = (Ward) wards.get(d);

                                                                    %>
                                                                    Wards
                                                                    <% if (bed.getWardOrRoom().equalsIgnoreCase("ward_" + ward.getWardid())) {%>

                                                                    <option selected="selected" value="ward_<%=ward.getWardid()%>"><%=ward.getWardname()%></option>
                                                                    <% } else {%>
                                                                    <option  value="ward_<%=ward.getWardid()%>"><%=ward.getWardname()%></option>

                                                                    <% }
                                                                        }%>
                                                                </optgroup>
                                                            </select>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <!--   <div class="control-group">
                                                           <label class="control-label" for="input01"> Status: </label>
                                                           <div class="controls">
                                                    <% if (bed.isOccuppied() == true) {%>
                                                    Occupied <input type="checkbox"  name="occ"  checked="checked" id="occ_<%=bed.getBedid()%>" />


                                                    <%} else {%>
                                                    Occupied <input type="checkbox"  name="occ"  id="occ_<%=bed.getBedid()%>" />

                                                    <% }%>
                                                    <p class="help-block"></p>
                                                </div>
                                            </div>
                                         
                                                    -->

                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="editbed" >
                                                            <i class="icon-edit icon-white"> </i> Update Bed 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td style="text-align: center;">
                                            <form style="padding: 0; margin: 0;" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=bed.getBedid()%>" value="<%=bed.getBedid()%>"/> 

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=bed.getBedid()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete  
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>



                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>
                <div style="display: none;" id="dialog" title="New Bed">
                    <form id="addbed" class="form-horizontal" action="action/wardaction.jsp" method="post"  name="items" >

                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Bed Description: </label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Ward or Room</label>
                                <div class="controls">
                                    <select name="beds" id="beds">
                                        <option value="">Select Room or Ward</option>
                                        <optgroup label="Rooms">
                                            <%
                                                List roomslist = mgr.listRoom();
                                                for (int e = 0; e < roomslist.size(); e++) {
                                                    Room room = (Room) roomslist.get(e);

                                            %>

                                            <option value="room_<%=room.getRoomid()%>"><%=room.getDescription()%></option>

                                            <%}%>
                                        </optgroup>
                                        <optgroup label="Wards">
                                            <%
                                                List wardlists = mgr.listWard();
                                                for (int f = 0; f < wardlists.size(); f++) {
                                                    Ward ward = (Ward) wardlists.get(f);

                                            %>

                                            <option value="ward_<%=ward.getWardid()%>"><%=ward.getWardname()%></option>
                                            <%}%> 
                                        </optgroup>


                                    </select>
                                    <p class="help-block"></p>
                                </div>
                            </div>


                            <div class="form-actions">

                                <button class="btn btn-info" type="submit" name="action" value="addbed" >
                                    <i class="icon-plus-sign icon-white"> </i> Add Bed
                                </button>

                            </div>
                        </fieldset>
                    </form>
                </div>

            </section>

            <footer style="display: none; margin-top: 50px;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

        </div><!-- /container -->    

    </div>
</div>
<!--end static dialog-->

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

    });
    
    
    $(document).ready(function(){
        
        
        $('#addbed').validate({
                            
            rules: {
                name: {
                    required: true,
                    minlength : 2
                                    
                },
                wardRoom: {
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
        
        
    })
    
</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        Bed vst = (Bed) itmss.get(i);
%>


<script type="text/javascript">
   
    $(document).ready(function(){
        
        
        $('#editbed<%= vst.getBedid()%>').validate({
                            
            rules: {
                uname: {
                    required: true,
                    minlength : 2
                                    
                },
                
                wardRoom: {
                    required: true
                    
                }
                ,
                occ: {
                    required: false
                    
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
        
        
    })
    
    $("#<%= vst.getBedid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getBedid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getBedid()%>_link").click(function(){
      
        $("#<%=vst.getBedid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getBedid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getBedid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>