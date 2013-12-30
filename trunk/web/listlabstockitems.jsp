<!DOCTYPE html>

<html lang="en">
    <%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
    <%
        HMSHelper mgr = new HMSHelper();
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        List labStockItems = mgr.listLabStockItems();
        String staffName = "";


        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        //Patient patient = mgr.getPatientByID(patientid);

        Stafftable loggedInStaff = mgr.getStafftableByid(user.getStaffid());

        if (loggedInStaff != null) {
            staffName = loggedInStaff.getLastname() + " " + loggedInStaff.getOthername();
        }

    %>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <%@include file="widgets/header.jsp" %> 

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
                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">

                        <div style="padding-bottom: 80px; " class="span9 thumbnail well content">

                            <table class="example display">
                                <thead>
                                    <tr>
                                        <th> Item ID</th>
                                        <th> Item </th>
                                        <th> Re Order Level</th>
                                        <th> Current Level</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int r = 0; r < labStockItems.size(); r++) {
                                            LabStockItem labStockItem = (LabStockItem) labStockItems.get(r);
                                    %>
                                    <tr>
                                        <td>STID<%=labStockItem.getId()%> </td>

                                        <td><%=labStockItem.getName()%></td>
                                        <td><%=labStockItem.getReOrderLevel()%></td>
                                        <td><%=labStockItem.getCurrentLevel()%></td>
                                        <td>
                                            <div style="max-height: 600px; display: none" id="<%=labStockItem.getId()%>_dialog" title="Add New Stock To <%=labStockItem.getName()%>">

                                                <form action="action/labstockaction.jsp" method="POST" class="form-horizontal well">
                                                    <fieldset>
                                                        <div class="pre_first_half">
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Stock Item </label>
                                                                <div class="controls">
                                                                    <input disabled="disabled" type="text" name="stockitemname"  id="input01" value="<%=labStockItem.getName()%>"/>
                                                                    <input type="hidden" name="stockitemid"  id="input01" value="<%=labStockItem.getId()%>"/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="control-group">
                                                            <label class="control-label" for="input01">Select Distributor</label>

                                                            <div class="controls">
                                                                <select name="distributorid" id="select01">

                                                                    <option>Select</option>

                                                                    <%     List labStockDists = mgr.listLabStockDistributors();
                                                                        if (!labStockDists.isEmpty()) {
                                                                            for (int y = 0; y < labStockDists.size(); y++) {
                                                                                LabStockDistributor lsd = (LabStockDistributor) labStockDists.get(y);
                                                                    %>
                                                                    <option value="<%=lsd.getId()%>"><%=lsd.getName()%></option>
                                                                    <% }
                                                                        }%>
                                                                </select>
                                                                <p class="help-inline">

                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="first_half pull-left">
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Batch Number</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="batchnumber"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Manufacture Date (MM-DD-YYYY)</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="manudate"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Expiry Date (MM-DD-YYYY)</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="expirydate"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Qty</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="qty"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Unit Price</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="unitprice"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Total Price</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="totalprice"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="clearfix">

                                                        </div>           
                                                        <div class="form-actions center">
                                                            <button type="submit" name ="action" value="newstock" class="btn btn-primary btn-large">
                                                                <i class="icon-ok"></i> Update Stock
                                                            </button>

                                                        </div>
                                                    </fieldset>
                                                </form>

                                            </div>


                                            <div style="max-height: 600px; display: none" id="<%=labStockItem.getId()%>_dialog2" title="Release Stock Of <%=labStockItem.getName()%>">

                                                <form action="action/labstockreleaseaction.jsp" method="POST" class="form-horizontal well">
                                                    <fieldset>
                                                        <div class="pre_first_half">
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Stock Item </label>
                                                                <div class="controls">
                                                                    <input disabled="disabled" type="text" name="stockitemname"  id="input01" value="<%=labStockItem.getName()%>"/>
                                                                    <input type="hidden" name="stockitemid"  id="input01" value="<%=labStockItem.getId()%>"/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Distributor</label>

                                                                <div class="controls">
                                                                    <select name="distributorid" id="select01">

                                                                        <option value="0">All Suppliers</option>

                                                                        <%  List itemDistributors = mgr.listStockItemDistributorsByItemId(labStockItem.getId());
                                                                            LabStockDistributor stockDist;
                                                                            if (!itemDistributors.isEmpty()) {
                                                                                int distId = 0;
                                                                                for (int y = 0; y < itemDistributors.size(); y++) {
                                                                                    LabStockItemDistributor lsd = (LabStockItemDistributor) itemDistributors.get(y);
                                                                                    if (lsd != null) {
                                                                                        distId = lsd.getDistributorId();


                                                                                        stockDist = (LabStockDistributor) mgr.listLabStockDistributorById(distId).get(0);
                                                                                        if (stockDist != null) {
                                                                        %>
                                                                        <option value="<%=stockDist.getId()%>"><%=stockDist.getName()%></option>
                                                                        <% }
                                                                                    }
                                                                                }
                                                                            }%>
                                                                    </select>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Remaining Stock </label>
                                                                <div class="controls">
                                                                    <input disabled="disabled" type="text" name="remainingStock"  id="input01" value="<%=labStockItem.getCurrentLevel()%>"/>
                                                                    <input type="hidden" name="remainingStockQty"  id="input01" value="<%=labStockItem.getCurrentLevel()%>"/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Received From </label>
                                                                <div class="controls">
                                                                    <input disabled="disabled" type="text" name="receivedFrom"  id="input01" value="<%=staffName%>"/>
                                                                    <input type="hidden" name="receivedFromId"  id="input01" value="<%=user.getStaffid()%>"/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="control-group">
                                                            <label class="control-label" for="input01">Dispatched To</label>

                                                            <div class="controls">
                                                                <select name="dispatchedToId" id="select01">

                                                                    <option value="0">Select</option>

                                                                    <%  List allStaff = mgr.listAllStaff();
                                                                        if (!allStaff.isEmpty()) {
                                                                            String dispatchedStaffName = "";
                                                                            for (int y = 0; y < allStaff.size(); y++) {
                                                                                Stafftable lsd = (Stafftable) allStaff.get(y);
                                                                                dispatchedStaffName = lsd.getLastname() + " " + lsd.getOthername();
                                                                    %>
                                                                    <option value="<%=lsd.getStaffid()%>"><%=dispatchedStaffName%></option>
                                                                    <% }
                                                                        }%>
                                                                </select>
                                                                <p class="help-inline">

                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="first_half pull-left">
                                                            <div class="control-group">
                                                                <label class="control-label" for="input01">Qty Dispatched</label>
                                                                <div class="controls">
                                                                    <input  type="text" name="qtydispatched"  id="input01" value=""/>
                                                                    <p class="help-inline">

                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <!--        <div class="control-group">
                                                                        <label class="control-label" for="input01">Manufacture Date (MM-DD-YYYY)</label>
                                                                        <div class="controls">
                                                                            <input  type="text" name="manudate"  id="input01" value=""/>
                                                                            <p class="help-inline">
        
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01">Expiry Date (MM-DD-YYYY)</label>
                                                                        <div class="controls">
                                                                            <input  type="text" name="expirydate"  id="input01" value=""/>
                                                                            <p class="help-inline">
        
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01">Qty</label>
                                                                        <div class="controls">
                                                                            <input  type="text" name="qty"  id="input01" value=""/>
                                                                            <p class="help-inline">
        
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01">Unit Price</label>
                                                                        <div class="controls">
                                                                            <input  type="text" name="unitprice"  id="input01" value=""/>
                                                                            <p class="help-inline">
        
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label class="control-label" for="input01">Total Price</label>
                                                                        <div class="controls">
                                                                            <input  type="text" name="totalprice"  id="input01" value=""/>
                                                                            <p class="help-inline">
        
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                            
                                                            -->

                                                        </div>

                                                        <div class="clearfix">

                                                        </div>           
                                                        <div class="form-actions center">
                                                            <button type="submit" name ="action" value="releasestock" class="btn btn-primary btn-large">
                                                                <i class="icon-ok"></i> Release Stock
                                                            </button>

                                                        </div>
                                                    </fieldset>
                                                </form>

                                            </div>                          

                                            <button class="btn btn-info btn-small" id="<%=labStockItem.getId()%>_link">
                                                Add Stock
                                            </button>
                                        </td>
                                        <td>


                                            <button class="btn btn-danger btn-small" id="<%=labStockItem.getId()%>_link2">
                                                Release Stock
                                            </button>
                                            <!--   <input type="hidden" id ="id_%=patient.getPatientid()%>" value="%=patient.getPatientid()%>"/>
                                            -->
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->



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

            });

        </script>
        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                $('.example').dataTable({
                    "bJQueryUI" : true,
                    "sScrollY" : 400,
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
        
            function showMembershipbox(){
                var show = document.getElementById("privateid");
                var shows = document.getElementById("nhis");
               
                show.style.display="block";
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
                
                //  } if(show.style.display == "none"){ 
                shows.style.display="none";
            }
            
            function showConType(id){
                var show = document.getElementById(id);
                //var shows = document.getElementById("nhis");
                //if(show.style.display == "block"){
                show.style.display="block";
                //}else{
                
                //  } if(show.style.display == "none"){ 
                // shows.style.display="none";
            }

        </script>
        <% for (int i = 0; i < labStockItems.size(); i++) {
                LabStockItem vst = (LabStockItem) labStockItems.get(i);
        %>


        <script type="text/javascript">
   
                      
            $("#<%= vst.getId()%>_dialog").dialog({
                autoOpen : false,
                width : 850,
                modal :true

            });
            
            $("#<%= vst.getId()%>_dialog2").dialog({
                autoOpen : false,
                width : 850,
                modal :true

            });
    
            $("#<%= vst.getId()%>_adddrug_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
    
   
    
            $("#<%=vst.getId()%>_link").click(function(){
      
                $("#<%=vst.getId()%>_dialog").dialog('open');
    
            })
            
            $("#<%=vst.getId()%>_link2").click(function(){
      
                $("#<%=vst.getId()%>_dialog2").dialog('open');
    
            })
  
    
            $("#<%= vst.getId()%>_adddrug_link").click(function(){
                alert("");
                $("#<%=vst.getId()%>_adddrug_dialog").dialog('open');
        
            })
   
    
        </script>



        <% }%>
    </body>
</html>
