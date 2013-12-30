<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

        <%
            Users user = (Users) session.getAttribute("staff");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);
            Date date = new Date();
            String orderid = request.getParameter("orderid");
            orderid = orderid.trim();
            Procedureorderswalkin order = mgr.getProcedureorderswalking(orderid);

        %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                        <ul class="nav nav-pills">

                            <li>
                                <a href="#">Billing</a><span class="divider"></span>
                            </li>
                            <li  class="active">
                                <a href="#"> Walk-in Procedure Bill</a><span class="divider"></span>
                            </li>

                        </ul>
                    </div>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%>center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>




                    <div style="display: none;" class="span8 thumbnail main-c">

                        <table class="example display table-striped">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px; text-align: left;"> Order ID</th>
                                    <th style="font-size: 12px; text-align: left;"> Patient Name </th>

                                    <th style="font-size: 12px; text-align: left;"> Date of Birth </th>
                                    <th style="font-size: 12px; text-align: left;"> Requested On </th>

                                    <th style="text-transform: capitalize; font-size: 12px;"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (order != null) {


                                %>


                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bold; font-size: 18px;"> <%=order.getOrderid()%>   </td>
                                    <td> <%= order.getFirstName()%> <%= order.getLastName()%></td>
                                    <td><%= formatter.format(order.getDateOfBirth())%>   </td>
                                    <td><%= formatter.format(order.getOrderdate())%>   </td>

                                    <td>
                                        <button class="btn btn-info btn-small" id="<%=order.getOrderid()%>_link">
                                            Make Payment
                                        </button>
                                    </td>
                                </tr>
                                <% }
                                %> 

                            </tbody>
                        </table>

                    </div>


                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    

    </div>
</div>
<!--end static dialog-->

<div style="display: none;" class="dialog" id="<%=order.getOrderid()%>_dialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> WALK-IN PROCEDURE BILL PAYMENT </span>">
    <span class="span4">
        <dl class="dl-horizontal">

            <dt style="text-align: left;" >Reference No.:</dt>
            <dd style="text-transform: uppercase;"><%= order.getOrderid()%></dd>

            <dt style="text-align: left;" >Patient Name:</dt>
            <dd><%= order.getFirstName()%>
                <%= order.getLastName()%>
            </dd>

        </dl>
    </span>
    <div class="clearfix">
    </div>    
    <div style="font-weight: bolder;" class="lead center"> <u> 
            OFFICIAL RECEIPT  </u> 
    </div>
    <div style="max-height: 400px; overflow-y: scroll;" class="center thumbnail">

        <form action="action/accountsaction.jsp" method="post">
            <table class="table table-striped">
                <thead>
                    <tr style="color: #fff;">
                        <th  style="color: #fff; text-align: left;"> Procedure </th>
                        <th  style="color: #fff; text-align: right;" > Price </th>
                        <th class="hide"  style="color: #fff; width: 100px;"> Status</th>


                </thead>
                <tbody>
                    <%
                        List procedures = mgr.listWalkingProcedureByOrderid(order.getOrderid());
                        double total = 0.0;
                        for (int r = 0; r < procedures.size(); r++) {
                            PatientProcedureWalkins procedure = (PatientProcedureWalkins) procedures.get(r);
                            total = total + mgr.getProcedure(procedure.getProcedureCode()).getPrice();
                    %>
                    <tr>
                        <td class="procedure_row<%=procedure.getProcedureCode()%>" style="padding-left: 5px;"><%=mgr.getProcedure(procedure.getProcedureCode()).getDescription()%> </td>
                        <td class="procedure_row<%=procedure.getProcedureCode()%>" style="text-align: right;"><%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> 
                            <input type="hidden" class="amountduepiece<%=order.getOrderid()%>" value="<%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%>" />
                        </td>
                        <td class="hide">
                            <label class="switch-container">
                                <input id="procedure_check<%=procedure.getProcedureCode()%>" type="checkbox" name="paid[]" checkvalue="<%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> " value="<%=procedure.getProcedureCode()%>" style="width: 100px" class="switch-input  hide">
                                <div class="switch">
                                    <span class="switch-label">Yes</span>
                                    <span class="switch-label">No</span>
                                    <span class="switch-handle"></span>
                                </div>  
                            </label> 

                        </td>
                    </tr>
                    <%
                        }%>





                    <tr>
                        <td  style="border-top: solid 1px black; padding-left: 5px; line-height: 25px;">
                            <b>   Total Bill </b>
                        </td>
                        <td style="border-top: solid 1px black; text-align: right; font-weight: bold; " class="amountduetext<%=order.getOrderid()%>">

                            <input type="hidden" class="amountdueinput<%=order.getOrderid()%>" />
                        </td>
      


                    </tr>
                    <tr>
                        <td  style="padding-left: 5px; line-height: 25px;">
                            Amount Paid 
                        </td>
                        <td style="text-align: right;  padding-right: 5px;">
                            <input style="text-align: right;" type="text" name="amountpaidinput" class="amountpaidinput<%=order.getOrderid()%> input-mini" value="0.00"  />
                        </td>
                        
                    </tr>
                    <tr>
                        <td  style="padding-left: 5px; line-height: 25px;">
                            Balance
                        </td>
                        <td style="text-align: right;  padding-right: 5px;" class="balancetext<%=order.getOrderid()%>">

                        </td>
                        
                    </tr>



                    <tr>
                        <td>
                            <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%= order.getOrderid()%>" style="display: none">
                                <section class="hide" id="dashboard">
                                    <!-- Headings & Paragraph Copy -->
                                    <div class="container">

                                        <div style="margin-bottom: -15px;" class="row">
                                            <div class="span3" style="float: left;">
                                                <img src="images/danpongclinic.png" width="100px;" style="margin-top: 30px;" />
                                            </div>
                                            <img src="images/danpongaddress.png" width="100px;" style="float: right; margin-top: 20px;" />  
                                        </div>
                                    </div>

                                    <div style="clear: both;"></div>

                                    <hr style="border: solid #000000 0.5px ;"  />

                                    <div style="text-align: center;  margin-top: 0px;" class="row center ">

                                        <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; ">  PROCEDURE RECEIPT </h3>

                                    </div>
                                    <hr class="row" style="border-top: 2px dashed #45BF55;margin-top: 0px;" >


                                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">



                                        <table style="width: 300px; float: left; margin-left: 6px; font-size:  12px;">
                                            <tr>
                                                <td style="line-height: 25px;">
                                                    Date
                                                </td>
                                                <td style="line-height: 25px;">
                                                    <%= formatter.format(date)%>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="line-height: 25px;">
                                                    Invoice No.
                                                </td>
                                                <td style="line-height: 25px;">
                                                    INV<%=order.getOrderid()%>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="line-height: 25px;">
                                                    Name:
                                                </td>
                                                <td style="line-height: 25px;">
                                                    <%= order.getFirstName()%>
                                                    <%= order.getLastName()%>

                                                </td>
                                            </tr>



                                        </table>
                                        <div style="clear: both;"></div>

                                        <hr class="row" style="border-top: 2px dashed #45BF55;
                                            margin-top: 5px;" >
                                        <div class="row center">

                                            <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing:  ">PROCEDURES TENDERED</h3>

                                        </div>

                                        <table style="width: 100%" cellspacing="0">
                                            <thead>
                                                <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                    <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px;">Procedure </th>

                                                    <th style="width: 80px; text-align: right; padding-right: 15px;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;  border-left: none;">
                                                        Price
                                                    </th>

                                                </tr>
                                            </thead>
                                            <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                                <%
                                                    procedures = mgr.listWalkingProcedureByOrderid(order.getOrderid());
                                                    for (int r = 0; r < procedures.size(); r++) {
                                                        PatientProcedureWalkins procedure = (PatientProcedureWalkins) procedures.get(r);
                                                %>

                                                <tr>
                                                    <td class="procedure_check<%=procedure.getProcedureCode()%>" style="text-align: left; padding-left: 15px; line-height: 25px;"><%=mgr.getProcedure(procedure.getProcedureCode()).getDescription()%> </td>
                                                    <td class="procedure_check<%=procedure.getProcedureCode()%>" style="width: 80px; text-align: right; padding-right: 5px; line-height: 25px;"><%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> 
                                                    </td>
                                                </tr>
                                                <%  }%>



                                                <tr>
                                                    <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                        <b>   Total Bill </b>
                                                    </td>
                                                    <td style="border-top: solid 1px black; text-align: right;">
                                                        <span style="text-align: right; font-weight: bold; padding-right: 5px;" class="amountduetext<%=order.getOrderid()%>"> </span>
                                                        <input type="hidden" class="amountdueinput<%=order.getOrderid()%>" />
                                                    </td>
                                                </tr>


                                                <tr>
                                                    <td  style="padding-left: 15px; line-height: 25px;">
                                                        Amount Paid 
                                                    </td>
                                                    <td style="text-align: right;  padding-right: 5px;" class="amountpaidtext<%=order.getOrderid()%>">

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style=" padding-left: 15px; line-height: 25px;">
                                                        Balance Tendered
                                                    </td>
                                                    <td style="text-align: right;  padding-right: 5px;" class="balancetext<%=order.getOrderid()%>">

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  style=" padding-left: 15px; line-height: 25px;">
                                                        Payment Status  
                                                    </td>
                                                    <td style="text-align: right;  padding-right: 5px;" class="paymentstatus<%=order.getOrderid()%>">
                                                        Not Paid
                                                    </td>
                                                </tr>



                                            </tbody>
                                        </table>

                                    </div>
                                    <div style="clear: both"></div>

                                    <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                        Served by <%= mgr.getStafftableByid(user.getStaffid()).getOthername() %> <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                        Wishing You Speedy Recovery <br /> Thank you
                                    </div>       
                                </section> 
                            </div>
                        </td>
                        <td>

                        </td>
                     
                    </tr>

                </tbody>

            </table>

            <div style="text-align: center;" class="form-actions">
                <button style="width: 45%" class="btn btn-info  pull-left" href="" onclick='printSelection(document.getElementById("print<%=order.getOrderid()%>"));return false'>
                    <i class="icon-white icon-print"></i> Print
                </button>


                <input type="hidden" name="orderid" value="<%=order.getOrderid()%>" />

                

                <button style="width: 45%" type="submit" name="action" value="walk-inprocedurepayment" class="btn btn-danger pull-right" onclick='updateProcedure("orderid_<%=order.getOrderid()%>","amountdue_<%=order.getOrderid()%>");return false'>
                    <i class="icon-white icon-arrow-right"> </i> Forward
                </button>
            </div>
        </form>
    </div>
</div>

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
    function updateProcedure(orderid,amountdue){
      
        var orderid = document.getElementById(orderid).value;
        var amountdue = document.getElementById(amountdue).value;
        //  alert(orderid)
        $.post('action/procedureaction.jsp', { action : "Procedure Receipt", orderid : orderid, amountdue : amountdue}, function(data) {
            alert(data);
            $('#results').html(data).hide().slideDown('slow');
        } );
    }
    function printSelection(node){
        var content=node.innerHTML
        var pwin=window.open('','print_content','width=400,height=900');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
        setTimeout(function(){pwin.close();},1000);
    }
    
    
    
    $(function() {
        $("input:checkbox").attr("checked", true);
        
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
        
        $(".menu").fadeIn();
        $(".main-c").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
        $(".alert").fadeIn();
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
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 400
        }); 
        
        
        $(".patient").popover({
            placement : 'right',
            animation : true
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


<script type="text/javascript">
    
    
    var amountdue<%= order.getOrderid()%> = 0.0;
    
    $(".amountduepiece<%=order.getOrderid()%>").each(function(){
         
        //alert("amountduepiece"+ $(".amountduepiece<%=order.getOrderid()%>").attr("value"))
        amountdue<%=order.getOrderid()%> = parseFloat(amountdue<%=order.getOrderid()%>)  + parseFloat($(this).attr("value"));
        $(".amountduetext<%=order.getOrderid()%>").attr("value",amountdue<%=order.getOrderid()%>);
        $(".amountdueinput<%=order.getOrderid()%>").attr("value",amountdue<%=order.getOrderid()%>);
    });
    // alert(amountdue<%=order.getOrderid()%>)
    
    $("#<%= order.getOrderid()%>_dialog").dialog({
        autoOpen : true,
        width : "90%",
        modal :true,
        position : "top"
    });
    
    $("#<%= order.getOrderid()%>_link").click(function(){
        $("#<%=order.getOrderid()%>_dialog").dialog('open');
    })
    
    
    $("#discount_links<%=order.getOrderid()%>").dialog({
        autoOpen : false,
        width : 450,
        modal :true
    });
    
    $("#password_link<%=order.getOrderid()%>").dialog({
        autoOpen : false,
        width : 450,
        modal :true
    });
    $("#discount<%=order.getOrderid()%>").click(function(){
        $(".discount_row<%=order.getOrderid()%>").show()
        $("#password_link<%=order.getOrderid()%>").dialog('open');
        return false; 
    }) 
   
    $(function(){
        var amountdue = parseFloat($(".amountdueinput<%= order.getOrderid()%>").attr("value")).toFixed(2);
        
        $(".amountduetext<%= order.getOrderid()%>").html(amountdue);
        var checkedValue = 0;
        //$("#amountdue").attr("value",parseFloat(0));
        //$("#amountduetext").html("0.0");
        
        $(".balanceinput<%= order.getOrderid()%>").attr("value",parseFloat(0).toFixed(2));
        $(".balancetext<%= order.getOrderid()%>").html("0.00");
        
        $(".amountpaidinput<%= order.getOrderid()%>").attr("value",parseFloat(0).toFixed(2))
        $(".amountpaidtext<%= order.getOrderid()%>").html($(".amountpaidinput<%= order.getOrderid()%>").attr("value"))
        
        $(".amountpaidinput<%= order.getOrderid()%>").live('keyup',function(){
           
            var amountdue = $(".amountdueinput<%= order.getOrderid()%>").attr("value");
            var amountpaid = $(".amountpaidinput<%= order.getOrderid()%>").attr("value");
            $(".amountpaidtext<%= order.getOrderid()%>").html($(".amountpaidinput<%= order.getOrderid()%>").attr("value"))
            
            if(amountpaid == ""){
                amountpaid = 0;
            }
            var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
            
            if(amountpaid > 0 &&balance < 0){
                $(".paymentstatus<%= order.getOrderid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                $('.balanceinput<%= order.getOrderid()%>').closest('.control-group').addClass('error').removeClass('success')
                $('.balancetext<%= order.getOrderid()%>').addClass('text-error').removeClass('text-success')
                $('.balancetextcolour<%= order.getOrderid()%>').addClass('text-error').removeClass('text-success')
               
            } else if (amountpaid == 0){
                $(".paymentstatus<%= order.getOrderid()%>").html("Not Paid").removeClass('text-success').removeClass('text-error')
                $('.balanceinput<%= order.getOrderid()%>').closest('.control-group').removeClass('success').removeClass('error')
                $('.balancetext<%= order.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= order.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                
            } 
           
            else if(amountpaid > 0 && balance >= 0){
                $(".paymentstatus<%= order.getOrderid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                $('.balanceinput<%= order.getOrderid()%>').closest('.control-group').addClass('success').removeClass('error')
                $('.balancetext<%= order.getOrderid()%>').addClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= order.getOrderid()%>').addClass('text-success').removeClass('text-error')
            }
            $(".balanceinput<%= order.getOrderid()%>").attr("value",parseFloat(balance).toFixed(2));
            $(".balancetext<%= order.getOrderid()%>").html(parseFloat(balance).toFixed(2));
            $(".amountduetext<%= order.getOrderid()%>").attr("value",$(".amountdue<%= order.getOrderid()%>").attr("value"));
            
        });
        
        
        var amounttoplimit = amountdue;
        var amountbottomlimit = 0;
        
        
        $(".checkValue<%=order.getOrderid()%>").change(function(){
            
            
            var amountpaid = parseFloat($(".amountpaidinput<%=order.getOrderid()%>").attr("value"));
            //alert(amountpaid)
            if(amountpaid == ""){
                amountpaid = 0;
            }
            var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
            
            
            if($(this).is(':checked')){ 
                
                // alert("Checked")
                checkedValue = parseFloat($(this).attr("checkvalue")).toFixed(2);
                //alert(checkedValue);
                if(amountdue < amounttoplimit) { 
                    
                    amountdue = parseFloat(amountdue) + parseFloat(checkedValue);
                    
                    $(".amountdueinput<%=order.getOrderid()%>").attr("value",amountdue);
                    $(".amountduetext<%=order.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    
                }
    <%
        procedures = mgr.listWalkingProcedureByOrderid(order.getOrderid());
        for (int r = 0; r < procedures.size(); r++) {
            PatientProcedureWalkins procedure = (PatientProcedureWalkins) procedures.get(r);
    %>
                    if ($(this).attr("id")=="procedure_check<%=procedure.getProcedureCode()%>"){
                        $(".procedure_row<%=procedure.getProcedureCode()%>").css('text-decoration','none')
                        $(".procedure_check<%=procedure.getProcedureCode()%>").css('display','block')
                    }                                                  
                                                                                
    <% }%>
               
                }else {
               
                    checkedValue = parseFloat($(this).attr("checkvalue")); 
                 
                    if(amountdue > amountbottomlimit) { 
                        amountdue = parseFloat(amountdue) - parseFloat(checkedValue);
                    
                        $(".amountdueinput<%=order.getOrderid()%>").attr("value",amountdue);
                        $(".amountduetext<%=order.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    }
               
    <%
        procedures = mgr.listWalkingProcedureByOrderid(order.getOrderid());
        for (int r = 0; r < procedures.size(); r++) {
            PatientProcedureWalkins procedure = (PatientProcedureWalkins) procedures.get(r);
    %>
                    if ($(this).attr("id")=="procedure_check<%=procedure.getProcedureCode()%>"){
                        $(".procedure_row<%=procedure.getProcedureCode()%>").css('text-decoration','line-through')
                        $(".procedure_check<%=procedure.getProcedureCode()%>").css('display','none')
                    }                                                  
                                                                                
                                                                                
    <% }%>
                
                    $("#override_action").dialog("open")
                }
            
                if (amountpaid > 0 && amountdue > 0){ 
                    balance = parseFloat(amountdue).toFixed(2) - parseFloat(amountpaid).toFixed(2);
                    $(".balancetext<%=order.getOrderid()%>").html(parseFloat(balance).toFixed(2));
                }
                if(amountpaid > 0 && balance < 0){
                    $(".paymentstatus<%=order.getOrderid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                    $('.balanceinput<%=order.getOrderid()%>').closest('.control-group').addClass('error').removeClass('success')
                    $('.balancetext<%=order.getOrderid()%>').addClass('text-error').removeClass('text-success')
                    $('.balancetextcolour<%=order.getOrderid()%>').addClass('text-error').removeClass('text-success')
               
                } else if (amountpaid == 0.00){
                    $(".paymentstatus").html("").removeClass('text-success').removeClass('text-error')
                    $('.balanceinput<%=order.getOrderid()%>').closest('.control-group').removeClass('success').removeClass('error')
                    $('.balancetext<%=order.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                    $('.balancetextcolour<%=order.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                
                }
                else if(amountpaid > 0 && balance >= 0){
                    $(".paymentstatus").html("Full Payment").addClass('text-success').removeClass('text-error')
                    $('.balanceinput<%=order.getOrderid()%>').closest('.control-group').addClass('success').removeClass('error')
                    $('.balancetext<%=order.getOrderid()%>').addClass('text-success').removeClass('text-error')
                    $('.balancetextcolour<%=order.getOrderid()%>').addClass('text-success').removeClass('text-error')
                }
            });
        })
        var amountduebeforediscount = $(".amountdueinput<%= order.getOrderid()%>").attr("value");
        $("#newamount<%= order.getOrderid()%>").attr("value",amountduebeforediscount);
        var amountdueafterdiscount;
        var discountpercentage;
        var discountamount;
    
        $("#actualdiscount<%= order.getOrderid()%>").live('keyup',function(){
            if( $(this).attr("value") >= 0){ 
                
                discountamount = $("#actualdiscount<%= order.getOrderid()%>").attr("value");
                discountpercentage = (parseFloat(discountamount)/parseFloat(amountduebeforediscount))*100
                amountdueafterdiscount = parseFloat(amountduebeforediscount).toFixed(2) - parseFloat(discountamount).toFixed(2);
                $("#percentagediscount<%= order.getOrderid()%>").attr("value",parseFloat(discountpercentage).toFixed(2));
                $("#newamount<%= order.getOrderid()%>").attr("value",parseFloat(amountdueafterdiscount).toFixed(2));       
                $(".discount_row_percent<%=order.getOrderid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%") 
                $(".discount_row_amount<%=order.getOrderid()%>").html(parseFloat(discountamount).toFixed(2))
                $(".bill_after_discount<%=order.getOrderid()%>").html(parseFloat(amountdueafterdiscount).toFixed(2));
                $(".discount_row_amount_percent<%=order.getOrderid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
            }else {
                alert("Please Enter a Positive Decimal Value, Only")
            }
        
        });
    
        $("#percentagediscount<%= order.getOrderid()%>").live('keyup',function(){
            if( $(this).attr("value") >= 0){ 
                
                discountpercentage = $("#percentagediscount<%= order.getOrderid()%>").attr("value");
                
                var discountamount = (parseFloat(discountpercentage)*parseFloat(amountduebeforediscount))/100
                var amountdueafterdiscount = amountduebeforediscount - discountamount;
        
                $("#actualdiscount<%= order.getOrderid()%>").attr("value",discountamount);
                $("#newamount<%= order.getOrderid()%>").attr("value",amountdueafterdiscount);         
       
                $(".discount_row_percent<%=order.getOrderid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%"); 
                $(".discount_row_amount<%=order.getOrderid()%>").html(parseFloat(discountamount).toFixed(2));
                $(".bill_after_discount<%=order.getOrderid()%>").html(parseFloat(amountdueafterdiscount).toFixed(2));
                $(".discount_row_amount_percent<%=order.getOrderid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
            }else {
                alert("Please Enter a Positive Decimal Value, Only")
            }
        
        });
        $("#verify<%=order.getOrderid()%>").click(function(){
            // alert("hello");
            var username = $("#username<%=order.getOrderid()%>").attr("value");
            var password = $("#password<%=order.getOrderid()%>").attr("value");
            $.post('patientcount.jsp', {action : "patientdiscount", username : username, password : password}, function(data) {
                //alert(data);
                var bool = data;
                if(bool=="false"){
                    alert("You are eligible please go ahead")
                }
                else{
                    alert("You don't qualify to give discount please talk to a senior staff")
                    $("#discount_links<%=order.getOrderid()%>").dialog('open');
                    return false;
                }
            });
        });
        $("#<%=order.getOrderid()%>_discount").click(function(){     
            var percentage = $("#percentagedis<%=order.getOrderid()%>").attr("value");
            var actual = $("#actualdis<%=order.getOrderid()%>").attr("value");
            var newcharge = $("#newamount<%=order.getOrderid()%>").attr("value");
            var status = $("#statusdis<%=order.getOrderid()%>").attr("value");
            var staff = $("#staffiddis<%=order.getOrderid()%>").attr("value");
            var reason = $("#reasondis<%=order.getOrderid()%>").attr("value");
            var visit = $("#visitiddis<%=order.getOrderid()%>").attr("value");
            $(".amountdueinput<%=order.getOrderid()%>").attr("value", newcharge);
            $(".print_discount_row<%=order.getOrderid()%> hide ").show()
            alert(staff);
            $.post('patientcount.jsp', {action : "savediscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit}, function(data) {
                alert(data);      
            });
            //  return false;
        }); 
    
    
    
</script>

</body>
</html>