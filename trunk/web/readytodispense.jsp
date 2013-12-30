<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

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
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    Date date = new Date();
    // List visits = mgr.listUnitVisitations("pharmacy", dateFormat.format(date));
    List visits = mgr.listPharmordersByStatus("Settled");
    List treatments = null;

    DecimalFormat df = new DecimalFormat();

    df.setMinimumFractionDigits(2);
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
    </head>
    <script type="text/javascript">
        function alert(){
            
        }
    </script>
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
                        <li class="active">
                            <a href="#">Drug Dispensing</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

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

                    <div style="display: none" class="span8 main-c thumbnail">

                        <table class="example display table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;"> Folder Number</th>
                                    <th style="text-align: left;"> Patient Name </th>
                                    <th style="text-align: left;"> Payment Type </th>
                                    <th style="text-align: left;"> Date of Birth  </th>
                                    <th style="text-align: left;"> Request Date </th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (visits != null) {
                                        for (int i = 0; i < visits.size(); i++) {
                                            Pharmorder vst = (Pharmorder) visits.get(i);
                                %>
                                <tr>
                                    <td>
                                        <div class="dialog" id="<%=vst.getPatientid()%>_dialog" title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%;'> DRUG DISPENSING | <%= vst.getPatientid()%> </span>">


                                            <div class="lead center ">
                                                DISPENSE DRUGS
                                            </div>
                                            <form action="action/forwardaction.jsp" method="post">
                                                <table class="table">
                                                    <thead>
                                                        <tr style="color: #FFF;">
                                                            <th style="color: #fff;  font-size: 14px; text-align: left;"> Drug </th>

                                                            <th style="color: #FFF; font-size: 14px; text-align: left;"> Dosage </th>
                                                            <th style="color: #FFF; font-size: 14px; text-align: center;"> Quantity</th>                                                                
                                                            <!--   <th style="color: #FFF; font-size: 14px; text-align: right;"> Unit Cost </th>
                                                               <th style="color: #FFF;  font-size: 14px;text-align: right;"> Total </th>  -->

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%%>

                                                        <%

                                                            List ptreatmentss = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
                                                            for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                Patienttreatment ptPatienttreatments = (Patienttreatment) ptreatmentss.get(r);
                                                                if (ptPatienttreatments.getDispensed().equalsIgnoreCase("Paid")) {
                                                        %>
                                                        <tr>
                                                            <td><%=mgr.getTreatment(ptPatienttreatments.getTreatmentid()).getTreatment()%> </td>

                                                            <td><%=ptPatienttreatments.getDosage().split("_")[1]%>  </td>

                                                            <td style="text-align: right; padding-right: 3%;"> <%=ptPatienttreatments.getQuantity()%> </td>

                                                             <!--   <td style="text-align: right;"><%= df.format(ptPatienttreatments.getPrice())%> </td>
                                                                <td style="text-align: right;"><%= df.format((ptPatienttreatments.getQuantity() * ptPatienttreatments.getPrice()))%></td>  -->
                                                    <input type="hidden" name="dispensed[]" value="<%= ptPatienttreatments.getTreatmentid()%>"  />


                                                    </tr>

                                                    <% }
                                                        }
                                                    %> 


                                                    </tbody>

                                                </table>

                                                <div style="text-align: center;" class="form-actions">


                                                    <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                    <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                    <input type="hidden" name="orderid" value="<%=vst.getOrderid()%>"/>
                                                    <%
                                                        String unitid = "";
                                                        if (mgr.getVisitById(vst.getVisitid()).getPreviouslocstion().equalsIgnoreCase("consultation")) {
                                                            unitid = "account";
                                                        } else {
                                                            unitid = "records";
                                                        }
                                                    %>

                                                    <br/>
                                                    <input type="hidden" name="from" value="Pharmacy"/>
                                                    <input type="hidden" name="unitid" value="<%=unitid%>"/>
                                                    <button style="width: 90%" class="btn btn-danger" name="action" value="dispensedrugs">
                                                        <i class="icon-white icon-check"></i> Dispense Drugs
                                                    </button>
                                                </div>
                                            </form>

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
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                    <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%>. <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>

                                    <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  </td>
                                    <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                    <td><%= formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                    <td><%=formatter.format(vst.getOrderdate())%> </td>

                                    <td>
                                        <button class="btn btn-info btn-small" id="<%=vst.getPatientid()%>_link">
                                            <i class="icon-white icon-check"></i> Dispense
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
        
        
        $(".patient").popover({

            placement : 'right',
            animation : true

        });
    
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "sScrollY" : "300px",
            "aaSorting" : [],
            "bSort" : true

        });

    });

</script>
<% for (int i = 0;
            i < visits.size();
            i++) {
        Pharmorder vst = (Pharmorder) visits.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getPatientid()%>_dialog").dialog({
        autoOpen : true,
        width : "90%",
        modal :true,
        position : "top"

    });
    
    
   
    
    $("#<%= vst.getPatientid()%>_link").click(function(){
      
        $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
    })
   
    
   
    
</script>



<% }%>

</body>
</html>
