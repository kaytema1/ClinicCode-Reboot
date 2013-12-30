<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    PatientBills visit;
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);
    //Patient p = (Patient)session.getAttribute("patient");
    //get current date time with Date()
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    Date date = new Date();
    //System.out.println(dateFormat.format(date));
    List visits = mgr.listDebtors();
    // List patients = mgr.listPatients();
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">
            <header  class="jumbotron subhead" id="overview">
                <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="#">Billing</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Outstanding Bills</a><span class="divider"></span>
                        </li>
                    </ul>
                </div>
            </header>
            <%@include file="widgets/loading.jsp" %>
            <section id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="span9 offset3 thumbnail well content hide">
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Folder Number </th>
                                    <th style="text-align: left;">Full Name </th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Registered On</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < visits.size(); i++) {
                                        visit = (PatientBills) visits.get(i);
                                %>

                                <tr>
                                    <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>  </h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= mgr.getPatientByID(visit.getPatientid()).getEmployer()%>  </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr> <tr>
                                        <td> Membership Number </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%= mgr.sponsorshipDetails(visit.getPatientid()).getBenefitplan()%> </td> </tr>  </table> ">
                                        <a href="vital.jsp?patientid=<%=visit.getPatientid()%>&id=<%=visit.getVisitid()%>"><%= visit.getPatientid()%> </a> 
                                    </td>
                                    <td>
                                        <%=mgr.getPatientByID(visit.getPatientid()).getFname()%> <%=mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()).getLname()%>
                                    </td>
                                    <td>
                                        <%=mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%> 
                                    </td>
                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofbirth())%>
                                    </td>

                                    <td>
                                        <%= formatter.format(mgr.getPatientByID(visit.getPatientid()).getDateofregistration())%>
                                    </td>

                                    <td>
                                        <a id="<%=visit.getPatientid()%><%=visit.getVisitid()%>link"  class="visitlink btn btn-info btn-small"> <i class="icon-pencil icon-white"> </i> Make Payments </a>
                                    </td>
                                </tr>
                                <% }

                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->
        <%@include file="widgets/javascripts.jsp" %>

        <%   for (int i = 0; i < visits.size(); i++) {
                visit = (PatientBills) visits.get(i);%>
        <script type="text/javascript">
            $(document).ready(function(){
                                                      
               
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog({
                    autoOpen : false,
                    width : 950,
                    modal :true,
                    position : "top"
		
                });
                
                $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>link').click(function(){
                   
                    $('#<%=visit.getPatientid()%><%=visit.getVisitid()%>').dialog('open');
                    return false;
                });
                
                                                        
                
            });
            
        </script>

        <div style="max-height: 600px;  display: none;" class="visit hide" id="<%=visit.getPatientid()%><%=visit.getVisitid()%>"  title="Outstanding Bill For <%= mgr.getPatientByID(visit.getPatientid()).getFname()%> <%= mgr.getPatientByID(visit.getPatientid()).getLname()%> | <span style='text-transform: uppercase;'> <%= mgr.getPatientByID(visit.getPatientid()).getPatientid()%> </span>">


            <div class=" thumbnail">
                <span class="span5">
                    <dl class="dl-horizontal">
                        <dt style="text-align: left;" >Laboratory Number:</dt>
                        <dd style="text-transform: uppercase;"><b><%=visit.getVisitid()%> </b></dd>
                        <dt style="text-align: left;" >Patient Name:</dt>
                        <dd>
                            <b> <%= mgr.getPatientByID(visit.getPatientid()).getFname()%>
                                <%= mgr.getPatientByID(visit.getPatientid()).getMidname()%>
                                <%= mgr.getPatientByID(visit.getPatientid()).getLname()%> </b>
                        </dd>
                        <dt style="text-align: left;" >Payment Type:</dt>
                        <dd style="text-transform: capitalize;">
                            <% if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("Cash")) {%>
                            Out of Pocket
                            <% } else if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("NHIS")) {%>
                            National Health Insurance
                            <% } else if (mgr.sponsorshipDetails(visit.getPatientid()).getType().equalsIgnoreCase("Private")) {%>
                            <%= mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>
                            <% } else {%>
                            Corporate (<%= mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(visit.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(visit.getPatientid()).getSponsorid()).getSponsorname()%>)
                            <% }%>
                        </dd>
                    </dl>
                </span>
                <div class="clearfix">

                </div>
                <form action="action/accountsaction.jsp" method="post" class="form-horizontal">
                    <table class="table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="color: white; text-align: left; font-size: 14px;" >
                                    Description of Service
                                </th>

                                <th style="color: white; text-align: right; font-size: 14px;">
                                    <span style="text-align: right; float: right; padding-right: 50px;">
                                        Price GH&#162;
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td>
                                    <b>Total Bill </b>
                                </td>
                                <td style="text-align: right">
                                    <%=df.format(visit.getTotalBill())%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Amount Deposited

                                </td>
                                <td style="text-align: right">
                                    <%=df.format(visit.getAmountPaid())%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Outstanding Bill
                                </td>
                                <td style="text-align: right">
                                    <%=df.format(visit.getTotalBill() - visit.getAmountPaid())%>
                                    <input  class="amountdueinput<%=visit.getPatientid()%>" type="hidden" value="<%=df.format(visit.getTotalBill() - visit.getAmountPaid())%>"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Amount Paid
                                </td>
                                <td style="text-align: right;">
                                    <input  type="text" style="text-align: right; color: blue;"  name="extra_amount"  class="pull-right input-mini amountpaidinput<%=visit.getPatientid()%>" id="extra_amount<%=visit.getVisitid()%>"/>
                                    <input type="hidden" name="" id="extra_<%=visit.getVisitid()%>"  value="<%=visit.getTotalBill() - visit.getAmountPaid()%>"/>

                                    <input type="hidden" name="visitid" id="<%=visit.getVisitid()%>" value="<%=visit.getVisitid()%>"/>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Balance
                                </td>
                                <td  class="balancetext<%=visit.getPatientid()%>" style="text-align: right;  font-weight: bold;">

                                </td>
                            </tr>

                        </tbody>
                    </table>
                    <div class="form-actions">
                        <button type="submit" name="action" value="Outstanding Bills" class="btn btn-danger btn-small pull-right" id="id_<%=visit.getVisitid()%>">
                            <i class="icon-white icon-arrow-right"> </i> Forward
                        </button>
                    </div>
                </form>
            </div>


            <% }%>
            <div class="clear">

            </div>
    </body>


    <%
        for (int i = 0; i < visits.size(); i++) {
            visit = (PatientBills) visits.get(i);%>

    %>
    <script type="text/javascript">
        $(document).ready(function(){
           
            $(function(){
                var amountdue = parseFloat($(".amountdueinput<%=visit.getPatientid()%>").attr("value")).toFixed(2);
        
                $(".amountduetext<%=visit.getPatientid()%>").html(amountdue);
                var checkedValue = 0;
                $(".balanceinput<%=visit.getPatientid()%>").attr("value",parseFloat(0).toFixed(2));
                $(".balancetext<%=visit.getPatientid()%>").html("0.00");
        
                $(".amountpaidinput<%=visit.getPatientid()%>").attr("value",parseFloat(0).toFixed(2))
                $(".amountpaidtext<%=visit.getPatientid()%>").html($(".amountpaidinput<%=visit.getPatientid()%>").attr("value"))
        
                $(".amountpaidinput<%=visit.getPatientid()%>").live('keyup',function(){
                    
                    var amountdue = $(".amountdueinput<%=visit.getPatientid()%>").attr("value");
                   
                    var amountpaid = $(".amountpaidinput<%=visit.getPatientid()%>").attr("value");
                    $(".amountpaidtext<%=visit.getPatientid()%>").html($(".amountpaidinput<%=visit.getPatientid()%>").attr("value"))
                    
                    if(amountpaid == ""){
                        amountpaid = 0;
                    }
                    var balance = parseFloat(amountpaid).toFixed(2) - parseFloat(amountdue).toFixed(2);
                    if(amountpaid > 0 &&balance < 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("Part Payment").addClass('text-error').removeClass('text-success') 
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                        $('.balancetext<%=visit.getPatientid()%>').addClass('text-error').removeClass('text-success')
                        $('.balancetextcolour<%=visit.getPatientid()%>').addClass('text-error').removeClass('text-success')            
                    } else if (amountpaid == 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("").removeClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').removeClass('success').removeClass('error')
                        $('.balancetext<%=visit.getPatientid()%>').removeClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=visit.getPatientid()%>').removeClass('text-success').removeClass('text-error')             
                    }         
                    else if(amountpaid > 0 && balance >= 0){
                        $(".paymentstatus<%=visit.getPatientid()%>").html("Full Payment").addClass('text-success').removeClass('text-error')
                        $('.balanceinput<%=visit.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                        $('.balancetext<%=visit.getPatientid()%>').addClass('text-success').removeClass('text-error')
                        $('.balancetextcolour<%=visit.getPatientid()%>').addClass('text-success').removeClass('text-error')
                    }     
                    $(".balanceinput<%=visit.getPatientid()%>").attr("value",parseFloat(balance).toFixed(2));
                    $(".balancetext<%=visit.getPatientid()%>").html(parseFloat(balance).toFixed(2));
                    $(".amountduetext<%=visit.getPatientid()%>").attr("value",$(".amountdue<%=visit.getPatientid()%>").attr("value"));         
                });
      
                
            })
            
        });
    /*    $("#extra_<%=visit.getVisitid()%>").live(function(){
            var amount = $("#extra_<%=visit.getVisitid()%>").attr("values")
            var extra_amount = $("#extra_amount<%=visit.getVisitid()%>").attr("values")
            alert(amount)
        });
      */  
        
    </script>



    <% }%>
</html>