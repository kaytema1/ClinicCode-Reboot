<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    PaymentObject payment;
    DecimalFormat df = new DecimalFormat();

    df.setMinimumFractionDigits(2);
    double totalBill = 0.0;
    double totalAmountPaid = 0.0;
    double totalOustanding = 0.0;
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">
            <header  class="jumbotron subhead" id="overview">
                <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Outstanding Bill Payments </a><span class="divider"></span>
                        </li>
                    </ul>
                </div>
            </header>
            <%@include file="widgets/loading.jsp" %>
            <section id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="display: none;" class="span9 offset3 thumbnail well content hide">
                        <form action="" method="post">
                            <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                <li style="margin-top: 10px;">
                                    <a style="font-size: 15px;">Outstanding Bill Payments</a>
                                </li>
                                <li class="pull-right" style="margin-top: 7px; margin-left: 5px;">
                                    <button class="btn btn-inverse">
                                        <i class="icon icon-white icon-search"></i> Display
                                    </button>
                                </li>
                                <li class="pull-right">
                                    <input name="daterange" placeholder="Select Date Range" style="margin-top: 8px;" id="rangeA" type="text" class="input-large"  />
                                </li>
                            </ul>
                        </form>
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Laboratory Number </th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Requested on</th>
                                    <th style="text-align: left;">Total Bill</th>
                                    <th style="text-align: left;">Amount Paid</th>
                                    <th style="text-align: left;">Outstanding Bill</th>
                                    <th style="text-align: left;">Received By </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    //Patient p = (Patient)session.getAttribute("patient");
                                    //get current date time with Date()
                                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                                    Date date = new Date();
                                    
                                    //System.out.println(dateFormat.format(date));
                                    List outstandingPayments = mgr.listAllPaymentsMade();
                                    // List patients = mgr.listPatients();
                                    for (int i = 0; i < outstandingPayments.size(); i++) {
                                        payment = (PaymentObject) outstandingPayments.get(i);
                                        Laborders laborder  =  mgr.getLabOrdersByOrderId(payment.getTransactionId());
                                        totalBill = totalBill + laborder.getTotalAmount();
                                        totalAmountPaid = totalAmountPaid + payment.getTotalAmountPaid() ;
                                     if (payment.getTotalAmountPaid() > 0){   
                                %>

                                <tr>
                                    <%if (laborder.getPatientid().contains("c") || laborder.getPatientid().contains("C")) {%>

                                    <td style="line-height: 25px; text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getFname()%>, <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getMidname()%> <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : formatter.format(mgr.getPatientByID(laborder.getPatientid()).getDateofbirth())%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(laborder.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(laborder.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(laborder.getPatientid()) == null ? "" : mgr.sponsorshipDetails(laborder.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(laborder.getPatientid()) == null ? "" : mgr.sponsorshipDetails(laborder.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%=laborder.getOrderid()%> </a>   </td>
                                    <td><%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getFname()%>  <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getMidname()%> <%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : mgr.getPatientByID(laborder.getPatientid()).getLname()%> </td>
                                    <td><%=mgr.getPatientByID(laborder.getPatientid()) == null ? "" : formatter.format(laborder.getOrderdate())%> </td>
                                    <td style="text-align: right;"><%=df.format(laborder.getTotalAmount())%> </td>
                                    <td style="text-align: right;"><%= df.format(payment.getTotalAmountPaid())%> </td>
                                    <td style="text-align: right;"><%= df.format(laborder.getOutstanding())%> </td>
                                    <td style="text-align: right;"><%= mgr.getStafftableByid(laborder.getReceivedBy()).getOthername() %> </td>
                                    <%} else {%>

                                    <td style=" line-height: 25px; text-transform: uppercase;  font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getFname()%>, <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : formatter.format(mgr.getLabPatientByID(laborder.getPatientid()).getDateofbirth())%></h5> </span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Method </td> <td> <%=mgr.sponsorshipDetails(laborder.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(laborder.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                        <td> Membership Number </td> <td> <%=mgr.sponsorshipDetails(laborder.getPatientid()) == null ? "" : mgr.sponsorshipDetails(laborder.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(laborder.getPatientid()) == null ? "" : mgr.sponsorshipDetails(laborder.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <a href="#"> <%=laborder.getOrderid()%> </a> 
                                    </td>
                                    <td>
                                        <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getMidname()%> <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : mgr.getLabPatientByID(laborder.getPatientid()).getLname()%> 
                                    </td>
                                    <td>
                                        <%=mgr.getLabPatientByID(laborder.getPatientid()) == null ? "" : formatter.format(laborder.getOrderdate())%> 
                                    </td>
                                    <td style="text-align: right;">
                                        <%= df.format(laborder.getTotalAmount())%> 
                                    </td>
                                    <td style="text-align: right;">
                                        <%= df.format(payment.getTotalAmountPaid())%> 
                                    </td>
                                    <td style="text-align: right;">
                                        <%= df.format(laborder.getOutstanding())%> 
                                    </td>
                                    <td style="text-align: left;"> 
                                        <%= mgr.getStafftableByid(laborder.getReceivedBy()).getLastname() %> 
                                        <%= mgr.getStafftableByid(laborder.getReceivedBy()).getOthername() %> 
                                    </td>
                                    <%}%>

                                </tr>
                                <% } }

                                %>
                                
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td style="text-align: left; font-size: larger; line-height: 25px;"><b>TOTAL</b></td>
                                    <td></td>
                                    <td></td>
                                    
                                    <td style="text-align: right; font-size: larger;"><b><%=df.format(totalBill)%></b></td>
                                    <td style="text-align: right; font-size: larger;"><b><%=df.format(totalAmountPaid)%></b></td>
                                    <td style="text-align: right; font-size: larger;"></td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div> 

                    <div class="clear"></div>
                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



        <%@page import="entities.Vitalcheck"%>
        <%@page import="java.util.List"%>
        <%@page import="entities.ExtendedHMSHelper"%>
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript" charset="utf-8" src="js/jquery2.js"></script>
        <script type="text/javascript" charset="utf-8" src="js/jquery.dataTables2.js"></script>
        <script type="text/javascript" charset="utf-8" src="media/js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="media/js/TableTools.js"></script>

        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>

        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltip.js"></script>

        <script src="js/bootstrap-popover.js"></script>
        <script src="js/application.js"></script>  


        <script type="text/javascript" src="js/jquery-ui-1.10.2.custom.min.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script> 


        <script type="text/javascript">
    
    
            $(function() {
       
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();
             
                $(".menu").fadeIn();
                $(".content").fadeIn();
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

            $(document).ready(function() {
     
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "bPaginate" : false,
                    
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sScrollY" : 400,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "aButtons": [
                            {
                                "sExtends": "print",
                                "sButtonText": "Print Table"
                            },
                            
                            {
                                "sExtends": "pdf",
                                "sButtonText": "Export as PDF File"
                            },
                            {
                                "sExtends": "xls",
                                "sButtonText": "Export as Excel File"
                            }
                        ]
                    }
                });
        
                

                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
                $("#rangeA").daterangepicker();

                
            });
           
        </script>

    </body>

</html>