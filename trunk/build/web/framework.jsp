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
            List listorders = mgr.listLabordersByStatus(Boolean.FALSE);
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
                    <%@include file="widgets/leftsidebar.jsp" %>
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
                                    <% if (listorders != null) {
                                            for (int i = 0; i < listorders.size(); i++) {
                                                Laborders vst = (Laborders) listorders.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <div class="dialog" id="<%=vst.getOrderid()%>_dialog" title="Enter Results">

                                                <div class="well thumbnail">

                                                    <form action="action/labaction.jsp" method="post">
                                                        <table class="table">
                                                            <thead>
                                                                <tr >
                                                                    <th style="color: #FFF;"> Test </th>
                                                                    <th style="color: #FFF;"> Result </th>
                                                                    <th style="color: #FFF;"> Comments </th>
                                                                    <th style="color: #FFF;"> Confirmed </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%
                                                                    List ptreatmentss = mgr.patientInvestigationByOrderId(vst.getOrderid());
                                                                    String invName = "", mainInvName = "";
                                                                    int invType = 0, groupedUnderId = 0, invId, posInvResultId;

                                                                    Investigation inv = null, mainInv = null;
                                                                    DetailedinvPosinvresults detInvPosRes = null;
                                                                    PossibleinvResults posInvRes = null;
                                                                    boolean hasResultOptions = false, foundSubTests = false, subTestHasResultOptions = false;
                                                                    List detailedInvPosResults, mainInvSubInvs;
                                                                    for (int r = 0; r < ptreatmentss.size(); r++) {
                                                                        Patientinvestigation ptPatienttreatments = (Patientinvestigation) ptreatmentss.get(r);

                                                                        //    System.out.println("ppt +++++ " + ptPatienttreatments.getInvestigationid());
                                                                        List laborders = mgr.listLabordersByVisitid(vst.getVisitid());
                                                                        Laborders laborder = (Laborders) laborders.get(0);

                                                                        inv = mgr.getInvestigation(ptPatienttreatments.getInvestigationid());
                                                                        invId = inv.getDetailedInvId();

                                                                        invName = inv.getName();
                                                                        invType = inv.getTypeOfTestId();

                                                                        hasResultOptions = false;
                                                                        foundSubTests = false;

                                                                %>
                                                                <tr>
                                                                    <%     if (invType == 1) { // main test    

                                                                            // check if there are subtests under it
                                                                            mainInvSubInvs = mgr.listSubInvUnderMainInv(invId);

                                                                            if (mainInvSubInvs.isEmpty()) {  // no subtests found under it  
                                                                                foundSubTests = false;
                                                                    %>
                                                                    <td><%=invName%></td>
                                                                    <td>

                                                                        <%
                                                                            // find if it has results associated
                                                                            hasResultOptions = inv.isResultOptions();

                                                                            if (hasResultOptions) {  //go ahead and populate a dropdown of those

                                                                                // first, get the result options
                                                                                detailedInvPosResults = mgr.listDetailedInvPosResults(invId);

                                                                                if (!detailedInvPosResults.isEmpty()) {%>

                                                                        <div class="controls">
                                                                            <select class="MustSelectOpt" name="results<%=ptPatienttreatments.getId()%>" >

                                                                                <option>Select</option>


                                                                                <%            for (int q = 0; q < detailedInvPosResults.size(); q++) {
                                                                                        //     System.out.println("qqqq : " + detailedInvPosResults.get(q));
                                                                                        detInvPosRes = (DetailedinvPosinvresults) detailedInvPosResults.get(q);
                                                                                        posInvResultId = detInvPosRes.getPosinvresultId();
                                                                                        posInvRes = mgr.getPossibleInvResultById(posInvResultId);
                                                                                %>

                                                                                <option><%=posInvRes.getPosinvResult()%></option>

                                                                                <%                       }%>
                                                                            </select>
                                                                        </div>
                                                                        <%         } else {%>
                                                                        <input type="text" name="results<%=ptPatienttreatments.getId()%>" />                  
                                                                        <%           }
                                                                        } else {%>
                                                                        <input type="text" name="results<%=ptPatienttreatments.getId()%>" />                 
                                                                        <%         }%>

                                                                    </td>
                                                                    <% } else {  // subtests exist under it. 
                                                                        foundSubTests = true;
                                                                    %>

                                                                    <td colspan="2"><%=invName%></td>

                                                                    <% }%>

                                                                    <%

                                                                        if (foundSubTests) {

                                                                            for (int j = 0; j < mainInvSubInvs.size(); j++) {
                                                                                //     subTestHasResultOptions = false;
                                                                                inv = (Investigation) mainInvSubInvs.get(j);

                                                                                invId = inv.getDetailedInvId();
                                                                                invName = inv.getName();
                                                                                //     subTestHasResultOptions = inv.isResultOptions();

                                                                    %>
                                                                
                                                            <table>
                                                                <tr>
                                                                    <td><%=invName%></td>
                                                                    <td>

                                                                        <%
                                                                            // find if it has results associated
                                                                            hasResultOptions = inv.isResultOptions();

                                                                            if (hasResultOptions) {  //go ahead and populate a dropdown of those

                                                                                // first, get the result options
                                                                                detailedInvPosResults = mgr.listDetailedInvPosResults(invId);

                                                                                if (!detailedInvPosResults.isEmpty()) {%>

                                                                        <div class="controls">
                                                                            <select class="MustSelectOpt" name="results<%=ptPatienttreatments.getId()%>" >

                                                                                <option>Select</option>


                                                                                <%            for (int q = 0; q < detailedInvPosResults.size(); q++) {
                                                                                        //     System.out.println("qqqq : " + detailedInvPosResults.get(q));
                                                                                        detInvPosRes = (DetailedinvPosinvresults) detailedInvPosResults.get(q);
                                                                                        posInvResultId = detInvPosRes.getPosinvresultId();
                                                                                        posInvRes = mgr.getPossibleInvResultById(posInvResultId);
                                                                                %>

                                                                                <option><%=posInvRes.getPosinvResult()%></option>

                                                                                <%                       }%>
                                                                            </select>
                                                                        </div>
                                                                        <%         } else {%>
                                                                        <input type="text" name="results<%=ptPatienttreatments.getId()%>" />                  
                                                                        <%           }
                                                                        } else {%>
                                                                        <input type="text" name="results<%=ptPatienttreatments.getId()%>" />                 
                                                                        <%         }%>

                                                                    </td>

                                                                    <%             }%>
                                                                </tr>
                                                            </table>

                                                                <%       }
                                                                %>

                                                                <%        }%>


                                                                <%

                                                                    if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Afford")) {%>

                                                            <td>Unpaid</td>

                                                            <td>Pending Payment</td>

                                                            <%}
                                                                if (ptPatienttreatments.getPerformed().equals("Pending")) {%>
                                                            <td><input type="text" name="comment<%=ptPatienttreatments.getId()%>"/></td>

                                                            <td><input type="checkbox" name="afford[]" value="<%=ptPatienttreatments.getId()%>"/></td>
                                                                <%}
                                                                    if (ptPatienttreatments.getPerformed().equalsIgnoreCase("Performed")) {%>
                                                            <td><%=ptPatienttreatments.getResult()%></td>

                                                            <td>Paid</td>

                                                            <%}%> 




                                                            <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                                                            <input type="hidden" name="patient" value="<%=vst.getPatientid()%>"/>
                                                            <input type="hidden" name="labid" value="<%=vst.getOrderid()%>"/>
                                                            <input type="hidden" name="ids[]" value="<%=ptPatienttreatments.getId()%>"/>
                                                            </tr>

                                                            <%}%>
                                                            <!-- </form>

                                                           end--> 


                                                            </tbody>

                                                        </table>

                                                        <button class="btn btn-danger" type="submit" id="action" name="laboratory" value="Forward">
                                                            <i class="icon-arrow-right icon-white"> </i> Forward to Main Laboratory
                                                        </button>
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
                                        <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>

                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth()%> </td>
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 
                                        <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>
                                        <td><%=vst.getOrderdate()%> </td>

                                        <td>
                                            <button class="btn btn-info" id="<%=vst.getOrderid()%>_link">
                                                <i class="icon-white icon-check"></i> Update 
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

</script>
<% for (int i = 0;
            i < listorders.size();
            i++) {
        Laborders vst = (Laborders) listorders.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getOrderid()%>_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
    $("#<%= vst.getOrderid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
   
    
    $("#<%= vst.getOrderid()%>_link").click(function(){
      
        $("#<%=vst.getOrderid()%>_dialog").dialog('open');
    
    })
   
    $("#<%= vst.getOrderid()%>_dialog").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
   
    
    $("#<%= vst.getOrderid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getOrderid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>




<% }%>

</body>
</html>
