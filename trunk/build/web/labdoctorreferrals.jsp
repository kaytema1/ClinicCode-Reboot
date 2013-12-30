<%--
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
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
            SimpleDateFormat datetimeformat = new SimpleDateFormat("E dd MMM. yyyy HH:mm a");
            Date date = new Date();
            List listorders = mgr.listLabordersByDoctorid();
            Laborders laborder = (Laborders) listorders.get(0);
            HashMap<String, String> hashMap = new HashMap<String, String>();
            DecimalFormat df = new DecimalFormat();
            df.setMinimumFractionDigits(2);
            int count = 1;
            double price = 0.0;
            int totalCount = 0;
            Double totalRate = 0.0;
            System.out.println("size of listorders : " + listorders.size());
            for (int i = 0; i < listorders.size(); i++) {
                Laborders vst = (Laborders) listorders.get(i);
                System.out.println("vst.getph : " + vst.getPhysician());
                if (hashMap.containsKey(vst.getPhysician())) {
                    String string = hashMap.get(vst.getPhysician());
                    System.out.println("string : " + string);
                    hashMap.remove(vst.getPhysician());
                    String[] arr = string.split("_");
                    System.out.println("arr[0] : " + arr[0]);
                    System.out.println("arr[1] : " + arr[1]);
                    System.out.println("vst.gettotal : " + vst.getTotalAmount());
                    count = Integer.parseInt(arr[0]) + 1;
                    price = Double.parseDouble(arr[1]) + vst.getTotalAmount();
                    System.out.println("price : " + price);
                    hashMap.put(vst.getPhysician(), "" + count + "_" + price);
                    
                } else {
                    System.out.println("new guy : " + vst.getPhysician());
                    price = vst.getTotalAmount();
                    hashMap.put(vst.getPhysician(), "1_" + price);
                }

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
                            <a href="#">Laboratory</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Laboratory Doctors Referral Summary</a><span class="divider"></span>
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
                            <form action="" method="post">
                                <ul style="margin-left: 0px; padding-bottom: 20px;" class="breadcrumb ">
                                    <li style="margin-top: 10px;">
                                        <a style="font-size: 15px;">Laboratory Doctor's Referral Summary</a>
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
                                        <th style="text-align: left;"> Referring Doctor</th>
                                        <th style="text-align: left;"> Number of Labs</th>
                                        <th style="text-align: left;"> Total Amount</th>
                                        <td></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (!hashMap.isEmpty()) {
                                            Collection<?> keys = hashMap.keySet();
                                            for (Object key : keys) {
                                                String string = hashMap.get(key);
                                                String[] stringArray = string.split("_");
                                    %>
                                    <tr>
                                        <td style="text-transform: uppercase; color: #4183C4;  font-weight: bolder; font-size: 15px;"><%=key%></td>
                                        <td style="text-align: right;"><%=stringArray[0]%> 
                                        <% totalCount = totalCount + Integer.parseInt(stringArray[0]); %>
                                        </td>
                                        <td style="text-align: right;"><%=stringArray[1]%>0 
                                        <% totalRate = totalRate + Double.parseDouble(stringArray[1]); %>
                                        </td>
                                        <td style="text-align: center;"><a class="btn btn-small btn-info" href="doctorreferraldetails.jsp?doctorid=<%=key%>">View Details</a> </td>
                                    </tr>
                                    <%}
                                            // }
                                        }%> 

                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>
                                            <b style="font-size: larger;"> TOTAL </b>
                                        </td>
                       
                                        <td style="font-size: larger; text-align:right ">
                                            <b> 
                                                <%= totalCount %>
                                            </b>
                                        </td>
                                        <td style="font-size: larger; text-align: right">
                                            <b > 
                                                <%= df.format(totalRate) %>
                                            </b>
                                        </td>
                                        
                                        <td>
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

    
</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
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