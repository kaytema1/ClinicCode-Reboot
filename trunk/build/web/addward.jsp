<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
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
    DecimalFormat df = new DecimalFormat();

    df.setMinimumFractionDigits(2);
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                
                var name = document.getElementById("name").value;
                var beds = document.getElementById("beds").value;
                //var ty = document.getElementById("beds").value;
                $.post('action/wardaction.jsp', { action : "wards", name : name, beds : beds}, function(data) {
                    //alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
                
            }
            
            function updateUnit(name,cost){
                
               
                var uname = document.getElementById(name).value;
                //var uid = document.getElementById(id).value;
                //var beds = document.getElementById(bed).value;
                //var occupied = document.getElementById(occ).value;
                var cost = document.getElementById(cost).value;
                // var roledescription = document.getElementById("roledescription").value;
              
                // alert(uname);
                $.post('action/wardaction.jsp', { action : "editward", uname : uname, cost : cost}, function(data) {
                    //alert(data);
                    location.reload();
                    //$('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/wardaction.jsp', { action : "delete", id : id}, function(data) {
                        //alert(data);
                        location.reload();
                        //$('#results').html(data).hide().slideDown('slow');
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
                            <a href="#">Ward Management</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
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

                        // HMSHelper mgr = new HMSHelper();

                        List itmss = mgr.listWard();




                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Wards</a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Ward
                                    </a>

                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Ward Name 
                                        </th>
                                        <th>
                                            Number of Beds 
                                        </th>
                                        <th>
                                            Beds Available
                                        </th>
                                        <th>
                                            Bed Cost(GH&#162;)
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Ward unit = (Ward) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=unit.getWardname()%>
                                        </td>
                                        <td style="text-align: right">
                                            <%=unit.getNumberofbeds()%>
                                        </td>
                                        <td style="text-align: right">
                                            <%=(unit.getNumberofbeds() - unit.getOccupied())%>
                                        </td>

                                        <td style="text-align: right; padding-right: 10px; ">
                                            <%=df.format(unit.getCost())%>
                                        </td>
                                        <td style="text-align: center;">
                                            <button class="btn btn-inverse" id="<%=unit.getWardid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=unit.getWardid()%>_dialog" title="Editing <%=unit.getWardname()%>">
                                                <form id="newward<%=unit.getWardid()%>" class="form-horizontal" action="action/wardaction.jsp" method="post">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Ward Name: </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=unit.getWardid()%>" value="<%=unit.getWardname()%>">
                                                            <input type="hidden" name="uid" id="unitid_<%=unit.getWardid()%>" value="<%=unit.getWardid()%>">

                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Ward Cost: </label>
                                                        <div class="controls">
                                                            <input type="text" name="cost" class="input-mini" id="cost_<%=unit.getWardid()%>" value="<%=df.format(unit.getCost())%>" />
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="editward" onclick='updateUnit("nameunit_<%=unit.getWardid()%>","cost_<%=unit.getCost()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Unit 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td style="text-align: center;">
                                            <form style="padding: 0px; margin: 0px;" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=unit.getWardid()%>" value="<%=unit.getWardid()%>"/> 

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=unit.getWardid()%>");return false;'>
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
                <div style="display: none;" id="dialog" title="New Ward">
                    <form id="newward" class="form-horizontal" action="action/wardaction.jsp" method="post"  name="items" >

                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Ward Name: </label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">  Ward Costs: </label>
                                <div class="controls">
                                    <p class="help-inline"> GH&#162; </p> 
                                    <input class="input-small" type="text" name="beds" id="beds">
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="form-actions">

                                <button type="submit" name="action" value="addward"  class="btn btn-info">
                                    <i class="icon-plus-sign icon-white"> </i> Add Ward 
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
        
        
        $('#newward').validate({
                            
            rules: {
                name: {
                    required: true,
                    minlength : 2
                                    
                },
                beds: {
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
        Ward vst = (Ward) itmss.get(i);
%>


<script type="text/javascript">
   
    $(document).ready(function(){
        
        
        $('#newward<%= vst.getWardid()%>').validate({
                            
            rules: {
                uname: {
                    required: true,
                    minlength : 2
                                    
                },
                cost: {
                    required: true,
                    minlength : 1
                    
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
    
    $("#<%= vst.getWardid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getWardid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getWardid()%>_link").click(function(){
      
        $("#<%=vst.getWardid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getWardid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getWardid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>