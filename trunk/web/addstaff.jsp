<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    HMSHelper mgr = new HMSHelper();%>
<html>
    <head>

        <%@include file="widgets/stylesheets.jsp" %>

        <script type="text/javascript">
            function submitform(){
                var name = document.getElementById("name").value;
                // var roledescription = document.getElementById("roledescription").value;
              
                 
                $.post('action/unitaction.jsp', { action : "units", name : name}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function updateUnit(){
                var uname = document.getElementById("nameunit").value;
                var uid = document.getElementById("unitid").value;
                // var roledescription = document.getElementById("roledescription").value;
              
                 
                $.post('action/unitaction.jsp', { action : "edit", uname : uname, uid : uid}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            
            function deleteUnit(userid){
                var id = userid;
                
                if (userid != 0 || userid != ""){ 
                    // var roledescription = document.getElementById("roledescription").value;
                    var con = confirm("Are You Sure You Want Delete This Staff");
                    if (con ==true)
                    {
                        $.post('action/staffaction.jsp', { action : "delete", id : id}, function(data) {
                            
                            location.reload();
                            
                            //alert(data);
                            //$('#results').html(data).hide().slideDown('slow');
                        } );
                    }
                    else 
                    {
                        alert("Delete Was Cancelled!");
                        //return;
                    }
                 
                }else{
                
                    alert("No User Selected!");
                        
                }
                
                
                return;
            }
            
            
            
            function reactivateUnit(userid){
                var id = userid;
                
                if (userid != 0 || userid != ""){ 
                    // var roledescription = document.getElementById("roledescription").value;
                    var con = confirm("Are You Sure You Want Activate This Staff");
                    if (con ==true)
                    {
                       
                        $.post('action/staffaction.jsp', { action : "activate", id : id}, function(data) {
                          
                            //
                            location.reload();
                            //alert(data);
                            //$('#results').html(data).hide().slideDown('slow');
                        } );
                    }
                    else 
                    {
                        alert("Activation Was Cancelled!");
                        //return;
                    }
                 
                }else{
                
                    alert("No User Selected!");
                        
                }
                
                
                return;
            }
            
            function addpermission(name){
                var perms = document.getElementsByName(name);
                for(var i = 0; i<perms.length;i++){
                    alert("here"+perms[i].value);
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
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Staff Management</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">
                <%if (session.getAttribute("lasterror") != null) {%>
                <div style="text-align: center;  font-size: larger; " class="alert <%=session.getAttribute("class")%>">
                    <%=session.getAttribute("lasterror")%> 
                </div>
                <%
                        session.removeAttribute("lasterror");
                    }%>

                <div class="row">

                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
                        List itmss = mgr.listAllStaff();
                        List departments = mgr.listUnits();
                        List roles = mgr.listRoles();
                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px; " class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a>Staff Management</a>
                                </li>
                                <li class="pull-right">
                                    <a href="#" class="registration_dialog_link btn">

                                        <i class="icon-plus-sign"></i> New Employee
                                    </a>

                                </li>

                            </ul>
                            <table class="table table-condensed example display">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;">
                                            Full Name 
                                        </th>

                                        <th style="text-align: left;">Username</th>
                                        <th style="text-align: left;"> Role </th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            Stafftable stafftable = (Stafftable) itmss.get(i);
                                            // List users = mgr.listUsers(stafftable.getStaffid());
                                            //Users user = (Users) users.get(0);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bolder; font-size: larger">
                                            <%=stafftable.getLastname()%> 
                                        </td>

                                        <td><% List l = mgr.getUserByStaffid(stafftable.getStaffid());
                                            Users users = (Users) l.get(0);
                                            %>
                                            <%=users.getUsername()%>
                                        </td> 
                                        <td>
                                            <% Roletable r  = mgr.getRoleByid(stafftable.getRole()); %>
                                            <%= r.getRolename() %>
                                        </td>
                                        <td> <% if (stafftable.isActive()) { %>
                                            
                                            <button class="btn btn-inverse" id="<%=stafftable.getStaffid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <%} else {%> 

                                            <label style="text-align: center; font-size: larger" class="label label-important"> Not Active </label> <%}%>
                                            <div style="display: none;" id="<%=stafftable.getStaffid()%>_dialog" title="Editing <%=stafftable.getLastname()%>, <%=stafftable.getOthername()%>">
                                                <form class="form-horizontal" action="action/staffaction.jsp" method="post"  name="items" >

                                                    <fieldset>
                                                        <div class="tabs">
                                                            <ul>
                                                                <li><a href="#tabs-1">Personal Information</a></li>
                                                                <li><a href="#tabs-2">Educational Background</a></li>

                                                            </ul>
                                                            <div id="tabs-1">
                                                                <div class="pull-left">
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Employee ID: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="employeeid" id="employeeid" value="<%=stafftable.getStaffid()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Last Name: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="lname" id="fname" value="<%=stafftable.getLastname()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Other Names: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="othername" id="othername" value="<%=stafftable.getOthername()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Social Security #: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="ssn" id="ssn" value="<%=stafftable.getSsn()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="inputError">Date of Birth</label>
                                                                        <div class="controls">
                                                                            <input type="text" class="date" name="dob" value="<%=stafftable.getDob()%>">
                                                                            <span class="help-inline"></span>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                                <div class="pull-left">
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01">Gender</label>
                                                                        <div class="controls">
                                                                            <input type="text" name="gender" id="gender" value="<%=stafftable.getGender()%>">
                                                                            <p class="help-inline">

                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Place of Birth: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="pob" id="pob" value="<%=stafftable.getPlaceofbirth()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Year Employed: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="yearemployed" id="pob" value="<%=stafftable.getYearofemployment()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Role: </label>
                                                                        <div class="controls">

                                                                            <select name="role">
                                                                                <option>R</option>
                                                                                <%
                                                                                    //List roles = mgr.listRoles();
                                                                                    for (int j = 0; j < roles.size(); j++) {
                                                                                        Roletable roletable = (Roletable) roles.get(j);
                                                                                        if (stafftable.getRole() == roletable.getRoleid()) {%>
                                                                                <option value="<%=roletable.getRoleid()%>" selected="selected"><%=roletable.getRolename()%></option> 
                                                                                <%} else {%>
                                                                                <option value="<%=roletable.getRoleid()%>"><%=roletable.getRolename()%></option> 
                                                                                <% }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Extra Role: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="extrarole" id="extrarole" value="<%=stafftable.getExtraduty()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01">Email</label>
                                                                        <div class="controls">

                                                                            <input type="text" name="email" id="extrarole" value="<%=stafftable.getEmail()%>">
                                                                            <p class="help-inline">

                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="pull-right">       
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Address: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="address" id="address" value="<%=stafftable.getAddress()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Contact: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="contact" id="contact" value="<%=stafftable.getContact()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Next of Kin: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="nextofkin" id="nextofkin" value="<%=stafftable.getNextofkin()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Next of Kin Contact: </label>
                                                                        <div class="controls">
                                                                            <input type="text" name="kincontact" id="kincontact" value="<%=stafftable.getNextofkincontact()%>">
                                                                            <p class="help-block"></p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01"> Department Name: </label>
                                                                        <div class="controls">

                                                                            <select name="departmentid">
                                                                                <%
                                                                                    // List departments = mgr.listDepartments();
                                                                                    for (int j = 0; j < departments.size(); j++) {
                                                                                        Units department = (Units) departments.get(j);
                                                                                        //Roletable roletable = (Roletable) roles.get(j);
                                                                                        if (stafftable.getUnit() == department.getUnitid()) {%>
                                                                                <option value="<%=department.getUnitid()%>" selected="selected"><%=department.getUnitname()%></option> 
                                                                                %>

                                                                                <% } else {%>
                                                                                <option value="<%=department.getUnitid()%>"><%=department.getUnitname()%></option> 
                                                                                <%  }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </div>
                                                                        <p class="help-block"></p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="tabs-2">
                                                                <table class="table table-condensed">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Qualification</th><th>From</th><th>To</th><th>Institution</th>

                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <% List qualifications = mgr.listQualificationByStaffid(stafftable.getStaffid());
                                                                            if (qualifications != null && qualifications.size() > 0) {
                                                                                Qualification qualification = (Qualification) qualifications.get(0);
                                                                                if (qualification != null) {
                                                                        %>
                                                                        <tr>
                                                                            <td>
                                                                                SHS 
                                                                                <input type="hidden" name="shs" id="bachelors" value="SHS"> 
                                                                                <input type="hidden" name="shsid" id="bachelors" value="<%=qualification.getQuid()%>"> 
                                                                            </td>
                                                                            <td>
                                                                                <input type="text"  name="shsfrom" id="bachelors" value="<%=qualification.getStartyear()%>"> 
                                                                            </td>

                                                                            <td> <input type="text" name="shsto" id="bachelors" value="<%=qualification.getEndyear()%>"> 

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="input-xxlarge" name="shsinstitution" id="bachelors" value="<%=qualification.getInstitution()%>"> 
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <% qualification = (Qualification) qualifications.get(1);%>
                                                                            <td>
                                                                                HND
                                                                                <input type="hidden" name="hnd" id="bachelors" value="HND"> 
                                                                                <input type="hidden" name="hndid" id="bachelors" value="<%=qualification.getQuid()%>"> 
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="hndfrom" id="bachelors" value="<%=qualification.getStartyear()%>"> 
                                                                            </td>

                                                                            <td> <input type="text" name="hndto" id="bachelors" value="<%=qualification.getEndyear()%>"> 

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="input-xxlarge" name="hndinstitution" id="bachelors" value="<%=qualification.getInstitution()%>"> 
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <% qualification = (Qualification) qualifications.get(2);%>
                                                                            <td>
                                                                                Bachelors: 
                                                                                <input type="hidden" name="bachelors" id="bachelors" value="Bachelors"> 
                                                                                <input type="hidden" name="bachelorid" id="bachelors" value="<%=qualification.getQuid()%>"> 
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="bachelorsfrom" id="bachelors" value="<%=qualification.getStartyear()%>"> 
                                                                            </td>

                                                                            <td> <input type="text" name="bachelorsto" id="bachelors" value="<%=qualification.getEndyear()%>"> 

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="input-xxlarge" name="bachelorsinstitution" id="bachelors" value="<%=qualification.getInstitution()%>" > 
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <% qualification = (Qualification) qualifications.get(3);%>
                                                                            <td>
                                                                                Masters
                                                                                <input type="hidden" name="masters" id="bachelors" value="Masters"> 
                                                                                <input type="hidden" name="mastersid" id="bachelors" value="<%=qualification.getQuid()%>"> 
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="mastersfrom" id="bachelors" value="<%=qualification.getStartyear()%>"> 
                                                                            </td>

                                                                            <td> <input type="text" name="mastersto" id="bachelors" value="<%=qualification.getEndyear()%>"> 

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="input-xxlarge" name="mastersinstitution" id="bachelors" value="<%=qualification.getInstitution()%>"> 
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <% qualification = (Qualification) qualifications.get(4);%>
                                                                            <td>
                                                                                Doctorate
                                                                                <input type="hidden" name="phd" id="bachelors" value="Doctorate"> 
                                                                                <input type="hidden" name="phdid" id="bachelors" value="<%=qualification.getQuid()%>"> 
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="phdfrom" id="bachelors" value="<%=qualification.getStartyear()%>"> 
                                                                            </td>

                                                                            <td> <input type="text" name="phdto" id="bachelors" value="<%=qualification.getEndyear()%>"> 

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="input-xxlarge" name="phdinstitution" id="bachelors" value="<%=qualification.getInstitution()%>"> 
                                                                            </td>
                                                                        </tr>
                                                                        <%}
                                                                            }%>
                                                                    </tbody>
                                                                </table>
                                                            </div>

                                                        </div>

                                                        <div class="clearfix"></div>
                                                        <div class="control-group">





                                                        </div>

                                                        <div style="text-align: center;" class="form-actions">



                                                            <button class="btn btn-inverse" type="submit" name="action" value="update">
                                                                <i class="icon-edit icon-white"> </i> Update Staff Details 
                                                            </button>


                                                        </div>

                                                    </fieldset>
                                                </form>
                                            </div>
                                        </td>

                                        <td>
                                            <% if (stafftable.isActive()) {%>
                                            <form style="padding: 0px; margin: 0px;" class="form-horizontal" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id" value="<%=stafftable.getStaffid()%>"/> 
                                                <input type="hidden" id="userid" value="<%=stafftable.getStaffid()%>"/> 

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="delete" onclick='deleteUnit("<%=stafftable.getStaffid()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete  
                                                </button>
                                            </form>
                                            <%} else {%>
                                            <label style="text-align: center; font-size: larger" class="label label-important"> Not Active  </label>
                                            <%}%>
                                        </td>
                                        <td>
                                            <% if (stafftable.isActive()) {%>
                                            <button class="btn btn-group btn-medium" id="<%=stafftable.getStaffid()%>_permission">
                                                <i class="icon-wrench "> </i> Set Permission 
                                            </button>
                                            <%} else {%>
                                            <form style="padding: 0px; margin: 0px;" class="form-horizontal" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id" value="<%=stafftable.getStaffid()%>"/> 
                                                <input type="hidden" id="userid" value="<%=stafftable.getStaffid()%>"/> 

                                                <button class="btn btn-medium btn-success" type="submit" name="action" value="activate" onclick='reactivateUnit("<%=stafftable.getStaffid()%>");return false;'>
                                                    <i class="icon-check icon-white "> </i> Reactivate
                                                </button>
                                            </form>
                                            <%}%>
                                            <div  style="display: none; max-height: 680px; overflow-y: scroll;" id="<%=stafftable.getStaffid()%>_dialog_permission" title="Permissions: <%=stafftable.getLastname()%>, <%=stafftable.getOthername()%>">
                                                <form  action="action/permissionaction.jsp" method="post" onsubmit="return validateForm();" name="items" >
                                                    <table class="table table-condensed display">
                                                        <thead>
                                                            <tr>
                                                                <th style="color: white; text-align: left;">
                                                        <h4> Permission </h4>
                                                        </th>
                                                        <th style="color: white">
                                                        <h4> Activated</h4>
                                                        </th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% List lists = mgr.listPermissions();
                                                                List<Integer> index = new ArrayList();
                                                                for (int v = 0; v < lists.size(); v++) {
                                                                    Permission permission = (Permission) lists.get(v);
                                                                    List perms1 = mgr.listStaffPermissions(stafftable.getStaffid());
                                                                    // if(perms1 != null){
                                                                    for (int u = 0; u < perms1.size(); u++) {


                                                                        StaffPermission staffPermission = (StaffPermission) perms1.get(u);
                                                                        index.add(staffPermission.getPermissionid());
                                                                    }

                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <h4><%=permission.getPermission()%></h4>
                                                                </td>
                                                                <td style="text-align: center; width: 100px;" class="center">


                                                                    <label class="switch-container">


                                                                        <%if (index.contains(permission.getPermissionid())) {%>
                                                                        <input type="checkbox" name="permission[]" checked="checked" value="<%=permission.getPermissionid()%>" style="width: 100px" class="switch-input checkValue hide"/>
                                                                        <% } else {%> 
                                                                        <input type="checkbox" name="permission[]"  value="<%=permission.getPermissionid()%>" style="width: 100px" class="switch-input checkValue hide"/>  <%}%>
                                                                        <div class="switch">
                                                                            <span class="switch-label">Yes</span>
                                                                            <span class="switch-label">No</span>
                                                                            <span class="switch-handle"></span>
                                                                        </div>  
                                                                    </label> 
                                                                </td>
                                                            </tr>
                                                            <%
                                                                    //}
                                                                }%>
                                                        </tbody>
                                                    </table>
                                                    <input type="hidden" name="staffid" value="<%=stafftable.getStaffid()%>"/>
                                                    <div style="text-align: center;" class="form-actions">



                                                        <button class="btn btn-inverse" type="submit" name="action" value="setpermission" onclick='addpermission("permission<%=stafftable.getStaffid()%>[]")'>
                                                            <i class="icon-wrench icon-white "> </i> Set Permissions 
                                                        </button>


                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>    

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>
                <div style="display: none;" id="registration_dialog" title="New Employee">
                    <form class="form-horizontal" action="action/staffaction.jsp" method="post" id="createStaff" name="items" >

                        <fieldset>
                            <div class="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Personal Information</a></li>
                                    <li><a href="#tabs-2">Educational Background</a></li>

                                </ul>
                                <div id="tabs-1">
                                    <div class="pull-left">
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Employee ID *  </label>
                                            <div class="controls">
                                                <input type="text" class="input-medium" name="employeeid" id="employeeid">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Title * </label>
                                            <div class="controls">
                                                <select class="input-small" id="title" name="title">
                                                    <option value="">Select</option>
                                                    <option value="Prof.">Prof.</option>
                                                    <option value="Dr.">Dr.</option>
                                                    <option value="Mr.">Mr.</option>
                                                    <option value="Mrs.">Mrs.</option>
                                                    <option value="Miss.">Miss.</option>
                                                    <option value="Ms.">Ms.</option>
                                                </select>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Last Name * </label>
                                            <div class="controls">
                                                <input type="text" name="lname" id="fname">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Other Names * </label>
                                            <div class="controls">
                                                <input type="text" name="othername" id="othername">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Social Security #: </label>
                                            <div class="controls">
                                                <input type="text" name="ssn" id="ssn">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="inputError">Date of Birth *</label>
                                            <div class="controls">
                                                <select class="input-mini MustSelectOpt" id="day" name="day">
                                                    <option value="">D</option>
                                                    <option value="01">1</option>
                                                    <option value="02">2</option>
                                                    <option value="03">3</option>
                                                    <option value="04">4</option>
                                                    <option value="05">5</option>
                                                    <option value="06">6</option>
                                                    <option value="07">7</option>
                                                    <option value="08">8</option>
                                                    <option value="09">9</option>
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

                                                <select class="input-mini" id="month" name="month">
                                                    <option value="" >M</option>
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



                                                <select class="input-small year" id="year"  name="year">
                                                    <option value="">Y</option>


                                                </select>

                                                <span class="help-inline"></span>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="pull-left">
                                        <div class="control-group">
                                            <label class="control-label" for="input01">Gender *</label>
                                            <div class="controls">
                                                <select class="input-small" name="gender" id="select01">
                                                    <option value="">Select</option>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                </select>
                                                <p class="help-inline">

                                                </p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Place of Birth * </label>
                                            <div class="controls">
                                                <input type="text" name="pob" id="pob">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Year Employed * </label>
                                            <div class="controls">
                                                <select class="year MustSelectOpt input-small" name="yearemployed">
                                                    <option value="">Select</option>


                                                </select>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Role * </label>
                                            <div class="controls"> 
                                                <select id="role" class="input-medium" name="role">
                                                    <option value="" >Select Role</option>
                                                    <%

                                                        for (int j = 0; j < roles.size(); j++) {
                                                            Roletable roletable = (Roletable) roles.get(j);
                                                    %>
                                                    <option value="<%=roletable.getRoleid()%>"><%=roletable.getRolename()%></option> 
                                                    <% }

                                                    %>
                                                </select>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>


                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Extra Role: </label>
                                            <div class="controls">
                                                <input type="text" name="extrarole" id="extrarole">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label" for="input01">Email </label>
                                            <div class="controls">

                                                <input type="text"  name="email" id="extrarole">
                                                <p class="help-inline">

                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Address *</label>
                                            <div class="controls">
                                                <textarea name="address" id="address"></textarea>
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Contact: *</label>
                                            <div class="controls">
                                                <input type="text" name="contact" id="contact">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Next of Kin: *</label>
                                            <div class="controls">
                                                <input type="text" name="nextofkin" id="nextofkin">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Next of Kin's Contact *</label>
                                            <div class="controls">
                                                <input type="text" name="kincontact" id="kincontact">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Department Name  *</label>
                                            <div class="controls">
                                                <select name="departmentid">
                                                    <option value="">Select</option>
                                                    <%

                                                        for (int j = 0; j < departments.size(); j++) {
                                                            Units department = (Units) departments.get(j);
                                                    %>
                                                    <option value="<%=department.getUnitid()%>"><%=department.getUnitname()%></option> 
                                                    <% }

                                                    %>
                                                </select>
                                            </div>
                                            <p class="help-block"></p>
                                        </div>

                                    </div>
                                </div>
                                <div id="tabs-2">
                                    <div class="control-group">


                                        <table class="table table-condensed">
                                            <thead>
                                                <tr>
                                                    <th style="color: #FFF; text-align: left; font-size: larger;">Qualification</th><th style="color: #FFF; text-align: left; font-size: larger;">From</th><th style="color: #FFF; text-align: left; font-size: larger;">To</th><th style="color: #FFF; text-align: left; font-size: larger;">Institution</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <tr>
                                                    <td>
                                                        SHS 
                                                        <input type="hidden" name="shs" id="bachelors" value="SHS"> 
                                                    </td>
                                                    <td>
                                                        <input type="text" class="date" name="shsfrom" id="bachelors"> 
                                                    </td>

                                                    <td> <input type="text" class="date" name="shsto" id="bachelors"> 

                                                    </td>
                                                    <td>
                                                        <input type="text" class="input-xxlarge" name="shsinstitution" id="bachelors"> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        HND
                                                        <input type="hidden" name="hnd" id="bachelors" value="HND"> 
                                                    </td>
                                                    <td>
                                                        <input type="text" class="date" name="hndfrom" id="bachelors"> 
                                                    </td>

                                                    <td> <input type="text" class="date" name="hndto" id="bachelors"> 

                                                    </td>
                                                    <td>
                                                        <input type="text" class="input-xxlarge" name="hndinstitution" id="bachelors"> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Bachelors: 
                                                        <input type="hidden" name="bachelors" id="bachelors" value="Bachelors"> 
                                                    </td>
                                                    <td>
                                                        <input type="text" class="date" name="bachelorsfrom" id="bachelors"> 
                                                    </td>

                                                    <td> <input type="text" class="date" name="bachelorsto" id="bachelors"> 

                                                    </td>
                                                    <td>
                                                        <input type="text"class="input-xxlarge"  name="bachelorsinstitution" id="bachelors"> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Masters
                                                        <input type="hidden" name="masters" id="bachelors" value="Masters"> 
                                                    </td>
                                                    <td>
                                                        <input type="text" class="date" name="mastersfrom" id="bachelors"> 
                                                    </td>

                                                    <td> <input type="text" class="date" name="mastersto" id="bachelors"> 

                                                    </td>
                                                    <td>
                                                        <input type="text" class="input-xxlarge" name="mastersinstitution" id="bachelors"> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Doctorate
                                                        <input type="hidden" name="phd" id="bachelors" value="Doctorate"> 
                                                    </td>
                                                    <td>
                                                        <input type="text" class="date" name="phdfrom" id="bachelors"> 
                                                    </td>

                                                    <td> <input type="text" class="date" name="phdto" id="bachelors"> 

                                                    </td>
                                                    <td>
                                                        <input type="text"class="input-xxlarge" name="phdinstitution" id="bachelors"> 
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>



                                    </div>
                                </div>

                            </div>

                            <div class="clearfix">

                            </div>





                            <div class="form-actions center">

                                <button class="btn btn-info btn-large submit_button" type="submit" name="action" value="stafftable" onclick='submitform();return false;'>
                                    <i class="icon-plus-sign icon-white"> </i> Add Staff 
                                </button>

                            </div>


                        </fieldset>
                    </form>

                </div>

            </section>

            <footer style="display: none; margin-top: 50px;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

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
        
        
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sScrollY" : "550px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });

    });
    
    
    
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
            
            
    for (i = new Date().getFullYear(); i > 1900; i--)
    {                       
        $('.year').append($('<option />').val(i).html(i));
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
        
    $('#createStaff').validate({
        rules: {
            employeeid: {
                minlength: 2,
                required: true
            },
            lname: {
                minlength: 2,
                required: true
            },
            title: {
                minlength: 1,
                required: true
            }
            ,
            othername: {
                
                minlength: 2,
                required: true
            }
            ,ssn: {
                minlength: 5,
                required: false
            },
            day: {
                minlength: 1,
                required: true
            },
            month: {
                minlength: 1,
                required: true
            },
            year: {
                minlength: 1,
                required: true
            },
            email: {
                required: false,
                email: true
            },
            gender: {
                required: true,
                minlength : 1
            },
            pob: {
                required: true,
                minlength :2
            },
            yearemployed: {
                required: true,
                minlength :1
            },
            role:{
                required: true,
                minlength:1
            
            },
            address:{
                required: true,
                minlength:2
            },
            contact:{
                required: true,
                minlength:10,
                maxlength: 14
            },
            nextofkin:{
                required: true,
                minlength:2
            },
            kincontact:{
                required: true,
                minlength:10,
                maxlength: 14
            },
            departmentid:{
                required: true,
                minlength:1
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
    
    
    
    
    
   
    function todaysdate()
    {
        var currentDate = new Date()
        var day = currentDate.getDate()
        var month = currentDate.getMonth() + 1
        var year = currentDate.getFullYear()
        var dat=(" " + year + "-" + month + "-" + day )
        //document.write(dat)
        // alert("Todays Date is "+dat)
        return dat; 
   
 
    }
</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        Stafftable vst = (Stafftable) itmss.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getStaffid()%>_dialog").dialog({
        autoOpen : false,
        width : '100%',
        modal :true

    });
    
    $("#<%= vst.getStaffid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : '100%',
        modal :true

    });
    
    $("#<%= vst.getStaffid()%>_dialog_permission").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
   
    
    $("#<%= vst.getStaffid()%>_link").click(function(){
      
        $("#<%=vst.getStaffid()%>_dialog").dialog('open');
    
    })
    
    
    $("#<%= vst.getStaffid()%>_permission").click(function(){
      
        $("#<%=vst.getStaffid()%>_dialog_permission").dialog('open');
    
    })
  
    
    $("#<%= vst.getStaffid()%>_adddrug_link").click(function(){
  
        $("#<%=vst.getStaffid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>