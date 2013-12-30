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
                var startqty = document.getElementById("qty").value;
               
               // var startdate = document.getElementById("datepicker1").value;
                $.post('action/additem.jsp', { action : "inuse", code : code, startqty : startqty}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                //alert("aden");
            }
            function updateUnit(batchno,startqty){
                var code = document.getElementById(code).value;
                var startqty = document.getElementById(startqty).value;
                $.post('action/additem.jsp', { action : "inuseedit", batchno : batchno,startqty : startqty}, function(data) {
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
                    $.post('action/additem.jsp', { action : "deleteinuse", id : id,code:code}, function(data) {
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
                        List itmss = itm.listStockLabItemBatchInfo();

                        List list = itm.listLabStocks();
                        List suppliers = itm.listSuppliersProper();
                        List manufarers = itm.listManufacturer();
                    %>     
                    <!--%@include file="widgets/adminpanelleftsidebar.jsp" %-->
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <a>Items in Use</a>
                                </li>
                                <li class="pull-right">
                                    <% if (permissions.contains(68)) {%>
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> Items On Shelve
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
                                            Start Date
                                        </th>
                                        <th style="width: 30px; text-align: left;">
                                            Staff
                                        </th>
                                        <th style="width: 30px; text-align: left;">
                                            Start Quantity
                                        </th>
                                        
                                        <!--th></th>
                                        <th></th-->
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (itmss != null) {
                                            for (int i = 0; i < itmss.size(); i++) {
                                                LabStockItemBatchInfo stockItems = (LabStockItemBatchInfo) itmss.get(i);
                                                // System.out.println(stockItems);
                                                if (stockItems != null) {
                                    %>
                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 15px; ">
                                            <%=stockItems.getBatchNum()%>
                                        </td>
                                        <td>
                                             <%=mgr.getLabStockItem(mgr.getLabStock(stockItems.getBatchNum()).getItemId()).getName() %>
                                        </td>
                                        <td>
                                            <%= formatter.format(stockItems.getStartDate())%>
                                        </td>
                                        <td>
                                            <%= mgr.getStafftableByid(stockItems.getStaffId()).getLastname()+" "+mgr.getStafftableByid(stockItems.getStaffId()).getOthername() %>
                                        </td>
                                        <td style="text-align: center"> 
                                            <%=stockItems.getStartQty()%>
                                        </td>
                                        <!--td>
                                            <!--button class="btn btn-inverse btn-mini" id="<%=stockItems.getId()%>_link">
                                                Edit 
                                            </button-->
                                            <div style="display: none; max-height: 500px;" id="<%=stockItems.getId()%>_dialog" title="Editing <%=mgr.getLabStockItem(mgr.getLabStock(stockItems.getBatchNum()).getItemId()) == null ? "" : mgr.getLabStockItem(mgr.getLabStock(stockItems.getBatchNum()).getItemId()).getName() %>">
                                                <form style="padding: 0px; margin: 0px;" class="form-horizontal" action="action/additem.jsp" method="post" name="">


                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Batch Number </label>
                                                        <div class="controls">
                                                            <input type="text"  name="description" id="batch_<%=stockItems.getId()%>" value="<%=stockItems.getBatchNum()%>" disabled="disabled"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Start Date</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="expiry_<%=stockItems.getId()%>" value="<%=stockItems.getStartDate()%>"/>
                                                            
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Start Quantity</label>
                                                        <div class="controls">
                                                            <input type="text" name="code" id="qty_<%=stockItems.getId()%>" value="<%=stockItems.getStartQty()%>"/>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="form-actions">
                                                        <% if (permissions.contains(69)) {%>
                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("batch_<%=stockItems.getId()%>","expiry_<%=stockItems.getId()%>","qty_<%=stockItems.getId()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Item 
                                                        </button>
                                                            <%}%>
                                                    </div>
                                                </form> 
                                            </div>
                                        </td>
                                        <td>
                                            <!--form style="padding: 0px; margin: 0px;" action="action/additem.jsp" method="post">
                                                <input type="hidden" id="id_<%=stockItems.getId()%>" value="<%=stockItems.getId()%>"/> 

                                                <button class="btn btn-danger btn-mini" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=stockItems.getId()%>");return false;'>
                                                    Delete
                                                </button>
                                            </form>
                                        </td-->
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

                                            <label class="control-label" for="input01"> Select Item</label>
                                            <div class="controls">
                                                <select name="code" id="prod">

                                                    <%  if (list != null) {
                                                            for (int x = 0; x < list.size(); x++) {
                                                                LabStock itt = (LabStock) list.get(x);
                                                                String supplier = mgr.getLabStockItem(itt.getItemId()).getName()+" ("+itt.getBatchNumber()+")";
                                                    %>
                                                    <option value="<%=itt.getBatchNumber()%>"><%=supplier%></option>
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


                                    <div class="clearfix"></div>                

                                </fieldset>

                                <div class="form-actions center">
                                    <button class="btn btn-info btn-small" type="submit" name="action" value="additem" onclick="submitform();return false">
                                        <i class="icon-plus-sign icon-white"> </i> Add to Shelve 
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
        LabStockItemBatchInfo vst = (LabStockItemBatchInfo) itmss.get(i);
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
        
        $("#<%=vst.getId()%>_adddrug_dialog").dialog('open');
        
    })
    
    $("#<%= vst.getId()%>_slink").click(function(){
       
        $("#<%=vst.getId()%>_stock").dialog('open');
        
    })
   
    
</script>

<% }%>
</body>
</html>
