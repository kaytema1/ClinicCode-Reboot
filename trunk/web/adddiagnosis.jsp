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
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    List ls = mgr.listGroups();
%>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <script type="text/javascript">
            function submitform(){
                var t = validateForm();
                //  alert(t)
                if(t){
                    //alert("here");
                    var icd10 = document.getElementById("icd10").value;
                    var gdrg = document.getElementById("gdrg").value;
                    var group = document.getElementById("group").value;
                    var diagnosis = document.getElementById("diagnosis").value;
                    //alert(diagnosis);
                    $.post('action/diagnisisgroupaction.jsp', 
                    { action : "detaildiagnosis", icd10 : icd10, gdrg : gdrg, group : group, diagnosis : diagnosis},
                    function(data) {
                        alert(data);
                    } );
                    //alert("aden");
                }else{
                    alert("fields cannot be empty");
                    return
                }
            }
            
            function updateUnit(id,group,gdrg,diag,icd){
               
                var id = document.getElementById(id).value;
                    
                var group = document.getElementById(group).value;
                var gdrg = document.getElementById(gdrg).value;
                var diag = document.getElementById(diag).value;
                var icd = document.getElementById(icd).value;
                $.post('action/diagnisisgroupaction.jsp', { action : "editdiagnosis", id : id, group : group, gdrg : gdrg, diag : diag, icd : icd}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
                // alert(icd)
            }
            
            function deleteUnit(id){
                var id = document.getElementById(id).value;
                // var roledescription = document.getElementById("roledescription").value;
                var con = confirm("Are You Sure You Want Delete This Item");
                
                if (con ==true)
                {
                    $.post('action/diagnisisgroupaction.jsp', { action : "deletediagnosis", id : id}, function(data) {
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
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="adminpanel.jsp">Admin Panel</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">NHIS Diagnosis Management</a><span class="divider"></span>
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

                        // HMSHelper mgr = new HMSHelper();

                        List itmss = mgr.listNHISDiagnosis();




                    %>     
                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px; padding-bottom:  15px;" class="breadcrumb">
                                <li>
                                    <a> Diagnoses </a> 
                                </li>
                                <li class="pull-right">
                                    <a href="#" class="dialog_link btn"> <i class="icon-tasks"></i> New Diagnosis </a>
                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>
                                            Diagnosis 
                                        </th>
                                        <th>
                                            Group 
                                        </th>
                                        <th>
                                            GDRG Code 
                                        </th>
                                        
                                        <th>
                                            ICD10 Code
                                        </th>
                                        <th></th><th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < itmss.size(); i++) {
                                            DetailsDiagnosis dd = (DetailsDiagnosis) itmss.get(i);
                                    %>
                                    <tr>
                                        <td>
                                            <%=dd.getDescription()%>
                                        </td>
                                        <td>
                                            <%=dd.getDiagnosticGroup()%>
                                        </td>
                                        <td>
                                            <%=dd.getGdrg()%>
                                        </td>
                                        
                                        <td>
                                            <%=dd.getIcd10()%>
                                        </td>
                                        <td>
                                            <button class="btn  btn-primary btn-medium" id="<%=dd.getDetailid()%>_link">
                                                <i class="icon-edit icon-white"> </i> Edit 
                                            </button>
                                            <div style="display: none;" id="<%=dd.getDetailid()%>_dialog" title="Editting <%=dd.getDescription()%>">
                                                <form class="form-horizontal" action="action/diagnisisgroupaction.jsp" method="post" name="edit">
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Group: </label>
                                                        <div class="controls">
                                                            <select name="group" id="group_<%=dd.getDetailid()%>"/>
                                                            <% List lst = mgr.listGroups();
                                                                for (int r = 0; r < lst.size(); r++) {
                                                                    DiagnosticGroupings dg = (DiagnosticGroupings) ls.get(r);
                                                                    if (dg.getCode().equals(dd.getDiagnosticGroup())) {
                                                            %> 
                                                            <option value="<%=dg.getCode()%>" selected="selected"><%=dg.getDescriptio()%></option>
                                                            <%} else {%>
                                                            <option value="<%=dg.getCode()%>"><%=dg.getDescriptio()%></option>
                                                            <%}
                                                                }%>
                                                            </select>
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> GDRG: </label>
                                                        <div class="controls">
                                                            <input type="text" name="gdrg" id="gdrg_<%=dd.getDetailid()%>" value="<%=dd.getGdrg()%>">
                                                            <input type="hidden" name="id" id="id_<%=dd.getDetailid()%>" value="<%=dd.getDetailid()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> Diagnosis: </label>
                                                        <div class="controls">
                                                            <input type="text" name="diag" id="diag_<%=dd.getDetailid()%>" value="<%=dd.getDescription()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="input01"> ICD10 </label>
                                                        <div class="controls">
                                                            <input type="text" name="icd" id="icd_<%=dd.getDetailid()%>" value="<%=dd.getIcd10()%>">
                                                            <p class="help-block"></p>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">
                                                        <button class="btn btn-danger btn-large" type="submit" name="action" value="editdiagnosis" onclick='updateUnit("id_<%=dd.getDetailid()%>","group_<%=dd.getDetailid()%>","gdrg_<%=dd.getDetailid()%>","diag_<%=dd.getDetailid()%>","icd_<%=dd.getDetailid()%>");return false;'>
                                                            <i class="icon-arrow-right icon-white"> </i> Update Diagnosis 
                                                        </button>

                                                    </div>

                                                </form> 
                                            </div>
                                        </td>

                                        <td>
                                            <form style="margin: 0px;" action="action/unitaction.jsp" method="post">
                                                <input type="hidden" id="id_<%=dd.getDetailid()%>" value="<%=dd.getDetailid()%>"/> 

                                                <button class="btn btn-danger btn-medium" type="submit" name="action" value="units" onclick='deleteUnit("id_<%=dd.getDetailid()%>");return false;'>
                                                    <i class="icon-arrow-right icon-white"> </i> Delete  
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>


                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>
                <div style="display: none;" id="dialog" title="New NHIS Diagnosis">
                    <form class="form-horizontal" action="action/diagnisisgroupaction.jsp" method="post" onsubmit="return validateForm();" name="items" >

                        <fieldset>

                            <div class="control-group">
                                <label class="control-label" for="input01">ICD10 CODE</label>
                                <div class="controls">
                                    <input type="text" name="icd10" id="icd10">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01"> GDRG CODE</label>
                                <div class="controls">
                                    <input type="text" name="gdrg" id="gdrg">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Group</label>
                                <div class="controls">
                                    <select name="group" id="group">
                                        <%
                                            for (int i = 0; i < ls.size(); i++) {
                                                DiagnosticGroupings dg = (DiagnosticGroupings) ls.get(i);
                                        %> 
                                        <option value="<%=dg.getCode()%>"><%=dg.getDescriptio()%></option>
                                        <%}%>
                                    </select>

                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="input01">Diagnosis</label>
                                <div class="controls">
                                    <input type="text" name="diagnosis" id="diagnosis">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="form-actions">

                                <button class="btn btn-info btn-small"  onclick='submitform();return false;'>
                                    <i class="icon-arrow-right icon-white"> </i> Add Diagnosis 
                                </button>

                            </div>
                        </fieldset>
                    </form>

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
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/tablecloth.js"></script>
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


        $('.example').dataTable({
            "bJQueryUI" : true,
            "sScrollY": "300px",
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
        
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
    
    
    
    function validateForm()
    {
        var x=document.forms["items"]["gdrg"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
        
        var x=document.forms["items"]["diagnosis"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
        
        var x=document.forms["items"]["icd10"].value;
        if (x==null || x=="")
        {
            // alert("Item must be filled out");
            return false;
        }
        
        var x=document.forms["items"]["group"].value;
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
        //document.write(dat)
        // alert("Todays Date is "+dat)
        return dat; 
   
 
    }
</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        DetailsDiagnosis vst = (DetailsDiagnosis) itmss.get(i);
%>


<script type="text/javascript">
   
                      
    $("#<%= vst.getDetailid()%>_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
    $("#<%= vst.getDetailid()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 500,
        modal :true

    });
    
   
    
    $("#<%= vst.getDetailid()%>_link").click(function(){
      
        $("#<%=vst.getDetailid()%>_dialog").dialog('open');
    
    })
  
    
    $("#<%= vst.getDetailid()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getDetailid()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>