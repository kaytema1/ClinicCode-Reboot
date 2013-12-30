<div style="max-height: 90%; overflow-y: scroll; display: none;" class=" hide" id="<%= patient.getPatientid()%>_dialog"  title="Laboratory Processing for  <%= mgr.getLabPatientByID(patient.getPatientid()).getFname()%> <%if (mgr.getLabPatientByID(patient.getPatientid()).getLname() != null) {%> <%= mgr.getLabPatientByID(patient.getPatientid()).getMidname()%> <% }%> <%= mgr.getLabPatientByID(patient.getPatientid()).getLname()%>  ">
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
                                            <option value="Afghanistan" data-alternative-spellings="AF 