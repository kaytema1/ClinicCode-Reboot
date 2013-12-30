<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> list = (ArrayList<Integer>) session.getAttribute("staffPermission");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            HMSHelper mgr = new HMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

            Date date = new Date();
            List visits = mgr.listRecentVisits(dateFormat.format(date));
        %>
        <%@include file="widgets/stylesheets.jsp" %>
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
                            <a href="#">Diagnostics Reception</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->



                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>
                <div class="row-fluid">


                    <%String perm = (String) session.getAttribute("unit");
                        int role = (Integer) session.getAttribute("role");
                        String[] perms = perm.split("_");

                    %>



                    <%if (session.getAttribute("lasterror") != null) {%>
                    <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                        <b>  <%=session.getAttribute("lasterror")%> </b>
                    </div>

                    <div class="clearfix"></div>
                    <%session.removeAttribute("lasterror");
                        }%>




                    <div style="width:100%; overflow-x: hidden; overflow-y: hidden; " class="box" id="myModal">
                        <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                            <img class="pull-left" src="img/glyphicons/png/glyphicons_298_hospital.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Quick Links </h4> </a>
                            <i class="pull-right icon-remove"> </i>
                            <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                        </div>
                        <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">


                            <% if (role == 13 || role == 14) {%>




                            <%if(list.contains(7)||list.contains(21)){ %>
                            <a href="labreception.jsp">
                                <div style="margin-right: 5px;" class="span4  center pull-left  well large_button ">
                                    <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/010.png" />  Reception
                                </div> 
                            </a>
                            <%}%>
                            <%if(list.contains(8)||list.contains(27)){ %>
                            <a href="laboratory_n.jsp">
                                <div style="margin-right: 5px;" class="span4  center pull-left  well large_button ">
                                    <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/006.png" />  Main Laboratory
                                </div> </a>
                            <%}%>
                            <%if(list.contains(9)||list.contains(29)){ %>
                            <a href="labvetted.jsp">
                                <div style="margin-right: 5px;" class="span4  center pull-left  well large_button ">
                                    <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/013.png" />  Results Scrutiny
                                </div> 
                            </a>
                            <%}%>
                            
                            <a href="labadminpanel.jsp">
                                <div style="margin-right: 5px;" class="span4  center pull-left  well large_button ">
                                    <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/027.png" /> Diagnostics Administration
                                </div> 
                            </a>


                            <%}
                                    if (role == 9) {%>

                            <a href="labreception.jsp">
                                <div style="margin-right: 5px;" class="span4  center pull-left  well large_button ">
                                    <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/010.png" />  Reception/Cashier
                                </div> 
                            </a>


                            <%}
                                    if (role == 6) {%>

                            <a href="laboratory_n.jsp">
                                <div style="margin-right: 5px;" class="span4  center pull-left  well large_button ">
                                    <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/006.png" />  Main Laboratory
                                </div> 
                            </a>



                            <%}%>


                        </div>

                    </div>
                </div>

                <div class="clearfix"></div>



            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->


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
            
            
            
            $(".submit_button").click(function(){
                
                $(".MustSelectOpt").each(function(){
                   
                    var selectedid =  $(this).attr('id');
                    var selectedvalue = $(this).attr('value')
                    
                    if(selectedvalue=="Select"){
                       
                        $('#'+selectedid).closest('.control-group').addClass('error').removeClass('success')
                    }
                    else{
                       
                        $('#'+selectedid).closest('.control-group').addClass('success').removeClass('error');
                    }
                   
                });
                
               
                
            });
            
            
            
            
            
            $("input:checkbox").attr("checked", false);
            
            
            
            for (i = new Date().getFullYear(); i > 1900; i--)
            {                       
                $('#year').append($('<option />').val(i).html(i));
            }
            
            
            
            $(".MustSelectOpt").change(function(){
                
                var selectedvalue = $(this).attr('value')
                var selectedid = $(this).attr('id');    
                //alert(selectedvalue);
                //alert(selectedid);
                if($("#"+selectedid).attr("value")=="Select"){
                    
                    $('#'+selectedid).closest('.control-group').addClass('error').removeClass('success')
                    // $('.MustSel').closest('.control-group').addClass('error').removeClass('success')
                        
                }else{
                    $('#'+selectedid).closest('.control-group').addClass('success').removeClass('error');        
                    //  $('.MustSel').closest('.control-group').addClass('success').removeClass('error');
                }
                        
                  
                    
            })
        
            $('#registration').validate({
                rules: {
                    fname: {
                        minlength: 2,
                        required: true
                    },
                    lname: {
                        minlength: 2,
                        required: true
                    },
                    midname: {
                        minlength: 2,
                        required: false
                    }
                    ,
                    contact: {
                        maxlength: 14,
                        minlength: 10,
                        required: true
                    }
                    ,emergencyperson: {
                        minlength: 2,
                        required: true
                    },
                    emergencycontact: {
                        maxlength: 14,
                        minlength: 10,
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
        
            $("#payment").change(function() {
          
                var payment =  $('#payment option:selected').attr('id');
            
                if(payment=='nhis'){
                    //alert("nhis");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideDown();
                    $('#nhismembershipid').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#benefitplan').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#membershipid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                
                
                }else if(payment=='cash'){
                    //alert("cash");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                    $('#nhismembershipid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#benefitplan').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#membershipid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                
                }else if(payment=='private'){
                    //alert("private");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideDown();
                    $("#nhisdiv").slideUp();
                    /* $('#benefitplan').rules('add', {
                                   required : true,
                                    minlength: 2
                                });
                    
                     */
                    if ($('#sponsor').attr('value')=="Select"){
                        $('#sponsor').closest('.control-group').addClass('error').removeClass('success')
                    }
                    
                    $('#membershipid').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#nhismembershipid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
               
            
                }else if(payment=='corporate'){
                    //alert("corporate");
                    $("#companydiv").slideDown();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                    
                    if ($('#coperate').attr('value')=="Select"){
                        $('#coperate').closest('.control-group').addClass('error').removeClass('success')
                    }
                    
                    $('#coperateid').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#nhismembershipid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                
                    $('#benefitplan').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#membershipid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                }
                else{
                    alert("Please Select Payment Method");
                }
            });
            
            
            $("#sponsor").change(function(){
                
                
                if ($('#sponsor').attr('value')!="Select"){
                    $('#sponsor').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#sponsor').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
            
            
            $(".dob").change(function(){
                
                
                if (($('#day').attr('value')!="D") && ($('#month').attr('value')!="M") && ($('#year').attr('value')!="Y")){
                    $('#year').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#year').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
            
            
            $("#dependent_check").change(function(){
               
                $("#dependent_content").slideToggle("slow")
               
            });
            
            
               
               
               
           
            $(function() {
            
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
            
            

                //menu_ul.hide();

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
            
            
            
            
            
            function showMembershipbox(){
                               var show = document.getElementById("privateid");
                               var shows = document.getElementById("nhis");
                              
                               show.style.display="block";
                               shows.style.display="none";
                           
                       }
        
            function showCorporate(){
                               var show = document.getElementById("privateid");
                               var shows = document.getElementById("nhis");
                              
                               show.style.display="none";
                               shows.style.display="none";
                           
                       }
        
                       function showInsurance(){
                               var show = document.getElementById("nhis");
                               var shows = document.getElementById("privateid");
                              
                               show.style.display="block";
                               shows.style.display="none";
                           
                       }
        
                       function hideIt(){
                               var show = document.getElementById("privateid");
                                var shows = document.getElementById("nhis");
                                //if(show.style.display == "block"){
                               show.style.display="none";
                           //}else{
                               
                             //  } if(show.style.display == "none"){ 
                                shows.style.display="none";
                       }    
      
        </script>

    </body>
</html>