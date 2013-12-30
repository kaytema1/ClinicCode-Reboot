<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            // List lists = (List) session.getAttribute("staffPermission");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            HMSHelper mgr = new HMSHelper();
            ExtendedHMSHelper mg1 = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

            Date date = new Date();
            List visits = mgr.listRecentVisits(dateFormat.format(date));
            List listorders = mg1.listTransitLabs();

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
                            <a href="#">Laboratory Reception</a><span class="divider"></span>
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


                    <%@include file="widgets/laboratorywidget.jsp" %>

                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <%if (session.getAttribute("lasterror") != null) {%>

                        <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                            <b>  <%=session.getAttribute("lasterror")%>    


                            </b>


                        </div>

                        <form style="padding: 0px; margin: 0px;" class="form-horizontal"  action="labpatientsearch.jsp" method="post">
                            <input type="hidden" name="searchid"  value="<%=session.getAttribute("patient")%> " />
                            <input type="hidden" placeholder="Please Enter Search Query" class="input-xlarge" value="<%=session.getAttribute("patient")%>"  name="searchquery"/>
                            <%if (permissions.contains(6)) {%>
                            <button type="button" class="link btn-small">
                                <i class="icon-arrow-right icon-white"></i>  Visit 
                            </button>
                            <%}%>
                        </form>

                        <div class="clearfix"></div>


                        <%session.removeAttribute("lasterror");
                            }%>

                        <div style="padding-bottom: 80px;" class="span9">
                            <div style="width:100%" class="box" id="myModal">
                                <div class="modal-header" style="height: 20px; background-color: #F8F8F8; z-index: 1500;">

                                    <img class="pull-left" src="img/glyphicons/png/glyphicons_298_hospital.png" /><a class="pull-left" style=" padding-left: 5px; padding-top: 2px;"> <h4> Quick Actions </h4> </a>
                                    <i class="pull-right icon-remove"> </i>
                                    <i style="padding-right: 5px;" class="pull-right icon-chevron-down"> </i>
                                </div>
                                <div id="chart_div" style="height: 100%; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden; display: block; margin: 0 auto; padding-top: 50px; padding-left: 20px; padding-right: 20px; padding-bottom: 50px;" class="box-body">

                                    <%if (permissions.contains(21) || permissions.contains(7)) {%>
                                    <a href="#">
                                        <div class="span3  center  well large_button registration_dialog_link">
                                            <img style="margin-top: -4px;" width= " 36px;" src="images/icons/041.png" />  Registration 
                                        </div> 
                                    </a>
                                    <%}%>
                                    <%if (permissions.contains(6)) {%>
                                    <a href="#">
                                        <div class="dialog_link2 span3 offset1 center  well large_button">
                                            <img style="margin-top: -4px;" width= " 36px;" src="images/icons/042.png" />  Find Lab Patient 
                                        </div> 
                                    </a>
                                    <%}%>
                                    <div class="clearfix"></div>
                                    <br />
                                    <br />


                                    <div class="clearfix"></div>
                                    <%if (permissions.contains(6)) {%>
                                    <a href="fromclinic.jsp">
                                        <div class="span3 center well large_button">
                                            <img style="margin-top: -4px;" width= " 36px;" src="images/icons/021.png" />
                                            <%if (listorders.size() > 0) {%>
                                            Clinic Requests <span style="margin-left: 10px;" class="badge_b"><%=listorders.size()%> </span>
                                            <%} else {%> Clinic Requests <span style="margin-left: 10px;" class="badge_b">0</span> <%}%>
                                        </div> 
                                    </a>
                                    <%}%>
                                    <%if (permissions.contains(24)) {%>
                                    <a href="readyfordispatch.jsp">
                                        <div class="span3 offset1  center well large_button">
                                            <img style="margin-top: -4px;" width= " 33px;" src="images/icons/031.png" />

                                            Lab Results <span style="margin-left: 10px;" class="badge_b"><%=newLabs.size()%> </span>

                                        </div> 
                                    </a>
                                    <%}%>
                                    <!--   <div class="clearfix"></div>
                                       <br />
                                       <br />
                                       <div class="clearfix"></div>
                                       <a href="laboutstandingbills.jsp">
                                           <div class="span3 center well large_button">
                                               <img style="margin-top: -4px;" width= " 36px;" src="images/icons/031.png" />
                                    <% if (mgr.listOutstanding().size() > 0) {%>
                                    Outstanding Bills<span style="margin-left: 10px;" class="badge_b"><%=mgr.listOutstanding().size()%> </span>
                                    <% } else {%>
                                    No Outstanding Bills
                                    <%}%>
                                </div> 
                            </a>
                        </div> -->
                                    <div class="clearfix"></div>


                                </div>  
                            </div>  
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
                            <label class="control-label" for="fname">First Name *</label>
                            <div class="controls">
                                <input class="input-medium"  type="text" name="fname"  id="fname"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="midname">Middle Name</label>
                            <div class="controls">
                                <input class="input-medium"  type="text" name="midname"  id="midname"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="lname">Last Name *</label>
                            <div class="controls">
                                <input class="input-medium"  type="text" name="lname"  id="lname"/>

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
                                <select class="input-mini dob" id="day" name="day" >
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

                                <select class="input-mini dob" id="month" name="month">
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



                                <select class="input-small dob" id="year" name="year">
                                    <option value="">Y</option>

                                </select>


                            </div>
                        </div>
                        <div class="control-group">
                            <label  class="control-label MustSel">Marital Status</label>
                            <div class="controls">
                                <select class="MustSelectOpt input-medium required" name="maritalstatus" id="martialstatus">
                                    <option value="">Select</option>
                                    <option value="Divorced">Divorced</option>
                                    <option value="Married">Married</option>
                                    <option value="Minor">Minor</option>
                                    <option value="Separated">Separated</option>
                                    <option value="Single">Single</option>
                                </select>

                            </div>
                        </div>



                    </div>
                    <div style="float: left;" class="second">            
                        <div class="control-group">
                            <label class="control-label MustSel"  for="input01">Country *</label>
                            <div class="controls">
                                <select class="MustSelectOpt input-medium" name="country" id="country">
                                    <option value="Ghana" data-alternative-spellings="GH">Ghana</option>
                                    <option value="Afghanistan" data-alternative-spellings="AF افغانستان">Afghanistan</option>
                                    <option value="Åland Islands" data-alternative-spellings="AX Aaland Aland" data-relevancy-booster="0.5">Åland Islands</option>
                                    <option value="Albania" data-alternative-spellings="AL">Albania</option>
                                    <option value="Algeria" data-alternative-spellings="DZ الجزائر">Algeria</option>
                                    <option value="American Samoa" data-alternative-spellings="AS" data-relevancy-booster="0.5">American Samoa</option>
                                    <option value="Andorra" data-alternative-spellings="AD" data-relevancy-booster="0.5">Andorra</option>
                                    <option value="Angola" data-alternative-spellings="AO">Angola</option>
                                    <option value="Anguilla" data-alternative-spellings="AI" data-relevancy-booster="0.5">Anguilla</option>
                                    <option value="Antarctica" data-alternative-spellings="AQ" data-relevancy-booster="0.5">Antarctica</option>
                                    <option value="Antigua And Barbuda" data-alternative-spellings="AG" data-relevancy-booster="0.5">Antigua And Barbuda</option>
                                    <option value="Argentina" data-alternative-spellings="AR">Argentina</option>
                                    <option value="Armenia" data-alternative-spellings="AM Հայաստան">Armenia</option>
                                    <option value="Aruba" data-alternative-spellings="AW" data-relevancy-booster="0.5">Aruba</option>
                                    <option value="Australia" data-alternative-spellings="AU" data-relevancy-booster="1.5">Australia</option>
                                    <option value="Austria" data-alternative-spellings="AT Österreich Osterreich Oesterreich ">Austria</option>
                                    <option value="Azerbaijan" data-alternative-spellings="AZ">Azerbaijan</option>
                                    <option value="Bahamas" data-alternative-spellings="BS">Bahamas</option>
                                    <option value="Bahrain" data-alternative-spellings="BH البحرين">Bahrain</option>
                                    <option value="Bangladesh" data-alternative-spellings="BD বাংলাদেশ" data-relevancy-booster="2">Bangladesh</option>
                                    <option value="Barbados" data-alternative-spellings="BB">Barbados</option>
                                    <option value="Belarus" data-alternative-spellings="BY Беларусь">Belarus</option>
                                    <option value="Belgium" data-alternative-spellings="BE België Belgie Belgien Belgique" data-relevancy-booster="1.5">Belgium</option>
                                    <option value="Belize" data-alternative-spellings="BZ">Belize</option>
                                    <option value="Benin" data-alternative-spellings="BJ">Benin</option>
                                    <option value="Bermuda" data-alternative-spellings="BM" data-relevancy-booster="0.5">Bermuda</option>
                                    <option value="Bhutan" data-alternative-spellings="BT भूटान">Bhutan</option>
                                    <option value="Bolivia" data-alternative-spellings="BO">Bolivia</option>
                                    <option value="Bonaire, Sint Eustatius and Saba" data-alternative-spellings="BQ">Bonaire, Sint Eustatius and Saba</option>
                                    <option value="Bosnia and Herzegovina" data-alternative-spellings="BA Босна и Херцеговина">Bosnia and Herzegovina</option>
                                    <option value="Botswana" data-alternative-spellings="BW">Botswana</option>
                                    <option value="Bouvet Island" data-alternative-spellings="BV">Bouvet Island</option>
                                    <option value="Brazil" data-alternative-spellings="BR Brasil" data-relevancy-booster="2">Brazil</option>
                                    <option value="British Indian Ocean Territory" data-alternative-spellings="IO">British Indian Ocean Territory</option>
                                    <option value="Brunei Darussalam" data-alternative-spellings="BN">Brunei Darussalam</option>
                                    <option value="Bulgaria" data-alternative-spellings="BG България">Bulgaria</option>
                                    <option value="Burkina Faso" data-alternative-spellings="BF">Burkina Faso</option>
                                    <option value="Burundi" data-alternative-spellings="BI">Burundi</option>
                                    <option value="Cambodia" data-alternative-spellings="KH កម្ពុជា">Cambodia</option>
                                    <option value="Cameroon" data-alternative-spellings="CM">Cameroon</option>
                                    <option value="Canada" data-alternative-spellings="CA" data-relevancy-booster="2">Canada</option>
                                    <option value="Cape Verde" data-alternative-spellings="CV Cabo">Cape Verde</option>
                                    <option value="Cayman Islands" data-alternative-spellings="KY" data-relevancy-booster="0.5">Cayman Islands</option>
                                    <option value="Central African Republic" data-alternative-spellings="CF">Central African Republic</option>
                                    <option value="Chad" data-alternative-spellings="TD تشاد‎ Tchad">Chad</option>
                                    <option value="Chile" data-alternative-spellings="CL">Chile</option>
                                    <option value="China" data-relevancy-booster="3.5" data-alternative-spellings="CN Zhongguo Zhonghua Peoples Republic 中国/中华">China</option>
                                    <option value="Christmas Island" data-alternative-spellings="CX" data-relevancy-booster="0.5">Christmas Island</option>
                                    <option value="Cocos (Keeling) Islands" data-alternative-spellings="CC" data-relevancy-booster="0.5">Cocos (Keeling) Islands</option>
                                    <option value="Colombia" data-alternative-spellings="CO">Colombia</option>
                                    <option value="Comoros" data-alternative-spellings="KM جزر القمر">Comoros</option>
                                    <option value="Congo" data-alternative-spellings="CG">Congo</option>
                                    <option value="Congo, the Democratic Republic of the" data-alternative-spellings="CD Congo-Brazzaville Repubilika ya Kongo">Congo, the Democratic Republic of the</option>
                                    <option value="Cook Islands" data-alternative-spellings="CK" data-relevancy-booster="0.5">Cook Islands</option>
                                    <option value="Costa Rica" data-alternative-spellings="CR">Costa Rica</option>
                                    <option value="Côte d'Ivoire" data-alternative-spellings="CI Cote dIvoire">Côte d'Ivoire</option>
                                    <option value="Croatia" data-alternative-spellings="HR Hrvatska">Croatia</option>
                                    <option value="Cuba" data-alternative-spellings="CU">Cuba</option>
                                    <option value="Curaçao" data-alternative-spellings="CW Curacao">Curaçao</option>
                                    <option value="Cyprus" data-alternative-spellings="CY Κύπρος Kýpros Kıbrıs">Cyprus</option>
                                    <option value="Czech Republic" data-alternative-spellings="CZ Česká Ceska">Czech Republic</option>
                                    <option value="Denmark" data-alternative-spellings="DK Danmark" data-relevancy-booster="1.5">Denmark</option>
                                    <option value="Djibouti" data-alternative-spellings="DJ جيبوتي‎ Jabuuti Gabuuti">Djibouti</option>
                                    <option value="Dominica" data-alternative-spellings="DM Dominique" data-relevancy-booster="0.5">Dominica</option>
                                    <option value="Dominican Republic" data-alternative-spellings="DO">Dominican Republic</option>
                                    <option value="Ecuador" data-alternative-spellings="EC">Ecuador</option>
                                    <option value="Egypt" data-alternative-spellings="EG" data-relevancy-booster="1.5">Egypt</option>
                                    <option value="El Salvador" data-alternative-spellings="SV">El Salvador</option>
                                    <option value="Equatorial Guinea" data-alternative-spellings="GQ">Equatorial Guinea</option>
                                    <option value="Eritrea" data-alternative-spellings="ER إرتريا ኤርትራ">Eritrea</option>
                                    <option value="Estonia" data-alternative-spellings="EE Eesti">Estonia</option>
                                    <option value="Ethiopia" data-alternative-spellings="ET ኢትዮጵያ">Ethiopia</option>
                                    <option value="Falkland Islands (Malvinas)" data-alternative-spellings="FK" data-relevancy-booster="0.5">Falkland Islands (Malvinas)</option>
                                    <option value="Faroe Islands" data-alternative-spellings="FO Føroyar Færøerne" data-relevancy-booster="0.5">Faroe Islands</option>
                                    <option value="Fiji" data-alternative-spellings="FJ Viti फ़िजी">Fiji</option>
                                    <option value="Finland" data-alternative-spellings="FI Suomi">Finland</option>
                                    <option value="France" data-alternative-spellings="FR République française" data-relevancy-booster="2.5">France</option>
                                    <option value="French Guiana" data-alternative-spellings="GF">French Guiana</option>
                                    <option value="French Polynesia" data-alternative-spellings="PF Polynésie française">French Polynesia</option>
                                    <option value="French Southern Territories" data-alternative-spellings="TF">French Southern Territories</option>
                                    <option value="Gabon" data-alternative-spellings="GA République Gabonaise">Gabon</option>
                                    <option value="Gambia" data-alternative-spellings="GM">Gambia</option>
                                    <option value="Georgia" data-alternative-spellings="GE საქართველო">Georgia</option>
                                    <option value="Germany" data-alternative-spellings="DE Bundesrepublik Deutschland" data-relevancy-booster="3">Germany</option>

                                    <option value="Gibraltar" data-alternative-spellings="GI" data-relevancy-booster="0.5">Gibraltar</option>
                                    <option value="Greece" data-alternative-spellings="GR Ελλάδα" data-relevancy-booster="1.5">Greece</option>
                                    <option value="Greenland" data-alternative-spellings="GL grønland" data-relevancy-booster="0.5">Greenland</option>
                                    <option value="Grenada" data-alternative-spellings="GD">Grenada</option>
                                    <option value="Guadeloupe" data-alternative-spellings="GP">Guadeloupe</option>
                                    <option value="Guam" data-alternative-spellings="GU">Guam</option>
                                    <option value="Guatemala" data-alternative-spellings="GT">Guatemala</option>
                                    <option value="Guernsey" data-alternative-spellings="GG" data-relevancy-booster="0.5">Guernsey</option>
                                    <option value="Guinea" data-alternative-spellings="GN">Guinea</option>
                                    <option value="Guinea-Bissau" data-alternative-spellings="GW">Guinea-Bissau</option>
                                    <option value="Guyana" data-alternative-spellings="GY">Guyana</option>
                                    <option value="Haiti" data-alternative-spellings="HT">Haiti</option>
                                    <option value="Heard Island and McDonald Islands" data-alternative-spellings="HM">Heard Island and McDonald Islands</option>
                                    <option value="Holy See (Vatican City State)" data-alternative-spellings="VA" data-relevancy-booster="0.5">Holy See (Vatican City State)</option>
                                    <option value="Honduras" data-alternative-spellings="HN">Honduras</option>
                                    <option value="Hong Kong" data-alternative-spellings="HK 香港">Hong Kong</option>
                                    <option value="Hungary" data-alternative-spellings="HU Magyarország">Hungary</option>
                                    <option value="Iceland" data-alternative-spellings="IS Island">Iceland</option>
                                    <option value="India" data-alternative-spellings="IN भारत गणराज्य Hindustan" data-relevancy-booster="3">India</option>
                                    <option value="Indonesia" data-alternative-spellings="ID" data-relevancy-booster="2">Indonesia</option>
                                    <option value="Iran, Islamic Republic of" data-alternative-spellings="IR ایران">Iran, Islamic Republic of</option>
                                    <option value="Iraq" data-alternative-spellings="IQ العراق‎">Iraq</option>
                                    <option value="Ireland" data-alternative-spellings="IE Éire" data-relevancy-booster="1.2">Ireland</option>
                                    <option value="Isle of Man" data-alternative-spellings="IM" data-relevancy-booster="0.5">Isle of Man</option>
                                    <option value="Israel" data-alternative-spellings="IL إسرائيل ישראל">Israel</option>
                                    <option value="Italy" data-alternative-spellings="IT Italia" data-relevancy-booster="2">Italy</option>
                                    <option value="Jamaica" data-alternative-spellings="JM">Jamaica</option>
                                    <option value="Japan" data-alternative-spellings="JP Nippon Nihon 日本" data-relevancy-booster="2.5">Japan</option>
                                    <option value="Jersey" data-alternative-spellings="JE" data-relevancy-booster="0.5">Jersey</option>
                                    <option value="Jordan" data-alternative-spellings="JO الأردن">Jordan</option>
                                    <option value="Kazakhstan" data-alternative-spellings="KZ Қазақстан Казахстан">Kazakhstan</option>
                                    <option value="Kenya" data-alternative-spellings="KE">Kenya</option>
                                    <option value="Kiribati" data-alternative-spellings="KI">Kiribati</option>
                                    <option value="Korea, Democratic People's Republic of" data-alternative-spellings="KP North Korea">Korea, Democratic People's Republic of</option>
                                    <option value="Korea, Republic of" data-alternative-spellings="KR South Korea" data-relevancy-booster="1.5">Korea, Republic of</option>
                                    <option value="Kuwait" data-alternative-spellings="KW الكويت">Kuwait</option>
                                    <option value="Kyrgyzstan" data-alternative-spellings="KG Кыргызстан">Kyrgyzstan</option>
                                    <option value="Lao People's Democratic Republic" data-alternative-spellings="LA">Lao People's Democratic Republic</option>
                                    <option value="Latvia" data-alternative-spellings="LV Latvija">Latvia</option>
                                    <option value="Lebanon" data-alternative-spellings="LB لبنان">Lebanon</option>
                                    <option value="Lesotho" data-alternative-spellings="LS">Lesotho</option>
                                    <option value="Liberia" data-alternative-spellings="LR">Liberia</option>
                                    <option value="Libyan Arab Jamahiriya" data-alternative-spellings="LY ليبيا">Libyan Arab Jamahiriya</option>
                                    <option value="Liechtenstein" data-alternative-spellings="LI">Liechtenstein</option>
                                    <option value="Lithuania" data-alternative-spellings="LT Lietuva">Lithuania</option>
                                    <option value="Luxembourg" data-alternative-spellings="LU">Luxembourg</option>
                                    <option value="Macao" data-alternative-spellings="MO">Macao</option>
                                    <option value="Macedonia, The Former Yugoslav Republic Of" data-alternative-spellings="MK Македонија">Macedonia, The Former Yugoslav Republic Of</option>
                                    <option value="Madagascar" data-alternative-spellings="MG Madagasikara">Madagascar</option>
                                    <option value="Malawi" data-alternative-spellings="MW">Malawi</option>
                                    <option value="Malaysia" data-alternative-spellings="MY">Malaysia</option>
                                    <option value="Maldives" data-alternative-spellings="MV">Maldives</option>
                                    <option value="Mali" data-alternative-spellings="ML">Mali</option>
                                    <option value="Malta" data-alternative-spellings="MT">Malta</option>
                                    <option value="Marshall Islands" data-alternative-spellings="MH" data-relevancy-booster="0.5">Marshall Islands</option>
                                    <option value="Martinique" data-alternative-spellings="MQ">Martinique</option>
                                    <option value="Mauritania" data-alternative-spellings="MR الموريتانية">Mauritania</option>
                                    <option value="Mauritius" data-alternative-spellings="MU">Mauritius</option>
                                    <option value="Mayotte" data-alternative-spellings="YT">Mayotte</option>
                                    <option value="Mexico" data-alternative-spellings="MX Mexicanos" data-relevancy-booster="1.5">Mexico</option>
                                    <option value="Micronesia, Federated States of" data-alternative-spellings="FM">Micronesia, Federated States of</option>
                                    <option value="Moldova, Republic of" data-alternative-spellings="MD">Moldova, Republic of</option>
                                    <option value="Monaco" data-alternative-spellings="MC">Monaco</option>
                                    <option value="Mongolia" data-alternative-spellings="MN Mongγol ulus Монгол улс">Mongolia</option>
                                    <option value="Montenegro" data-alternative-spellings="ME">Montenegro</option>
                                    <option value="Montserrat" data-alternative-spellings="MS" data-relevancy-booster="0.5">Montserrat</option>
                                    <option value="Morocco" data-alternative-spellings="MA المغرب">Morocco</option>
                                    <option value="Mozambique" data-alternative-spellings="MZ Moçambique">Mozambique</option>
                                    <option value="Myanmar" data-alternative-spellings="MM">Myanmar</option>
                                    <option value="Namibia" data-alternative-spellings="NA Namibië">Namibia</option>
                                    <option value="Nauru" data-alternative-spellings="NR Naoero" data-relevancy-booster="0.5">Nauru</option>
                                    <option value="Nepal" data-alternative-spellings="NP नेपाल">Nepal</option>
                                    <option value="Netherlands" data-alternative-spellings="NL Holland Nederland" data-relevancy-booster="1.5">Netherlands</option>
                                    <option value="New Caledonia" data-alternative-spellings="NC" data-relevancy-booster="0.5">New Caledonia</option>
                                    <option value="New Zealand" data-alternative-spellings="NZ Aotearoa">New Zealand</option>
                                    <option value="Nicaragua" data-alternative-spellings="NI">Nicaragua</option>
                                    <option value="Niger" data-alternative-spellings="NE Nijar">Niger</option>
                                    <option value="Nigeria" data-alternative-spellings="NG Nijeriya Naíjíríà" data-relevancy-booster="1.5">Nigeria</option>
                                    <option value="Niue" data-alternative-spellings="NU" data-relevancy-booster="0.5">Niue</option>
                                    <option value="Norfolk Island" data-alternative-spellings="NF" data-relevancy-booster="0.5">Norfolk Island</option>
                                    <option value="Northern Mariana Islands" data-alternative-spellings="MP" data-relevancy-booster="0.5">Northern Mariana Islands</option>
                                    <option value="Norway" data-alternative-spellings="NO Norge Noreg" data-relevancy-booster="1.5">Norway</option>
                                    <option value="Oman" data-alternative-spellings="OM عمان">Oman</option>
                                    <option value="Pakistan" data-alternative-spellings="PK پاکستان" data-relevancy-booster="2">Pakistan</option>
                                    <option value="Palau" data-alternative-spellings="PW" data-relevancy-booster="0.5">Palau</option>
                                    <option value="Palestinian Territory, Occupied" data-alternative-spellings="PS فلسطين">Palestinian Territory, Occupied</option>
                                    <option value="Panama" data-alternative-spellings="PA">Panama</option>
                                    <option value="Papua New Guinea" data-alternative-spellings="PG">Papua New Guinea</option>
                                    <option value="Paraguay" data-alternative-spellings="PY">Paraguay</option>
                                    <option value="Peru" data-alternative-spellings="PE">Peru</option>
                                    <option value="Philippines" data-alternative-spellings="PH Pilipinas" data-relevancy-booster="1.5">Philippines</option>
                                    <option value="Pitcairn" data-alternative-spellings="PN" data-relevancy-booster="0.5">Pitcairn</option>
                                    <option value="Poland" data-alternative-spellings="PL Polska" data-relevancy-booster="1.25">Poland</option>
                                    <option value="Portugal" data-alternative-spellings="PT Portuguesa" data-relevancy-booster="1.5">Portugal</option>
                                    <option value="Puerto Rico" data-alternative-spellings="PR">Puerto Rico</option>
                                    <option value="Qatar" data-alternative-spellings="QA قطر">Qatar</option>
                                    <option value="Réunion" data-alternative-spellings="RE Reunion">Réunion</option>
                                    <option value="Romania" data-alternative-spellings="RO Rumania Roumania România">Romania</option>
                                    <option value="Russian Federation" data-alternative-spellings="RU Rossiya Российская Россия" data-relevancy-booster="2.5">Russian Federation</option>
                                    <option value="Rwanda" data-alternative-spellings="RW">Rwanda</option>
                                    <option value="Saint Barthélemy" data-alternative-spellings="BL St. Barthelemy">Saint Barthélemy</option>
                                    <option value="Saint Helena" data-alternative-spellings="SH St.">Saint Helena</option>
                                    <option value="Saint Kitts and Nevis" data-alternative-spellings="KN St.">Saint Kitts and Nevis</option>
                                    <option value="Saint Lucia" data-alternative-spellings="LC St.">Saint Lucia</option>
                                    <option value="Saint Martin (French Part)" data-alternative-spellings="MF St.">Saint Martin (French Part)</option>
                                    <option value="Saint Pierre and Miquelon" data-alternative-spellings="PM St.">Saint Pierre and Miquelon</option>
                                    <option value="Saint Vincent and the Grenadines" data-alternative-spellings="VC St.">Saint Vincent and the Grenadines</option>
                                    <option value="Samoa" data-alternative-spellings="WS">Samoa</option>
                                    <option value="San Marino" data-alternative-spellings="SM">San Marino</option>
                                    <option value="Sao Tome and Principe" data-alternative-spellings="ST">Sao Tome and Principe</option>
                                    <option value="Saudi Arabia" data-alternative-spellings="SA السعودية">Saudi Arabia</option>
                                    <option value="Senegal" data-alternative-spellings="SN Sénégal">Senegal</option>
                                    <option value="Serbia" data-alternative-spellings="RS Србија Srbija">Serbia</option>
                                    <option value="Seychelles" data-alternative-spellings="SC" data-relevancy-booster="0.5">Seychelles</option>
                                    <option value="Sierra Leone" data-alternative-spellings="SL">Sierra Leone</option>
                                    <option value="Singapore" data-alternative-spellings="SG Singapura  சிங்கப்பூர் குடியரசு 新加坡共和国">Singapore</option>
                                    <option value="Sint Maarten (Dutch Part)" data-alternative-spellings="SX">Sint Maarten (Dutch Part)</option>
                                    <option value="Slovakia" data-alternative-spellings="SK Slovenská Slovensko">Slovakia</option>
                                    <option value="Slovenia" data-alternative-spellings="SI Slovenija">Slovenia</option>
                                    <option value="Solomon Islands" data-alternative-spellings="SB">Solomon Islands</option>
                                    <option value="Somalia" data-alternative-spellings="SO الصومال">Somalia</option>
                                    <option value="South Africa" data-alternative-spellings="ZA RSA Suid-Afrika">South Africa</option>
                                    <option value="South Georgia and the South Sandwich Islands" data-alternative-spellings="GS">South Georgia and the South Sandwich Islands</option>
                                    <option value="South Sudan" data-alternative-spellings="SS">South Sudan</option>
                                    <option value="Spain" data-alternative-spellings="ES España" data-relevancy-booster="2">Spain</option>
                                    <option value="Sri Lanka" data-alternative-spellings="LK ශ්‍රී ලංකා இலங்கை Ceylon">Sri Lanka</option>
                                    <option value="Sudan" data-alternative-spellings="SD السودان">Sudan</option>
                                    <option value="Suriname" data-alternative-spellings="SR शर्नम् Sarnam Sranangron">Suriname</option>
                                    <option value="Svalbard and Jan Mayen" data-alternative-spellings="SJ" data-relevancy-booster="0.5">Svalbard and Jan Mayen</option>
                                    <option value="Swaziland" data-alternative-spellings="SZ weSwatini Swatini Ngwane">Swaziland</option>
                                    <option value="Sweden" data-alternative-spellings="SE Sverige" data-relevancy-booster="1.5">Sweden</option>
                                    <option value="Switzerland" data-alternative-spellings="CH Swiss Confederation Schweiz Suisse Svizzera Svizra" data-relevancy-booster="1.5">Switzerland</option>
                                    <option value="Syrian Arab Republic" data-alternative-spellings="SY Syria سورية">Syrian Arab Republic</option>
                                    <option value="Taiwan, Province of China" data-alternative-spellings="TW 台灣 臺灣">Taiwan, Province of China</option>
                                    <option value="Tajikistan" data-alternative-spellings="TJ Тоҷикистон Toçikiston">Tajikistan</option>
                                    <option value="Tanzania, United Republic of" data-alternative-spellings="TZ">Tanzania, United Republic of</option>
                                    <option value="Thailand" data-alternative-spellings="TH ประเทศไทย Prathet Thai">Thailand</option>
                                    <option value="Timor-Leste" data-alternative-spellings="TL">Timor-Leste</option>
                                    <option value="Togo" data-alternative-spellings="TG Togolese">Togo</option>
                                    <option value="Tokelau" data-alternative-spellings="TK" data-relevancy-booster="0.5">Tokelau</option>
                                    <option value="Tonga" data-alternative-spellings="TO">Tonga</option>
                                    <option value="Trinidad and Tobago" data-alternative-spellings="TT">Trinidad and Tobago</option>
                                    <option value="Tunisia" data-alternative-spellings="TN تونس">Tunisia</option>
                                    <option value="Turkey" data-alternative-spellings="TR Türkiye Turkiye">Turkey</option>
                                    <option value="Turkmenistan" data-alternative-spellings="TM Türkmenistan">Turkmenistan</option>
                                    <option value="Turks and Caicos Islands" data-alternative-spellings="TC" data-relevancy-booster="0.5">Turks and Caicos Islands</option>
                                    <option value="Tuvalu" data-alternative-spellings="TV" data-relevancy-booster="0.5">Tuvalu</option>
                                    <option value="Uganda" data-alternative-spellings="UG">Uganda</option>
                                    <option value="Ukraine" data-alternative-spellings="UA Ukrayina Україна">Ukraine</option>
                                    <option value="United Arab Emirates" data-alternative-spellings="AE UAE الإمارات">United Arab Emirates</option>
                                    <option value="United Kingdom" data-alternative-spellings="GB Great Britain England UK Wales Scotland Northern Ireland" data-relevancy-booster="2.5">United Kingdom</option>
                                    <option value="United States" data-relevancy-booster="3.5" data-alternative-spellings="US USA United States of America">United States</option>
                                    <option value="United States Minor Outlying Islands" data-alternative-spellings="UM">United States Minor Outlying Islands</option>
                                    <option value="Uruguay" data-alternative-spellings="UY">Uruguay</option>
                                    <option value="Uzbekistan" data-alternative-spellings="UZ Ўзбекистон O'zbekstan O‘zbekiston">Uzbekistan</option>
                                    <option value="Vanuatu" data-alternative-spellings="VU">Vanuatu</option>
                                    <option value="Venezuela" data-alternative-spellings="VE">Venezuela</option>
                                    <option value="Vietnam" data-alternative-spellings="VN Việt Nam" data-relevancy-booster="1.5">Vietnam</option>
                                    <option value="Virgin Islands, British" data-alternative-spellings="VG" data-relevancy-booster="0.5">Virgin Islands, British</option>
                                    <option value="Virgin Islands, U.S." data-alternative-spellings="VI" data-relevancy-booster="0.5">Virgin Islands, U.S.</option>
                                    <option value="Wallis and Futuna" data-alternative-spellings="WF" data-relevancy-booster="0.5">Wallis and Futuna</option>
                                    <option value="Western Sahara" data-alternative-spellings="EH لصحراء الغربية">Western Sahara</option>
                                    <option value="Yemen" data-alternative-spellings="YE اليمن">Yemen</option>
                                    <option value="Zambia" data-alternative-spellings="ZM">Zambia</option>
                                    <option value="Zimbabwe" data-alternative-spellings="ZW">Zimbabwe</option>
                                </select>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="city">City </label>
                            <div class="controls">
                                <input type="text" value="Accra" class="input-medium" name="city" id="city"/>

                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Phone No. *</label>
                            <div class="controls">
                                <input type="text" name="contact" class="input-medium" id="contact"/>
                                <span class="help-inline"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="address">Address </label>
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
                            <label class="control-label">Next of Kin *</label>
                            <div class="controls">
                                <input type="text" name="emergencyperson" id="emergencyperson"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Next of Kin's Tel. No. *</label>
                            <div class="controls">
                                <input class="input-medium" type="text" name="emergencycontact" id="emergencycontact"/>

                            </div>
                        </div>
                    </div>
                    <div style="float: left;" class=" third_third">
                        <div class="control-group">
                            <label class="control-label" for="employer">Employer </label>
                            <div class="controls">
                                <input class="input-medium" type="text" name="employer" id="inputSuccess"/>

                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="occupation">Occupation </label>
                            <div class="controls">
                                <input class="input-medium" type="text" name="occupation" id="inputSuccess"/>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label MustSel"  for="type">Payment Type *</label>
                            <div class="controls">
                                <select class="input-medium" class="MustSelectOpt required" id="payment" name="type">
                                    <option value="">Select</option>
                                    <option id="nhis" value="NHIS" onclick="showInsurance()">National Health Insurance</option>
                                    <option id="cash" value="CASH" onclick="hideIt()">Out of Pocket </option>
                                    <option id="private"value="Private" onclick="showMembershipbox()">Private Health Insurance</option>
                                    <option id="corporate" value="Cooperate" onclick="showCorporate()">Corporate</option>
                                </select>
                            </div>
                        </div>

                        <div style="display:none;" id="companydiv">
                            <div class="control-group">
                                <label class="control-label" >Company *</label>
                                <div class="controls">
                                    <select class="input-medium" id="coperate" name="coperate">
                                        <option value="">Select</option>
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
                                <label for="coperateid" class="control-label" >Corporate ID *</label>
                                <div class="controls">
                                    <input class="input-medium" type="text" id="coperateid" name="coperateid" for="coperateid" value=""/>

                                </div>
                            </div>
                        </div>
                        <div style="display:none;" id="privatediv">
                            <div class="control-group">
                                <label class="control-label">Sponsors *</label>
                                <div class="controls">
                                    <select class="input-medium" name="sponsorid" id="sponsor">
                                        <option value="">Select</option>
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
                                <label for="membershipid" class="control-label" >Membership ID *</label>
                                <div class="controls">
                                    <input type="text" class="input-medium" id="membershipid"name="membershipid" for="membershipid" value=""/>

                                </div>
                            </div>

                            <div class="control-group">
                                <label for="benefitplan" class="control-label" >Benefit Plan *</label>
                                <div class="controls">
                                    <input class="input-medium" type="text" id="benefitplan" name="benefitplan" for="benefitplan" value=""/>

                                </div>
                            </div>
                        </div>
                        <div style="display:none;" id="nhisdiv">
                            <div class="control-group">
                                <label for="nhismembershipid" class="control-label" >Membership ID *</label>
                                <div class="controls">
                                    <input class="input-medium" type="text" id="nhismembershipid" name="nhismembershipid" for="nhismembershipid" value=""/><br/>
                                    <input type="hidden" id="sponsorid" name="nhisid" for="nhismembershipid" value="<%= mgr.getNHISID().getSponshorshipid()%>"/>
                                    <input type="hidden" id="outofpocketpid" name="outofpocketpid" for="outofpocketpid" value="<%= mgr.getCASHID().getSponshorshipid()%>"/>

                                </div>
                            </div>

                        </div>
                        <div class="secondary_payment" style="display: none;">
                            <div class="control-group">
                                <label class="control-label MustSel"  for="type">Secondary Payment Type *</label>
                                <div class="controls">
                                    <select class="MustSelectOpt input-medium required" id="payment2" name="secondarytype">
                                        <option value="">Select</option>
                                        <option id="nhis" value="NHIS" onclick="showInsurance()">National Health Insurance</option>
                                        <option selected="selected" id="cash" value="CASH" onclick="hideIt()">Out of Pocket </option>
                                        <option id="private"value="Private" onclick="showMembershipbox()">Private Health Insurance</option>
                                        <option id="corporate" value="Cooperate" onclick="showCorporate()">Corporate</option>
                                    </select>

                                </div>
                            </div>

                            <div style="display:none;" id="companydiv2">
                                <div class="control-group">
                                    <label class="control-label" >Company *</label>
                                    <div class="controls">


                                        <select class="input-medium" id="coperate2" name="secondarycoperate">
                                            <option value="">Select</option>
                                            <%

                                                companies = mgr.listCooperateInsurers();
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
                                    <label for="coperateid" class="control-label" >Corporate ID *</label>
                                    <div class="controls">
                                        <input type="text" id="coperateid2" class="input-small" name="secondarycoperateid" for="coperateid" value=""/>

                                    </div>
                                </div>
                            </div>
                            <div style="display:none;" id="privatediv2">
                                <div class="control-group">
                                    <label class="control-label">Sponsors *</label>
                                    <div class="controls">
                                        <select class="input-medium" name="secondarysponsorid" id="sponsor2">

                                            <%

                                                Sponsors = mgr.listPrivateSponsors();
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
                                    <label for="membershipid2" class="control-label" >Membership ID *</label>
                                    <div class="controls">
                                        <input type="text" class="input-small" id="membershipid2"name="secondarymembershipid" for="membershipid" value=""/>

                                    </div>
                                </div>

                                <div class="control-group">
                                    <label for="benefitplan2" class="control-label" >Benefit Plan *</label>
                                    <div class="controls">
                                        <input class="input-medium" type="text" id="benefitplan2" name="secondarybenefitplan" for="benefitplan" value=""/>

                                    </div>
                                </div>
                            </div>
                            <div style="display:none;" id="nhisdiv2">
                                <div class="control-group">
                                    <label for="nhismembershipid" class="control-label" >Membership ID *</label>
                                    <div class="controls">
                                        <input type="text" class="input-small" id="nhismembershipid2" name="secondarynhismembershipid" for="nhismembershipid" value=""/><br/>
                                        <input type="hidden" id="sponsorid2" name="secondarynhisid" for="nhismembershipid" value="<%= mgr.getNHISID().getSponshorshipid()%>"/>
                                        <input type="hidden" id="outofpocketpid2" name="secondaryoutofpocketpid" for="outofpocketpid" value="<%= mgr.getCASHID().getSponshorshipid()%>"/>

                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>
                    <div class="clearfix">

                    </div>
                    <div class="save_registration" style="text-align: center;">
                        <button style="text-align: center;" type="submit" name ="action" value="patient" disabled="disabled" class="btn btn-info btn-large span6 submit_button center offset3">
                            <i class="icon-ok icon-white"></i> Save Patient Registration
                        </button>
                    </div>
                </fieldset>


            </form>
        </div>

        <div style="display: none;" id="dialog2" title="Patient Search">

            <form id="search_dialog" class="form-horizontal" action="labpatientsearch.jsp" method="post">
                <fieldset>
                    <div class="control-group center">
                        <h3> Search By First or Last Name </h3>
                        <br />

                        <select class="hide" name="searchid">
                            <option value="fullname">First or Last Name</option>
                          <!--  <option value="patientid">Laboratory Patient ID</option>  -->


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

        <script type="text/javascript" src="js/tablecloth.js"></script>
        <script type="text/javascript" src="js/demo.js"></script>

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
                $('#year').append($('<option />').val(i).html(i));
            }
            
            
            $(".MustSelectOpt").change(function(){
                
                var selectedvalue = $(this).attr('value')
                var selectedid = $(this).attr('id');    
                //alert(selectedvalue);
                //alert(selectedid);
                if($("#"+selectedid).attr("value")==""){
                    
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
                        required: true,
                        digits: true,
                        maxlength: 14,
                        minlength: 10
                        
                    }
                    ,emergencyperson: {
                        minlength: 2,
                        required: true
                    },
                    emergencycontact: {
                        required: true,
                        digits: true,
                        maxlength: 14,
                        minlength: 10
                        
                    },
                    email: {
                        required: false,
                        email: true
                    },
                    type: {
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
            
            $('#search_dialog').validate({
                            
                rules: {
                    searchid: {
                        required: true
                                    
                    },
                    searchquery: {
                        required: true,
                        minlength : 2
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
        
            $("#payment").change(function() {
          
                var payment =  $('#payment option:selected').attr('id');
            
                if(payment=='nhis'){
                    //alert("nhis");
                    $(".submit_button").removeAttr("disabled");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideDown();
                    $(".secondary_payment").slideDown();
                    
                    $('#payment2').rules('add', {
                        required : true
                      
                    });
                    
                    $('#nhismembershipid').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    
                      $('#coperate').rules('remove', {
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
                    $(".submit_button").removeAttr("disabled");
                    //alert("cash");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                    $(".secondary_payment").slideUp();
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
                    
                    $('#payment2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    
                    
                
                }else if(payment=='private'){
                    //alert("private");
                    $(".submit_button").removeAttr("disabled");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideDown();
                    $("#nhisdiv").slideUp();
                    $(".secondary_payment").slideDown();
                    /* $('#benefitplan').rules('add', {
                                   required : true,
                                    minlength: 2
                                });
                    
                     */
                    if ($('#sponsor').attr('value')==""){
                        $('#sponsor').closest('.control-group').addClass('error').removeClass('success')
                    }
                    
                    $('#sponsor').rules('add', {
                        required : true
                    })
                    $('#payment2').rules('add', {
                        required : true
                      
                    });
                    $('#membershipid').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    
                     $('#benefitplan').rules('add', {
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
                    
                     $('#coperate').rules('remove', {
                        required : true,
                        minlength: 2
                    });
               
                    
            
                }else if(payment=='corporate'){
                    //alert("corporate");
                    $(".submit_button").removeAttr("disabled");
                    $("#companydiv").slideDown();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                    $(".secondary_payment").slideDown();
                    
                    if ($('#coperate').attr('value')==""){
                        $('#coperate').closest('.control-group').addClass('error').removeClass('success')
                    }
                    $('#payment2').rules('add', {
                        required : true
                      
                    });
                    $('#coperate').rules('add', {
                        required : true
                    });
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
                    $(".submit_button").attr("disabled","disabled");
                    alert("Please Select Payment Method");
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                    $(".secondary_payment").slideUp();
                    
                    $('#payment2').rules('remove', {
                        required : true
                      
                    });
                    
                }
            });
            
                        
            $("#payment2").change(function() {
          
                var payment =  $('#payment2 option:selected').attr('id');
            
                if(payment=='nhis'){
                    $(".submit_button").removeAttr("disabled")
                    //alert("nhis");
                    $("#companydiv2").slideUp();
                    $("#privatediv2").slideUp();
                    $("#nhisdiv2").slideDown();
                    $('#nhismembershipid2').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#benefitplan2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#membershipid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    
                    
                
                }else if(payment=='cash'){
                    $(".submit_button").removeAttr("disabled")
                    $("#companydiv2").slideUp();
                    $("#privatediv2").slideUp();
                    $("#nhisdiv2").slideUp();
                    $('#nhismembershipid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#benefitplan2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#membershipid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    
                    
                
                }else if(payment=='private'){
                    $(".submit_button").removeAttr("disabled")
                    $("#companydiv2").slideUp();
                    $("#privatediv2").slideDown();
                    $("#nhisdiv2").slideUp();
                    /* $('#benefitplan').rules('add', {
                                   required : true,
                                    minlength: 2
                                });
                    
                     */
                    if ($('#sponsor2').attr('value')==""){
                        $('#sponsor2').closest('.control-group').addClass('error').removeClass('success')
                    }
                    
                    $('#membershipid2').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#nhismembershipid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    
                   
               
            
                }else if(payment=='corporate'){
                    $(".submit_button").removeAttr("disabled")
                    $("#companydiv2").slideDown();
                    $("#privatediv2").slideUp();
                    $("#nhisdiv2").slideUp();
                    
                    if ($('#coperate2').attr('value')==""){
                        $('#coperate2').closest('.control-group').addClass('error').removeClass('success')
                    }
                    
                    
                    $('#coperate2').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#coperateid2').rules('add', {
                        required : true,
                        minlength: 2
                    });
                    $('#nhismembershipid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                
                    $('#benefitplan2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    $('#membershipid2').rules('remove', {
                        required : true,
                        minlength: 2
                    });
                    
                   
                }
                else{
                    alert("Please Select Payment Method");
                    $(".submit_button").attr("disabled","disabled");
                }
            });
                        
                        
            $("#sponsor").change(function(){
                
                
                if ($('#sponsor').attr('value')!=""){
                    $('#sponsor').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#sponsor').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
                        
            $("#sponsor2").change(function(){
                
                
                if ($('#sponsor2').attr('value')!=""){
                    $('#sponsor2').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#sponsor2').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
            
            
            
            
            
            
            $(".dob").change(function(){
                
                
                if (($('#day').attr('value')!="D") && ($('#month').attr('value')!="M") && ($('#year').attr('value')!="Y")){
                    $('#year').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#year').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
            
            
            /*  $("#year").change(function(){
                
                
                if ($('#year').attr('value')!="Y"){
                    $('#year').closest('.control-group').addClass('success').removeClass('error')
                }else{
                    $('#year').closest('.control-group').addClass('error').removeClass('success')
                }
           
            });
             */
            
               
               
               
           
            $(function() {
                $('#country').selectToAutocomplete();
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
            
            
            
        </script>

    </body>
</html>