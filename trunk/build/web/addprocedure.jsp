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
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    DecimalFormat df = new DecimalFormat();

    df.setMinimumFractionDigits(2);
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var code = document.getElementById("code").value;
                var description = document.getElementById("description").value;
                var price = document.getElementById("price").value;
                
                $.post('action/procedureaction.jsp', { action : "addprocedure", code : code, description : description, price : price}, function(data) {
                    location.reload();
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function updateUnit(code,description,price){
                var code = document.getElementById(code).value;
                var description = document.getElementById(description).value;
                var price = document.getElementById(price).value;
                alert(code);
                $.post('action/procedureaction.jsp', { action : "editprocedure", code : code, description : description, price : price}, function(data) {
                    location.reload();
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                var con = confirm("Are You Sure You Want to Delete This Item");
                if (con ==true)
                {
                    $.post('action/procedureaction.jsp', { action : "deleteprocedure", id : id}, function(data) {
                        location.reload();
                        alert(data);
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
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Procedure Management</a><span class="divider"></span>
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
                        List itmss = mgr.listProcedure();
                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a>Procedure</a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Procedure
                                    </a>

                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Code
                                        </th>
                                        <th>
                                            Description
                                        </th>
                                        <th>
                                            Price
                                        </th> 
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Procedure procedure = (Procedure) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=procedure.getCode()%>
                                        </td>
                                        <td>
                                            <%=procedure.getDescription()%>
                                        </td>
                                        <td style="text-align: right; padding-right: 20px;"> 
                                            <%=df.format(procedure.getPrice())%>
                                        </td>
                                        <td style="margin: 0px; padding: 0px;">
                                            <button class="btn btn-inverse" id="<%=procedure.getCode()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=procedure.getCode()%>_dialog" title="Editing <%=procedure.getDescription()%>">
                                                <form class="form-horizontal" action="action/additem.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Procedure Description</label>
                                                        <div class="controls">
                                                            <input type="hidden" name="id" id="id_<%=procedure.getCode()%>" value="<%=procedure.getCode()%>">
                                                            <textarea name="description" id="description_<%=procedure.getCode()%>"><%=procedure.getDescription()%></textarea>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Procedure Price </label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="code_<%=procedure.getCode()%>" value="<%=procedure.getPrice()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("id_<%=procedure.getCode()%>","description_<%=procedure.getCode()%>","code_<%=procedure.getCode()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Procedure
                                                        </button>
                                                    </div>
                                                </form> 
                                            </div>
                                        </td>

                                        <td style="margin: 0px; padding: 0px;">
                                            <form style="margin: 0px; padding: 0px;" action="action/additem.jsp" method="post">

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=procedure.getCode()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Remove 
                                                </button>
                                                <input type="hidden" id="id_<%=procedure.getCode()%>" value="<%=procedure.getCode()%>"/> 
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
                <div style="display: none;" id="dialog" title="New Procedure">
                    <form class="form-horizontal" action="action/additem.jsp" method="post" >
                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Procedure Code</label>
                                <div class="controls">
                                    <input type="text" name="code" id="code">
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Procedure Description</label>
                                <div class="controls">
                                    <textarea name="description" id="description"></textarea>

                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Price </label>
                                <div class="controls">
                                    <input type="text" name="price" id="price">
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button class="btn btn-info"  onclick='submitform();return false;'>
                                    <i class="icon-plus-sign icon-white"> </i> Add Procedure 
                                </button>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </section>

            <%@include file="widgets/footer.jsp" %>

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
        Procedure vst = (Procedure) itmss.get(i);
%>


<script type="text/javascript">
   
             
    $(document).ready(function(){  
             
       
        $("#<%= vst.getCode()%>_dialog").dialog({
            autoOpen : false,
            width : 500,
            modal :true

        });
    
        $("#<%= vst.getCode()%>_adddrug_dialog").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
    
   
    
        $("#<%=vst.getCode()%>_link").click(function(){
            alert("Hello");
            $("#<%=vst.getCode()%>_dialog").dialog('open');
    
        })
  
    
        $("#<%= vst.getCode()%>_adddrug_link").click(function(){
            alert("");
            $("#<%=vst.getCode()%>_adddrug_dialog").dialog('open');
        
        })
    
    })
   
    
</script>

<% }%>
</body>
</html>