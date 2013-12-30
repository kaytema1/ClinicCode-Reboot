<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Random"%> 
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
            boolean correctDateFound = false;
            boolean singleDateValue = true;
            SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateUtilDate = new java.util.Date();
            java.sql.Date dateSqlDate = null;
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);

            SimpleDateFormat rangeformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date rangeUtilDate = new java.util.Date();
            java.sql.Date rangeSqlDate = null;

            String displayedDate = "";
            String dateValue = "";
            String dateRange = "";
            String splittedDateDuration[] = new String[2];
            String[] splittedDate = new String[3];
            String[] splittedDateRange = new String[3];
            HMSHelper mgr = new HMSHelper();
            System.out.println("telling");
            dateRange = request.getParameter("daterange");
            System.out.println("dateRange : " + dateRange);

            if (request.getParameter("daterange") != null) {
                dateValue = request.getParameter("daterange");
                displayedDate = dateValue;

                if (!dateValue.isEmpty()) {
                    correctDateFound = true;
                    if (dateValue.contains("-")) {
                        singleDateValue = false;

                        splittedDateDuration = dateValue.split("-");
                        dateValue = splittedDateDuration[0];
                        dateRange = splittedDateDuration[1];

                        dateRange = dateRange.replace("/", "-");
                        splittedDateRange = dateRange.split("-");
                        dateRange = splittedDateRange[2].trim() + "-" + splittedDateRange[0].trim() + "-" + splittedDateRange[1].trim();

                        rangeUtilDate = rangeformatter.parse(dateRange);
                        rangeSqlDate = new java.sql.Date(rangeUtilDate.getTime());
                    } else {
                        singleDateValue = true;
                    }
                    dateValue = dateValue.replace("/", "-");
                    splittedDate = dateValue.split("-");
                    dateValue = splittedDate[2].trim() + "-" + splittedDate[0].trim() + "-" + splittedDate[1].trim();
                    dateUtilDate = dateformatter.parse(dateValue);
                    dateSqlDate = new java.sql.Date(dateUtilDate.getTime());
                }
            }

            System.out.print("dateValue : " + dateValue);
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
                            <a href="#">Reports</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Departmental Revenue Summary </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="span9 offset3 thumbnail well content hide">
                        <form action="anballdepartments.jsp" method="post">
                            <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                <li style="margin-top: 10px;">
                                    <a> Departmental Revenue Summary | <%=displayedDate%></a>
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
                        <table class="example display table">
                            <thead>

                                <tr>
                                    <th style="text-align: left;">Department</th>
                                    <th style="text-align: left;">Expected Revenue</th>
                                    <th style="text-align: left;">Actual Revenue</th>
                                    <!--       <th>Registered On</th>
                                         <th> </th>
                                    -->
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    List allPTreatments = null;
                                    List allPInvs = null;
                                    List allPCons = null;

                                    if (correctDateFound) {
                                        if (singleDateValue) {
                                            System.out.println("very single");
                                            System.out.println(" dateValue : " + dateValue);
                                            allPTreatments = mgr.listAllPatientTreatmentsForDate(dateSqlDate);
                                        } else {
                                            System.out.println("not very single");
                                            allPTreatments = mgr.listAllPatientTreatmentsForDuration(dateSqlDate, rangeSqlDate);
                                        }
                                    } else {
                                        allPTreatments = mgr.listAllPatientTreatments();
                                    }

                                    System.out.println(" allPTreatments : " + allPTreatments.size());

                                    Treatment treatment;
                                    double treatmentCost, treatmentPrice, totalTreatmentCost = 0, amountPaid, totAmountPaid = 0;
                                    String treatmentId;
                                    int qty;
                                    for (int i = 0; i < allPTreatments.size(); i++) {
                                        Patienttreatment pT = (Patienttreatment) allPTreatments.get(i);
                                        treatmentId = pT.getTreatmentid();
                                        qty = pT.getQuantity();

                                        amountPaid = pT.getAmounpaid();
                                        totAmountPaid += amountPaid;

                                        treatment = mgr.getTreatment(treatmentId);
                                        treatmentPrice = treatment.getPrice();
                                        treatmentCost = treatmentPrice * qty;

                                        totalTreatmentCost += treatmentCost;
                                    }

                                    if (correctDateFound) {
                                        if (singleDateValue) {
                                            System.out.println("very single");
                                            System.out.println(" dateValue : " + dateValue);
                                            allPInvs = mgr.listAllPatientInvestigationForDate(dateSqlDate);
                                        } else {
                                            System.out.println("not very single");
                                            allPInvs = mgr.listAllPatientInvestigationForDuration(dateSqlDate, rangeSqlDate);
                                        }
                                    } else {
                                        allPInvs = mgr.listAllPatientInvestigation();
                                    }


                                    System.out.println(" allPInvs : " + allPInvs.size());
                                    Investigation inv;
                                    Laborders lbo = null;
                                    double invCost, invPrice, totalInvCost = 0, invAmntPaid, totInvAmntPaid = 0;
                                    int invId, invQty, visitIdd;
                                    List invList;
                                    for (int i = 0; i < allPInvs.size(); i++) {
                                        Patientinvestigation pT = (Patientinvestigation) allPInvs.get(i);

                                        invId = pT.getInvestigationid();
                                        invQty = pT.getQuantity();

                                        invAmntPaid = pT.getAmountpaid();
                                        totInvAmntPaid += invAmntPaid;


                                        //      visitIdd = pT.getVisitationid();
                                        //       invList = mgr.getNursingVitalsInfo(visitIdd);

                                        inv = mgr.getInvestigation(invId);
                                        if (inv != null) {
                                            invPrice = inv.getRate();
                                            invCost = invPrice * invQty;

                                            totalInvCost += invCost;
                                        }
                                    }

                                    if (correctDateFound) {
                                        if (singleDateValue) {
                                            System.out.println("very single");
                                            System.out.println(" dateValue : " + dateValue);
                                            allPCons = mgr.listAllPatientVisitsForDate(dateSqlDate);
                                        } else {
                                            System.out.println("not very single");
                                            allPCons = mgr.listAllPatientVisitsForDuration(dateSqlDate, rangeSqlDate);
                                        }
                                    } else {
                                        allPCons = mgr.listAllPatientVisits();
                                    }


                                    System.out.println(" allPCons : " + allPCons.size());
                                    Visitationtable vTable;
                                    List patientVisit = null;
                                    int visitId = 0;
                                    Patientconsultation pCon = null;
                                    Consultation con = null;

                                    double conPrice, totalConCost = 0, conExpected, conTotExpected = 0;

                                    for (int i = 0; i < allPCons.size(); i++) {
                                        Visitationtable pT = (Visitationtable) allPCons.get(i);
                                        visitId = pT.getVisitid();

                                        patientVisit = mgr.getPatientConsultationByVisitid(visitId);
                                        //  System.out.println("size : " + patientVisit.size());

                                        if (!patientVisit.isEmpty() && patientVisit != null) {
                                            System.out.println("size : " + patientVisit.size());

                                            for (int j = 0; j < patientVisit.size(); j++) {
                                                pCon = (Patientconsultation) patientVisit.get(j);

                                                con = mgr.getConsultationId(pCon.getTypeid());
                                                conExpected = con.getAmount();
                                                conTotExpected += conExpected;

                                                conPrice = pCon.getAmountpaid();
                                                totalConCost += conPrice;
                                            }
                                        }

                                    }

                                    List allPReg = mgr.listAllPatientRegs();
                                    int sizeOfReg = allPReg.size();
                                    double regg = sizeOfReg * 15;


                                %>
                                <tr>
                                    <td style="line-height: 25px; font-weight: bold; font-size: 15px;"><a href="#">Registration</a> </td> <td style="text-align: right; padding-right: 10px;"><%=df.format(regg)%></td> <td style="text-align: right; padding-right: 10px;"><%=df.format(regg)%></td>
                                </tr>
                                <tr>
                                    <td style="line-height: 25px; font-weight: bold; font-size: 15px;"> <a href="#">Consultation</a> </td> <td style="text-align: right; padding-right: 10px;"><%=df.format(conTotExpected)%></td> <td style="text-align: right; padding-right: 10px;"><%=df.format(totalConCost)%></td>
                                </tr>
                                <tr>
                                    <td style="line-height: 25px; font-weight: bold; font-size: 15px;"> <a href="#">Dispensary </a> </td> <td style="text-align: right ;padding-right: 10px;"><%=df.format(totalTreatmentCost)%></td> <td style="text-align: right; padding-right: 10px;"><%=df.format(totAmountPaid)%></td>
                                </tr>
                                <tr>
                                    <td style="line-height: 25px; font-weight: bold; font-size: 15px;"> <a href="#">Laboratory </a> </td> <td style="text-align: right; padding-right: 10px;"><%=df.format(totalInvCost)%></td> <td style="text-align: right; padding-right: 10px;"><%=df.format(totInvAmntPaid)%></td>
                                </tr>

                            </tbody>
                        </table>
                    </div> 

                    <div class="clear"></div>



                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



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
             
                //$(".numeric").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
                //$('.decimal').live("keyup",function(){inputControl($(this),'float');});
                //$('.text_input').filter_input({regex:'[a-zA-Z]'});
                $(".menu").fadeIn();
                $(".content").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $(".alert").fadeIn();
                $(".progress1").hide();
               // 
        
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
                    "sScrollY": "300px",
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "aButtons": [
                            
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



</body>
</html>
