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
    HMSHelper mgr = new HMSHelper();
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            /*   function submitform(){
                
                
                var name = document.getElementById("name").value;
                var type = document.getElementById("type").value;
                $.post('action/unitaction.jsp', { action : "units", name : name, type : type}, function(data) {
                    alert(data);
                    location.reload();
                    //$('#results').html(data).hide().slideDown('slow');
                } );
               
                
            }
             */
            function updateUnit(name,id){
             
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
               
                $.post('action/unitaction.jsp', { action : "edit", uname : uname, uid : uid}, function(data) {
                    //alert(data);
                    location.reload();
                    //$('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Unit");
                if (con ==true)
                {
                    $.post('action/unitaction.jsp', { action : "delete", id : id}, function(data) {
                        //alert(data);
                        location.reload();
                        //$('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Canceled!");
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
                            <a href="#">Unit Management</a><span class="divider"></span>
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
              
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                        }%>
                <div class="row">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();


                        List itmss = mgr.listUnits();




                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Units</a>
                                </li>
                                <li class="pull-right">
                                    <a  href="#" class="dialog_link btn ">

                                        <i class="icon-plus-sign"></i> New Unit
                                    </a>

                                </li>

                            </ul>

                            <table class="example display table">
                                <thead>
                                    <tr>
                                        <th <td style="text-align: left;">
                                            Unit Name 
                                            </th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Units unit = (Units) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold;">
                                            <%=unit.getUnitname()%>
                                        </td>

                                        <td style="text-align: right;">
                                            <button class="btn btn-inverse btn-small" id="<%=unit.getUnitid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=unit.getUnitid()%>_dialog" title="Editing <%=unit.getUnitname()%>">
                                                <form id="newunit<%=unit.getUnitid()%>" class="form-horizontal" action="action/unitaction.jsp" method="post" onsubmit="return validateForm();" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Unit Name: </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=unit.getUnitid()%>" value="<%=unit.getUnitname()%>">
                                                            <input type="hidden" name="uid" id="unitid_<%=unit.getUnitid()%>" value="<%=unit.getUnitid()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">

                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("nameunit_<%=unit.getUnitid()%>","unitid_<%=unit.getUnitid()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Unit 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td style="text-align: right;">
                                            <form style="padding: 0; margin: 0;" class="form-horizontal" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=unit.getUnitid()%>" value="<%=unit.getUnitid()%>"/> 

                                                <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=unit.getUnitid()%>");return false;'>
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
                <div style="display: none;" id="dialog" title="New Unit">
                    <form id="newunit" class="form-horizontal" action="action/unitaction.jsp" method="post"  name="items" >
                        <fieldset>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Unit Name: </label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Unit Type </label>
                                <div class="controls">
                                    <select class="input-medium" name="type" id="type">
                                        <option value="T">Select</option>
                                        <option value="lab">Diagnostics</option>
                                        <option value="pharmacy">Pharmacies</option>
                                        <option value="records">Records/Front Desk</option>
                                        <option value="vitals">Nurses Station</option>
                                        <option value="account">Account Offices</option>

                                    </select>
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="form-actions">

                                <button class="btn btn-info btn-small" type="submit" name="action" value="units">
                                    <i class="icon-check icon-white"> </i> New Unit 
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
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
        
       

    });
    
    $(document).ready(function(){
        
        
        $('#newunit').validate({
                            
            rules: {
                name: {
                    required: true,
                    minlength : 2
                                    
                },
                type: {
                    required: true,
                    minlength : 2
                    
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
        Units vst = (Units) itmss.get(i);
%>


<script type="text/javascript">
   
   
   
   $(document).ready(function(){
        
        $('#newunit<%= vst.getUnitid()%>').validate({
                            
            rules: {
                uname: {
                    required: true,
                    minlength : 2
                                    
                },
                uid: {
                    required: true,
                    minlength : 2
                    
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
                      
    $("#<%= vst.getUnitid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        
        modal :true

    });
    
    $("#<%= vst.getUnitid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getUnitid()%>_link").click(function(){
      
        $("#<%=vst.getUnitid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getUnitid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getUnitid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>