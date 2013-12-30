<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <% Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }

            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        %> 
        <%
            HMSHelper mgr = new HMSHelper();
            String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
            String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");

            // request to determine if this patient is honouring an appointment
            String appPatient = request.getParameter("appPatient") == null ? "" : request.getParameter("appPatient");

            Patient p = null;
            List list = null;

            try {
                if (searchid.equalsIgnoreCase("memberdshipnumber")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    // Sponsorhipdetails spd = mgr.getSearchedSpID(searchquery.trim());
                    List l = mgr.getSearchedSpID(searchquery.trim());
                    Sponsorhipdetails spd = (Sponsorhipdetails) l.get(0);

                    p = (Patient) mgr.getPatientByID(spd.getPatientid());

                }
                if (searchid.equalsIgnoreCase("fullname")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    list = mgr.getPatientByName(searchquery);
                }
                if (searchid.equalsIgnoreCase("patientid")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    p = mgr.getPatientByID(searchquery.trim());

                }
                if (searchid.equalsIgnoreCase("dob")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("records.jsp");
                        return;
                    }
                    System.out.println(searchquery);

                    list = mgr.listPatientByDob(searchquery);
                    System.out.println("here " + list.size());

                }
            } catch (ArrayIndexOutOfBoundsException e) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            } catch (NullPointerException e) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }


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

                    <li>
                        <a href="records.jsp">Records</a><span class="divider"></span>
                    </li>
                    <li class="active">
                        <a href="#"> Patient Search Results</a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>
        <%if (p != null) {%>
        <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

            <!-- Headings & Paragraph Copy -->
            <div class="row-fluid">
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span8  thumbnail main-c">



                    <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                        <thead>
                            <tr>
                                <th style="text-align: left;">Folder Number </th>
                                <th style="text-align: left;">Patient Name </th>
                                <th style="text-align: left;">Payment Type</th>
                                <th style="text-align: left;">Date of Birth</th>
                                <th style="text-align: left;">Location</th>
                                <th style="text-align: left;">Select Consultation Type</th>

                            </tr>
                        </thead>
                        <tbody>

                            <tr class="odd gradeX">

                                <td style="font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Payment Type </td> <td>
                                    <%=  mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                    </table>">
                                    <a style="text-transform: uppercase;" class="patientid"><% if(p.getEmergencyPatient()==1){ %> 
                                                <%=p.getPatientid()%>EMG 
                                                <% } else { %>
                                                <%=p.getPatientid()%>
                                                <%} %></a>
                                </td>
                                <td><%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%> </td><td><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                <td>  <%= formatter.format(p.getDateofbirth())%> </td>
                                <td style="text-transform: capitalize; text-align: left"><%=mgr.getPatientFolder(p.getPatientid()).getStatus()%><td>
                                    <div  style="display: block; text-align: left" id="s_<%=p.getPatientid()%>">
                                        <select style="text-transform: capitalize;" class="input-small" name="contype" onchange='showConType("d_<%=p.getPatientid()%>")' id="ty">
                                            <option>Select</option>
                                            <%
                                                List types = mgr.listConsultation();
                                                for (int j = 0; j < types.size(); j++) {
                                                    Consultation unit = (Consultation) types.get(j);
                                            %>
                                            <option style="text-transform: capitalize;" value="<%=unit.getConid()%>"><%=unit.getContype()%></option> 
                                            <% }%>
                                        </select>
                                    </div>
                                    <div  id="d_<%=p.getPatientid()%>" style="display: none; float: left">
                                        <a  id="patientidlink"  class="btn btn-info center" onclick='getContype()'> <i class="icon-pencil icon-white"> </i> Start Visit </a>
                                    </div></td>
                            </tr>

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



        <div style="max-height: 600px; y-overflow: scroll; display: none;" class="usersummary hide" id="<%= p.getPatientid()%>"  title=" <img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 5%; top: 29%;'> PATIENT INFORMATION <span>">
            <div class="thumbnail">
                <ul style="margin-left: 0px; text-transform: uppercase;" class="breadcrumb">
                    <li>
                        <span class="divider"></span> Folder Number:  <b> <% if(p.getEmergencyPatient()==1){ %> 
                                                <%=p.getPatientid()%>EMG 
                                                <% } else { %>
                                                <%=p.getPatientid()%>
                                                <%} %> </b>
                    </li>
                </ul>

                <div style="margin-top: 12px; padding-top: 5px;  padding-bottom: 5px; text-align: center; width:  30%; float: left;" class="thumbnail">
                    <% if (p.getGender().equalsIgnoreCase("Male")) {%>


                    <img src="img/default-facebook-avatar-male.gif" />


                    <% } else {%>

                    <img src="img/default-facebook-avatar-female.gif" />

                    <% }%>
                </div>

                <table style="width: 65%; margin-left: 2%" class="table table-bordered  pull-left">
                    <tr>
                        <td> Patient Name</td>

                        <td><b> <%= p.getFname()%> <%= p.getMidname()%> <%= p.getLname()%> </b></td>
                    </tr>

                    <tr>
                        <td> Gender </td>

                        <td><b> <%=p.getGender()%></b></td>
                    </tr>

                    <tr>
                        <td> Employer </td>

                        <td><b> <%= p.getEmployer()%></b></td>
                    </tr>
                    <tr>
                        <td> Folder Number </td>

                        <td style="text-transform: uppercase;"><b> <%= p.getPatientid()%></b></td>
                    </tr>

                </table>

                <div class="clearfix"></div>


                <div class="form-actions">
                    <form style="text-align: right;"  action="action/forwardaction.jsp" method="post">
                        <p class="help-block"></p>

                        <!-- <button  class="btn btn-info pull-left" type="button"  href="#" onclick='printSelection(document.getElementById("print")); return false'>
                             <i class="icon-print icon-white"> </i> Print
                         </button>  -->

                        <input type="hidden" name="patient" value="<%=p.getPatientid()%>"/>
                        <input type="hidden" name="unitid" value="account"/>
                        <input type="hidden" name="contype" id="contype" value=""/>

                        <% if (!appPatient.isEmpty()) {%>
                        <input type="hidden" name="appPatient" value="<%=appPatient%>" />
                        <% }%>
                        <button  class="btn btn-danger" type="submit" id="action" name="action" value="forward">
                            <i class="icon-arrow-right icon-white"> </i> Forward to Cashier
                        </button>

                    </form>
                </div>

            </div>
        </div>

        <div style="display: none; text-align: justify;" id="print">
            <h2 style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif"> DANPONG CLINIC </h2> 

            <h2 style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif"> FOLDER NO. </h1> 

                <h1 style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; text-transform: uppercase;"><%= p.getPatientid()%></h1>
        </div>

        <%}%>
        <%if (list != null) {%>
        <section style="margin-top: -30px;" id="dashboard">

            <!-- Headings & Paragraph Copy -->
            <div class="row">
                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">



                    <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                        <thead>
                            <tr>
                                <th style="text-align: left;">Folder Number </th>
                                <th style="text-align: left;">Patient Name </th>
                                <th style="text-align: left;">Payment Type</th>
                                <th style="text-align: left;">Date of Birth</th>
                                <th style="text-align: left;">Location</th>
                                <th style="text-align: left;">Select Consultation Type</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < list.size(); i++) {
                                    Patient pp = (Patient) list.get(i);
                                    System.out.println("test " + list.size());
                            %>
                            <tr class="odd gradeX">
                                <td style="font-size: 18px; font-weight: bolder;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= pp.getFname()%>, <%= pp.getLname()%> <%= pp.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(pp.getDateofbirth())%></h5> <span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= pp.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= pp.getEmployer()%>  </td>  </tr> <tr> <td> Payment Type </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                    </table>"><a class="patientid"><%= pp.getPatientid()%></a></td><td><b><%= pp.getFname()%>  <%= pp.getMidname()%> <%= pp.getLname()%> </b></td>
                                <td><%= mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                <td>  <%= formatter.format(pp.getDateofbirth())%> </td>
                                <td style="text-transform: capitalize">
                                    <%= mgr.getPatientFolder(pp.getPatientid()).getStatus()%>

                                <td>
                                    <div style="display: block" id="s_<%=pp.getPatientid()%>">
                                        <select class="input-large" name="contype" onchange='showConType("d_<%=pp.getPatientid()%>")' id="ty_<%=pp.getPatientid()%>">
                                            <option>Select</option>
                                            <%
                                                List types = mgr.listConsultation();
                                                for (int j = 0; j < types.size(); j++) {
                                                    Consultation unit = (Consultation) types.get(j);
                                            %>
                                            <option value="<%=unit.getConid()%>"><%=unit.getContype()%></option> 
                                            <% }%>
                                        </select>
                                    </div>
                                    <div id="d_<%=pp.getPatientid()%>" style="display: none; float: left;">
                                        <a  id="<%=pp.getPatientid()%>_patientidlink"  class="btn btn-info" onclick='getType("ty_<%=pp.getPatientid()%>","type_<%=pp.getPatientid()%>")'> <i class="icon-pencil icon-white"> </i> Start Visit </a>
                                    </div></td>
                            </tr>
                            <%}%>
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

    <%for (int i = 0; i < list.size(); i++) {
            Patient ppp = (Patient) list.get(i);
    %>
    <div style="max-height: 600px; y-overflow: scroll; display: none;" class="usersummary hide" id="<%= ppp.getPatientid()%>_dialog"  title="Patient Information">
        <div class="well thumbnail">
            <ul style="margin-left: 0px; text-transform: uppercase;" class="breadcrumb">
                <li>
                    <span class="divider"></span> Folder Number: <%= ppp.getPatientid()%>
                </li>
            </ul>

            <div style="margin-top: 12px; padding-top: 5px;  padding-bottom: 5px; text-align: center;" class="thumbnail span2">
                <% if (ppp.getGender().equalsIgnoreCase("Male")) {%>


                <img src="img/default-facebook-avatar-male.gif" />


                <% } else {%>

                <img src="img/default-facebook-avatar-female.gif" />

                <% }%>

            </div>

            <table class="table span3 pull-right table-bordered table-condensed">
                <tr>
                    <td> Folder Number </td>

                    <td><b> <%= ppp.getPatientid()%></b></td>
                </tr>

                <tr>
                    <td> Patient Name</td>

                    <td><b> <%= ppp.getFname()%> <%= ppp.getMidname()%> <%= ppp.getLname()%></b></td>
                </tr>

                <tr>
                    <td> Gender </td>

                    <td><b> <%=ppp.getGender()%></b></td>
                </tr>

                <tr>
                    <td> Employer </td>

                    <td><b> <%= ppp.getEmployer()%></b></td>
                </tr>



            </table>

            <div class="clearfix"></div>
            <br />
            <div class="clearfix"></div>

            <hr />

            <form class="span3" style="text-align: center; margin-left: 25%; "  action="action/forwardaction.jsp" method="post">

                <br />
                <input type="hidden" name="patient" value="<%=ppp.getPatientid()%>"/>
                <input type="hidden" name="unitid" value="account"/>
                <input type="hidden" name="contype" id="type_<%=ppp.getPatientid()%>" value=""/>

                <% if (!appPatient.isEmpty()) {%>
                <input type="hidden" name="appPatient" value="<%=appPatient%>" />
                <% }%>

                <button class="btn btn-danger" type="submit" id="action" name="action" value="forward">
                    <i class="icon-arrow-right icon-white"> </i> Forward to Cashier
                </button>

            </form>
            <div class="clearfix"></div>
        </div>
    </div>

    <% }
    } else {

    %>

    <br/> 

    <!-- <div class="alert hide alert-info container center">
         <b> No Results Found!  </b>
     </div>
     <br/>
     <div class="container-fluid center">
 
 
         <img id="bgimage"  class="center hide" width="40%" src="images/logoonly.png" />
 
     </div>   -->
    <%        }
    %>

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
    <script type="text/javascript" src="js/demo.js"></script>

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

            var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

             menu_ul.hide();

            $(".menu").fadeIn();
            $(".alert").fadeIn();
            $(".main-c").fadeIn();
            $(".sidebar-toggle-container").fadeIn();
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

        });

    </script>
    <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function() {

            $('.example').dataTable({
                "bJQueryUI" : true,
                "sScrollY": "300px",
                "sPaginationType" : "full_numbers",
                "iDisplayLength" : 25,
                "aaSorting" : [],
                "bSort" : true,
                "sDom": '<"H"Tfr>t<"F"ip>',
                "oTableTools": {
                    "aButtons": [
                        {
                            "sExtends": "print",
                            "sButtonText": "Print Table"
                        },
                        {
                            "sExtends": "pdf",
                            "sButtonText": "Export As Pdf"
                        },
                        {
                            "sExtends": "xls",
                            "sButtonText": "Export As Excel"
                        }
                    ]
                }

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

            $(".patient_visit").popover({

                placement : 'top',
                animation : true

            });

        });
            
        function showConType(id){
            var show = document.getElementById(id);
            //var shows = document.getElementById("nhis");
            //if(show.style.display == "block"){
            show.style.display="block";
            //}else{
                
            //  } if(show.style.display == "none"){ 
            // shows.style.display="none";
        }

        function getContype(){
            var show = document.getElementById("ty").value
            document.getElementById("contype").value = show;
            var t = document.getElementById("contype").value;
            
            
            //alert(t);
        }
        function getType(i,d){
            var show = document.getElementById(i).value
            document.getElementById(d).value = show;
            var t = document.getElementById("contype").value;
            
            
        }
    </script>
    <% if (list != null) {
            for (int i = 0;
                    i < list.size();
                    i++) {
                Patient vst = (Patient) list.get(i);
    %>


    <script type="text/javascript">
   
                      
        $("#<%= vst.getPatientid()%>_dialog").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
    
   
    
        $("#<%= vst.getPatientid()%>_patientidlink").click(function(){
      
            $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
        })    
   
        $("#<%= vst.getPatientid()%>_dialog").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
   
    
    </script>



    <% }
        }%>

</body>
</html>
