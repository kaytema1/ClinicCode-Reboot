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
        <%@include file="widgets/stylesheets.jsp" %>

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            //Patient p = (Patient)session.getAttribute("patient");
            //get current date time with Date()
            Date date = new Date();
            //System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            // for (int i = 0; i < visits.size(); i++) {
            //   Visitationtable visit = (Visitationtable) visits.get(i);
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
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">

                            <table class="example display table">
                                <thead>
                                    <tr>
                                        <th> Patient # </th>
                                        <th> Patient Name </th>
                                        <th> Date of Birth  </th>
                                        <th> Sponsor </th>
                                        <th> Membership ID </th>
                                        <th> Request Date </th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (visits != null) {
                                            String labtest = "";
                                            Double rate = 0.0;
                                            for (int i = 0; i < visits.size(); i++) {
                                                Visitationtable vst = (Visitationtable) visits.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <div class="dialog" id="<%=vst.getVisitid()%>_dialog" title=" Results">

                                                <div class="well thumbnail">

                                                    <form action="action/forwardaction.jsp" method="post">
                                                        <table class="table table-bordered table-condensed example display">
                                                            <thead>
                                                                <tr style="color: #000;">
                                                                    <th> Test </th>
                                                                    <th> Result </th>
                                                                    <th> Price</th>
                                                                    <th> Can Afford</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>

                                                                <%if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equals("NHIS")) {%>
                                                                <%List ptreatmentss = mgr.patientInvestigation(vst.getVisitid());
                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                        Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                                                                        List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                                                        Laborders laborder = (Laborders) laborders.get(0);
                                                                        labtest = mgr.getNhisInvestigation(ptPatienttreatments.getInvestigationid()).getName();
                                                                        rate = ptPatienttreatments.getPrice();
                                                                %>
                                                                <tr>
                                                                    <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> </h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></td> </tr> <tr>
                                                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><%=mgr.getNhisInvestigation(ptPatienttreatments.getInvestigationid()).getName()%> </td>
                                                                    <%if (ptPatienttreatments.getPerformed().equalsIgnoreCase("paid")) {%>
                                                                    <td> Result: <input type="text" name="results<%=ptPatienttreatments.getId()%>" value=""/><br/>
                                                                        Units : <input type="text" name="concentration<%=ptPatienttreatments.getId()%>" value=""/><br/>
                                                                        Range : <input type="text" name="range<%=ptPatienttreatments.getId()%>" value=""/>
                                                                        <input type="hidden" name="ids[]" value="<%=ptPatienttreatments.getId()%>"/>
                                                                    </td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td>Paid</td>
                                                                    <% }
                                                                        if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Afford")) {%>

                                                                    <td>Unpaid</td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td>Pending Payment</td>

                                                                    <%}
                                                                        if (ptPatienttreatments.getPerformed().equals("No")) {%>
                                                                    <td>Unpaid</td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td><input type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"/></td>
                                                                        <%}
                                                                            if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Yes")) {%>
                                                                    <td><%=ptPatienttreatments.getResult()%></td>
                                                                    <td><%=ptPatienttreatments.getPrice()%></td>
                                                                    <td>Paid</td>

                                                                    <%}%> 
                                                                   <!-- <td><%=ptPatienttreatments.getPrice()%></td>-->
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="labid" value="<%=laborder.getOrderid()%>"/>

                                                            </tr>

                                                            <div id="print" style="display: none">
                                                                Laboratory Request Form<br/>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>,  <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%><br/>
                                                                <%=mgr.getStafftableByid(vst.getDoctor()).getLastname()%>, <%= mgr.getStafftableByid(vst.getDoctor()).getOthername()%><br/>
                                                                <%= "" + new Date()%>
                                                                <table>


                                                                    <%}
                                                                        for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                            Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                                                                            List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                                                            Laborders laborder = (Laborders) laborders.get(0);
                                                                            labtest = mgr.getNhisInvestigation(ptPatienttreatments.getInvestigationid()).getName();
                                                                            rate = ptPatienttreatments.getPrice();%>

                                                                    <tr>
                                                                        <td><%= labtest%><td>
                                                                        <td><%= rate%><td>
                                                                    </tr>
                                                                    <%  }%>
                                                                </table>
                                                            </div>

                                                            <%} else {%>
                                                            <%List ptreatmentss = mgr.patientInvestigation(vst.getVisitid());
                                                                for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                    Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                                                                    List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                                                    Laborders laborder = (Laborders) laborders.get(0);
                                                                    labtest = mgr.getInvestigation(ptPatienttreatments.getInvestigationid()).getName();
                                                                    rate = ptPatienttreatments.getPrice();
                                                            %>
                                                            <tr>
                                                                <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> </h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></td> </tr> <tr>
                                                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><%=mgr.getInvestigation(ptPatienttreatments.getInvestigationid()).getName()%> </td>
                                                                <%if (ptPatienttreatments.getPerformed().equalsIgnoreCase("paid")) {%>
                                                                <td> Result: <input type="text" name="results<%=ptPatienttreatments.getId()%>" value=""/><br/>
                                                                    Units : <input type="text" name="concentration<%=ptPatienttreatments.getId()%>" value=""/><br/>
                                                                    Range : <input type="text" name="range<%=ptPatienttreatments.getId()%>" value=""/>
                                                                    <input type="hidden" name="ids[]" value="<%=ptPatienttreatments.getId()%>"/>
                                                                </td>
                                                                <td><%=ptPatienttreatments.getPrice()%></td>
                                                                <td>Paid</td>
                                                                <% }
                                                                    if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Afford")) {%>

                                                                <td>Unpaid</td>
                                                                <td><%=ptPatienttreatments.getPrice()%></td>
                                                                <td>Pending Payment</td>

                                                                <%}
                                                                    if (ptPatienttreatments.getPerformed().equals("No")) {%>
                                                                <td>Unpaid</td>
                                                                <td><%=ptPatienttreatments.getPrice()%></td>
                                                                <td><input type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"/></td>
                                                                    <%}
                                                                        if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Yes")) {%>
                                                                <td><%=ptPatienttreatments.getResult()%></td>
                                                                <td><%=ptPatienttreatments.getPrice()%></td>
                                                                <td>Paid</td>

                                                                <%}%> 
                                                               <!-- <td><%=ptPatienttreatments.getPrice()%></td>-->
                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="labid" value="<%=laborder.getOrderid()%>"/>
                                                        </tr>

                                                    <%}%>
                                                    <tr><td>
                                                    <div id="print" style="display: none">
                                                                Laboratory Request Form<br/>
                                                                <%=mgr.getPatientByID(vst.getPatientid()).getFname()%>,  <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%><br/>
                                                                <%=mgr.getStafftableByid(vst.getDoctor()).getLastname()%>, <%= mgr.getStafftableByid(vst.getDoctor()).getOthername()%><br/>
                                                                <%= "" + new Date()%>
                                                                <table>


                                                                    <%
                                                                        for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                            Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);
                                                                           // List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                                                           // Laborders laborder = (Laborders) laborders.get(0);
                                                                            labtest = mgr.getInvestigation(ptPatienttreatments.getInvestigationid()).getName();
                                                                           rate = ptPatienttreatments.getPrice();%>

                                                                    <tr>
                                                                        <td><%= labtest%><td>
                                                                        <td><%= rate%><td>
                                                                    </tr>
                                                                    <%  }%>
                                                                </table>
                                                            </div>
                                                        </td></tr>
                                                        <%}%>
                                                        
                                                    <!-- </form>

                                                   end-->
                                                    <tr>
                                                        <td>

                                                            <select name="unitid">
                                                                <%
                                                                    List consultingrooms = mgr.listConRooms();
                                                                    List units = mgr.listUnits();
                                                                    String previous = vst.getPreviouslocstion();
                                                                    String[] strs = previous.split("_");
                                                                    for (int j = 0; j < units.size(); j++) {
                                                                        Units unit = (Units) units.get(j);

                                                                        if (strs[0].equalsIgnoreCase("account")) {
                                                                            if (unit.getType().equalsIgnoreCase("records")) {
                                                                %>
                                                                <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option> 
                                                                <% }
                                                                    }
                                                                    if (strs[0].equalsIgnoreCase("consultation")) {
                                                                        if (unit.getType().equalsIgnoreCase("account")) {
                                                                %>
                                                                <option value="<%=unit.getType()%>_<%=unit.getUnitid()%>"><%=unit.getUnitname()%></option> 
                                                                <% }
                                                                        }
                                                                    }
                                                                %>
                                                            </select>


                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <button class="btn btn-info" name="laboratory" value="Forward" id="">
                                                                <i class="icon-white icon-check"></i> Forward 
                                                            </button>
                                                        </td>
                                                        <td>
                                                            <a href="" onclick="printSelection(document.getElementById('print'));return false">Print Laboratory Request</a>
                                                        </td>
                                                    </tr>      
                                                    </tbody>

                                                </table>
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
                                <td>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-transform: uppercase; color: #70A5CB; font-weight: bolder;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>
                                <td><%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%> </td>

                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%>  </td>
                                <td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>

                                <td><%=vst.getDate()%> </td>

                                <td>
                                    <button class="btn btn-info btn-small" id="<%=vst.getVisitid()%>_link">
                                        <i class="icon icon-white icon-edit"></i> Update 
                                    </button>
                                </td>
                            </tr>
                            <%}
                                }%> 

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
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();

        $(".menu").fadeIn();
        $(".content1").fadeIn();
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

</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
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

    });
    
    function printSelection(node){

        var content=node.innerHTML
        var pwin=window.open('','print_content','width=400,height=600');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }

</script>
<% for (int i = 0;
            i < visits.size();
            i++) {
        Visitationtable vst = (Visitationtable) visits.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getVisitid()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
    $("#<%= vst.getVisitid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
   
    
    $("#<%= vst.getVisitid()%>_link").click(function(){
      
        $("#<%=vst.getVisitid()%>_dialog").dialog('open');
    
    })
   
    $("#<%= vst.getPatientid()%>_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
   
    
    $("#<%= vst.getVisitid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getVisitid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>




<% }%>

</body>
</html>
