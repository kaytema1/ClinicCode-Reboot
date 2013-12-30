<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
    String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");


    List nhisinvestigations = null;
    List investigations = null;
    LabPatient patient = null;
    List list = null;

    try {

        if (searchid.equalsIgnoreCase("fullname")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }
            list = mgr.getLabPatientByName(searchquery.trim());
            //System.out.println("patient " + list.size());

        }


        if (searchid.equalsIgnoreCase("patientid")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }
            patient = mgr.getLabPatientByID(searchquery.trim());

        }
        /* if (searchid.equalsIgnoreCase("memberdshipnumber")) {
         if (searchquery.equals("")) {
         session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
         session.setAttribute("class", "alert-error");
         response.sendRedirect("records.jsp");
         return;
         }
         // Sponsorhipdetails spd = mgr.getSearchedSpID(searchquery.trim());
         List l = mgr.getSearchedSpID(searchquery.trim());
         Sponsorhipdetails spd = (Sponsorhipdetails) l.get(0);
        
         p = (LabPatient) mgr.getLabPatientByID(spd.getPatientid());
        
         }
        
         if (searchid.equalsIgnoreCase("dob")) {
         if (searchquery.equals("")) {
         session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
         session.setAttribute("class", "alert");
         response.sendRedirect("records.jsp");
         return;
         }
         System.out.println(searchquery);
         list = mgr.listPatientByDob(searchquery.trim());
         System.out.println("here " + list.size());
        
         } */
    } catch (ArrayIndexOutOfBoundsException e) {
        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
        session.setAttribute("class", "alert");
        response.sendRedirect("records.jsp");
        return;
    } catch (NullPointerException e) {
        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
        session.setAttribute("class", "alert");
        response.sendRedirect("records.jsp");
        return;
    }


%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body style="overflow-y: scroll;" data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="labreception.jsp">Laboratory Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Search Results</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <%if (list != null) {%>

            <div class="container-fluid">
                <section style="margin-top: -30px;" id="dashboard">

                    <!-- Headings & Paragraph Copy -->
                    <div class="row">
                        <%@include file="widgets/laboratorywidget.jsp" %>

                        <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">
                            <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;">Patient Number </th>
                                        <th style="text-align: left;">Patient Name </th>
                                        <th style="text-align: left;">Payment Type</th>
                                        <th style="text-align: left;">Date of Birth</th>
                                        <th style="text-align: left;">Registered On</th>
                                        <th style="text-align: center;"></th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < list.size(); i++) {
                                            LabPatient patient1 = (LabPatient) list.get(i);
                                            System.out.println("test " + list.size());
                                    %>
                                    <tr class="odd gradeX">
                                        <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5> <b> <%= patient1.getFname()%>, <%= patient1.getLname()%> <%= patient1.getMidname()%> </b></h5> <h5><b> Date of Birth :</b> <%= formatter.format(patient1.getDateofbirth())%></h5> <span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%= patient1.getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%= patient1.getEmployer()%>  </td>  </tr> <tr> <td> Payment </td> <td><%=mgr.getSponsor(mgr.sponsorshipDetails(patient1.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(patient1.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patient1.getPatientid()).getSponsorid()).getSponsorname()%>  </td> </tr>
                                            </table>"><b><a class="patientid"><%= patient1.getPatientid()%></a></b></td>
                                        <td style="text-align: left;"><%= patient1.getFname()%>  <%= patient1.getMidname()%> <%= patient1.getLname()%> 
                                        </td>
                                        <td style="text-align: left;"><%= mgr.getSponsor(mgr.sponsorshipDetails(patient1.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(patient1.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(patient1.getPatientid()).getSponsorid()).getSponsorname()%></td>
                                        <td style="text-align: left;">  <%= formatter.format(patient1.getDateofbirth())%> </td>
                                        <td style="text-align: left;"> <%=formatter.format(mgr.getLabPatientByID(patient1.getPatientid()).getDateofregistration())%>
                                        </td>
                                        <td style="text-align: center;">

                                            <a  id="<%=patient1.getPatientid()%>_patientidlink"  class="btn btn-info btn-small"> <i class="icon-pencil icon-white"> </i>Update Patient </a>

                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>

                        </div>
                        <div class="clearfix"></div>

                    </div>

                </section>

                <%@include file="widgets/footer.jsp" %>
            </div>

            <%for (int i = 0; i < list.size(); i++) {
                    LabPatient ppp = (LabPatient) list.get(i);
            %>
            <div style="max-height: 90%; overflow-y: scroll; display: none;" class=" hide" id="<%= ppp.getPatientid()%>_dialog"  title="Laboratory Processing for  <%= mgr.getLabPatientByID(ppp.getPatientid()).getFname()%> <%if (mgr.getLabPatientByID(ppp.getPatientid()).getLname() != null) {%> <%= mgr.getLabPatientByID(ppp.getPatientid()).getMidname()%> <% }%> <%= mgr.getLabPatientByID(ppp.getPatientid()).getLname()%>  ">
                <div class="well thumbnail">
                    <form id="updateregistration<%=ppp.getPatientid()%>" action="action/updatelabregistrationaction.jsp" method="POST" enctype="multipart/data"  class="form-horizontal well" style="padding-top: 40px;">
                        <fieldset>
                            <div class="pre_first_half">
                                <div class="control-group success">
                                    <label class="control-label" for="input01">Folder Number *</label>
                                    <div class="controls">
                                        <input readonly="readonly" class="input-small" type="text" name="patientid"  id="input01" value="<%=ppp.getPatientid()%>"/>
                                        <p class="help-inline">

                                        </p>
                                    </div>
                                </div>

                            </div>
                            <div class="first_half pull-left">
                                <div class="control-group">
                                    <label class="control-label" for="fname">First Name *</label>
                                    <div class="controls">
                                        <input class="text_input"  value="<%=ppp.getFname()%>" type="text" name="fname"  id="fname"/>

                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="midname">Middle Name</label>
                                    <div class="controls">
                                        <input class="text_input" type="text" value="<%=ppp.getMidname()%>" name="midname"  id="midname"/>

                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="lname">Last Name *</label>
                                    <div class="controls">
                                        <input  type="text" name="lname" value="<%=ppp.getLname()%>"  id="lname"/>

                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="input01">Gender *</label>

                                    <div class="controls">
                                        <select class="input-small" name="gender" id="gender">
                                            <!-- <option>Select</option>
                                             <option>Male</option>
                                             <option>Female</option>-->
                                            <%if (ppp.getGender().equals("Male")) {%>
                                            <option selected="selected">Male</option>
                                            <option>Female</option>
                                            <%}
                                                if (ppp.getGender().equals("Female")) {%>
                                            <option selected="selected">Female</option>
                                            <option>Male</option>
                                            <%}%>
                                        </select>
                                        <p class="help-inline">

                                        </p>
                                    </div>
                                </div>
                                <%
                                    System.out.println("whats hot ********************** 2 ");
                                %>
                                <div class="control-group">
                                    <label class="control-label" for="inputError">Date of Birth *</label>
                                    <div class="controls">
                                        <input name="day" id="day" class="input-mini"  value="<%=ppp.getDateofbirth().getDay()%>">
                                        <input name="month" id="month" class="input-mini"  value="<%=ppp.getDateofbirth().getMonth()%>"/>
                                        <input name="year" id="year" class="input-mini"  value="<%=ppp.getDateofbirth().getYear() + 1900%>"/>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input01">Marital Status *</label>
                                    <div class="controls">
                                        <select  class="input-medium" name="maritalstatus" id="maritalstatus">
                                            <option>Select</option>

                                            <%if (ppp.getMaritalstatus().equals("Minor")) {%>
                                            <option selected="selected">Minor</option>
                                            <option>Married</option>
                                            <option>Single</option>
                                            <option>Divorced</option>
                                            <%}
                                                if (ppp.getMaritalstatus().equals("Married")) {%>
                                            <option selected="selected">Married</option>
                                            <option>Single</option>
                                            <option>Divorced</option>
                                            <%}
                                                if (ppp.getMaritalstatus().equals("Single")) {%>
                                            <option>Minor</option>
                                            <option>Married</option>
                                            <option selected="selected">Single</option>
                                            <option>Divorced</option>
                                            <%}
                                                if (ppp.getMaritalstatus().equals("Divorced")) {%>
                                            <option>Minor</option>
                                            <option>Married</option>

                                            <option>Single</option>
                                            <option selected="selected">Divorced</option>

                                            <%}%>
                                        </select>
                                        <p class="help-inline">

                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div style="margin-top: -50px;" class="pull-left">            

                                <div class="control-group">
                                    <label class="control-label" for="input01">Country *</label>
                                    <div class="controls">

                                        <select   class="input-medium" name="country" id="country">
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
                                        <p class="help-inline">

                                        </p>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="city">City</label>
                                    <div class="controls">
                                        <input type="text" class="input-medium" name="city" id="city" value="<%=ppp.getCity()%>"/>

                                        <span class="help-inline"></span>
                                    </div>
                                </div>    


                                <div class="control-group">
                                    <label class="control-label" for="inputSuccess">Phone No. *</label>
                                    <div class="controls">
                                        <input type="text" name="contact" class="input-medium numeric" id="contact" value="<%=ppp.getContact()%>"/>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="inputSuccess">Address </label>
                                    <div class="controls">
                                        <textarea type="text"   name="address" id="address"><%=ppp.getAddress()%></textarea>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputSuccess">Email</label>
                                    <div class="controls">
                                        <input type="text" name="email" id="email" class="input-medium" placeholder="<%=ppp.getEmail()%>" value=""/>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputSuccess">Next of Kin. *</label>
                                    <div class="controls">
                                        <input type="text" name="emergencyperson"  class="input-medium" id="emergencyperson" value="<%=ppp.getEmergencyperson()%>"/>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputSuccess">Next of Kin's Tel. No. *</label>
                                    <div class="controls">
                                        <input type="text" name="emergencycontact" class="input-medium numeric" id="emergencycontact" value="<%=ppp.getEmergencycontact()%>"/>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>
                            </div>



                            <div style="float: left; margin-top: -50px;" >


                                <div class="control-group">
                                    <label class="control-label" for="inputSuccess">Employer</label>
                                    <div class="controls">
                                        <input type="text" name="employer"  class="input-medium" id="employer" value="<%=ppp.getEmployer()%>"/>
                                        <span class="help-inline"></span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label MustSel "  for="type">Primary Sponsorship Method</label>
                                    <div class="controls">
                                        <input type="text" disabled="disabled"  class="input-medium" value="<%=mgr.sponsorshipDetails(ppp.getPatientid()) == null ? mgr.sponsorshipDetails(ppp.getFolderNumber()).getType() : mgr.sponsorshipDetails(ppp.getPatientid()).getType()%>" />   
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label MustSel"  for="type">Sponsor</label>
                                    <div class="controls">

                                        <input type="text" disabled="disabled"  class="input-medium" value="<%=mgr.sponsorshipDetails(ppp.getPatientid()) == null ? mgr.getSponsor(mgr.sponsorshipDetails(ppp.getFolderNumber()).getSponsorid()).getSponsorname() : mgr.getSponsor(mgr.sponsorshipDetails(ppp.getPatientid()).getSponsorid()).getSponsorname()%>" />
                                    </div>
                                </div>

                            </div> 

                            <div style="float: right; text-align: right; padding-bottom: 15px; padding-right: 50px;" >
                                <button type="button" class="btn btn-block updatebilling<%= ppp.getPatientid()%> btn-inverse" > <i class="icon-white icon-edit"></i>  Update Billing Details </button>
                            </div>        

                            <div style="float: right" class=" updatebillingdiv<%= ppp.getPatientid()%> hide">

                                <div style="float: left;" class=" third_third">

                                    <div class="control-group">
                                        <label class="control-label MustSel"  for="type">Payment Type *</label>
                                        <div class="controls">
                                            <select class="input-medium" class="MustSelectOpt required" id="payment<%= ppp.getPatientid()%>" name="type">
                                                <option value="">Select</option>
                                                <option id="nhis" value="NHIS" >National Health Insurance</option>
                                                <option id="cash" value="CASH" >Out of Pocket </option>
                                                <option id="private"value="Private" >Private Health Insurance</option>
                                                <option id="corporate" value="Cooperate" >Corporate</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div style="display:none;" id="companydiv<%= ppp.getPatientid()%>">
                                        <div class="control-group">
                                            <label class="control-label" >Company *</label>
                                            <div class="controls">
                                                <select class="input-medium" id="coperate<%= ppp.getPatientid()%>" name="coperate">
                                                    <option value="">Select</option>
                                                    <%

                                                        List companies = mgr.listCooperateInsurers();
                                                        for (int x = 0; x < companies.size(); x++) {
                                                            Sponsorship sponsor = (Sponsorship) companies.get(x);
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
                                                <input class="input-medium" type="text" id="coperateid<%= ppp.getPatientid()%>" name="coperateid" for="coperateid" value=""/>

                                            </div>
                                        </div>
                                    </div>
                                    <div style="display:none;" id="privatediv<%= ppp.getPatientid()%>">
                                        <div class="control-group">
                                            <label class="control-label">Sponsors *</label>
                                            <div class="controls">
                                                <select class="input-medium" name="sponsorid" id="sponsor<%= ppp.getPatientid()%>">
                                                    <option value="">Select</option>
                                                    <%

                                                        List Sponsors = mgr.listPrivateSponsors();
                                                        for (int x = 0; x < Sponsors.size(); x++) {
                                                            Sponsorship sponsor = (Sponsorship) Sponsors.get(x);
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
                                                <input type="text" class="input-medium" id="membershipid<%= ppp.getPatientid()%>"name="membershipid" for="membershipid" value=""/>

                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label for="benefitplan" class="control-label" >Benefit Plan *</label>
                                            <div class="controls">
                                                <input class="input-medium" type="text" id="benefitplan<%= ppp.getPatientid()%>" name="benefitplan" for="benefitplan" value=""/>

                                            </div>
                                        </div>
                                    </div>
                                    <div style="display:none;" id="nhisdiv<%= ppp.getPatientid()%>">
                                        <div class="control-group">
                                            <label for="nhismembershipid" class="control-label" >Membership ID *</label>
                                            <div class="controls">
                                                <input class="input-medium" type="text" id="nhismembershipid<%= ppp.getPatientid()%>" name="nhismembershipid" for="nhismembershipid" value=""/><br/>
                                                <input type="hidden" id="sponsorid<%= ppp.getPatientid()%>" name="nhisid" for="nhismembershipid" value="<%= mgr.getNHISID().getSponshorshipid()%>"/>
                                                <input type="hidden" id="outofpocketpid<%= ppp.getPatientid()%>" name="outofpocketpid" for="outofpocketpid" value="<%= mgr.getCASHID().getSponshorshipid()%>"/>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="secondary_payment<%= ppp.getPatientid()%>" style="display: none;">
                                        <div class="control-group">
                                            <label class="control-label MustSel"  for="type">Secondary Payment Type *</label>
                                            <div class="controls">
                                                <select class="MustSelectOpt input-medium required" id="payment2<%= ppp.getPatientid()%>" name="secondarytype">
                                                    <option value="">Select</option>
                                                    <option id="nhis" value="NHIS" onclick="showInsurance()">National Health Insurance</option>
                                                    <option selected="selected" id="cash" value="CASH" onclick="hideIt()">Out of Pocket </option>
                                                    <option id="private"value="Private" onclick="showMembershipbox()">Private Health Insurance</option>
                                                    <option id="corporate" value="Cooperate" onclick="showCorporate()">Corporate</option>
                                                </select>

                                            </div>
                                        </div>

                                        <div style="display:none;" id="companydiv2<%= ppp.getPatientid()%>">
                                            <div class="control-group">
                                                <label class="control-label" >Company *</label>
                                                <div class="controls">


                                                    <select class="input-medium" id="coperate2<%= ppp.getPatientid()%>" name="secondarycoperate">
                                                        <option value="">Select</option>
                                                        <%

                                                            companies = mgr.listCooperateInsurers();
                                                            for (int x = 0; x < companies.size(); x++) {
                                                                Sponsorship sponsor = (Sponsorship) companies.get(x);
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
                                                    <input type="text" id="coperateid2<%= ppp.getPatientid()%>" class="input-small" name="secondarycoperateid" for="coperateid" value=""/>

                                                </div>
                                            </div>
                                        </div>
                                        <div style="display:none;" id="privatediv2<%= ppp.getPatientid()%>">
                                            <div class="control-group">
                                                <label class="control-label">Sponsors *</label>
                                                <div class="controls">
                                                    <select class="input-medium" name="secondarysponsorid" id="sponsor2<%= ppp.getPatientid()%>">

                                                        <%

                                                            Sponsors = mgr.listPrivateSponsors();
                                                            for (int x = 0; x < Sponsors.size(); x++) {
                                                                Sponsorship sponsor = (Sponsorship) Sponsors.get(x);
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
                                                    <input type="text" class="input-small" id="membershipid2<%= ppp.getPatientid()%>"name="secondarymembershipid" for="membershipid" value=""/>

                                                </div>
                                            </div>

                                            <div class="control-group">
                                                <label for="benefitplan2" class="control-label" >Benefit Plan *</label>
                                                <div class="controls">
                                                    <input class="input-medium" type="text" id="benefitplan2<%= ppp.getPatientid()%>" name="secondarybenefitplan" for="benefitplan" value=""/>

                                                </div>
                                            </div>
                                        </div>
                                        <div style="display:none;" id="nhisdiv2<%= ppp.getPatientid()%>">
                                            <div class="control-group">
                                                <label for="nhismembershipid" class="control-label" >Membership ID *</label>
                                                <div class="controls">
                                                    <input type="text" class="input-small" id="nhismembershipid2<%= ppp.getPatientid()%>" name="secondarynhismembershipid" for="nhismembershipid" value=""/><br/>
                                                    <input type="hidden" id="sponsorid2" name="secondarynhisid" for="nhismembershipid" value="<%= mgr.getNHISID().getSponshorshipid()%>"/>
                                                    <input type="hidden" id="outofpocketpid2" name="secondaryoutofpocketpid" for="outofpocketpid" value="<%= mgr.getCASHID().getSponshorshipid()%>"/>

                                                </div>
                                            </div>

                                        </div>
                                    </div>           




                                </div>

                            </div>
                            <div class="clearfix">

                            </div>           
                            <div class="form-actions center">
                                <button type="submit" name ="action" value="patient" class="btn btn-info btn-large span6 submit_button center offset1">
                                    <i class="icon-ok icon-white"></i> Update Profile
                                </button>

                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>

            <% }
            } else {

            %>

            <br/>
            <br/>
            <br/>

            <div class="alert hide alert-info container center">
                <b> No Results Found!  </b>
            </div>
            <br/>
            <div class="container-fluid center">


                <!--    <img id="bgimage"  class="center hide" width="40%" src="images/logoonly.png" /> --->

            </div>   
            <%        }
            %>

            <!--end static dialog-->

            <!-- Le javascript
            ================================================== -->
            <!-- Placed at the end of the document so the pages load faster -->
            <script src="js/jquery.js"></script>
            <script src="js/bootstrap-dropdown.js"></script>
            <script src="js/bootstrap-scrollspy.js"></script>
            <script src="js/bootstrap-collapse.js"></script>
            <script src="js/bootstrap-tooltipatient.js"></script>

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
            <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
            <script type="text/javascript" src="js/tablecloth.js"></script>
            <script type="text/javascript" src="js/demo.js"></script>

            <!--initiate accordion-->
            <script type="text/javascript"> 
            
                
                $(function() {

                    var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                    menu_ul.hide();

                    $(".menu").fadeIn();
                    $(".alert").fadeIn();
                    $(".content1").fadeIn();
                    $(".navbar").fadeIn();
                    $(".footer").fadeIn();
                    $(".subnav").fadeIn();
                    $("#bgimage").fadeIn();
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
                
                    $("input:checkbox").attr("checked", false);
                    $('.example').dataTable({
                        "bJQueryUI" : true,
                        "sScrollY" : "300px",
                        "sPaginationType" : "full_numbers",
                        "iDisplayLength" : 25,
                        "aaSorting" : [],
                        "bSort" : true

                    });

                   

                   
            
                

                });

                
            
   
                $(document).ready(function(){   
                
                
                <% if (list != null) {
                        for (int i = 0;
                                i < list.size();
                                i++) {
                            LabPatient vst = (LabPatient) list.get(i);
                %>
                    
                        $("#<%= vst.getPatientid()%>_dialog").dialog({
                            autoOpen : false,
                            width : "90%",
                            modal :true,
                            position : 'top'

                        });
                    
                    
                
                   
    
                        $("#<%= vst.getPatientid()%>_patientidlink").click(function(){
                        
                            $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
                        })   
                    
                    
                    
                    
                    
                        $('#updateregistration<%=vst.getPatientid()%>').validate({
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
            
                        
        
                        $("#payment<%= vst.getPatientid()%>").change(function() {
          
                            var payment =  $('#payment<%= vst.getPatientid()%> option:selected').attr('id');
                           // alert(payment)
                            if(payment=='nhis'){
                                //alert("nhis");
                                //$(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled");
                                $("#companydiv<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv<%= vst.getPatientid()%>").slideDown();
                                $(".secondary_payment<%= vst.getPatientid()%>").slideDown();
                    
                                $('#payment2<%= vst.getPatientid()%>').rules('add', {
                                    required : true
                      
                                });
                    
                                $('#nhismembershipid<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                                $('#coperate<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#benefitplan<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#membershipid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                
                    
                
                            }else if(payment=='cash'){
                                //$(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled");
                                //alert("cash");
                                $("#companydiv<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv<%= vst.getPatientid()%>").slideUp();
                                $(".secondary_payment<%= vst.getPatientid()%>").slideUp();
                                $('#nhismembershipid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#benefitplan<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#membershipid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                                $('#payment2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                    
                
                            }else if(payment=='private'){
                                //alert("private");
                                //$(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled");
                                $("#companydiv<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv<%= vst.getPatientid()%>").slideDown();
                                $("#nhisdiv<%= vst.getPatientid()%>").slideUp();
                                $(".secondary_payment<%= vst.getPatientid()%>").slideDown();
                                /* $('#benefitplan').rules('add', {
                                   required : true,
                                    minlength: 2
                                });
                    
                                 */
                                if ($('#sponsor<%= vst.getPatientid()%>').attr('value')==""){
                                    $('#sponsor<%= vst.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                                }
                    
                                $('#sponsor<%= vst.getPatientid()%>').rules('add', {
                                    required : true
                                })
                                $('#payment2<%= vst.getPatientid()%>').rules('add', {
                                    required : true
                      
                                });
                                $('#membershipid<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                    
                                $('#benefitplan<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#nhismembershipid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                                $('#coperate<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
               
                    
            
                            }else if(payment=='corporate'){
                                //alert("corporate");
                                $(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled");
                                $("#companydiv<%= vst.getPatientid()%>").slideDown();
                                $("#privatediv<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv<%= vst.getPatientid()%>").slideUp();
                                $(".secondary_payment<%= vst.getPatientid()%>").slideDown();
                    
                                if ($('#coperate<%= vst.getPatientid()%>').attr('value')==""){
                                    $('#coperate<%= vst.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                                }
                                $('#payment2<%= vst.getPatientid()%>').rules('add', {
                                    required : true
                      
                                });
                                $('#coperate<%= vst.getPatientid()%>').rules('add', {
                                    required : true
                                });
                                $('#coperateid<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#nhismembershipid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                
                                $('#benefitplan<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#membershipid<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                            }
                            else{
                               // $(".submit_button<%= vst.getPatientid()%>").attr("disabled","disabled");
                                alert("Please Select Payment Method");
                                $("#companydiv<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv<%= vst.getPatientid()%>").slideUp();
                                $(".secondary_payment<%= vst.getPatientid()%>").slideUp();
                    
                                $('#payment2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true
                      
                                });
                    
                            }
                        });
            
                        
                        $("#payment2<%= vst.getPatientid()%>").change(function() {
          
                            var payment =  $('#payment2<%= vst.getPatientid()%> option:selected').attr('id');
            
                            if(payment=='nhis'){
                                $(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled")
                                //alert("nhis");
                                $("#companydiv2<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv2<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv2<%= vst.getPatientid()%>").slideDown();
                                $('#nhismembershipid2<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#benefitplan2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#membershipid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                    
                
                            }else if(payment=='cash'){
                                $(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled")
                                $("#companydiv2<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv2<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv2<%= vst.getPatientid()%>").slideUp();
                                $('#nhismembershipid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#benefitplan2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#membershipid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                    
                
                            }else if(payment=='private'){
                                $(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled")
                                $("#companydiv2<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv2<%= vst.getPatientid()%>").slideDown();
                                $("#nhisdiv2<%= vst.getPatientid()%>").slideUp();
                                /* $('#benefitplan').rules('add', {
                                   required : true,
                                    minlength: 2
                                });
                    
                                 */
                                if ($('#sponsor2<%= vst.getPatientid()%>').attr('value')==""){
                                    $('#sponsor2<%= vst.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                                }
                    
                                $('#membershipid2<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#nhismembershipid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                   
               
            
                            }else if(payment=='corporate'){
                                $(".submit_button<%= vst.getPatientid()%>").removeAttr("disabled")
                                $("#companydiv2<%= vst.getPatientid()%>").slideDown();
                                $("#privatediv2<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv2<%= vst.getPatientid()%>").slideUp();
                    
                                if ($('#coperate2<%= vst.getPatientid()%>').attr('value')==""){
                                    $('#coperate2<%= vst.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                                }
                    
                    
                                $('#coperate2<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#coperateid2<%= vst.getPatientid()%>').rules('add', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#nhismembershipid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                
                                $('#benefitplan2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                                $('#membershipid2<%= vst.getPatientid()%>').rules('remove', {
                                    required : true,
                                    minlength: 2
                                });
                    
                   
                            }
                            else{
                                alert("Please Select Payment Method");
                                $("#companydiv2<%= vst.getPatientid()%>").slideUp();
                                $("#privatediv2<%= vst.getPatientid()%>").slideUp();
                                $("#nhisdiv2<%= vst.getPatientid()%>").slideUp();
                                //$(".submit_button<%= vst.getPatientid()%>").attr("disabled","disabled");
                            }
                        });
                        
                        
                        $("#sponsor<%= vst.getPatientid()%>").change(function(){
                
                
                            if ($('#sponsor<%= vst.getPatientid()%>').attr('value')!=""){
                                $('#sponsor<%= vst.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                            }else{
                                $('#sponsor<%= vst.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                            }
           
                        });
                        
                        $("#sponsor2<%= vst.getPatientid()%>").change(function(){
                
                
                            if ($('#sponsor2<%= vst.getPatientid()%>').attr('value')!=""){
                                $('#sponsor2<%= vst.getPatientid()%>').closest('.control-group').addClass('success').removeClass('error')
                            }else{
                                $('#sponsor2<%= vst.getPatientid()%>').closest('.control-group').addClass('error').removeClass('success')
                            }
           
                        });
                
                
                        $(".updatebilling<%=vst.getPatientid()%>").click(function(){
                
                            $(".updatebillingdiv<%=vst.getPatientid()%>").slideToggle("slow");
                        })
                      
                        $("#<%= vst.getPatientid()%>_dialog").dialog({
                            autoOpen : false,
                            width : "90%",
                            modal :true

                        });
   
                <% }
                    }%>
   
   
   
   
   
   
                        })    
            </script>




    </body>
</html>
