<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    DecimalFormat df = new DecimalFormat();
    df.setMinimumFractionDigits(2);

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat datetimeformat = new SimpleDateFormat("dd-MM-yyyy | hh:mm");
    SimpleDateFormat time = new SimpleDateFormat("h:mm a");
%> 
<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    String searchid = request.getParameter("searchid") == null ? "" : request.getParameter("searchid");
    String searchquery = request.getParameter("searchquery") == null ? "" : request.getParameter("searchquery");
    List nhisinvestigations = null;
    List investigations = null;
    LabPatient p = null;
    Patient q = null;
    List list = null;

    try {
        if (searchid.equalsIgnoreCase("labordernumber")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("completedlabsearch.jsp");
                return;
            }

            List dispatch = mgr.listLabordersByStatusNOrderId("Dispatched", searchquery.trim());
            list = mgr.listLabordersByStatusNOrderId("Returned", searchquery.trim());
            list.addAll(dispatch);

            System.out.println("l.size : " + list.size());

        }
        if (searchid.equalsIgnoreCase("fullname")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("completedlabsearch.jsp");
                return;
            }
            List patientsNamesList = mgr.getLabPatientByName(searchquery.trim());
            System.out.println("patient " + patientsNamesList.size());

            if (!patientsNamesList.isEmpty()) {

                // get the actual patients and put them in a list
                LabPatient lPatient;
                for (int i = 0; i < patientsNamesList.size(); i++) {
                    lPatient = (LabPatient) patientsNamesList.get(i);

                    p = mgr.getLabPatientByID(lPatient.getPatientid());

                    List dispatch = mgr.listLabordersByStatusNPatientid("Dispatched", p.getPatientid());
                    list = mgr.listLabordersByStatusNPatientid("Returned", p.getPatientid());
                    list.addAll(dispatch);
                }

            } else {
                session.setAttribute("lasterror", "Patient Called " + searchquery.trim() + " Not Found !!");
                session.setAttribute("class", "alert");
                response.sendRedirect("completedlabsearch.jsp");
                return;
            }

        }
        if (searchid.equalsIgnoreCase("patientid")) {
            if (searchquery.equals("")) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("records.jsp");
                return;
            }
            p = mgr.getLabPatientByID(searchquery.trim());

            if (p == null) {
                session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
                session.setAttribute("class", "alert");
                response.sendRedirect("completedlabsearch.jsp");
                return;
            }

            List dispatch = mgr.listLabordersByStatusNPatientid("Dispatched", p.getPatientid());
            list = mgr.listLabordersByStatusNPatientid("Returned", p.getPatientid());
            list.addAll(dispatch);

            System.out.println("l.size : " + list.size());
        }


    } catch (ArrayIndexOutOfBoundsException e) {
        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
        session.setAttribute("class", "alert");
        response.sendRedirect("completedlabsearch.jsp");
        return;
    } catch (NullPointerException e) {
        session.setAttribute("lasterror", "Invalid search. Please enter a correct value in the field provided");
        session.setAttribute("class", "alert");
        response.sendRedirect("completedlabsearch.jsp");
        return;
    }


%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <a href="#">Laboratory Records</a><span class="divider"></span>
                        </li>
                        <li class="active">
                            <a href="#">Archive Search Results</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <%if (list != null) {%>

            <div class="container-fluid">
                <section style="margin-top: -30px;" id="dashboard">

                    <!-- Headings & Paragraph Copy -->
                    <div class="row">
                        <%@include file="widgets/laboratorywidget.jsp" %>

                        <div style="display: none;" class="span9 offset3 thumbnail well content1 hide">
                            <table cellpadding="0" cellspacing="0" border="0" class="display example table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left"> Laboratory Number </th>
                                        <th style="text-align: left;"> Patient Name </th>
                                        <th style="text-align: left;"> Payment Type </th>
                                        <th style="text-align: left;"> Date of Birth  </th>


                                        <th style="text-align: left;"> Requested On </th>
                                        <th style="text-align: left;"> Time </th>
                                        <th></th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        Laborders labOrder;
                                        for (int i = 0; i < list.size(); i++) {
                                            labOrder = (Laborders) list.get(i);
                                            if (labOrder.getPatientid().contains("DC")) {

                                                q = mgr.getPatientByID(labOrder.getPatientid());
                                            } else {
                                                p = mgr.getLabPatientByID(labOrder.getPatientid());
                                            }
                                            System.out.println("test " + list.size());
                                            if (labOrder.getPatientid().contains("DC")) {%>
                                    <tr class="odd gradeX">
                                        <td style="text-transform: uppercase;  font-weight: bold ;font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(q.getPatientid()).getFname()%> <%=mgr.getPatientByID(q.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(q.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(q.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(q.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(q.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(q.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(q.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(q.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(q.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%= labOrder.getOrderid()%></td>

                                        <td><%= q.getFname()%> 
                                                <% if (q.getMidname() != null) {%>
                                                <%= q.getMidname()%>
                                                <% }%>
                                                <%= q.getLname()%>
                                            </td>

                                        <td style="text-align: left;"><%=mgr.sponsorshipDetails(q.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(q.getPatientid()).getSponsorid()).getSponsorname()%> 
                                        </td>
                                        <td>
                                            <%= formatter.format(q.getDateofbirth())%>
                                        </td>
                                        <td style="text-align: left;"><%=formatter.format(labOrder.getOrderdate())%></td>
                                        <td style="text-align: left;"><%=time.format(labOrder.getOrderdate())%></td>
                                        <td style="text-align: center;">
                                            <form style="margin: 0px;" action="dispatched.jsp" method="post">
                                                <input type="hidden" name="labOrderId" value="<%=labOrder.getOrderid()%>"/>
                                                <button type="submit" name="action" class="btn btn-small btn-info">
                                                    <i class="icon-white icon-search"></i> View Lab Report
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%} else {%>
                                    <tr class="odd gradeX">
                                        <td style="text-transform: uppercase;  font-weight: bold; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getLabPatientByID(p.getPatientid()).getFname()%> <%=mgr.getLabPatientByID(p.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getLabPatientByID(p.getPatientid()).getDateofbirth())%></h5> </span>"
                                            data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getLabPatientByID(p.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getLabPatientByID(p.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Payment Type </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(p.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                            <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(p.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(p.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "><a href="#"> <%= labOrder.getOrderid()%></td>

                                        <td><%= p.getFname()%> 
                                                <% if (p.getMidname() != null) {%>
                                                <%= p.getMidname()%>
                                                <% }%>
                                                <%= p.getLname()%>
                                            </td>
                                        <td style="text-align: left;"><%=mgr.sponsorshipDetails(p.getPatientid()) == null ? "" : mgr.getSponsor(mgr.sponsorshipDetails(p.getPatientid()).getSponsorid()).getSponsorname()%> 
                                        </td>
                                        <td>
                                            <%= formatter.format(p.getDateofbirth())%>
                                        </td>

                                        <td style="text-align: left;"><%=formatter.format(labOrder.getOrderdate())%></td>
                                        <td style="text-align: left;"><%=time.format(labOrder.getOrderdate())%></td>

                                        <td style="text-align: center;">
                                            <form style="margin: 0px;" action="dispatched.jsp" method="post">
                                                <input type="hidden" name="labOrderId" value="<%=labOrder.getOrderid()%>"/>
                                                <button type="submit" name="action" class="btn btn-small btn-info">
                                                    <i class="icon-white icon-search"></i> View Lab Report
                                                </button>
                                            </form>
                                        </td>
                                    </tr>

                                    <% }
                                        }%>
                                </tbody>
                            </table>

                        </div>
                        <div class="clearfix"></div>

                    </div>

                </section>

                <%@include file="widgets/footer.jsp" %>
            </div>


            <%
            } else {

            %>

            <br/> 

            <div class="alert hide alert-info container center">
                <b> No Results Found!  </b>
            </div>
            <br/>
            <div class="container-fluid center">


                <img id="bgimage"  class="center hide" width="40%" src="images/logoonly.png" />

            </div>   
            <%        }
            %>

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
            <script type="text/javascript" charset="utf-8" src="media/js/ZeroClipboard.js"></script>
            <script type="text/javascript" charset="utf-8" src="media/js/TableTools.js"></script>


            <!--initiate accordion-->
            <script type="text/javascript">
                $(function() {

                    var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                    menu_ul.hide();

                    $(".menu").fadeIn();
                    $(".alert").fadeIn();
                    $(".content1").fadeIn();
                    $(".navbar").fadeIn();
                    $(".footer").fadeIn();
                    $(".subnav").fadeIn();
                    $("#bgimage").fadeIn();
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
                
                
            
                    var counter = 0;
                    var labtestpricetotal = 0;
            
                    $(".selected_result").change(function(){
                        var labtestname =  $(this).attr("labtestname");
                        var labtestprice = $(this).attr("labtestprice");
                        var labtestpricevalue = $(this).attr("labtestpricevalue");
                        var labid = $(this).attr("labid");
                   
                    
                    
                   
                        if($(this).is(':checked')){ 
                            counter = counter + 1;
                            $(this).addClass("counter"+counter)
                            labtestpricetotal = parseInt(labtestpricetotal) + parseInt(labtestpricevalue)
                            $("#labtestpricetotal").html("<b> GH&#162;"+parseFloat(labtestpricetotal).toFixed(2)+ "</b>")
                            $('#selected_tests tbody').append("<tr ><td  class="+labid+ ">"+labtestname +"</td><td class="+labid+ ">"+ labtestprice +" </td></tr>");
                        
                            return false;
                        
                   
                        }else{
                            labtestpricetotal = parseInt(labtestpricetotal) - parseInt(labtestpricevalue)
                            $("."+labid).hide();
                            $("#labtestpricetotal").html("<b> GH&#162;"+parseFloat(labtestpricetotal).toFixed(2)+ "</b>")
                        
                        }
                    
                    
                    
                    });
                
                
                

                });

            </script>
            
            <script type="text/javascript" charset="utf-8">
                var addcount = 0;
                var tt =0;
                $(document).ready(function() {
                    $("input:checkbox").attr("checked", false);
                    $('.example').dataTable({
                        "bJQueryUI" : true,
                        "sScrollY" : "450px",
                        "sPaginationType" : "full_numbers",
                        "iDisplayLength" : 25,
                        "aaSorting" : [],
                        "bSort" : true
                        

                    });

                    $(".patient").popover({

                        placement : 'right',
                        animation : true

                    });

                    $(".patient_visit").popover({

                        placement : 'top',
                        animation : true

                    });
                
                    $("#refer").live('keyup', function(){
                
                        alert($(this).val());
                        //$("#refertext").attr("value",$("refer").val());
                    });  
                
                });
            
                function showConType(id){
                    var show = document.getElementById(id);
                    //var shows = document.getElementById("nhis");
                    //if(show.style.display == "block"){
                    show.style.display="block";
                    //}else{
                
                    //  } if(show.style.display == "none"){ 
                    // shows.style.display="none";
                }
            
                function getContype(){
                    var show = document.getElementById("ty").value
                    document.getElementById("contype").value = show;
                    var t = document.getElementById("contype").value;
                }
                function getType(i,d){
                    var show = document.getElementById(i).value
                    document.getElementById(d).value = show;
                    var t = document.getElementById("contype").value;
                }
            
                function addInvestigationCheck(id1,id2,id3,id4){
                    // alert(id1);
                    addcount++;
                    var t1 = document.getElementById(id1).value;
                    // var text = document.getElementById(id1);
                    // alert(t1);
                    var tr = document.createElement("tr");
                    var td1 = document.createElement("td"); 
                    var td5 = document.createElement("td");
                    var td6 = document.createElement("td");
                
                    var tr1 = document.createElement("tr");
                    var td7 = document.createElement("td"); 
                    var td8 = document.createElement("td");
                    var td9 = document.createElement("td");
                
                    var tr2 = document.createElement("tr");
                
                    var cb = document.createElement( "input" );
                    var input = document.createElement( "input" );
                    var btn = document.createElement( "button" );
                    var btn1 = document.createElement( "button" );
                    btn.innerHTML = 'Remove';
                    btn1.innerHTML = 'Remove';
                    cb.type = "checkbox";
                    input.type = "text";
                    cb.id = "id";
                    input.id ="in_"+addcount;
                    cb.name = "labtest1";
                    var ttt = t1;
                    var str = t1.split("><");
                
                    var text = document.createTextNode(str[0]+" ---  "+str[2]+"0");
                    var text1 = document.createTextNode(str[0]);
                    var text2 = document.createTextNode(str[2]);
                    //var price = document.createTextNode(str[2]);
                    cb.value = ttt;
                    cb.checked = true;
                    td1.appendChild(text);
                    td6.appendChild(btn);
                
                    td5.appendChild(cb);
                    tr.id = "tr1_"+addcount;
                    tr.appendChild(td1);
                    tr.appendChild(td5);
                    tr.appendChild(td6);
                
                    tr1.id = "tr1_"+addcount;
                    td7.appendChild(text1);
                    td8.id = "td_"+addcount;
            
              
                    input.value = ttt;
                    input.name="labtest[]"
                    // input.value = input.name;
                    //input.disabled = "disabled";
                
                    td9.appendChild(input);
                    tr1.appendChild(td7);
                    // tr1.appendChild(td9);
                    tr2.id = "tr1_"+addcount;
                    tr1.appendChild(td8);
                    tr2.appendChild(td9);
                    document.getElementById(id2).appendChild(tr);
                    document.getElementById(id3).appendChild(tr1);
                    document.getElementById(id4).appendChild(tr2);
                    //  document.getElementById(id3).appendChild(total);
                    //var ch = document.getElementById("labtest");
               
                    btn.onclick = function(){
    
                        var tbl = document.getElementById(id2);
                        var tb2 = document.getElementById(id3);
                        var tb3 = document.getElementById(id4);
                    
                        var rem = confirm("Are you sure you to remove this diagnosis");
                        if(rem){
                            tbl.removeChild(document.getElementById(tr.id));
                            tb2.removeChild(document.getElementById(tr1.id));
                            tb3.removeChild(document.getElementById(tr2.id));
                            addcount--;
                            alert("Removed Successfully");
                            return false;
                        }else{
                            return false;
                        }
                    };
                }
            
                function getTotal(){
                    var vl="";
                    for(var i=1;i<= addcount;i++){
                        vl = document.getElementById("in_"+i).value;
                        tt = tt + parseInt(vl, 0);
                    }
                    return tt;
                    //alert(tt);
                }
            
                function printSelection(node){

                    var content=node.innerHTML
                    var pwin=window.open('','print_content','width=800,height=1000');

                    pwin.document.open();
                    pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                    pwin.document.close();
 
                    setTimeout(function(){pwin.close();},1000);

                }
                $("#new_dialog").dialog({
                    autoOpen : false,
                    width : 900,
                    modal :true

                });
    
                $("#new_dialog_link").click(function(){
      
                    $("#new_dialog").dialog('open');
    
                })   
            </script>
            <% if (list != null) {
                    for (int i = 0;
                            i < list.size();
                            i++) {
                        Laborders vst = (Laborders) list.get(i);
            %>
            <script type="text/javascript">
   
                      
                $("#<%= vst.getPatientid()%>_dialog").dialog({
                    autoOpen : false,
                    width : 1200,
                    modal :true

                });
    
                $("#<%= vst.getPatientid()%>_patientidlink").click(function(){
      
                    $("#<%=vst.getPatientid()%>_dialog").dialog('open');
    
                })    
   
        
   
    
            </script>
            <% }
                }%>



    </body>
</html>


<%--


                        
                        



                            

                            

                        </div>
                        <div style="clear: both"></div>

                        <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                            Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                            Wishing You Speedy Recovery <br /> Thank you
                        </div>
                    
--%>
