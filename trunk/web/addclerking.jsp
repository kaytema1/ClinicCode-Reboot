<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }


    HMSHelper mgr = new HMSHelper();
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            /*    function submitform(){
                var name = document.getElementById("question").value;
                var category = document.getElementById("category").value
                
               
                $.post('action/clerkingaction.jsp', { action : "clerking", name : name, category : category}, function(data) {
                  
                     
                    
                } );
                
               window.top.location.reload();
                    
               
            } */
            
            function updateUnit(id,name){
                
                
                var question = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
                $.post('action/clerkingaction.jsp', { action : "edit", uname : question, uid : uid}, function(data) {
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
                    $.post('action/clerkingaction.jsp', { action : "deleteclerking", id : id}, function(data) {
                        alert("Deleted Successfully");
                        location.reload();
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Cancelled!");
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
                            <a href="#">Systemic Review</a><span class="divider"></span>
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


                        List itmss = mgr.listClerkQuestions();




                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <h4>Systemic Review Questions</h4>
                                </li>

                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">

                                        <i class="icon-plus-sign"></i> New Systemic Review Question
                                    </a>
                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Category 
                                        </th>
                                        <th>
                                            Systemic Review 
                                        </th>
                                        <th>

                                        </th>

                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Clerkingquestion clerkingQuestion = (Clerkingquestion) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="font-size: 14px; color: #0074cc;">
                                            <%= mgr.getClerkingCategoriesById(clerkingQuestion.getCategoryId()).getCategoryName()%>
                                        </td>
                                        <td>
                                            <%=clerkingQuestion.getQuestion()%>  
                                        </td>





                                        <td style="padding: 0px; margin: 0px;">
                                            <button class="btn btn-inverse btn-small" id="<%=clerkingQuestion.getClerkid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=clerkingQuestion.getClerkid()%>_dialog" title="Editing Question: <%=clerkingQuestion.getQuestion()%>">
                                                <form id="editclerking<%=clerkingQuestion.getClerkid()%>" class="form-horizontal" action="action/clerkingaction.jsp" method="POST"  >

                                                    <fieldset>
                                                        <div class="control-group">
                                                            <label class="control-label" for="input01"> Review Question: </label>
                                                            <div class="controls">
                                                                <select id="category" name="category">

                                                                    <option value="">Select Category </option>
                                                                    <% List categories = mgr.listClerkCategories();
                                                                        for (int x = 0; x < categories.size(); x++) {
                                                                            ClerkingCategories category = (ClerkingCategories) categories.get(x);
                                                                    %>

                                                                    <% if (clerkingQuestion.getCategoryId() == category.getId()) {%>
                                                                    <option selected="selected" value="<%= category.getId()%>"><%= category.getCategoryName()%>  </option>
                                                                    <% } else {%>
                                                                    <option  value="<%= category.getId()%>"><%= category.getCategoryName()%>  </option>
                                                                    <% }
                                                                        }%>


                                                                </select>
                                                                <p class="help-block"></p>
                                                            </div>
                                                        </div>


                                                        <div class="control-group">
                                                            <label class="control-label" for="input01"> Review Question: </label>
                                                            <div class="controls">
                                                                <input type="hidden" name="questionId" value="<%=clerkingQuestion.getClerkid()%>">
                                                                <input class="input-xlarge"  name="name" value="<%=clerkingQuestion.getQuestion()%>">
                                                                <p class="help-block"></p>
                                                            </div>
                                                        </div>




                                                        <div class="form-actions">
                                                            <button type="submit" name="action" value="editclerking" class="btn btn-info">
                                                                <i class="icon-plus-sign icon-white"> </i> Update Review Question 
                                                            </button>
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </td>

                                        <td style="padding: 0px; margin: 0px;">
                                            <form style="padding: 0px; margin: 0px;" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=clerkingQuestion.getClerkid()%>" value="<%=clerkingQuestion.getClerkid()%>"/> 
                                                <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=clerkingQuestion.getClerkid()%>");return false;'>
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
                <div style="display: none;" id="dialog" title="New Systemic Review Question">



                    <form id="addclerking" class="form-horizontal" action="action/clerkingaction.jsp" method="POST">

                        <fieldset>
                            <div class="control-group">
                                <label class="control-label" for="input01">Category: </label>
                                <div class="controls">

                                    <select id="category" name="category">

                                        <option value="">Select Category </option>
                                        <% List categories = mgr.listClerkCategories();
                                            for (int x = 0; x < categories.size(); x++) {
                                                ClerkingCategories category = (ClerkingCategories) categories.get(x);
                                        %>
                                        <option value="<%= category.getId()%>"><%= category.getCategoryName()%>  </option>
                                        <% }%>


                                    </select>

                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Review Question: </label>
                                <div class="controls">

                                    <input class="input-xlarge" name="name" id="question"></textarea>
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="form-actions">

                                <button type="submit" name="action" value="clerking" class="btn btn-info">
                                    <i class="icon-plus-sign icon-white"> </i> Save Review Question
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
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/tablecloth.js"></script>
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
        
        
        $('#addclerking').validate({
            rules: {
                name: {
                    minlength: 2,
                    required: true
                },
                category: {
                    
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
        Clerkingquestion vst = (Clerkingquestion) itmss.get(i);
%>


<script type="text/javascript">
   
    $('#editclerking<%= vst.getClerkid()%>').validate({
        rules: {
            name: {
                minlength: 2,
                required: true
            },
            category: {
                    
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
    $("#<%= vst.getClerkid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    
   
    
    $("#<%= vst.getClerkid()%>_link").click(function(){
      
        $("#<%=vst.getClerkid()%>_dialog").dialog('open');
    
    })
  
    
    
   
    
</script>



<% }%>
</body>
</html>