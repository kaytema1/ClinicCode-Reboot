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
                var beds = document.getElementById("facility").value;
                //var ty = document.getElementById("beds").value;
                $.post('action/labaction.jsp', { action : "doctor", name : name, beds : beds}, function(data) {
                    // alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
                
            }
            
            function updateUnit(id,name,occ){
                
               
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
                
                var occupied = document.getElementById(occ).value;
                // var roledescription = document.getElementById("roledescription").value;
              
                // alert(uname);
                $.post('action/labaction.jsp', { action : "doctoredit", uname : uname, uid : uid,occupied : occupied}, function(data) {
                    // alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                //alert(id)
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/labaction.jsp', { action : "deletedoctor", id : id}, function(data) {
                        // alert(data);
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
                            <a href="#">Laboratory Setup</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Referring Doctors</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>
            <%if (session.getAttribute("lasterror") != null) {%>
                <div style="width: 100%" class="alert  <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                }%>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                
                <div class="row">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        // HMSHelper mgr = new HMSHelper();

                        List itmss = mgr.listDoctors();
                    %>     
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Referring Doctors</a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Doctor
                                    </a>

                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Doctor (Name)
                                        </th>

                                        <th>
                                            Facility
                                        </th>

                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            ReferringDoctors referringDoctors = (ReferringDoctors) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold;">
                                            <%=referringDoctors.getNameName()%>
                                        </td>
                                        <td>
                                            <%=referringDoctors.getFacility()%>
                                        </td>

                                        <td style="text-align: center;">
                                            <button class="btn btn-inverse" id="<%=referringDoctors.getId()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=referringDoctors.getId()%>_dialog" title="Editing <%=referringDoctors.getNameName()%>">
                                                <form class="form-horizontal" action="action/unitaction.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Doctor (Name) </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=referringDoctors.getId()%>" value="<%=referringDoctors.getNameName()%>">
                                                            <input type="hidden" name="uid" id="unitid_<%=referringDoctors.getId()%>" value="<%=referringDoctors.getId()%>">

                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Facility </label>
                                                        <div class="controls">
                                                            <input type="text" name="occ" id="occ_<%=referringDoctors.getId()%>" value="<%=referringDoctors.getFacility()%>">

                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>


                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("unitid_<%=referringDoctors.getId()%>","nameunit_<%=referringDoctors.getId()%>","occ_<%=referringDoctors.getId()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Doctor's Details
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td style="text-align: center;">
                                            <form style="padding: 0; margin: 0;" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=referringDoctors.getId()%>" value="<%=referringDoctors.getId()%>"/> 

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=referringDoctors.getId()%>");return false;'>
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
                <div style="display: none;" id="dialog" title="New Doctor">
                    <form class="form-horizontal" action="action/wardaction.jsp" method="post" onsubmit="return validateForm();" name="items" >

                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Doctor (Name)</label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Facility </label>
                                <div class="controls">
                                    <input type="text" name="facility" id="facility">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="form-actions">

                                <button class="btn btn-info"  onclick='submitform();return false;'>
                                    <i class="icon-plus-sign icon-white"> </i> Add Doctor
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
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });

    });
    
    
    
    function validateForm()
    {
        var x=document.forms["items"]["name"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
        
        var x=document.forms["items"]["beds"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
       
        return true;
    }

    function todaysdate()
    {
        var currentDate = new Date()
        var day = currentDate.getDate()
        var month = currentDate.getMonth() + 1
        var year = currentDate.getFullYear()
        var dat=(" " + year + "-" + month + "-" + day )
        //document.write(dat)
        // alert("Todays Date is "+dat)
        return dat; 
   
 
    }
</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        ReferringDoctors vst = (ReferringDoctors) itmss.get(i);
%>


<script type="text/javascript">
   
                      
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
      
        $("#<%=vst.getId()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getId()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getId()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>