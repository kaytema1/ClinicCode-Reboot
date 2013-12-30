<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

        <%
            Users user = (Users) session.getAttribute("staff");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);
            Date date = new Date();
            List orders = mgr.listWalkinProcedures("Cashier");
            List treatments = null;
        %>


    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                        <ul class="nav nav-pills">

                            <li>
                                <a href="#">Billing</a><span class="divider"></span>
                            </li>
                            <li  class="active">
                                <a href="#"> Walk-in Procedure Bills </a><span class="divider"></span>
                            </li>

                        </ul>
                    </div>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%>center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row-fluid">

                    <%@include file="widgets/leftsidebar.jsp" %>




                    <div style="display: none;" class="span8 thumbnail main-c">

                        <table class="example display">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px; text-align: left;"> Order ID</th>
                                    <th style="font-size: 12px; text-align: left;"> Patient Name </th>
                                    <th style="font-size: 12px; text-align: left;"> Date of Birth </th>

                                    <th style="font-size: 12px; text-align: left;"> Requested On </th>

                                    <th style="text-transform: capitalize; font-size: 12px;"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (orders != null) {




                                        for (int i = 0; i < orders.size(); i++) {
                                            Procedureorderswalkin order = (Procedureorderswalkin) orders.get(i);
                                %>


                                <tr>
                                    <td style="text-transform: uppercase; color: #4183C4; font-weight: bold; font-size: 18px;"> <%=order.getOrderid()%>   </td>
                                    <td> <%= order.getFirstName()%> <%= order.getLastName()%></td>
                                    <td><%= formatter.format(order.getDateOfBirth())%>   </td>
                                    <td><%= formatter.format(order.getOrderdate())%>   </td>

                                    <td>
                                        <a href="walk-inprocedurepayment.jsp?orderid=<%= order.getOrderid()%>" class="btn btn-info btn-small">
                                           Make Payment
                                        </a>
                                    </td>
                                </tr>
                                <%}
                                    }%> 

                            </tbody>
                        </table>

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
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/demo.js"></script>

<!--initiate accordion-->
<script type="text/javascript">
    
    
    
    
    $(function() {
        $("input:checkbox").attr("checked", true);
        
        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
        
        $(".menu").fadeIn();
        $(".main-c").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
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
        
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true,
            "sScrollY" : 400
        }); 
        
        
        $(".patient").popover({
            placement : 'right',
            animation : true
        });
       
        $('#sidebar-toggle').click(function(e) {
            e.preventDefault();
            $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
            $('.menu').animate({width: 'toggle'}, 0);
            $('.menu').toggleClass('span3 hide');
            $('.main-c').toggleClass('span8');
                
        });
       
    });
</script>
</body>
</html>