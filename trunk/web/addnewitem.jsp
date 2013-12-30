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

        SimpleDateFormat formatter = new SimpleDateFormat();
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var description = document.getElementById("description").value;
                var type = document.getElementById("type").value;
                var icd10 = document.getElementById("icd10").value;
                var markup = document.getElementById("markup").value;
                var unitprice = document.getElementById("unitprice").value;
                var reorder = document.getElementById("reorder").value;
                var emergency = document.getElementById("emergency").value;
                var therapeutic = document.getElementById("therapeutic").value;
                var diagnostic = document.getElementById("diagnostic").value;
                
                $.post('action/additem.jsp', { action : "additem", icd10 : icd10, description : description, type : type, markup : markup, unitprice : unitprice, reorder : reorder, emergency : emergency, therapeutic :therapeutic,diagnostic:diagnostic}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
            }
            function updateUnit(code,icd10,description,markup,type,unitprice,quantity,reorder,emergency,theragroup,diagnostics){
                var code = document.getElementById(code).value;
                var description = document.getElementById(description).value;
                var markup = document.getElementById(markup).value;
                var unitprice = document.getElementById(unitprice).value;
                var type = document.getElementById(type).value;
                var quantity = document.getElementById(quantity).value;
                var reorder = document.getElementById(reorder).value;
                var emergency = document.getElementById(emergency).value;
                var theragroup = document.getElementById(theragroup).value;
                var diagnostic = document.getElementById(diagnostics).value;
                
                //var ty = document.getElementById("beds").value;
                $.post('action/additem.jsp', { action : "edititems", code : code,icd10 : icd10, quantity : quantity, description : description, markup:markup, type:type, unitprice : unitprice,reorder : reorder, emergency : emergency, theragroup : theragroup, diagnostic : diagnostic}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
              
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/additem.jsp', { action : "deleteitems", id : id}, function(data) {
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
            List itmss = mgr.listStockItems();
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
                            <a href="#">Dispensary Stock </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">


                    <!--%@include file="widgets/adminpanelleftsidebar.jsp" %-->
                    <%@include file="widgets/leftsidebar.jsp" %>


                    <div style="display: none;" class="span8 thumbnail main-c">
                        <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                            <li style="margin-top: 5px;">
                                <a style="font-size: 15px; font-weight: bolder;">Dispensary Stock Items</a>

                            </li>
                            <li class="pull-right">
                                <a href="#" class="dialog_link btn">
                                    <i class="icon-plus-sign"></i> Add New Item to Dispensary Stock
                                </a>

                            </li>

                        </ul>
                        <table  class="example display table table-striped table-condensed">
                            <thead>
                                <tr>

                                    <th style="text-align: left;">
                                        Code
                                    </th>
                                    <th style="text-align: left;">
                                        Description
                                    </th>


                                    <!--  <th style="width: 30px;">
                                          Mark Up
                                      </th>  -->
                                    <th style="text-align: left; width: 2%">
                                        Quantity
                                    </th>
                                    <!--  <th style="width: 30px;">
                                         Re-Order Level
                                     </th>
                                    <th>
                                         Emerg Level 
                                     </th>
                                     <th>
                                         Therapeutic Group 
                                     </th>
                                     <th>
                                         Diagnostic Group
                                     </th>  -->
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (itmss != null) {
                                        for (int i = 0; i < itmss.size(); i++) {
                                            StockItems stockItems = (StockItems) itmss.get(i);
                                            System.out.println(stockItems);
                                            if (stockItems != null) {
                                %>
                                <tr>

                                    <td style="text-transform: uppercase;">
                                        <%=stockItems.getCode()%>
                                    </td>
                                    <td>
                                        <%=stockItems.getDescription()%>
                                    </td>
                                    <!--   <td style="text-align: center"> 
                                    <%=stockItems.getTypeId()%>
                                </td>  
                                <td style="text-align: center"> 
                                    <%=stockItems.getUnitOfPricing()%>
                                </td>
                                <td style="text-align: center"> 
                                    <%=stockItems.getMarkUp()%>
                                </td> -->
                                    <td style="text-align: right;"> 
                                        <%=stockItems.getQunaity()%>
                                    </td>
                                    <!--  <td style="text-align: center"> 
                                    <%=stockItems.getReOrderLevel()%>
                                </td>
                                <td style="text-align: center"> 
                                    <%=stockItems.getEmergencyLevel()%>
                                </td>
                                <td> 
                                    <%=mgr.getTherapeuticGroup(stockItems.getTheragroup()) == null ? "" : mgr.getTherapeuticGroup(stockItems.getTheragroup()).getDescription()%>
                                </td>
                                <td> 
                                    <%=mgr.getGroups(stockItems.getGroupId()) == null ? "" : mgr.getGroups(stockItems.getGroupId()).getDescriptio()%>
                                </td>   -->
                                    <td style="padding: 0px; margin: 0px; text-align: center;">
                                        <button class="btn btn-inverse btn-small" id="<%=stockItems.getCode()%>_link">
                                            <i class="icon-edit icon-white"> </i> Edit 
                                        </button>
                                        <div style="display: none; max-height: 500px;" id="<%=stockItems.getCode()%>_dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%; text-transform: capitalizel'> Editing <%=stockItems.getDescription()%> | <%=stockItems.getCode()%>  <span>">
                                            <form class="form-horizontal" action="action/additem.jsp" method="post" name="">
                                                <div class="pull-left">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Code</label>
                                                        <div class="controls">
                                                            <input type="text" class="input-mini" name="code" id="code_<%=stockItems.getCode()%>" value="<%=stockItems.getCode()%>" disabled="disabled">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> ICD10</label>
                                                        <div class="controls">
                                                            <input  type="text" class="input-mini" style="text-transform: uppercase;" name="code" id="icd10_<%=stockItems.getIcd10()%>" value="<%=stockItems.getIcd10()%>" disabled="disabled">
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
                                                        <label class="control-label" for="input01"> Type</label>
                                                        <div class="controls">
                                                            <select name="supplier" id="type_<%=stockItems.getCode()%>">

                                                                <%  if (types != null) {
                                                                        for (int x = 0; x < types.size(); x++) {
                                                                            Itemtype itt = (Itemtype) types.get(x);
                                                                            String supplier = itt.getItemType();
                                                                            if (itt.getId() == stockItems.getTypeId()) {%>
                                                                <option value="<%=itt.getId()%>" selected="selected"><%=supplier%></option>
                                                                <%} else {%>
                                                                <option value="<%=itt.getId()%>"><%=supplier%></option>
                                                                <% }
                                                                        }
                                                                    }%>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Unit of Price</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="price_<%=stockItems.getCode()%>" value="<%=stockItems.getUnitOfPricing()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <!--   <div class="control-group">
                                                           <label class="control-label" for="input01"> Mark Up</label>
                                                           <div class="controls">
                                                               <input type="text" name="code" id="mark_<%=stockItems.getCode()%>" value="<%=stockItems.getMarkUp()%>">
                                                               <p class="help-block"></p>
                                                           </div>
                                                       </div>  -->

                                                </div>
                                                <div class="pull-left offset1">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Quantity in Stock</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" class="input-mini" id="qty_<%=stockItems.getCode()%>" value="<%=stockItems.getQunaity()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Re Order Level</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" class="input-mini" id="reorder_<%=stockItems.getCode()%>" value="<%=stockItems.getReOrderLevel()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Emergency Level</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" class="input-mini" id="emergency_<%=stockItems.getCode()%>" value="<%=stockItems.getEmergencyLevel()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Therapeutic Group </label>
                                                        <div class="controls">
                                                            <select name="supplier" id="therapeutic_<%=stockItems.getCode()%>">

                                                                <%  if (theragroups != null) {
                                                                        for (int x = 0; x < theragroups.size(); x++) {
                                                                            TherapeuticGroup itt = (TherapeuticGroup) theragroups.get(x);
                                                                            String supplier = itt.getDescription();
                                                                            if (itt.getTheraid() == stockItems.getTheragroup()) {%>
                                                                <option value="<%=itt.getTheraid()%>" selected="selected"><%=supplier%></option>
                                                                <%} else {%>
                                                                <option value="<%=itt.getTheraid()%>"><%=supplier%></option>
                                                                <% }
                                                                        }
                                                                    }%>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Diagnostic Group </label>
                                                        <div class="controls">
                                                            <select name="manufacturer" id="diagnostic_<%=stockItems.getCode()%>">

                                                                <%   if (diagnosticgroups != null) {
                                                                        for (int z = 0; z < diagnosticgroups.size(); z++) {
                                                                            DiagnosticGroupings itt = (DiagnosticGroupings) diagnosticgroups.get(z);
                                                                            String supplier = itt.getDescriptio();
                                                                            if (itt.getCode().equalsIgnoreCase(stockItems.getGroupId())) {%>
                                                                <option value="<%=itt.getCode()%>" selected="selected"><%=supplier%> </option>
                                                                <%} else {%>
                                                                <option value="<%=itt.getCode()%>"><%=supplier%> </option>
                                                                <% }
                                                                        }
                                                                    }%>
                                                            </select>
                                                            <p class="help-block"></p>
                                                        </div>

                                                    </div>

                                                </div>

                                                <div class="clearfix">

                                                </div>
                                                <div style="padding-left: 0px;" class="form-actions center">
                                                    <button style="width: 90%" class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("code_<%=stockItems.getCode()%>","icd10_<%=stockItems.getIcd10()%>","description_<%=stockItems.getCode()%>","mark_<%=stockItems.getCode()%>","type_<%=stockItems.getCode()%>","price_<%=stockItems.getCode()%>","qty_<%=stockItems.getCode()%>","reorder_<%=stockItems.getCode()%>","emergency_<%=stockItems.getCode()%>","therapeutic_<%=stockItems.getCode()%>","diagnostic_<%=stockItems.getCode()%>");return false;'>
                                                        <i class="icon-edit icon-white"> </i> Update Dispensary Item 
                                                    </button>
                                                </div>

                                            </form> 
                                        </div>
                                    </td>
                                    <td style="padding: 0px; margin: 0px; text-align: center;">
                                        <form style="padding: 0px; margin: 0px;" action="action/additem.jsp" method="post">
                                            <input type="hidden" id="id_<%=stockItems.getCode()%>" value="<%=stockItems.getCode()%>"/> 

                                            <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=stockItems.getCode()%>");return false;'>
                                                <i class="icon-remove icon-white"> </i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <%}
                                        }
                                    }%>
                            </tbody>
                        </table>
                    </div>


                    <div class="clearfix"></div>
                    <div style="display: none;" id="dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> ADD TO DISPENSARY STOCK </span>" >
                        <form class="form-horizontal" action="action/additem.jsp" method="post"  name="" >
                            <fieldset>
                                <div class="pull-left">
                                    <div class="control-group">
                                        <label class="control-label" for="input01">ICD10  </label>
                                        <div class="controls">
                                            <input type="text" class="input-mini" name="icd10" id="icd10">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="input01">Treatment Name  </label>
                                        <div class="controls">
                                            <input type="text" name="description" id="description">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="input01">Item Type </label>
                                        <div class="controls">
                                            <select name="type" id="type">
                                                <option>
                                                    Select Item Type
                                                </option>
                                                <%  if (types != null) {
                                                        for (int x = 0; x < types.size(); x++) {
                                                            Itemtype itt = (Itemtype) types.get(x);
                                                            String supplier = itt.getItemType();
                                                %>
                                                <option value="<%=itt.getId()%>"><%=supplier%></option>
                                                <% }
                                                    }%>
                                            </select>
                                            <br/>
                                            <p class="help-block"></p>
                                        </div>
                                    </div> 
                                    <div class="control-group">
                                        <label class="control-label" for="input01"> Unit of Sale </label>
                                        <div class="controls">
                                            <input type="text" name="unitprice" class="input-small" id="unitprice">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <!--   <div class="control-group">
                                           <label class="control-label"  for="input01">Mark Up </label>
                                           <div class="controls">
                                               <input type="text" class="input-mini" name="markup" id="markup" >
                                               <p class="help-block"></p>
                                           </div>
                                       </div>  -->
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
                                        <label class="control-label" for="input01">Emerg. Order Level </label>
                                        <div class="controls">
                                            <input style="width: 60px;" type="text" name="emergency" id="emergency">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="input01">Therapeutic Group </label>
                                        <div class="controls">
                                            <select name="therapeutic" id="therapeutic">
                                                <option>
                                                    Select Therapeutic Group
                                                </option>
                                                <%  if (theragroups != null) {
                                                        for (int i = 0; i < theragroups.size(); i++) {
                                                            TherapeuticGroup itt = (TherapeuticGroup) theragroups.get(i);

                                                            String supplier = itt.getDescription();%>
                                                <option value="<%=itt.getTheraid()%>">
                                                    <%=supplier%>
                                                </option>
                                                <% }
                                                    }%>
                                            </select><br/>
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="input01">Diagnostic Group </label>
                                        <div class="controls">
                                            <select name="diagnostic" id="diagnostic">
                                                <option>
                                                    Select Diagnostic Grouping
                                                </option>
                                                <%  if (diagnosticgroups != null) {
                                                        for (int i = 0; i < diagnosticgroups.size(); i++) {
                                                            DiagnosticGroupings itt = (DiagnosticGroupings) diagnosticgroups.get(i);

                                                            String supplier = itt.getDescriptio();%>
                                                <option value="<%=itt.getCode()%>">
                                                    <%=supplier%>
                                                </option>
                                                <% }
                                                    }%>
                                            </select><br/>
                                            <p class="help-block"></p>
                                        </div>
                                    </div>

                                </div>
                                <input type="hidden" name="eq" value="0">
                                <input type="hidden" name="rq" value="0">
                                <input type="hidden" name="drug" value="Choose Drug Type">
                                <input type="hidden" name="locationId" value="Enter Drud Location">
                                <div class="clearfix"></div>                

                            </fieldset>
                            <div class="clearfix">

                            </div>
                            <div style="padding-left: 0px;" class="form-actions center">
                                <button style="width: 90%" class="btn btn-info" type="submit" name="action" value="additem" onclick="submitform();return false;">
                                    <i class="icon-plus-sign icon-white"> </i> Add to Dispensary Stock 
                                </button>
                            </div>
                        </form>
                    </div>

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
        $(".main-c").fadeIn();
        
        $("#sidebar-toggle-container").fadeIn();
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
            "sScrollY": "300px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true
            

        });
        
        
        
        $("#dialog").dialog({
            position: "top",
            autoOpen : false,
            width : "90%",
            modal :true

        });
        
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
            $('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('span3 hide');
            $('.main-c').toggleClass('span8');
                
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
        StockItems vst = (StockItems) itmss.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getCode()%>_dialog").dialog({
        autoOpen : false,
        width : "90%",
        modal :true

    });
    
    
    
    $("#<%= vst.getCode()%>_stock").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getCode()%>_link").click(function(){
      
        $("#<%=vst.getCode()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getCode()%>_slink").click(function(){
        alert("");
        $("#<%=vst.getCode()%>_stock").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>
