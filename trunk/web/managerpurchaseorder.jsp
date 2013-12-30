<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
<%@page import="java.util.Set"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<%
    HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
    Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            TransactionEntityManager mgr = new TransactionEntityManager();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();
            List<PurchaseOrder> itmss = mgr.listObjects("from PurchaseOrder where status='Pending'");
            List<InventoryItems> list = mgr.listObjects("from InventoryItems where quantity_on_hand < reorder_level");
            //Set<ItemBatch> items = null;


        %>
        <script>
            var addcount; 
            function addDiadChecks(id1,id2,id3){
                addcount++;
                var t1 = document.getElementById(id1).value;
                var qty = document.getElementById(id2).value
                var tr = document.createElement("tr");
                var td1 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                // var text = document.createTextNode(document.getElementById(id1).value);
                var cb = document.createElement( "input" );
                var put = document.createElement( "input" );
                var btn = document.createElement( "button" );
                btn.innerHTML = 'Remove';
                cb.type = "checkbox";
                put.type = "hidden";
                put.name = "qty[]";
                cb.id = "id";
                cb.name = "labtest";
                var ttt = t1;
                var str = t1.split("><");
                var text = document.createTextNode(str[1]);
                var text1 = document.createTextNode(qty);
                cb.value = str[0];
                put.value = qty
                cb.checked = true;
                td1.appendChild(text);
                td4.appendChild(text1);
                td4.appendChild(put);
                td6.appendChild(btn);
                alert(ttt)
                td5.appendChild(cb);
                tr.appendChild(td1);
                
                tr.id = "tr1_"+addcount;
                tr.appendChild(td4);
                tr.appendChild(td5);
               
                tr.appendChild(td6);
                document.getElementById(id3).appendChild(tr);
                var ch = document.getElementById("labtest");
               
                btn.onclick = function(){
                    var tbl = document.getElementById(id3);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
            }
            
            function updateUnit(id,qty,batch){
                var id = document.getElementById(id).value;
               
                var qty = document.getElementById(qty).value;
                var batch = document.getElementById(batch).value;
                $.post('action/requisitionaction.jsp', { action : "postitem", id : id, qty : qty, batch : batch}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function updateQty(id,qty){
                //var id = document.getElementById(id).value;
                var qty = document.getElementById(qty).value;
                $.post('action/orderaction.jsp', { action : "updateqty", id : id, qty : qty}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function sumit(id){
                document.forms[id].submit();
            }
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                var con = confirm("Are You Sure You Want Delete This Item");
                if (con ==true)
                {
                    $.post('action/requisitionaction.jsp', { action : "deleteitemstock", id : id}, function(data) {
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
                            <a href="#">All Requests </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">


                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="display: none;"  class="span8 thumbnail main-c">
                        <ul style="margin-left: 0px; padding-bottom: 0px;" class="breadcrumb">

                            <li>
                                <a style="font-size: 15px; margin-top: 10px;" href="#"> Pending Orders  </a><span class="divider"></span>
                            </li>
                            <li class="pull-right">
                                <a href="#" class="dialog_link btn">
                                    <i class="icon-plus-sign"></i> New Purchase Order
                                </a>
                            </li>
                        </ul>

                        <table class="example display">
                            <thead>
                                <tr>
                                    <th>Order Id</th>
                                    <th>Staff In Charge</th>
                                    <th>Date generated</th>
                                    <th></th>

                                </tr>
                            </thead>
                            <tbody>
                                <%  for (PurchaseOrder itt : itmss) {
                                    if (itt.getStafftableByApprovedByManager() == null) {
                                        //InventoryItems ii = itt.getInventoryItems();

                                %>
                                <tr> 
                                    <td><%=itt.getPurchaseOrderId()%> </td>
                                    <td><%=itt.getStafftableByOrderingStaff().getLastname() + " " + itt.getStafftableByOrderingStaff().getOthername()%></td>
                                    <td><%=formatter.format(itt.getDateOfOrder())%> </td>

                                    <td>
                                        <button class="btn btn-info btn-small" id="<%=itt.getPurchaseOrderId()%>_post">
                                            View Item Details
                                        </button>
                                        <div class="dialog" id="<%=itt.getPurchaseOrderId()%>_postdialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> REQUEST APPROVAL  </span>">


                                            <form action="action/orderaction.jsp" method="post" name="form_<%=itt.getPurchaseOrderId()%>" id="form_<%=itt.getPurchaseOrderId()%>">
                                                <div class="thumbnail">
                                                    <div class="lead center">CURRENT REQUEST (# <%=itt.getPurchaseOrderId()%>)</div>
                                                    <div class="clearfix">
                                                        <%//List<PurchaseOrderItems> purchaseOrderItemses = mgr.listObjects("from PurchaseOrderItems where orderid="+itt.getPurchaseOrderId()); 
                                                            List<PurchaseOrderItems> purchaseOrderItemses = mgr.listObjects("from PurchaseOrderItems where orderid=" + itt.getPurchaseOrderId());
                                                        %>
                                                    </div>
                                                    <table class="table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 80%">Description</th>
                                                                <th style="text-align: right;">Quantity Requested </th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%if (purchaseOrderItemses != null) {
                                                                    for (PurchaseOrderItems orderItems : purchaseOrderItemses) {%>
                                                            <tr>
                                                                <td>
                                                                    <%=orderItems.getInventoryItems().getItemDescription()%>
                                                                </td>
                                                                <td style="text-align: right;">
                                                                    <input type="text" name="quantity" id="qty_<%=orderItems.getQuantityOrdered()%>"value="<%=orderItems.getQuantityOrdered()%>"/>
                                                                </td>
                                                                <td>
                                                                    <button  class="btn btn-info" name="action" value="Post Items" onclick='updateQty("<%=orderItems.getOrderItemsId()%>","qty_<%=orderItems.getQuantityOrdered()%>");return false;'>
                                                                        <i class="icon-white icon-check"></i> Update
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <%}
                                                                }%>
                                                        </tbody>
                                                    </table>
                                                    <div style="padding-left:  7%" class="form-actions">
                                                        <input type="hidden" name="orderid" value="<%=itt.getPurchaseOrderId()%>"/>
                                                        <button class="btn btn-danger" style="width: 95%;"  name="action" value="managerapproveorder">
                                                            <i class="icon-arrow-right icon-white"> </i> Approve Order
                                                        </button>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                        </div>
                                    </td>

                                </tr>
                                <%}
                                }%> 
                            </tbody>
                        </table>
                    </div>

                    <div class="clearfix"></div>
                </div>
                <div style="display: none;" id="dialog" title="New Request">
                    <form class="form-horizontal" action="action/orderaction.jsp" method="post" >
                        <fieldset>

                            <table id="appendd" class="table">
                                <thead>
                                    <tr style="padding: 12px 0px 12px 0px;">
                                        <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                            Selected Items
                                        </th>
                                        <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                            Confirmed
                                        </th>
                                        <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                            Quantity
                                        </th>

                                    </tr>
                                </thead>
                                <tbody id="tbody">
                                    <%   for (InventoryItems itt : list) {%>
                                    <tr>
                                        <td>
                                            <label class="control-label" for="input01"> <%=itt.getItemDescription()%></label>
                                        </td>
                                        <td>
                                            <input type="checkbox" name="items" id="confirm" value="<%=itt.getItemCode()%>" checked="checked"/>
                                        </td>
                                        <td>
                                            <input type="text" name="quantity_<%=itt.getItemCode()%>" id="quantity" value="<%=itt.getReorderQty()%>">
                                        </td>

                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>

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
    function editRecord(id){
        var f=document.form;
        f.method="post";
        f.action='updateItems.jsp?id='+id;
        f.submit();
    }
    function deleteRecord(id){
        var f=document.form;
        f.method="post";
        f.action='delete.jsp?id='+id;
        f.submit();
    }
    function postItem(id){
        var f=document.form;
        f.method="post";
        f.action='postItem.jsp?id='+id;
        f.submit();
    }
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
        $("#dialog").dialog({
            autoOpen : false,
            width : 500,
            modal :true
        });
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
            "sScrollY" : "400px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        }); 
        
        
        
    });

</script>
<% for (PurchaseOrder itt : itmss) {
        //Requisitions itt = (Requisitions) itmss.get(i);;
%>
<script type="text/javascript">
    
    $("#<%= itt.getPurchaseOrderId()%>_postdialog").dialog({
        autoOpen : false,
        width : "80%",
        modal :true,
        position : "top"
    });
   
    $("#<%= itt.getPurchaseOrderId()%>_post").click(function(){
        $("#<%=itt.getPurchaseOrderId()%>_postdialog").dialog('open');
    })
</script>
<% }%>

</body>
</html>