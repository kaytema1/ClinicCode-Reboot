<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    List patientBeds = mgr.listPatientBed();

%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <style type="text/css">

            .occupied {

                color: #cc0000;
                border-color: #cc0000;

            }

            .available {
                color: #2ba949;
                border-color: #2ba949;

            }



        </style>

    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <!--<li>
                            <a href="#">Records</a><span class="divider"></span>
                        </li>-->
                        <li>
                            <a href="#">Ward</a><span class="divider"></span>
                        </li>
                        
                        <li class="active">
                            <a href="#">Current In Patients </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>



            <div style="position: absolute; left: 30%; top: 200px; text-align: center;" class="progress1">
                <img src="images/logoonly.png" width="136px;" style="margin-bottom: 20px;" />
                <a href="#"> <h3 class="segoe" style="text-align: center; font-weight: lighter;"> Your page is taking longer than expected to load.....
                        <br />
                        Please be patient!</h3>
                    <br />
                </a>
                <div  class="progress progress-striped active span5">

                    <div class="bar"
                         style="width: 100%;"></div>
                </div>
            </div>
            <div id="sidebar-toggle-container" class="container-fluid hide">
                <div class="row-fluid">
                    <a href="#" class="btn" id="sidebar-toggle"><i class="icon-chevron-right"></i></a>
                </div>
            </div>
            <div class="clearfix">

            </div>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">
                    <%
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        //Patient p = (Patient)session.getAttribute("patient");
                        //get current date time with Date()
                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                        Date date = new Date();
                        //System.out.println(dateFormat.format(date));

                        List allWards = mgr.listWard();
                        List allRooms = mgr.listRoom();
                        List beds = null;

                    %>

                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="thumbnail main-c span8">
                        <ul class="breadcrumb center">
                            <li>
                                <a style="font-weight: bold" href="#">PATIENTS ON ADMISSION</a>
                            </li>
                        </ul>

                        <%

                            for (int y = 0; y < patientBeds.size(); y++) {
                                PatientBed patientBed = (PatientBed) patientBeds.get(y);
                        %>

                        <div class="thumbnail center " style="width: 28%;  float:  left; margin-left: 2%; margin-top: 2%;  text-transform: capitalize;">  

                            <div style="margin-top: 2%"> 
                                
                                <h3 style="text-transform: uppercase;"> <%= mgr.getBed(patientBed.getBedid()).getDescription()  %> OF
                                
                                    <% if(mgr.getBed(patientBed.getBedid()).getWardid() != 0){ %>
                                    
                                    <%= mgr.getWardById(mgr.getBed(patientBed.getBedid()).getWardid()).getWardname() %>
                                    <% } %>
                                    
                                    <% if(mgr.getBed(patientBed.getBedid()).getRoomid() != 0){ %>
                                    <%= mgr.getRoom(mgr.getBed(patientBed.getBedid()).getRoomid()).getDescription()  %>
                                    
                                    <% } %>
                                </h3>
                                <br />
                                <h3 style="text-transform: uppercase;">  <%= patientBed.getPatientid()%> </h3>
                                <br/>

                                <h4> <%= mgr.getPatientByID(patientBed.getPatientid()).getFname()%>
                                     <%= mgr.getPatientByID(patientBed.getPatientid()).getMidname()%>
                                     <%= mgr.getPatientByID(patientBed.getPatientid()).getLname()%>
                                </h4>
                                <br />
                                
                                




                               
                                <div class="clearfix">
                                    
                                </div>
                                <a href="inpatientconsultation.jsp?visitid=<%=patientBed.getVisitid()%>" class="btn btn-primary">
                                    Attend to Patient
                                </a>

                            </div>

                        </div>
                        <% }%>

                    </div>





                </div>



        </div> 

        <div class="clear"></div>



    </div>

</section>

<%@include file="widgets/footer.jsp" %>

</div><!-- /container -->




</div>


<div class="clear"></div>



<script src="js/jquery.js"></script>
<script src="js/bootstrap-dropdown.js"></script>
<script src="js/bootstrap-scrollspy.js"></script>
<script src="js/bootstrap-collapse.js"></script>
<script src="js/bootstrap-tooltip.js"></script>
<script src="js/bootstrap-popover.js"></script>
<script src="js/application.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/jquery-ui-autocomplete.js"></script>
<script src="js/jquery.select-to-autocomplete.min.js"></script>

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
        $("#sidebar-toggle-container").fadeIn();
        $(".main-c").fadeIn();
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
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
            
                
               
                
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-right icon-chevron-left');
            $('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('hide span3');
            $('.menu').toggleClass('span3');
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