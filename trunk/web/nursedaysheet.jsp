<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>


<%@page import="javax.xml.crypto.dsig.keyinfo.PGPData"%>
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
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateUtilDate = new java.util.Date();
            java.sql.Date dateSqlDate = null;

            SimpleDateFormat rangeformatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date rangeUtilDate = new java.util.Date();
            java.sql.Date rangeSqlDate = null;

            HMSHelper mgr = new HMSHelper();
            String displayedDate = mgr.getQueryDate();
            List visits = null;

            String dateValue = "";
            String dateRange = "";
            String splittedDateDuration[] = new String[2];
            String[] splittedDate = new String[3];
            String[] splittedDateRange = new String[3];



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
            } else {
                displayedDate = displayedDate.replace("/", "-");
                splittedDate = displayedDate.split("-");
                displayedDate = splittedDate[2].trim() + "-" + splittedDate[0].trim() + "-" + splittedDate[1].trim();
                dateUtilDate = dateformatter.parse(displayedDate);
                dateSqlDate = new java.sql.Date(dateUtilDate.getTime());

                visits = mgr.listRecentVisits(displayedDate);
            }

            System.out.print("dateValue : " + dateValue);
            System.out.print("displayedDate : " + displayedDate);
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
                            <a href="#">Nurses Station</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Nurses Day Sheet</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="display: none;" class="span8 thumbnail main-c">
                        <form action="anballpatientsrevenues.jsp" method="post">
                            <ul style="margin-left: 0px; padding-bottom: 20px;"  class="breadcrumb ">
                                <li style="margin-top: 10px;">
                                    <a>Nurses Day Sheet | <%=displayedDate%> </a>
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
                                    <th>#</th>
                                    <th>Time</th>
                                    <th>Folder #</th>
                                    <th>Patient Name</th>
                                    <th>Sex | Age</th>
                                    <th>Payment Type</th>
                                    <th>Nurse</th>
                                    <th>Doctor</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    System.out.println("entereddddd");
                                    // get all visits for today

                                    System.out.println("formatter displayedDate : " + displayedDate);

                                    Visitationtable vks = null;
                                    Sponsorhipdetails sD = null;
                                    List results, vitalsResults;
                                    int visId, counter = 0;
                                    String patientId = "", pName = "", doB = "", age = "", vTime = "";
                                    String[] splittedTime = new String[2];
                                    Patient p = null;
                                    NursingtableVitals nV = null;

                                    if (!visits.isEmpty()) {

                                        for (int i = 0; i < visits.size(); i++) {
                                            counter += 1;
                                            vks = (Visitationtable) visits.get(i);
                                            visId = vks.getVisitid();
                                            patientId = vks.getPatientid();

                                            p = mgr.getPatientByID(patientId);
                                            pName = p.getFname() + " " + p.getMidname() + " " + p.getLname();
                                            doB = p.getDateofbirth() + "";
                                            age = mgr.getAgeDifference(doB);

                                            results = mgr.getPatientSponsor(patientId);
                                            sD = (Sponsorhipdetails) results.get(0);

                                            vitalsResults = mgr.getNursingVitalsInfo(visId);
                                            nV = (NursingtableVitals) vitalsResults.get(0);

                                            vTime = nV.getTime() + "";
                                            splittedTime = vTime.split(" ");
                                            vTime = splittedTime[1];

                                %>

                                <tr>
                                    <td><%=counter%></td>
                                    <td><%=vTime%></td>
                                    <td><%=patientId%></td>
                                    <td><%=pName%></td>
                                    <td><%=p.getGender()%> | <%=age%></td>
                                    <td><%=sD.getType()%></td>
                                    <td>Dr. McSey</td>
                                    <td>Dr. McSey</td>
                                </tr>
                                <%                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div> 

                    <div class="clear"></div>



                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



        <%@include file="widgets/javascripts.jsp" %>
        <script type="text/javascript">
                   
            $("#rangeA").daterangepicker();

        </script>


    </body>
</html>



</body>
</html>
