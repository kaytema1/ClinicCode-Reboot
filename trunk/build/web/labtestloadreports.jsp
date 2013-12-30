<%--
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
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
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat newformatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E dd MMM, yyyy HH:mm a");
            Date date = new Date();
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);

            List listorders = null;


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
            
            System.out.println("dateSqlDate : " + dateSqlDate);
            System.out.println("rangeSqlDate : " + rangeSqlDate);

            if (correctDateFound) {
                if (singleDateValue) {
                    System.out.println("very single");
                    System.out.println(" dateValue : " + dateValue);
                    listorders = mgr.patientInvestigationByTypeForDate(dateSqlDate);
                } else {
                    System.out.println("not very single");
                    listorders = mgr.patientInvestigationByTypeForDuration(dateSqlDate, rangeSqlDate);
                }
            } else {
                listorders = mgr.patientInvestigationByType();
            }

            System.out.println("listorders.size : " + listorders.size());

            System.out.print("dateValue : " + dateValue);
            ////System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations((String) session.getAttribute("unit"), dateFormat.format(date));
            List treatments = null;
            //List dispatch = mgr.listLabordersByStatus("Dispatched");
            double totalRate = 0.0;
            int totalCount = 0;
            double totalValue = 0.0;
            //listorders.addAll(dispatch);
            //System.out.println("laborders+++++++++++++++++++++++++++ " + listorders.size());

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
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Test Load Report</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row">
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <form action="labtestloadreports.jsp" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Test Load Report | <%=displayedDate%></a>
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
                                        <th style="text-align: left;"> Laboratory Classification </th>
                                        <th style="text-align: left;"> Test </th>
                                        <th style="text-align: right;"> Price </th>
                                        <th style="text-align: right;"> Quantity</th>
                                        <th style="text-align: right;"> Value</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% if (listorders != null) {
                                            //int count = 0;
                                            HashMap<Integer, Integer> hashMap = new HashMap<Integer, Integer>();
                                            for (int i = 0; i < listorders.size(); i++) {
                                                
                                                Patientinvestigation vst = (Patientinvestigation) listorders.get(i);
                                                if (!(vst.getDate().equals("0000-00-00 00:00:00"))) {
                                                if (mgr.getInvestigation(vst.getInvestigationid()).getTypeOfTestId() == 1) {
                                                    if (hashMap.containsKey(vst.getInvestigationid())) {
                                                        int count = hashMap.get(vst.getInvestigationid());
                                                        hashMap.remove(vst.getInvestigationid());
                                                        hashMap.put(vst.getInvestigationid(), count + 1);
                                                    } else {
                                                        hashMap.put(vst.getInvestigationid(), 1);
                                                    }
                                                }
                                            }
                                            }
                                            //hashMap.put(key, value)

                                    %>
                                    <% //hashMap = entriesSortedByValues(hashMap);
                                        if (!hashMap.isEmpty()) {

                                            Collection<?> keys = hashMap.keySet();
                                            for (Object key : keys) {
                                                String investigationid = "" + key;



                                    %>
                                    <tr>
                                        <td style="text-align: left; text-transform: uppercase; font-size: larger;"> 
                                            <a style="font-weight: bolder;" href="#"> <%=mgr.getLabTypeByid(mgr.getInvestigation(Integer.parseInt(investigationid)).getLabTypeId()).getLabType()%> </a></td>
                                        <td style="text-align: left;"><%=mgr.getInvestigation(Integer.parseInt(investigationid)).getName()%></td>
                                        <td style="text-align: right; padding-right: 20px;">
                                            <%= df.format(mgr.getInvestigation(Integer.parseInt(investigationid)).getRate())%>
                                            <%totalRate = totalRate + mgr.getInvestigation(Integer.parseInt(investigationid)).getRate();%>
                                        </td>
                                        <td style="text-align: right; padding-right: 20px;">
                                            <%=hashMap.get(key)%>
                                            <%totalCount = totalCount + hashMap.get(key);%>
                                        </td>
                                        <td style="text-align: right; padding-right: 20px;">
                                            <%= df.format(Double.parseDouble(df.format(mgr.getInvestigation(Integer.parseInt(investigationid)).getRate())) * hashMap.get(key))%>
                                            <% totalValue = totalValue + Double.parseDouble(df.format(mgr.getInvestigation(Integer.parseInt(investigationid)).getRate())) * hashMap.get(key);%>
                                        </td>


                                        <td style="text-align: left;">
                                            <a class="btn btn-info" href="testdetails.jsp?invid=<%=investigationid%>">View
                                            </a>
                                        </td>
                                    </tr>

                                    <%}
                                            }
                                        }%> 

                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>
                                            <b style="font-size: larger;"> TOTAL </b>
                                        </td>
                                        <td>

                                        </td>
                                        <td style="font-size: larger; text-align:right ">
                                            <b > 
                                              <!--  <%= df.format(totalRate)%>  -->
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right">
                                            <b > 
                                                <%= totalCount%>
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right"> 
                                            <b > 
                                                <%= df.format(totalValue)%>
                                            </b>
                                        </td>
                                        <td id="total">
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    

    </div>
</div>
<!--end static dialog-->

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
            "sScrollY": "450px",
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
