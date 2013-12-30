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
            List visits = mgr.listPatientProcedures("Cashier");
            List treatments = null;
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
                                <a href="#"> Procedure Bills </a><span class="divider"></span>
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

                        <table class="example display">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px; text-align: left;"> Folder Number</th>
                                    <th style="font-size: 12px; text-align: left;"> Patient Name </th>

                                    <th style="font-size: 12px; text-align: left;"> Payment Type</th>
                                    <th style="font-size: 12px;text-align: left;"> Date of Birth  </th>
                                    <th style="font-size: 12px; text-align: left;"> Requested On </th>

                                    <th style="text-transform: capitalize; font-size: 12px;"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (visits != null) {

                                        String pId = "";
                                        PatientRegistration pReg = null;
                                        List result;
                                        boolean paymentStatus = false;


                                        for (int i = 0; i < visits.size(); i++) {
                                            Procedureorders vst = (Procedureorders) visits.get(i);
                                %>
                                <tr>
                                    <td>
                                        <div class="dialog" id="<%=vst.getOrderid()%>_dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-right' style='margin-top: 30px; padding: 0px;' />">
                                            <span class="span4">
                                                <dl class="dl-horizontal">

                                                    <dt style="text-align: left;" >Reference:</dt>
                                                    <dd style="text-transform: uppercase;"><%= vst.getOrderid()%></dd>
                                                    <dt style="text-align: left;" >Patient ID:</dt>
                                                    <dd style="text-transform: uppercase;"><%= vst.getPatientid()%></dd>
                                                    <dt style="text-align: left;" >Patient Name:</dt>
                                                    <dd><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                        <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                        <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                    </dd>
                                                    <dt style="text-align: left;" >Sponsor:</dt>
                                                    <dd><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></dd>
                                                </dl>
                                            </span>
                                            <div class="clearfix">
                                            </div>    
                                            <div style="font-weight: bolder;" class="lead center"> <u> <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                    OFFICIAL INVOICE 
                                                    <% } else {%> OFFICIAL RECEIPT <% }%> </u> 
                                            </div>
                                            <div style="max-height: 400px; overflow-y: scroll;" class="center thumbnail">

                                                <form action="action/accountsaction.jsp" method="post">
                                                    <table class="table">
                                                        <thead>
                                                            <tr style="color: #fff;">
                                                                <th rowspan="2" style="color: #fff; text-align: left;"> Procedure </th>
                                                                <th  rowspan="2"style="color: #fff; text-align: right;" > Price </th>
                                                                <th rowspan="2"style="color: #fff; width: 100px;"> Status</th>

                                                                <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                <th colspan="2" style="color: #fff; width: 100px;"> Co Payment</th>
                                                                <% }%>
                                                            </tr>
                                                            <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                            <tr>
                                                                <th style="color: #fff; width: 100px;"> <%= mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname()%></th>
                                                                <th style="color: #fff; width: 100px;"> Out of Pocket</th>
                                                            </tr>
                                                            <% }%>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                List procedures = mgr.listPatientProcdureByOrderid(vst.getOrderid());
                                                                double total = 0.0;
                                                                for (int r = 0; r < procedures.size(); r++) {
                                                                    PatientProcedure procedure = (PatientProcedure) procedures.get(r);
                                                                    total = total + mgr.getProcedure(procedure.getProcedureCode()).getPrice();
                                                            %>
                                                            <tr>
                                                                <td class="procedure_row<%=procedure.getProcedureCode()%>" style="padding-left: 5px;"><%=mgr.getProcedure(procedure.getProcedureCode()).getDescription()%> </td>
                                                                <td class="procedure_row<%=procedure.getProcedureCode()%>" style="text-align: right;"><%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> 
                                                                    <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" value="<%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%>" />
                                                                </td>
                                                                <td>
                                                                    <label class="switch-container">
                                                                        <input id="procedure_check<%=procedure.getProcedureCode()%>" type="checkbox" name="paid[]" checkvalue="<%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> " value="<%=procedure.getProcedureCode()%>" style="width: 100px" class="switch-input  hide">
                                                                        <div class="switch">
                                                                            <span class="switch-label">Yes</span>
                                                                            <span class="switch-label">No</span>
                                                                            <span class="switch-handle"></span>
                                                                        </div>  
                                                                    </label> 

                                                                </td>
                                                                <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                <td style="text-align: center;">
                                                                    <script type="text/javascript">
                                                                        $(function(){
                                                                            $("#regg<%=procedure.getId()%>").attr("checked", false);  
                                                                            $("#regg2<%=procedure.getId()%>").attr("checked", false);
                                                                            $("#con<%=procedure.getId()%>").attr("checked", false);  
                                                                            $("#con2<%=procedure.getId()%>").attr("checked", false);
        
                                                                            $("#regg<%=procedure.getId()%>").change(function(){
                                                                                if($("#regg<%=procedure.getId()%>").is(':checked')){
                                                                                    $("#displayregg2<%=procedure.getId()%>").css("display", "block")
                                                                                }else{
                                                                                    $("#displayregg2<%=procedure.getId()%>").css("display", "none")
                                                                                }
                                                                            });
        
                                                                            $("#regg2<%=procedure.getId()%>").change(function(){
                                                                                if($("#regg2<%=procedure.getId()%>").is(':checked')){
                                                                                    $("#displayregg3<%=procedure.getId()%>").css("display", "block")
                                                                                }else{
                                                                                    $("#displayregg3<%=procedure.getId()%>").css("display", "none")
                                                                                }
                                                                            });
        
                                                                            $("#con<%=procedure.getId()%>").change(function(){
                                                                                if($("#con<%=procedure.getId()%>").is(':checked')){
                                                                                    $("#displaycon2<%=procedure.getId()%>").css("display", "block")
                                                                                }else{
                                                                                    $("#displaycon2<%=procedure.getId()%>").css("display", "none")
                                                                                }
                                                                            });
        
                                                                            $("#con2<%=procedure.getId()%>").change(function(){
                                                                                if($("#con2<%=procedure.getId()%>").is(':checked')){
                                                                                    $("#displaycon3<%=procedure.getId()%>").css("display", "block")
                                                                                }else{
                                                                                    $("#displaycon3<%=procedure.getId()%>").css("display", "none")
                                                                                }
                                                                            });
         
                                                                        })
                                                                    </script>
                                                                    <div style="display: block; text-align: center;" id="displaycon<%=procedure.getId()%>">
                                                                        <label class="switch-container">
                                                                            <input type="checkbox" name="copay[]" value="<%=procedure.getId()%>" onclick="displayCon()" id="con<%=procedure.getId()%>" class="switch-input hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label> 
                                                                    </div>
                                                                    <div style="display: none; text-align: center;" id="displaycon2<%=procedure.getId()%>"><%
                                                                        if (mgr.sponsorshipDetails(vst.getPatientid()).getSecondaryType().equalsIgnoreCase("CASH")) {%>
                                                                        <input class="input-mini" type="text" id="conamountpaid" name="secondarysupportcon<%=procedure.getId()%>" value=""/>      <%} else {
                                                                            // out.print(mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSecondarySponsor()).getSponsorname());
%>

                                                                        <input class="input-mini" type="text" id="conamountpaid" name="secondarysupportcon<%=procedure.getId()%>" value=""/><%}%>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div style="display: block; text-align: center;" id="displaycon1<%=procedure.getId()%>">

                                                                        <label class="switch-container">

                                                                            <input type="checkbox" name="isprivateSupportcon[]" value="<%=procedure.getId()%>" onclick="displayConOne()" id="con2<%=procedure.getId()%>" class="switch-input checkValue<%= vst.getOrderid()%> hide">
                                                                            <div class="switch">
                                                                                <span class="switch-label">Yes</span>
                                                                                <span class="switch-label">No</span>
                                                                                <span class="switch-handle"></span>
                                                                            </div>  
                                                                        </label>
                                                                    </div>
                                                                    <div style="display: none; text-align: center;" id="displaycon3<%=procedure.getId()%>">
                                                                        <input type="text" class="input-mini" id="conamountpaid" name="privatesupportcon<%=procedure.getId()%>" value=""/>
                                                                    </div>
                                                                </td>
                                                                <% }
                                                                    }%>
                                                            </tr>

                                                            <%//}
                                                            %> 
                                                            <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                            <tr>
                                                                <td  style="border-top: solid 1px black; padding-left: 5px; line-height: 25px;">
                                                                    <b>   Total Amount Credited </b>
                                                                </td>
                                                                <td style="border-top: solid 1px black; text-align: right; font-weight: bold;" class="amountduetext<%=vst.getOrderid()%>">

                                                                    <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" />
                                                                    <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" name="amountpaid" value="<%=total%>"/>
                                                                </td>
                                                                <td colspan="3" style="border-top: solid 1px black">

                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td  style="padding-top: 10px; padding-left: 5px; line-height: 25px;">
                                                                    Payment Status  
                                                                </td>
                                                                <td colspan="5" style="padding-top: 10px; text-align: right;" class="paymentstatus<%=vst.getOrderid()%>">

                                                                    Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

                                                                </td>
                                                            </tr>



                                                            <% } else {%> 

                                                            <tr>
                                                                <td  style="border-top: solid 1px black; padding-left: 5px; line-height: 25px;">
                                                                    <b>   Total Bill </b>
                                                                </td>
                                                                <td style="border-top: solid 1px black; text-align: right; font-weight: bold; " class="amountduetext<%=vst.getOrderid()%>">

                                                                    <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" />
                                                                </td>

                                                                <td style="border-top: solid 1px black; text-align: center;">
                                                                    <a href="#" class="btn btn-danger btn-mini" style="color: #fff;" onclick='showdiscount("discount<%=vst.getVisitid()%>");return false' id="discount<%=vst.getVisitid()%>">Discount</a>
                                                                    <div class="dialog" id="password_link<%=vst.getVisitid()%>" title="Discounting Medical Bills">
                                                                        <form action="" class="form-horizontal" method="post">
                                                                            <div class="control-group">
                                                                                <label class="control-label" for="inputEmail">Username</label> 
                                                                                <div class="controls">
                                                                                    <input type="text" name="username" id="username<%=vst.getVisitid()%>" /><br/>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label class="control-label" for="inputEmail">Password</label> 
                                                                                <div class="controls">
                                                                                    <input type="password" name="password" id="password<%=vst.getVisitid()%>" /><br/>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-actions">
                                                                                <button class="btn btn-info pull-right" id="verify<%=vst.getVisitid()%>" onclick="return false">
                                                                                    <i class="icon-white icon-check"></i> Give Discount
                                                                                </button>   
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                    <div class="dialog" id="discount_links<%=vst.getVisitid()%>" title="Discounting Medical Bill">
                                                                        <form action="" class="form-horizontal" method="post">
                                                                            <div class="control-group">
                                                                                <label class="control-label" for="inputEmail">Percentage Discount</label> 
                                                                                <div class="controls">
                                                                                    <input class="input-mini decimal" type="text" name="percentagediscount" id="percentagediscount<%=vst.getVisitid()%>" />
                                                                                    <p class="help-inline"> % </p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label class="control-label" for="inputEmail">Actual Discount</label>  
                                                                                <div class="controls">
                                                                                    <input class="input-mini decimal" type="text" name="actualdiscount" id="actualdiscount<%=vst.getVisitid()%>" />  
                                                                                    <p class="help-inline"> GHS </p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label class="control-label" for="inputEmail">
                                                                                    New Credited Price</label> 
                                                                                <div class="controls"> 
                                                                                    <input  class="input-mini decimal" type="text" name="newamount" id="newamount<%=vst.getVisitid()%>" />
                                                                                    <p class="help-inline"> GHS </p>
                                                                                </div>
                                                                            </div>
                                                                            <input type="hidden" name="status" id="statusdis<%=vst.getVisitid()%>" value="Medical Bills" />
                                                                            <input type="hidden" name="visitid" id="visitiddis<%=vst.getVisitid()%>" value="<%=vst.getVisitid()%>" />
                                                                            <input type="hidden" name="staffid" id="staffiddis<%=vst.getVisitid()%>" value="" />
                                                                            <div class="control-group">
                                                                                <label class="control-label" for="inputEmail">
                                                                                    Reason</label>
                                                                                <div class="controls"> 
                                                                                    <textarea name="reasondis" id="reasondis<%=vst.getVisitid()%>"></textarea>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-actions">
                                                                                <button class="btn btn-small btn-danger" id="<%=vst.getVisitid()%>_discount" onclick="return false;">
                                                                                    <i class="icon-white icon-check"></i> Give Discount
                                                                                </button>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </td> 
                                                            </tr>
                                                            <tr>
                                                                <td class="discount_row<%=vst.getVisitid()%> hide  " style="text-align: left;">  
                                                                    <b>
                                                                        Discount
                                                                    </b>
                                                                </td>
                                                                <td class="discount_row<%=vst.getVisitid()%> hide  ">
                                                                    <span style="text-align: right; float: right;" class="discount_row_amount<%=vst.getVisitid()%>"></span>
                                                                </td>

                                                                <td class="discount_row<%=vst.getVisitid()%> hide  ">
                                                                    <span style="text-align: right; float: right" class="discount_row_percent<%=vst.getVisitid()%>"></span>
                                                                </td>

                                                            </tr>

                                                            <tr>
                                                                <td class="discount_row<%=vst.getVisitid()%> hide   text-success" style="text-align: left;">  
                                                                    <b>
                                                                        Bill Due to Discount
                                                                    </b>
                                                                </td>
                                                                <td class="discount_row<%=vst.getVisitid()%> hide  text-success ">
                                                                    <span style="text-align: right; float: right;" class="bill_after_discount<%=vst.getVisitid()%>"></span>
                                                                </td>

                                                                <td class="discount_row<%=vst.getVisitid()%> hide  ">

                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td  style="padding-left: 5px; line-height: 25px;">
                                                                    Amount Paid 
                                                                </td>
                                                                <td style="text-align: right;">

                                                                    <input  class="input-mini amountpaidinput<%=vst.getOrderid()%>" style="color: blue;  margin-bottom: 0px; text-align: right; font-size: 15px;"  type="text" name="amountpaid" value="0.00"/>
                                                                </td>
                                                                <td>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td  style=" padding-left: 5px; line-height: 25px;">
                                                                    Balance Tendered
                                                                </td>
                                                                <td style="text-align: right;  margin-right: 20px;" class="balancetext<%=vst.getOrderid()%>">

                                                                </td>
                                                                <td>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td  style="padding-top: 10px; padding-left: 5px; line-height: 25px;">
                                                                    Payment Status  
                                                                </td>
                                                                <td style="padding-top: 10px;text-align: right;  margin-right: 20px;" class="paymentstatus<%=vst.getOrderid()%>"> 

                                                                </td>
                                                                <td>

                                                                </td>
                                                            </tr>

                                                            <% }%> 
                                                            <tr>
                                                                <td>
                                                                    <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%= vst.getOrderid()%>" style="display: none">
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

                                                                                <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                                    PROCEDURE INVOICE 
                                                                                    <% } else {%> PROCEDURE RECEIPT <% }%></h3>

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
                                                                                            INV<%=vst.getOrderid()%>
                                                                                        </td>
                                                                                    </tr>

                                                                                    <tr>
                                                                                        <td style="line-height: 25px;">
                                                                                            Account
                                                                                        </td>
                                                                                        <td style="line-height: 25px;">
                                                                                            <%=mgr.sponsorshipDetails(vst.getPatientid()).getType()%> Patient
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="line-height: 25px;">
                                                                                            Name:
                                                                                        </td>
                                                                                        <td style="line-height: 25px;">
                                                                                            <%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                                                                            <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                                                                            <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="line-height: 25px;">
                                                                                            Card No.
                                                                                        </td>
                                                                                        <td style="line-height: 25px; text-transform: uppercase">
                                                                                            <%= vst.getPatientid()%>
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
                                                                                            procedures = mgr.listPatientProcdureByOrderid(vst.getOrderid());
                                                                                            for (int r = 0; r < procedures.size(); r++) {
                                                                                                PatientProcedure procedure = (PatientProcedure) procedures.get(r);
                                                                                        %>

                                                                                        <tr>
                                                                                            <td class="procedure_check<%=procedure.getProcedureCode()%>" style="text-align: left; padding-left: 15px; line-height: 25px;"><%=mgr.getProcedure(procedure.getProcedureCode()).getDescription()%> </td>
                                                                                            <td class="procedure_check<%=procedure.getProcedureCode()%>" style="width: 80px; text-align: right; padding-right: 5px; line-height: 25px;"><%=df.format(mgr.getProcedure(procedure.getProcedureCode()).getPrice())%> 
                                                                                            </td>
                                                                                        </tr>
                                                                                        <%  }%>

                                                                                        <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                                                                                        <tr>
                                                                                            <td  style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                                                <b>   Total Amount Credited </b>
                                                                                            </td>
                                                                                            <td style="border-top: solid 1px black; text-align: right; padding-right: 5px;" class="amountduetext<%=vst.getOrderid()%>">
                                                                                                <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td  style="padding-top: 10px; padding-left: 15px; line-height: 25px;">
                                                                                                Payment Status  
                                                                                            </td>
                                                                                            <td style="padding-top: 10px; text-align: right;  padding-right: 5px;" class="paymentstatus<%=vst.getOrderid()%>">

                                                                                                Credited to <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>

                                                                                            </td>
                                                                                        </tr>



                                                                                        <% } else {%> 

                                                                                        <tr>
                                                                                            <td style="border-top: solid 1px black; padding-left: 15px; line-height: 25px;">
                                                                                                <b>   Total Bill </b>
                                                                                            </td>
                                                                                            <td style="border-top: solid 1px black; text-align: right;">
                                                                                                <span style="text-align: right; font-weight: bold; padding-right: 5px;" class="amountduetext<%=vst.getOrderid()%>"> </span>
                                                                                                <input type="hidden" class="amountdueinput<%=vst.getOrderid()%>" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="print_discount_row<%=vst.getVisitid()%> hide " style="padding-left: 15px; line-height: 25px;">  

                                                                                                Discount

                                                                                            </td>
                                                                                            <td style="text-align: right;  margin-right: 20px;" class="print_discount_row<%=vst.getVisitid()%> hide discount_row_amount_percent<%=vst.getVisitid()%>">

                                                                                            </td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td class="print_discount_row<%=vst.getVisitid()%> hide text-success" style="padding-left: 15px; line-height: 25px;">  
                                                                                                <b>
                                                                                                    Bill Due to Discount
                                                                                                </b>
                                                                                            </td>
                                                                                            <td  style="text-align: right;  margin-right: 20px;" class="print_discount_row<%=vst.getVisitid()%> text-success hide bill_after_discount<%=vst.getVisitid()%>">

                                                                                            </td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td  style="padding-left: 15px; line-height: 25px;">
                                                                                                Amount Paid 
                                                                                            </td>
                                                                                            <td style="text-align: right;  padding-right: 5px;" class="amountpaidtext<%=vst.getOrderid()%>">

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style=" padding-left: 15px; line-height: 25px;">
                                                                                                Balance Tendered
                                                                                            </td>
                                                                                            <td style="text-align: right;  padding-right: 5px;" class="balancetext<%=vst.getOrderid()%>">

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td  style=" padding-left: 15px; line-height: 25px;">
                                                                                                Payment Status  
                                                                                            </td>
                                                                                            <td style="text-align: right;  padding-right: 5px;" class="paymentstatus<%=vst.getOrderid()%>">

                                                                                            </td>
                                                                                        </tr>


                                                                                        <% }%> 
                                                                                    </tbody>
                                                                                </table>

                                                                            </div>
                                                                            <div style="clear: both"></div>

                                                                            <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                                                                Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                                                                Wishing You Speedy Recovery <br /> Thank you
                                                                            </div>       
                                                                        </section> 
                                                                    </div>
                                                                </td>
                                                                <td>

                                                                </td>
                                                                <td>

                                                                </td>
                                                                <%  if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 

                                                                <td>

                                                                </td>
                                                                <td>

                                                                </td>
                                                                <% }%>
                                                            </tr>

                                                        </tbody>

                                                    </table>

                                                    <div style="text-align: center;" class="form-actions">
                                                        <button class="btn btn-info btn-small pull-left" href="" onclick='printSelection(document.getElementById("print<%=vst.getOrderid()%>"));return false'>
                                                            <i class="icon-white icon-print"></i> Print
                                                        </button>

                                                        <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                        <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                        <input type="hidden" id="orderid_<%=vst.getOrderid()%>" name="orderid" value="<%=vst.getOrderid()%>"/>
                                                        <%
                                                            String unitid = "";
                                                            if (mgr.getVisitById(vst.getVisitid()).getPreviouslocstion().equalsIgnoreCase("consultation")) {
                                                                unitid = "account";
                                                            } else {
                                                                unitid = "records";
                                                            }
                                                        %>
                                                        <input type="hidden" name="from" value="Pharmacy"/>
                                                        <input type="hidden" name="unitid" value="Cashier"/>

                                                        <button type="submit" name="action" value="Procedure Receipt" class="btn btn-danger btn-small pull-right" onclick='updateProcedure("orderid_<%=vst.getOrderid()%>","amountdue_<%=vst.getOrderid()%>");return false'>
                                                            <i class="icon-white icon-arrow-right"> </i> Forward
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>

                                    </td>
                                    <td>

                                    </td>

                                    <td>

                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bold; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                    <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                    <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                    <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>


                                    <td><%= formatter.format(vst.getOrderdate())%>   </td>

                                    <td>
                                        <button class="btn btn-info btn-small" id="<%=vst.getOrderid()%>_link">
                                            Payment
                                        </button></td>
                                </tr>
                                <%}
                                    }%> 

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
<% for (int i = 0;
            i < visits.size();
            i++) {
        Procedureorders vst = (Procedureorders) visits.get(i);
%>
<script type="text/javascript">
    
    
    var amountdue<%=vst.getOrderid()%> = 0.0;
    
    $(".amountduepiece<%=vst.getOrderid()%>").each(function(){
         
        //alert("amountduepiece"+ $(".amountduepiece<%=vst.getOrderid()%>").attr("value"))
        amountdue<%=vst.getOrderid()%> = parseFloat(amountdue<%=vst.getOrderid()%>)  + parseFloat($(this).attr("value"));
        $(".amountduetext<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue<%=vst.getOrderid()%>);
    });
    // alert(amountdue<%=vst.getOrderid()%>)
    
    $("#<%= vst.getOrderid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true
    });
    $("#<%= vst.getOrderid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true
    });
    $("#<%= vst.getOrderid()%>_link").click(function(){
        $("#<%=vst.getOrderid()%>_dialog").dialog('open');
    })
    $("#<%= vst.getPatientid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true
    });
    $("#<%= vst.getVisitid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getVisitid()%>_adddrug_dialog").dialog('open');
    })
    $("#discount_links<%=vst.getVisitid()%>").dialog({
        autoOpen : false,
        width : 450,
        modal :true
    });
    /* $("#discount<%=vst.getVisitid()%>").click(function(){
        $("#discount_link<%=vst.getVisitid()%>").dialog('open');
        return false;
    
    })*/
    $("#password_link<%=vst.getVisitid()%>").dialog({
        autoOpen : false,
        width : 450,
        modal :true
    });
    $("#discount<%=vst.getVisitid()%>").click(function(){
        $(".discount_row<%=vst.getVisitid()%>").show()
        $("#password_link<%=vst.getVisitid()%>").dialog('open');
        return false; 
    }) 
   
    $(function(){
        var amountdue = parseFloat($(".amountdueinput<%= vst.getOrderid()%>").attr("value")).toFixed(2);
        
        $(".amountduetext<%= vst.getOrderid()%>").html(amountdue);
        var checkedValue = 0;
        //$("#amountdue").attr("value",parseFloat(0));
        //$("#amountduetext").html("0.0");
        
        $(".balanceinput<%= vst.getOrderid()%>").attr("value",parseFloat(0).toFixed(2));
        $(".balancetext<%= vst.getOrderid()%>").html("0.00");
        
        $(".amountpaidinput<%= vst.getOrderid()%>").attr("value",parseFloat(0).toFixed(2))
        $(".amountpaidtext<%= vst.getOrderid()%>").html($(".amountpaidinput<%= vst.getOrderid()%>").attr("value"))
        
        $(".amountpaidinput<%= vst.getOrderid()%>").live('keyup',function(){
           
            var amountdue = $(".amountdueinput<%= vst.getOrderid()%>").attr("value");
            var amountpaid = $(".amountpaidinput<%= vst.getOrderid()%>").attr("value");
            $(".amountpaidtext<%= vst.getOrderid()%>").html($(".amountpaidinput<%= vst.getOrderid()%>").attr("value"))
            
            if(amountpaid == ""){
                amountpaid = 0;
            }
            var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
            
            if(amountpaid > 0 &&balance < 0){
                $(".paymentstatus<%= vst.getOrderid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                $('.balanceinput<%= vst.getOrderid()%>').closest('.control-group').addClass('error').removeClass('success')
                $('.balancetext<%= vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
                $('.balancetextcolour<%= vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
               
            } else if (amountpaid == 0){
                $(".paymentstatus<%= vst.getOrderid()%>").html("").removeClass('text-success').removeClass('text-error')
                $('.balanceinput<%= vst.getOrderid()%>').closest('.control-group').removeClass('success').removeClass('error')
                $('.balancetext<%= vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                
            } 
           
            else if(amountpaid > 0 && balance >= 0){
                $(".paymentstatus<%= vst.getOrderid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                $('.balanceinput<%= vst.getOrderid()%>').closest('.control-group').addClass('success').removeClass('error')
                $('.balancetext<%= vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
                $('.balancetextcolour<%= vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
            }
            $(".balanceinput<%= vst.getOrderid()%>").attr("value",parseFloat(balance).toFixed(2));
            $(".balancetext<%= vst.getOrderid()%>").html(parseFloat(balance).toFixed(2));
            $(".amountduetext<%= vst.getOrderid()%>").attr("value",$(".amountdue<%= vst.getOrderid()%>").attr("value"));
            
        });
        
        
        var amounttoplimit = amountdue;
        var amountbottomlimit = 0;
        
        
        $(".checkValue<%=vst.getOrderid()%>").change(function(){
            
            
            var amountpaid = parseFloat($(".amountpaidinput<%=vst.getOrderid()%>").attr("value"));
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
                    
                    $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue);
                    $(".amountduetext<%=vst.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    
                }
    <%
        List procedures = mgr.listPatientProcdureByOrderid(vst.getOrderid());
        for (int r = 0; r < procedures.size(); r++) {
            PatientProcedure procedure = (PatientProcedure) procedures.get(r);
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
                    
                        $(".amountdueinput<%=vst.getOrderid()%>").attr("value",amountdue);
                        $(".amountduetext<%=vst.getOrderid()%>").html(parseFloat(amountdue).toFixed(2));
                    }
               
    <%
        procedures = mgr.listPatientProcdureByOrderid(vst.getOrderid());
        for (int r = 0; r < procedures.size(); r++) {
            PatientProcedure procedure = (PatientProcedure) procedures.get(r);
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
                    $(".balancetext<%=vst.getOrderid()%>").html(parseFloat(balance).toFixed(2));
                }
                if(amountpaid > 0 && balance < 0){
                    $(".paymentstatus<%=vst.getOrderid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                    $('.balanceinput<%=vst.getOrderid()%>').closest('.control-group').addClass('error').removeClass('success')
                    $('.balancetext<%=vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
                    $('.balancetextcolour<%=vst.getOrderid()%>').addClass('text-error').removeClass('text-success')
               
                } else if (amountpaid == 0.00){
                    $(".paymentstatus").html("").removeClass('text-success').removeClass('text-error')
                    $('.balanceinput<%=vst.getOrderid()%>').closest('.control-group').removeClass('success').removeClass('error')
                    $('.balancetext<%=vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                    $('.balancetextcolour<%=vst.getOrderid()%>').removeClass('text-success').removeClass('text-error')
                
                }
                else if(amountpaid > 0 && balance >= 0){
                    $(".paymentstatus").html("Full Payment").addClass('text-success').removeClass('text-error')
                    $('.balanceinput<%=vst.getOrderid()%>').closest('.control-group').addClass('success').removeClass('error')
                    $('.balancetext<%=vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
                    $('.balancetextcolour<%=vst.getOrderid()%>').addClass('text-success').removeClass('text-error')
                }
            });
        })
        var amountduebeforediscount = $(".amountdueinput<%= vst.getOrderid()%>").attr("value");
        $("#newamount<%= vst.getVisitid()%>").attr("value",amountduebeforediscount);
        var amountdueafterdiscount;
        var discountpercentage;
        var discountamount;
    
        $("#actualdiscount<%= vst.getVisitid()%>").live('keyup',function(){
            if( $(this).attr("value") >= 0){ 
                
                discountamount = $("#actualdiscount<%= vst.getVisitid()%>").attr("value");
                discountpercentage = (parseFloat(discountamount)/parseFloat(amountduebeforediscount))*100
                amountdueafterdiscount = parseFloat(amountduebeforediscount).toFixed(2) - parseFloat(discountamount).toFixed(2);
                $("#percentagediscount<%= vst.getVisitid()%>").attr("value",parseFloat(discountpercentage).toFixed(2));
                $("#newamount<%= vst.getVisitid()%>").attr("value",parseFloat(amountdueafterdiscount).toFixed(2));       
                $(".discount_row_percent<%=vst.getVisitid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%") 
                $(".discount_row_amount<%=vst.getVisitid()%>").html(parseFloat(discountamount).toFixed(2))
                $(".bill_after_discount<%=vst.getVisitid()%>").html(parseFloat(amountdueafterdiscount).toFixed(2));
                $(".discount_row_amount_percent<%=vst.getVisitid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
            }else {
                alert("Please Enter a Positive Decimal Value, Only")
            }
        
        });
    
        $("#percentagediscount<%= vst.getVisitid()%>").live('keyup',function(){
            if( $(this).attr("value") >= 0){ 
                
                discountpercentage = $("#percentagediscount<%= vst.getVisitid()%>").attr("value");
                
                var discountamount = (parseFloat(discountpercentage)*parseFloat(amountduebeforediscount))/100
                var amountdueafterdiscount = amountduebeforediscount - discountamount;
        
                $("#actualdiscount<%= vst.getVisitid()%>").attr("value",discountamount);
                $("#newamount<%= vst.getVisitid()%>").attr("value",amountdueafterdiscount);         
       
                $(".discount_row_percent<%=vst.getVisitid()%>").html(parseFloat(discountpercentage).toFixed(2)+"%"); 
                $(".discount_row_amount<%=vst.getVisitid()%>").html(parseFloat(discountamount).toFixed(2));
                $(".bill_after_discount<%=vst.getVisitid()%>").html(parseFloat(amountdueafterdiscount).toFixed(2));
                $(".discount_row_amount_percent<%=vst.getVisitid()%>").html("("+parseFloat(discountpercentage).toFixed(2)+"%)      "+parseFloat(discountamount).toFixed(2));
            
            }else {
                alert("Please Enter a Positive Decimal Value, Only")
            }
        
        });
        $("#verify<%=vst.getVisitid()%>").click(function(){
            // alert("hello");
            var username = $("#username<%=vst.getVisitid()%>").attr("value");
            var password = $("#password<%=vst.getVisitid()%>").attr("value");
            $.post('patientcount.jsp', {action : "patientdiscount", username : username, password : password}, function(data) {
                //alert(data);
                var bool = data;
                if(bool=="false"){
                    alert("You are eligible please go ahead")
                }
                else{
                    alert("You don't qualify to give discount please talk to a senior staff")
                    $("#discount_links<%=vst.getVisitid()%>").dialog('open');
                    return false;
                }
            });
        });
        $("#<%=vst.getVisitid()%>_discount").click(function(){     
            var percentage = $("#percentagedis<%=vst.getVisitid()%>").attr("value");
            var actual = $("#actualdis<%=vst.getVisitid()%>").attr("value");
            var newcharge = $("#newamount<%=vst.getVisitid()%>").attr("value");
            var status = $("#statusdis<%=vst.getVisitid()%>").attr("value");
            var staff = $("#staffiddis<%=vst.getVisitid()%>").attr("value");
            var reason = $("#reasondis<%=vst.getVisitid()%>").attr("value");
            var visit = $("#visitiddis<%=vst.getVisitid()%>").attr("value");
            $(".amountdueinput<%=vst.getOrderid()%>").attr("value", newcharge);
            $(".print_discount_row<%=vst.getVisitid()%> hide ").show()
            alert(staff);
            $.post('patientcount.jsp', {action : "savediscount", percentage : percentage, actual : actual, newcharge : newcharge, status : status, staff : staff, reason : reason, visit : visit}, function(data) {
                alert(data);      
            });
            //  return false;
        }); 
    
    
    
</script>
<% }%>
</body>
</html>