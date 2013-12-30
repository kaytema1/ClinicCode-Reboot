<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<%
    Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }

    ExtendedHMSHelper mgr = new ExtendedHMSHelper();

    GeneralSettings labReportHeader = null;
    GeneralSettings labReportFooter = null;
    boolean footerExists = false, headerExists = false;
    
       
    
    labReportHeader = mgr.getGeneralSettingByName("lab_report_header_active");
    if(labReportHeader.isValue()){

        headerExists = true;
    }


    
    
    labReportFooter = mgr.getGeneralSettingByName("lab_report_footer_active");
    if(labReportFooter.isValue()){
        
        footerExists = true;
    }
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <style type="text/css">
            .consult th {
                border-top: 1px solid #DDDDDD;
                line-height: 18px;
                text-align: center;
                vertical-align: top;
                color: #FFFFFF;
                font-size: 12px;
            }
        </style>




    </head>


    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">
            <!-- Masthead
           ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -80px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li class="active">
                            <a href="#">General Laboratory Settings</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>
            <section id="dashboard"> 
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

                    <div class="span9 offset3 thumbnail well content">

                        <div style="max-height: 600px; overflow-y: scroll; overflow-x: hidden;" class="visit" id=""  title="Consultation for   ">

                            <div class="span10">

                                <div style="margin-left: -50px;" class="span2 ">
                                    <ul class="menu">
                                        <li> <a class="print_link active"> <i class="icon icon-check"> </i> Print Setting </a></li>



                                    </ul>



                                </div>
                                <div class="span7">

                                    <div  class="thumbnail center vital">
                                        <ul style="margin-left: 0px; text-transform: uppercase" class="breadcrumb">
                                            <li>
                                                <a style="text-align: center;"> <b> Print Settings </b></a>
                                            </li>

                                        </ul>



                                        <form id="facility_setup" class="form-horizontal" action="action/generalsettingsaction.jsp" method="POST">



                                            <div class="control-group">
                                                <label class="control-label" for="input01">Laboratory Report Header: </label>
                                                <div class="controls">


                                                    <select name="labReportHeaderActiveString" class="input-mini">
                                                        <% if (headerExists) {
                                                                if (labReportHeader.isValue()) {%>
                                                                <option value="Yes">Yes</option>
                                                                <option value="No">No</option>

                                                        <% } else {%> 
                                                        <option value="No">No</option>
                                                        <option value="Yes">Yes</option>
                                                        <% }
                                                            } else { %> 
                                                            <option value="No">NO</option>
                                                            <option value="Yes">YES</option>
                                                            
                                                            <% } %>
                                                    </select>

                                                </div>
                                            </div>

                                            <div class="control-group">
                                                <label class="control-label" for="input01">Laboratory Report Footer: </label>
                                                <div class="controls">
                                                    <select name="labReportFooterActiveString" class="input-mini">
                                                        <% if (footerExists) {
                                                                if (labReportFooter.isValue()) {
                                                        %>
                                                        <option value="Yes">Yes</option>
                                                        <option value="No">No</option>

                                                        <% } else {%> 
                                                        <option value="No">No</option>
                                                        <option value="Yes">Yes</option>
                                                        <% }
                                                            } else { %> 
                                                            <option value="No">No</option>
                                                        <option value="Yes">Yes</option>
                                                            <% } %>
                                                    </select>
                                                </div>
                                            </div>





                                            <div class="clearfix">

                                            </div>
                                            <div class="form-actions center">

                                                <button class="btn btn-info" type="submit" name="action" value="savePrintSetting">
                                                    <i class="icon icon-plus-sign icon-white"> </i>  Update Print Settings
                                                </button>

                                            </div>
                                        </form>

                                    </div>



                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div> 
            </section>

        </div>
        <%@include file="widgets/footer.jsp" %>




        <%@include file="widgets/javascripts.jsp" %>




    </body>
</html>

