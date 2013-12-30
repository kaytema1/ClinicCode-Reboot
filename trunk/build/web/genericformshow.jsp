
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="entities.Consultation"%>
<%@page import="entities.Treatments"%>
<%@page import="entities.Patienttreatment"%>
<%@page import="entities.Investigation"%>
<%@page import="entities.Patientinvestigation"%>
<%@page import="entities.Diagnosis"%>
<%@page import="entities.Patientdiagnosis"%>
<%@page import="java.util.List"%>
<%@page import="entities.Sponsorhipdetails"%>
<%@page import="entities.Visitationtable"%>
<%@page import="entities.Patient"%>
<%@page import="entities.HMSHelper"%>
<%@page import="entities.Users"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>ClaimSync EMR </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <%
            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }

            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            String patientId = request.getParameter("id") == null ? "" : request.getParameter("id");
            String visitId = request.getParameter("sid") == null ? "" : request.getParameter("sid");

            System.out.println("patientId : " + patientId + "visitId : " + visitId);

            //   if(patientId.isEmpty() || visitId.isEmpty()) {
            //       response.sendRedirect("account_search.jsp");
            //   }

            HMSHelper mgr = new HMSHelper();
            Patient p = null;
            Visitationtable visit = null;
            try {
                p = mgr.getPatientByID(patientId);
                visit = mgr.getVisitById(Integer.parseInt(visitId));
            } catch (NumberFormatException e) {
                session.setAttribute("lasterror", "There is an error please try again");
                response.sendRedirect("accounts.jsp");
            }

        %>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <link href="css/docs.css" rel="stylesheet">
        <link rel="stylesheet" href="css/styles.css">
        <style type="text/css" title="currentStyle">
            @import "css/jquery.dataTables_themeroller.css";
            @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
        </style>
        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="third-party/jQuery-UI-Date-Range-Picker/css/ui.daterangepicker.css" media="screen" rel="Stylesheet" type="text/css" />

        <!--Load the AJAX API-->

        <style type="text/css" >
            body {

            }

            #chart_div {
                z-index: 100
            }
            .center {
                text-align: center;

            }

            .modal-header {
                background-color: #FBFBFB;
                background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
                background-repeat: repeat-x;
                border: 1px solid #DDDDDD;
                border-radius: 3px 3px 3px 3px;
                box-shadow: 0 1px 0 #FFFFFF inset;
            }
            input {
                height: 25px;
                font-size: 14px !important;
                color: #4183C4  !important;
                text-transform: capitalize
            }

            /* select	 {
                    height: 25px;
                    font-size: 20px !important;
                    color: #4183C4  !important;
            }
            */


        </style>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li >
                            <a class="accept" href="account_search.jsp"> Patient Bills</a>
                        </li>
                        <li class="active">
                            <a class="accept" href="#"> View Claim</a>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section  class="hide container-fluid" style="margin-top: -30px; " id="dashboard">

                <!-- Headings & Paragraph Copy -->
                

                    <div class="span" style="width: 97%" >
                        <ul class="breadcrumb">
                            <li>
                                <a href="#">PATIENT </a>
                            </li>
                            <li class="pull-right">
                                <i class="icon icon-chevron-right"> </i>
                            </li>
                        </ul>

                    </div>
                    <%  if (p != null) {%>
                    <div class="offset8 span3">
                        <input style="height: 40px;" type="text" class="input input-xlarge center date" 
                               placeholder="DATE OF ATTENDANCE" value="<%=formatter.format(visit.getDate())%>" />
                        <br />
                        <br />
                        <div class="center">
                            PATIENT FOLDER NUMBER
                        </div>
                        <input style="text-transform: uppercase;" class="center input-xlarge" type="text" value="<%=p.getPatientid()%>" />
                    </div>

                    <div class="clearfix">

                    </div>
                    <div class="span12">
                        PATIENT NAME
                    </div>
                    <div class="clearfix">

                    </div>
                    <div class="span4">
                        <input class="input-xlarge" type="text" value="<%=p.getLname()%>"/>
                        <br/>
                        SURNAME
                    </div>
                    <div class="span4">
                        <input class="input-xlarge" type="text" value="<%=p.getFname()%> <%=p.getMidname()%>" />
                        <br/>
                        OTHER NAMES
                    </div>
                    <div class="span3 ">

                        <%
                            String employer = p.getEmployer();
                            if (employer.equalsIgnoreCase("N/A")) {
                                employer = "";
                            }
                        %>

                        <input class="input-xlarge" style="text-align: center" type="text" value="<%=employer%>" />
                        <br/>
                        <span style="text-align: left;"> COMPANY OR FIRM </span>
                    </div>

                    <div class="clearfix">

                    </div>
                    <hr />

                    <div class="clearfix">

                    </div>
                    <div class="span4">

                        <%

                            String memNum = "";
                            Sponsorhipdetails sp = mgr.sponsorshipDetails(p.getPatientid());

                            if (sp == null) {
                                memNum = "";
                            } else {
                                memNum = sp.getMembershipid();
                            }
                        %>

                        <input class="input-xlarge" type="text" value="<%=memNum%>"/>
                        <br/>
                        MEMBERSHIP NUMBER
                    </div>
                    <div class="span4">

                        <%
                            String telNum = p.getContact();
                            if (telNum.equalsIgnoreCase("N/A")) {
                                telNum = "";
                            }
                        %>

                        <input class="input-xlarge" type="text" value="<%=telNum%>" />
                        <br/>
                        PATIENT'S TELEPHONE NUMBER
                    </div>
                    <div class="span3 ">

                        <input class="input-mini" type="text" value="<%=p.getGender()%>" />


                        <input class="dob" style="margin-left:1px;width: 185px; text-align: center;" type="text" value="<%=formatter.format(p.getDateofbirth())%>" />
                        <br/>
                        <span style="text-align: left;"> SEX </span>
                        <span style="text-align: left; margin-left: 55px;"> DATE OF BIRTH </span>
                    </div>

                    <div class="clearfix">

                    </div>
                    <hr />

                    <div class="clearfix">

                    </div>
                    <div class="span4">

                        <%
                            String depNum = "";

                        %>

                        <input class="input-xlarge" type="text" value="<%=depNum%>" />
                        <br/>
                        DEPENDANT'S NUMBER
                    </div>
                    <div class="span4">
                        <input class="input-xlarge" type="text" />
                        <br/>
                        PATIENT'S SURNAME (if Different from member)
                    </div>
                    <div class="span3 ">
                        <input  class="input-	large" type="text"  />

                        <br/>
                        <span style="text-align: left;"> NHIS NO (CO-CARE) </span>

                    </div>

                    <div class="divider">

                    </div>

                    <div class="span" style="width: 97%" >
                        <br />
                        <br />
                        <ul class="breadcrumb">
                            <li>
                                <a href="#">SERVICE PROVIDER </a>
                            </li>
                            <li class="pull-right">
                                <i class="icon icon-chevron-right"> </i>
                            </li>
                        </ul>

                        <br />
                        <br />

                    </div>

                    <div class="clearfix">

                    </div>

                    <div class="span3">
                        <input class="input-xlarge" type="text" />
                        <br/>
                        NAME OF FACILITY
                    </div>
                    <div style="text-align: right;" class="span3">
                        <input class="input-large" type="text" />
                        <br/>
                        <span style="margin-left: -80px;"> CLINCIAN / ATTENDING OFFICER </span>
                    </div>
                    <div style="border:  1px solid #ccc; padding: 12px;" class="span">
                        <label class="radio inline">
                            <input type="radio" name="patientstate" id="inlineCheckbox1" value="option1">
                            IN-PATIENT </label>
                        <br />
                        <label class="radio inline">
                            <input type="radio" name="patientstate" id="inlineCheckbox2" value="option2">
                            OUT-PATIENT </label>

                    </div>
                    <div class="span4" style="text-align: right;">

                        <span style="text-align: left; padding-right: 20px;"> DETENTION DATE </span>
                        <input  class="input date" type="text"  />

                        <br/>
                        <span style="text-align: left;  padding-right: 20px;"> ADMISSION DATE </span>
                        <input  class="input date" type="text"  />

                        <br/>
                        <span style="text-align: left;  padding-right: 20px;"> DISCHARGE DATE </span>
                        <input  class="input date" type="text"  />

                        <br/>

                    </div>
                    <div class="span8" style="margin-left: 30px; margin-top: -55px;">
                        <label style="padding: 20px;" class="radio inline">
                            <input name="typeofservice" type="radio" id="inlineCheckbox1" value="option1"/>
                            MEDICAL 
                        </label>
                        <label style="padding: 20px;"  class="radio inline">
                            <input name="typeofservice" type="radio" id="inlineCheckbox2" value="option2"/>
                            OPTHALMOLOGY </label>
                        <label style="padding: 20px;" class="radio inline">
                            <input name="typeofservice" type="radio" id="inlineCheckbox1" value="option1"/>
                            RADIOLOGY </label>
                        <label  style="padding: 20px;" class="radio inline">
                            <input name="typeofservice" type="radio" id="inlineCheckbox2" value="option2"/>
                            PHARMACY </label>
                        <label style="padding: 20px;" class="radio inline">
                            <input name="typeofservice" type="radio" id="inlineCheckbox1" value="option1"/>
                            LABORATORY </label>
                        <label style="padding: 20px;" class="radio inline">
                            <input name="typeofservice" type="radio" id="inlineCheckbox2" value="option2">
                            OTHER </label>

                    </div>

                    <div class="clearfix">

                    </div>
                    <div class="span" style="width: 97%" >
                        <br />
                        <br />
                        <ul class="breadcrumb">
                            <li>
                                <a href="#">DIAGNOSIS </a>
                            </li>
                            <li class="pull-right">
                                <i class="icon icon-chevron-right"> </i>
                            </li>
                        </ul>

                        <br />
                        <br />

                    </div>

                    <%
                        List diagList = mgr.listPatientDiagnosisForVisit(p.getPatientid(), visit.getVisitid());
                        if (!diagList.isEmpty()) {



                    %>
                    <span style="font-size: 20px; color: #4183C4; line-height: 22px; padding-top: 2px;" class="span">
                        <% for (int diag_count = 1; diag_count <= diagList.size(); diag_count++) {
                        %>
                        <%=diag_count%>. <br /> <br />

                        <%  }

                        %>



                    </span>

                    <div class="span10">

                        <%


                            Patientdiagnosis pd;
                            int diagId;
                            Diagnosis d;
                            String diag = "";
                            System.out.println("diaglist : ldldldldldld " + diagList.size());
                            for (int i = 0; i < diagList.size(); i++) {
                                pd = (Patientdiagnosis) diagList.get(i);
                                diagId = pd.getDiagnosisid();
                                d = mgr.getDiagnosis(diagId);
                                diag = d.getDiagnosis();
                                System.out.println("didididid : " + diag);
                        %>
                        <input class="span10" type="text" value="<%=diag%>"/>
                        <br/>

                        <% }

                        %>
                    </div>
                    <%       }%>
                    <div class="span2">


                    </div>

                    <div class="clearfix">

                    </div>
                    <hr />
                    <div class="divider">

                    </div>

                    <div class="span" style="width: 95%" >
                        <br />
                        <br />
                        <ul class="breadcrumb">
                            <li>
                                <a href="#">INVESTIGATIONS & TREATMENTS</a>
                            </li>
                            <li class="pull-right">
                                <i class="icon icon-chevron-right"></i>
                            </li>

                        </ul>

                        <br />
                        <br />

                    </div>
                    <div class="clearfix">

                    </div>

                    <table style="width: 70%" class="table-striped table-bordered">
                        <thead>
                            <tr>
                                <th> DATE </th>
                                <th> DESCRIPTION </th>
                                <th>  <!--  <th style="font-size: 8px"> MED / DEN / LAB / PHA </th>  --> </th>
                             <!--   <th> FORM </th>  -->
                                <th  style="text-align: right;"> QTY </th>
                                <th  style="text-align: right;"> UNIT COST </th>

                                <th  style="text-align: right;"> TOTAL COST </th>
                            </tr>

                        </thead>
                        <tbody>

                            <%
                                Double totalAssociatedCost = 0.0;
                                int visitType = visit.getVisittype();
                                Consultation con = mgr.getConsultationId(visitType);
                                if (con != null) {
                                    double conP = 0;
                                    String c = con.getContype();

                                    conP = con.getAmount();
                                    totalAssociatedCost += conP;
                            %> 
                            <tr>
                                <td>
                                    <input class="input-small date" type="text" value="<%=formatter.format(visit.getDate())%>" />
                                </td>
                                <td colspan="4">
                                    <input class="input-xxlarge" style="width: 98%" type="text" value="CONSULTATION : <%=c%>" />
                                </td>
                                <!--     <td>
                                         <input type="text" class="input-medium" value="LAB"/>
     
                                     </td>
                                     <td>
                                         <input type="text" class="input-small"/>
                                     </td>
                                     <td>
                                         <input class="input-small" type="text" value="1" />
                                     </td>
                                     <td>
                                         <input class="input-small" type="text" value="%=pI.getAmountpaid() %>" />
                                     </td>  -->

                                <td>
                                    <input class="input-small" style="text-align: right;" type="text" value="<%=df.format(conP)%>"/>
                                </td>

                            </tr>
                            <%
                                    // totalAssociatedCost += inv.getTotalCost();

                                }%>


                            <%

                                List lList = mgr.listPatientLabForVisit(p.getPatientid(), visit.getVisitid());
                                System.out.println("lsldlkds : " + lList.size());
                                if (!lList.isEmpty()) {
                                    Patientinvestigation pI;
                                    int invId;
                                    Investigation inv;
                                    String investigation = "";
                                    double invP = 0, totalLabP = 0;

                                    for (int g = 0; g < lList.size(); g++) {
                                        pI = (Patientinvestigation) lList.get(g);
                                        invId = pI.getInvestigationid();
                                        inv = mgr.getInvestigation(invId);
                                        investigation = inv.getName();

                                        invP = pI.getPrice();

                                        totalLabP += invP;
                            %> 
                            <% if (invP > 0) {%>
                            <tr>
                                <td>
                                    <input class="input-small date" type="text" value="<%=formatter.format(pI.getDate())%>" />
                                </td>
                                <td>
                                    <input class="input-xxlarge" type="text" value="<%=investigation%>" />
                                </td>
                                <td>
                                    <input type="text" class="input-mini" value="LAB"/>

                                </td>
                             <!--   <td>
                                    <input type="text" class="input-small"/>
                                </td>  -->
                                <td>
                                    <input class="input-mini"  style="text-align: right;" type="text" value="1" />
                                </td>
                                <td>
                                    <input class="input-mini"  style="text-align: right;" type="text" value="<%=df.format(invP)%>" />
                                </td>
                                <td>
                                    <input class="input-small"  style="text-align: right;" type="text" value="<%=df.format(invP)%>"/>
                                </td>

                            </tr>

                            <% }%>
                            <%

                                    }
                                    totalAssociatedCost += totalLabP;
                                }%>


                            <%
                                //Double totalAssociatedCost = 0.0;
                                lList = mgr.listPatientTreatmentForVisit(p.getPatientid(), visit.getVisitid());
                                System.out.println("lsldlkds : " + lList.size());
                                if (!lList.isEmpty()) {
                                    Patienttreatment pT;
                                    int treatId;
                                    Treatments treat;
                                    String treatment = "";
                                    int qty;
                                    double price, totalCost = 0, totalTreatCost = 0;

                                    for (int g = 0; g < lList.size(); g++) {
                                        pT = (Patienttreatment) lList.get(g);
                                        treatId = pT.getTreatmentid();
                                        treat = mgr.getTreatment(treatId);
                                        treatment = treat.getTreatment();

                                        qty = pT.getQuantity();
                                        price = pT.getPrice();
                                        totalCost = qty * price;

                                        totalTreatCost += totalCost;
                            %> 
                            <tr>
                                <td>
                                    <input class="input-small date" type="text" value="<%=formatter.format(pT.getDate())%>" />
                                </td>
                                <td>
                                    <input class="input-xxlarge"  type="text" value="<%=treatment%>" />
                                </td>
                                <td>
                                    <input type="text" class="input-mini" value="PHA"/>

                                </td>
                               <!-- <td>
                                    <input type="text" class="input-small" value="<%--=pT.getType()--%>"/>
                                </td>  -->
                                <td>
                                    <input class="input-mini"  style="text-align: right;" type="text" value="<%=qty%>" />
                                </td>
                                <td>
                                    <input class="input-mini"  style="text-align: right;" type="text" value="<%=df.format(price)%>" />
                                </td>
                                <td>
                                    <input class="input-small"  style="text-align: right;" type="text" value="<%=df.format(totalCost)%>"/>
                                </td>

                            </tr>
                            <%
                                        // totalAssociatedCost += inv.getTotalCost();
                                    }
                                    totalAssociatedCost += totalTreatCost;
                                }%>





                            <tr>
                                <td colspan="4">
                                </td>

                                <td style="border: solid 1px black;"> AMOUNT DUE </td>
                                <td style="border: solid 1px black;">
                                    <input type="text"  style="text-align: right;" class="input-small" value="<%=df.format(totalAssociatedCost)%>"/>
                                </td>

                            </tr>
                        </tbody>

                    </table>

                    <div class="clearfix">

                    </div>

                    <hr />

                    <div class="span4">
                        <input placeholder="REFERRED TO" class="input-xlarge center" type="text" />

                    </div>
                    <div class="span4">
                        <input  placeholder="REMARKS" class="input-xlarge center" type="text" />

                    </div>
                    <div class="span3 ">
                        <input placeholder="DATE" value="<%=formatter.format(visit.getDate())%>"  class="input-large center date" type="text"  />

                    </div>

                
                <% }%>
            </section>

            <footer style="display: none;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

        </div><!-- /container-fluid -->

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

        <!--	<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

        <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
        <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

        <script type="text/javascript" src="js/tablecloth.js"></script>  -->
        <script type="text/javascript" src="js/genericformshow.js"></script>
        <!--initiate accordion-->
        <script type="text/javascript">
            $(function() {
                $("#dashboard").fadeIn();
                $(".menu").fadeIn();
                $(".content1").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $(".progress1").hide();
                $("input").attr("disabled","disabled")
                $("select").attr("disabled","disabled")
            });

        </script>

    </body>
</html>
