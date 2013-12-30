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
                // alert("here");
                var name = document.getElementById("name").value;
                var type = document.getElementById("type").value;
                var reaction = document.getElementById("reaction").value;
                var suggestion = document.getElementById("suggestion").value;                   
                $.post('action/allergyaction.jsp', { action : "allergy", name : name, type : type, reaction : reaction, suggestion : suggestion}, function(data) {
                    location.reload();
                    alert("Allergy Saved Successfully");
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function updateUnit(name,id,type,reaction,suggestion){
                
               
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
                var rxn = document.getElementById(reaction).value;
                var type = document.getElementById(type).value;
                var suggestion = document.getElementById(suggestion).value;
               
                   
                $.post('action/allergyaction.jsp', { action : "allergyedit", uname : uname, uid : uid, type : type, rxn : rxn, suggestion : suggestion}, function(data) {
                    location.reload();
                    alert("Allergy Edited Successfully");
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/allergyaction.jsp', { action : "delete", id : id}, function(data) {
                        location.reload();
                        alert("Allergy Deleted Successfully");
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancled!");
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
                            <a href="#">Allergy Management</a><span class="divider"></span>
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

                        // HMSHelper mgr = new HMSHelper();

                        List itmss = mgr.listAllergiess();
                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a>Allergies</a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Allergy
                                    </a>

                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Name  
                                        </th>
                                        <th>
                                            Type
                                        </th>
                                        <th>
                                            Possible reactions
                                        </th>
                                        <th>
                                            Suggestion
                                        </th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Allergies unit = (Allergies) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=unit.getName()%>
                                        </td>
                                        <td>
                                            <%=unit.getType()%>
                                        </td>
                                        <td>
                                            <%if (unit.getPossibleRxns() != null) {%> 
                                            <%=unit.getPossibleRxns()%>

                                            <% }%>
                                        </td>
                                        <td>
                                            <%if (unit.getPossibleRxns() != null) {%> 

                                            <%=unit.getSuggestedTreatment()%>
                                            
                                            <% }%>
                                        </td>

                                        <td style="padding: 0px; margin: 0px;">
                                            <button class="btn btn-inverse btn-small" id="<%=unit.getAllergyid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=unit.getAllergyid()%>_dialog" title="Editing <%=unit.getName()%>">
                                                <form id="editallergy<%=unit.getAllergyid()%>"  class="form-horizontal" action="action/allergyaction.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Allergy Name: </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=unit.getAllergyid()%>" value="<%=unit.getName()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Allergy Type: </label>
                                                        <div class="controls">
                                                            <select name="type" id="type_<%=unit.getAllergyid()%>"/>
                                                            <%if (unit.getType().equalsIgnoreCase("Food")) {%>
                                                            <option value="Food" selected="selected">Food</option>
                                                            <option value="Drug">Drug</option>
                                                            <option value="Environmental" >Environmental</option>
                                                            <%}%>
                                                            <%if (unit.getType().equalsIgnoreCase("Drug")) {%>
                                                            <option value="Food">Food</option>
                                                            <option value="Drug" selected="selected">Drug</option>
                                                            <option value="Environmental">Environmental</option>
                                                            <%}%>
                                                            <%if (unit.getType().equalsIgnoreCase("Environmental")) {%>
                                                            <option value="Food">Food</option>
                                                            <option value="Drug">Drug</option>
                                                            <option value="Environmental" selected="selected">Environmental</option>
                                                            <%}%>
                                                            </select>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Possible Reactions: </label>
                                                        <div class="controls">
                                                            <textarea name="reactions" id="reactions_<%=unit.getAllergyid()%>" ><%=unit.getPossibleRxns()%></textarea>

                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Suggested Treatments: </label>
                                                        <div class="controls">
                                                            <textarea name="suggestion" id="suggestion_<%=unit.getAllergyid()%>"><%=unit.getSuggestedTreatment()%></textarea>

                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" name="uid" id="unitid_<%=unit.getAllergyid()%>" value="<%=unit.getAllergyid()%>">

                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="allergyedit" >
                                                            <i class="icon-edit icon-white"> </i> Update Allergy 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td style="padding: 0px; margin: 0px;">
                                            <form style="padding: 0px; margin: 0px;" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=unit.getAllergyid()%>" value="<%=unit.getAllergyid()%>"/> 

                                                <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=unit.getAllergyid()%>");return false;'>
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
                <div style="display: none;" id="dialog" title="New Allergy">
                    <form id="addallergy" class="form-horizontal" action="action/wardaction.jsp" method="post" onsubmit="return validateForm();" name="items" >

                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Allergy Name: </label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Allergy Type </label>
                                <div class="controls">
                                    <select name="type" id="type">
                                        <option value="Food">Food</option>
                                        <option value="Drug" selected="selected">Drug</option>
                                        <option value="Environmental">Environmental</option>
                                    </select>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Possible Reactions </label>
                                <div class="controls">
                                    <textarea id="reaction" name="reaction"></textarea>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Suggested Treatment </label>
                                <div class="controls">
                                    <textarea id="suggestion" name="suggestion"></textarea>
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="form-actions">

                                <button class="btn btn-info"  onclick='submitform();return false;'>
                                    <i class="icon-plus-sign icon-white"> </i> Add Allergy 
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
        
        
        $('#addallergy').validate({
            rules: {
                name: {
                    minlength: 2,
                    required: true
                },
                type: {
                    
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
            i < itmss.size();
            i++) {
        Allergies vst = (Allergies) itmss.get(i);
%>


<script type="text/javascript">
   
   
    $(document).ready(function(){ 
    
        $('#editallergy<%= vst.getAllergyid()%>').validate({
            rules: {
                uname: {
                    minlength: 2,
                    required: true
                },
                type: {
                
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
    $("#<%= vst.getAllergyid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getAllergyid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getAllergyid()%>_link").click(function(){
      
        $("#<%=vst.getAllergyid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getAllergyid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getAllergyid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>