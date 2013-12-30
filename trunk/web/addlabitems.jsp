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
                var code = document.getElementById("prod").value;
                var quantity = document.getElementById("qty").value;
                var batchno = document.getElementById("batchno").value;
                var unitprice = document.getElementById("unitprice").value;
                var expirydate = document.getElementById("datepicker1").value;
                //var reorder = document.getElementById("reorder").value;
                //var emergency = document.getElementById("emergency").value;
                var supplier = document.getElementById("supplier").value;
                var manudate = document.getElementById("datepicker2").value;
                //var ty = document.getElementById("beds").value;
                $.post('action/additem.jsp', { action : "additemlabstock", code : code, quantity : quantity, batchno : batchno, unitprice : unitprice, expirydate : expirydate, supplier : supplier, manudate : manudate}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
            }
            function updateUnit(batchno,code,expirydate,unitprice,quantity,manufacturer,supplier,total){
                var code = document.getElementById(code).value;
                var expirydate = document.getElementById(expirydate).value;
                var batchno = document.getElementById(batchno).value;
                //alert(batchno)
                var unitprice = document.getElementById(unitprice).value;
                var quantity = document.getElementById(quantity).value;
                var supplier = document.getElementById(supplier).value;
                var manufacturer = document.getElementById(manufacturer).value;
                var total = document.getElementById(total).value;
                //alert(supplier)
                //var ty = document.getElementById("beds").value;
                $.post('action/additem.jsp', { action : "editlabitemstock", batchno : batchno,code : code, expirydate : expirydate, unitprice : unitprice, quantity : quantity, manufacturer : manufacturer, supplier : supplier,  total : total}, function(data) {
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

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        ExtendedHMSHelper itm = new ExtendedHMSHelper();
                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-YYYY");
                        List itmss = itm.listLabStocks();

                        List list = itm.listLabStockItems();
                        List suppliers = itm.listSuppliersProper();
                        List manufarers = itm.listManufacturer();
                    %>     
                    <!--%@include file="widgets/adminpanelleftsidebar.jsp" %-->
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a>Items in Stock</a>
                                </li>
                                <li class="pull-right">
                                    <% if (permissions.contains(65)) {%>
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> Receive Items to Stock
                                    </a>
<%}%>
                                </li>

                            </ul>
                            <table  class="example display table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;">
                                            Batch No.
                                        </th>
                                        <th style="text-align: left;"> 
                                            Product
                                        </th>

                                        <th style="width: 30px; text-align: left;">
                                            Expiry Date
                                        </th>
                                        <th style="width: 30px; text-align: left;">
                                            Unit Price
                                        </th>
                                        <th style="width: 30px; text-align: left;">
                                            Quantity
                                        </th>
                                        <th style="width: 30px; text-align: left;">
                                            Total Price
                                        </th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (itmss != null) {
                                            for (int i = 0; i < itmss.size(); i++) {
                                                LabStock stockItems = (LabStock) itmss.get(i);
                                                // System.out.println(stockItems);
                                                if (stockItems != null) {
                                    %>
                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 15px; ">
                                            <%=stockItems.getBatchNumber()%>
                                        </td>
                                        <td>
                                            <%= mgr.getLabStockItem(stockItems.getItemId()).getName()%>
                                        </td>
                                        <td>
                                            <%= formatter.format(stockItems.getExpiryDate())%>
                                        </td>
                                        <td>
                                            <%= stockItems.getUnitPrice()%>
                                        </td>
                                        <td style="text-align: center"> 
                                            <%=stockItems.getQty()%>
                                        </td>
                                        <td style="text-align: center"> 
                                            <%=stockItems.getTotalPrice()%>
                                        </td>


                                        <td>
                                            <% if (permissions.contains(67)) {%>
                                            <button class="btn btn-inverse btn-mini" id="<%=stockItems.getBatchNumber()%>_link">
                                                Edit 
                                            </button>
                                                <%}%>
                                            <div style="display: none; max-height: 500px;" id="<%=stockItems.getBatchNumber()%>_dialog" title="Editing <%=mgr.getLabStockItem(stockItems.getItemId()) == null ? "" : mgr.getLabStockItem(stockItems.getItemId()).getName()%>">
                                                <form style="padding: 0px; margin: 0px;" class="form-horizontal" action="action/additem.jsp" method="post" name="">


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
                                                            <input type="hidden" name="code" id="code_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getItemId()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Manufacturing Date</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="manu_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getManufactureDate()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Purchasing Price</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="price_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getUnitPrice()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Quantity in Stock</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="qty_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getQty()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Total Price</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="total_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getTotalPrice()%>"/>
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
                                                                            if (itt.getSupplierid() == stockItems.getLabStockItemDistributorId()) {%>
                                                                <option value="<%=itt.getSupplierid()%>"><%=supplier%></option>
                                                                <%} else {%>
                                                                <option value="<%=itt.getSupplierid()%>"><%=supplier%></option>
                                                                <% }
                                                                        }
                                                                    }%>
                                                            </select>
                                                        </div>
                                                    </div>
                                                            <% if (permissions.contains(66)) {%>
                                                    <div class="form-actions">
                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("batch_<%=stockItems.getBatchNumber()%>","code_<%=stockItems.getBatchNumber()%>","expiry_<%=stockItems.getBatchNumber()%>","price_<%=stockItems.getBatchNumber()%>","qty_<%=stockItems.getBatchNumber()%>","manu_<%=stockItems.getBatchNumber()%>","supplier_<%=stockItems.getBatchNumber()%>","total_<%=stockItems.getBatchNumber()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Item 
                                                        </button>
                                                            <%}%>
                                                    </div>
                                                </form> 
                                            </div>
                                        </td>
                                        <td>
                                            <form style="padding: 0px; margin: 0px;" action="action/additem.jsp" method="post">
                                                <input type="hidden" id="id_<%=stockItems.getBatchNumber()%>" value="<%=stockItems.getBatchNumber()%>"/> 

                                                <button class="btn btn-danger btn-mini" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=stockItems.getBatchNumber()%>","<%=stockItems.getItemId()%>");return false;'>
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

                    </div>
                    <div class="clearfix"></div>
                    <div style="display: none;" id="dialog" title="New Item" >
                        <form class="form-horizontal" action="action/additem.jsp" method="post"  name="" >
                            <div style="padding-bottom: 10px;" class="span10 content bs-docs-example">
                                <fieldset>
                                    <div class="pull-left">

                                        <div class="control-group">
                                            <label class="control-label" for="input01">New Batch Number </label>

                                            <div class="controls">
                                                <input type="text" class="input-medium" name="batchno" id="batchno">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">

                                            <label class="control-label" for="input01"> Select Item</label>
                                            <div class="controls">
                                                <select name="code" id="prod">

                                                    <%  if (list != null) {
                                                            for (int x = 0; x < list.size(); x++) {
                                                                LabStockItem itt = (LabStockItem) list.get(x);
                                                                String supplier = itt.getName();
                                                    %>
                                                    <option value="<%=itt.getId()%>"><%=supplier%></option>
                                                    <% }
                                                        }%>
                                                </select>
                                            </div>
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

                                    <div class="control-group">
                                        <label class="control-label"  for="input01">Expiry Date </label>
                                        <div class="controls">
                                            <input type="date" class="date" name="expDate" id="datepicker1" >
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"  for="input01">Manufactured Date </label>
                                        <div class="controls">
                                            <input type="date" class="date" name="manuDate" id="datepicker2" >
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

                                    <div class="clearfix"></div>                

                                </fieldset>

                                <div class="form-actions center">
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
            width : 900,
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
        LabStock vst = (LabStock) itmss.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getBatchNumber()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getBatchNumber()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
    $("#<%= vst.getBatchNumber()%>_stock").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getBatchNumber()%>_link").click(function(){
      
        $("#<%=vst.getBatchNumber()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getBatchNumber()%>_adddrug_link").click(function(){
        
        $("#<%=vst.getBatchNumber()%>_adddrug_dialog").dialog('open');
        
    })
    
    $("#<%= vst.getBatchNumber()%>_slink").click(function(){
       
        $("#<%=vst.getBatchNumber()%>_stock").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>
