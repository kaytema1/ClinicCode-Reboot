
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

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat emergencyPatient = new SimpleDateFormat("dd-MM-yyyy hh:mm");

            Date date = new Date();
            List visits = mgr.listRecentVisits(dateFormat.format(date));
        %>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            addcount = 0;
            function addProcedure(id1,id2) {
                //alert(id1);
                addcount++
                var t1 = document.getElementById(id1).value;
                //alert(t1);
                if( t1 != ""){
                    var tr = document.createElement("tr");
                    var td1 = document.createElement("td"); 
                    var td5 = document.createElement("td");
                    var td6 = document.createElement("td");
                    // var text = document.createTextNode(document.getElementById(id1).value);
                    var cb = document.createElement( "input" );
                    var btn = document.createElement( "button" );
                    btn.innerHTML = 'Remove';
                    cb.type = "checkbox";
                    cb.id = "id";
                    cb.name = "procedures";
                    var ttt = t1;
                    var str = t1.split("><");
                    var text = document.createTextNode(str[0]);
                    cb.value = ttt;
                    cb.checked = true;
                    td1.appendChild(text);
                    td6.appendChild(btn);
                
                    td5.appendChild(cb);
                    tr.appendChild(td1);
                    tr.id = "tr1_"+addcount;
                    tr.appendChild(td5);
                    tr.appendChild(td6);
                    document.getElementById( id2 ).appendChild( tr );
                }else {
                    alert("Please Select a Procedure!")
                }
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id2);
                    var rem = confirm("Are You Sure You Want To Remove The Procedure");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                }
            }
            
            
        </script>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">

                    <li class="active">
                        <a href="#">Procedures for Walk In Patients</a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section class="container-fluid" style="margin-top: -50px;" id="dashboard">

            <!-- Headings & Paragraph Copy -->



            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%> center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>



            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>

                <div style="display: none;" class="box span8 main-c " id="myModal">
                    <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                        <img class="pull-left" src="img/glyphicons/png/glyphicons_298_hospital.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Book Procedures For Walk Ins </h4> </a>
                        <i class="pull-right icon-remove"> </i>
                        <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                    </div>
                    <div id="chart_div" style="height: 100%; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden; display: block; margin: 0 auto; padding-top: 50px; padding-left: 20px; padding-right: 20px; padding-bottom: 50px;" class="box-body">
                        <form id="walkingprocedures" action="action/walkingprocedureaction.jsp" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">First Name</label>
                                <div class="controls">
                                    <input type="text" name="firstname"  placeholder="First Name">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Last Name</label>
                                <div class="controls">
                                    <input type="text" name="lastname"  placeholder="Last Name">
                                </div>
                            </div>
                            <div class="control-group gender_group">
                                <label class="control-label MustSel" for="input01">Gender *</label>
                                <div class="controls">
                                    <select class="MustSelectOpt input-small required" name="gender" id="gender">
                                        <option value="">Select</option>
                                        <option>Male</option>
                                        <option>Female</option>
                                    </select>

                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" for="dateofbirth">Date of Birth *</label>
                                <div class="controls">
                                    <select class="input-mini dob day" name="day" >
                                        <option vale="">D</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                        <option value="25">25</option>
                                        <option value="26">26</option>
                                        <option value="27">27</option>
                                        <option value="28">28</option>
                                        <option value="29">29</option>
                                        <option value="30">30</option>
                                        <option value="31">31</option>
                                    </select>

                                    <select class="input-mini dob month" name="month">
                                        <option value="">M</option>
                                        <option value="01">Jan</option>
                                        <option value="02">Feb</option>
                                        <option value="03">Mar</option>
                                        <option value="04">Apr</option>
                                        <option value="05">May</option>
                                        <option value="06">Jun</option>
                                        <option value="07">Jul</option>
                                        <option value="08">Aug</option>
                                        <option value="09">Sep</option>
                                        <option value="10">Oct</option>
                                        <option value="11">Nov</option>
                                        <option value="12">Dec</option>
                                    </select>



                                    <select class="input-small dob year" name="year">
                                        <option value="">Y</option>

                                    </select>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label pull-left" style="line-height: 25px;"  for="input01"> Select Procedure : </label>
                                <div class="controls">
                                    <select style="width: 70%" id="procedures">
                                        <option value="">Select Procedure </option>
                                        <%List procedures = mgr.listProcedure();
                                            for (int index = 0; index < procedures.size(); index++) {
                                                Procedure procedure = (Procedure) procedures.get(index);
                                        %>
                                        <option value="<%=procedure.getDescription()%>><<%=procedure.getCode()%>><<%=procedure.getPrice()%>"><%=procedure.getDescription()%></option>
                                        <%}%>
                                    </select>
                                    <div class="help-inline">
                                        <button type="button" id="addCheckBoxes" style="width: 100%" class="btn btn-info" onclick='addProcedure("procedures","procedure"); return false;'>
                                            <i class="icon-white icon-plus-sign"> </i>  Add 
                                        </button>
                                    </div>
                                </div>
                                <table id="procedure" class="table table-bordered">
                                    <tr style="padding: 12px 0px 12px 0px;">
                                        <th style="color: black; padding: 10px 0px 10px 0px; font-size: 13px;" colspan="8">
                                            Selected Procedures
                                        </th>
                                    </tr>
                                </table>

                                <div style="padding-left: 0px; padding-right: 0px;" class="form-actions center">
                                    <button style="width: 90%" type="submit" name="action" value="addwalkingprocedure" class="btn btn-info">Save changes</button>

                                </div>


                            </div>
                        </form>
                        <div class="clearfix"></div>

                    </div>  

                </div>

        </section>

        <%@include file="widgets/footer.jsp" %>

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
            
            $(':input').attr('autocomplete', 'off');
            
            $(".submit_button").click(function(){
                
                $(".MustSelectOpt").each(function(){
                   
                    var selectedid =  $(this).attr('id');
                    var selectedvalue = $(this).attr('value')
                    
                    if(selectedvalue==""){
                       
                        $('#'+selectedid).closest('.control-group').addClass('error').removeClass('success')
                    }
                    else{
                       
                        $('#'+selectedid).closest('.control-group').addClass('success').removeClass('error');
                    }
                   
                });
                
               
                
            });
            
            for (i = new Date().getFullYear(); i > 1900; i--)
            {                       
                $('.year').append($('<option />').val(i).html(i));
            }
            
            
            $('#sidebar-toggle').click(function(e) {
                e.preventDefault();
                $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                $('.menu').animate({width: 'toggle'}, 0);
                $('.menu').toggleClass('span3 hide');
                $('.main-c').toggleClass('span8');
                
            });
            
            
            
            $('#walkingprocedures').validate({
                rules: {
                    firstname: {
                        minlength: 2,
                        required: true
                    },
                    lastname: {
                        minlength: 2,
                        required: true
                    },
                    gender: {
                        required: true
                    },
                    day: {
                        required: true,
                        minlength :1
                    },
                    month: {
                        required: true,
                        minlength :1
                    },
                    year: {
                        required: true,
                        minlength :1
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
            
            
        
            
            
            
           
            $(function() {
                $('#country').selectToAutocomplete();
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');
            
            

                menu_ul.hide();

                $(".menu").fadeIn();
                $("#sidebar-toggle-container").fadeIn();
                $(".main-c").fadeIn();
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
            
            
            
        </script>

    </body>
</html>