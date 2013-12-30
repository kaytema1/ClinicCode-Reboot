<%-- 
    Document   : accounts
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : ClaimSync
--%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> list = (ArrayList<Integer>) session.getAttribute("staffPermission");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();

            
            List dispensingbills = mgr.listUnPaidPatientBillByBillTypenStatus("Dispensing Bill", "Not Paid");
            List procedurebills = mgr.listUnPaidPatientBillByBillTypenStatus("Procedure Bill", "Not Paid");
          

            Set<String> combinedList = new HashSet<String>();


            

            for (int i = 0; i < dispensingbills.size(); i++) {
                PatientBills bill = (PatientBills) dispensingbills.get(i);
                String vstString = bill.getPatientid();
                combinedList.add(vstString);

            }

            for (int i = 0; i < procedurebills.size(); i++) {
                PatientBills bill = (PatientBills) procedurebills.get(i);
                String vstString = bill.getPatientid();
                combinedList.add(vstString);

            }
            

        %>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">
                     <li>
                        <a href="#">Billing</a><span class="divider"></span>
                    </li>
                    <li class="active">
                        <a href="#">Outstanding Clinic Bills</a><span class="divider"></span>
                    </li>
                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%>  center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>
            <br/>
            <div class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>

            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span8 thumbnail main-c">
                    <table style="width: 100%" class="example display table-striped ">
                        <thead>
                            <tr>
                                <th style="font-size: 12px;"> Folder Number</th>
                                <th style="font-size: 12px;"> Patient Name </th>
                                <th style="font-size: 12px;"> Payment Type </th>
                                <th style="font-size: 12px;"> Date of Birth  </th>
                                <th style="font-size: 12px;"> Requested On </th>
                                <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%    for (String patientid : combinedList) {%>

                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(patientid).getFname()%> <%=mgr.getPatientByID(patientid).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(patientid).getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(patientid).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(patientid).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()) == null ? mgr.sponsorshipDetails(patientid).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(patientid).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(patientid).getBenefitplan()%> </td> </tr>  </table> "> <%=patientid%>   </td>
                                <td><%=mgr.getPatientByID(patientid).getFname()%> <%=mgr.getPatientByID(patientid).getMidname()%> <%=mgr.getPatientByID(patientid).getLname()%></td>
                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()) == null ? mgr.sponsorshipDetails(patientid).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()).getSponsorname()%> </td>

                                <td><%=formatter.format(mgr.getPatientByID(patientid).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(patientid).getMembershipid()%>   </td>  -->

                                <td><%=formatter.format(new Date())%> </td>

                                <td>
                                    <a href="processbill.jsp?patientid=<%= patientid%>" class="btn btn-info btn-small" style="color: #fff;">
                                        Process Payment
                                    </a>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>

                    </table>
                </div>
            </div>
        </section>

        <%  for (String patientid : combinedList) {%> 
        <div class="dialog" style="display: none; " id="<%=patientid%>_dialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%; text-transform: uppercase;'> CURRENT BILL FOR | <%= mgr.getPatientByID(patientid).getFname()%> <%= mgr.getPatientByID(patientid).getLname()%>  |  <%= mgr.getPatientByID(patientid).getPatientid()%> </span>">
            <span class="span4">
                <dl class="dl-horizontal">


                    <dt style="text-align: left;" >Patient ID:</dt>
                    <dd style="text-transform: uppercase;"><%= patientid%></dd>
                    <dt style="text-align: left;" >Patient Name:</dt>
                    <dd><%= mgr.getPatientByID(patientid).getFname()%>
                        <%= mgr.getPatientByID(patientid).getMidname()%>
                        <%= mgr.getPatientByID(patientid).getLname()%>
                    </dd>
                    <dt style="text-align: left;" >Sponsor:</dt>
                    <dd><%=mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()) == null ? mgr.sponsorshipDetails(patientid).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientid).getSponsorid()).getSponsorname()%></dd>
                </dl>
            </span>
            <div class="clearfix">
            </div>    
            <div class="center">
                <span style="font-weight: bolder;" class="lead">CURRENT BILL SUMMARY</span>
                <br />
                <br />
                <%
                    
                    List patientdispensingbills = mgr.listPharmordersByStatusByPatient("Approved", patientid);
                    List patientprocedurebills = mgr.listPatientProceduresByStatusandPatient("Cashier", patientid);

                %>

                  
                <div class="clearfix"></div>
                <% if (patientdispensingbills.size() > 0) {

                        Pharmorder vst = (Pharmorder) patientdispensingbills.get(0);
                %>
                <div class="thumbnail">
                    <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                        <li><b> DISPENSING</b> </li>
                    </ul>
                </div>
                <% }%> 
                <div class="clearfix"></div>

                <% if (patientprocedurebills.size() > 0) {

                        Procedureorders vst = (Procedureorders) patientprocedurebills.get(0);
                %>
                <div class="thumbnail">
                    <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                        <li><b> PROCEDURES</b> </li>
                    </ul>
                    <table class="table">
                        <thead>
                            <tr style="color: #fff;">
                                <th style="color: #fff; text-align: left; font-size: 14px;"> PROCEDURE </th>
                                <th style="color: #fff; text-align: right; font-size: 14px;" > PRICE </th>

                            </tr>
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

                            </tr>

                            <% }%>

                        </tbody>

                    </table>
                </div>
                <% }%> 
                <div class="clearfix"></div>



            </div>

        </div>
        <% }%>
    </body>
    <%@page import="entities.Vitalcheck"%>
<%@page import="java.util.List"%>
<%@page import="entities.ExtendedHMSHelper"%>
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
<script src="js/jquery.validate.min.js"></script>
<script src="js/jquery.select-to-autocomplete.js"></script>
<script src="js/jquery.select-to-autocomplete.min.js"></script>

<script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>

<script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>
<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>

<script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

<script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
<script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

<!-- <script type="text/javascript" src="js/tablecloth.js"></script>   --->
<script type="text/javascript" src="js/demo.js"></script>    
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/jquery.numeric.js"></script>
<script type="text/javascript" src="js/jquery.filter_input.js"></script>
<script type="text/javascript" src="js/chosen.jquery.js"></script>
<script type="text/javascript" src="js/jquery.ui.combify.js"></script>
<!--initiate accordion-->


<script type="text/javascript">
    
    
     
    
    
    $(function() {
       
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

       // menu_ul.hide();
             
        $(".numeric").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
        $('.decimal').live("keyup",function(){inputControl($(this),'float');});
        $('.text_input').filter_input({regex:'[a-zA-Z]'});
        $(".menu").fadeIn();
        $(".content").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
        $(".main-c").fadeIn();
        $(".main").fadeIn();
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
         
       


    });

   
    $(document).ready(function() {
    
        $('.select').selectToAutocomplete();
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sScrollY": "400px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true
            

        });
        
        $(':input').attr('autocomplete', 'off');
        
        // var forms = $("form");
        //forms.each(function(i) {
        //    i.attr('autocomplete', 'off');
        //});
            
        
        var currentValue = "";
        $("#addSup").click(function(){
            currentValue = $("#nonexistantsource").attr("value");
            if(currentValue != ""){ 
            
                $("#nonexistant").val($("#nonexistant").val() + currentValue + ', ');
                $("#tbody").append("<tr> <td>"+currentValue+"</td><td> </td></tr>")
           
                currentValue = $("#nonexistantsource").attr("value","");
            }
            
        });

        
        $('.close_dialog').click(function() {

            $('#dialog').dialog('close');

        });
        
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
            $('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('span3 hide');
            $('.main-c').toggleClass('span8');
                
        });

        $(".patient").popover({

            placement : 'right',
            animation : true

        });

        $(".patient_visit").popover({

            placement : 'top',
            animation : true

        });

        $(".btn").tooltip({

            placement : 'bottom',
            animation : true

        });

        $(".update_sponsor").click(function() {
            $(".sponsor_panel").slideToggle();
            $(".vitals_panel").slideUp();
            $(".history_panel").slideUp();
        });

        $(".update_vitals").click(function() {
            $(".sponsor_panel").slideUp();
            $(".vitals_panel").slideToggle();
            $(".history_panel").slideUp();
        });

        $(".update_history").click(function() {
            $(".sponsor_panel").slideUp();
            $(".vitals_panel").slideUp();
            $(".history_panel").slideToggle();
        });
        
        $(".slideup").click(function() {
            $(".sponsor_panel").slideUp();
            $(".vitals_panel").slideUp();
            $(".history_panel").slideUp();      
        })
            
        $("#sponsor").change(function(){
                
                
            if ($('#sponsor').attr('value')!="Select"){
                $('#sponsor').closest('.control-group').addClass('success').removeClass('error')
            }else{
                $('#sponsor').closest('.control-group').addClass('error').removeClass('success')
            }
           
        });
            
            
        $(".dob").change(function(){
                
                
            if (($('#day').attr('value')!="D") && ($('#month').attr('value')!="M") && ($('#year').attr('value')!="Y")){
                $('#year').closest('.control-group').addClass('success').removeClass('error')
            }else{
                $('#year').closest('.control-group').addClass('error').removeClass('success')
            }
           
        });
                
                
        $(".updatebilling").click(function(){
            $(".updatebillingdiv").slideToggle("slow");
        })
        
        
     
    });
    
       	
           
</script>


    <script type="text/javascript">
        
        $(document).ready(function(){
            
            
           menu_ul.show();
        <%  for (String patientid : combinedList) {%> 
                $("#<%= patientid%>_dialog").dialog({
                    autoOpen : false,
                    width : "90%",
                    modal :true,
                    position: "top"

                });
        
             
                
                $("#<%= patientid%>_patientidlink").click(function(){
                    
                    $("#<%=patientid%>_dialog").dialog('open');
    
                })
            
        <% }%>
            
            })
        
        
    </script>

</html>
