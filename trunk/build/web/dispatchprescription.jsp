<%--
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
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
        <style type="text/css">

            table thead th{
                background-color: #FFF !important;
                background-image: none !important;
                color: #000;
            }
        </style>
        <style type="text/css">
            @media print {
                .main{margin:100px 0;}
            }
        </style>
        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat smallformatter = new SimpleDateFormat("dd-MM-yy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy  h:mm a");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);



            String orderId = request.getParameter("orderid");

            if (orderId == null) {
                orderId = "Null";
            }
            Pharmorder vst = mgr.getPharmorder(orderId);


            List ptreatmentss = mgr.listPatientTreatmentsByOrderid(orderId);



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

                        <li>
                            <a href="#">Dispensary</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Prescription For <%= vst.getPatientid()%></a><span class="divider"></span>
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


                    <div class="span8 thumbnail  main-c center" style="padding: 10px; display: none;" >
                        <button type="button" class="btn btn-info" onclick="hidePrint();printSelection(print<%=vst.getOrderid()%>)" style="width: 90%">
                            <i class="icon-white icon-print"></i>   Print Prescription
                        </button>
                        <section style="margin-top: -56px; text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=vst.getOrderid()%>"  >

                            <!-- Headings & Paragraph Copy -->  
                            <div class="container-fluid">

                                <div style="margin-bottom: -15px;" class="row-fluid">
                                    <div style="float: left;  width: 20%">
                                        <img src="images/danpongclinic.png"  style="margin-top: 30px; width: 100%" />
                                    </div>

                                    <img src="images/danpongaddress.png"  style="float: right; margin-top: 20px; width:25% " /> 

                                </div>


                                <div style="clear: both;"></div>

                                <hr style="border: solid #000000 0.5px ; width: 100%"  />

                                <div style="text-align: center;  margin-top: 0px;" class="row-fluid center ">

                                    <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> PRESCRIPTION</h3>

                                </div>
                                <hr class="row-fluid" style="border-top: 2px solid #45BF55; margin: 0px;  width: 100%" >
                                <table class="table-condensed" style="width: 100%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12px; float: left; margin: 5px;">
                                    <tr>
                                        <td> Date:</td> <td><%=formatter.format(vst.getOrderdate())%> </td>
                                    </tr>
                                    <tr>
                                        <td> Invoice No:</td> <td><%= vst.getOrderid()%> </td>
                                    </tr>
                                    <tr>
                                        <td> Account:</td> <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getType()%>  </td>
                                    </tr>
                                    <tr>
                                        <td> Name:</td> <td style="text-transform: uppercase;"><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                            <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                            <%= mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>
                                    </tr>
                                    <tr>
                                        <td> Card No:</td> <td style="text-transform: uppercase;"><%= vst.getPatientid()%> </td>
                                    </tr>
                                </table>

                                <div style="clear: both;"></div>

                                <hr class="row-fluid" style="border-top: 2px solid #45BF55; margin: 0px;" >
                                <div class="row-fluid center">

                                    <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;  ">PRESCRIBED DRUGS</h3>

                                </div>

                                <table style="width: 100%" cellspacing="0">
                                    <thead>
                                        <tr style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                            <th style="width: 90%; border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 5px;">
                                                Details 
                                            </th>
                                            <th style="width: 10%; text-align: right;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px;   border-left: none; padding-right: 5px;">
                                                Quantity
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                        <%

                                            List ptreatmentss2 = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());
                                            for (int r = 0; r < ptreatmentss2.size(); r++) {
                                                Patienttreatment ptPatienttreatments2 = (Patienttreatment) ptreatmentss2.get(r);

                                        %>
                                        
                                        <tr id="patTre<%=ptPatienttreatments2.getTreatmentid()%>">
                                            <td class="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments2.getTreatmentid()%>" style=" text-transform: uppercase; line-height: 12px; padding-left: 5px;">
                                                <input type="checkbox" checked="checked" id="patTre<%=ptPatienttreatments2.getTreatmentid()%>checkbox" style="margin-right: 10px; " class="pull-left no-print"/>     
                                                <%=mgr.getTreatment(ptPatienttreatments2.getTreatmentid()).getTreatment()%>
                                            </td>
                                            <td class="treatment_check<%=vst.getOrderid()%><%=ptPatienttreatments2.getTreatmentid()%>" style="text-align: right; line-height: 12px; padding-right: 5px;">
                                                <%=ptPatienttreatments2.getQuantity()%>
                                            </td>

                                        </tr>

                                        <% }
                                        %>



                                    </tbody>
                                </table>
                                <div style="margin-top: 20px;bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                                    Served by  <%= mgr.getStafftableByid(user.getStaffid()).getOthername()%> <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                                    Wishing You Speedy Recovery <br /> Thank you
                                </div>        
                            </div>
                        </section> 

                        <br />
                        <br />
                        <button type="button" class="btn btn-info" onclick="hidePrint();printSelection(print<%=vst.getOrderid()%>)" style="width: 90%">
                            <i class="icon-white icon-print"></i>   Print Prescription
                        </button>
                    </div>





                </div>

            </section>  

        </div>


        <div class="clearfix"></div>



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
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();

        $(".menu").fadeIn();
        $(".main-c").fadeIn();
        $(".navbar").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
        $(".alert").fadeIn();
        $(".progress1").hide();

        menu_a.click(function(e) {
            e.preventDefault();
            if (!$(this).hasClass('active')) {
                menu_a.removeClass('active');
                menu_ul.filter(':visible').slideUp('normal');
                $(this).addClass('active').next().stop(true, true).slideDown('normal');
            } else {
                $(this).removeClass('active');
                $(this).next().stop(true, true).slideUp('normal');
            }
        });

    });

    function printSelection(node) {

        var content = node.innerHTML
        var pwin = window.open('', 'print_content', 'width=350,height=800');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">' + content + '</body></html>');
        pwin.document.close();

        setTimeout(function() {
            pwin.close();
        }, 1000);

    }

    function dispatch(id) {
        //alert("here");
        //var name = document.getElementById(id).value;

        $.post('action/labaction.jsp', {action: "dispatch", name: id}, function(data) {
            //alert(data);
            $('#results').html(data).hide().slideDown('slow');
        });

    }
</script>


<script type="text/javascript">
    
    $(document).ready(function(){ 
        
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
            //$('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('span3 hide');
            $('.main-c').toggleClass('span9');
            queueTable.fnAdjustColumnSizing();
        });
               
    
    <%
        List patientTreatments = mgr.listPatientTreatmentsByOrderid(vst.getOrderid());

        for (int x = 0; x < patientTreatments.size(); x++) {
            Patienttreatment patTre = (Patienttreatment) patientTreatments.get(x);

    %>
    
    
            $("#patTre<%=patTre.getTreatmentid()%>checkbox").change(function(){
        
                if($(this).is(':checked')){ 
            
                   
                    $("#patTre<%=patTre.getTreatmentid()%>").children().css("text-decoration","none")
                    $("#patTre<%=patTre.getTreatmentid()%>").removeAttr("class");
                    $("#patTre<%=patTre.getTreatmentid()%>").children().removeAttr("class");
                    
                    
                }else{
                    
                    $("#patTre<%=patTre.getTreatmentid()%>").attr("class","no-print");
                    $("#patTre<%=patTre.getTreatmentid()%>").children().css("text-decoration","line-through")
                    $("#patTre<%=patTre.getTreatmentid()%>").children().addClass("no-print")
                    
                    
                    
                    
                }
                
                //alert($(this).attr("class"));
            })
        
    
    <% }%>
        });
    
</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers",
            "iDisplayLength": 25,
            "aaSorting": [],
            "bSort": true,
            "sScrollY": 400

        });

        $(".patient").popover({
            placement: 'right',
            animation: true

        });

    });
    
    
    function hidePrint(){
             
        $(".no-print").css("display","none");
        
        //alert("Printing")            
    }

</script>


</body>
</html>
