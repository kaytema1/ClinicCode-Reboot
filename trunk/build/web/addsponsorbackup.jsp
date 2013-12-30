<%-- 
    Document   : pharmacy
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : dependable
--%>

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
                var rolename = document.getElementById("rolename").value;
                var roledescription = document.getElementById("roledescription").value;
              
                 
                $.post('action/roleaction.jsp', { action : "addrole", rolename : rolename, roledescription : roledescription}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
        </script>
        <script type="text/javascript">
            function submitform(){
                var name= document.getElementById("name").value;
              
                var bool = validateForm();
                if(bool){
                    $.post('action/sponsoraction.jsp',{ action : "units", name : name}, function(data){
                        alert(data);
                    })
                }else{
                    alert("Sponsor field cannot be empty");
                }
            }
            
            function updateUnit(name,id){
                var uname = document.getElementById(name).value;
                var uid = document.getElementById(id).value;
               
                $.post('action/permissionaction.jsp', { action : "edit", uname : uname, uid : uid}, function(data) {
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
                    $.post('action/permissionaction.jsp', { action : "delete", id : id}, function(data) {
                        alert(data);
                        $('#results').html(data).hide().slideDown('slow');
                    } );
                }
                else 
                {
                    alert("Delete Was Cancelled!");
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
            <%if (session.getAttribute("lasterror") != null) {%>
            <div style="width: 100%" class="alert  <%=session.getAttribute("class")%> center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>

            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Sponsorship Management</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">
                    <%
                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
                        List itmss = mgr.listSponsors();
                    %> 

                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li style=" font-size: 14px; font-weight: bold; padding-top: 7px;">
                                    <a>Sponsors</a>
                                </li>

                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn"> <i class="icon-plus-sign"></i> New Sponsor</a>
                                </li>

                            </ul>



                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Sponsor 
                                        </th>
                                        <th>
                                            Sponsorship Type
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (itmss != null) {
                                            for (int i = 0; i < itmss.size(); i++) {
                                                Sponsorship sponsor = (Sponsorship) itmss.get(i);
                                    %>
                                    <tr>
                                        <td style="text-transform: capitalize; color: #4183C4; font-weight: bold;">
                                            <%=sponsor.getSponsorname()%>
                                        </td>
                                        <td>
                                            <%=sponsor.getType()%>
                                        </td>

                                        <td>
                                            <button class="btn btn-inverse " id="<%=sponsor.getSponshorshipid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=sponsor.getSponshorshipid()%>_dialog" title="Editing <%=sponsor.getSponshorshipid()%>">
                                                <form class="form-horizontal" action="action/unitaction.jsp" method="post" onsubmit="return validateForm();" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Sponsor </label>
                                                        <div class="controls">
                                                            <input type="text" name="uname" id="nameunit_<%=sponsor.getSponshorshipid()%>" value="<%=sponsor.getSponshorshipid()%>">
                                                            <input type="hidden" name="uid" id="unitid_<%=sponsor.getSponshorshipid()%>" value="<%=sponsor.getSponshorshipid()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>'
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Sponsor ID  : </label>
                                                        <div class="controls">
                                                            <input type="text" name="sponsorid" value=""/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Sponsor Name  : </label>
                                                        <div class="controls">
                                                            <input type="text" name="sponsorname" value=""/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Type : </label>
                                                        <div class="controls">
                                                            <select name="type">

                                                                <option value="Private">Private Health Insurance</option>

                                                                <option value="Cooperate">Corporate Insured</option>
                                                            </select>

                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Address : </label>
                                                        <div class="controls">
                                                            <textarea type="text" name="address" value=""></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Contact  : </label>
                                                        <div class="controls">

                                                            <input type="text" name="contact" value=""/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Email: </label>
                                                        <div class="controls"><input type="text" name="email" value=""/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Diagnostics Mark Up (GHS) </label>
                                                        <div class="controls">
                                                            <input type="text" name="markupprice" value=""/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Diagnostics Mark Up (%)</label>
                                                        <div class="controls">
                                                            <input type="text" name="markuppercentage" value=""/>%<br/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Treatment Mark Up (GHS)</label>
                                                        <div class="controls">
                                                            <input type="text" name="treatmentmarkupprice" value=""/>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01">Treatment Mark Up (%)</label>
                                                        <div class="controls">
                                                            <input type="text" name="treatmentpricepercentage" value=""/>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">

                                                        <button class="btn btn-inverse" type="submit" name="action" value="units" onclick='updateUnit("nameunit_<%=sponsor.getSponshorshipid()%>","unitid_<%=sponsor.getSponshorshipid()%>");return false;'>
                                                            <i class="icon-edit icon-white"> </i> Update Sponsor ID 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td>
                                            <form style="margin: 0px; padding: 0px;" class="form-horizontal" action="" method="post">
                                                <input type="hidden" id="id_<%=sponsor.getSponshorshipid()%>" value="<%=sponsor.getSponshorshipid()%>"/> 

                                                <button class="btn btn-danger" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=sponsor.getSponshorshipid()%>");return false;'>
                                                    <i class="icon-remove icon-white"> </i> Delete  
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%}
                                                            }%>
                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>
                <div style="display: none;" id="dialog" title="New Sponsor">

                    <form class="form-horizontal" action="action/sponsoraction.jsp" method="POST">

                        <div class="control-group">
                            <label class="control-label" for="input01">Sponsor ID  : </label>
                            <div class="controls">
                                <input type="text" name="sponsorid" value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Sponsor Name  : </label>
                            <div class="controls">
                                <input type="text" name="sponsorname" value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Type : </label>
                            <div class="controls">
                                <select name="type">

                                    <option value="Private">Private Health Insurance</option>

                                    <option value="Cooperate">Corporate Insured</option>
                                </select>

                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Address : </label>
                            <div class="controls">
                                <textarea type="text" name="address" value=""></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Contact  : </label>
                            <div class="controls">

                                <input type="text" name="contact" value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Email: </label>
                            <div class="controls"><input type="text" name="email" value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Diagnostics Mark Up (GHS) </label>
                            <div class="controls">
                                <input type="text" name="markupprice" value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Diagnostics Mark Up (%)</label>
                            <div class="controls">
                                <input type="text" name="markuppercentage" value=""/>%<br/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Treatment Mark Up (GHS)</label>
                            <div class="controls">
                                <input type="text" name="treatmentmarkupprice" value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input01">Treatment Mark Up (%)</label>
                            <div class="controls">
                                <input type="text" name="treatmentpricepercentage" value=""/>
                            </div>
                        </div>
                        <div class="form-actions">

                            <button class="btn btn-info" type="submit" name="action" value="sponsor">
                                <i class="icon icon-plus-sign icon-white"> </i>  New Sponsor
                            </button>

                        </div>
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
            "sScrollY" : "350px",
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
        /* var x=document.forms["edit"]["uname"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }*/
        
        return true;
    }
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
        Sponsorship vst = (Sponsorship) itmss.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getSponshorshipid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getSponshorshipid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= vst.getSponshorshipid()%>_link").click(function(){
      
        $("#<%=vst.getSponshorshipid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getSponshorshipid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getSponshorshipid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>