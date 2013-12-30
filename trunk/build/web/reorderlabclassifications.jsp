

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

        <%

            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            HMSHelper mgr = new HMSHelper();
            boolean foundListTypes = false;

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
                            <a href="#">Laboratory Management</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Laboratory Classifications</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%

                        //  HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        // HMSHelper mgr = new HMSHelper();

                        List listTypes = mgr.listLabTypes();

                        if (!listTypes.isEmpty()) {
                            foundListTypes = true;
                        }

                    %>
                    <%if (session.getAttribute("lasterror") != null) {%>
                    <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                        <b> <%=session.getAttribute("lasterror")%>  </b>
                    </div>
                    <br/>
                    <div style="margin-bottom: 20px;" class="clearfix"></div>
                    <%session.removeAttribute("lasterror");
                        }%>




                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">
                        <div style="padding-bottom: 80px; max-height: 800px;" class="span9 thumbnail  content">

                            <ul style="margin-left: 0px; padding-bottom: 15px; " class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a href="#">All Lab Classifications</a></li>
                                <li class="pull-right"><a href="#" class="btn btn-small btn-danger" id="new_link"> <i class="icon-plus-sign icon-white"></i> New Lab Classification</a></li>
                            </ul>

                            <% if (foundListTypes) {%>
                            <form action="action/labtypeaction.jsp" method="post">   
                                <ul class="sortable">
                                    <%int labTypeId = 0;
                                        Labtypes lt;

                                        for (int p = 0; p < listTypes.size(); p++) {
                                            lt = (Labtypes) listTypes.get(p);
                                            labTypeId = lt.getLabTypeId();
                                    %>
                                    <li id="<%=labTypeId%>" class="ui-state-default">
                                        <span class="ui-icon ui-icon-arrowthick-2-n-s"></span><%=lt.getLabType()%>
                                    </li>
                                    
                                    <%
                                        }
                                    %>
                                </ul>
                                <input type="hidden" class="newOrder" name="newOrder" value="" />
                                <div class="form-actions">
                                    <button class="btn btn-small pull-right" type="submit" name="action" value="ordering" >
                                        <i class="icon-resize-vertical"> </i> Save Lab Classification Order
                                    </button>
                                </div>
                            </form>
                            <% }%>
                            <div title="New Lab Classification" id="new" class="hide" >


                                <form id="savelabclassification" class="form-horizontal" action="action/labtypeaction.jsp" method="post" name="items" >

                                    <fieldset>


                                        <div class="control-group">
                                            <label class="control-label">Code</label>

                                            <div class="controls">
                                                <input style="text-transform: uppercase;" type="text" class="input-small" name="code" value=""/>
                                            </div>
                                        </div>


                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Lab Classification: </label>
                                            <div class="controls">
                                                <input  style="text-transform: uppercase;" type="text" name="name" id="name">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>


                                    </fieldset>
                                    <div class="form-actions">

                                        <button class="btn btn-small btn-info"  type="submit" name="action" value="units" onclick="alert('Hello')">
                                            <i class="icon-check icon-white"> </i> Save Lab Classification 
                                        </button>

                                    </div>
                                </form>
                            </div>


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
<script src="js/jquery.js"></script>
<script src="js/bootstrap-dropdown.js"></script>
<script src="js/bootstrap-scrollspy.js"></script>
<script src="js/bootstrap-collapse.js"></script>
<script src="js/bootstrap-tooltip.js"></script>
<script src="js/bootstrap-popover.js"></script>
<script src="js/application.js"></script>
<script src="js/jquery.validate.min.js"></script>
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
        
        $("#new").dialog({
            autoOpen : false,
            width : 600,
            modal :true

        });
        
        $("#new_link").click(function(){
      
            $("#new").dialog('open');
    
        })

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
        
        
        
        $('#savelabclassification').validate({
            rules: {
                code: {
                    minlength: 2,
                    required: true
                },
                name: {
                    minlength: 2,
                    required: true
                }
            },
            highlight: function(label) {
                $(label).closest('.control-group').addClass('error');
            },
            success: function(label) {
                label
                .text('OK!').addClass('valid')
                .closest('.control-group').addClass('success');
            }
        });

    });
    
</script>

</body>
</html>