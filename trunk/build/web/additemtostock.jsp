<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.util.Formatter"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");



        DecimalFormat df = new DecimalFormat();

        df.setMinimumFractionDigits(2);
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var code = document.getElementById("code").value;
                var quantity = document.getElementById("qty").value;
                var batchno = document.getElementById("batchno").value;
                var unitprice = document.getElementById("unitprice").value;
                var expirydate = document.getElementById("datepicker1").value;
                //var reorder = document.getElementById("reorder").value;
                //var emergency = document.getElementById("emergency").value;
                var supplier = document.getElementById("supplier").value;
                var manufacturer = document.getElementById("manufacturer").value;
                var location = document.getElementById("location").value;
                
                //var ty = document.getElementById("beds").value;
                $.post('action/additem.jsp', { action : "additemstock", code : code, quantity : quantity, batchno : batchno, unitprice : unitprice, expirydate : expirydate, supplier : supplier, manufacturer : manufacturer, location : location}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
            }
            function updateUnit(batchno,code,expirydate,unitprice,dispensing,nhis,pharmacy,laboratory,quantity,reorder,emergency,supplier,manufacturer,location){
                var code = document.getElementById(code).value;
                var expirydate = document.getElementById(expirydate).value;
                var batchno = document.getElementById(batchno).value;
                var unitprice = document.getElementById(unitprice).value;
                var dispensing = document.getElementById(dispensing).value;
                var nhis = document.getElementById(nhis).value;
                var pharmacy = document.getElementById(pharmacy).value;
                var laboratory = document.getElementById(laboratory).value;
                var quantity = document.getElementById(quantity).value;
                //var reorder = document.getElementById(reorder).value;
                //var emergency = document.getElementById(emergency).value;
                var supplier = document.getElementById(supplier).value;
                var manufacturer = document.getElementById(manufacturer).value;
                var location = document.getElementById(location).value;
                
                //var ty = document.getElementById("beds").value;
                $.post('action/additem.jsp', { action : "edititemstock", code : code, quantity : quantity, batchno : batchno, unitprice : unitprice, dispensing : dispensing, nhis : nhis, pharmacy : pharmacy, laboratory : laboratory, expirydate : expirydate, supplier : supplier, manufacturer : manufacturer, location : location}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                    
            }
            
            function deleteUnit(id,code){
                var id = document.getElementById(id).value;
                // var code = document.getElementById(code).value;
              
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/additem.jsp', { action : "deleteitemstock", id : id,code:code}, function(data) {
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
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
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
                        <li >
                            <a href="adminpanel.jsp">Admin Panel </a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Stock & Inventory </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        ExtendedHMSHelper itm = new ExtendedHMSHelper();
                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-YYYY");
                        List itmss = itm.listItems();

                        List list = itm.listStockItems();
                        List suppliers = itm.listSuppliersProper();
                        List manufarers = itm.listManufacturer();
                    %>     
                    <!--%@include file="widgets/adminpanelleftsidebar.jsp" %-->
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="margin-top: 0px; display: none "class="span8 main-c thumbnail">


                        <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                            <li>
                                <a>Items in Stock</a>

                            </li>
                            <li class="pull-right">
                                <a href="#" class="dialog_link btn">
                                    <i class="icon-plus-sign"></i> Add to Stock
                                </a>

                            </li>

                        </ul>
                        <table  class="example display table">
                            <thead>
                                <tr>
                                    <!--  <th>
                                          Code
                                      </th>   -->

                                    <th style="text-align: left;">
                                        Batch No.
                                    </th>
                                    <th style="text-align: left;"> 
                                        Product
                                    </th>

                                    <th style="width: 30px; text-align: left;">
                                        Quantity
                                    </th>
                                    <th style="width: 30px; text-align: left;">
                                        Expires On
                                    </th>

                                    <th style="text-align: left;">
                                        Manufacturer
                                    </th>
                                    <th style="width: 30px; text-align: left;">
                                        Location
                                    </th>
                                    <!--
                                                                            <th></th>-->
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (itmss != null) {
                                        for (int i = 0; i < itmss.size(); i++) {
                                            ItemsTable stockItems = (ItemsTable) itmss.get(i);
                                            System.out.println(stockItems);
                                            if (stockItems != null) {
                                %>
                                <tr>
                                    <!--   <td>
                                    <%=mgr.getStockItem(stockItems.getCode()) == null ? "" : mgr.getStockItem(stockItems.getCode()).getDescription()%>
                                </td>  -->
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 15px; ">
                                        <%=stockItems.getBatchNumber()%>
                                    </td>
                                    <td>
                                        <%= mgr.getStockItem(stockItems.getCode()).getDescription()%>
                                    </td>
                                    <td style="text-align: rightx"> 
                                        <%=stockItems.getQuantity()%>
                                    </td>
                                    <td>
                                        <%= formatter.format(stockItems.getExpiryDate())%>
                                    </td>


                                    <!-- <td> 
                                    <%=mgr.getSupplier(stockItems.getSupplier()) == null ? "" : mgr.getSupplier(stockItems.getSupplier()).getName()%>
                                </td>  -->
                                    <td> 
                                        <%=mgr.getManufacturer(stockItems.getManufacturer()) == null ? "" : mgr.getManufacturer(stockItems.getManufacturer()).getManufaturer()%>
                                    </td>
                                    <td style="text-align: left; text-transform: capitalize;"> 
                                        <%=stockItems.getLocationId()%>
                                    </td>
                                    <td>
                                        <button class="btn btn-inverse btn-mini" id="<%=stockItems.getBatchNumber()%>_link">
                                            Edit 
                                        </button>
                                        <div style="display: none; max-height: 500px;" id="<%=stockItems.getBatchNumber()%>_dialog" title="Editing <%=mgr.getStockItem(stockItems.getCode()) == null ? "" : mgr.getStockItem(stockItems.getCode()).getDescription()%>">
                                            <form style="padding: 0px; margin: 0px;" class="form-horizontal" action="action/additem.jsp" method="post" name="">
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Code</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="code_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getCode()%>" disabled="disabled">
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Batch Number </label>
                                                    <div class="controls">
                                                        <input type="text"  name="description" id="batch_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getBatchNumber()%>" disabled="disabled"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Expiry Date</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="expiry_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getExpiryDate()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Purchasing Price</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="price_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getPurchasingprice()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Dispensing Price</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="dispensing_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getDispensaryprice()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Pharmacy Price</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="pharmacy_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getPharmacyprice()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> NHIS Pricing</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="nhis_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getNhisprice()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Laboratory Price</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="lab_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getLaboratoryprice()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Quantity in Stock</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="qty_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getQuantity()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Re Order Level</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="reorder_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getReorderLevel()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Emergency Level</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="emergency_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getEmergencyLevel()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Supplier </label>
                                                    <div class="controls">
                                                        <select name="supplier" id="supplier_<%=stockItems.getBatchNumber()%>">

                                                            <%  if (suppliers != null) {
                                                                    for (int x = 0; x < suppliers.size(); x++) {
                                                                        Supplier itt = (Supplier) suppliers.get(x);
                                                                        String supplier = itt.getName();
                                                                        if (itt.getSupplierid() == stockItems.getSupplier()) {%>
                                                            <option value="<%=itt.getSupplierid()%>"><%=supplier%></option>
                                                            <%} else {%>
                                                            <option value="<%=itt.getSupplierid()%>"><%=supplier%></option>
                                                            <% }
                                                                    }
                                                                }%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Manufacturer </label>
                                                    <div class="controls">
                                                        <select name="manufacturer" id="manufacturer_<%=stockItems.getBatchNumber()%>">

                                                            <%   if (manufarers != null) {
                                                                    for (int z = 0; z < manufarers.size(); z++) {
                                                                        Manufacturer itt = (Manufacturer) manufarers.get(z);
                                                                        String supplier = itt.getManufaturer();
                                                                        if (itt.getManufacturerid() == stockItems.getManufacturer()) {%>
                                                            <option value="<%=itt.getManufacturerid()%>" selected="selected"><%=supplier%> </option>
                                                            <%} else {%>
                                                            <option value="<%=itt.getManufacturerid()%>"><%=supplier%> </option>
                                                            <% }
                                                                    }
                                                                }%>
                                                        </select>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01"> Location</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" id="location_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getLocationId()%>"/>
                                                        <p class="help-block"></p>
                                                    </div>
                                                </div>

                                                <div class="form-actions">
                                                    <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("batch_<%=stockItems.getBatchNumber()%>","code_<%=stockItems.getBatchNumber()%>","expiry_<%=stockItems.getBatchNumber()%>","price_<%=stockItems.getBatchNumber()%>","dispensing_<%=stockItems.getBatchNumber()%>","nhis_<%=stockItems.getBatchNumber()%>","pharmacy_<%=stockItems.getBatchNumber()%>","lab_<%=stockItems.getBatchNumber()%>","qty_<%=stockItems.getBatchNumber()%>","reorder_<%=stockItems.getBatchNumber()%>","emergency_<%=stockItems.getBatchNumber()%>","supplier_<%=stockItems.getBatchNumber()%>","manufacturer_<%=stockItems.getBatchNumber()%>","location_<%=stockItems.getBatchNumber()%>");return false;'>
                                                        <i class="icon-edit icon-white"> </i> Update Item 
                                                    </button>
                                                </div>
                                            </form> 
                                        </div>
                                    </td>
                                    <td>
                                        <form style="padding: 0px; margin: 0px;" action="action/additem.jsp" method="post">
                                            <input type="hidden" id="id_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getBatchNumber()%>"/> 

                                            <button class="btn btn-danger btn-mini" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=stockItems.getBatchNumber()%>","<%=stockItems.getCode()%>");return false;'>
                                                Delete
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
                    <div style="display: none;" id="dialog" title="New Item" >
                        <form id="additem" class="form-horizontal" action="action/additem.jsp" method="post"  name="" >
                           
                                <fieldset>
                                    <div class="pull-left">

                                        <div class="control-group">
                                            <label class="control-label" for="input01">Batch Number </label>

                                            <div class="controls">
                                                <input type="text" class="input-medium" name="batchno" id="batchno">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Select Item: </label>
                                            <div class="controls">
                                                <select name="code" id="code">
                                                    <option>
                                                        Select Item
                                                    </option>
                                                    <%  if (list != null) {
                                                            for (int i = 0; i < list.size(); i++) {
                                                                StockItems itt = (StockItems) list.get(i);
                                                    %>
                                                    <option value="<%=itt.getCode()%>">
                                                        <%= itt.getDescription()%>
                                                    </option>
                                                    <% }
                                                        }%>
                                                </select>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Quantity of Item  </label>
                                            <div class="controls">
                                                <input type="text" class="input-mini" name="qty" id="qty">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Purchasing / Unit Price  </label>
                                            <div class="controls">
                                                <input type="text" name="unitprice" id="unitprice">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="pull-left" >
                                        <!--div class="control-group">
                                            <label class="control-label" for="input01">Re - Order Level </label>
                                            <div class="controls">
                                                <input style="width: 60px;" type="text" name="reorder" id="reorder">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Emergency Order Level </label>
                                            <div class="controls">
                                                <input style="width: 60px;" type="text" name="emergency" id="emergency">
                                                <p class="help-block"></p>
                                            </div>
                                        </div-->
                                        <div class="control-group">
                                            <label class="control-label"  for="input01">Expiry Date </label>
                                            <div class="controls">
                                                <input type="date" class="date" name="expDate" id="datepicker1" >
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Item Supplier </label>
                                            <div class="controls">
                                                <select name="supplier" id="supplier">
                                                    <option>
                                                        Select Supplier
                                                    </option>
                                                    <%  if (suppliers != null) {
                                                            for (int i = 0; i < suppliers.size(); i++) {
                                                                Supplier itt = (Supplier) suppliers.get(i);

                                                                String supplier = itt.getName();%>
                                                    <option value="<%=itt.getSupplierid()%>">
                                                        <%=supplier%>
                                                    </option>
                                                    <% }
                                                        }%>
                                                </select><br/>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Item Manufacturer </label>
                                            <div class="controls">
                                                <select name="manufacturer" id="manufacturer">
                                                    <option>
                                                        Select Manufacturer
                                                    </option>
                                                    <%  if (manufarers != null) {
                                                            for (int i = 0; i < manufarers.size(); i++) {
                                                                Manufacturer itt = (Manufacturer) manufarers.get(i);

                                                                String supplier = itt.getManufaturer();%>
                                                    <option value="<%=itt.getManufacturerid()%>">
                                                        <%=supplier%>
                                                    </option>
                                                    <% }
                                                        }%>
                                                </select><br/>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"  for="input01">Location</label>
                                            <div class="controls">
                                                <input type="text" class="" name="location"  id="location">
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

                                <div class="form-actions center">
                                    <button class="btn btn-info btn-small" type="submit" name="action" value="additem" onclick="submitform();return false">
                                        <i class="icon-plus-sign icon-white"> </i> Add to Stock 
                                    </button>
                                </div>

                            
                        </form>
                    </div>
                </div>
                <div class="clearfix"></div>
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
            width : "50%",
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
        ItemsTable vst = (ItemsTable) itmss.get(i);
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
    
    $("#<%= vst.getCode()%>_stock").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getCode()%>_link").click(function(){
      
        $("#<%=vst.getCode()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getCode()%>_adddrug_link").click(function(){
        
        $("#<%=vst.getCode()%>_adddrug_dialog").dialog('open');
        
    })
    
    $("#<%= vst.getCode()%>_slink").click(function(){
       
        $("#<%=vst.getCode()%>_stock").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>
