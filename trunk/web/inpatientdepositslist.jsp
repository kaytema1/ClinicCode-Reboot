<%-- 
    Document   : accounts
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : ClaimSync
--%>
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
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            Date date = new Date();
            double registrationFee = 0;
            List visits = mgr.listVisitationsAtUnit("deposits");
            List treatments = null;
            //   Visitationtable visit = (Visitationtable) visits.get(i);
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
                    <li  class="active">
                        <a href="#"> In Patient Deposits </a><span class="divider"></span>
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


                <div style="display: none;" class="span8 thumbnail main-c">

                    <table class="example display table-striped">
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
                            <% if (visits != null) {

                                    String pId = "";
                                    PatientRegistration pReg = null;
                                    List result;
                                    boolean paymentStatus = false;
                                    for (int i = 0; i < visits.size(); i++) {
                                        Visitationtable vst = (Visitationtable) visits.get(i);
                            %>
                            

                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> ">

                                    <% if (mgr.getPatientByID(vst.getPatientid()).getEmergencyPatient() == 1) {%> 
                                    <%=vst.getPatientid()%>EMG 
                                    <% } else {%>
                                    <%=vst.getPatientid()%>
                                    <%}%>

                                </td>
                                <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                <td><%=formatter.format(vst.getDate())%> </td>

                                <td>
                                    <a href="processdepositpayment.jsp?visitid=<%=vst.getVisitid() %>" class="btn btn-info btn-small" id="<%=vst.getVisitid()%>_link">
                                        Make Deposit
                                    </a></td>
                            </tr>
                            <% }
                                }%> 

                        </tbody>
                    </table>

                </div>


                <div class="clearfix"></div>



        </section>

        <%@include file="widgets/footer.jsp" %>



    </div>                          

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

<script type="text/javascript" src="js/jquery.filter_input.js "></script>
<!--initiate accordion-->
<script type="text/javascript">
    
    
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

        //menu_ul.hide();

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
    });

</script>

</body>
</html>