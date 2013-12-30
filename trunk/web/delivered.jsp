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
            Date date = new Date();
            List itmss = mgr.listRequisitionByStatus("Delivered");
            List list = mgr.listStockItems();
            List items = null;
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");

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
            
            function updateUnit(id,id2){
                var id = document.getElementById(id).value;
                var code = document.getElementById(id2).value;
                $.post('action/requisitionaction.jsp', { action : "acceptpost", id : id, code:code}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                var con = confirm("Are You Sure You Want Cancel This Delivery");
                if (con ==true)
                {
                    $.post('action/requisitionaction.jsp', { action : "canceldelivery", id : id}, function(data) {
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
            function submitform(id){
                // var batch = document.getElementById(id).value;
                alert(id);
                $.post('action/treatgroupaction.jsp', { action : "treatmentbatch", batch : id}, function(data) {
                    alert(data);
                });
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
                            <a href="#">Inventory</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">
                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="display: none;" class="span8 thumbnail main-c">

                        <table class="example display">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Description</th>
                                    <th style="text-align: right;">Requested Qty </th>
                                    <th style="text-align: right;">Delivered Qty </th>
                                    <th>Requested On</th>
                                    <th>Delivered On</th>
                                   <!-- <th>Time</th>  -->
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
                                    <td style="text-align: right;"><%=itt.getRedquantity()%> </td>
                                    <td style="text-align: right;"><%=itt.getDeliveredquantity()%> </td>
                                    <td><%= formatter.format(itt.getOrderdate())%> </td>

                                    <td><%= formatter.format(itt.getDeliverydate())%>  </td>
                                   <!-- <td style="padding: 0px;"><%= time.format(itt.getDeliverytime())%></td>  -->
                                    <td>


                                        <button class="btn btn-small btn-danger" id="<%=itt.getRequisitionid()%>_post">
                                            Action
                                        </button>
                                        <div class="dialog" id="<%=itt.getRequisitionid()%>_postdialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> ADJUDICATE DELIVERIES  </span>">
                                            <table class="table table-striped table-condensed table-bordered">
                                                <thead>
                                                    <tr>

                                                        <th>Batch Number</th>
                                                        <th>Item</th>
                                                        <th>Available Quantity</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                    <% items = mgr.listPostedItemsByRequestid(itt.getRequisitionid());
                                                        int qy = 0;%>
                                                    <%=mgr.getStockItem(itt.getItemcode()).getDescription()%>: Requested (<%=itt.getRedquantity()%>)<br/> 
                                                    <%if (items != null) {
                                                            for (int t = 0; t < items.size(); t++) {
                                                                PostedItems table = (PostedItems) items.get(t);
                                                                qy = qy + table.getQunatity();
                                                    %>
                                                <tr>

                                                    <td style="text-transform: uppercase;"><%=table.getBatchNumber()%></td> 
                                                    <td><%=mgr.getStockItem(mgr.getItemTable(table.getBatchNumber()).getCode()).getDescription()%></td> 

                                                    <td><%=table.getQunatity()%></td>
                                                    <td>
                                                        <button class="btn btn-primary" id="batch_<%=table.getBatchNumber()%>" onclick='submitform("<%=table.getBatchNumber()%>");return false'>
                                                            <i class="icon-edit icon-white"> </i> Add to Stock 
                                                        </button>

                                                    </td>
                                                </tr>

                                                <%}
                                                    }%>
                                                <tr><td></td>
                                                    <td><b>Total Received</b></td>
                                                    <td><b><%=qy%></b></td>
                                                </tr>
                                                <tr>
                                                    <td><input type="hidden" name="dateposted" value="<%=itt.getRequisitionid()%>" id="id_<%=itt.getRequisitionid()%>"/>
                                                        <input type="hidden" name="dateposted" value="<%=itt.getItemcode()%>" id="code_<%=itt.getRequisitionid()%>"/>
                                                    </td>
                                                    <td>  <button class="btn btn-info" name="action" value="Post Items" onclick='updateUnit("id_<%=itt.getRequisitionid()%>","code_<%=itt.getRequisitionid()%>");return false;'>
                                                            <i class="icon-white icon-check"></i> Accept Items
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="itt" value="<%=itt.getRequisitionid()%>" id="id_<%=itt.getRequisitionid()%>"/>
                                                        <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=itt.getRequisitionid()%>");return false;'>
                                                            <i class="icon-remove icon-white"> </i> Cancel Delivery 
                                                        </button>
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>

                                        </div>
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

        //menu_ul.hide();

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
<% for (int i = 0;
            i < itmss.size();
            i++) {
        Requisitions itt = (Requisitions) itmss.get(i);;
%>
<script type="text/javascript">
    
    $("#<%= itt.getRequisitionid()%>_postdialog").dialog({
        autoOpen : false,
        width : "70%",
        modal :true,
        position :"top"
    });
   
    $("#<%= itt.getRequisitionid()%>_post").click(function(){
        $("#<%=itt.getRequisitionid()%>_postdialog").dialog('open');
    })
</script>
<% }%>

</body>
</html>