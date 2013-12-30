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
        <script type="text/javascript">
            function submitform(){
                var name= document.getElementById("name").value;
              
                var bool = validateForm();
                if(bool){
                    $.post('action/permissionaction.jsp',{ action : "units", name : name}, function(data){
                        alert(data);
                    })
                }else{
                    alert("Permission field cannot be empty");
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

        <!-- Navbar
        ================================================== -->
        <% HMSHelper mgr = new HMSHelper();%>
        <!-- Navbar
        ================================================== -->
        <div class="navbar navbar-fixed-top hide">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
                    <a class="brand" href="#"><img src="images/logo.png" width="200px;" /></a>

                    <div style="margin-top: 10px;" class="nav-collapse">


                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">



                    </ul>
                </div>  

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%if (session.getAttribute("lasterror") != null) {%>
                    <div style="width: 100%" class="alert <%=session.getAttribute("class")%> center">
                        <b> <%=session.getAttribute("lasterror")%>  </b>
                    </div>
                    
                    <div style="margin-bottom: 20px;" class="clearfix"></div>
                    <%session.removeAttribute("lasterror");
                        }%>

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();



                        List itmss = mgr.listPermissions();




                    %>     
                    <br/>
                    <br/>
                    <br/>
                    <div  class="modal hide">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <img src="images/danpong group logo.png" width="60px;" />
                        </div>

                        <form autocomplete="off" class="form-horizontal" id="login" action="action/login.jsp" method="post" name="items" >

                            <fieldset>
                                <div class="modal-body">
                                    <div class="control-group">
                                        <label class="control-label" for="input01"> Username </label>
                                        <div class="controls">
                                            <input autocomplete="off" type="text" name="username" id="username">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="input01"> Password </label>
                                        <div class="controls">
                                            <input autocomplete="off" type="password" name="password" id="password">
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="input01"> Unit </label>
                                        <div class="controls">
                                            <select class="input-medium" name="unit">
                                                <option value="">Select </option>
                                                <% List list = mgr.listDepartments();
                                                    for (int i = 0; i < list.size(); i++) {
                                                        Department department = (Department) list.get(i);
                                                %>
                                                <option value="<%=department.getDepartment()%>"><%=department.getDepartment()%></option>
                                                <%}
                                                    List lists = mgr.listUnits();

                                                    for (int r = 0; r < lists.size(); r++) {
                                                        Units unit = (Units) lists.get(r);
                                                %>  

                                                <%}
                                                    List ls = mgr.listConRooms();
                                                    for (int x = 0; x < ls.size(); x++) {
                                                        Consultingrooms conroom = (Consultingrooms) ls.get(x);
                                                %>
                                                <%}%>
                                            </select>

                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">

                                    <button class="btn btn-info btn-large" type="submit" value="login" name="action">
                                        <i class=" icon-lock icon-white"> </i> Sign In 
                                    </button>

                                </div>
                            </fieldset>
                        </form>


                    </div>


                    <div class="clearfix"></div>

                </div>


            </section>

            <!--    <footer style="display: none; position: static; bottom: 500px;"  class="footer">
                    <p style="text-align: center" class="pull-right">
                        <img src="images/logo.png" width="100px;" />
                    </p>
                </footer>   -->

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
<script src="js/jquery-ui-autocomplete.js"></script>
<script src="js/jquery.select-to-autocomplete.min.js"></script>  

<script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

<script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
<script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
<script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

<script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
<script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

<script type="text/javascript" src="js/jquery.numeric.js"></script>
<script type="text/javascript" src="js/tablecloth.js"></script>
<script type="text/javascript" src="js/demo.js"></script>
<script type="text/javascript" src="js/jquery.filter_input.js"></script>


<!--initiate accordion-->
<script type="text/javascript">
    $(function() {

        var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

        menu_ul.hide();
        $(".alert").fadeIn();
        $(".modal").fadeIn();
        //$(".menu").fadeIn();
        //$(".content1").fadeIn();
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
        
        
        $(':input').attr('autocomplete', 'off');
        
        
                 
                        
        

    });
    
    $(document).ready(function(){
        $('#login').validate({
                            
            rules: {
                username: {
                    required: true,
                    minlength : 2
                                    
                },
                password: {
                    required: true,
                    minlength : 2
                },
                unit: {
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
        })
        
        
    })
    
    
    
   
</script>
</body>
</html>