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

                        <li>
                            <a href="clinicreception.jsp">Billing</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Patient Bill Search</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

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


                    <%@include file="widgets/leftsidebar.jsp" %>

                    
                        <%if (session.getAttribute("lasterror") != null) {%>
                        <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                            <b>  <%=session.getAttribute("lasterror")%> </b>
                        </div>

                        <div class="clearfix"></div>
                        <%session.removeAttribute("lasterror");
                            }%>
                        <div class="span8 main-c hide">     
                            <div style="width:100%" class="box" id="myModal">
                                <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                                    <img class="pull-left" src="img/glyphicons/png/glyphicons_298_hospital.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Patient Bill Search </h4> </a>
                                    <i class="pull-right icon-remove"> </i>
                                    <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                                </div>
                                <div id="chart_div" style="height: 100%; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden; display: block; margin: 0 auto; padding-top: 50px; padding-left: 20px; padding-right: 20px; padding-bottom: 50px;" class="box-body">

                                    <form class="form-horizontal" action="account_searchresults.jsp" method="post">
                                        <fieldset>
                                            <div class="control-group center">
                                                <h3> Search By </h3>
                                                <br />

                                                <select name="searchid">
                                                    <option value="patientid">Folder Number</option>
                                                 <!--   <option value="fullname">Patient First or Last Names</option>  -->
                                                </select>

                                            </div>

                                            <hr />

                                            <div class="clearfix"></div>
                                            <div class="center">

                                                <input type="text" placeholder="Please enter search query" class="input-xlarge"  name="searchquery"/>

                                                <br />
                                                <br />
                                                <br />



                                                <button type="submit" name="action" class="btn btn-small btn-info">
                                                    <i class="icon-white icon-search"></i> Search
                                                </button>
                                            </div>

                                        </fieldset>
                                    </form>




                                </div>
                              

                            </div> 
                        </div>

                        </section>

                        <footer style="display: none; margin-top: 50px;" class="footer">
                            <p style="text-align: center" class="pull-right">
                                <img src="images/logo.png" width="100px;" />
                            </p>
                        </footer>

                    </div><!-- /container -->



                    <div style="display: none;" id="dialog2" title="Patient Search">



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
                                },
                    
                   
                    
                                address: {
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
