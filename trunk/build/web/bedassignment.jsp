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
    List availableBeds = mgr.listAvailableBed();
    List visits = mgr.listUnitVisitations("ward");
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
                            <a href="#">Patient Bed Assignments</a><span class="divider"></span>
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
                    <a href="#" class="btn" id="sidebar-toggle"><i class="icon-chevron-left"></i></a>
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
                                <a style="font-weight: bold" href="#"> BED ASSIGNMENTS</a>
                            </li>
                        </ul>
                        <div class="vertical_tabs">
                            <ul>
                                <% for (int x = 0; x < allWards.size(); x++) {
                                        Ward ward = (Ward) allWards.get(x);
                                %>



                                <li><a href="#tabs-<%=x + 1%>wards"><%= ward.getWardname()%></a></li>

                                <% }%>
                                <% for (int x = 0; x < allRooms.size(); x++) {
                                        Room room = (Room) allRooms.get(x);
                                %>



                                <li><a href="#tabs-<%=x + 1%>rooms"><%= room.getDescription()%></a></li>

                                <% }%>
                            </ul>

                            <% for (int x = 0; x < allWards.size(); x++) {
                                    Ward ward = (Ward) allWards.get(x);
                            %>
                            <div id="tabs-<%=x + 1%>wards">
                                <%  List wardBeds = mgr.listBedByWardid(ward.getWardid());

                                    for (int y = 0; y < wardBeds.size(); y++) {
                                        Bed wardBed = (Bed) wardBeds.get(y);
                                %>

                                <div class="thumbnail center <% if (wardBed.isOccuppied()) {%> occupied <% } else {%> available  <% }%>" style="width: 30%;  float:  left; margin-left: 2%; margin-top: 2%;  text-transform: capitalize;">  

                                    <div style="margin-top: 2%"> 
                                        <h3>  <%= wardBed.getDescription()%> </h3>
                                        <br/>
                                        <br/>

                                        <% if (wardBed.isOccuppied()) {%> 
                                        <h1 style="font-weight: bolder; letter-spacing: 2px;">  OCCUPIED <br /> 

                                        </h1>

                                        <% } else {%> 
                                        <h1 style="font-weight: bolder; letter-spacing: 2px;"> AVAILABLE </h1>

                                        <br />

                                        <button id="avalablebed<%= wardBed.getBedid()%>link" style="width: 80%; margin-left: 5%" class="btn btn-success">
                                            <i class="icon-white icon-hdd"></i>  Assign Bed 
                                        </button>

                                        <% }%>

                                    </div>

                                </div>
                                <% }%>

                            </div>

                            <% }%>

                            <% for (int x = 0; x < allRooms.size(); x++) {
                                    Room room = (Room) allRooms.get(x);
                            %>
                            <div id="tabs-<%=x + 1%>rooms">
                                <%  List wardBeds = mgr.listBedByRoomid(room.getRoomid());

                                    for (int y = 0; y < wardBeds.size(); y++) {
                                        Bed wardBed = (Bed) wardBeds.get(y);
                                %>

                                <div class="thumbnail center <% if (wardBed.isOccuppied()) {%> occupied <% } else {%> available  <% }%>" style="width: 30%;  float:  left; margin-left: 2%; margin-top: 2%;  text-transform: capitalize;">  

                                    <div style="margin-top: 2%"> 
                                        <h3>  <%= wardBed.getDescription()%> </h3>
                                        <br/>
                                        <br/>

                                        <% if (wardBed.isOccuppied()) {%> 
                                        <h1 style="font-weight: bolder; letter-spacing: 2px;">OCCUPIED  <br /> 

                                        </h1>

                                        <% } else {%> 
                                        <h1 style="font-weight: bolder; letter-spacing: 2px;"> AVAILABLE </h1>

                                        <br />

                                        <button id="avalablebed<%= wardBed.getBedid()%>link" style="width: 80%; margin-left: 5%" class="btn btn-success">
                                            <i class="icon-white icon-hdd"></i>  Assign Bed 
                                        </button>

                                        <% }%>

                                    </div>

                                </div>
                                <% }%>

                            </div>

                            <% }%>

                        </div>



                    </div> 

                    <div class="clear"></div>
                    <% for (int xy = 0; xy < availableBeds.size(); xy++) {
                            Bed bed = (Bed) availableBeds.get(xy);
                    %>

                    <div  class="dialog hide" id="avalablebed<%= bed.getBedid()%>" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%; text-transform: uppercase;'> ASSIGN <%= bed.getDescription() %> OF <% if (bed.getWardid() != 0 ){ %>  <%=mgr.getWardById(bed.getWardid()).getWardname() %> <% } if (bed.getRoomid() != 0 ){ %> <%=mgr.getRoom(bed.getRoomid()).getDescription() %> <% } %>  </span>">

                        <form action="action/wvaultaction.jsp" method="post" class="form-horizontal">

                            <input type="hidden"  name="bed" value="<%=bed.getBedid()%>"/>

                            <div class="control-group">
                                <label class="control-label" for="inputEmail">Select Patient</label>
                                <div class="controls">
                                    <select name="patient">

                                        <% for (int i = 0; i < visits.size(); i++) {
                                                Visitationtable visit = (Visitationtable) visits.get(i);%>
                                                <% Patient emergencyPatient = mgr.getPatientByID(visit.getPatientid());
                                                if(emergencyPatient.getEmergencyPatient() == 1){%>
                                                
                                                <option value="<%= visit.getPatientid()%>_<%= visit.getVisitid()%>"> <b>  <%= visit.getPatientid()%>EMG </b>  <%=mgr.getPatientByID(visit.getPatientid()).getFname()%> <%=mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()).getLname()%> </option>

                                                <% } else {%>
                                                
                                        <option value="<%= visit.getPatientid()%>_<%= visit.getVisitid()%>"> <b>  <%= visit.getPatientid()%> </b>  <%=mgr.getPatientByID(visit.getPatientid()).getFname()%> <%=mgr.getPatientByID(visit.getPatientid()).getMidname()%> <%=mgr.getPatientByID(visit.getPatientid()).getLname()%> </option>

                                        <% }  }%>

                                    </select>

                                </div>
                            </div>

                            <div class="clearfix">
                            </div>
                            <div style="text-align: center; padding-left: 0px;" class="form-actions">

                                <button style="width: 90%" class="btn btn-danger btn-small " type="submit" name="action" value="Forward">
                                    <i class="icon-arrow-right icon-white"> </i> Assign Bed 
                                </button>
                            </div>
                        </form>


                    </div>


                    <% }%>


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
               
  
               
        
 

        <% for (int xy = 0; xy < availableBeds.size(); xy++) {
                Bed bed = (Bed) availableBeds.get(xy);
        %>                                               
               
                $('#avalablebed<%= bed.getBedid()%>').dialog({
                    autoOpen : false,
                    width : "50%",
                    modal :true,
                    position : "top"
                
                });
                
                $('#avalablebed<%= bed.getBedid()%>link').click(function(){
                   
                    $('#avalablebed<%= bed.getBedid()%>').dialog('open');
                    return false;
                });
                
        <% }%>                                       
                
            });
    </script>
</body>
</html>