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
            List visits = mgr.listPatientProcedures("Not Done");
            List walkinOrders = mgr.listWalkinProcedures("Not Done");
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
                                <a href="#">Nurses Station</a><span class="divider"></span>
                            </li>
                            <li  class="active">
                                <a href="#">Procedures To Be Performed </a><span class="divider"></span>
                            </li>

                        </ul>
                    </div>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>



                    <div style="display: none;" class="span8 thumbnail well main-c">

                        <table class="example display">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px;"> Folder Number</th>
                                    <th style="font-size: 12px;"> Patient Name </th>
                                    <th style="font-size: 12px;"> Payment Type </th>
                                    <th style="font-size: 12px;"> Date of Birth  </th>
                                    <th style="font-size: 12px;"> Request On </th>

                                    <th style="font-size: 12px;">  </th>

                                </tr>
                            </thead>
                            <tbody>
                                <% if (visits != null) {


                                        for (int i = 0; i < visits.size(); i++) {
                                            Procedureorders vst = (Procedureorders) visits.get(i);
                                %>



                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bold; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(vst.getPatientid()).getDateofbirth()%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> 
                                        <% if(mgr.getPatientByID(vst.getPatientid()).getEmergencyPatient()==1){ %> 
                                                <%=mgr.getPatientByID(vst.getPatientid()).getPatientid()%>EMG 
                                                <% } else { %>
                                                <%=mgr.getPatientByID(vst.getPatientid()).getPatientid()%>
                                                <%} %>   
                                    </td>
                                    <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%>, <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>


                                    <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>
                                    <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
                                    <td><%=formatter.format(vst.getOrderdate())%> </td>


                                    <td><a href="readyprocedure.jsp?order=<%= vst.getOrderid() %>&orderid=-1" class="btn btn-info btn-small">
                                            <i class="icon-white icon-check"></i> View Details
                                        </a>
                                    </td>
                                </tr>
                                <%}
                                    }%> 

                                <% if (walkinOrders != null) {



                                        for (int i = 0; i < walkinOrders.size(); i++) {
                                            Procedureorderswalkin order = (Procedureorderswalkin) walkinOrders.get(i);
                                %>



                                <tr>
                                    <td style="text-transform: uppercase; color: #ff3333 ; font-weight: bold; font-size: 18px;"> <%=order.getOrderid()%>   </td>
                                    <td><%= order.getFirstName()%> <%= order.getLastName()%></td>


                                    <td> Out of Pocket </td>
                                    <td><%=formatter.format(order.getDateOfBirth())%> </td>
                                    <td><%=formatter.format(order.getOrderdate())%> </td>

                                    <td>
                                        <a href="readyprocedure.jsp?orderid=<%= order.getOrderid()%>&order=-1" class="btn btn-info btn-small">
                                            <i class="icon-white icon-check"></i> View Details
                                        </a>

                                    </td>
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
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
        $(".alert").fadeIn();
        $(".progress1").hide();
        $("#sidebar-toggle-container").fadeIn()

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
        
        queueTable =  $('.example').dataTable({
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