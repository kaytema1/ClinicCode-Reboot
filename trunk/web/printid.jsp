<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat nice = new SimpleDateFormat("d MMM. yyyy");

    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
    SimpleDateFormat day = new SimpleDateFormat("dd");
    SimpleDateFormat month = new SimpleDateFormat("MM");
    SimpleDateFormat year = new SimpleDateFormat("yyyy");
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
    String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");
    String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");

    Patient patient = null;




    List list = null;

    try {
        if (patientid != "") {
            patient = mgr.getPatientByID(patientid);
            list = new ArrayList<Patient>();
            list.add(patient);
            if (patient == null) {
                session.setAttribute("lasterror", "Please Select a Patient");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("listpatients.jsp");
                return;
            }
        }


    } catch (NullPointerException e) {
        session.setAttribute("lasterror", "Please Select a Patient");
        session.setAttribute("class", "alert");
        response.sendRedirect("records.jsp");
        return;
    }


%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>


    <body style="overflow-y: scroll;" data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="records.jsp">Records <i class="icon-chevron-right"></i></a><span class="divider"></span>
                        </li>

                        <li class="active">
                            <a href="#"><%= patientid%>  </a><span class="divider"></span>
                        </li>



                    </ul>
                </div>

            </header>



            <%if (list != null) {%>


            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">
                    <div style="margin-left: 22%; display: block; width: 56%; text-align: center; margin-bottom: 2%">
                        <a class="btn btn-info btn-large" style="width: 100%" onclick='printSelection(document.getElementById("print")); submitform(); return false;' href="#"><i class="icon-print icon-white"></i> Print ID Card Only </a><span class="divider"></span>
                        <input type="hidden" name="patientid" id="patientid" value="<%= patient.getPatientid()%>" />
                        <input type="hidden" name="orderedby" id="orderedby" value="<%= user.getStaffid()%>" />

                    </div>
                    <div class="clearfix">

                    </div>
                    <div id="print" style="margin-left:  22%; display: block; width: 56%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; padding-left: 2%;" class="profile thumbnail">

                        <div style="float: left; width: 28%; padding-top: 2%;  border-right: solid #ccc 1px;">

                            <div>
                                <img style="width: 90%" src="images/danpongclinic.png" />  
                            </div>

                            <div class="clearfix">

                            </div>

                            <table style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; line-height: 15px; margin-top: 2%">
                                <tr>
                                    <td style="text-align: left; padding-left: 5%; width: 35%; margin-bottom: 2%; font-weight: bold;">
                                        TEL. :
                                    </td>

                                    <td style="text-transform: uppercase;  margin-bottom: 2%; margin-left: 10%;">
                                        0302 811 153
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: left; padding-left: 5%; width: 35%; margin-bottom: 2%; font-weight: bold;">

                                    </td>

                                    <td style="text-transform: uppercase;  margin-bottom: 2%; margin-left: 10%;">
                                        0302 811 672
                                    </td>
                                </tr>


                            </table>
                            <br />


                            <div  style="width: 100%; padding-bottom: 5%; padding-left: 0px; text-align: center;">
                                <% if (patient.getGender().equalsIgnoreCase("Male")) {%>


                                <img style="width: 80%; height: 120px" src="img/default-facebook-avatar-male.gif"  />


                                <% } else {%>

                                <img style="width: 80%; height: 120px" src="img/default-facebook-avatar-female.gif"  />

                                <% }%>
                            </div>
                            <br/>

                            <div style=" font-size: 16px; text-align: center; text-transform: uppercase; margin-bottom: 5%; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" >
                                <%= patient.getFname()%> <%if (patient.getMidname() != null) {%> <%= patient.getMidname()%> <% }%> <%= patient.getLname()%>
                            </div>
                        </div>



                        <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; width: 68%; float: left; font-size: 17px; ">
                            <div style="margin-bottom: 2%; width: 100%; float: left;padding-top: 1% ">
                                <div  style=" font-size: 30px; font-weight: bolder; text-align: center; text-transform: uppercase; margin-bottom: 5% ">
                                    FOLDER NO.: <%= patient.getPatientid()%>
                                </div>
                                <hr style="border: solid 1px #ccc;" />

                                <table style="line-height: 22px; width: 100%">
                                    <tr>
                                        <td style="text-align: left; padding-left: 7%; width: 40%; font-weight: bold;">
                                            FULL NAME
                                        </td>
                                        <td style="text-transform: uppercase; padding-left: 5%; width: 60%;">
                                            <%= patient.getFname()%> <%if (patient.getMidname() != null) {%> <%= patient.getMidname()%> <% }%> <%= patient.getLname()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding-left: 7%; width: 40%; font-weight: bold;">
                                            DATE OF BIRTH
                                        </td>
                                        <td style="text-transform: uppercase; padding-left: 5%;width: 60%; ">
                                            <%= nice.format(patient.getDateofbirth())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding-left: 7%; width: 40%; font-weight: bold;">
                                            GENDER
                                        </td>
                                        <td style="text-transform: uppercase; padding-left: 5%;width: 60%; ">
                                            <%= patient.getGender()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding-left: 7%; width: 40%; font-weight: bold;">
                                            NATIONALITY
                                        </td>
                                        <td style="text-transform: uppercase; padding-left: 5%;width: 60%; ">
                                            <%= patient.getCountry()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding: 0px; padding-left: 7%; width: 40%; font-weight: bold;">
                                            PHONE NUMBER
                                        </td>
                                        <td style="text-transform: uppercase; padding-left: 5%;width: 60%; ">
                                            <% if (patient.getContact() != null) {%> <%= patient.getContact()%> <% }%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding-left: 7%; width: 40%; font-weight: bold;">
                                            ISSUED ON
                                        </td>
                                        <td style="text-transform: uppercase; padding-left: 5%;width: 60%; ">
                                            <%= nice.format(patient.getDateofregistration())%>
                                        </td>
                                    </tr>


                                </table>

                                <hr style="border: solid 1px #ccc;" />
                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-align: center; font-size: 20px; font-weight: bold; padding: 0px;"> PATIENT IDENTITY CARD  </div>
                                <br />
                                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-align: center; font-size: 13px;  padding: 0px;">
                                    Kindly Bring This Card Each Time You Attend The Clinic.
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>

                    <div class="clearfix">

                    </div>
                    <div style="margin-left: 22%; display: block; width: 56%; text-align: center; margin-top: 2%; ">
                        <form name="form" style="margin: 0px; padding: 0px; text-align: center;" class="form-horizontal" id="search_dialog" action="searchresults.jsp" method="post">
                            <input type="hidden" name="searchid"  value="patientid" />
                            <input type="hidden" placeholder="Please Enter Search Query" class="input-xlarge" value="<%=patient.getPatientid()%>"  name="searchquery"/>

                            <button style="width: 100%" type="submit"  onclick='submitform(); printSelection(document.getElementById("print"));  document.forms.form.submit(); return false;' class="btn btn-danger btn-large">
                                <i class="icon-arrow-right icon-white"></i> Print ID Card & Start Visit 
                            </button>


                        </form>
                    </div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>
        </div>



        <%}


        %>


        <!--end static dialog-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltipatient.js"></script>

        <script src="js/application.js"></script>
        <script src="js/jquery.validate.min.js"></script>

        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

        <script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

        <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
        <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="js/tablecloth.js"></script>
        <script type="text/javascript" src="js/demo.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript"> 
            
                
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();

                $(".menu").fadeIn();
                $(".alert").fadeIn();
                $(".main-c").fadeIn();
               
                $(".profile").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $("#bgimage").fadeIn();
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
                
                $("input:checkbox").attr("checked", false);
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true

                });
                    
                    
                $('#sidebar-toggle').click(function(e) {
                    e.preventDefault();
                    $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                    $('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('span3 hide');
                    $('.main-c').toggleClass('span8');
                
                });

                   

                   
            
                

            });
            
            
            function printSelection(node){

                var content=node.innerHTML
                var pwin=window.open('','print_content','width=800,height=500');

                pwin.document.open();
                pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                pwin.document.close();
 
                setTimeout(function(){pwin.close();},1000);

            }
            
            
            
            function submitform(){
                var patient = document.getElementById("patientid").value;
                var ordered = document.getElementById("orderedby").value;
                $.post('action/registrationaction.jsp', { action : "cardupdate", patientid : patient, orderedby : ordered}, function(data) {
                    // alert("Hello");
                    // location.reload();
                });
               
                
            }
        </script>




    </body>
</html>
