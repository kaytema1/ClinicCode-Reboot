<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Formatter"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>
        <% Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> lists = (ArrayList<Integer>) session.getAttribute("staffPermission");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);

        %>

        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>

        <%
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
            String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            Patient p = null;
            List list = null;
            Visitationtable vs = null;
            int lastVisitId = 0;

            try {
                
                if (searchid.equalsIgnoreCase("fullname")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert");
                        response.sendRedirect("account_search.jsp");
                        return;
                    }
                    list = mgr.getPatientByName(searchquery);
                    if(list == null || list.size() < 0  ){
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("account_search.jsp");
                    }

                }
                if (searchid.equalsIgnoreCase("patientid")) {
                    if (searchquery.equals("")) {
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("account_search.jsp");
                        return;
                    }
                    
                    p = mgr.getPatientByID(searchquery.trim());
                    if(p == null){
                        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                        session.setAttribute("class", "alert-error");
                        response.sendRedirect("account_search.jsp");
                    }

                }
              

                List visits = mgr.patientHistory(p.getPatientid());

                for (int r = 0; r < visits.size(); r++) {
                    vs = (Visitationtable) visits.get(r);
                    lastVisitId = vs.getVisitid();
                }
            } catch (Exception e) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("account_search.jsp");
                return;
            }


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
                            <a href="account_search.jsp">Patient Bill Search</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Bill Search Results</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>
            <%if (p != null) {%>
            <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <%if (session.getAttribute("lasterror") != null) {%>
                    <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                        <b> <%=session.getAttribute("lasterror")%>  </b>
                    </div>
                    <br/>
                    <div style="margin-bottom: 20px;" class="clearfix"></div>
                    <%session.removeAttribute("lasterror");
                            }%>

                    <div style="display: none;" class="span8 main-c thumbnail">



                        <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Folder Number</th>
                                    <th style="text-align: left;">Patient Name </th>
                                    <th style="text-align: left;">Payment Type</th>
                                    <th style="text-align: left;">Date of Birth</th>
                                    <th style="text-align: left;">Folder Location</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr class="odd gradeX">

                                    <td style="text-transform: uppercase; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b><%= p.getFname()%> <%= p.getMidname()%>  <%= p.getLname()%>  </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(p.getDateofbirth())%></h5> <span>"
                                        data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= p.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= p.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td>
                                        <%=  mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                        </table>">
                                        <a class="patientid"><%= p.getPatientid()%></a>
                                    </td>
                                    <td><%= p.getFname()%>  <%= p.getMidname()%> <%= p.getLname()%></td><td><%= mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></td><td>  <%= formatter.format(p.getDateofbirth())%> </td>
                                    <td style="text-transform: capitalize;"><%= mgr.getPatientFolder(p.getPatientid()).getStatus()%></td>
                                    <td>
                                        <div class="btn-group">
                                            <a class="btn dropdown-toggle btn-info btn-small" data-toggle="dropdown" href="#">
                                                Action
                                                <span class="caret"></span>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li> <a href="#" id="<%= p.getPatientid()%>_patientidlink"> Last Visit </a> </li>
                                                <li> <a href="#" id="<%= p.getPatientid()%>_patientidlink2"> Previous Visits </a> </li>
                                                <li> <a href="#" id="<%= p.getPatientid()%>_patientidlink3"> Billing History </a> </li>
                                            </ul>
                                        </div></td>
                                </tr>
                                


                            </tbody>
                        </table>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container --> 
        <div style="max-height: 600px; overflow-y: scroll; display: none;" id="<%= p.getPatientid()%>_dialog"  title="Patient Billing Summary">

            <span class="span4">
                <dl class="dl-horizontal">


                    <dt style="text-align: left;" >Patient ID:</dt>
                    <dd style="text-transform: uppercase;"><%= p.getPatientid()%></dd>
                    <dt style="text-align: left;" >Patient Name:</dt>
                    <dd><%= mgr.getPatientByID(p.getPatientid()).getFname()%>
                        <%= mgr.getPatientByID(p.getPatientid()).getMidname()%>
                        <%= mgr.getPatientByID(p.getPatientid()).getLname()%>
                    </dd>
                    <dt style="text-align: left;" >Sponsor:</dt>
                    <dd><%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%></dd>
                </dl>
            </span>
            <div class="clearfix">
            </div>    
            <div class="center thumbnail">
                <span style="font-weight: bolder;" class="lead"> <u> BILLING SUMMARY </u> </span>
                <br />
                <br />
                <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                    <li><b> Consultation  </b> </li>
                </ul>
                <table class="table">

                    <thead>
                        <tr>
                            <th style="color: #FFF; text-align: left;">Item</th>
                            <th style="color: #FFF; text-align: left;">Description</th>
                            <th style="color: #FFF; text-align: right; width: 40px;">Cost</th>
                            <th style="color: #FFF; text-align: right; width: 80px;">Amount Paid</th>
                            <th style="color: #FFF; text-align: right; width: 100px;">Balance Tendered</th>
                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td> Consultation Type </td>
                            <%
                                double itcost = 0.0;
                                double ttcost = 0.0;
                                int conTypeId = vs.getVisittype();

                                Consultation cs = mgr.getConsultationId(conTypeId);
                                String csType = cs.getContype();
                                double csCost = cs.getAmount();

                                Patientconsultation pc = (Patientconsultation) mgr.getPatientConsultationByVisitid(vs.getVisitid()).get(0);
                                System.out.println("amntPd : " + pc.getAmountpaid());

                                double amountPaid = pc.getAmountpaid();
                                double amountOutstanding = amountPaid - csCost;

                            %>
                            <td style="text-transform: capitalize;"><%=csType%></td>
                            <td style="text-align: right;"><%=df.format(csCost)%></td>
                            <td style="text-align: right;"><%=df.format(amountPaid)%></td>
                            <td style="text-align: right;"><%=df.format(amountOutstanding)%></td>
                        </tr>
                </table>


                <%
                    List pTreatments = mgr.getPatientTreatmentByVisitid(lastVisitId);

                    if (!pTreatments.isEmpty()) {%>

                <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                    <li>   <b> Dispensary  </b> </li>
                </ul>
                <table class="table">

                    <thead>
                        <tr>
                            <th style="color: #FFF; text-align: left;">Treatment Desc.</th>

                            <th style="color: #FFF;">Price</th>
                            <th style="color: #FFF;">Quantity</th>
                            <th style="color: #FFF;">Total</th>
                            <th style="color: #FFF;">Amount Paid</th>
                            <th style="color: #FFF;">Balance</th>
                        </tr>
                    </thead>

                    <%

                        Patienttreatment pT = null;
                        int treatmentId = 0;
                        Treatments treatment = null;
                        double qty = 0, price = 0, totalCost = 0, amntPaid = 0, balance = 0;
                        for (int u = 0; u < pTreatments.size(); u++) {
                            pT = (Patienttreatment) pTreatments.get(u);
                            treatmentId = pT.getTreatmentid();
                            treatment = mgr.getTreatment(treatmentId);

                            qty = pT.getQuantity();

                            price = pT.getPrice();
                            totalCost = qty * price;

                            amntPaid = pT.getAmounpaid();

                            balance = amntPaid - totalCost;
                    %>

                    <tr>
                        <td style="text-transform: capitalize"><%=treatment.getTreatment()%></td>


                        <td  style="text-align: right;"><%=df.format(price)%></td>
                        <td style="text-align: right;"><%=qty%></td>

                        <td style="text-align: right;"><%=df.format(totalCost)%></td>
                        <td style="text-align: right;"><%=df.format(amntPaid)%></td>
                        <td style="text-align: right;"><%=df.format(balance)%></td>
                    </tr>
                    <% ttcost = ttcost + amntPaid;
                            }
                        }
                    %>

                    </tbody>
                </table>


                <%
                    List pInvestigations = mgr.getPatientInvestigatonsByVisitid(lastVisitId);

                    if (!pInvestigations.isEmpty()) {%>

                <ul style="margin-left: 0px; margin-bottom: 0px;" class="breadcrumb">
                    <li>   <b> Laboratory  </b> </li>
                </ul>
                <table class="table">


                    <thead>
                        <tr>
                            <th style="color: #FFF; text-align: left">Investigation Description.</th>
                            <th style="color: #FFF; text-align: right">Price</th>
                            <th style="color: #FFF; text-align: right">Amount Paid</th>
                            <th style="color: #FFF; text-align: right">Balance</th>
                        </tr>
                    </thead> 


                    <%   if (mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getType().equalsIgnoreCase("NHIS")) {
                            Patientinvestigation pI = null;
                            int invId = 0;
                            Nhisinvestigation inv = null;
                            double price = 0, amntPaid = 0, balance = 0;

                            for (int q = 0; q < pInvestigations.size(); q++) {

                                pI = (Patientinvestigation) pInvestigations.get(q);
                                invId = pI.getInvestigationid();
                                inv = mgr.getNhisInvestigation(invId);

                                price = pI.getPrice();

                                amntPaid = pI.getAmountpaid();

                                //   if(totalCost < amntPaid) {
                                balance = amntPaid - price;

                    %>
                    <% if (price > 0) {%>
                    <tr>

                        <td style="text-transform: capitalize;"><%=mgr.getInvestigation(pI.getInvestigationid()).getName()%></td>

                        <td style="text-align: right;"><%=price%></td>

                        <td style="text-align: right;"><%=price%></td>
                        <td style="text-align: right;">0</td>

                    </tr>

                    <% }%>
                    <% itcost = itcost + price;
                        }
                    } else {
                        Patientinvestigation pI = null;
                        int invId = 0;
                        Investigation inv = null;
                        double price = 0, amntPaid = 0, balance = 0;

                        for (int q = 0; q < pInvestigations.size(); q++) {

                            pI = (Patientinvestigation) pInvestigations.get(q);
                            invId = pI.getInvestigationid();
                            inv = mgr.getInvestigation(invId);

                            price = pI.getPrice();

                            amntPaid = pI.getAmountpaid();

                            //   if(totalCost < amntPaid) {
                            balance = amntPaid - price;

                    %>
                    <% if (price > 0) {%>
                    <tr>
                        <td style="text-transform: capitalize;"><%=mgr.getInvestigation(pI.getInvestigationid()).getName()%></td>

                        <td style="text-align: right;"><%=df.format(price)%></td>

                        <td style="text-align: right;"><%=df.format(price)%></td>
                        <td style="text-align: right;">0.00</td>

                    </tr>
                    <% }%>
                    <% itcost = itcost + price;
                            }
                        }%>

                    </tbody>
                </table>
                <%  }%>                       

                <div class="clearfix"></div>

                <!--  <div class="btn-group" style="margin-left: 40%;">
                      <button class="btn update_sponsor btn-info">
                          Sponsorship
                      </button>
                  </div>  -->
                <%if (mgr.sponsorshipDetails(p.getPatientid()).getType().equalsIgnoreCase("NHIS")) {
                        session.setAttribute("total", "" + ttcost + itcost + csCost);
                %>
                <a class="btn btn-small btn-inverse" style="color: #FFF;" href="nhisform.jsp?id=<%=p.getPatientid()%>&sid=<%=lastVisitId%>&ccost=<%=csCost%>&incost=<%=itcost%>&tcost=<%=ttcost%>"> <i class="icon-white icon-eye-open"></i> View Claim</a>
                <%} else {%>
                <a class="btn btn-small btn-inverse" style="color: #FFF;" href="genericformshow.jsp?id=<%=p.getPatientid()%>&sid=<%=lastVisitId%>"> <i class="icon-white icon-eye-open"></i> View Claim</a>
                <%}%>
                <br />
                <div class="clearfix"></div>


            </div>
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
                                <th style="color: #FFF;">Folder # </th>
                                <th style="color: #FFF;">Full Name </th>
                                <th style="color: #FFF;">Sponsor</th>
                                <th style="color: #FFF;">Date of Birth</th>
                                <th style="color: #FFF;">Location</th>
                                <th style="color: #FFF;">Consultation Type</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < list.size(); i++) {
                                    Patient pp = (Patient) list.get(i);
                                    System.out.println("test " + list.size());
                            %>
                            <tr class="odd gradeX">
                                <td class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= pp.getFname()%>, <%= pp.getLname()%> <%= pp.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= pp.getDateofbirth()%></h5> <span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= pp.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= pp.getEmployer()%>  </td>  </tr> <tr> <td> Sponsor </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                    </table>"><a class="patientid"><%= pp.getPatientid()%></a></td><td><b><%= pp.getFname()%>, <%= pp.getLname()%> <%= pp.getMidname()%> </b></td><td><%= mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(pp.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(pp.getPatientid()).getSponsorid()).getSponsorname()%></td><td>  <%= pp.getDateofbirth()%> </td>
                                <td><%= mgr.getPatientFolder(pp.getPatientid()).getStatus()%></td>
                                <td>
                                    <div style="display: block" id="s_<%=pp.getPatientid()%>">
                                        <select class="input-medium" name="contype" onchange='showConType("d_<%=pp.getPatientid()%>")' id="ty_<%=pp.getPatientid()%>">
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
                                    <div id="d_<%=pp.getPatientid()%>" style="display: none">
                                        <a  id="<%=pp.getPatientid()%>_patientidlink"  class="btn btn-info" onclick='getType("ty_<%=pp.getPatientid()%>","type_<%=pp.getPatientid()%>")'> <i class="icon-pencil icon-white"> </i> New Visit </a>
                                    </div></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <div class="clearfix"></div>

            </div>

        </section>

        <%@include file="widgets/footer.jsp" %>

    </div><!-- /container -->

    <%for (int i = 0; i < list.size(); i++) {
            Patient ppp = (Patient) list.get(i);
    %>
    <div style="max-height: 600px; y-overflow: scroll; display: none;" id="<%= ppp.getPatientid()%>_dialog"  title="Patient Information">
        <div class="well thumbnail">
            <ul style="margin-left: 0px;" class="breadcrumb">
                <li>
                    <span class="divider"></span> Folder No: <%= ppp.getPatientid()%>
                </li>
            </ul>

            <div style="margin-top: 12px; padding-top: 5px;  padding-bottom: 5px; text-align: center;" class="thumbnail span2">
                <img src="images/default_profile.png" />

            </div>

            <table class="table span3 right table table-bordered table-condensed">
                <tr>
                    <td> Folder Number </td>

                    <td><b> <%= ppp.getPatientid()%></b></td>
                </tr>

                <tr>
                    <td> Full Name</td>

                    <td><b> <%= ppp.getFname()%></b></td>
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







        </div>
    </div>




    <script type="text/javascript">
   
               
        $("#<%= ppp.getPatientid()%>_dialog").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
 
        $("#<%= ppp.getPatientid()%>_dialog2").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
 
        $("#<%= ppp.getPatientid()%>_dialog3").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
    
 
    
        $("#<%= ppp.getPatientid()%>_patientidlink").click(function(){
            alert("Whats wrong!")
            $("#<%=ppp.getPatientid()%>_dialog").dialog('open');
    
        })
 
        $("#<%= ppp.getPatientid()%>_patientidlink2").click(function(){
      
            $("#<%=ppp.getPatientid()%>_dialog2").dialog('open');
    
        }) 
 
        $("#<%= ppp.getPatientid()%>_patientidlink2").click(function(){
      
            $("#<%=ppp.getPatientid()%>_dialog3").dialog('open');
    
        }) 
   
        $("#<%= ppp.getPatientid()%>_dialog").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
   
    
    </script>



    <% }
    } else {

    %>

    <br/> 

    <div class="alert hide alert-info container center">
        <b> No Results Found!  </b>
    </div>
    <br/>
    <div class="container-fluid center">


        <img id="bgimage"  class="center hide" width="40%" src="images/logoonly.png" />

    </div>   
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
        $(function() {

            var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

            //  menu_ul.hide();

            $(".menu").fadeIn();
            $(".alert").fadeIn();
            $(".main-c").fadeIn();
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
                "sScrollY" : "300px",
                "sPaginationType" : "full_numbers",
                "iDisplayLength" : 25,
                "aaSorting" : [],
                "bSort" : true

            });

            $(".patient").popover({

                placement : 'right',
                animation : true

            });

            $(".patient_visit").popover({

                placement : 'top',
                animation : true

            });
            
            
            $("#<%= p.getPatientid()%>_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
        
             
            $("#<%= p.getPatientid()%>_dialog2").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
            
            
            $("#<%= p.getPatientid()%>_dialog3").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
            $("#<%= p.getPatientid()%>_patientidlink").click(function(){
                alert("")
                $("#<%=p.getPatientid()%>_dialog").dialog('open');
    
            })
            
            
            
            
        
            $("#<%= p.getPatientid()%>_patientidlink2").click(function(){
      
                $("#<%=p.getPatientid()%>_dialog2").dialog('open');
    
            })
            
             
        
            $("#<%= p.getPatientid()%>_patientidlink3").click(function(){
      
                $("#<%=p.getPatientid()%>_dialog3").dialog('open');
    
            })

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
        
        $("#<%= vst.getPatientid()%>_dialog2").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
        
        $("#<%= vst.getPatientid()%>_dialog3").dialog({
            autoOpen : false,
            width : 1000,
            modal :true

        });
    
   
    
        $("#<%= vst.getPatientid()%>_patientidlink").click(function(){
      
            $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
        })
        
        $("#<%= vst.getPatientid()%>_patientidlink2").click(function(){
      
            $("#<%=vst.getPatientid()%>_dialog2").dialog('open');
    
        }) 
        
        $("#<%= vst.getPatientid()%>_patientidlink2").click(function(){
      
            $("#<%=vst.getPatientid()%>_dialog3").dialog('open');
    
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
