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
                            <a href="#">Pharmacy Home</a><span class="divider"></span>
                        </li>


                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->



                <%if (session.getAttribute("lasterror") != null) {%>
                <div class="alert hide <%=session.getAttribute("class")%> center">
                    <b> <%=session.getAttribute("lasterror")%>  </b>
                </div>
                <br/>
                <div style="margin-bottom: 20px;" class="clearfix"></div>
                <%session.removeAttribute("lasterror");
                    }%>

                <div class="row-fluid">

                    <%
                        String perm = (String) session.getAttribute("unit");
                        int role = (Integer) session.getAttribute("role");
                        String[] perms = perm.split("_");
                    %>

                    <div style="margin-top: 0px; width: 100%; "class="content1 hide">

                        <div style="width:100%; overflow-x: hidden; overflow-y: hidden; " class="box" id="myModal">
                            <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                                <img class="pull-left" src="img/glyphicons/png/glyphicons_298_hospital.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Quick Links </h4> </a>
                                <i class="pull-right icon-remove"> </i>
                                <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                            </div>
                            <div id="chart_div" style="width: 100%; height: 100%; margin-top: -5px;  z-index: 1000; overflow-x: hidden; max-height: 100%; overflow-y: scroll; display: block; margin: 0 auto; padding-top: 50px; padding-left: 2%; padding-right: 10px; padding-bottom: 50px;" class="box-body">


                                <a href="prescriptionsales.jsp">
                                    <div style="margin-right: 5px;" class="span5  center pull-left  well large_button ">
                                        <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/001.png" />  Pharmacy Sales
                                    </div> 
                                </a>

                                <a href="addmedicine.jsp">
                                    <div style="margin-right: 5px;" class="span5  center pull-left  well large_button ">
                                        <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/024.png" />  Pharmacy Maintenance
                                    </div> 
                                </a>
                                <a href="clinicprescription.jsp">
                                    <div style="margin-right: 5px;" class="span5  center pull-left  well large_button ">
                                        <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/013.png" />  Clinic Referrals
                                    </div>
                                </a>
                                    <a href="pharmacysalesreport.jsp">
                                        <div style="margin-right: 5px;" class="span5  center pull-left  well large_button ">
                                            <img style="margin-top: -4px;" width= " 36px;" height="36px;" src="images/icons/013.png" />  Reports & Statistics
                                        </div> 
                                    </a>

                            </div>

                        </div>


                        <div class="clearfix"></div>

                    </div>  

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->

        <div style="max-height: 600px; display: none" id="registration_dialog" title="New Registration">

            <form id="registration" enctype="multipart/data"action="action/labregistrationaction.jsp" method="POST" class="form-horizontal well">
                <fieldset>
                    <div style="float: left;" class="pre_first_half">
                        <!-- <div class="control-group success">
                             <label class="control-label" for="input01">Folder No. / Patient ID </label>
                             <div class="controls">
                        <%String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                            String y = yr.substring(2);
                        %>
                        
                    </div>
                </div>-->


                        <div class="control-group">
                            <label class="control-label" for="fname">First Name</label>
                            <div class="controls">
                                <input  type="text" name="fname"  id="fname"/>

                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="midname">Other Names</label>
                            <div class="controls">
                                <input type="text" name="midname"  id="midname"/>

                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="lname">Last Name</label>
                            <div class="controls">
                                <input type="text" name="lname"  id="lname"/>

                            </div>
                        </div>

                        <div class="control-group gender_group">
                            <label class="control-label MustSel" for="input01">Gender</label>
                            <div class="controls">
                                <select class="MustSelectOpt" name="gender" id="gender">
                                    <option>Select</option>
                                    <option>Male</option>
                                    <option>Female</option>
                                </select>

                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="dateofbirth">Date of Birth</label>
                            <div class="controls">
                                <select class="input-mini dob" id="day" name="day" >
                                    <option>D</option>
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

                                <select class="input-mini dob" id="month" name="month">
                                    <option>M</option>
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



                                <select class="input-small dob" id="year" name="year">
                                    <option>Y</option>
                                    <option value="2004">2004</option>
                                    <option value="2003">2003</option>
                                    <option value="2002">2002</option>
                                    <option value="2001">2001</option>
                                    <option value="2000">2000</option>
                                    <option value="1999">1999</option>
                                    <option value="1998">1998</option>
                                    <option value="1997">1997</option>
                                    <option value="1996">1996</option>
                                    <option value="1995">1995</option>
                                    <option value="1994">1994</option>
                                    <option value="1993">1993</option>
                                    <option value="1992">1992</option>
                                    <option value="1991">1991</option>
                                    <option value="1990">1990</option>
                                    <option value="1989">1989</option>
                                    <option value="1988">1988</option>
                                    <option value="1987">1987</option>
                                    <option value="1986">1986</option>
                                    <option value="1985">1985</option>
                                    <option value="1984">1984</option>
                                    <option value="1983">1983</option>
                                    <option value="1982">1982</option>
                                    <option value="1981">1981</option>
                                    <option value="1980">1980</option>
                                    <option value="1979">1979</option>
                                    <option value="1978">1978</option>
                                    <option value="1977">1977</option>
                                    <option value="1976">1976</option>
                                    <option value="1975">1975</option>
                                    <option value="1974">1974</option>
                                    <option value="1973">1973</option>
                                    <option value="1972">1972</option>
                                    <option value="1971">1971</option>
                                    <option value="1970">1970</option>
                                    <option value="1969">1969</option>
                                    <option value="1968">1968</option>
                                    <option value="1967">1967</option>
                                    <option value="1966">1966</option>
                                    <option value="1965">1965</option>
                                    <option value="1964">1964</option>
                                    <option value="1963">1963</option>
                                    <option value="1962">1962</option>
                                    <option value="1961">1961</option>
                                    <option value="1960">1960</option>
                                    <option value="1959">1959</option>
                                    <option value="1958">1958</option>
                                    <option value="1957">1957</option>
                                    <option value="1956">1956</option>
                                    <option value="1955">1955</option>
                                    <option value="1954">1954</option>
                                    <option value="1953">1953</option>
                                    <option value="1952">1952</option>
                                    <option value="1951">1951</option>
                                    <option value="1950">1950</option>
                                    <option value="1949">1949</option>
                                    <option value="1948">1948</option>
                                    <option value="1947">1947</option>
                                    <option value="1946">1946</option>
                                    <option value="1945">1945</option>
                                    <option value="1944">1944</option>
                                    <option value="1943">1943</option>
                                    <option value="1942">1942</option>
                                    <option value="1941">1941</option>
                                    <option value="1940">1940</option>
                                    <option value="1939">1939</option>
                                    <option value="1938">1938</option>
                                    <option value="1937">1937</option>
                                    <option value="1936">1936</option>
                                    <option value="1935">1935</option>
                                    <option value="1934">1934</option>
                                    <option value="1933">1933</option>
                                    <option value="1932">1932</option>
                                    <option value="1931">1931</option>
                                    <option value="1930">1930</option>
                                    <option value="1929">1929</option>
                                    <option value="1928">1928</option>
                                    <option value="1927">1927</option>
                                    <option value="1926">1926</option>
                                    <option value="1925">1925</option>
                                    <option value="1924">1924</option>
                                    <option value="1923">1923</option>
                                    <option value="1922">1922</option>
                                    <option value="1921">1921</option>
                                    <option value="1920">1920</option>
                                    <option value="1919">1919</option>
                                    <option value="1918">1918</option>
                                    <option value="1917">1917</option>
                                    <option value="1916">1916</option>
                                    <option value="1915">1915</option>
                                    <option value="1914">1914</option>
                                    <option value="1913">1913</option>
                                    <option value="1912">1912</option>
                                    <option value="1911">1911</option>
                                    <option value="1910">1910</option>
                                    <option value="1909">1909</option>
                                    <option value="1908">1908</option>
                                    <option value="1907">1907</option>
                                    <option value="1906">1906</option>
                                    <option value="1905">1905</option>
                                    <option value="1904">1904</option>
                                    <option value="1903">1903</option>
                                    <option value="1902">1902</option>
                                    <option value="1901">1901</option>
                                    <option value="1900">1900</option>
                                </select>


                            </div>
                        </div>
                        <div class="control-group">
                            <label  class="control-label MustSel">Marital Status</label>
                            <div class="controls">
                                <select class="MustSelectOpt" name="maritalstatus" id="martialstatus">
                                    <option>Select</option>
                                    <option>Married</option>
                                    <option>Single</option>
                                    <option>Divorced</option>
                                    <option>Separated</option>
                                </select>

                            </div>
                        </div>

                    </div>
                    <div style="float: left;" class="second">            
                        <div class="control-group">
                            <label class="control-label MustSel"  for="input01">Country</label>
                            <div class="controls">
                                <select class="MustSelectOpt" name="country" id="country">
                                    <option >Select</option>
                                    <option>Ghana</option>
                                    <option>Togo</option>
                                    <option>Benin</option>
                                </select>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="city">City</label>
                            <div class="controls">
                                <input type="text" name="city" id="city"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="address">Address</label>
                            <div class="controls">
                                <textarea type="text" name="address" id="address"></textarea>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" >Email</label>
                            <div class="controls">
                                <input type="text" name="email" id="email"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Telephone No.</label>
                            <div class="controls">
                                <input type="text" name="contact" id="contact"/>

                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Emergency Person.</label>
                            <div class="controls">
                                <input type="text" name="emergencyperson" id="emergencyperson"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Emergency Tel. No.</label>
                            <div class="controls">
                                <input type="text" name="emergencycontact" id="emergencycontact"/>

                            </div>
                        </div>
                    </div>
                    <div style="float: left;" class=" third_third">
                        <div class="control-group">
                            <label class="control-label" for="employer">Employer</label>
                            <div class="controls">
                                <input type="text" name="employer" id="inputSuccess"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label MustSel"  for="type">Sponsorship Method</label>
                            <div class="controls">
                                <select class="MustSelectOpt" id="payment" name="type">
                                    <option>Select</option>
                                    <option id="nhis" value="NHIS" onclick="showInsurance()">National Health Insurance</option>
                                    <option id="cash" value="CASH" onclick="hideIt()">Out of Pocket </option>
                                    <option id="private"value="Private" onclick="showMembershipbox()">Private Health Insurance</option>
                                    <option id="corporate" value="Cooperate" onclick="showCorporate()">Cooperate</option>
                                </select>

                            </div>
                        </div>

                        <div style="display:none;" id="companydiv">
                            <div class="control-group">
                                <label class="control-label" >Company</label>
                                <div class="controls">


                                    <select id="coperate" name="coperate">

                                        <%

                                            List companies = mgr.listCooperateInsurers();
                                            for (int i = 0; i < companies.size(); i++) {
                                                Sponsorship sponsor = (Sponsorship) companies.get(i);
                                        %>
                                        <option value="<%=sponsor.getSponshorshipid()%>"><%=sponsor.getSponsorname()%></option>
                                        <% }

                                        %>

                                    </select>

                                </div>
                            </div>

                            <div class="control-group">
                                <label for="coperateid" class="control-label" >Corporate ID</label>
                                <div class="controls">
                                    <input type="text" id="coperateid" name="coperateid" for="coperateid" value=""/>

                                </div>
                            </div>
                        </div>
                        <div style="display:none;" id="privatediv">
                            <div class="control-group">
                                <label class="control-label">Sponsors</label>
                                <div class="controls">
                                    <select name="sponsorid" id="sponsor">

                                        <%

                                            List Sponsors = mgr.listPrivateSponsors();
                                            for (int i = 0; i < Sponsors.size(); i++) {
                                                Sponsorship sponsor = (Sponsorship) Sponsors.get(i);
                                        %>
                                        <option value="<%=sponsor.getSponshorshipid()%>"><%=sponsor.getSponsorname()%></option>
                                        <% }

                                        %>

                                    </select>
                                </div>
                            </div>

                            <div class="control-group">
                                <label for="membershipid" class="control-label" >Membership ID</label>
                                <div class="controls">
                                    <input type="text" class="input-medium" id="membershipid"name="membershipid" for="membershipid" value=""/>

                                </div>
                            </div>

                            <div class="control-group">
                                <label for="benefitplan" class="control-label" >Benefit Plan</label>
                                <div class="controls">
                                    <input type="text" id="benefitplan" name="benefitplan" for="benefitplan" value=""/>

                                </div>
                            </div>
                        </div>
                        <div style="display:none;" id="nhisdiv">
                            <div class="control-group">
                                <label for="nhismembershipid" class="control-label" >Membership ID</label>
                                <div class="controls">
                                    <input type="text" id="nhismembershipid" name="nhismembershipid" for="nhismembershipid" value=""/><br/>
                                    <input type="hidden" id="sponsorid" name="nhisid" for="nhismembershipid" value="<%= mgr.getNHISID().getSponshorshipid()%>"/>
                                    <input type="hidden" id="outofpocketpid" name="outofpocketpid" for="outofpocketpid" value="<%= mgr.getCASHID().getSponshorshipid()%>"/>

                                </div>
                            </div>

                        </div>


                    </div>
                </fieldset>
                <div style="text-align: center;">
                    <button type="submit" name ="action" value="patient" class="btn btn-danger btn-large submit_button">
                        <i class="icon-ok icon-white"></i> Save changes
                    </button>

                </div>

            </form>
        </div>

        <div style="display: none;" id="dialog2" title="Patient Search">

            <form class="form-horizontal" action="labpatientsearch.jsp" method="post">
                <fieldset>
                    <div class="control-group center">
                        <h3> Search By </h3>
                        <br />

                        <select name="searchid">
                            <option value="patientid">Patient ID/Folder No.</option>
                            <option value="fullname">Patient First or Last Names</option>
                            <option value="memberdshipnumber">Policy No.</option>
                            <option value="dob">Date of Birth(0000-00-00)</option>
                        </select>

                    </div>

                    <hr />

                    <div class="clearfix"></div>
                    <div class="center">

                        <input type="text" placeholder="Please enter search query" class="input-xlarge"  name="searchquery"/>

                        <br />
                        <br />
                        <br />



                        <button type="submit" name="action" class="btn btn-large btn-info">
                            <i class="icon-white icon-search"></i> Search
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
            
            
            $("#year").change(function(){
                
                
                if ($('#year').attr('value')!="Y"){
                    $('#year').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#year').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
            
            
               
               
               
           
            $(function() {
            
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