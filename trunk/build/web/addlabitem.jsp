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
//ArrayList<Integer> lists = (ArrayList<Integer>) session.getAttribute("staffPermission");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");

        SimpleDateFormat formatter = new SimpleDateFormat();
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var description = document.getElementById("description").value;
                var code = document.getElementById("code").value;
                var markup = document.getElementById("markup").value;
                var emergency = document.getElementById("emergency").value;
                var reorder = document.getElementById("reorder").value;
                var maximum = document.getElementById("maximum").value;
                var staffid = document.getElementById("staffid").value;
               
                $.post('action/additem.jsp', { action : "addlabitem", code : code, description : description,markup : markup, reorder : reorder, emergency : emergency, maximum:maximum, staffid : staffid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
            }
            function updateUnit(code,description,reorder,emergency,maximum,markup){
                var code = document.getElementById(code).value;
                var description = document.getElementById(description).value;
                var markup = document.getElementById(markup).value;
                var reorder = document.getElementById(reorder).value;
                var emergency = document.getElementById(emergency).value;
                var maximum = document.getElementById(maximum).value;
                $.post('action/additem.jsp', { action : "editlabitems", code : code, description : description, markup:markup, reorder : reorder, emergency : emergency, maximum : maximum}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
              
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/additem.jsp', { action : "deletelabitems", id : id}, function(data) {
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
        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />

        <%

            HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            List itmss = mgr.listLabStockItems();
            // List list = itm.listStockItems();
            List theragroups = mgr.listTherapeuticGroup();
            List diagnosticgroups = mgr.listGroups();
            List types = mgr.listItemType();
        %>   
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        
                        <li class="active">
                            <a href="#">Laboratory Inventory </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">


                    <!--%@include file="widgets/adminpanelleftsidebar.jsp" %-->
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a>Items in Stock</a>

                                </li>
                                <li class="pull-right">
                                        <% if (permissions.contains(61)) {%>
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> Add New Item to Stock
                                    </a>
<%}%>
                                </li>

                            </ul>
                            <table  class="example display table">
                                <thead>
                                    <tr>

                                        <th style="text-align: left;">
                                            Item Code
                                        </th>
                                        <th style="text-align: left; ">
                                            Description 
                                        </th>
                                        <th style="text-align: left;">
                                            Re-Order Level
                                        </th>
                                        <th style="text-align: left;">
                                            Emergency  Level
                                        </th>
                                        <th style="text-align: left;">
                                            Maximum  Level
                                        </th>
                                        <th style="text-align: left;">
                                            Packaging
                                        </th>
                                        
                                        
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (itmss != null) {
                                            for (int i = 0; i < itmss.size(); i++) {
                                                LabStockItem stockItems = (LabStockItem) itmss.get(i);
                                                System.out.println(stockItems);
                                                if (stockItems != null) {
                                    %>
                                    <tr>

                                        <td class="text-info" style="text-transform: uppercase; font-weight: bold; text-align: left;">
                                            <%=stockItems.getId()%>
                                        </td>
                                        <td>
                                            <%=stockItems.getName()%>
                                        </td>

                                        <td style="text-align: right;"> 
                                            <%=stockItems.getReOrderLevel()%>
                                        </td>
                                        <td style="text-align: right;"> 
                                            <%=stockItems.getEmergencyStockLevel()%>
                                        </td>
                                        <td style="text-align: right;"> 
                                            <%=stockItems.getMaximumStockLevel()%>
                                        </td>
                                        <td style="text-align: center;"> 
                                            <%=stockItems.getMarkUp()%>
                                        </td>
                                        <td style=" margin: 0px; padding: 0px;">
                                            <button class="btn btn-inverse btn-small" id="<%=stockItems.getId()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style=" margin: 0px; padding: 0px; display: none; max-height: 500px;" id="<%=stockItems.getId()%>_dialog" title="Editing <%=stockItems.getName()%>">
                                                <form class="form-horizontal" action="action/additem.jsp" method="post" name="">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Code</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="code_<%=stockItems.getId()%>" value="<%=stockItems.getId()%>" disabled="disabled">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Description </label>
                                                        <div class="controls">
                                                            <input type="text"  name="description" id="description_<%=stockItems.getId()%>" value="<%=stockItems.getName()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Re-Order Level</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="reorder_<%=stockItems.getId()%>" value="<%=stockItems.getReOrderLevel()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Emergency Stock Level</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="emergency_<%=stockItems.getId()%>" value="<%=stockItems.getEmergencyStockLevel()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Maximum Stock Level</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="maximum_<%=stockItems.getId()%>" value="<%=stockItems.getMaximumStockLevel()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Packaging</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="mark_<%=stockItems.getId()%>" value="<%=stockItems.getMarkUp()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <!--div class="control-group">
                                                        <label class="control-label" for="input01"> Added By</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="staff_<%=stockItems.getId()%>" value="<%=stockItems.getStaffId()%>" readonly="readonly"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Date Added</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="date_<%=stockItems.getId()%>" value="<%=stockItems.getDateAdded()%>" readonly="readonly"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div-->
                                                    <div class="form-actions">
                                                        <% if (permissions.contains(63)) {%>
                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("code_<%=stockItems.getId()%>","description_<%=stockItems.getId()%>","reorder_<%=stockItems.getId()%>","emergency_<%=stockItems.getId()%>","maximum_<%=stockItems.getId()%>","mark_<%=stockItems.getId()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Item 
                                                        </button>
                                                            <%}%>
                                                    </div>
                                                </form> 
                                            </div>
                                        </td>
                                        <td>
                                            <form style="padding-top: 15px;" action="action/additem.jsp" method="post">
                                                <input type="hidden" id="id_<%=stockItems.getId()%>" value="<%=stockItems.getId()%>"/> 
<% if (permissions.contains(64)) {%>
                                                <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=stockItems.getId()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete
                                                </button>
                                                    <%}%>
                                            </form>
                                        </td>
                                    </tr>
                                    <%}
                                            }
                                        }%>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="clearfix"></div>
                    <div style="display: none;" id="dialog" title="New Item" >
                        <form class="form-horizontal" action="" method="post"  name="" >
                            <div style="padding-bottom: 10px;" class="span10 content bs-docs-example">
                                <fieldset>
                                    <div class="pull-left">
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Code  </label>
                                            <div class="controls">
                                                <input class="input-mini" type="text" name="code" id="code">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Description (Name)  </label>
                                            <div class="controls">
                                                <input type="text" name="description" id="description">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"  for="input01">Packaging </label>
                                            <div class="controls">
                                                <input type="text" name="markup" id="markup" >
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-left offset1">
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Re - Order Level </label>
                                            <div class="controls">
                                                <input style="width: 60px;" type="text" name="reorder" id="reorder">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Emergency Stock Level </label>
                                            <div class="controls">
                                                <input style="width: 60px;" type="text" name="emergency" id="emergency">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Maximum Stock Level </label>
                                            <div class="controls">
                                                <input style="width: 60px;" type="text" name="maximum" id="maximum">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>

                                    </div>
                                    <input type="hidden" name="staffid" value="<%=user.getStaffid()%>" id="staffid">
                                                  
                                </fieldset>

                                <div class="form-actions">
                                    <button class="btn btn-info btn-small" type="submit" name="action" value="additem" onclick="submitform();return false">
                                        <i class="icon-plus-sign icon-white"> </i> Add to Stock 
                                    </button>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
                <div class="clearfix"></div>

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
            "sScrollX" : "350px",
            "sScrollX": "100%",
            "sScrollXInner": "110%",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
        
        
        
        $("#dialog").dialog({
            autoOpen : false,
            width : 1100,
            modal :true

        });
       

    });
    
    function validateForm()
    {
        var x=document.forms["items"]["items"].value;
        if (x==null || x=="")
        {
            alert("Item must be filled out");
            return false;
        }


        var x=document.forms["items"]["item_quantity"].value;
        if (x==null || x=="")
        {
            alert("Quantity must be filled out");
            return false;
        }
        var x=document.forms["items"]["price_per_item"].value;
        if (x==null || x=="")
        {
            alert("Price must be filled out");
            return false;
        }
        var x=document.forms["items"]["date"].value;
        if (x==null || x=="")
        {
            alert("Date must be filled out");
            return false;
        }
        var x=document.forms["items"]["exp_date"].value;
        if (x==null || x=="")
        {
            alert("Expiring Date must be filled out");
            return false;
        }
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
        LabStockItem vst = (LabStockItem) itmss.get(i);
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
    
    $("#<%= vst.getId()%>_stock").dialog({
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
    
    $("#<%= vst.getId()%>_slink").click(function(){
        alert("");
        $("#<%=vst.getId()%>_stock").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>
