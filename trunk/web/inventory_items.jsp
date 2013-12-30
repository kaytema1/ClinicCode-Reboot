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
            function submitform(id){
                // var batch = document.getElementById(id).value;
                alert(id);
                $.post('action/treatgroupaction.jsp', { action : "treatmentbatch", batch : id}, function(data) {
                    //alert(data);
                });
            }
            
            function updateUnit(id,group,tgroup,gdrg,treat,uprice,price){
               
                var id = document.getElementById(id).value;
                var group = document.getElementById(group).value;
                var gdrg = document.getElementById(gdrg).value;
                var tgroup = document.getElementById(tgroup).value;
                var uprice = document.getElementById(uprice).value;
                var treat = document.getElementById(treat).value;
                var price = document.getElementById(price).value;
                $.post('action/treatgroupaction.jsp', { action : "edittreatment", id : id, group : group, gdrg : gdrg, tgroup : tgroup, uprice : uprice, treat : treat, price : price}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                // alert(icd)
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/treatgroupaction.jsp', { action : "deletetreatment", id : id}, function(data) {
                        alert(data);
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancelled!");
                    //return;
                }
                 
                
            }
            
            function validateForm()
            {
                var x=document.forms["items"]["gdrg"].value;
                if (x==null || x=="")
                {
                    // alert("Item must be filled out");
                    return false;
                }
        
                var x=document.forms["items"]["desc"].value;
                if (x==null || x=="")
                {
                    // alert("Item must be filled out");
                    return false;
                }
        
                var x=document.forms["items"]["theragroup"].value;
                if (x==null || x=="")
                {
                    // alert("Item must be filled out");
                    return false;
                }
        
                var x=document.forms["items"]["group"].value;
                if (x==null || x=="")
                {
                    // alert("Item must be filled out");
                    return false;
                }
        
                var x=document.forms["items"]["unitprice"].value;
                if (x==null || x=="")
                {
                    // alert("Item must be filled out");
                    return false;
                }
        
                var x=document.forms["items"]["price"].value;
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
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li style="left: 0px;" class="active">
                            <a href="#">Clinic Inventory</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>



            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        List itmss = mgr.listItems();
                    %>     


                    <div style="padding-bottom: 80px;" class="thumbnail main-c">
                        <ul style="margin-left: 0px; padding: 15px;" class="breadcrumb">
                            <li>
                                <h4>Add Items to Stock</h4>
                            </li>

                        </ul>
                        <table class="example display">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px; text-align: left;">
                                        BATCH NO. 
                                    </th>

                                    <th style="font-size: 12px;text-align: left;">
                                        Drug Name
                                    </th>

                                    <th style="font-size: 12px;text-align: left;">
                                        Manufacturer
                                    </th>
                                    <th style="font-size: 12px; text-align: left;">
                                        Unit
                                    </th>
                                    <th style="font-size: 12px; text-align: left;">
                                        Price (GHS)
                                    </th>
                                    <!--  <th style="font-size: 12px;">
                                          Private Price 
                                      </th>  -->
                                    <th style="font-size: 12px; text-align: left;">
                                        Expires On 
                                    </th>


                                    <th style="font-size: 12px; text-align: left;">
                                        Supplier
                                    </th>

                                    <th style="font-size: 12px; text-align: left;">
                                        Therapeutic Group 
                                    </th>
                                    <th style="font-size: 12px; text-align: left;">
                                        GDRG CODE 
                                    </th>

                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < itmss.size(); i++) {
                                        InventoryItems itemsTable = (InventoryItems) itmss.get(i);
                                %>
                                <tr>
                                    <td style="text-transform: uppercase;">
                                        <%=itemsTable.getBatchNumber()%>
                                    </td>
                                    <td>
                                        <%=mgr.getStockItem(itemsTable.getCode()).getDescription()%>
                                    </td>
                                    <td>
                                        <%= itemsTable.getManufacturer() %>
                                    </td>
                                    
                                    <td>
                                        <%=mgr.getStockItem(itemsTable.getCode()).getUnitOfPricing()%>
                                    </td>
                                   
                                    <td>
                                        <%=df.format(itemsTable.getPharmacyprice())%>
                                    </td>
                                    <td>
                                        <%=mgr.getTherapeuticGroup(mgr.getStockItem(itemsTable.getCode()).getTheragroup()).getDescription()%>
                                    </td>
                                    <td>
                                        <%=mgr.getSupplier(itemsTable.getSupplier()).getName() %>
                                    </td>

                                    <td>
                                        <%=itemsTable.getCode()%>
                                    </td>

                                    <td style="padding: 0px; text-align: center;">

                                        <button class="btn btn-info btn-mini" id="batch_<%=itemsTable.getBatchNumber()%>" onclick='submitform("<%=itemsTable.getBatchNumber()%>");return false'>
                                            Add to Stock 
                                        </button>

                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>


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
<script type="text/javascript" src="js/demo.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>

<!--initiate accordion-->
<script type="text/javascript">
    $(function() {


        
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        //menu_ul.hide();

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
            "sScrollY": "300px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
        
        

    });
    
    
    
   
</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        InventoryItems vst = (InventoryItems) itmss.get(i);
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
    
   
    
    $("#<%= vst.getBatchNumber()%>_link").click(function(){
      
        $("#<%=vst.getBatchNumber()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getBatchNumber()%>_adddrug_link").click(function(){
        
        $("#<%=vst.getBatchNumber()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>