<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            HMSHelper mgr = new HMSHelper();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            //     List patients = mgr.listLabPatients();
            //     System.out.print("patients.size : " + patients.size());

            // List to keep track of patients who made orders for specified date ( range )
            List<LabPatient> orderPatients = new ArrayList<LabPatient>();
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


            List orders = null;


            boolean correctDateFound = false;
            boolean singleDateValue = true;
            SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateUtilDate = new java.util.Date();
            java.sql.Date dateSqlDate = null;


            SimpleDateFormat rangeformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date rangeUtilDate = new java.util.Date();
            java.sql.Date rangeSqlDate = null;

            String displayedDate = "";
            String dateValue = "";
            String dateRange = "";
            String splittedDateDuration[] = new String[2];
            String[] splittedDate = new String[3];
            String[] splittedDateRange = new String[3];

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

            if (correctDateFound) {
                if (singleDateValue) {
                    System.out.println("very single");
                    System.out.println(" dateValue : " + dateValue);
                    orders = mgr.listLabordersForDate(dateSqlDate);
                } else {
                    System.out.println("not very single");
                    orders = mgr.listLabordersForDuration(dateSqlDate, rangeSqlDate);
                }
            } else {
                orders = mgr.listLaborders();
            }


            System.out.print("dateValue : " + dateValue);
            System.out.print("orders.size : " + orders.size());




            ArrayList<Patient> arrayList = new ArrayList<Patient>();
            ArrayList<String> stringArrayList = new ArrayList<String>();
            if (orders != null) {
                for (int r = 0; r < orders.size(); r++) {
                    Laborders laborders = (Laborders) orders.get(r);
                    if (laborders.getPatientid().contains("DC") || laborders.getPatientid().contains("dc")) {
                        Patient patient = mgr.getPatientByID(laborders.getPatientid());

                        if (!arrayList.contains(patient)) {
                            arrayList.add(patient);
                        }
                    } else {
                        String patId = laborders.getPatientid();
                        System.out.println("PatId : " + patId);
                        LabPatient oPatient = mgr.getLabPatientByID(patId);
                        String oPatientId = oPatient.getPatientid().toLowerCase();
                        if (!stringArrayList.contains(oPatientId)) {
                            stringArrayList.add(oPatientId);
                            orderPatients.add(oPatient);
                        }
                    }
                }
            }

            // patients of selected date from clinic
            System.out.print("arrayList.size : " + arrayList.size());
            System.out.print("orderPatients.size : " + orderPatients.size());
        %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

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
                            <a href="labreception.jsp">Laboratory Reception</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Laboratory Patient History Report </a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 ">

                        <div style="padding-bottom: 80px; " class="span9 thumbnail well content hide">
                            <form action="labpatienthistory.jsp" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Laboratory Patient History | <%=displayedDate%></a>
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
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th> Patient Number </th>
                                        <th> Patient Name</th>
                                        <th> Payment Type </th>
                                        <th> Date of Birth </th>
                                        <th> Date of Registration</th>
                                        <th></th>
                                        <!-- <th></th>  -->
                                    </tr>
                                </thead>
                                <tbody>

                                    <% for (int r = 0; r < orderPatients.size(); r++) {
                                            LabPatient patient = (LabPatient) orderPatients.get(r);

                                            System.out.println("pat id : " + patient.getFname());

                                    %>
                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%=patient.getFname()%> <%=patient.getLname()%></h5> <h5><b> Date of Birth :</b>  <%=formatter.format(patient.getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=patient.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=patient.getEmployer()%> </td>  </tr> 
                                            </table> "><%=patient.getPatientid()%>
                                        </td>

                                    <td><%=patient.getFname() + " " + patient.getMidname() + " " + patient.getLname()%></td>
                                        <td><%= mgr.sponsorshipDetails(patient.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(patient.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(patient.getPatientid()).getSponsorid()).getSponsorname()%></td>

                                        <td><%=formatter.format(patient.getDateofbirth())%></td>


                                        <td><%=formatter.format(patient.getDateofregistration())%></td>
                                        <td><a class="btn btn-info" href="labpatienthistorydetails.jsp?patientid=<%=patient.getPatientid()%>&singledate=<%=dateValue %>&enddate=<%=rangeSqlDate %>">Details</a></td>
                          
                                    </tr>

                                    <% }%>


                                    <% if (arrayList != null) {
                                            for (int v = 0; v < arrayList.size(); v++) {
                                                Patient pat = (Patient) arrayList.get(v);

                                    %>
                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <%=pat.getFname()%> <%=pat.getLname()%></h5> <h5><b> Date of Birth :</b>  <%=formatter.format(pat.getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=pat.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=pat.getEmployer()%> </td>  </tr> 
                                            </table> "><a href="patientprevious.jsp?patientid=<%=pat.getPatientid()%>"><a href="patientprevious.jsp?patinetid=<%=pat.getPatientid()%>"><%=pat.getPatientid()%></a></td>
                                        <td><%=pat.getFname() + " " + pat.getMidname() + " " + pat.getLname()%></td>
                                        <td><%= mgr.sponsorshipDetails(pat.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(mgr.getLabPatientByID(pat.getPatientid()).getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(pat.getPatientid()).getSponsorid()).getSponsorname()%></td>

                                        <td><%=formatter.format(pat.getDateofbirth())%></td>


                                        <td><%=formatter.format(pat.getDateofregistration())%></td>
                                        <td><a class="btn btn-info" href="labpatienthistorydetails.jsp?patientid=<%=pat.getPatientid()%>&singledate=<%=dateValue %>&enddate=<%=rangeSqlDate %>">Details</a></td>
                                    </tr>
                                    <%}
                                        }%>


                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

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
        <!--    <script src="js/jquery-1.9.1.js"></script>  -->

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
