<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    HMSHelper mgr = new HMSHelper();
    ExtendedHMSHelper newmgr = new ExtendedHMSHelper();
    CompanyProfile profile = newmgr.getProfile("1");
%>

<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var rolename = document.getElementById("rolename").value;
                var roledescription = document.getElementById("roledescription").value;
              
                 
                $.post('action/roleaction.jsp', { action : "addrole", rolename : rolename, roledescription : roledescription}, function(data) {
                    alert(data);
                    location.reload();
                    //$('#results').html(data).hide().slideDown('slow');
                } );
            }
        </script>
        <script type="text/javascript">
            function submitform(){
                var name= document.getElementById("name").value;
              
                var bool = validateForm();
                if(bool){
                    $.post('action/sponsoraction.jsp',{ action : "units", name : name}, function(data){
                        alert(data);
                    })
                }else{
                    alert("Sponsor field cannot be empty");
                }
            }
            
            function updateUnit(name,id){
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
               
                $.post('action/permissionaction.jsp', { action : "edit", uname : uname, uid : uid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                if (con ==true)
                {
                    $.post('action/permissionaction.jsp', { action : "delete", id : id}, function(data) {
                        alert(data);
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancelled!");
                    //return;
                }
            }
        </script>
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
                            <a href="labadminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Facility Setup</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">
                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>

                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%
                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                    %> 

                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style=" font-size: 14px; font-weight: bold; padding-top: 7px;">
                                    <a>Laboratory Code Details</a>
                                </li>



                            </ul>

                            <form id="facility_setup" class="form-horizontal" action="action/faciltyaction.jsp" method="POST">



                                <div class="pull-left">

                                    <div class="control-group">
                                        <label class="control-label" for="input01">Laboratory Folder Code: </label>
                                        <div class="controls">
                                            <input type="text" class="input-mini"  name="diagnostics_folder_code" value="<%= profile.getDiagnosticsFolderCode()%>"/>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="input01">Laboratory Folder Start Number: </label>
                                        <div class="controls">
                                            <input type="text" class="input-mini"  name="diagnostics_folder_start_number" value="<%= profile.getDiagnosticFolderStartNumber()%>"/>
                                        </div>
                                    </div>







                                    <div class="form-actions">

                                        <button class="btn btn-info" type="submit" name="action" value="updatelab">
                                            <i class="icon icon-plus-sign icon-white"> </i>  Update Laboratory Code Details
                                        </button>

                                    </div>
                                </div>
                            </form>





                        </div>
                        <div class="clearfix"></div>

                    </div>


            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    

    </div>
</div>
<!--end static dialog-->

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
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/demo.js"></script>

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
    
    $(document).ready(function(){
        $('#facility_setup').validate({
                            
            rules: {
                facilityname: {
                    required: true,
                    minlength : 2
                                    
                },
                servicenumber: {
                    required: true,
                    minlength : 2
                },
                telephone: {
                    minlength : 10,
                    maxlength : 14,
                    required: true
                    
                },
                address: {
                    required: false
                    
                }
                ,
                eclaimnumber: {
                    required: false
                    
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
        })
        
        
    })
    
    
   
</script>

</body>
</html>