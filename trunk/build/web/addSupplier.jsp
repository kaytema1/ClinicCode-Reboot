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
        <meta charset="utf-8">

        <%@include file="widgets/stylesheets.jsp" %> 

        <script type="text/javascript">
            function submitform(){
                var name = document.getElementById("name").value;
                var address = document.getElementById("address").value;
                var telephone = document.getElementById("telephone").value;
                var email = document.getElementById("email").value;
                $.post('action/addSup.jsp', { action : "addsupplier", name : name, address : address, telephone : telephone, email : email}, function(data) {
                    //alert(data);
                    location.reload();
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function updateUnit(id,name,address,telephone,email){
                var id = document.getElementById(id).value;
                var name = document.getElementById(name).value;
                var address = document.getElementById(address).value;
                var telephone = document.getElementById(telephone).value;
                var email = document.getElementById(email).value;
               
                $.post('action/addSup.jsp', { action : "editsupplier", id : id, name : name, address : address, telephone : telephone, email : email}, function(data) {
                    //alert(data);
                    location.reload();
                    //$('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                var con = confirm("Are You Sure You Want to Delete This Item");
                if (con ==true)
                {
                    $.post('action/addSup.jsp', { action : "deletesupplier", id : id}, function(data) {
                        alert("Deleted Successfully");
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
                            <a href="#">Manage Suppliers</a><span class="divider"></span>
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
                        List itmss = mgr.listSuppliersProper();
                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a style="font-size: 15px; margin-top: 10px;"> <b> Suppliers </b></a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Supplier
                                    </a>

                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Supplier
                                        </th>
                                        <th>
                                            Address
                                        </th>
                                        <th>
                                            Telephone
                                        </th>   
                                        <th>
                                            Email
                                        </th>

                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Supplier supplier = (Supplier) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=supplier.getName()%>
                                        </td>
                                        <td>
                                            <%=supplier.getAddress()%>
                                        </td>
                                        <td> 
                                            <%=supplier.getTelephone()%>
                                        </td>
                                        <td> <%=supplier.getEmail()%></td>
                                        <td style="padding: 0px; margin: 0px;">
                                            <button  class="btn btn-inverse" id="<%=supplier.getSupplierid()%>_link">
                                                Edit 
                                            </button>
                                            <div style="display: none;" id="<%=supplier.getSupplierid()%>_dialog" title="Editing <%=supplier.getName()%>">
                                                <form id="editSupplier<%=supplier.getSupplierid()%>" class="form-horizontal" action="action/addSup.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Supplier Name</label>
                                                        <div class="controls">
                                                            <input type="hidden" name="id" id="id_<%=supplier.getSupplierid()%>" value="<%=supplier.getSupplierid()%>">
                                                            <input type="text" name="name" id="code_<%=supplier.getSupplierid()%>" value="<%=supplier.getName()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Address </label>
                                                        <div class="controls">
                                                            <textarea name="address" id="description_<%=supplier.getSupplierid()%>"><%=supplier.getAddress()%></textarea>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Telephone </label>
                                                        <div class="controls">
                                                            <input type="text" class="input" name="telephone" id="unitofpricing_<%=supplier.getSupplierid()%>" value="<%=supplier.getTelephone()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Email </label>
                                                        <div class="controls">
                                                            <input type="text" class="input" name="email" id="markup_<%=supplier.getSupplierid()%>" value="<%=supplier.getEmail()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="editsupplier">
                                                            <i class="icon-edit icon-white"> </i> Update Supplier
                                                        </button>
                                                    </div>
                                                </form> 
                                            </div>
                                        </td>

                                        <td>
                                            <form style="padding: 0px; margin: 0px;" action="action/additem.jsp" method="post">
                                                <input type="hidden" id="id_<%=supplier.getSupplierid()%>" value="<%=supplier.getSupplierid()%>"/> 
                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=supplier.getSupplierid()%>");return false;'>
                                                    Delete 
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
                <div style="display: none;" id="dialog" title="New Supplier">
                    <form id="addSupplier" class="form-horizontal" action="action/addSup.jsp" method="post" >
                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Supplier</label>
                                <div class="controls">
                                    <input type="text" name="name" id="name">
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Address</label>
                                <div class="controls">
                                    <textarea name="address" id="address"></textarea>

                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Telephone </label>
                                <div class="controls">
                                    <input type="text" name="telephone" id="telephone">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Email </label>
                                <div class="controls">
                                    <input type="text" name="email" id="email">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button class="btn btn-info" name="action" value="addsupplier" >
                                    <i class="icon-plus-sign icon-white"> </i> Add Supplier 
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
        
        
        $('#addSupplier').validate({
                            
            rules: {
                name: {
                    required: true,
                    minlength : 2
                                    
                },
                address: {
                    required: true
                                    
                }
                ,
                telephone: {
                    required: true,
                    minlength : 10,
                    maxlength : 14
                                    
                },
                email : {
                    required: false,
                    email: true
                        
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
        Supplier vst = (Supplier) itmss.get(i);
%>


<script type="text/javascript">
   
   
    $(document).ready(function(){
        
        
        $('#editSupplier<%= vst.getSupplierid()%>').validate({
                            
            rules: {
                name: {
                    required: true,
                    minlength : 2
                                    
                },
                address: {
                    required: true
                                    
                }
                ,
                telephone: {
                    required: true,
                    minlength : 10,
                    maxlength : 14
                                    
                },
                email : {
                    required: false,
                    email: true
                        
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
                      
    $("#<%= vst.getSupplierid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getSupplierid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getSupplierid()%>_link").click(function(){
      
        $("#<%=vst.getSupplierid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getSupplierid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getSupplierid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>