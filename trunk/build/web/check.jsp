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
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
%>
<html>
    <head>
        <meta charset="utf-8">
        <%@include file="widgets/stylesheets.jsp" %>

        <%
            HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

            //HMSHelper mgr = new HMSHelper();

            List itmss = mgr.CheckItems();

            DecimalFormat df = new DecimalFormat();




            df.setMinimumFractionDigits(2);
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

                        <li class="active">
                            <a href="#">Items Close to Expiry</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>


            <%@include file="widgets/loading.jsp" %>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">


                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="padding-bottom: 80px; display: none;" class="span8 thumbnail main-c">

                        <table class="example display">
                            <thead>
                                <tr>
                                    <th>BATCH</th>
                                    <th>Description</th>
                                    <th>Quantity</th>
                                    <th style="text-align: right;">Price GHS</th>

                                    <th>Expiring Date</th>
                                    <!--  <th>Edit</th>  -->
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%   for (int i = 0; i < itmss.size(); i++) {
                                        ItemsTable itt = (ItemsTable) itmss.get(i);

                                %>
                                <tr>
                                    <td>
                                        <div class="dialog" id="<%=itt.getBatchNumber()%>_dialog" title="Edit Item">

                                            <div class="well thumbnail">
                                                <ul style="margin-left: 0px;" class="breadcrumb">
                                                    <li>
                                                        <span class="divider"></span> Edit Item
                                                    </li>    
                                                </ul>
                                                <form action="action/forwardaction.jsp" method="post">
                                                    <table class="table example display">
                                                        <thead>
                                                            <tr style="color: #000;">
                                                                <th> Drug </th>
                                                                <th> Type </th>
                                                                <th> Dosage </th>

                                                                <th> Quantity</th>                                                                
                                                                <th> Unit Cost </th>
                                                                <th> Total </th>
                                                                <th> Dispensed</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>


                                                        </tbody>

                                                    </table>

                                                    <div style="text-align: center;" class="form-actions">

                                                        <input type="hidden" name="unitid" value="Accounts"/>
                                                        <input type="hidden" name="patient" value="<%=itt.getBatchNumber()%>"/>
                                                        <input type="hidden" name="visitid" value="<%=itt.getBatchNumber()%>"/>
                                                        <!-- <input type="submit" name="action" value="it to Accounts"/>-->
                                                        <button class="btn btn-info" name="action" value="Forward to Accounts">
                                                            <i class="icon-white icon-check"></i> Forward to Accounts
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>


                                    <td></td>
                                </tr>

                                <tr>
                                    <td style="text-transform: uppercase;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Supplier </h3> <h5><%=itt.getSupplier()%></h5> <h5><b> Remaining Quantity :</b> <%=itt.getQuantity()%> </td> </tr>  </table> "> <%=itt.getBatchNumber()%></td>
                                    <td><%=mgr.getStockItem(itt.getCode()).getDescription()%></td>
                                    <td style="text-align: right;"><%=itt.getQuantity()%> </td>


                                    <td style="text-align: right;"><%=df.format(itt.getPurchasingprice())%>   </td>

                                  <!--  <td><%=itt.getLocationId()%> </td>  -->


                                    <td><%=formatter.format(itt.getExpiryDate())%> </td>
                                    <td>
                                        <button class="btn btn-danger btn-small" id="<%=itt.getBatchNumber()%>_update">
                                            <i class="icon-white icon-remove"></i> Delete
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
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/demo.js"></script>

<!--initiate accordion-->
<script type="text/javascript">
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();

        $(".menu").fadeIn();
        $(".main-c").fadeIn();
        $(".main-c").fadeIn();
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

    });

</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sScrollY" : "400px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
            
            

        $(".patient").popover({

            placement : 'right',
            animation : true

        });

    });

</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        ItemsTable itt = (ItemsTable) itmss.get(i);;
%>


<script type="text/javascript">
   
                      
    $("#<%= itt.getBatchNumber()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
    $("#<%= itt.getBatchNumber()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= itt.getBatchNumber()%>_link").click(function(){
      
        $("#<%=itt.getBatchNumber()%>_dialog").dialog('open');
    
    })
   
    $("#<%= itt.getBatchNumber()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= itt.getBatchNumber()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=itt.getBatchNumber()%>_adddrug_dialog").dialog('open');
        
    })
   
   
    function editRecord(item_id){
        var f=document.form;
        f.method="post";
        f.action='edit_items.jsp?item_id='+item_id;
        f.submit();
    }
    function deleteRecord(id){
        var f=document.form;
        f.method="post";
        f.action='delete.jsp?id='+id;
        f.submit();
    }

    function show_confirm()
    {
        var con = confirm("Are You Sure You Want Delete This Item");
        if (con ==true)
        {
   
                      
            alert("Delete Was Successfull!");
        }
        else 
        {
            alert("Delete Was Cancled!");
        }
    }


</script>

<% }%>

</body>
</html>
