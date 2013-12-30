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
        <meta charset="utf-8">
        <title>ClaimSync Extended</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <link href="css/docs.css" rel="stylesheet">
        <link rel="stylesheet" href="css/styles.css">

        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            List itmss = mgr.listRequisitionByStatus("Delivered");
            List list = mgr.listRequisitionByStatus("Approved");
            List list1 = mgr.listRequisitionByStatus("Cancelled");
            itmss.addAll(list);
            itmss.addAll(list1);
            //List list = mgr.listStockItems();

        %>

        <style type="text/css" title="currentStyle">
            @import "css/jquery.dataTables_themeroller.css";
            @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
            body {
                overflow: hidden;
            }

            .large_button {
                background-color: #FBFBFB;
                background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
                background-repeat: repeat-x;
                border: 1px solid #DDDDDD;
                border-radius: 3px 3px 3px 3px;
                box-shadow: 0 1px 0 #FFFFFF inset;
                list-style: none outside none;
                font-weight: lighter;
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
                font-size: 36px;
                /* padding: 7px 14px; */
            }

            .large_button:hover {
                background-color: #35AFE3;
                background-image: -moz-linear-gradient(center top , #45C7EB, #2698DB);
                box-shadow: 0 1px 0 0 #6AD2EF inset;
                color: #FFFFFF;
                text-decoration: none;
            }


            .table th {
                border-top: 1px solid #DDDDDD;
                line-height: 8px;
                text-align: center;
                vertical-align: top;
                color: #000000;
                font-size: 8px;
            }

            .table td {
                padding: 6px;
                padding-bottom: 0px;
                line-height: 18px;
            }

        </style>
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
            
            function updateUnit(id){
                var id = document.getElementById(id).value;
                $.post('action/requisitionaction.jsp', { action : "acceptpost", id : id}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
             function updateUnitDel(id){
                var id = document.getElementById(id).value;
                $.post('action/requisitionaction.jsp', { action : "delpost", id : id}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            function updateUnitPost(id,qty){
                var id = document.getElementById(id).value;
               
                var qty = document.getElementById(qty).value;
                $.post('action/requisitionaction.jsp', { action : "postitem", id : id, qty : qty}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
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
                            <a href="#">Inventory</a><span class="divider"></span>
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
                           
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>CODE</th>
                                        <th>Item Name</th>
                                        <th>Requested Quantity</th>
                                        <th>Order Date</th>
                                        <th>Delivered QUantity</th>
                                        <th>Delivered Date</th>
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
                                         <td><%=itt.getRedquantity()%> </td>
                                        <td><%=itt.getOrderdate()%> </td>
                                        <td><%=itt.getDeliveredquantity()%> </td>
                                        <td><%=itt.getDeliverydate()%> <%=itt.getDeliverytime()%> </td>
                                        <td>
                                            <%if(itt.getStatus().equalsIgnoreCase("Delivered")){%>
                                             <input type="hidden" name="dateposted" value="<%=itt.getRequisitionid()%>" id="id_<%=itt.getRequisitionid()%>"/>
                                                            <button class="btn btn-info" name="action" value="Delete Items" onclick='updateUnitDel("id_<%=itt.getRequisitionid()%>");return false;'>
                                                                <i class="icon-white icon-check"></i> Stop Post
                                                            </button>
                                                                <%}else if(itt.getStatus().equalsIgnoreCase("Cancelled")){%>
                                                             <button class="btn btn-info btn-small" id="<%=itt.getRequisitionid()%>_post">
                                                Post Item
                                            </button>
                                            <div class="dialog" id="<%=itt.getRequisitionid()%>_postdialog" title="Post Item">
                                                <div class="well thumbnail">
                                                    <ul style="margin-left: 0px;" class="breadcrumb">
                                                        <li>
                                                            <span class="divider"></span> Post
                                                        </li>    
                                                    </ul>
                                                    <form action="action/requisitionaction.jsp" method="post">
                                                        <table >
                                                            <thead>
                                                                <tr>
                                                                    <th>Item</th>
                                                                    <th>Requested Quantity</th>
                                                                    <th>Dispatching Quantity</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td> <%=mgr.getStockItem(itt.getItemcode()).getDescription()%> </td>
                                                                    <td><%=itt.getRedquantity()%></td>
                                                                    <td><input type="text" name="dateposted" value="<%=itt.getRedquantity()%>" id="qty_<%=itt.getRequisitionid()%>"/>
                                                                    <input type="hidden" name="dateposted" value="<%=itt.getRequisitionid()%>" id="id_<%=itt.getRequisitionid()%>"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                        <div style="text-align: center;" class="form-actions">
                                                            <button class="btn btn-info" name="action" value="Post Items" onclick='updateUnitPost("id_<%=itt.getRequisitionid()%>","qty_<%=itt.getRequisitionid()%>");return false;'>
                                                                <i class="icon-white icon-check"></i> Post Items
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                                                <input type="hidden" name="dateposted" value="<%=itt.getRequisitionid()%>" id="id_<%=itt.getRequisitionid()%>"/>
                                                            <button class="btn btn-info" name="action" value="Delete Items" onclick='updateUnitDel("id_<%=itt.getRequisitionid()%>");return false;'>
                                                                <i class="icon-white icon-check"></i> Stop Post
                                                            </button>
                                                                
                                                                <%}else{%>
                                                                Items Received
                                                                <%}%>
                                            
                                        </td>

                                    </tr>
                                    <%}%> 
                                </tbody>
                            </table>
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
        width : 1000,
        modal :true
    });
   
    $("#<%= itt.getRequisitionid()%>_post").click(function(){
        $("#<%=itt.getRequisitionid()%>_postdialog").dialog('open');
    })
</script>
<% }%>

</body>
</html>