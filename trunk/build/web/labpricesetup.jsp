<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            List investigations = mgr.listInvestigation();
            //String patientid = request.getParameter("patientid")== null ? "" : request.getParameter("patientid");
            try {
            } catch (Exception e) {
                session.setAttribute("lasterror", "patient does not exist please try again");
                response.sendRedirect("index.jsp");
            }
            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            //LabPatient patient = mgr.getLabPatientByID(patientid);

            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);


            List sponsors = mgr.listSponsors();

        %>


    </head>

    <body style="overflow-x: none;" data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <%@include file="widgets/header.jsp" %> 

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="labreception.jsp">Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">All Laboratory Patients</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert  <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; position: static; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px; " class="span9 thumbnail well content">
                            <!--        <ul style="margin-left: 0px;" class="breadcrumb">
                                        <li style=" font-size: 14px; font-weight: bold">
                                            <a>All LabPatients</a>
                                        </li>
                                    </ul>  -->
                            <form action="action/additemprice.jsp" method="post">
                                <table class="example display">
                                    <thead>
                                        <tr>
                                            <th>

                                            </th>

                                            <%
                                                if (sponsors != null) {
                                                    for (int i = 0; i < sponsors.size(); i++) {
                                                        Sponsorship sponsor = (Sponsorship) sponsors.get(i);
                                            %>

                                            <th style="text-transform: capitalize; color: black">
                                                <%=sponsor.getSponsorname().toLowerCase()%>
                                            </th>

                                            <%  }
                                                }%>

                                        </tr>

                                    </thead>
                                    <tbody>
                                        <% for (int r = 0; r < investigations.size(); r++) {


                                                Investigation investigation = (Investigation) investigations.get(r);
                                                if (investigation.getRate() > 0) {
                                        %>
                                        <tr>
                                            <td style="text-transform: capitalize;  font-size: 14px;"> 
                                                <%=investigation.getName().toLowerCase()%> 
                                            </td>
                                            <%
                                                if (sponsors != null) {
                                                    for (int i = 0; i < sponsors.size(); i++) {
                                                        Sponsorship sponsor = (Sponsorship) sponsors.get(i);
                                                        List prices = mgr.listItemPriceList(investigation.getDetailedInvId(), sponsor.getSponshorshipid());
                                                        SponsorLabitemPrice labitemPrice = null;
                                                        double price = 0;
                                                        // if
                                                        labitemPrice = prices == null || prices.size() < 1 ? null : (SponsorLabitemPrice) prices.get(0);
                                                        price = labitemPrice == null ? investigation.getRate() : labitemPrice.getPrice();

                                            %>
                                            <td style="text-align: right;">
                                                <input type="hidden" name="sponsor_id[]" value="<%= sponsor.getSponshorshipid()%>" />
                                                <input type="hidden" name="labitems[]" value="<%= investigation.getDetailedInvId()%>" />
                                                <input type="text" name="price[]" class="input-mini" value="<%=df.format(price)%>"/>
                                            </td>

                                            <% }
                                                }%>
                                        </tr>
                                        <%

                                                }
                                            }%>
                                        <tr>



                                            <%  for (int i = 0; i < sponsors.size(); i++) {%>
                                            <td>


                                            </td>

                                            <% }%> 
                                            <td>

                                            </td>



                                        </tr>
                                    </tbody>
                                </table>
                                <button class="btn btn-block btn-danger pull-right" type="submit" name="action" value="addpriceitem">
                                    <i class="icon-white icon-check"></i>  Save Prices
                                </button>
                            </form>
                        </div>

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
                
                for (i = new Date().getFullYear(); i > 1900; i--)
                {                       
                    $('#year').append($('<option />').val(i).html(i));
                }

            });

        </script>

        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                var oTable = $('.example').dataTable({
                   
                    "sScrollY": "500px",
                    "sScrollX": "400px",
                    "sScrollXInner": "150%",
                    "bScrollCollapse": true,
                    "bPaginate": false,
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
                new FixedColumns( oTable );
                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
                $('#country').selectToAutocomplete();
                
                
                
                
                
                

            });
        
            function showMembershipbox(){
                var show = document.getElementById("privateid");
                var shows = document.getElementById("nhis");
               
                show.style.display="block";
                shows.style.display="none";
                
            }
            function showInsurance(){
                var show = document.getElementById("nhis");
                var shows = document.getElementById("privateid");
               
                show.style.display="block";
                shows.style.display="none";
                
            }
            function hideIt(){
                var show = document.getElementById("privateid");
                var shows = document.getElementById("nhis");
                //if(show.style.display == "block"){
                show.style.display="none";
                //}else{
                
                //  } if(show.style.display == "none"){ 
                shows.style.display="none";
            }
            
            function showConType(id){
                var show = document.getElementById(id);
                //var shows = document.getElementById("nhis");
                //if(show.style.display == "block"){
                show.style.display="block";
                //}else{
                
                //  } if(show.style.display == "none"){ 
                // shows.style.display="none";
            }

        </script>



    </body>
</html>
