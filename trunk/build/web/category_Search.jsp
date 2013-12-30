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
    String types = request.getParameter("type");
%>
<html>
    <head>
        <meta charset="utf-8">
        <title>ClaimSync Extended</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <link href="css/docs.css" rel="stylesheet">
        <link rel="stylesheet" href="css/styles.css">

        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />

        <%
            HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

            HMSHelper itm = new HMSHelper();
        %>
        <script language="javascript">
            function editRecord(id){
                var f=document.form;
                f.method="post";
                f.action='updateItems.jsp?id='+id;
                f.submit();
            }
            function deleteRecord(id){
                var f=document.form;
                f.method="post";
                f.action='delete.jsp?id='+id;
                f.submit();
            }
            function postItem(id){
                var f=document.form;
                f.method="post";
                f.action='postItem.jsp?id='+id;
                f.submit();
            }

        </script>
    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <div style="display: none;" class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
                    <a class="brand" href="../"><img src="images/logo.png" width="200px;" /></a>

                    <div style="margin-top: 10px;" class="nav-collapse">
                        <ul class="nav pull-right">

                            <li class="dropdown">

                                <a class="active" > Logged in as:  <%=itm.getStafftableByid(user.getStaffid()).getLastname()%> <%=itm.getStafftableByid(user.getStaffid()).getOthername()%></a>

                            </li>
                            <li class="divider-vertical"></li>

                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-user"></i> Account <b class="caret"></b></a>
                                <ul class="dropdown-menu">

                                    <li>
                                        <a target="_blank" href="bootstrap.min.css"><i class="icon-wrench"></i> Settings </a>
                                    </li>

                                    <li>
                                        <a target="_blank" href="bootstrap.css"><i class="icon-question-sign"></i> Help </a>
                                    </li>
                                    <li>
                                        <a target="_blank" href="bootstrap.css"><i class="icon-share"></i> Feedback </a>
                                    </li>
                                    <li class="divider"></li>

                                    <li>
                                        <a target="_blank" href="logout.jsp"><i class="icon-off"></i> Log Out</a>
                                    </li>

                                </ul>

                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="#">Inventory</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <div style="position: absolute; left: 30%; top: 200px; text-align: center;" class="progress1">
                <img src="images/logoonly.png" width="136px;" style="margin-bottom: 20px;" />
                <a href="#"> <h3 class="segoe" style="text-align: center; font-weight: lighter;"> Your page is taking longer than expected to load.....
                        <br />
                        Please be patient!</h3>
                    <br />
                </a>
                <div  class="progress progress-striped active span5">

                    <div class="bar"
                         style="width: 100%;"></div>
                </div>
            </div>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">


                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail well content">
                            <ul style="margin-left: 0px;" class="breadcrumb">
                                <li>
                                    <a> <i class="icon-tasks"></i> Total list of All Suppliers</a>
                                </li>

                            </ul>
                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th>Item Id</th>
                                        <th>Items</th>
                                        <th>Quantity</th>
                                        <th>Unit</th>
                                        <th>Price</th>
                                        <th>Entry Date</th>
                                        <th>Expiring Date</th>
                                        <th>Item Type</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                        <th>Post Item</th>
                                    </tr>


                                    </tr>
                                </thead>
                                <tbody>
                                    <%    List itmss = itm.searchByCategory(types);
                                        for (int i = 0; i < itmss.size(); i++) {
                                            ItemsTable itt = (ItemsTable) itmss.get(i);

                                            String code = itt.getCode();
                                            int id = itt.getItemsId();
                                            String item = itt.getItems();
                                            int quantity = itt.getQuantity();
                                            String unit = itt.getUnit();
                                            double price = itt.getPrice();
                                            Date date = itt.getDate();
                                            Date expDate = itt.getExpDate();
                                            String type = itt.getItemType();



                                    %>  
                                    <tr><td><%=code%></td>
                                        <td><%= item%></td>
                                        <td><%=quantity%></td>
                                        <td><%=unit%></td>
                                        <td><%=price%></td>
                                        <td><%=date%></td>
                                        <td><%=expDate%></td>
                                        <td><%=type%></td>
                                        <td>
                                            <button class="btn btn-info" id="<%=itt.getItemsId()%>_edit" onClick="editRecord(<%=id%>);">
                                                <i class="icon-white icon-check"></i> Update
                                            </button>
                                        </td>

                                        <td>
                                            <button class="btn btn-info" id="<%=itt.getItemsId()%>_edit" onclick="show_confirm(),deleteRecord(<%=id%>); " >
                                                <i class="icon-white icon-check"></i> Delete
                                            </button>
                                        <td>
                                            <button class="btn btn-info" id="<%=itt.getItemsId()%>_edit"  onclick="postItem(<%=id%>); ">
                                                <i class="icon-white icon-check"></i> Post Item
                                            </button>
                                        </td>
                                    </tr>

                                    <%
                                        }
                                        //session1.close();
                                    %>

                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

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
    function editRecord(id){
        var f=document.form;
        f.method="post";
        f.action='updateItems.jsp?id='+id;
        f.submit();
    }
    function deleteRecord(id){
        var f=document.form;
        f.method="post";
        f.action='delete.jsp?id='+id;
        f.submit();
    }
    function postItem(id){
        var f=document.form;
        f.method="post";
        f.action='postItem.jsp?id='+id;
        f.submit();
    }
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

</script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $('.example').dataTable({
            "bJQueryUI" : true,
            "sPaginationType" : "full_numbers",
            "iDisplayLength" : 25,
            "aaSorting" : [],
            "bSort" : true

        });
            
            

        $(".patient").popover({

            placement : 'right',
            animation : true

        });

    });
    
    function show_confirm()
    {
        var con = confirm("Are You Sure You Want Delete This Item");
        if (con ==true)
        {
   
                      
            alert("Delete Was Successfull!");
        }
        else 
        {
            alert("Delete Was Cancled!");
        }
    }
    
    function todaysdate()
    {
        var currentDate = new Date()
        var day = currentDate.getDate()
        var month = currentDate.getMonth() + 1
        var year = currentDate.getFullYear()
        var dat=(" " + year + "-" + month + "-" + day )
        //document.write(dat)
        alert("Todays Date is "+dat)
   
   
 
    }

</script>
<% for (int i = 0;
            i < itmss.size();
            i++) {
        ItemsTable itt = (ItemsTable) itmss.get(i);;
%>


<script type="text/javascript">
   
                      
    $("#<%= itt.getItemsId()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
    $("#<%= itt.getItemsId()%>_adddrug_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= itt.getItemsId()%>_link").click(function(){
      
        $("#<%=itt.getItemsId()%>_dialog").dialog('open');
    
    })
   
    $("#<%= itt.getItemsId()%>_dialog").dialog({
        autoOpen : false,
        width : 1000,
        modal :true

    });
    
   
    
    $("#<%= itt.getItemsId()%>_adddrug_link").click(function(){
        alert("");
        $("#<%=itt.getItemsId()%>_adddrug_dialog").dialog('open');
        
    })
   
    
</script>



<% }%>

</body>
</html>