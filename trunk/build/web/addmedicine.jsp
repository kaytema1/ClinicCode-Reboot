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
    TransactionEntityManager mgr = new TransactionEntityManager();
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

                        <li>
                            <a href="#">Inventory</a><span class="divider"></span>
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

                        List<InventoryItems> inventoryItemses = mgr.listObjects("from InventoryItems");
                    %>     
                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="padding-bottom: 80px;" class="span8 thumbnail main-c">
                        <ul style="margin-left: 0px; padding: 15px;" class="breadcrumb">
                            <li class="pull-right">
                                <a href="#" class="dialog_link btn">
                                    <i class="icon-plus-sign"></i> Add New Item to Stock
                                </a>

                            </li>

                        </ul>
                        <table class="example display">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px;">
                                        Item Code 
                                    </th>
                                    <th style="font-size: 12px;">
                                        Item Description 
                                    </th>
                                    <th style="font-size: 12px;">
                                        Item Form
                                    </th>
                                    <th style="font-size: 12px;">
                                        Active Ingredients
                                    </th>
                                    <th style="font-size: 12px;">
                                        Manufacturer
                                    </th>
                                    <th style="font-size: 12px;">
                                        Unit of Issue
                                    </th>
                                    <th style="font-size: 12px;">
                                        Max. Stock Level
                                    </th>
                                    <th style="font-size: 12px;">
                                        Reorder Level
                                    </th>
                                    <th style="font-size: 12px;">
                                        Reorder Quantity
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (InventoryItems inventoryItems : inventoryItemses) {
                                        //ItemsTable itemsTable = (ItemsTable) itmss.get(i);
                                %>
                                <tr>
                                    <td style="text-transform: uppercase;">
                                        <%=inventoryItems.getItemCode() + " " + inventoryItems.getStrength()%>
                                    </td>
                                    <td>
                                        <%=inventoryItems.getItemDescription()%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <%=inventoryItems.getActiveIngredients()%>
                                    </td>
                                    <td>
                                        <%=inventoryItems.getManufacturer()%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <%=inventoryItems.getMaximumStockLevel()%>
                                    </td>
                                    <td>
                                        <%=inventoryItems.getReorderLevel()%>
                                    </td>
                                    <td>
                                        <%=inventoryItems.getReorderQty()%>
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
        <div style="display: none; width: 800px" id="dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> ADD TO INVENTORY STOCK </span>">
            <form class="form-horizontal" action="action/itemaction.jsp" method="post"  name="" >
                <fieldset>
                    <div class="pull-left">
                        <div class="control-group">
                            <label class="control-label" for="input01">Item Description</label>
                            <div class="controls">
                                <input type="text" class="input-xlarge" name="itemdescription" id="itemdescription">
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Item Form  </label>
                            <div class="controls">
                                <select name="itemform" id="itemform">
                                    <option>

                                    </option>
                                    <%  List<ItemForm> forms = mgr.listObjects("from ItemForm");
                                        for (ItemForm form : forms) {

                                    %>
                                    <option value="<%=form.getFormId()%>"><%=form.getFormDescription()%></option>
                                    <% }
                                    %>
                                </select>
                                <br/>
                                <p class="help-block"></p>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="input01">Item Strength</label>
                            <div class="controls">
                                <input type="text" name="itemstrength" class="input-small" id="itemstrength">
                                <br/>
                                <p class="help-block"></p>
                            </div>
                        </div> 
                        <div class="control-group">
                            <label class="control-label" for="input01">Active Ingredients</label>
                            <div class="controls">
                                <input type="text" name="activeingredients" class="input-xlarge" id="activeingredients">
                                <br/>
                                <p class="help-block"></p>
                            </div>
                        </div> 
                        <div class="control-group">
                            <label class="control-label" for="input01">Manufacturer</label>
                            <div class="controls">
                                <input type="text" name="manufacturer" class="input-small" id="manufacturer">
                                <br/>
                                <p class="help-block"></p>
                            </div>
                        </div> 
                        <div class="control-group">
                            <label class="control-label" for="input01">Therapeutic Group </label>
                            <div class="controls">
                                <select name="therapeutic" id="therapeutic">
                                    <option>
                                        
                                    </option>
                                    <%  List<TherapeuticGroup> groups = mgr.listObjects("from TherapeuticGroup");
                                            for (TherapeuticGroup group : groups) {
                                                String supplier = group.getDescription();%>
                                    <option value="<%=group.getTheraid()%>">
                                        <%=supplier%>
                                    </option>
                                    <% }
                                        %>
                                </select><br/>
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01"> Unit of Issue </label>
                            <div class="controls">
                                <select name="unitofmeasure" id="unitofmeasure">
                                    <option>

                                    </option>
                                    <%  List<UnitsOfMeasure> ofMeasures = mgr.listObjects("from UnitsOfMeasure");
                                        for (UnitsOfMeasure measure : ofMeasures) {

                                    %>
                                    <option value="<%=measure.getUnitId()%>"><%=measure.getUnitName()%></option>
                                    <% }
                                    %>
                                </select>
                                <p class="help-block"></p>
                            </div>
                        </div>
                    </div>
                    <div class="pull-left offset1">
                         <div class="control-group">
                            <label class="control-label" for="input01">Maximum Stock Level</label>
                            <div class="controls">
                                <input style="width: 60px;" type="text" name="maximumstocklevel" id="reorder">
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Re - Order Level </label>
                            <div class="controls">
                                <input style="width: 60px;" type="text" name="reorder" id="reorder">
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Minimum Stock Level </label>
                            <div class="controls">
                                <input style="width: 60px;" type="text" name="minimumstocklevel" id="emergency">
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Mark Up (Percentage)</label>
                            <div class="controls">
                                <input style="width: 60px;" type="text" name="percentagemarkup" id="emergency">
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Mark Up (Value)</label>
                            <div class="controls">
                                <input style="width: 60px;" type="text" name="valuemarkup" id="emergency">
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Vatable</label>
                            <div class="controls">
                                <Select name="vatable">
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </Select>
                                <p class="help-block"></p>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Location</label>
                            <div class="controls">
                                <Select name="location" multiple="multiple">
                                    <option value="PHY">Pharmacy Item</option>
                                    <option value="LAB">Laboratory Item</option>
                                    <option value="DIS">Dispensary</option>
                                </Select>
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
                    <button style="width: 90%" class="btn btn-info" type="submit" name="action" value="additem">
                        <i class="icon-plus-sign icon-white"> </i> Add to Dispensary Stock 
                    </button>
                </div>
            </form>
        </div>

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

</body>
</html>