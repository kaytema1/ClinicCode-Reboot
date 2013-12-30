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
            int id = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
            try {
            } catch (NumberFormatException formatException) {
                session.setAttribute("lasterror", "Sorry Yoy can't access this page");
                response.sendRedirect("addlabtypes.jsp");
            }
            Investigation labtypes = mgr.getInvestigation(id);
        %>
        <script type="text/javascript">
            var addcount = 0;
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
            
            function addAntiChecks(id1,id2){
                addcount++;
                // alert("here");
                var t1 = document.getElementById(id1).value;
                var tr = document.createElement("tr");
                var td1 = document.createElement("td"); 
                var td5 = document.createElement("td"); 
                var td6 = document.createElement("td"); 
                //var text = document.createTextNode(document.getElementById(id1).value);
                var cb = document.createElement( "input" );
                var btn = document.createElement("button")
                //var btn.type = "button";
                btn.innerHTML = 'Remove';
               
                cb.type = "checkbox";
                cb.id = "selected_antibiotics"+addcount;
                cb.name = "selected_antibiotics"+addcount;
                var ttt = t1;
                var str = t1.split("><");
                var text = document.createTextNode(str[0]);
                cb.value = ttt;
                cb.checked = true;
                tr.id = "tr_"+addcount;
                td1.appendChild(text);
                td6.appendChild(btn);
                
                td5.appendChild(cb);
                tr.appendChild(td1);
                tr.appendChild(td5);
                tr.appendChild(td6);
                
                document.getElementById( id2 ).appendChild( tr );
                btn.onclick = function(){
    
                    var tbl = document.getElementById(id2);
                    var rem = confirm("Are you sure you to remove this diagnosis");
                    if(rem){
                        tbl.removeChild(document.getElementById(tr.id));
                        alert("Removed Successfully");
                        return false;
                    }else{
                        return false;
                    }
                };
                $("#hiddencount_antibiotics").attr("value",addcount);
                //  alert($("#selected_antibiotic1").attr("value"));
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
                            <a href="#">Edit Main Investigation</a><span class="divider"></span>
                        </li>


                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">


                    <%@include file="widgets/laboratorywidget.jsp" %>
                    <div style="margin-top: 0px; "class="span9 offset3 content1 hide">
                        <div style="padding-bottom: 80px; max-height: 800px;" class="span9 thumbnail  content">

                            <ul style="margin-left: 0px; padding-bottom: 15px; " class="breadcrumb">
                                <li style="padding-top: 10px; font-size: 14px; font-weight: bold">
                                    <a href="#">Edit Main Investigation | <%=labtypes.getName()%></a></li>

                            </ul>

                            <%

                                boolean refRangeIsNone = false, refRangeIsUni = false, refRangeIsDet = false;
                                boolean isParagraphicRefRange = false, canDisplayDetRefRangeValues = false;



                                if (labtypes != null) {%>

                            <div id="tabs">
                                <ul>
                                    <li><a href="#tabs-1">Main Investigation Information</a></li>
                                    <li><a href="#tabs-2">Reference Information</a></li>
                                    <li><a href="#tabs-3">Results Options</a></li>

                                </ul>
                                <div id="tabs-1">
                                    <form id="maininvestigation" enctype="multipart/data"action="action/editlabsavingaction.jsp" method="POST" class="form-horizontal">
                                        <fieldset>
                                            <div style="float: left; width: 50%" class="pre_first_half">
                                                <div class="control-group success">
                                                    <label class="control-label" for="selectError">Lab Classification</label>
                                                    <div class="controls">


                                                        <select class="input-medium"  style="pointer-events: none; cursor: default;"  id="payment" name="type" onchange='OnChange(this.value);'>

                                                            <%

                                                                List labTypes3 = mgr.listLabTypes();
                                                                for (int i = 0; i < labTypes3.size(); i++) {
                                                                    Labtypes lType = (Labtypes) labTypes3.get(i);
                                                                    if (lType.getLabTypeId() == labtypes.getLabTypeId()) {
                                                            %>
                                                            <option selected="selected" value="<%=lType.getLabTypeId()%>"><%=lType.getLabType()%></option>
                                                            <% } else {%>
                                                            <option value="<%=lType.getLabTypeId()%>"><%=lType.getLabType()%></option>
                                                            <% }
                                                                }

                                                            %>

                                                        </select>

                                                        <span class="help-inline"></span>
                                                    </div>
                                                </div>


                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Code</label>
                                                    <div class="controls">
                                                        <input type="text" name="code" class="input-small" id="input01" value="<%=labtypes.getCode()%>"/>
                                                        <p class="help-inline">

                                                        </p>
                                                    </div>
                                                </div>


                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Name</label>
                                                    <div class="controls">
                                                        <input  type="text" name="name"  id="input01" value="<%=labtypes.getName()%>"/>
                                                        <p class="help-inline">

                                                        </p>
                                                    </div>
                                                </div>

                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Rate</label>
                                                    <div class="controls">
                                                        <input class="input-mini" type="text" name="rate"  id="input01" value="<%=labtypes.getRate()%>"/>
                                                        <p class="help-inline">
                                                            GHS
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="input01">NHIS Rate</label>
                                                    <div class="controls">
                                                        <input class="input-mini" type="text" name="nhisrate"  id="input01" value="<%=labtypes.getNhisRate()%>"/>
                                                        <p class="help-inline">
                                                            GHS
                                                        </p>
                                                    </div>
                                                </div>
                                                        
                                                         <div class="control-group">
                                            <label class="control-label" for="hasantibiotic">Has Antibiotics?</label>
                                            <div class="checkbox inline">
                                                <input style="margin-left: 4px;" type="checkbox" name="hasantibiotic" id="hasantibiotic" value="TRUE" />
                                                <span class="help-inline"></span>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="issubheading">Is Subheading?</label>
                                            <div class="checkbox inline">
                                                <input style="margin-left: 4px;" type="checkbox" name="subheading" id="hasantibiotic" value="TRUE" />
                                                <span class="help-inline"></span>
                                            </div>
                                        </div>


                                            </div>
                                            <div  style="float: left; width: 50px;" class="second">            

                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Units</label>
                                                    <div class="controls">
                                                        <input type="text" class="input-small" name="units"  id="input01" value="<%=labtypes.getUnits()%>"/>
                                                        <p class="help-inline">

                                                        </p>
                                                    </div>
                                                </div>

                                                <div class="control-group">
                                                    <label class="control-label" for="inputSuccess">Interpretation</label>
                                                    <div class="controls">
                                                        <textarea type="text" name="interpretation" id="inputSuccess"><%=labtypes.getInterpretation()%></textarea>
                                                        <span class="help-inline"></span>
                                                    </div>
                                                </div>

                                                <input  type="hidden" name="nhis" id="nhis" value="nhis"/>

                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Specimen</label>
                                                    <div class="controls">
                                                        <%List lst = mgr.listSpecimen();
                                                            for (int v = 0; v < lst.size(); v++) {
                                                                Specimen specimen = (Specimen) lst.get(v);

                                                        %>
                                                        <label class="radio">
                                                            <%if (specimen.getSpecimenId() == labtypes.getSpecimenId()) {%>
                                                            <input  type="radio" checked="checked" name="specimen" value="<%=specimen.getSpecimenId()%>"/>
                                                            <%=specimen.getSpecimen()%>
                                                            <%} else {%>
                                                            <input  type="radio" name="specimen" value="<%=specimen.getSpecimenId()%>"/>
                                                            <%=specimen.getSpecimen()%>
                                                            <%}%>
                                                        </label>
                                                        <%}%>
                                                    </div>

                                                </div>






                                            </div>
                                        </fieldset>
                                        <div  class="form-actions">
                                            <input class="input-medium" count="1" id="option1" type="hidden" name="labid" value="<%=labtypes.getDetailedInvId()%>">
                                            <button id="submitbutton" type="submit" name ="action" value="editmainlab" class="btn btn-danger btn-small pull-right">
                                                <i class="icon-ok icon-white"></i> Save Changes
                                            </button>

                                        </div>

                                    </form>
                                </div>
                                <div id="tabs-2">

                                    <%
                                        List<RefRangeUni> universalRefRangeList;
                                        RefRangeUni universalRefRange;
                                        List<RefRangeDet> detailedRefRangeList = null;
                                        int detailedRefRangeListCount = 0;
                                        String refRangeType = labtypes.getRefRangeType();

                                        String lowerRefRangeValue = "", upperRefRangeValue = "", paragraphicRefRangeValue = "";

                                        int sizeOfDetailedRefRangeList = 0;

                                        if (refRangeType.equals("non")) {
                                            refRangeIsNone = true;
                                        }
                                        if (refRangeType.equals("uni")) {
                                            refRangeIsUni = true;
                                            universalRefRangeList = mgr.getUniRefRangeByDetInvId(labtypes.getDetailedInvId());
                                            if (universalRefRangeList != null && !universalRefRangeList.isEmpty()) {
                                                universalRefRange = universalRefRangeList.get(0);

                                                // is this universalrefrange paragraphic or does it have a lower and upper boundary
                                                if (universalRefRange.getSelected() == 1) {
                                                    isParagraphicRefRange = true;
                                                }

                                                lowerRefRangeValue = universalRefRange.getLowerRefRange();
                                                upperRefRangeValue = universalRefRange.getUpperRefRange();
                                                paragraphicRefRangeValue = universalRefRange.getParagraphic();
                                            }
                                        }
                                        if (refRangeType.equals("det")) {
                                            refRangeIsDet = true;

                                            detailedRefRangeList = mgr.getDetRefRangeByDetInvId(labtypes.getDetailedInvId());
                                            if (detailedRefRangeList != null && !detailedRefRangeList.isEmpty()) {
                                                canDisplayDetRefRangeValues = true;
                                                sizeOfDetailedRefRangeList = detailedRefRangeList.size();
                                            }
                                        }

                                    %>



                                    <form id="maininvestigation" enctype="multipart/data"action="action/editlabrefrencesavingaction.jsp" method="POST" class="form-horizontal">



                                        <fieldset>


                                            <div class="pull-left">
                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Reference Range *</label>
                                                    <div class="controls">
                                                        <label class="radio">
                                                            <% if (refRangeIsNone) {%>
                                                            <input id="none_radio" type="radio" name="optionsRadios"  checked="true" value="non" />
                                                            <% } else {%>
                                                            <input id="none_radio" type="radio" name="optionsRadios"  value="non" />
                                                            <% }%>
                                                            None
                                                        </label>
                                                        <label class="radio">
                                                            <% if (refRangeIsUni) {%>
                                                            <input id="universal_radio" type="radio" name="optionsRadios" checked="true"  value="uni" />
                                                            <% } else {%>
                                                            <input id="universal_radio" type="radio" name="optionsRadios"  value="uni" />
                                                            <% }%>
                                                            Universal Reference Range
                                                        </label>
                                                        <label class="radio">
                                                            <% if (refRangeIsDet) {%>
                                                            <input id="detailed_radio" type="radio" name="optionsRadios" checked="true" value="det"/>
                                                            <% } else {%>
                                                            <input id="detailed_radio" type="radio" name="optionsRadios" value="det"/>
                                                            <% }%>
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
                                                                <td rowspan="2">
                                                                    <%
                                                                        if (refRangeIsUni) {
                                                                            if (isParagraphicRefRange) {%>
                                                                    <input type="radio" name="UniveralOption" value="duo" /> 
                                                                    <% } else {%>
                                                                    <input type="radio" name="UniveralOption" value="duo" checked="true" /> 

                                                                    <%      }
                                                                    } else {%>
                                                                    <input type="radio" name="UniveralOption" value="duo" /> 
                                                                    <% }%>
                                                                </td> 

                                                                <td><span style="line-height: 25px;" class="pull-right small">Lower Reference Range</span> </td>
                                                                <td>
                                                                    <input type="text" class="input-mini" name="lowRefRange" value="<%=lowerRefRangeValue%>"/>
                                                                </td>

                                                            </tr>

                                                            <tr>


                                                                <td> <span style="line-height: 25px;" class="pull-right small">Upper Reference Range</span> </td>   
                                                                <td>
                                                                    <input type="text" class="input-mini" name="uppRefRange" value="<%=upperRefRangeValue%>"/>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="3">Paragraphic Reference Range</td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <%
                                                                        if (refRangeIsUni) {
                                                                            if (isParagraphicRefRange) {%>
                                                                    <input type="radio" name="UniveralOption" value="one" checked="true" /> 
                                                                    <% } else {%>
                                                                    <input type="radio" name="UniveralOption" value="one" /> 
                                                                    <% }
                                                                    } else {%>
                                                                    <input type="radio" name="UniveralOption" value="one" /> 
                                                                    <% }%>
                                                                </td>
                                                                <td colspan="2">
                                                                    <textarea style="width: 95%" name="paraRange"><%=paragraphicRefRangeValue%></textarea>
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

                                                            <%

                                                                int counter = 0;
                                                                if(detailedRefRangeList != null && !detailedRefRangeList.isEmpty()) {
                                                                if (canDisplayDetRefRangeValues) {

                                                                    for (RefRangeDet detRefRange : detailedRefRangeList) {
                                                                         counter++;
                                                            %>


                                                            <tr>
                                                                <td>
                                                                    <input id="age_from<%=counter%>" type="text" style="width: 35px;" class="input-mini" name="age_from<%=counter%>" value="<%=detRefRange.getDetFrom()%>"/>
                                                                </td>
                                                                <td>
                                                                    <input id="age_to<%=counter%>" type="text" style="width: 35px;" class="input-mini" name="age_to<%=counter%>" value="<%=detRefRange.getDetTo()%>"/>
                                                                </td>
                                                                <td>
                                                                    <input id="male_lower<%=counter%>" type="text" style="width: 35px;" class="input-mini" name="male_lower<%=counter%>" value="<%=detRefRange.getMLower()%>"/>
                                                                </td>
                                                                <td>
                                                                    <input id="male_higher<%=counter%>" type="text" style="width: 35px;" class="input-mini" name="male_higher<%=counter%>" value="<%=detRefRange.getMUpper()%>"/>
                                                                </td>
                                                                <td>
                                                                    <input id="female_lower<%=counter%>" type="text" style="width: 35px;" class="input-mini" name="female_lower<%=counter%>" value="<%=detRefRange.getFLower()%>"/>
                                                                </td>
                                                                <td>
                                                                    <input id="female_higher<%=counter%>" type="text" style="width: 35px;"  class="input-mini" name="female_higher<%=counter%>" value="<%=detRefRange.getFUpper()%>"/>
                                                                </td>
                                                            </tr>
                                                            <% 
                                                                   
                                                                    }
                                                                    
                                                                    if(detailedRefRangeList != null && !detailedRefRangeList.isEmpty()) {
                                                                        detailedRefRangeListCount = detailedRefRangeList.size();
                                                                    }
                                                                }
                                                                System.out.println("Counter " + counter);
                                                                
                                                            %>
                                                       
                                               <%  } else { 
                      counter = 1;                                               
                     %>             
                                                       <tr>
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
                                                        <% } %>
                                                        <tr class="clone_source1 hide" >
                                                            <td>
                                                                <input id="age_from1" type="text" style="width: 35px;" class="input-mini" />
                                                            </td>
                                                            <td>
                                                                <input id="age_to1" type="text" style="width: 35px;" class="input-mini" />
                                                            </td>
                                                            <td>
                                                                <input id="male_lower1" type="text" style="width: 35px;" class="input-mini" />
                                                            </td>
                                                            <td>
                                                                <input id="male_higher1" type="text" style="width: 35px;" class="input-mini" />
                                                            </td>
                                                            <td>
                                                                <input id="female_lower1" type="text" style="width: 35px;" class="input-mini" />
                                                            </td>
                                                            <td>
                                                                <input id="female_higher1" type="text" style="width: 35px;"  class="input-mini" />
                                                            </td>
                                                        </tr>



                                                        <tr id="dummyrow1">
                                                            <td colspan="6">
                                                                <input value="<%=counter %>"   type="hidden" id="click_count1" name="detClickCount" />
                                                            </td>    
                                                        </tr>
                                                        </tbody>
                                                    </table>

                                                </div>


                                                <input name="typeoftest" type="hidden" value="1" />
                                            </div> 
                                                        <div  class="form-actions">
                                            <input class="input-medium" count="1" id="option1" type="hidden" name="labid" value="<%=labtypes.getDetailedInvId()%>">
                                            <button id="submitbutton" type="submit" name ="action" value="editlabreference" class="btn btn-danger btn-small pull-right">
                                                <i class="icon-ok icon-white"></i> Save Changes
                                            </button>

                                        </div>
                                        </fieldset>
                                        

                                    </form>         
                                </div>




                                    <div id="tabs-3">

                                        <form style="width: 50%;" id="maininvestigation" enctype="multipart/data"action="action/editlabresultsavingaction.jsp" method="POST" class="form-horizontal">
<fieldset>


                                            <div>


                                                <div class="control-group">
                                                    <label class="control-label" for="input01">Results Options</label>
                                                    <div class="controls">
                                                        <select class="input-mini" id="resultsoptions"  name="resultsoptions" id="select01">
                                                            <option value="Yes">Yes</option>
                                                            <option value="No">No</option>
                                                        </select>
                                                        <p class="help-inline">

                                                        </p>
                                                    </div>
                                                </div>

                                                <div id="add" class="control-group">
                                                    <div class="controls">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <%

                                                                        List<DetailedinvPosinvresults> possibleResultsList = mgr.listDetailedInvPosResults(labtypes.getDetailedInvId());
                                                                        System.out.println(" +++++++++++++ " + possibleResultsList.size());
                                                                        PossibleinvResults posInvResult = null;
                                                                        String existingResult = "";
                                                                        int countOfPosInvResults = 1;
                                                                        if (!possibleResultsList.isEmpty()) {
                                                                            for (DetailedinvPosinvresults posResults : possibleResultsList) {
                                                                                posInvResult = mgr.getPossibleInvResultById(posResults.getPosinvresultId());
                                                                                if (posInvResult != null && !posInvResult.getPosinvResult().isEmpty()) {
                                                                                    existingResult = posInvResult.getPosinvResult();
                                                                                }
                                                                    %>

                                                                    <input class="input-medium" name="option<%=countOfPosInvResults%>" type="text" value="<%=existingResult%>" />

                                                                    <%
                                                                                countOfPosInvResults++;
                                                                            }
                                                                        }

                                                                    %>

                                                                    <input class="input-medium" type="hidden" id="hiddencount" name="hiddencount" value="<%=countOfPosInvResults%>" />
                                                                    <input class="input-medium" name="option<%=countOfPosInvResults%>" type="text" />

                                                                </td>
                                                                <td>
                                                                    <input  id="resultoptionadd"  class="btn btn-info pull-right" type="button" value="Add" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>


                                                </div>

                                                <div id="clonehub" class="control-group hide clonehub">

                                                    <div style="padding-left: 8px;" class="controls">
                                                        <input class="input-medium" count="1" id="option1" type="text" >
                                                        <p class="help-inline">


                                                        </p>
                                                    </div>
                                                </div>
                                            </div>

                                            <div  class="form-actions">
                                                <input class="input-medium" count="1" id="option1" type="hidden" name="labid" value="<%=labtypes.getDetailedInvId()%>">
                                                <button id="submitbutton" type="submit" name ="action" value="editlabresultoptions" class="btn btn-danger btn-small pull-right">
                                                    <i class="icon-ok icon-white"></i> Save Changes
                                                </button>

                                            </div>
</fieldset>
                                        </form>

                                    </div>

                                </div>


                                <% }%>

                            </div>

                        </div>
                        <div class="clearfix"></div>

                    </div>


            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    

    </div>
</div>
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
        
        
    <%


    %>
        
        
            var click_count1 = $("#click_count1").attr("value");
            //alert(click_count1)
            $("#addrow1").click(function() {
                alert("Before"+click_count1)
             
                click_count1 =  parseInt(click_count1) + 1;
                 alert("After"+click_count1)
                var clone = $(".clone_source1").clone().attr("class", "clone");
           
                clone.find("#age_from1").attr("id", "age_from" + click_count1).attr("name", "age_from" + click_count1).attr("value", "");
                clone.find("#age_to1").attr("id", "age_to" + click_count1).attr("name", "age_to" + click_count1).attr("value", "");
                clone.find("#male_lower1").attr("id", "male_lower" + click_count1).attr("name", "male_lower" + click_count1).attr("value", "");
                clone.find("#male_higher1").attr("id", "male_higher" + click_count1).attr("name", "male_higher" + click_count1).attr("value", "");
                clone.find("#female_lower1").attr("id", "female_lower" + click_count1).attr("name", "female_lower" + click_count1).attr("value", "");
                clone.find("#female_higher1").attr("id", "female_higher" + click_count1).attr("name", "female_higher" + click_count1).attr("value", "");
            
                clone.insertBefore("#dummyrow1")
                                        
                $("#click_count1").attr("value",click_count1);                            
                // alert($("#click_count1").attr("value"));                
                                        
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
                width : 1000,
                modal :true,
                position : 'top'

            });
                
            $("#new_link").click(function(){
      
                $("#new").dialog('open');
    
            })
        
        
            $('#maininvestigation').validate({
                rules: {
                    type: {
              
                        required: true
                    },
                    code: {
                        minlength: 2,
                        required: true
                    },
                    name: {
                        minlength: 2,
                        required: false
                    }
                    ,
                    rate: {
                        required: true
                    },
                    nhisrate: {
                        required: true
                    },
                    specimen: {
                        required: true
                    },
                    optionsRadios: {
                        required: true
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
    
    
    
    
    
   
    var click_count = parseInt($("#hiddencount").attr("value"));
        
    $("#resultoptionadd").click(function() {
       
        click_count = parseInt(click_count) + 1;
        //alert(click_count);
        //alert($("#hiddencount").val());
        var clone = $(".clonehub").clone().attr("class","clone");
                   clone.find("#option1").attr("id","option"+click_count).attr("name","option"+click_count).attr("value","").attr("count",click_count);
                   clone.insertBefore("#clonehub");
        $("#hiddencount").attr("value",click_count);
        
           
    })
    
    
    $("#resultsoptions_antibiotics").change(function() {
             
           
        
        if($('#resultsoptions_antibiotics').is(':checked')){
            $(this).attr("value","Yes");
            //alert($(this).attr("value"));
            $("#add_antibiotics").slideDown();
                
                
        }else {
            $(this).attr("value","No");
            //alert($(this).attr("value"));
            $("#add_antibiotics").slideUp();
                
                
        }
            
            
    });
    
    
    
    <%if (refRangeIsNone) {%>
      
        
        $("#none_radio_display").css("display","block")
        $("#universal").hide()
        $("#detailed").hide()
        
    <%}%>
                                            
    <% if (refRangeIsUni) {%>
        
        $("#none_radio_display").hide()
        $("#universal").css("display","block")
        $("#detailed").hide()
        
        
     
    <% }%>
        
    <% if (refRangeIsDet) {%>
       
        $("#none_radio_display").hide()
        $("#universal").hide()
        $("#detailed").css("display","block")
        
    
    <% }%>
    
    
        /*
         *
         *
         *
    var click_count_antibiotics = 1;
        
    $("#resultoptionadd_antibiotics").click(function() {
       
        click_count_antibiotics = click_count_antibiotics + 1;
        
        //alert($("#hiddencount").val());
        var clone = $(".clonehub_antibiotics").clone().attr("class","clone_antibiotics");
                   clone.find("#option_antibiotics_1").attr("id","option"+"_antibiotics_"+click_count_antibiotics).attr("name","option"+"_antibiotics_"+click_count_antibiotics).attr("value","").attr("count",click_count_antibiotics);
                   clone.insertBefore("#clonehub_antibiotics");
        $("#hiddencount_antibiotics").attr("value", click_count_antibiotics);
        alert($("#hiddencount_antibiotics").attr("value"))
        
           
    })
         */    
               
               
           
   
            
            
            
            
            
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
                  
                    alert('No Main Tests Found Under Selected Lab Classification');
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
            alert("Delete Was Canceled!");
            //return;
        }
                 
                
    }
            
          
            
              
           
</script>
</body>
</html>