<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Set"%>
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
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E. dd MMM. yyyy  h:mm a");
            SimpleDateFormat time = new SimpleDateFormat("h:mm a");
            Date date = new Date();

            List listorders = mgr.listLabordersByStatuses("Approved", "Out-Complete");
            System.out.println("laborders " + listorders.size());

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
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">New Laboratory Results</a><span class="divider"></span>
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
                                        <th style="text-align: left;"> Laboratory Number </th>
                                        <th style="text-align: left;"> Patient Name </th>
                                        <th style="text-align: left;"> Payment Type </th>
                                        <th style="text-align: left;"> Date of Birth  </th>

                                        <th style="text-align: left;"> Requested On </th>
                                        <th style="text-align: left"> Time </th>
                                        <th></th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (listorders != null) {
                                            for (int i = 0; i < listorders.size(); i++) {
                                                Laborders vst = (Laborders) listorders.get(i);
                                    %>


                                    <tr>

                                        <%if (vst.getPatientid().contains("C") || vst.getPatientid().contains("c")) {%>
                                        <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px; text-align: left" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=vst.getOrderid()%> </a>   </td>
                                        <td style="text-align: left;"><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : mgr.getPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td style="text-align: left;"><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 
                                        <td style="text-align: left;"><%=mgr.getPatientByID(vst.getPatientid()) == null ? "" : newformatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

<!--   <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->
                                        <td style="text-align: left;"><%=newformatter.format(vst.getOrderdate())%> </td>
                                        <%} else {%>
                                        <td style="text-transform: uppercase;  font-weight: bolder; font-size: 18px; " class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=vst.getOrderid()%> </a>  </td>
                                        <td style="text-align: left;"><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : mgr.getLabPatientByID(vst.getPatientid()).getLname()%> </td>
                                        <td style="text-align: left;"><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> 

                                        <td style="text-align: left;"><%=mgr.getLabPatientByID(vst.getPatientid()) == null ? "" : newformatter.format(mgr.getLabPatientByID(vst.getPatientid()).getDateofbirth())%> </td>
                                          <!-- <td><%=mgr.sponsorshipDetails(vst.getPatientid()) == null ? "" : mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td> -->
                                        <td style="text-align: left;"><%=newformatter.format(vst.getOrderdate())%> </td>
                                        <td style="text-align: left;"><%=time.format(vst.getOrderdate())%> </td>
                                        <%}%>
                                        <td style="text-align: center;">

                                            <div class="btn-group">
                                                <a class="btn btn-info btn-small"  href="print.jsp?labOrderId=<%=vst.getOrderid()%>">
                                                    <i class="icon-eye-open icon-white"></i> View to Print
                                                </a>

                                            </div>

                                            <%}
                                                }%> 

                                </tbody>
                            </table>

                        </div>

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
<script type="text/javascript" charset="utf-8" src="media/js/ZeroClipboard.js"></script>
<script type="text/javascript" charset="utf-8" src="media/js/TableTools.js"></script>
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

    function printSelection(node){

        var content=node.innerHTML
        var pwin=window.open('','print_content','width=950,height=1200');

        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
        pwin.document.close();
 
        setTimeout(function(){pwin.close();},1000);

    }
    
    function dispatch(id){
        //alert("here");
        //var name = document.getElementById(id).value;
                  
        $.post('action/labaction.jsp', { action : "dispatch", name : id}, function(data) {
            //alert(data);
            $('#results').html(data).hide().slideDown('slow');
        } );
                
    }
</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 500
            

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
    
    
    $("#popupdiv<%=vst.getOrderid()%>").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
    $("#popupdiv<%= vst.getOrderid()%>link").click(function(){
      
        $("#popupdiv<%= vst.getOrderid()%>").dialog('open');
    
    })
   
    
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