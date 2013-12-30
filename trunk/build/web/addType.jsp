<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            HMSHelper mgr = new HMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            //Patient p = (Patient)session.getAttribute("patient");
            //get current date time with Date()
            Date date = new Date();
            //System.out.println(dateFormat.format(date));
            List visits = mgr.listUnitVisitations("Laboratory", dateFormat.format(date));
            List treatments = null;
            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            // for (int i = 0; i < visits.size(); i++) {
            //   Visitationtable visit = (Visitationtable) visits.get(i);
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

                        <li class="active">
                            <a href="#">Add Drug/Item Type</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row-fluid">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        HMSHelper itm = new HMSHelper();

                        List itmss = itm.listSuppliers();
                        List type1 = itm.listItemType();



                    %>     
                    <%@include file="widgets/leftsidebar.jsp" %>
                    <div style="padding: 0px; padding-bottom: 80px; display: none;" class="span8 thumbnail main-c">

                        <div style="width: 48%" class="pull-left thumbnail">
                            <ul style="margin-left: 0px;" class="breadcrumb">
                                <li>
                                    <a>Add Item Type</a>
                                </li>

                            </ul>
                            <form style="width: 90%" class="form-horizontal" method="post" action="action/saveType.jsp">
                                <fieldset>

                                    <div class="control-group">
                                        <label class="control-label" for="input01">Item Type:</label>
                                        <div class="controls">
                                            <input type="text" class="input-medium" name="itemType">
                                            <input type="hidden" name="id" value="1">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="form-actions">

                                        <button class="btn btn-info" type="submit" name="addType" value="Add Item Type">
                                            <i class="icon-plus-sign icon-white"> </i> Add Item Type 
                                        </button>

                                    </div>

                                </fieldset>
                            </form>
                        </div>
                        <div  style="width: 48%" class="pull-left thumbnail">
                            <ul style="margin-left: 0px;" class="breadcrumb">
                                <li>
                                    <a>Add Drug Type</a>
                                </li>

                            </ul>
                            <form class="form-horizontal" method="post" action="saveDrugType.jsp">
                                <fieldset>
                                    <div class="control-group">
                                        <label class="control-label" for="input01">Drug Type</label>
                                        <div class="controls">
                                            <input type="text" class="input-medium" name="drugType">
                                            <input type="hidden" name="id" value="1">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>


                                    <div class="form-actions">

                                        <button class="btn btn-info" type="submit" name="addDrugType" value="Add Drug Type">
                                            <i class="icon-plus-sign icon-white"> </i> Add Drug Type 
                                        </button>

                                    </div>
                                </fieldset>
                            </form>
                        </div>


                    </div>


                    <div class="clearfix"></div>

                </div>

            </section>

            <footer style="display: none; margin-top: 50px;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

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

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();

        $(".menu").fadeIn();
        $(".main-c").fadeIn();
        $("#sidebar-toggle-container").fadeIn();
        $(".navbar").fadeIn();
        $(".footer").fadeIn();
        $(".subnav").fadeIn();
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