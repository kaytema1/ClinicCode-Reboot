<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    HMSHelper mgr = new HMSHelper();
    DecimalFormat df = new DecimalFormat();

    df.setMinimumFractionDigits(2);
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                
                var name = document.getElementById("name").value;
                var amount = document.getElementById("amount").value;
                $.post('action/conroomaction.jsp', { action : "concharges", name : name, amount : amount}, function(data) {
                    alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
                
            }
            
            function updateUnit(uname,uid,uamount){
                
                var uname = document.getElementById(uname).value;
                var uid = document.getElementById(uid).value;
                var uamount = document.getElementById(uamount).value;
                $.post('action/conroomaction.jsp', { action : "editcon", uname : uname, uid : uid, uamount : uamount}, function(data) {
                    alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
                
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
               
                var con = confirm("Are You Sure You Want Delete This Item");
                if (con ==true)
                {
                    $.post('action/conroomaction.jsp', { action : "deletecon", id : id}, function(data) {
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
        </script>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->


            <%if (session.getAttribute("lasterror") != null) {%>
            <br />
            <div style="width: 100%" class="alert  <%=session.getAttribute("class")%> center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <div style="margin-bottom: 10px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Consultation Type Management</a><span class="divider"></span>
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



                        List itmss = mgr.listConsultation();




                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Consultation Fees</a>
                                </li>
                                <li class="pull-right">

                                    <a href="#" class="dialog_link btn">

                                        <i class="icon-plus-sign"></i> New Consultation Fee
                                    </a>

                                </li>

                            </ul>

                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Type 
                                        </th>
                                        <th style="width: 80px;">
                                            Amount (GH&#162)
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Consultation unit = (Consultation) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold;">
                                            <%=unit.getContype()%>
                                        </td>
                                        <td style="width: 80px;">
                                            <%=df.format(unit.getAmount())%> 
                                        </td>

                                        <td style="text-align: center;">
                                            <button class="btn btn-small btn-inverse" id="<%=unit.getConid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=unit.getConid()%>_dialog" title="Editing <%=unit.getContype()%>">
                                                <form id="addconcharges<%=unit.getConid()%>" class="form-horizontal" action="action/conroomaction.jsp" method="post" onsubmit="return validateForm();" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Name: </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="uname_<%=unit.getConid()%>" value="<%=unit.getContype()%>">
                                                            <input type="hidden" name="uid" id="unitid_<%=unit.getConid()%>" value="<%=unit.getConid()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Amount </label>
                                                        <div class="controls">
                                                            
                                                            <p class="help-inline"> GH&#162 </p>
                                                            <input type="text" class="input-small" name="uamount" id="uamount_<%=unit.getConid()%>" value="<%=df.format(unit.getAmount())%>">

                                                            
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">

                                                        <button class="btn btn-inverse" type="submit" name="action" value="editcon">
                                                            <i class="icon-edit icon-white"> </i> Update Charges 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td style="text-align: center;">
                                            <form class="form-horizontal" style="padding-top: 15px; padding: 0px; margin: 0px;" action="action/conroomaction.jsp" method="post">

                                                <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=unit.getConid()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete  
                                                </button>
                                                <input type="hidden" id="id_<%=unit.getConid()%>" value="<%=unit.getConid()%>"/> 
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
                <div style="display: none;" id="dialog" title="New Consultation Fee">

                    <form id="addconcharges" class="form-horizontal" action="action/conroomaction.jsp" method="post" onsubmit="return validateForm();" name="items" >

                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01">Type: </label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Amount: GH&#162</label>
                                <div class="controls">
                                    <p class="help-inline"> &#162</p>
                                    <input class="input-mini" type="text" name="amount" id="amount">
                                    
                                </div>
                            </div>

                            <div class="form-actions">

                                <button class="btn btn-info" type="submit" name="action" value="addconcharges">
                                    <i class="icon-plus-sign icon-white"> </i>Save Consultation Type 
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
        
        
        $('#addconcharges').validate({
                            
            rules: {
                name: {
                    required: true,
                    minlength : 2
                                    
                },
                amount: {
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
        Consultation vst = (Consultation) itmss.get(i);
%>


<script type="text/javascript">
   
    $(document).ready(function(){
        
        
        $('#addconcharges<%= vst.getConid()%>').validate({
                            
            rules: {
                uname: {
                    required: true,
                    minlength : 2
                                    
                },
                uamount: {
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
    $("#<%= vst.getConid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getConid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getConid()%>_link").click(function(){
      
        $("#<%=vst.getConid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getConid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getConid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>