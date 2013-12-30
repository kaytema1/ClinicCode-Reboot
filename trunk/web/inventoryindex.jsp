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
                var description = document.getElementById("description").value;
                var type = document.getElementById("type").value;
                var markup = document.getElementById("markup").value;
                var unitofpricing = document.getElementById("unitofpricing").value;
                 var group = document.getElementById("group").value;
                  var theragroup = document.getElementById("theragroup").value;
                //var ty = document.getElementById("beds").value;
                $.post('action/additem.jsp', { action : "additem", description : description, type : type, markup : markup, unitofpricing : unitofpricing, group : group, theragroup : theragroup}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
            }
            function updateUnit(code,description,type,unitofpricing,markup){
                var code = document.getElementById(code).value;
                var description = document.getElementById(description).value;
                var type = document.getElementById(type).value;
                var unitofpricing = document.getElementById(unitofpricing).value;
                var markup = document.getElementById(markup).value;
               
                $.post('action/additem.jsp', { action : "edititem", code : code, description : description, type : type, unitofpricing : unitofpricing, markup : markup}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/additem.jsp', { action : "deleteitem", id : id}, function(data) {
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
            
            function showdrops(){
                var selected = document.getElementById("type").value;
                //alert(selected);
                if(selected==1){
                    var id = document.getElementById("hide");
                    id.style.display = "block";
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
                            <a href="#">Stock Items Management</a><span class="divider"></span>
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
                        List itmss = mgr.listStockItems();
                    %>     
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a>Items</a>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Item
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
                                            Description (Name)
                                        </th>
                                        <th>
                                            Type
                                        </th>   
                                        <th>
                                            Unit of Pricing
                                        </th>
                                        <th>
                                            Mark Up
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            StockItems stockItems = (StockItems) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=stockItems.getCode()%>
                                        </td>
                                        <td>
                                            <%=stockItems.getDescription()%>
                                        </td>
                                        <td>
                                            <%=mgr.getItemType(stockItems.getTypeId()).getItemType()%>
                                        </td>
                                        <td> 
                                            <%=stockItems.getUnitOfPricing()%>
                                        </td>
                                        <td> <%=stockItems.getMarkUp()%></td>
                                        <td>
                                            <button class="btn btn-inverse" id="<%=stockItems.getCode()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=stockItems.getCode()%>_dialog" title="Editing <%=stockItems.getDescription()%>">
                                                <form class="form-horizontal" action="action/additem.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Code</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="code_<%=stockItems.getCode()%>" value="<%=stockItems.getCode()%>" disabled="disabled">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Description </label>
                                                        <div class="controls">
                                                            <input type="text"  name="description" id="description_<%=stockItems.getCode()%>" value="<%=stockItems.getDescription()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Type </label>
                                                        <div class="controls">
                                                            <select name="type" id="types_<%=stockItems.getCode()%>">
                                                                
                                                                <%
                                                                    List itList = mgr.listItemType();
                                                                    for (int c = 0; c < itList.size(); c++) {
                                                                        Itemtype itemtype = (Itemtype) itList.get(c);
                                                                        if (itemtype.getId() == stockItems.getTypeId()) {
                                                                %>
                                                                <option value="<%=itemtype.getId()%>" selected="selected"><%=itemtype.getItemType()%></option>
                                                                <%} else {%>
                                                                <option value="<%=itemtype.getId()%>"><%=itemtype.getItemType()%></option>
                                                                <%}
                                                                    }%>
                                                            </select>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Unit of Pricing </label>
                                                        <div class="controls">
                                                            <input type="text" class="input-mini" name="unitofpricing" id="unitofpricing_<%=stockItems.getCode()%>" value="<%=stockItems.getUnitOfPricing()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Mark Up (%) </label>
                                                        <div class="controls">
                                                            <input type="text" class="input-mini" name="markup" id="markup_<%=stockItems.getCode()%>" value="<%=stockItems.getMarkUp()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("code_<%=stockItems.getCode()%>","description_<%=stockItems.getCode()%>","types_<%=stockItems.getCode()%>","unitofpricing_<%=stockItems.getCode()%>","markup_<%=stockItems.getCode()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Item 
                                                        </button>
                                                    </div>
                                                </form> 
                                            </div>
                                        </td>

                                        <td >
                                            <form style="padding-top: 15px;" action="action/additem.jsp" method="post">
                                                <input type="hidden" id="id_<%=stockItems.getCode()%>" value="<%=stockItems.getCode()%>"/> 

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=stockItems.getCode()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete Item 
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
                <div style="display: none;" id="dialog" title="New Item">
                    <form class="form-horizontal" action="action/additem.jsp" method="post" >
                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Item Description (Name) </label>
                                <div class="controls">
                                    <input type="text" name="description" id="description">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Type</label>
                                <div class="controls">
                                    <select name="type" id="type" onchange="showdrops()">
                                        <option>Select Item</option>
                                        <%
                                            List list = mgr.listItemType();
                                            for (int e = 0; e < list.size(); e++) {
                                                Itemtype itemtype = (Itemtype) list.get(e);
                                        %>
                                        <option value="<%=itemtype.getId()%>"><%=itemtype.getItemType()%></option>
                                        <%}%>
                                    </select>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Unit of Pricing</label>
                                <div class="controls">
                                    <input type="text" name="unitofpricing" id="unitofpricing">
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Mark Up (%) </label>
                                <div class="controls">
                                    <input type="text" name="markup" id="markup">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div id="hide" style="display: none">
                                <div class="control-group">
                                    <label class="control-label" for="input01">Diagnostic Group</label>
                                    <div class="controls">
                                        <select name="group" id="group">
                                            <option value="0">Select Item</option>
                                            <% List ls = mgr.listGroups();
                                                for (int i = 0; i < ls.size(); i++) {
                                                    DiagnosticGroupings dg = (DiagnosticGroupings) ls.get(i);
                                            %> 
                                            <option value="<%=dg.getCode()%>"><%=dg.getDescriptio()%></option>
                                            <%}%>
                                        </select>

                                        <p class="help-block"></p>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input01">Therapeutic Group</label>
                                    <div class="controls">
                                        <select name="theragroup" id="theragroup">
                                            <option value="0">Select Item</option>
                                            <% List lst = mgr.listTherapeuticGroup();
                                                for (int j = 0; j < lst.size(); j++) {
                                                    TherapeuticGroup dg = (TherapeuticGroup) lst.get(j);
                                            %> 
                                            <option value="<%=dg.getTheraid()%>"><%=dg.getDescription()%></option>
                                            <%}%>
                                        </select>

                                        <p class="help-block"></p>
                                    </div>
                                </div> 
                            </div>
                            <div class="form-actions">
                                <button class="btn btn-info"  onclick='submitform();return false;'>
                                    <i class="icon-plus-sign icon-white"> </i> Add Item 
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
        StockItems vst = (StockItems) itmss.get(i);
%>


<script type="text/javascript">
   
                      
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
    
   
    
    $("#<%= vst.getCode()%>_link").click(function(){
      
        $("#<%=vst.getCode()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getCode()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getCode()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>