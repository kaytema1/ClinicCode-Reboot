
<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            HMSHelper mgr = new HMSHelper();
            ExtendedHMSHelper mg1 = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat emergencyPatient = new SimpleDateFormat("dd-MM-yyyy hh:mm");

            Date date = new Date();
            List visits = mgr.listRecentVisits(dateFormat.format(date));
            Patient lastPatient2 = (Patient) mgr.listPatients().get(mgr.listPatients().size() - 1);

            String lastPatientid2 = lastPatient2.getPatientid();

            int numberPatients = Integer.parseInt(lastPatientid2.substring(4));

            System.out.println(mgr.listPatients().size() + 1 + "________________________________________");
        %>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">

                    <li class="active">
                        <a href="#">Billing</a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

            <!-- Headings & Paragraph Copy -->



            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%> center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>



            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>

                <div style="display: none;" class="box span8 main-c " id="myModal">
                    <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                        <img class="pull-left" src="img/glyphicons/png/glyphicons_298_hospital.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Quick Actions </h4> </a>
                        <i class="pull-right icon-remove"> </i>
                        <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                    </div>
                    <div id="chart_div" style="height: 100%; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden; display: block; margin: 0 auto; padding-top: 50px; padding-left: 20px; padding-right: 20px; padding-bottom: 50px;" class="box-body">

                        <a href="#">
                            <div style="width: 40%; float:  left;" class="center  well large_button registration_dialog_link">
                                <img style="margin-top: -4px; margin-right: 15px;" width="36px;"height="36px;"  src="images/icons/042.png" />
                                Medical Bills
                                 <span style="margin-left: 10px;" class="badge_b"><%=medbillpatients.size()%> </span>
                            </div> </a>
                        <a href="#">
                            <div style="width: 40%; float:  right;" class="dialog_link2 center  well large_button">
                                <img style="margin-top: -4px; margin-right: 15px;" width="36px;"height="36px;"  src="images/icons/042.png" /> Outstanding Bills
                                <span style="margin-left: 10px;" class="badge_b"><%=dispensingpatients.size() + procedurepatients.size()%> </span>
                            </div> 
                        </a>

                        <div class="clearfix"></div>
                        <Br />
                        <Br />

                        <div class="clearfix"></div>
                        
                         <a href="walk-inprocedurepaymentlist.jsp">
                            <div style="width: 40%; float:  left; "  class="center well large_button">
                                <img style="margin-top: -4px;margin-right: 15px;" width="36px;"height="36px;"  src="images/icons/031.png" />
                               

                                    
                                Walk-In Procedures<span style="margin-left: 10px;" class="badge_b"><%= walkingprocedures.size()%> </span>
                                
                            </div> 
                        </a>
                        <a class="emergency_dialog_link" href="account_search.jsp">
                            <div style="width: 40%; float:  right;" class="center  well large_button">
                                <img style="margin-top: -4px; margin-right: 15px;" width="36px;"height="36px;" src="images/icons/041.png" /> Patient Bill Summaries
                            </div> 
                        </a>
                       

                        <div class="clearfix"></div>



                    </div>
                    <div class="clearfix"></div>

                </div>  

            </div>

        </section>

        <%@include file="widgets/footer.jsp" %>




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

        <script type="text/javascript" src="js/jquery.numeric.js"></script>
        <script type="text/javascript" src="js/tablecloth.js"></script>
        <script type="text/javascript" src="js/demo.js"></script>
        <script type="text/javascript" src="js/jquery.filter_input.js"></script>

        <!--initiate accordion-->

        <script type="text/javascript">
            
          
            $(function() {
                $('#country').selectToAutocomplete();
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
            
            

                //menu_ul.hide();

                $(".menu").fadeIn();
                $("#sidebar-toggle-container").fadeIn();
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

            });
            
            
            
        </script>

    </body>
</html>