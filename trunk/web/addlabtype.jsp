

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
                                <li class="pull-right">
                                    <% if (permissions.contains(37)) {%>
                                    <a href="#" class="btn btn-small btn-info" id="new_link"> 
                                        <i class="icon-plus-sign icon-white"></i> New Lab Classification</a>
                                        <%}%>
                                </li>
                                <li style="margin-right: 10px;" class="pull-right">
                                    <% if (permissions.contains(36)) {%>
                                    <a href="reorderlabclassifications.jsp" class="btn btn-small" id="new_link"> 
                                        <i class="icon-arrow-down "></i> Order Lab Classifications</a>
                                        <%}%>
                                </li>
                            </ul>

                            <% if (foundListTypes) {%>
                            <table class="example">
                                <thead>
                                    <tr>
                                        <th>
                                            Lab Classification
                                        </th>
                                        <th>
                                            Status
                                        </th>
                                        <th>

                                        </th>
                                        <th>

                                        </th>
                                    </tr>
                                <tbody>
                                    <%
                                        int labTypeId = 0;
                                        Labtypes lt;

                                        for (int p = 0; p < listTypes.size(); p++) {
                                            lt = (Labtypes) listTypes.get(p);
                                            labTypeId = lt.getLabTypeId();
                                    %>
                                    <tr>

                                        <td>



                                            <a style="color: #4183C4; font-weight:  bolder;" href="maininvreorderingbackup.jsp?labtype=<%=lt.getLabTypeId()%>"> <%=lt.getLabType()%></a>


                                        </td>
                                        <td>
                                            <% if (lt.getActive() == 0) {%>
                                            <label style="margin-left: 10px; margin-right: 10px;" class="label label-important pull-right">In-Active</label>
                                            <% } else {%>
                                            <label style="margin-left: 10px; margin-right: 10px;" class="label label-success pull-right ">Active </label>
                                            <% }%>
                                        </td>
                                        <td  style="margin: 0px; padding: 0px;" >
                                            <% if (permissions.contains(38)) {%>
                                            <a style="color: white;" class="btn btn-info  pull-right" href="editlabtype.jsp?id=<%=lt.getLabTypeId()%>"> 
                                                <i class="icon-white icon-edit"></i> Edit </a> 
                                                <%}%>
                                        </td>
                                        <td  style="margin: 0px; padding: 0px;" >
                                            <% if (permissions.contains(40)) {
                                                if (lt.getActive() == 0) {%>

                                            <form style="margin: 0px; padding: 0px;"   class="pull-right" method="POST" action="action/labtypeaction.jsp">

                                                <input type="hidden" name="id" value="<%= lt.getLabTypeId()%>" > 
                                                <input type="hidden" name="active" value="1"> 
                                                <button class="btn pull-right btn-inverse" type="submit" name="action" value="activate">
                                                    <i class="icon-check icon-white"></i> Activate
                                                </button>

                                            </form>


                                            <% } else {%>
                                            <form   style="margin: 0px; padding: 0px;"  class="pull-right" method="POST" action="action/labtypeaction.jsp">

                                                <input type="hidden" name="id" value="<%= lt.getLabTypeId()%>" /> 
                                                <input type="hidden" name="active" value="0"> 
                                                <button class="btn pull-right btn-danger" type="submit" name="action" value="activate">
                                                    <i class="icon-remove icon-white"></i> Deactivate
                                                </button>

                                            </form>


                                            <% }}%>

                                        </td>

                                    </tr>



                                    <%
                                        }
                                    %>

                                </tbody>
                            </table>

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

                                        <button class="btn btn-small btn-info"  type="submit" name="action" value="units">
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
<%@include file="widgets/javascripts.jsp" %>


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