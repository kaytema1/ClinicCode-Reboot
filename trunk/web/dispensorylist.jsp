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
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var t = validateForm();
                //  alert(t)
                if(t){
                    //alert("here");
                    var tgroup = document.getElementById("theragroup").value;
                    var gdrg = document.getElementById("gdrg").value;
                    var group = document.getElementById("group").value;
                    var treatment = document.getElementById("desc").value;
                    var price = document.getElementById("price").value;
                    var uprice = document.getElementById("unitprice").value;
                    //alert(tgroup);
                    $.post('action/treatgroupaction.jsp', 
                    { action : "detailtreatment", tgroup : tgroup, gdrg : gdrg, group : group, treatment : treatment, price : price, uprice : uprice},
                    function(data) {
                        alert(data);
                    } );
                    //alert("aden");
                }else{
                    alert("fields cannot be empty");
                    return
                }
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
                            <a href="#">Dispensary List</a><span class="divider"></span>
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

                        List itmss = mgr.listTreatments();
                    %>     
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding: 15px;" class="breadcrumb">
                                <li>
                                    <h4>Add Items to Stock</h4>
                                </li>
                               
                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                         <th style="font-size: 12px;">
                                            Batch Number 
                                        </th>
                                        <th style="font-size: 12px;">
                                            GDRG Code 
                                        </th>
                                        <th style="font-size: 12px;">
                                            Treatment 
                                        </th>
                                        <th style="font-size: 12px;">
                                            Unit of Price 
                                        </th>
                                        <th>Qunatity</th>
                                       <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Treatment itemsTable = (Treatment) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=itemsTable.getBatchNumber()%>
                                        </td>
                                        <td>
                                           <%=itemsTable.getGdrg() %>
                                        </td>
                                        <td>
                                            <%=itemsTable.getTreatment() %>
                                        </td>
                                        <td>
                                            <%=itemsTable.getPrice() %>
                                        </td>
                                        <td>
                                            <%=itemsTable.getQuantity() %>
                                        </td>
                                        
                                        <td>
                                            <button class="btn btn-primary" id="_link">
                                                <i class="icon-edit icon-white"> </i> Remove from Stock 
                                            </button>
                                           
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
        Treatment vst = (Treatment) itmss.get(i);
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
        alert("");
        $("#<%=vst.getBatchNumber()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>