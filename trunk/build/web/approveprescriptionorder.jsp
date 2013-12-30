<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Formatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("index.jsp");


    }%>

<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    TransactionEntityManager mgg = new TransactionEntityManager();
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy hh:mm a");
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
    Date date = new Date();
    // List visits = mgr.listUnitVisitations("pharmacy", dateFormat.format(date));
    List visits = mgr.listPharmordersByStatus("Not Done");
    String orderId = request.getParameter("orderid");
    Pharmorder pharmOrder = (Pharmorder) mgr.getPharmorder(orderId);
    if (pharmOrder == null) {
        session.setAttribute("lasterror", "Please Select Prescription Order");
        session.setAttribute("class", "alert-error");
        response.sendRedirect("prescriptionorders.jsp");

    }



%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
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
                            <a href="#">Dispensary</a><span class="divider"></span>
                        </li>
                        <li>
                            <a href="prescriptionorders.jsp">Prescription Orders</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Prescription Order | <%= pharmOrder.getPatientid()%></a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>



                <div class="row-fluid">


                    <%@include file="widgets/leftsidebar.jsp" %>



                    <div style="display: none;" class="span8 thumbnail main-c">

                        <table class="example display table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;"> Folder Number</th>
                                    <th style="text-align: left;"> Patient Name </th>
                                    <th style="text-align: left;"> Payment Type </th>
                                    <th style="text-align: left;"> Date of Birth  </th>
                                    <th style="text-align: left;"> Requested On </th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Pharmorder vst = pharmOrder;
                                %>
                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                    <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>

                                    <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  </td>
                                    <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                    <td><%= formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                    <td><%=formatter.format(vst.getOrderdate())%> </td>

                                    <td>
                                        <a class="btn btn-info btn-small dialog_link" id="<%= pharmOrder.getOrderid()%>_link">
                                            <i class="icon-white icon-check"></i> Approve Dispensing
                                        </a>
                                    </td>
                                </tr>


                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>
            <div  class="center hide" id="<%= pharmOrder.getOrderid()%>" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> PRESCRIPTION ORDER FOR <%= pharmOrder.getPatientid()%> </span>">

                <div class="lead">
                    CONFIRM THAT THE PATIENT CAN AFFORD ANY TREATMENT(S) PRESCRIBED
                </div>

                <form  action="action/prescriptionaction.jsp" method="post">
                    <input type="hidden" name="orderid" value="<%=pharmOrder.getOrderid()%>" />
                    <table id="appendx_3<%=pharmOrder.getPatientid()%>" class="table table-bordered table-condensed">

                        <thead>
                            <tr>
                                <th style="color: white; text-align: left; font-size: 14px; width: 35%" >
                                    Prescribed Treatment
                                </th>
                                <th style="color: #fff; text-align: left; font-size: 14px; width: 20%">
                                    Dosage 
                                </th>
                                <th style="color: #fff; text-align: right; font-size: 14px; width: 5%">
                                    Quantity
                                </th>                                                                
                                <th style="color: #fff; text-align: right; font-size: 14px; width: 10%"> 
                                    Price GH&#162; 
                                </th>
                                <th style="color: #fff; text-align: right; font-size: 14px;  width: 10%"> 
                                    Total GH&#162; 
                                </th>
                                <th style="color: #fff; font-size: 14px; width: 5%">
                                    Approved
                                </th>
                                <th style="color: #fff; font-size: 14px; width: 15%">
                                    Medicine Availability
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List dispensary = mgg.listObjects("from Patienttreatment where orderid='" + orderId + "'");
                                if (dispensary.size() > 0) {%>
                        <th colspan="7"><h4> Dispensary Items</h4></th>
                        <%
                            for (int r = 0; r < dispensary.size(); r++) {
                                Patienttreatment ptPatienttreatments = (Patienttreatment) dispensary.get(r);

                                if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No") && ptPatienttreatments.getDispensaryItems() != null) {
//DispensaryItems di = (DispensaryItems)mg.getStringObject(object, id);
                                    double price = 0.0;
                        %>
                        <tr>
                            <td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>">
                                <b> <%=ptPatienttreatments.getDispensaryItems().getItemDescription() + " " + ptPatienttreatments.getDispensaryItems().getItemForm().getFormDescription() + " " + ptPatienttreatments.getDispensaryItems().getStrength()%> </b>
                            </td>
                            <td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-transform: capitalize;">
                                <%=ptPatienttreatments.getDosage().getDescription()%>  
                            </td>
                            <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-align: center;"> 
                                <%=ptPatienttreatments.getDosage().getQuantity()%> 
                            </td>
                            <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-align: right;" id="price_<%=ptPatienttreatments.getId()%>">
                                <%=df.format(ptPatienttreatments.getPrice())%> 

                            </td>
                            <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-align: right;" id="total_<%=ptPatienttreatments.getId()%>">
                                <% price = ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice();%>
                                <%= df.format(price)%>

                            </td>
                            <td>
                                <% String check = "checked";
                                    if (ptPatienttreatments.getDispensaryItems().getQuantityOnHand() > ptPatienttreatments.getDosage().getQuantity()) {%>
                                <label  class="switch-container">

                                    <input id="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>"   type="checkbox" name="afford[]" checkPrice="" checkvalue="" vetSet="False" rowId="" checkvalue="<%=ptPatienttreatments.getId()%>" style="width: 100px" class="switch-input value<%=vst.getOrderid()%> hide" value="<%=ptPatienttreatments.getId()%>">
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div>  
                                </label>   

                                <%} else {%>
                                <label  class="switch-container">

                                    <input id="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>"  type="checkbox" name="afford[]" checkPrice="" checkvalue=""  value="<%=ptPatienttreatments.getId()%>" style="width: 100px" class="switch-input checkValue<%=vst.getOrderid()%> hide">
                                    <div class="switch">
                                        <span class="switch-label">Yes</span>
                                        <span class="switch-label">No</span>
                                        <span class="switch-handle"></span>
                                    </div>  
                                </label> 
                                <%}%>

                            </td>
                            <td>
                                <%
                                    List<DispensaryBatch> batchs = mgg.listObjects("from DispensaryBatch where item_code='" + ptPatienttreatments.getDispensaryItems().getItemCode() + "' ORDER BY expiry_date ASC");
                                    System.out.println("qty " + ptPatienttreatments.getDispensaryItems().getQuantityOnHand());
                                    if (ptPatienttreatments.getDispensaryItems().getQuantityOnHand() > ptPatienttreatments.getDosage().getQuantity()) {
                                %>
                                <button class="btn-success btn pull-right" style="width: 100%"  onclick='show("batches_<%= ptPatienttreatments.getId()%>");return false;' id="click<%= ptPatienttreatments.getId()%>">
                                    <i class="icon-white icon-arrow-right"></i>  select from batches
                                </button>
                                <div  style="display: none" class="center" id="batches_<%= ptPatienttreatments.getId()%>" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> PRESCRIPTION ORDER FOR <%= pharmOrder.getPatientid()%> </span>">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th style="width: 10%">Batch Number</th><th style="width: 20%">Item Description</th><th style="width: 10%">Expiry Date</th><th style="width: 10%">Quantity on Hand</th><th style="width: 50%"></th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%if (batchs != null) {
                                                    String color = "";

                                                    for (DispensaryBatch dispensaryBatch : batchs) {
                                                        if (mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) < 1) {
                                                            color = "#FF0000";
                                                        }
                                                        if (mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) > 0 && mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) < 3) {
                                                            color = "##FFFF00";
                                                        }
                                                        if (mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) > 3) {
                                                            color = "#00FF00";
                                                        }
                                            %>
                                            <tr style="background-color:  <%=color%>">
                                                <td><%=dispensaryBatch.getItemBatch()%></td>
                                                <td><%=dispensaryBatch.getDispensaryItems().getItemDescription()%></td>
                                                <td><%=dispensaryBatch.getExpiryDate()%></td>
                                                <td><%=dispensaryBatch.getQuantityOnHand()%></td>
                                                <td>
                                                    <%if (mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) < 1) {%>

                                                    <%}
                                                        if (mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) > 0 && mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) < 3) {%>
                                                    <button class="btn-success btn pull-right" style="width: 100%"  onclick='getPrice("batches_<%=ptPatienttreatments.getId()%>","<%=ptPatienttreatments.getQuantity()%>","<%=dispensaryBatch.getSellingPrice()%>","price_<%=ptPatienttreatments.getId()%>","total_<%=ptPatienttreatments.getId()%>","amountduepiece_<%=ptPatienttreatments.getId()%>","treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>","batch_<%=ptPatienttreatments.getId()%>","priceduepiece_<%=ptPatienttreatments.getId()%>","<%=dispensaryBatch.getItemBatch()%>","<%=ptPatienttreatments.getDosage().getDescription()%>","<%=ptPatienttreatments.getDispensaryItems().getItemDescription()%>");return false;' id="<%=dispensaryBatch.getItemBatch()%>">
                                                        <i class="icon-white icon-arrow-right"></i>  select
                                                    </button>
                                                    <% }
                                                        if (mgg.getMonthsBetweenDates(new Date(), dispensaryBatch.getExpiryDate()) > 3) {%>
                                                    <button class="btn-success btn pull-right" style="width: 100%"  onclick='getPrice("batches_<%=ptPatienttreatments.getId()%>","<%=ptPatienttreatments.getQuantity()%>","<%=dispensaryBatch.getSellingPrice()%>","price_<%=ptPatienttreatments.getId()%>","total_<%=ptPatienttreatments.getId()%>","amountduepiece_<%=ptPatienttreatments.getId()%>","treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>","batch_<%=ptPatienttreatments.getId()%>","priceduepiece_<%=ptPatienttreatments.getId()%>","<%=dispensaryBatch.getItemBatch()%>","<%=ptPatienttreatments.getDosage().getDescription()%>","<%=ptPatienttreatments.getDispensaryItems().getItemDescription()%>");return false;' id="<%=dispensaryBatch.getItemBatch()%>",>
                                                        <i class="icon-white icon-arrow-right"></i>  select
                                                    </button><%  }%>
                                                </td>
                                            </tr>
                                            <%}
                                                }%>
                                        </tbody>
                                    </table>
                                </div>
                                <%} else {%>
                                <button class="btn-danger btn pull-right" style="width: 100%"  onclick='return false;' id="click<%= ptPatienttreatments.getId()%>">
                                    <i class="icon-white icon-arrow-right"></i>  select from batches
                                </button><%}%>
                            </td>
                        </tr>
                        <input type="hidden" class="priceduepiece<%=vst.getOrderid()%>" name="priceduepiece<%=ptPatienttreatments.getId()%>"  value="" id="priceduepiece_<%=ptPatienttreatments.getId()%>"/>
                        <input type="hidden" class="priceduepiece<%=vst.getOrderid()%>" name="batch<%=ptPatienttreatments.getId()%>" value="" id="batch_<%=ptPatienttreatments.getId()%>"/>
                        <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" value="" name="amountduepiece<%=ptPatienttreatments.getId()%>" id="amountduepiece_<%=ptPatienttreatments.getId()%>"/>
                        <% }
                            }%>
                        <!--tr>
                            <td colspan="7">
                                <div class="form-actions center">

                                    <a href="dispatchprescription.jsp?orderid=<%=pharmOrder.getOrderid()%>" class="btn-info btn pull-left"  style="width: 40%; color: #fff;" type="button">
                                        <i class="icon-white icon-print"></i>  Print Prescription
                                    </a> 
                                    <button class="btn-danger btn pull-right" style="width: 40%" type="submit" name="action" value="approveprescription">
                                        <i class="icon-white icon-arrow-right"></i>  Approve Prescription Order For Payment
                                    </button>

                                </div>
                            </td>
                        </tr-->
                        <tr>
                            <td colspan="4" style="text-align: right"></td>
                        <input type="hidden" name="overalltotal" value="" id="overalltotal"/>
                        <td style="text-align: right;" id="initalTotalPrice"><b>0.00</b></td>
                        <td colspan="2" ></td>
                        </tr>

                        <%}%>

                        <%
                            List pharmacyItems = mgg.listObjects("from Patienttreatment where orderid='" + orderId + "'");
                            if (pharmacyItems.size() > 0) {
                                for (int r = 0; r < pharmacyItems.size(); r++) {
                                    Patienttreatment ptPatienttreatments = (Patienttreatment) pharmacyItems.get(r);
                                    if (ptPatienttreatments.getDispensed().equalsIgnoreCase("No") && ptPatienttreatments.getPharmacyItem() != null) {

                                        double price = 0.0;
                        %>
                        <th colspan="7"><h4> Pharmacy Items</h4></th>
                        <tr>
                            <td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>">
                                <b><%=ptPatienttreatments.getPharmacyItem().getItemDescription() + " " + ptPatienttreatments.getPharmacyItem().getItemForm().getFormDescription() + " " + ptPatienttreatments.getPharmacyItem().getStrength()%> </b>
                            </td>
                            <!--td style="text-align: left;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-transform: capitalize;">
                            <%=ptPatienttreatments.getDosage().getDescription()%>  
                        </td-->
                        <!--td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-align: center;"> 
                            <%=ptPatienttreatments.getDosage().getQuantity()%> 
                        </td-->
                            <td colspan="5"></td>
                            <!--td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-align: right;" id="price_<%=ptPatienttreatments.getId()%>">
                            <%=df.format(ptPatienttreatments.getPrice())%> 
                            <input type="hidden" class="priceduepiece<%=vst.getOrderid()%>" name="priceduepiece<%=ptPatienttreatments.getId()%>" value="<%=df.format(ptPatienttreatments.getPrice())%>" id="priceduepiece<%=ptPatienttreatments.getId()%>"/>
                        </td>
                        <td style="text-align: right;" class="treatment_row<%=vst.getOrderid()%><%=ptPatienttreatments.getId()%>" style="text-align: right;" id="total_<%=ptPatienttreatments.getId()%>">
                            <% price = ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice();%>
                            <%= df.format(price)%>
                            <input type="hidden" class="amountduepiece<%=vst.getOrderid()%>" name="amountduepiece<%=ptPatienttreatments.getId()%>" value="<%= df.format(price)%>" id="amountduepiece<%=ptPatienttreatments.getId()%>"/>
                        </td-->

                            <td>
                                <%

                                    if (ptPatienttreatments.getPharmacyItem().getQuantityOnHand() > ptPatienttreatments.getDosage().getQuantity()) {
                                %>
                                <button class="btn-success btn pull-right" style="width: 100%"  onclick='return false;' id="click<%= ptPatienttreatments.getId()%>">
                                    <i class="icon-white icon-arrow-right"></i>  In Stock
                                </button>
                                <%} else {%>
                                <button class="btn-danger btn pull-right" style="width: 100%"  onclick='return false;' id="click<%= ptPatienttreatments.getId()%>">
                                    <i class="icon-white icon-arrow-right"></i>  select from batches
                                </button><%}%>
                            </td>
                        </tr>


                        <% }
                                }
                            }%>
                        </tbody>


                    </table>
                    <div class="clearfix">

                    </div>

                    <div class="form-actions center">
                        <% String text = "";
                            String status = "";
                            if (!dispensary.isEmpty() && dispensary.size() > 0 && pharmacyItems.isEmpty() && pharmacyItems.size() < 1) {
                                text = "Approve Prescription Order For Payment";
                                status = "NON";
                            }
                            if (!pharmacyItems.isEmpty() && pharmacyItems.size() > 0 && dispensary.isEmpty() && dispensary.size() < 1) {
                                text = "Forward Prescription to Pharmacy";
                                status = "CREATE";
                            }
                            if (!pharmacyItems.isEmpty() && pharmacyItems.size() > 0 && !dispensary.isEmpty() && dispensary.size() > 0) {
                                text = "Approve Prescription Order For Payment and Forward to Pharmacy";
                                status = "BOTH";
                            }
                            if (!dispensary.isEmpty() && dispensary.size() > 0) {%>
                        <a  class="btn-primary btn center"  style="width: 40%; color: #fff;" type="button" onclick='printSelection(document.getElementById("dispensary_<%=orderId%>"));return false;'>
                            <i class="icon-white icon-print"></i>  Print Prescription for Dispensary
                        </a>
                        <%}%>
                        <!--a href="dispatchprescription.jsp?orderid=<%=pharmOrder.getOrderid()%>" class="btn-info btn pull-left"  style="width: 30%; color: #fff;" type="button">
                            <i class="icon-white icon-print"></i>  Print Prescription for Pharmacy
                        </a-->

<!--a href="dispatchprescription.jsp?orderid=<%=pharmOrder.getOrderid()%>" class="btn-primary btn center"  style="width: 30%; color: #fff;" type="button">
    <i class="icon-white icon-print"></i>  Print All Prescription
</a--><input type="hidden" name="status" value="<%=status%>"/>
                        <button class="btn-danger btn pull-right" style="width: 40%" type="submit" name="action" value="approveprescription">
                            <i class="icon-white icon-arrow-right"></i>  <%=text%>
                        </button>

                    </div> 
                </form>

            </div>
            <div style="display: none; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="dispensary_<%=orderId%>"> 
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

                        <img src="images/Rx_symbol.png" width="20px;" style="float: left; margin-top: 0px;" />  
                        <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> 

                            Prescription Form </h3>

                    </div>

                    <hr style="border: solid #000000 0.5px ;"  />
                    <div style="clear: both;"></div>

                    <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">

                        <table style="width: 45%; float: left; margin-left: 6px; font-size:  7px;">

                            <tr>
                                <td style="line-height: 11px;">
                                    Patient Name:
                                </td>
                                <td style="line-height: 11px;">
                                    <%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                    <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                    <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                                </td>
                            </tr>
                            <tr>
                                <td style="line-height: 11px;">
                                    Patient Sex: 
                                </td>
                                <td style="line-height: 11px;">
                                    <%=mgr.getPatientByID(vst.getPatientid()).getGender()%>

                                </td>
                            </tr>
                            <tr>
                                <td style="line-height: 11px;">
                                    PATIENT AGE & DOB: 
                                </td>
                                <td style="line-height: 11px;">
                                    <% String yr = mgr.getPatientByID(vst.getPatientid()).getDateofbirth() + "";
                                        String tt = yr.split("-")[0];
                                        //String tyr = new Date()+"";
                                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

                                        String tyr = dateFormat1.format(new Date()) + "";
                                        String t = tyr.split("-")[0];
                                    %>

                                    <%=Integer.parseInt(t) - Integer.parseInt(tt)%> Years / <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%>
                                </td>
                            </tr>
                            <tr>
                                <td style="line-height: 11px;">
                                    Diagnosis
                                </td>
                                <td style="line-height: 11px;">
                                    <%List<Patientdiagnosis> patientdiagnosises = mgr.patientDiagnosis(vst.getVisitid());
                                        if (patientdiagnosises != null) {
                                            for (Patientdiagnosis patientdiagnosis : patientdiagnosises) {%>
                                    <b><% out.print(mgr.getDiagnosis(patientdiagnosis.getDiagnosisid()).getDiagnosis());%></b>
                                    <%  }
                                        }
                                    %> 
                                </td>
                            </tr>
                        </table>
                        <table style="width: 50%; float: right; margin-left: 6px; font-size:  7px;">
                            <tr>
                                <td style="line-height: 11px; font-size: 7">
                                    HOSPITAL / CLINIC: 
                                </td>
                                <td style="line-height: 11px;">
                                    Danpong Clinic 
                                </td>
                            </tr>
                            <tr>
                                <td style="line-height: 11px;">
                                    REFERRED BY:
                                </td>
                                <td style="line-height: 11px;">
                                    <%
                                        Stafftable s = mgr.getStafftableByid(mgr.getVisitById(vst.getVisitid()).getDoctor());
                                    %>
                                    <%=s.getLastname()%>
                                    <%=s.getOthername()%>

                                </td>
                            </tr>
                            <tr>
                                <td style="line-height: 11px;">
                                    Prescription Date:
                                </td>
                                <td style="line-height: 11px;">
                                    <%=datetimeformat.format(vst.getOrderdate())%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="clear: both;"></div>
                    <hr class="row" style="border-top: 2px solid  #000; margin-top: 5px;" >
                    <table style="width: 100%; float: left; margin-left: 6px; font-size:  12px;" id="addtable">
                        <thead>
                            <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: underline;">Item </th>
                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: underline;">Dosage</th>
                            </tr>
                        </thead>
                        <tbody style="width: 100%" id="addrole">

                        </tbody>
                        <tfoot style="display: table-footer-group; width: 100px;">
                            <tr>
                                <th colspan="2">
                        <div style="text-align: center ;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px;" class="center">
                            <br />
                            <br />
                            <span style="letter-spacing: 5px;" >*********</span><span style="font-style: italic; font-size: 12px;" class="lead">End of Prescription</span> <span style="letter-spacing: 5px;" >*********</span>
                            <br />

                        </div> 
                        <div style=" width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                            Served & Electronically Signed by:  <%= mgr.getStafftableByid(user.getStaffid()).getOthername()%> <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                            Thank you for doing business with us <br /> Wishing you the best of health.
                        </div>
                        </th>
                        </tr>
                        </tfoot>
                    </table>

                </section>
            </div>


            <%@include file="widgets/footer.jsp" %>
        </div><!-- /container -->    

    </div>
</div>
<!--end static dialog-->

<!-- Le javascript  -->
<%@include file="widgets/javascripts.jsp" %>
<script type="text/javascript">
    $(function() {
        $(".switch-input").change(function(){
            var totalValue =  $(this).attr("checkvalue");
            var rowId =  $(this).attr("rowId");
            var setValue = $(this).attr("vetSet");
            var overalltotal = $("#overalltotal").attr("value");
            
            if(setValue=="False"){
                $(this).attr("checked", false)
                alert("Please Select a batch") 
            }        
            if(setValue=="True"){      
                if($(this).is(':checked')){ 
                    overalltotal = parseFloat(overalltotal) + parseFloat(totalValue)
                    $("#overalltotal").attr("value",overalltotal);
                    $("#initalTotalPrice").html("<b> GH&#162;"+parseFloat(overalltotal).toFixed(2)+ "</b>")
                }else{
                    overalltotal = parseFloat(overalltotal) - parseFloat(totalValue)
                    $("#overalltotal").attr("value",overalltotal);
                    $("#initalTotalPrice").html("<b> GH&#162;"+parseFloat(overalltotal).toFixed(2)+ "</b>")
                    //var tbl = $('#addrole');
                    $('table#addtable tr#'+rowId).remove();
                    //alert(rowId)
                }
            }   
        });
    })
    
    $('#<%=pharmOrder.getOrderid()%>').dialog({
        autoOpen : true,
        width : "90%",
        modal : true,
        position: "top"
    });
    
    $('#<%=pharmOrder.getOrderid()%>_link').click(function() {
        $('#<%=pharmOrder.getOrderid()%>').dialog('open');
        return false;
    });
    function printSelection(node){
                        
        var content=node.innerHTML
        var pwin=window.open('','print_content','width=400,height=1000');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
            
    function show(id){
        $('#'+id).show(); 
        return false;
        //}); 
    }
    var count = 0;
    function getPrice(id,qty,price,tdPrice,tdTotal,textTotal,toGetCheckAttr,inputBatch,inputPrice,batch,dosage,description){
        var total = qty * price;
        var overAllTotal = 0;
        count ++;
        $('#'+tdPrice).text((price/1).toFixed(2)); 
        $('#'+tdTotal).text((total/1).toFixed(2)); 
        // $('#'+textPrice).text((price/1).toFixed(2));
        $('#'+textTotal).attr("value",(total/1).toFixed(2));
        $('#'+inputBatch).attr("value",batch);
        $('#'+inputPrice).attr("value",(price/1).toFixed(2));
        //alert('#'+inputPrice)
        $('#'+toGetCheckAttr).attr("checkPrice",(price/1).toFixed(2)); 
        $('#'+toGetCheckAttr).attr("checkvalue",(total/1).toFixed(2));
        $('#'+toGetCheckAttr).attr("vetSet","True");
        $('#'+id).hide(); 
        var overall = $('#overalltotal').attr("value");
        //alert(overall)
        overall = (overall/1)+(total/1)
        $('#'+toGetCheckAttr).attr("checked", true)
        $("#overalltotal").attr("value", overall.toFixed(2));
        //alert(overall)
        $("#initalTotalPrice").text(overall.toFixed(2));
        var tr = document.createElement("tr")
        tr.id="row_"+count;
        $('#'+toGetCheckAttr).attr("rowId","row_"+count);
        var td = document.createElement("td");
        var td1 = document.createElement("td");
        var dosage = document.createTextNode(dosage);
        var description = document.createTextNode(description);
        var table = document.getElementById("addrole")
        td.appendChild(description)
        td1.appendChild(dosage)
        tr.appendChild(td)
        tr.appendChild(td1)
        table.appendChild(tr)
        //alert(tr.id)
        var tt = $('#'+inputPrice).attr("value");
        //alert(tt)
        return false;
    }
    
</script>

</body>
</html>
