<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();
            List itmss = mgr.listRequisitionByStatus("Pending");
            List list = mgr.listStockItems();
            List items = null;

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
                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">All Requests </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">


                <div class="row">

                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <!--ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn">
                                        <i class="icon-plus-sign"></i> New Request
                                    </a>
                                </li>
                                <li class="active">
                                    <a href="#"></a><span class="divider"></span>
                                </li>
                            </ul-->
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>Code</th>
                                        <th>Description</th>

                                        <th>Quantity</th>

                                        <th>Requested By</th>
                                        <th>Unit</th>
                                        <th>Requested On</th>
                                        <th>Time</th>
                                        <th></th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%  for (int i = 0; i < itmss.size(); i++) {
                                            Requisitions itt = (Requisitions) itmss.get(i);
                                    %>
                                    <tr>
                                        <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Item </h3> <h5><%=mgr.getStockItem(itt.getItemcode()) == null ? "" : mgr.getStockItem(itt.getItemcode()).getDescription()%></h5></td></tr>  </table> "> <%=itt.getItemcode()%>   </td>
                                        <td><%=mgr.getStockItem(itt.getItemcode()) == null ? "" : mgr.getStockItem(itt.getItemcode()).getDescription()%></td>
                                        <td style="text-align: right; padding-right: 20px;"><%=itt.getRedquantity()%> </td>
                                        <td><%=mgr.getStafftableByid(itt.getOrderer()) == null ? "" : mgr.getStafftableByid(itt.getOrderer()).getLastname() + " " + mgr.getStafftableByid(itt.getOrderer()).getOthername()%>   </td>


                                        <td><%=itt.getUnit()%> </td>
                                        <td><%=formatter.format(itt.getOrderdate())%> </td>
                                        <td><%=time.format(itt.getOrderdate())%> </td>
                                        <td>
                                            <button class="btn btn-info btn-small" id="<%=itt.getRequisitionid()%>_post">
                                                Respond to Request
                                            </button>
                                            <div class="dialog" id="<%=itt.getRequisitionid()%>_postdialog" title="Respond to Request">
                                                <div class="well thumbnail">

                                                    <form action="action/requisitionaction.jsp" method="post" name="form_<%=itt.getRequisitionid()%>" id="form_<%=itt.getRequisitionid()%>">
                                                        <h3 class="center">Request</h3>
                                                        <table>
                                                            <thead>
                                                                <tr>

                                                                    <th>Description</th>

                                                                    <th style="text-align: right;">Quantity Requested </th>
                                                                </tr>

                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <%=mgr.getStockItem(itt.getItemcode()).getDescription()%>
                                                                    </td>
                                                                    <td style="text-align: right;">
                                                                        <%=itt.getRedquantity()%>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        <h3 class="center">Response</h3>
                                                        <% items = mgr.listItemsByIemCode(itt.getItemcode());%>
                                                        <%=mgr.getStockItem(itt.getItemcode()).getDescription()%>: Requested (<%=itt.getRedquantity()%>)<br/> 

                                                        <table>
                                                            <thead>
                                                                <tr>
                                                                    <th>Select Batch</th>
                                                                    <th>Batch Number</th>
                                                                    <th>Description</th>

                                                                    <th>Quantity Available </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%if (items != null) {
                                                                        for (int t = 0; t < items.size(); t++) {
                                                                            ItemsTable table = (ItemsTable) items.get(t);
                                                                %>
                                                                <tr>
                                                                    <td style="text-align: center;">  <input type="checkbox" name="checkus[]" value="<%=table.getBatchNumber()%>"/></td>
                                                                    <td style="text-transform: uppercase;"><%=table.getBatchNumber()%></td> 
                                                                    <td><%=mgr.getStockItem(table.getCode()).getDescription()%></td> 

                                                                    <td><input type="text" style="text-align: right;" class="input-mini pull-right" name="quantity_<%=table.getBatchNumber()%>" value="<%=table.getQuantity()%>" id="qty_<%=itt.getRequisitionid()%>"/>
                                                                </tr>
                                                                <%}
                                                                }%>
                                                            </tbody>
                                                        </table>
                                                        <div style="text-align: center;" class="form-actions">
                                                            <input type="hidden" name="action" value="postitem"/>
                                                            <input type="hidden" name="requestid" value="<%=itt.getRequisitionid()%>" id="id_<%=itt.getRequisitionid()%>"/>

                                                            <button class="btn btn-info" name="action" value="postitem" onclick='submit("form_<%=itt.getRequisitionid()%>");return false;'>
                                                                <i class="icon-white icon-check"></i> Post Response
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>

                                    </tr>
                                    <%}%> 
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div style="display: none;" id="dialog" title="New Request">
                    <form class="form-horizontal" action="action/requisitionaction.jsp" method="post" >
                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01">Select Item: </label>
                                <div class="controls">
                                    <select name="code" id="code">
                                        <option>
                                            Select Item
                                        </option>
                                        <%   for (int i = 0; i < list.size(); i++) {
                                                StockItems itt = (StockItems) list.get(i);
                                        %>
                                        <option value="<%=itt.getCode()%>><<%= itt.getDescription()%>">
                                            <%= itt.getDescription()%>
                                        </option>
                                        <% }%>
                                    </select>
                                    <p class="help-block"></p>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="input01"> Quantity</label>
                                <div class="controls">
                                    <input type="text" name="quantity" id="quantity">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addDiadChecks("code","quantity","appendd");return false;'>
                                        <i class="icon-white icon-pencil"> </i>   Add Item
                                    </button>
                                </div>
                            </div>
                            <br/>
                            <table id="appendd" class="table">
                                <thead>
                                    <tr style="padding: 12px 0px 12px 0px;">
                                        <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                            Selected Items
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tbody">
                                </tbody>
                            </table>

                            <div class="form-actions">
                                <button class="btn btn-info"  name="action" value="Dispensary">
                                    <i class="icon-plus-sign icon-white"> </i> Request Item 
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
            "sScrollY" : "400px",
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
        Requisitions itt = (Requisitions) itmss.get(i);;
%>
<script type="text/javascript">
    
    $("#<%= itt.getRequisitionid()%>_postdialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true
    });
   
    $("#<%= itt.getRequisitionid()%>_post").click(function(){
        $("#<%=itt.getRequisitionid()%>_postdialog").dialog('open');
    })
</script>
<% }%>

</body>
</html>