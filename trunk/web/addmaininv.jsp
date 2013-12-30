

<%@page import="java.util.Calendar"%>
<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%
    HMSHelper mgr = new HMSHelper();
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    Date date = new Date();
    Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <meta charset="utf-8">
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
                        <li>
                            <a href="#">Laboratory Management</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">New Main Investigation</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>


            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->



                <%if (session.getAttribute("lasterror") != null) {%>

                <div class="alert alert-danger">
                    <%=session.getAttribute("lasterror")%> 
                </div>
                <%
                        session.removeAttribute("lasterror");
                    }%>



                <div class="row">


                    <%@include file="widgets/laboratorywidget.jsp" %>

                    <div style="margin-top: 0px; "class="span9 offset3 content1  hide">
                        <div style="padding-bottom: 80px; max-height: 800px;" class="span9 thumbnail  content">


                            <ul style="margin-left: 0px; padding-bottom: 15px; " class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a href="#">All Main Investigations</a></li>
                                <li class="pull-right"><a href="#" class="btn btn-small" id="new_link"> <i class="icon-plus-sign"></i> New Main Investigation</a></li>
                            </ul>


                            <div id="vertical_tabs">
                                <ul>
                                    <li><a href="#tabs-1">Nunc tincidunt</a></li>
                                    <li><a href="#tabs-2">Proin dolor</a></li>
                                </ul>
                                <div id="tabs-1">
                                    <ul class="sortable">
                                        <li id="1" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1</li>
                                        <li id="2" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 2</li>
                                        <li id="3" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 3</li>
                                        <li id="4" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 4</li>
                                        <li id="5" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 5</li>
                                        <li id="6" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 6</li>
                                        <li id="7" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 7</li>


                                    </ul>
                                    <input  type="hidden" class="newOrder" value="" />
                                </div>
                                <div id="tabs-2">
                                    <ul class="sortable">
                                        <li id="1" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1</li>
                                        <li id="2" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 2</li>
                                        <li id="3" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 3</li>
                                        <li id="4" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 4</li>
                                        <li id="5" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 5</li>
                                        <li id="6" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 6</li>
                                        <li id="7" class="ui-state-default"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 7</li>


                                    </ul>
                                    <input  type="hidden" class="newOrder" value="" />
                                </div>
                            </div>




                            <div title="New Main Investigation" id="new" class="hide">
                                <form enctype="multipart/data"action="action/labsavingaction.jsp" method="POST" class="form-horizontal">
                                    <fieldset>
                                        <div style="float: left; width: 50%" class="pre_first_half">
                                            <div class="control-group">
                                                <label class="control-label" for="selectError">Lab Type</label>
                                                <div class="controls">
                                                    <select id="payment" name="type" onchange='OnChange(this.value);'>
                                                        <option >Select</option>
                                                        <!--     <option id="nhis" value="nhis" onclick="showInsurance()">National Health Insurance</option>
                                                           <option id="cash" value="cash" onclick="hideIt()">Out of Pocket </option>
                                                           <option id="private"value="private" onclick="showMembershipbox()">Private Health Insurance</option>
                                                           <option id="corporate" value="cooperate" onclick="showCorporate()">Corporate</option>  -->

                                                        <%

                                                            List labTypes3 = mgr.listLabTypes();
                                                            for (int i = 0; i < labTypes3.size(); i++) {
                                                                Labtypes lType = (Labtypes) labTypes3.get(i);
                                                        %>
                                                        <option value="<%=lType.getLabTypeId()%>"><%=lType.getLabType()%></option>
                                                        <% }

                                                        %>

                                                    </select>

                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>


                                            <div class="control-group">
                                                <label class="control-label" for="input01">Code</label>
                                                <div class="controls">
                                                    <input type="text" name="code" id="input01" value=""/>
                                                    <p class="help-inline">

                                                    </p>
                                                </div>
                                            </div>


                                            <div class="control-group">
                                                <label class="control-label" for="input01">Name</label>
                                                <div class="controls">
                                                    <input  type="text" name="name"  id="input01"/>
                                                    <p class="help-inline">

                                                    </p>
                                                </div>
                                            </div>

                                            <div class="control-group">
                                                <label class="control-label" for="input01">Rate</label>
                                                <div class="controls">
                                                    <input type="text" name="rate"  id="input01"/>
                                                    <p class="help-inline">

                                                    </p>
                                                </div>
                                            </div>
                                            <!--      <div class="control-group">
                                                      <label class="control-label" for="input01">Low Bound</label>
                                                      <div class="controls">
                                                          <input type="text" name="lowbound"  id="input01"/>
                                                          <p class="help-inline">
              
                                                          </p>
                                                      </div>
                                                  </div>
                                                  <div class="control-group">
                                                      <label class="control-label" for="input01">High Bound</label>
                                                      <div class="controls">
                                                          <input type="text" name="highbound"  id="input01"/>
                                                          <p class="help-inline">
              
                                                          </p>
                                                      </div>
                                                  </div>
                                            
                                            -->

                                            <div class="control-group">
                                                <label class="control-label" for="input01">Reference Range</label>
                                                <div class="controls">
                                                    <label class="radio">
                                                        <input id="none_radio" type="radio" name="optionsRadios"  value="non" />
                                                        None
                                                    </label>
                                                    <label class="radio">
                                                        <input id="universal_radio" type="radio" name="optionsRadios"  value="uni" />
                                                        Universal Reference Range
                                                    </label>
                                                    <label class="radio">
                                                        <input id="detailed_radio" type="radio" name="optionsRadios" value="det"/>
                                                        Detailed Reference Range
                                                    </label>
                                                </div>

                                            </div>
                                            <div id="universal" class="thumbnail hide ">
                                                <ul class="breadcrumb">
                                                    <li class="active"><a href="#">Universal Reference Range</a> <span class="divider"></span></li>


                                                </ul>




                                                <table>

                                                    <tbody>
                                                        <tr>
                                                            <td rowspan="2">  <input type="radio" name="UniveralOption" value="duo" /> </td> 

                                                            <td><span style="line-height: 25px;" class="pull-right small">Lower Reference Range</span> </td>
                                                            <td>
                                                                <input type="text" class="input-mini" name="lowRefRange"/>
                                                            </td>

                                                        </tr>

                                                        <tr>


                                                            <td> <span style="line-height: 25px;" class="pull-right small">Upper Reference Range</span> </td>   
                                                            <td>
                                                                <input type="text" class="input-mini" name="uppRefRange"/>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="3">Paragraphic Reference Range</td>
                                                        </tr>
                                                        <tr>
                                                            <td><input type="radio" name="UniveralOption" value="one" /> </td>
                                                            <td colspan="2">
                                                                <textarea style="width: 95%" name="paraRange"></textarea>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>





                                            </div>

                                            <div id="detailed" class="control-group thumbnail hide">

                                                <ul class="breadcrumb" style="padding-bottom: 10px;">
                                                    <li class="active"><a href="#">Detailed Reference Range</a> <span class="divider"></span></li>

                                                    <li class="pull-right" >
                                                        <input id="addrow1" type="button" value="Add Row" class="btn btn-info btn-small"/>
                                                    </li>
                                                </ul>

                                                <table class="table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th colspan="2">
                                                                Age
                                                            </th>
                                                            <th colspan="2">
                                                                Male
                                                            </th>
                                                            <th colspan="2">
                                                                Female
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                From
                                                            </td>
                                                            <td>
                                                                To
                                                            </td>
                                                            <td>
                                                                Lower
                                                            </td>
                                                            <td>
                                                                Higher
                                                            </td>
                                                            <td>
                                                                Lower
                                                            </td>
                                                            <td>
                                                                Higher
                                                            </td>

                                                        </tr>
                                                        <tr class="clone_source1">
                                                            <td>
                                                                <input id="age_from1" type="text" style="width: 35px;" class="input-mini" name="age_from1"/>
                                                            </td>
                                                            <td>
                                                                <input id="age_to1" type="text" style="width: 35px;" class="input-mini" name="age_to1"/>
                                                            </td>
                                                            <td>
                                                                <input id="male_lower1" type="text" style="width: 35px;" class="input-mini" name="male_lower1"/>
                                                            </td>
                                                            <td>
                                                                <input id="male_higher1" type="text" style="width: 35px;" class="input-mini" name="male_higher1"/>
                                                            </td>
                                                            <td>
                                                                <input id="female_lower1" type="text" style="width: 35px;" class="input-mini" name="female_lower1"/>
                                                            </td>
                                                            <td>
                                                                <input id="female_higher1" type="text" style="width: 35px;"  class="input-mini" name="female_higher1"/>
                                                            </td>


                                                        </tr>
                                                        <tr id="dummyrow1">
                                                            <td colspan="6">
                                                                <input  type="hidden" id="click_count1" name="detClickCount" />
                                                            </td>    
                                                        </tr>
                                                    </tbody>
                                                </table>

                                            </div>




                                            <!--div class="control-group">
                                                <label class="control-label" for="input01">Type of Test</label>
                                                <div class="controls">
                                                    <select id="typeoftest" name="typeoftest" id="select01">
                                                        <option id="maintest" value="0">Select</option>
                                                        <option id="maintest" value="1">Main Test</option>
                                                        <option id="subtest" value="2">Sub Test</option>
                                                    </select>
                                                    <p class="help-inline">
        
                                                    </p>
                                                </div>
                                            </div-->

                                            <input name="typeoftest" type="hidden" value="1" />
                                            <!--div id="groupunder" class="control-group hide">
                                                <label class="control-label" for="input01">Main Test</label>
                                                <div class="controls">
        
                                                    <select id="combo" name="combo">
                                                    </select>
        
                                                    <p class="help-inline">
        
                                                    </p>
                                                </div>
                                                <input type="hidden" id="hiddenGroupUnderId" name="hiddenGroupUnderId" value="" />
                                            </div-->



                                        </div>
                                        <div  style="float: left; width: 50px;" class="second">            

                                            <div class="control-group">
                                                <label class="control-label" for="input01">Units</label>
                                                <div class="controls">
                                                    <input type="text" name="units"  id="input01"/>
                                                    <p class="help-inline">

                                                    </p>
                                                </div>
                                            </div>

                                            <div class="control-group">
                                                <label class="control-label" for="inputSuccess">Interpretation</label>
                                                <div class="controls">
                                                    <textarea type="text" name="interpretation" id="inputSuccess"></textarea>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>

                                            <div class="control-group">
                                                <label class="control-label" for="inputSuccess">Check if NHIS</label>
                                                <div class="controls">
                                                    <input  type="checkbox" name="nhis" id="nhis" value="nhis"/>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <!--div class="control-group">
                                                <label class="control-label" for="city">Default Value</label>
                                                <div class="controls">
                                                    <input type="text" name="defaultvalue" id="inputSuccess"/>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
        
                                            <div class="control-group">
                                                <label class="control-label" for="inputSuccess">Range From</label>
                                                <div class="controls">
                                                    <input type="text" name="rangefrom" id="inputSuccess"/>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="inputSuccess">Range Up To</label>
                                                <div class="controls">
                                                    <input type="text" name="rangeupto" id="inputSuccess"/>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <!--   <div class="control-group">
                                                   <label class="control-label" for="inputSuccess">Comments</label>
                                                   <div class="controls">
                                                       <input type="text" name="comments" id="inputSuccess"/>
                                                       <span class="help-inline"></span>
                                                   </div>
                                               </div>
                                            -->
                                            <!--div class="control-group">
                                                <label class="control-label" for="inputSuccess">Report Coll ( Days )</label>
                                                <div class="controls">
                                                    <input type="text" name="reportcolldays" id="inputSuccess"/>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="inputSuccess">Report Coll ( Time )</label>
                                                <div class="controls">
                                                    <input type="text" name="reportcolltime" id="inputSuccess"/>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div-->
                                            <!--            <div class="control-group">
                                                            <label class="control-label" for="inputSuccess">Employer</label>
                                                            <div class="controls">
                                                                <input type="text" name="employer" id="inputSuccess"/>
                                                                <span class="help-inline"></span>
                                                            </div>
                                                        </div>
                                            <!-- <div class="control-group">
                                                 <label class="control-label" for="inputSuccess">Upload Image</label>
                                                 <div class="controls">
                                                     <input type="file" name="imglocation" id="inputSuccess"/>
                                                     <span class="help-inline"></span>
                                                 </div>
                                             </div>-->



                                            <div class="hide" id="none_radio_display">
                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Results Options</label>
                                                    <div class="controls">
                                                        <select id="resultsoptions"  name="resultsoptions" id="select01">
                                                            <option value="Yes">Yes</option>
                                                            <option value="No">No</option>
                                                        </select>
                                                        <p class="help-inline">

                                                        </p>
                                                    </div>
                                                </div>

                                                <div id="add" class="control-group">
                                                    <div class="controls">
                                                        <input name="option1" type="text" />
                                                        <input type="hidden" id="hiddencount" name="hiddencount" value="1" />
                                                        <p class="help-inline">
                                                            <input id="resultoptionadd"  class="btn btn-info" type="button" value="Add" />

                                                        </p> <br/> <br/>    
                                                    </div>
                                                </div>

                                            </div>

                                            <div id="clonehub" class="control-group hide clonehub">
                                                <br/>
                                                <div class="controls">
                                                    <input count="1" id="option1" type="text" >
                                                        <p class="help-inline">


                                                        </p>
                                                </div>
                                            </div>


                                        </div>
                                    </fieldset>
                                    <div  class="form-actions">
                                        <button id="submitbutton" type="submit" name ="action" value="patient" class="btn btn-info btn-small">
                                            <i class="icon-ok icon-white"></i> Save Investigation
                                        </button>

                                    </div>

                                </form>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
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


        <script type="text/javascript" src="js/demo.js"></script>

        <!--initiate accordion-->
        <script type="text/javascript">
            $(function() {

                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                menu_ul.hide();
                $('input[type="radio"]:not(:checked)');
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
        
        
                var click_count1 = 1;

                $("#addrow1").click(function() {

                    click_count1 = click_count1 + 1;
            
                    var clone = $(".clone_source1").clone().attr("class", "clone");
           
                    clone.find("#age_from1").attr("id", "age_from" + click_count1).attr("name", "age_from" + click_count1).attr("value", "");
                    clone.find("#age_to1").attr("id", "age_to" + click_count1).attr("name", "age_to" + click_count1).attr("value", "");
                    clone.find("#male_lower1").attr("id", "male_lower" + click_count1).attr("name", "male_lower" + click_count1).attr("value", "");
                    clone.find("#male_higher1").attr("id", "male_higher" + click_count1).attr("name", "male_higher" + click_count1).attr("value", "");
                    clone.find("#female_lower1").attr("id", "female_lower" + click_count1).attr("name", "female_lower" + click_count1).attr("value", "");
                    clone.find("#female_higher1").attr("id", "female_higher" + click_count1).attr("name", "female_higher" + click_count1).attr("value", "");
            
                    clone.insertBefore("#dummyrow1")
                                        
                    $("#click_count1").attr("value",click_count1);                            
                             
                                        
                });
        
        
        
                $("#universal_radio").change(function(){
           
                    $("#universal").slideDown();
                    $("#detailed").slideUp();
                    $("#none_radio_display").slideDown();
                });
        
                $("#detailed_radio").change(function(){
                                                        
                    $("#universal").slideUp();
                    $("#detailed").slideDown();
                    $("#none_radio_display").slideDown();
                });
                                                    
                $("#none_radio").change(function(){
             
                    $("#none_radio_display").slideUp();
                    $("#universal").slideUp();
                    $("#detailed").slideUp();
                });
                
                $("#new").dialog({
                    autoOpen : false,
                    width : 900,
                    modal :true,
                    position : 'top'

                });
                
                $("#new_link").click(function(){
      
                    $("#new").dialog('open');
    
                })

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
                    i < 4;
                    i++) {
                Labtypes vst = new Labtypes();
        %>


        <script type="text/javascript">
   
                      
            $("#<%= vst.getLabTypeId()%>_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
    
            $("#<%= vst.getLabTypeId()%>_adddrug_dialog").dialog({
                autoOpen : false,
                width : 1000,
                modal :true

            });
    
   
    
            $("#<%= vst.getLabTypeId()%>_link").click(function(){
      
                $("#<%=vst.getLabTypeId()%>_dialog").dialog('open');
    
            })
  
    
            $("#<%= vst.getLabTypeId()%>_adddrug_link").click(function(){
                alert("");
                $("#<%=vst.getLabTypeId()%>_adddrug_dialog").dialog('open');
        
            })
   
    
        </script>

        <% }%>


        <script type="text/javascript">
        
            $("#payment").change(function() {
          
                var payment =  $('#payment option:selected').attr('id');
            
                if(payment=='nhis'){
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideDown();
                
                }else if(payment=='cash'){
                    $("#companydiv").slideUp();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                
                }else if(payment=='private'){
                    $("#companydiv").slideUp();
                    $("#privatediv").slideDown();
                    $("#nhisdiv").slideUp();
            
                }else if(payment=='corporate'){
                    $("#companydiv").slideDown();
                    $("#privatediv").slideUp();
                    $("#nhisdiv").slideUp();
                }
                else{
                    //  alert("Please Select Payment Method");
                }
            });
        
        
            $("#typeoftest").change(function() {
             
            
                var typeoftest =  $('#typeoftest option:selected').attr('id');
            
                if(typeoftest=='subtest'){
                    $("#groupunder").slideDown();
                
                
                }else {
                    $("#groupunder").slideUp();
                
                
                }
            
            
            });
        
        
            $("#resultsoptions").change(function() {
             
           
            
                var resultsoptions =  $('#resultsoptions option:selected').attr('value');
          
          
        
                if(resultsoptions=='Yes'){
                    $("#add").slideDown();
                
                
                }else {
                    $("#add").slideUp();
                
                
                }
            
            
            });
    
    
            var click_count = 1;
        
            $("#resultoptionadd").click(function() {
       
                click_count = click_count + 1;
        
                //alert($("#hiddencount").val());
                var clone = $(".clonehub").clone().attr("class","clone");
                           clone.find("#option1").attr("id","option"+click_count).attr("name","option"+click_count).attr("value","").attr("count",click_count);
                           clone.insertBefore("#clonehub");
                $("#hiddencount").attr("value",click_count);
        
           
            })
               
               
               
           
   
            
            
            
            
            
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
                               
                             //  } if(show.style.display == "none"){ 
                                shows.style.display="none";
                       }    
    
    
    
            var xhr;
            var myArray = new Array();
            var patientDetails = new Array();
            function OnChange(dropdown){
       
                //    alert('kjkj ' + dropdown);
    
                if(dropdown == "Select") {
                    //     alert('select ' + dropdown);
                    document.getElementById("submitbutton").disabled = true;
                } else {
                    document.getElementById("submitbutton").disabled = false;
                    xhr = new XMLHttpRequest();
                    xhr.onreadystatechange=processZipData;
                    xhr.open("GET","getPatientDetails.jsp?patientmembershipnumber=" + dropdown);
                    xhr.send(null);
                }
            }
    
            function processZipData() {
                if (xhr.readyState == 4) {
                    
                    document.getElementById('combo').options.length = 0;
                    var combo = document.getElementById("combo");
                    var option = document.createElement("option");
                    option.text = "Select";
                    option.value = "Select";
                    try {
                        combo.add(option, null); //Standard 
                    }catch(error) {
                        combo.add(option); // IE only
                    }
                    
                    
                    
                    var data = xhr.responseText;
                    //        alert("once again" + data);
                    if(data.indexOf("djaldjfakfalkdjfalkdjflajkdfalkflka") != -1){
                  
                        alert('No Main Tests Found Under Selected Lab Type');
                        //      document.getElementById("submitbutton").disabled = true;
                  
                    } else {
                        var incomingData = data.indexOf('$');
                      
                        //  alert("incoming" + incomingData);
                        var startPoint = incomingData + 1;
                        var starterData = data.substring(startPoint);
                        //  alert("starter" + starterData);
                        var detailedInv = starterData.split('^');
            
                        var lengthReturned = detailedInv.length;
                        //          alert("length" + lengthReturned);
            
                        //    if(lengthReturned > 0){
                        for (k=0; k<lengthReturned; k++)
                        {
                            var dInv = detailedInv[k].split('))');
                        
                            var option = document.createElement("option");
                            option.text = dInv[1];
                            option.value = dInv[0];
                            try {
                                //      alert(dInv[0]);
                                combo.add(option, null); //Standard 
                            }catch(error) {
                                combo.add(option); // IE only
                            }
                        }
                        //          document.getElementById("submitbutton").disabled = false;
                    }
                }
            }
      
        </script>
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



    </body>
</html>