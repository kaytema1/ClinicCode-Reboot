

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

        <%

            Users user = (Users) session.getAttribute("staff");
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            boolean foundListTypes = false;
            DecimalFormat df = new DecimalFormat();

            df.setMinimumFractionDigits(2);

        %>

        <script type="text/javascript">
            function submitform(){
                
                var t =  validateForm();
                if(t){
                    var name = document.getElementById("name").value;
                    $.post('action/labtypeaction.jsp', { action : "units", name : name}, function(data) {
                        alert(data);
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }else{
                    alert("You must enter lab type name");
                }
                // var roledescription = document.getElementById("roledescription").value;
              
                 
                
            }
            
            function updateUnit(name,id){
             
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
               
                $.post('action/labtypeaction.jsp', { action : "edit", uname : uname, uid : uid}, function(data) {
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
                    $.post('action/labtypeaction.jsp', { action : "delete", id : id}, function(data) {
                        alert(data);
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancled!");
                    //return;
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
                            <a href="#">Laboratory Management</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Profile Setup</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%

                        List listTypes = mgr.listLabTypes();

                        if (!listTypes.isEmpty()) {
                            foundListTypes = true;
                        }

                    %>
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">
                        <div style="padding-bottom: 80px; max-height: 800px;" class="span9 thumbnail  content">

                            <ul style="margin-left: 0px; padding-bottom: 15px; " class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a href="#">All Profiles</a></li>
                               <% if (permissions.contains(49)) {%> <li class="pull-right"><a href="#" class="btn btn-small" id="new_link"> <i class="icon-plus-sign"></i> Add New Profile</a></li><%}%>
                            </ul>
                            <table class="example display table">
                                <thead>
                                    <tr><th></th>
                                        <th> Profile No.</th>
                                        <th> Description</th>
                                        <th> Amount </th>
                                        <th> Edit </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List list = mgr.listProfile();
                                        if (list != null) {
                                            for (int r = 0; r < list.size(); r++) {
                                                Profile profile = (Profile) list.get(r);
                                                if (profile != null) {
                                    %>
                                    <tr>
                                        <td><% if (permissions.contains(52)) {%><a href="action/labaction.jsp?profileid=<%=profile.getProfileId()%>&action=deleteprofile" id=""><img src="images/button_cancel.png" width="10px" height="10px"/></a><%}%></td>
                                        <td style="text-align: center"><%=r + 1%></td>
                                        <td><%=profile.getProfileDescription()%></td>
                                        <td><%=df.format(profile.getProfileAmount())%></td>
                                        <td style="text-align: center">
                                            <% if (permissions.contains(51)) {%>
                                            <button class="btn btn-small btn-info" id="profile_link<%=profile.getProfileId()%>" >
                                                <i class="icon-check icon-white"> </i> Edit Profile Details
                                            </button>
                                                <%}%>
                                            <div class="hide" title="Editing Profile" id="edit_profile<%=profile.getProfileId()%>" >
                                                <table>
                                                    <thead>
                                                    <th> </th>
                                                    <th>No.</th>
                                                    <th>Description</th>
                                                    </thead>
                                                    <tbody>
                                                        <%List list1 = mgr.listProfileLab(profile.getProfileId());
                                                            for (int i = 0; i < list1.size(); i++) {
                                                                ProfileDetails profileDetails = (ProfileDetails) list1.get(i);%>
                                                        <tr>
                                                            <td><% if (permissions.contains(52)) {%><a href="action/labaction.jsp?detailid=<%=profileDetails.getDetailId()%>&action=deletedetail" id=""><img src="images/button_cancel.png" width="10px" height="10px"/></a><%}%></td>
                                                            <td><%=i + 1%></td>
                                                            <td><%=mgr.getInvestigation(profileDetails.getLabId()).getName()%></td>
                                                        </tr>


                                                        <%}%>
                                                        <tr>
                                                            <td></td><td colspan="2"><a href="" id="show_addition<%=profile.getProfileId()%>"onclick="return false;">Add more test(s)</td></tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <div id="show_<%=profile.getProfileId()%>" style="display: none">
                                                                    <div id="tabs">
                                                                        <ul>
                                                                            <li><a style="font-weight: bolder; color: #4183C4;" href="#tabs-1">Investigations</a></li>

                                                                        </ul>
                                                                        <form action="action/labaction.jsp" method="post" name="form<%=profile.getProfileId()%>" id="form<%=profile.getProfileId()%>">
                                                                            <% List investigations = null;
                                                                                List labTypes = mgr.listLabTypes();
                                                                                Labtypes labType;
                                                                                int labTypesNum = 0;
                                                                                TreeMap<Integer, String> labTypesMap = new TreeMap<Integer, String>();
                                                                                TreeMap<Integer, Labtypes> labTypesObjectMap = new TreeMap<Integer, Labtypes>();

                                                                                if (!labTypes.isEmpty()) {
                                                                                    labTypesNum = labTypes.size();
                                                                                }
                                                                            %>
                                                                            <div id="tabs-1">

                                                                                <div class="tabs">
                                                                                    <ul>
                                                                                        <%
                                                                                            if (labTypesNum > 0) {
                                                                                                int tabNum = 0;
                                                                                                for (int y = 0; y < labTypes.size(); y++) {
                                                                                                    labType = (Labtypes) labTypes.get(y);
                                                                                                    tabNum = y + 1;
                                                                                        %>
                                                                                        <li><a style="text-transform: capitalize;" href="#tabs-<%=tabNum%>"><%=labType.getLabType()%></a></li>
                                                                                        <%        labTypesMap.put(tabNum, labType.getLabType());
                                                                                                }
                                                                                            }%>
                                                                                    </ul>

                                                                                    <% if (!labTypes.isEmpty()) {
                                                                                            int colNum = 0;
                                                                                            int labTypeId = 0;
                                                                                            for (int h = 0; h < labTypes.size(); h++) {
                                                                                                labType = (Labtypes) labTypes.get(h);
                                                                                                labTypeId = labType.getLabTypeId();
                                                                                                colNum = h + 1;
                                                                                    %>
                                                                                    <div id="tabs-<%=colNum%>">
                                                                                        <div class="center" id="lab">

                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td>

                                                                                                        <%

                                                                                                            investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                                                                            if (investigations != null) {
                                                                                                        %>
                                                                                                        <div style="float: left"  class="radioset"> 
                                                                                                            <% for (int y = 0; y < investigations.size(); y++) {
                                                                                                                    Investigation investigation = (Investigation) investigations.get(y);
                                                                                                                    if (investigation != null) {%>

                                                                                                            <input style="margin-top: 10px; width: 200px;"  type="checkbox" name="labtest<%=profile.getProfileId()%>" id="test<%= investigation.getDetailedInvId()%>" value="<%= investigation.getDetailedInvId()%>"  
                                                                                                                   /><label style="width: 270px; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; "  for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></label> 

                                                                                                            <% }
                                                                                                                }%>
                                                                                                        </div> 

                                                                                                        <% }%>


                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <label>
                                                                                                            Amount
                                                                                                        </label>
                                                                                                        <input type="text" id="amount" name="amount" value="<%=df.format(profile.getProfileAmount())%>">
                                                                                                        <input type="hidden" name="profileid" value="<%=profile.getProfileId()%>">

                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <button class="btn btn-danger" id="submitAdditions<%=profile.getProfileId()%>" name="action" value="addlabtoprofile">
                                                                                                            <i class="icon-arrow-right icon-white"> </i> Add Test to Profile
                                                                                                        </button>
                                                                                                    </td>
                                                                                                </tr>

                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                    <% }
                                                                                        }%>

                                                                                </div>
                                                                            </div>
                                                                        </form> 
                                                                    </div>

                                                                </div>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>

                                        </td>
                                    </tr><%}
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>


                            <div title="Profile Setup" id="new" class="dialog" >
                                <form class="form-horizontal" action="action/labaction.jsp" method="post">
                                    <table>
                                        <tr>
                                            <td style="text-align: center;">
                                                <div id="tabs">
                                                    <ul>
                                                        <li><a href="#tabs-1">Investigations</a></li>

                                                    </ul>
                                                    <% List investigations = null;
                                                        List labTypes = mgr.listLabTypes();
                                                        Labtypes labType;
                                                        int labTypesNum = 0;
                                                        TreeMap<Integer, String> labTypesMap = new TreeMap<Integer, String>();
                                                        TreeMap<Integer, Labtypes> labTypesObjectMap = new TreeMap<Integer, Labtypes>();

                                                        if (!labTypes.isEmpty()) {
                                                            labTypesNum = labTypes.size();
                                                        }
                                                    %>
                                                    <div id="tabs-1">

                                                        <div class="tabs">
                                                            <ul>
                                                                <%
                                                                    if (labTypesNum > 0) {
                                                                        int tabNum = 0;
                                                                        for (int y = 0; y < labTypes.size(); y++) {
                                                                            labType = (Labtypes) labTypes.get(y);
                                                                            tabNum = y + 1;
                                                                %>
                                                                <li><a style="text-transform: capitalize;" href="#tabs-<%=tabNum%>"><%=labType.getLabType()%></a></li>
                                                                <%        labTypesMap.put(tabNum, labType.getLabType());
                                                                        }
                                                                    }%>
                                                            </ul>

                                                            <% if (!labTypes.isEmpty()) {
                                                                    int colNum = 0;
                                                                    int labTypeId = 0;
                                                                    for (int h = 0; h < labTypes.size(); h++) {
                                                                        labType = (Labtypes) labTypes.get(h);
                                                                        labTypeId = labType.getLabTypeId();
                                                                        colNum = h + 1;
                                                            %>
                                                            <div id="tabs-<%=colNum%>">
                                                                <div class="center" id="lab">

                                                                    <table>
                                                                        <tr>
                                                                            <td>

                                                                                <%

                                                                                    investigations = mgr.listMainInvsUnderLabType(labTypeId);
                                                                                    if (investigations != null) {
                                                                                %>
                                                                                <div style="float: left"  class="radioset"> 
                                                                                    <% for (int y = 0; y < investigations.size(); y++) {
                                                                                            Investigation investigation = (Investigation) investigations.get(y);
                                                                                            if (investigation != null) {%>

                                                                                    <input style="margin-top: 10px; width: 200px;"  type="checkbox" name="labtest1" id="test<%= investigation.getDetailedInvId()%>" value="<%= investigation.getDetailedInvId()%>"  
                                                                                           /><label style="width: 270px; font-size: 14px; text-align: center; float: left; margin-right: 30px; margin-bottom: 20px; "  for="test<%= investigation.getDetailedInvId()%>"><%=investigation.getName()%></label> 

                                                                                    <% }
                                                                                        }%>
                                                                                </div> 

                                                                                <% }%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                            <% }
                                                                }%>
                                                        </div>
                                                    </div>

                                                </div>

                                            </td> 
                                        </tr>
                                    </table>
                                    <table style="width: 33%; margin-left: 33%; vertical-align: top;">
                                        <tr>
                                            <td style="vertical-align: top;">
                                                Description <textarea type="text" name="description"></textarea>
                                            </td>
                                            <td 
                                            <td style="vertical-align: top;">
                                                Amount <input class="input-mini" type="text" name="amount">
                                            </td>
                                        </tr>
                                    </table>

                                    <div class="form-actions">
                                        <button class="btn btn-danger pull-right" type="submit"  name="action" value="profile">
                                            <i class="icon-arrow-right icon-white"> </i> Save Profile
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>


            </section>

            <%@include file="widgets/footer.jsp" %>

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
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/jquery.numeric.js"></script>
<script type="text/javascript" src="js/jquery.filter_input.js"></script>
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
            "sScrollY": "300px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });

    });
    
    function validateForm()
    {
        var x=document.forms["items"]["name"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
        var x=document.forms["edit"]["uname"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
        
        return true;
    }
    function todaysdate()
    {
        var currentDate = new Date()
        var day = currentDate.getDate()
        var month = currentDate.getMonth() + 1
        var year = currentDate.getFullYear()
        var dat=(" " + year + "-" + month + "-" + day )
        return dat; 
    }
    $("#new").dialog({
        autoOpen : false,
        width : 1200,
        modal :true

    });
    $("#new_link").click(function(){
      
        $("#new").dialog('open');
    
    })
</script>
<% for (int i = 0;
            i < list.size();
            i++) {
        Profile vst = (Profile) list.get(i);
%>
<script type="text/javascript">
   
    $("#edit_profile<%= vst.getProfileId()%>").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    $("#profile_link<%= vst.getProfileId()%>").click(function(){
        //alert("");
        $("#edit_profile<%=vst.getProfileId()%>").dialog('open');
        // return false;
    })
    $("#show_addition<%= vst.getProfileId()%>").click(function(){
        //alert("");
        var css = $("#show_<%=vst.getProfileId()%>").css("display");
        // alert(css);
        if(css=="none"){
            $("#show_<%=vst.getProfileId()%>").css("display", "block");   
        }if(css=="block"){
            $("#show_<%=vst.getProfileId()%>").css("display", "none");   
        }
    });
    labtest = [];
    $("#submitAdditions<%=vst.getProfileId()%>").click(function(){
        
    });
</script>
<% }%>
</body>
</html>