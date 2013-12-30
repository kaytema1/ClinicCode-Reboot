<%-- 
  Document   : registrationaction
  Created on : Mar 30, 2012, 11:22:44 PM
  Author     : Arnold Isaac McSey
--%>


<%@page import="java.text.DecimalFormat"%>
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
             SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
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
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="#">Reports</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Patient Revenues </a><span class="divider"></span>
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
                        <form action="anballpatientsrevenues.jsp" method="post">
                            <ul style="margin-left: 0px; padding-bottom: 20px;"  class="breadcrumb ">
                                <li style="margin-top: 10px;">
                                    <a>Patient Revenues | <%=displayedDate%> </a>
                                </li>
                                <li class="pull-right" style="margin-top: 0px; margin-left: 5px;">
                                    <button type="submit" class="btn btn-inverse">
                                        <i class="icon icon-white icon-search"></i> Display
                                    </button>
                                </li>
                                <li class="pull-right" >
                                    <input name="daterange" placeholder="Select Date Range"  id="rangeA" type="text" class="input-large"  />
                                </li>
                            </ul>
                        </form>
                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Folder Number </th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Consultation</th>
                                    <th style="text-align: left;">Laboratory</th>
                                    <th style="text-align: left;">Dispensary</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    int regConsultation = 20;
                                    double patientConsultation = 0;


                                    //       List visits = mgr.listVisitations();
                                    List patients = mgr.listPatients();
                                    List patientVisits = null;
                                    int patientVisitsNum;
                                    String patientId;
                                    String patientName;

                                    Random registration = new Random();
                                    int regNum = 0;

                                    for (int i = 0; i < patients.size(); i++) {
                                        Patient patient = (Patient) patients.get(i);
                                        patientId = patient.getPatientid();
                                        patientName = patient.getFname() +" "+ patient.getMidname()+ "  " + patient.getLname();

                                        if (correctDateFound) {
                                            if (singleDateValue) {
                                                patientVisits = mgr.patientHistoryForDate(patientId, dateSqlDate);
                                            } else {
                                                patientVisits = mgr.patientHistoryForDateDuration(patientId, dateSqlDate, rangeSqlDate);
                                            }
                                        } else {
                                            patientVisits = mgr.patientHistory(patientId);
                                        }



                                        patientVisitsNum = patientVisits.size();




                                        regNum = registration.nextInt(regConsultation);
                                        regNum += 15;



                                        patientConsultation = regNum * patientVisitsNum;

                                        Patientconsultation pC;
                                        double cTCost, totalCTCost = 0;
                                        int visitTypeId;
                                        //     List patientInvs;
                                        Visitationtable vTC;
                                        Consultation cT;
                                        for (int j = 0; j < patientVisits.size(); j++) {
                                            vTC = (Visitationtable) patientVisits.get(j);
                                            visitTypeId = vTC.getVisittype();

                                            cT = mgr.getConsultationId(visitTypeId);
                                            if (cT != null) {
                                                cTCost = cT.getAmount();

                                                totalCTCost += cTCost;
                                            }

                                        }




                                        Investigation inv;
                                        double invCost, invPrice, totalInvCost = 0;
                                        int invId, invQty, visitId;
                                        List patientInvs;
                                        Visitationtable vT;
                                        Patientinvestigation pT;
                                        for (int j = 0; j < patientVisits.size(); j++) {
                                            vT = (Visitationtable) patientVisits.get(j);
                                            visitId = vT.getVisitid();

                                            patientInvs = mgr.patientInvestigation(visitId);

                                            for (int t = 0; t < patientInvs.size(); t++) {
                                                pT = (Patientinvestigation) patientInvs.get(t);
                                                invId = pT.getInvestigationid();
                                                invQty = pT.getQuantity();

                                                inv = mgr.getInvestigation(invId);
                                                if (inv != null) {
                                                    invPrice = inv.getRate();
                                                    invCost = invPrice * invQty;

                                                    totalInvCost += invCost;
                                                }
                                            }
                                        }

                                        Treatment trtmnt;
                                        double treatCost, treatPrice, totalTreatCost = 0;
                                        String treatId; int treatQty;
                                        List patientTreats;
                                        Patienttreatment patTreat;
                                        for (int j = 0; j < patientVisits.size(); j++) {
                                            vT = (Visitationtable) patientVisits.get(j);
                                            visitId = vT.getVisitid();

                                            patientTreats = mgr.patientTreatment(visitId);

                                            for (int t = 0; t < patientTreats.size(); t++) {
                                                patTreat = (Patienttreatment) patientTreats.get(t);
                                                treatId = patTreat.getTreatmentid();
                                                treatQty = patTreat.getQuantity();

                                                trtmnt = mgr.getTreatment(treatId);
                                                treatPrice = trtmnt.getPrice();
                                                treatCost = treatPrice * treatQty;

                                                totalTreatCost += treatCost;
                                            }
                                        }

                                        double patientTotals = totalCTCost + totalInvCost + totalTreatCost;

                                %>

                                <tr>
                                    <td style="line-height: 25px; text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(patientId).getFname()%> <%=mgr.getPatientByID(patientId).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(patientId).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(patientId).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(patientId).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()) == null ? mgr.sponsorshipDetails(patientId).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patientId).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(patientId).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(patientId).getBenefitplan()%> </td> </tr>  </table> "><%=patientId%> </td>
                                    <td><%=patientName%></td>
                                    <td style="text-align: right; padding-right: 15px;"> <%=df.format(totalCTCost)%></td>
                                    <td style="text-align: right; padding-right: 15px;"><%=df.format(totalInvCost)%></td>
                                    <td style="text-align: right; padding-right: 15px;"><%=df.format(totalTreatCost)%></td>
                                    <td style="text-align: right; padding-right: 15px;"><%=df.format(patientTotals)%></td>
                                </tr>
                                <% }

                                %>
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
