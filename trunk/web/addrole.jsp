<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*"%>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    HMSHelper mgr = new HMSHelper();%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

        <script type="text/javascript">
            function submitform(){
                var rolename = document.getElementById("rolename").value;
                var roledescription = document.getElementById("roledescription").value;
                $.post('action/roleaction.jsp', { action : "addrole", rolename : rolename, roledescription : roledescription}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function updateUnit(id,id1,id2){
                var uname = document.getElementById(id).value;
                var desc = document.getElementById(id1).value;
                var uid = document.getElementById(id2).value;
                // alert(uid);
                $.post('action/roleaction.jsp', { action : "editrole", uname : uname, desc : desc, uid : uid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(dd){
                var id = document.getElementById(dd).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Staff");
                if (con ==true)
                {
                    $.post('action/roleaction.jsp', { action : "delete", id : id}, function(data) {
                        alert(data);
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Canceled!");
                    //return;
                }
                 
                
            }
            
            function addpermission(name){
                var perms = document.getElementsByName(name);
                for(var i = 0; i<perms.length;i++){
                    alert("here"+perms[i].value);
                }
                 
            }
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
                            <a href="#">Role Management</a><span class="divider"></span>
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
                        List itmss = mgr.listRoles();
                    %> 

                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Roles</a>
                                </li>
                                <li class="pull-right">
                                    <a class="dialog_link btn"> 
                                        <i class="icon-plus-sign"></i> New Role</a>
                                </li>

                            </ul>

                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Role 
                                        </th>
                                        <th>Description
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (itmss != null) {
                                            for (int i = 0; i < itmss.size(); i++) {
                                                Roletable rol = (Roletable) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold; width: 250px;">
                                            <%=rol.getRolename()%>
                                        </td>
                                        <td style="width: 350px;">
                                            <%=rol.getRoledescription()%>
                                        </td>

                                        <td>
                                            <button class="btn btn-inverse " id="<%=rol.getRoleid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=rol.getRoleid()%>_dialog" title="Editing <%=rol.getRolename()%>">
                                                <form class="form-horizontal" action="action/roleaction.jsp" method="post" onsubmit="return validateForm();" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Role Name </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=rol.getRoleid()%>" value="<%=rol.getRolename()%> ">
                                                            <input type="hidden" name="uid" id="unitid_<%=rol.getRoleid()%>" value="<%=rol.getRoleid()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Role Description </label>
                                                        <div class="controls">
                                                            <textarea type="text" name="desc" id="name_<%=rol.getRoleid()%>" value="<%=rol.getRoledescription()%>"><%=rol.getRoledescription()%></textarea>
                                                            <input type="hidden" name="uid" id="unitid_<%=rol.getRoleid()%>" value="<%=rol.getRoleid()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="edit" >
                                                            <i class="icon-edit icon-white"> </i> Update Role 
                                                        </button>
                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td>
                                            <form style="padding: 0px;margin:  0px;" class="form-horizontal" action="" method="post">
                                                <input type="hidden" id="id_<%=rol.getRoleid()%>" value="<%=rol.getRoleid()%>"/> 

                                                <button class="btn btn-danger" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=rol.getRoleid()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete  
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>





                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

                <div style="display: none;" id="dialog" title="New Role">
                    <form class="form-horizontal" method="post" action="saveType.jsp">

                        <div class="control-group">
                            <label class="control-label" for="input01">Role Name :</label>
                            <div class="controls">
                                <input type="text" name="rolename" id="rolename">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Role Description :</label>
                            <div class="controls">
                                <textarea name="roledescription" id="roledescription"></textarea>
                            </div>
                        </div>

                        <div class="form-actions">

                            <button class="btn btn-info" type="submit" onclick="submitform();return false;">
                                <i class="icon-plus-sign icon-white"> </i> New Role 
                            </button>

                        </div>


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
        /* var x=document.forms["edit"]["uname"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }*/
        
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
        Roletable vst = (Roletable) itmss.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getRoleid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getRoleid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getRoleid()%>_dialog_permission").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
   
    
    $("#<%= vst.getRoleid()%>_link").click(function(){
      
        $("#<%= vst.getRoleid()%>_dialog").dialog('open');
    
    })
    
    
    $("#<%= vst.getRoleid()%>_permission").click(function(){
      
        $("#<%= vst.getRoleid()%>_dialog_permission").dialog('open');
    
    })
  
    
    $("#<%= vst.getRoleid()%>_adddrug_link").click(function(){
  
        $("#<%= vst.getRoleid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>