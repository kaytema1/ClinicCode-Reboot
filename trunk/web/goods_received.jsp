<%@page import="entities.TransactionEntityManager"%>
<%@page import="java.util.Set"%>
<%@page import="helper.HibernateUtil"%>
<%@page import="entities.PurchaseOrderItems"%>
<%@page import="entities.PurchaseOrder"%>
<%@page import="entities.Supplier"%>
<%@page import="entities.UnitsOfMeasure"%>
<%@page import="entities.InventoryItems"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Users"%>
<%
    HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
    Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    String orderid = request.getParameter("orderid");
    if (orderid == null || orderid.equals("")) {
        response.sendRedirect("submittedorder.jsp");
    }
    TransactionEntityManager mgr = new TransactionEntityManager();
    //Session objectSession = mgr.getSession();
    PurchaseOrder order = new PurchaseOrder();
    PurchaseOrder purchaseOrder = (PurchaseOrder) mgr.getIntegerObject(order, Integer.parseInt(orderid));
%>
<!DOCTYPE html>
<html lang="en"> 
    <%@include file="widgets/css.jsp" %>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <%@include  file="widgets/header.jsp" %>
        <%@include  file="widgets/loading.jsp" %>
        <div class="main-container">

            <!-- Masthead
            ================================================== -->
            <header class="jumbotron subhead" id="overview">

                <div style="margin-top: 24px; margin-bottom: -50px;" class="subnav navbar-fixed-top">
                    <ul class="nav nav-pills" id="top-navigation-bar">

                        <li>
                            <a href="#">Dashboard</a>
                        </li>

                        <li class="active">
                            <a href="#">Inventory</a>
                        </li>

                        <li>
                            <a href="#">Point of Sale</a>
                        </li>

                    </ul>
                </div>

            </header>

            <div id="dashboard">

                <div id="content-wrapper" class="container-fluid"><!--content-wrapper starts-->
                    <div class="row-fluid">
                        <div class="main-c span11">

                            <div class="table-wrapper"><!--table wrapper starts-->

                                <form action="action/goodsreceivedAction.jsp" method="post">
                                    <div class="box-body row-fluid">

                                        <!--form starts-->
                                        <div id="form-properties" class="span12" style="alignment-adjust: central"><!-- form properties starts -->
                                            <div class="row-fluid">

                                                <div class="span5">

                                                    <div class="field-sep">
                                                        <div class="row-fluid">
                                                            <div class="span6">
                                                                <label for="grv-supplier"><b>Supplier</b></label>
                                                                <select id="grv-supplier" class="span12" name="supplier">
                                                                    <%List<Supplier> suppliers = mgr.listObjects("from Supplier");
                                                                        for (Supplier supplier : suppliers) {
                                                                    %>
                                                                    <option value="<%=supplier.getSupplierid()%>"><%=supplier.getName()%></option>
                                                                    <%}%>
                                                                </select>
                                                            </div>
                                                            <div class="span6">
                                                                <label for="grv-supplier-inv"><b>Supplier Invoice Number</b></label>
                                                                <input type="text" id="grv-supplier-inv" name="supplierinv" class="span12">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="field-sep">
                                                        <div class="row-fluid">
                                                            <div class="span6">
                                                                <label for="grv-num"><b>Invoice Date</b></label>
                                                                <input type="text" id="grv-date" name="invoicedate" class="span12"/>
                                                            </div>
                                                            <div class="span6">
                                                                <label for="grv-discount"><b>% Discount</b></label>
                                                                <input type="text" id="grv-discount" name="percentagediscount" class="span12">
                                                            </div>                      
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="span3">
                                                    <div class="field-sep">
                                                        <div class="row-fluid">
                                                            <!--div class="span6">
                                                                <label for="grv-discount"><b>% Discount</b></label>
                                                                <input type="text" id="grv-discount" name="percentagediscount" class="span12">
                                                            </div-->

                                                        </div>
                                                    </div>
                                                    <div class="field-sep">
                                                        <div class="row-fluid">

                                                            <div class="span6">
                                                                <label for="grv-discount"><b>GHC Discount</b></label>
                                                                <input type="text" id="price-grv-discount" name="pricediscount" class="span12">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="span3">
                                                    <div class="field-sep">
                                                        <div class="row-fluid">
                                                            <div class="span6">
                                                                <label for="grv-discount"><b>Comment</b></label>
                                                                <textarea name="comment" rows="4" cols="5"></textarea>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                        </div><!--form properties ends-->

                                        <div class="clearfix"></div>

                                        <!--form ends-->

                                        <table class="example "><!--TABLE STARTS-->
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Item Description</th>
                                                    <th>Batch Number</th>
                                                    <th>Expiry Date</th>
                                                    <th>Received</th>
                                                    <th>Unit Price</th>
                                                    <th>Vatable</th>
                                                    <th>Total</th>
                                                    <th>Taxed Total</th>
                                                    <th>Discount</th>
                                                    <th>Net</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% List<PurchaseOrderItems> purchaseOrderItemses = mgr.listObjects("from PurchaseOrderItems where orderid=" + purchaseOrder.getPurchaseOrderId());
                                                    for (PurchaseOrderItems purchaseOrderItems : purchaseOrderItemses) {
                                                %>

                                                <tr id="add-line">
                                                    <td><input type="checkbox" name="itemcode" value="<%=purchaseOrderItems.getInventoryItems().getItemCode()%>"/></td>

                                                    <td><%=purchaseOrderItems.getInventoryItems().getItemDescription() + " " + purchaseOrderItems.getInventoryItems().getStrength() + " " + purchaseOrderItems.getInventoryItems().getItemForm().getFormDescription()%></td>
                                                    <td><input type="text" name="batchnumber" class="span12" id="batchnumber_<%=purchaseOrderItems.getOrderItemsId()%>" value=""/></td> 
                                                    <td><input type="text" name="expiredate" class="span12" id="expirydate_<%=purchaseOrderItems.getOrderItemsId()%>" value=""/></td> 
                                                    <td><input type="text" name="qtyreceived" class="span12" id="qtyreceived_<%=purchaseOrderItems.getOrderItemsId()%>" value=""/></td>
                                                    <td><input type="text" name="purchaseprice" class="span12" id="purchaseprice_<%=purchaseOrderItems.getOrderItemsId()%>" value=""/></td>                                                   
                                                    <td>
                                                        <select name="taxamount_"  id="taxamount_<%=purchaseOrderItems.getOrderItemsId()%>" class="span12">
                                                            <option value="1" onclick ='getTaxAndTotal("<%=purchaseOrderItems.getOrderItemsId() + "_17.5"%>")'>Yes</option>
                                                            <option value="0" onclick ='getTaxAndTotal("<%=purchaseOrderItems.getOrderItemsId() + "_1"%>")'>No</option>
                                                        </select>
                                                    </td>
                                                    <td><input type="text" name="totalamount" class="span12" id="totalamount_<%=purchaseOrderItems.getOrderItemsId()%>" value=""/></td>
                                                    <td><input type="text" name="taxedtotalamount" class="span12" id="taxedtotalamount_<%=purchaseOrderItems.getOrderItemsId()%>" value=""/></td>

                                                    <td><input type="text" name="discount_" class="span12" id="discount_<%=purchaseOrderItems.getOrderItemsId()%>" value="0.00"/></td>
                                                    <td><input type="text" name="nettotal_" class="span12" id="nettoal_<%=purchaseOrderItems.getOrderItemsId()%>" value="0.00"/></td>
                                                </tr>
                                                <%}%>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td> 
                                                        <button class="btn btn-info" type="submit" name="action" value="addgoods" onclick='getValues();return false'>
                                                            <i class="icon-plus-sign icon-white"> </i> Get Overall Values
                                                        </button>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table><!--TABLE ENDS-->

                                    </div>

                                    <div class="row-fluid">
                                        <div class="span9">
                                        </div>
                                        <div class="span3 inv-sum">
                                            <div class="">
                                                <p>
                                                    Subtotal:
                                                    <span>
                                                        GHc
                                                        <span id="subtotal_">0.00</span>
                                                        <input type="hidden" name="subtotal" id="sub_total" class="span12"/>
                                                    </span>
                                                </p>
                                                <hr style="border: solid #000 thin"/>
                                                <p>
                                                    Taxed Total:
                                                    <span>
                                                        GHc
                                                        <span id="tax_">0.00</span>
                                                        <input type="hidden" name="totaltax" id="total_tax"class="span12"/>
                                                    </span>
                                                </p>

                                                <p>
                                                    Discount:
                                                    <span>
                                                        GHc
                                                        <span id="discountValue_">0.00</span>
                                                        <input type="hidden" name="netdiscount" id="disc" class="span12"/>
                                                    </span>
                                                </p>
                                                <hr style="border: solid #000 thin"/>
                                                <p>
                                                    <strong>
                                                        Balance:
                                                        <span>
                                                            GHc
                                                            <span id="balance_">0.00</span>
                                                            <input type="hidden" name="nettotal" id="net_total" class="span12"/>
                                                        </span>
                                                    </strong>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-actions text-center">
                                        <input type="hidden" name="orderid" id="orderid" class="span12" value="<%=purchaseOrder.getPurchaseOrderId()%>"/>
                                        <button class="btn btn-info" type="submit" name="action" value="addgoods" >
                                            <i class="icon-plus-sign icon-white"> </i> Add Items to Store
                                        </button>

                                    </div>
                                </form>
                            </div><!--table-wrapper ends-->

                        </div>

                    </div>

                </div><!--content-wrapper ends-->


            </div>

            <footer style="display: none; margin-top: 50px;" class="footer">
                <div class="container-fluid">
                    <div class="row-fluid">
                        <p style="text-align: center" class="pull-right">
                            <img src="images/logo-footer.png" width="124" height="23" />
                        </p>
                    </div>
                </div>
            </footer>

        </div><!-- /container -->

        <div style="display: none;" id="dialog" title="New Item">

            <!--<div style="margin-left: 50px;" class="btn-group dialog-control-btns" data-toggle="buttons-radio">
                    <button class="btn btn-primary">
                            Personal Information
                    </button>
                    <button class="btn btn-primary">
                            Address
                    </button>
                    <button class="btn btn-primary">
                            Medical Data
                    </button>
                    <button class="btn btn-primary">
                            Payment Information
                    </button>
            </div>
            <br />-->
            <div class="tabbable tabs-left">

                <ul class="nav nav-tabs" id="tab-nav">

                    <li class="active"><a href="#item-div" id="item-div" data-toggle="tab">Item Info</a></li>
                    <li><a href="#defaults-div" id="defaults-div" data-toggle="tab">Defaults</a></li>

                </ul>

                <div class="tab-content">

                    <form action="" method="POST" class="form-horizontal well">

                        <fieldset>

                            <div class="tab-pane active" id="item-div">
                                <div class="control-group">
                                    <label class="control-label" for="input01">Item Name </label>
                                    <div class="controls">
                                        <input type="text" name="patientid"  id="input01"/>
                                        <p class="help-inline">

                                        </p>
                                    </div>
                                </div>

                            </div>

                            <div class="tab-pane hide" id="defaults-div">
                                <div class="control-group">
                                    <label class="control-label" for="input01">Defaults </label>
                                    <div class="controls">
                                        <input type="text" name="patientid"  id="input01"/>
                                        <p class="help-inline">

                                        </p>
                                    </div>
                                </div>

                            </div>

                        </fieldset>
                    </form>

                </div>

            </div>




        </div>



        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <!--<script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltip.js"></script>
        <script src="js/bootstrap-popover.js"></script>
    <script src="js/bootstrap-button.js"></script>-->
        <script src="js/application.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>

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
        <script type="text/javascript" src="js/keyboard.js"></script>

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
                    if (!$(this).hasClass('active')) {
                        menu_a.removeClass('active');
                        menu_ul.filter(':visible').slideUp('normal');
                        $(this).addClass('active').next().stop(true, true).slideDown('normal');
                    } else {
                        $(this).removeClass('active');
                        $(this).next().stop(true, true).slideUp('normal');
                    }
                });

            });


            function addRow() {
                $('.example tbody').append(
                '<tr class="grv-line">' +
                    '<td class="delRow"><i class="icon-minus"></i></td>' +
                    '<td><input type="text" class="span12 item-code"></td>' +
                    '<td><input type="text" class="span12"></td>' +
                    '<td><input type="text" class="span12"></td>' +
                    '<td><input type="text" class="span12"></td>' +
                    '<td><input type="text" class="span12"></td>' +
                    '<td><input type="text" class="span12"></td>' +
                    '<td><input type="text" class="span12"></td>' +
                    '<td><input type="text" class="span12"readonly=""></td>' +
                    '<td><input type="text" class="span12"readonly=""></td>' +
                    '</tr>'
            );

                $('.delRow').bind('click', deleteRow);
                var row = $('#add-line-btn').parent();
                row.insertAfter(row.next());
                $('.example tbody tr').eq(row.index()-1).find('td input.item-code').focus();
            };

            function saveRow(obj) {
                var row = obj.parent().parent();
                var itemCode            = row.children('td:nth-child(2)');
                var itemDescription     = row.children('td:nth-child(3)');
                var itemWarehouse       = row.children('td:nth-child(4)');
                var itemQty             = row.children('td:nth-child(5)');
                var itemUnit            = row.children('td:nth-child(6)');
                var itemPrice           = row.children('td:nth-child(7)');
                var itemTaxRate         = row.children('td:nth-child(8)');
                var itemTax             = row.children('td:nth-child(9)');
                var itemTotal           = row.children('td:nth-child(10)');

                itemCode.html(itemCode.children("input[type=text]").val());

                itemDescription.html(itemDescription.children("input[type=text]").val());
                
                itemWarehouse.html(itemWarehouse.children("input[type=text]").val());
                
                itemQty.html(itemQty.children("input[type=text]").val());
                
                itemUnit.html(itemUnit.children("input[type=text]").val());
                
                itemPrice.html(itemPrice.children("input[type=text]").val());
                
                itemTaxRate.html(itemTaxRate.children("input[type=text]").val());
                
                itemTax.html(itemTax.children("input[type=text]").val());
                
                itemTotal.html(itemTotal.children("input[type=text]").val());
            };

            function deleteRow() {
                var row = $(this).parent();
                row.remove();
            };

            $(function() {
                $('#add-line-btn').bind('click', addRow);
            });


            //Bind shortcut to Add new row
            KeyboardJS.on('ctrl > x', function() {
                addRow();
            });

            $(document).keydown(function(e) {

                if( e.keyCode == 13 && $('.example tbody tr td input[type=text]').is(':focus') ) {
                    e.preventDefault();
                    //call save function here
                    saveRow($(':focus'));
                    addRow();
                    //alert('save'+ $(':focus').attr('class'));
                }

            });

        </script>

        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                queueTable = $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : false,
                    "bAutoWidth" : false,
                    "aoColumnDefs": [
                        { "bSortable": false, "aTargets": [0] },
                        {"sWidth": "0.5%", "aTargets":[0]},
                        {"sWidth": "20%", "aTargets":[2]}
                    ]
                });


                $("#customer_search").click(function() {
                    //alert("");
                    $("#customer_search_dialog").dialog('open')
                });

                $("#add-new-item").click(function(e) {
                    $("#dialog").dialog("open");
                    e.preventDefault();
                });
				
                $('#tab-nav a').click(function (e) {
                    e.preventDefault();
                    $(this).tab('show');
                })
				
                $('.patient').click(function() {
					
                    $('.patient').popover('toggle');
					
                });
				
                $(".dialog-control-btns button").click(function () {
                    $(this).button('toggle');
                });
                $(".patient_visit").popover({

                    placement : 'top',
                    animation : true

                });

                $('#sidebar-toggle').click(function(e) {
                    e.preventDefault();
                    $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                    //$('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('span2 hide');
                    $('.main-c').toggleClass('span10');
                    queueTable.fnAdjustColumnSizing();
                });

            });
            function getTaxAndTotal(tax){
                var selectedElements = tax.split("_");
                var qtyReceived = document.getElementById("qtyreceived_"+selectedElements[0]).value;
                var purchasePrice = document.getElementById("purchaseprice_"+selectedElements[0]).value;
                var grv_discount = document.getElementById("grv-discount").value;
                var taxVAlue = (selectedElements[1]/100)*(qtyReceived * purchasePrice)
                var discountValue = (grv_discount/100)*(qtyReceived * purchasePrice)
                document.getElementById("taxamount_"+selectedElements[0]).value = taxVAlue;
                document.getElementById("discount_"+selectedElements[0]).value = discountValue;
                document.getElementById("totalamount_"+selectedElements[0]).value = (qtyReceived * purchasePrice);
                var payable = (qtyReceived * purchasePrice) + taxVAlue;
                document.getElementById("nettoal_"+selectedElements[0]).value = payable-discountValue;
                document.getElementById("taxedtotalamount_"+selectedElements[0]).value = payable;
            }
            function getValues(){
                var total = document.getElementsByName("totalamount");
                var taxedtotal = document.getElementsByName("taxedtotalamount");
                var overallTotal=0;
                var taxedTotal=0;
                if(total.length>0){
                    for(var i=0;i<total.length;i++){
                        overallTotal += (total[i].value/1);
                        taxedTotal += (taxedtotal[i].value/1);
                    }
                }
                var subtotal_ = document.getElementById("subtotal_");
                var discount = document.getElementById("grv-discount").value;
                var discount_ = document.getElementById("discountValue_");
                var discountValue = (discount/100)*overallTotal;
                var balance_ = document.getElementById("balance_");
                var totalTaxed = document.getElementById("tax_");
                subtotal_.innerHTML = overallTotal;
                totalTaxed.innerHTML = taxedTotal;
                discount_.innerHTML = discountValue;
                balance_.innerHTML = taxedTotal - discountValue;
                
                document.getElementById("sub_total").value=overallTotal;
                document.getElementById("total_tax").value=taxedTotal;
                document.getElementById("net_total").value=taxedTotal  - discountValue;
                document.getElementById("disc").value=discountValue;
                document.getElementById("price-grv-discount").value=discountValue;
            }

        </script>

    </body>
</html>