<%-- 
    Document   : adminpanel.jsp
    Created on : Oct 5, 2012, 10:33:50 AM
    Author     : emmanueladdo-yirenkyi
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="entities.HMSHelper"%>
<%@page import="entities.Users"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }%>
<html lang="en">
    <head>

        <%
            HMSHelper mgr = new HMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            //List itmss = mgr.listItems();

        %>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li >
                            <a href="clinicreception.jsp">Clinic Home</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Admin Panel</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">

                    <div style="margin-top: 0px; width: 100%" class="container content1 hide">

                        <div style="padding-left: 0px;" id="tabs">
                            <ul>
                                <li>
                                    <a href="#tabs-1"><i class="icon icon-wrench"> </i> Facility Configurations</a>
                                </li>
                                <li>
                                    <a href="#tabs-2"><i class="icon icon-list"> </i> Stock & Inventory Configurations</a>
                                </li>
                                <li>
                                    <a href="#tabs-5"><i class="icon icon-list-alt"> </i> Consultation Options</a>
                                </li>
                                <li>
                                    <a href="#tabs-3"><i class="icon icon-list-alt"> </i> Health Data Administration</a>
                                </li>
                                <li>
                                    <a href="#tabs-4"><i class="icon icon-star-empty"> </i> User & Patient Administration</a>
                                </li>
                            </ul>
                            <div style="padding-left: 0px;" id="tabs-1">
                                <div style=" overflow: hidden; width:100%; padding: 0px;" class="box span12 pull-left" id="myModal">


                                    <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">


                                        <a href="facility_setup.jsp">
                                            <div style="margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" />   Facility Setup 
                                            </div>
                                        </a>
                                        
                                        <a href="addunit.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" />     Unit Management
                                            </div>
                                        </a>

                                        <a href="adddepartment.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/021.png" />      Department Mgt
                                            </div>
                                        </a>
                                        <a href="addward.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/039.png" />   Ward Management
                                            </div>
                                        </a>


                                        <a href="addroom.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/022.png" />  Add Rooms
                                            </div>
                                        </a>

                                        <a href="addbed.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/022.png" />  Add Beds
                                            </div>
                                        </a>
                                        <a href="addconsultingroom.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/023.png" />    Consultation Rooms
                                            </div>
                                        </a>


                                        <a href="addregfee.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/037.png" /> Registration Fee Management
                                            </div>
                                        </a>

                                        <a href="addconcharges.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/042.png" />    Consultation Fee Management
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div style="padding-left: 0px;" id="tabs-2">


                                <div style=" overflow: hidden; width:100%; padding: 0px;" class="box span12 pull-left" id="myModal">


                                    <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">



                                        <a href="additemtostock.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/020.png" />    Inventory Management
                                            </div>
                                        </a>
                                        
                                        <a href="addSupplier.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/020.png" />    Supplier Management
                                            </div>
                                        </a>
                                        
                                        
                                        <a href="addmanufacturer.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/020.png" />    Manufacturer Management
                                            </div>
                                        </a>
                                        



                                    </div>
                                </div>
                            </div>
                            
                            <div style="padding-left: 0px;" id="tabs-3">


                                <div style=" overflow: hidden; width:100%; padding: 0px;" class="box span12 pull-left" id="myModal">


                                    <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">






                                        <a href="addsymptom.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Symptoms Management
                                            </div>
                                        </a>

                                        <a href="addallergy.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/021.png" /> Allergies Management
                                            </div>
                                        </a>

                                        <a href="addclerking.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/031.png" />    Exam Questions.
                                            </div>
                                        </a>
                                        
                                        
                                        <a href="adddosage.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Dosage Management
                                            </div>
                                        </a>

                                        <a href="addprocedure.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/021.png" /> Procedure Management
                                            </div>
                                        </a>

                                        <a href="adddiagnosis.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/031.png" />    Diagnosis Management
                                            </div>
                                        </a>
                                        
                                       

                                    </div>
                                </div>
                            </div>
                            
                            <div style="padding-left: 0px;" id="tabs-5">


                                <div style=" overflow: hidden; width:100%; padding: 0px;" class="box span12 pull-left" id="myModal">


                                    <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">

                                         <a href="addproblemoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Condition Options
                                            </div>
                                        </a>
                                        
                                        <a href="addonsetoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Onset Options
                                            </div>
                                        </a>
                                        
                                        
                                        <a href="adddurationoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Duration Options
                                            </div>
                                        </a>
                                        
                                        <a href="addcharacteristicoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Characteristics Options
                                            </div>
                                        </a>
                                        
                                        <a href="addbodypartoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Body Part Options
                                            </div>
                                        </a>
                                        
                                        <a href="addaggrevationoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Aggravation Options
                                            </div>
                                        </a>
                                        
                                        <a href="addreliefoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Relief Options
                                            </div>
                                        </a>
                                        
                                        <a href="addtreatmentoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Treatment Options
                                            </div>
                                        </a>
                                            
                                        <a href="addmedicalhistoryoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Medical History Options
                                            </div>
                                        </a>
                                        
                                        <a href="addsocialhistoryoptions.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Social History Options
                                            </div>
                                        </a>
                                        <a href="addclerkingcategory.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Systemic Review Options Categories
                                            </div>
                                        </a>
                                        
                                        <a href="addclerking.jsp">
                                            <div style="  margin-right: 9px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/033.png" /> Systemic Review Options
                                            </div>
                                        </a>
                                        
                                    </div>
                                    
                                </div>
                                
                            </div>
                            
                            
                            <div style="padding-left: 0px;" id="tabs-4">
                                <div style=" overflow: hidden; width:100%" class="box span12 pull-left" id="myModal">


                                    <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">

                                        <a href="addappointmenttype.jsp">
                                            <div style="margin-right: 5px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/037.png" />    Appointments Management
                                            </div>
                                        </a>
                                        <a href="listpatients.jsp">
                                            <div style="margin-right: 5px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/018.png" />   Patient Management 
                                            </div>
                                        </a>
                                        <a href="addsponsor.jsp">
                                            <div style="margin-right: 5px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/019.png" />    Sponsorship Management
                                            </div>
                                        </a>

                                        <a href="addstaff.jsp">
                                            <div style="margin-right: 5px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/027.png" />   Staff Management
                                            </div>
                                        </a>
                                        <a href="addpermission.jsp">
                                            <div style="margin-right: 5px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/017.png" /> Clinic Permissions
                                            </div>
                                        </a>
                                        <a href="addrole.jsp">
                                            <div style="margin-right: 5px;" class="span4 center pull-left  well large_button">
                                                <img style="margin-top: -4px;" width= "36px;" height="36px;" src="images/icons/025.png" />  Roles Management 
                                            </div>
                                        </a>


                                    </div>


                                </div>
                            </div>

                        </div>

                    </div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->


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
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>

        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

        <script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

        <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
        <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

        <script type="text/javascript" src="js/tablecloth.js"></script>
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

        </script>

        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {

                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true

                });

                $("#customer_search").click(function() {
                    //alert("");
                    $("#customer_search_dialog").dialog('open')
                });

                $("#new_customer").click(function() {
                    $("#new_customer_dialog").dialog("open")
                })

                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });

                $(".patient_visit").popover({

                    placement : 'top',
                    animation : true

                });

            });

        </script>

    </body>
</html>