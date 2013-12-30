

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
            HMSHelper mgr = new HMSHelper();
            boolean foundListTypes = false;

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
                            <a href="#">New Lab Classification</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%

                        //  HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        // HMSHelper mgr = new HMSHelper();

                        List listTypes = mgr.listLabAntibiotics();

                        if (!listTypes.isEmpty()) {
                            foundListTypes = true;
                        }

                    %>




                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">
                        <div style="padding-bottom: 80px; max-height: 800px;" class="span9 thumbnail  content">

                            <ul style="margin-left: 0px; padding-bottom: 15px; " class="breadcrumb">
                                
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a href="#">All Antibiotics</a></li>
                               <% if (permissions.contains(53)) {%>
                                <li class="pull-right"><a href="#" class="btn btn-small" id="new_link"> <i class="icon-plus-sign"></i> New Anti Biotic</a></li><%}%>
                            </ul>

                            <% if (foundListTypes) {%>
                            <form action="action/labtypeaction.jsp" method="post">   
                                <ul class="sortable">

                                    <%
                                        int labTypeId = 0;
                                        LabAntibiotic lt;

                                        for (int p = 0; p < listTypes.size(); p++) {
                                            lt = (LabAntibiotic) listTypes.get(p);
                                            labTypeId = lt.getId();
                                    %>
                                    <li id="<%=labTypeId%>" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span><%=lt.getName()%> </li>

                                    <%
                                        }
                                    %>
                                    <!--         <li id="1" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1</li>
                                             <li id="2" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 2</li>
                                             <li id="3" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 3</li>
                                             <li id="4" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 4</li>
                                             <li id="5" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 5</li>
                                             <li id="6" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 6</li>
                                             <li id="7" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 7</li>
                                    -->

                                </ul>
                                <input  type="hidden" class="newOrder" name="newOrder" value="" />
                                <div class="form-actions">
                                    <button class="btn btn-small btn-info" type="submit" name="action" value="ordering" >
                                        <i class="icon-check icon-white"> </i>  New Antibiotic 
                                    </button>
                                </div>
                            </form>
                            <% }%>
                            <div title="New Lab Type" id="new" class="hide" >


                                <form class="form-horizontal" action="action/labtypeaction.jsp" method="post" onsubmit="return validateForm();" name="items" >

                                    <fieldset>
<!--

                                        <div class="control-group">
                                            <label class="control-label">Code</label>

                                            <div class="controls">
                                                <input type="text" class="input-small" name="code" value=""/>
                                            </div>
                                        </div>

-->
                                        <div class="control-group">
                                            <label class="control-label" for="input01"> Antibiotic: </label>
                                            <div class="controls">
                                                <input type="text" name="name" id="name">
                                                <p class="help-block"></p>
                                            </div>
                                        </div>


                                    </fieldset>
                                    <div class="form-actions">

                                        <button class="btn btn-small btn-info" type="submit" name="action" value="antis" onclick='submitform();return false;'>
                                            <i class="icon-check icon-white"> </i> New Antibiotic 
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
        //document.write(dat)
        // alert("Todays Date is "+dat)
        return dat; 
   
 
    }
</script>
<% for (int i = 0;
            i < listTypes.size();
            i++) {
        LabAntibiotic vst = (LabAntibiotic) listTypes.get(i);
%>


<script type="text/javascript">
   
                      
    $("#new").dialog({
        autoOpen : false,
        width : 600,
        modal :true

    });
    
    $("#<%= vst.getId()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#new_link").click(function(){
      
        $("#new").dialog('open');
    
    })
  
    
    $("#<%= vst.getId()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=vst.getId()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>
</body>
</html>