<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
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
        <%
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
            TransactionEntityManager mgr = new TransactionEntityManager();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();
            List<Requisition> itmss = mgr.listObjects("from Requisition where status='Pending' and location='Dispensary'");
            List<DispensaryItems> list = mgr.listObjects("from DispensaryItems");

        %>
        <%@include file="widgets/stylesheets.jsp" %>
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
                //alert(ttt)
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
            
            function updateUnit(id,code,qty){
                var id = document.getElementById(id).value;
                var code = document.getElementById(code).value;
                var qty = document.getElementById(qty).value;
                $.post('action/requisitionaction.jsp', { action : "edititemstock", id : id, code : code, qty : qty}, function(data) {
                    //alert(data);
                    location.reload();
                    alert("Request Edited Successfully");
                    //$('#results').html(data).hide().slideDown('slow');
                } );
            }
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                var con = confirm("Are You Sure You Want Delete This Item");
                if (con ==true)
                {
                    $.post('action/requisitionaction.jsp', { action : "deleteitemstock", id : id}, function(data) {
                        location.reload();
                        alert("Request Deleted Successfully");
                        //alert(data);
                        //$('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancelled!");
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
                            <a href="#">Dispensary Requests</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert  <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>


                    <div style="display: none;" class="span8 thumbnail main-c">
                        <ul style="margin-left: 0px; padding-bottom: 0px;" class="breadcrumb">

                            <li>
                                <a style="font-size: 15px; margin-top: 10px;" href="#"> Pending Stock Requests  </a><span class="divider"></span>
                            </li>
                            <li class="pull-right">
                                <a href="#" class="dialog_link btn">
                                    <i class="icon-plus-sign"></i> New Dispensary Request
                                </a>
                            </li>
                        </ul>
                        <table class="example display table-condensed">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Description</th>
                                    <th>Quantity Requested</th>
                                    <th>Requested By</th>
                                    <th>Requested On</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  for (Requisition itt : itmss) {
                                        //Requisition itt = (Requisition) itmss.get(i);
                                %>
                                <tr>
                                    <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Item </h3> <h5></h5></td></tr>  </table> "> <%=itt.getInventoryItems().getItemCode() %>   </td>
                                    <td></td>
                                    <td style="text-align: right; padding-right: 20px;"><%=itt.getQuantityRequested()%> </td>
                                    <td>  </td>
                                    <td><%=formatter.format(itt.getDateOfRequest())%> </td>
                                    <td>
                                        <button class="btn btn-info btn-small" id="<%=itt.getRequestId()%>_post">
                                            Edit
                                        </button>
                                        <div class="dialog center" id="<%=itt.getRequestId()%>_postdialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> EDIT REQUEST  </span>">

                                            <div class="lead center">
                                                <span class="divider"></span> EDIT REQUEST 
                                            </div>
                                            <div class="clearfix">

                                            </div>
                                            <form style="width: 50%; margin-left: 22%; padding: 2%;" class="form-horizontal thumbnail" action="action/requisitionaction.jsp" method="post">
                                                <div class="control-group">
                                                    <label class="control-label" for="inputEmail">Item</label>
                                                    <div style="text-align: left;" class="controls">
                                                        <input type="hidden" name="dateposted" id="id_<%=itt.getRequestId()%>" value="<%=itt.getRequestId()%>"/>

                                                        <select name="code" id="code_<%=itt.getRequestId()%>">

                                                            <%  // List<R
                                                            for (DispensaryItems stockItems : list) {
                                                                   // StockItems stockItems = (StockItems) list.get(r);
                                                                    if (stockItems.getItemCode().equals(itt.getInventoryItems().getItemCode())) {
                                                            %>
                                                            <option selected="selected" value="<%=stockItems.getItemCode()%>">
                                                                <%= stockItems.getItemDescription()%>
                                                            </option>
                                                            <% } else {%>
                                                            <option value="<%=stockItems.getItemCode()%>">
                                                                <%= stockItems.getItemDescription()%>
                                                            </option>
                                                            <%}
                                                                }%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="inputEmail">Quantity </label>
                                                    <div style="text-align: left;" class="controls">
                                                        <input type="text" class="input-mini" name="dateposted" value="<%=itt.getQuantityRequested()%>" id="qty_<%=itt.getRequestId()%>"/>
                                                    </div>
                                                </div>

                                                <div class="clearfix"></div>
                                                <div style="text-align: center; padding-left: 5%;" class="form-actions">
                                                    <button style="width: 100%" class="btn btn-info" name="action" value="Post Items" onclick='updateUnit("id_<%=itt.getRequestId()%>","code_<%=itt.getRequestId()%>","qty_<%=itt.getRequestId()%>");return false;'>
                                                        <i class="icon-white icon-check"></i> Update Request
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                        
                                    </td>
                                    <td>
                                        <input type="hidden" name="itt" value="<%=itt.getRequestId()%>" id="id_<%=itt.getRequestId()%>"/>
                                        <button class="btn btn-danger btn-small" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=itt.getRequestId()%>");return false;'>
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                                <%}%> 
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div style="display: none;" id="dialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> NEW STOCK REQUEST  </span>">
                    <div class="lead center">
                        NEW STOCK REQUEST
                    </div>
                    <form style="width: 70%; margin-left: 12%; padding: 2%;" class="form-horizontal thumbnail" action="action/requisitionaction.jsp" method="post" >
                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01">Select Item: </label>
                                <div class="controls">
                                    <select name="code" id="code">
                                        <option>
                                            Select Item
                                        </option>
                                        <%   for (DispensaryItems itt : list) {
                                                //StockItems itt = (StockItems) list.get(i);
                                        %>
                                        <option value="<%=itt.getItemCode()%>><<%= itt.getItemDescription()%>">
                                            <%= itt.getItemDescription()%>
                                        </option>
                                        <% }%>
                                    </select>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> Quantity</label>
                                <div class="controls">
                                    <input class="input-mini" type="text" name="quantity" id="quantity">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <button id="addCheckBoxes" class="btn btn-info btn-small" onclick='addDiadChecks("code","quantity","appendd");return false;'>
                                        <i class="icon-white icon-plus-sign"> </i>   Add Item
                                    </button>
                                </div>
                            </div>
                            <br/>
                            <table id="appendd" class="table">
                                <thead>
                                    <tr style="padding: 12px 0px 12px 0px;">
                                        <th style="color: white; padding: 10px 0px 10px 0px;" colspan="8">
                                <h4> Selected Items </h4>
                                </th>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                </tbody>
                            </table>

                            <div style="padding-left:  7%" class="form-actions">
                                <button class="btn btn-danger" style="width: 95%;"  name="action" value="Dispensary">
                                    <i class="icon-arrow-right icon-white"> </i> Send Request
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

        //menu_ul.hide();
        
        $("#dialog").dialog({
            autoOpen : false,
            width : "80%",
            modal :true,
            position : "top"
        });

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
        
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
            $('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('span3 hide');
            $('.main-c').toggleClass('span8');
                
        });
    });

</script>
<% for (Requisition itt : itmss) {
      //  Requisitions itt = (Requisitions) itmss.get(i);;
%>
<script type="text/javascript">
    
    $("#<%= itt.getRequestId()%>_postdialog").dialog({
        autoOpen : false,
        width : "80%",
        modal :true,
        position : "top"
    });
   
    $("#<%= itt.getRequestId()%>_post").click(function(){
        $("#<%=itt.getRequestId()%>_postdialog").dialog('open');
    })
</script>
<% }%>

</body>
</html>