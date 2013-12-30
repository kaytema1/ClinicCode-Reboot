<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            Users user = (Users) session.getAttribute("staff");
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
                            <a href="#">User Profile</a><span class="divider"></span>
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



                <div class="row">

                    <%
                        if ((staff.getRole() != 13) || (staff.getRole() != 9) || (staff.getRole() != 6)) {
                    %>
                    <%@include file="widgets/leftsidebar.jsp" %>


                    <% } else if ((staff.getRole() == 13) || (staff.getRole() == 9) || (staff.getRole() == 6)) {%>

                    <%@include file="widgets/laboratorywidget.jsp" %>

                    <%  }%>


                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <%if (session.getAttribute("lasterror") != null) {%>
                        <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                            <b>  <%=session.getAttribute("lasterror")%> </b>
                        </div>

                        <div class="clearfix"></div>
                        <%session.removeAttribute("lasterror");
                            }%>

                        <div style="padding-bottom: 80px;" class="span9">
                            <div style="width:100%" class="box" id="myModal">
                                <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                                    <img class="pull-left" src="img/glyphicons/png/glyphicons_003_user.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Staff Profile </h4> </a>
                                    <i class="pull-right icon-remove"> </i>
                                    <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                                </div>
                                <div id="chart_div" style=" margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden; display: block; margin: 0 auto; padding-top: 20px; padding-left: 20px; padding-right: 20px; padding-bottom: 50px;" class="box-body">


                                    <div style="margin-top: 12px; padding-top: 5px;  padding-bottom: 5px; text-align: center;" class="thumbnail span2 ">


                                        <%


                                            if (staff.getGender().equalsIgnoreCase("Male")) {%>


                                        <img src="img/default-facebook-avatar-male.gif" />


                                        <% } else {%>

                                        <img src="img/default-facebook-avatar-female.gif" />

                                        <% }%>

                                        <br />


                                        <button id="mydialog_link" type="button" class="btn btn-medium btn-info">
                                            <i class="icon-white icon-edit"></i> Update Profile
                                        </button>
                                    </div>




                                    <table style="font-size: 14px;" class="table-striped span6 table-bordered pull-left">
                                        <tr>
                                            <td style="width: 200px;"> Username</td>

                                            <td><b> <%= user.getUsername()%>   </b></td>
                                        </tr>
                                        <tr>
                                            <td> Full Name</td>

                                            <td><b> <%= staff.getLastname()%>   </b></td>
                                        </tr>
                                        <tr>
                                            <td> Date of Birth  </td>

                                            <td><b> <%= staff.getDob()%>  </b></td>
                                        </tr>
                                      

                                        <tr>
                                            <td> Role </td>

                                            <td><b> <%= mgr.getRoleByid(staff.getRole()).getRolename()%></b></td>
                                        </tr>
                                        <tr>
                                            <td> Role Description </td>

                                            <td><b style="text-transform: capitalize"> <%= mgr.getRoleByid(staff.getRole()).getRoledescription()%></b></td>
                                        </tr>
                                        <tr>
                                            <td> Phone No.  </td>

                                            <td><b> <%= staff.getContact()%>  </b></td>
                                        </tr>
                                        <tr>
                                            <td> Email Address  </td>

                                            <td><b> <%= staff.getEmail()%>  </b></td>
                                        </tr>
                                        <tr>
                                            <td> Address  </td>

                                            <td><b> <%= staff.getAddress()%>  </b></td>
                                        </tr>
                                        <tr>
                                            <td> Next of Kin  </td>

                                            <td><b> <%= staff.getNextofkin()%>  </b></td>
                                        </tr>
                                        <tr>
                                            <td> Next of Kin's Contact </td>

                                            <td><b> <%= staff.getNextofkincontact()%>  </b></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                    <br />



                                    <div class="clearfix"></div>
                                    <!-- <Br />
                                     <Br />
                                     <a href="outstandingbills.jsp">
                                         <div class="span3 center well large_button">
                                             <img style="margin-top: -4px; margin-right: 15px;" width="36px;" height="36px;"  src="images/icons/037.png" /> Outstanding Bills
                                         </div>
                                     </a>  -->
                                </div>
                                <div class="clearfix"></div>

                            </div>  
                        </div>
                    </div>
            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



        <div  id="mydialog" title="Update Details">

            <form id="updateprofile" class="form-horizontal" action="action/staffaction.jsp" method="post">
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="fname">Username</label>
                        <div class="controls">
                            <input class="text_input" readonly="readonly" type="text" name="username" value="<%= user.getUsername()%>"  />
                            <input class="text_input"  type="hidden" name="userid" value="<%= user.getStaffid()%>"  />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password">Password</label>
                        <div class="controls">
                            <input class="text_input" value="" type="password" name="password"  id="password"/>

                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="confirmpassword">Password Confirmation</label>
                        <div class="controls">
                            <input class="text_input"value="" type="password" name="confirmpassword"  id="confirmpassword"/>

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="contact">Phone No.</label>
                        <div class="controls">
                            <input class="text_input"value="<%=staff.getContact() %>" type="text" name="contact"  id="midname"/>

                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="email">Email</label>
                        <div class="controls">
                            <input class="text_input" type="text" value="<%=staff.getEmail() %>" name="email"  id="midname"/>

                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="address">Address</label>
                        <div class="controls">
                            <textarea class="text_input" type="text"  name="address" id="address"><%= staff.getAddress() %></textarea>

                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="emergencycontact">Next of Kin</label>
                        <div class="controls">
                            <input class="text_input" type="text" value="<%= staff.getNextofkin() %>" name="emergencyperson"  />

                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="emergencyperson">Next of Kin's Contact</label>
                        <div class="controls">
                            <input class="text_input" type="text"  name="emergencycontact"  value="<%= staff.getNextofkincontact()%>"/>

                        </div>
                    </div>




                    <div class="form-actions">
                        <button type="submit" name="action" value="staffupdate" class="btn btn-large btn-info">
                            <i class="icon-white icon-search"></i> Update
                        </button>
                    </div>

                </fieldset>
            </form>

        </div>
        <!--end static dialog-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltistaff.js"></script>
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
                
                
                
                
                
                $('#mydialog').dialog({
                    autoOpen : false,
                    width : 600,
                    modal : true
       
                });
    
                $('#mydialog_link').click(function() {
                    $('#mydialog').dialog('open');
                    return false;
                });
    
    
    
                $('#updateprofile').validate({
                    rules: {
                        username: {
                            minlength: 2,
                            required: true
                        },
                        password: {
                            minlength: 5,
                            required: true
                        },
                        confirmpassword: {
                            minlength: 5,
                            equalTo: "#password",
                            required: true
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
                        },
                        email: {
                            required: false,
                            email: true
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