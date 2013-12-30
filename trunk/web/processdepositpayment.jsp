<%-- 
    Document   : accounts
    Created on : Jul 26, 2012, 8:55:54 AM
    Author     : ClaimSync
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="entities.*,java.util.List,java.util.Date,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="widgets/stylesheets.jsp" %>
        <%
            Users user = (Users) session.getAttribute("staff");
            ArrayList<Integer> list = (ArrayList<Integer>) session.getAttribute("staffPermission");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            DecimalFormat df = new DecimalFormat();

            String visitString = request.getParameter("visitid");

            int visitid = 0;
            if (!visitString.equalsIgnoreCase("")) {
                try {
                    visitid = Integer.parseInt(visitString);
                } catch (NumberFormatException ex) {
                    session.setAttribute("class", "alert-error");
                    session.setAttribute("lasterror", "Please Try Again");
                    response.sendRedirect("inpatientdepositshub.jsp");
                    ex.printStackTrace();
                }



            }




            df.setMinimumFractionDigits(2);
            if (user == null) {
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            Date date = new Date();
            double registrationFee = 0;
            Visitationtable vst = mgr.getVisitById(visitid);
            if (vst == null) {
                session.setAttribute("lasterror", "Please Select Patient With Initiated Visit");
                response.sendRedirect("inpatientdepositshub.jsp");
            }

        %>
    </head>


    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <%@include file="widgets/header.jsp" %>



        <!-- Masthead
        ================================================== -->
        <header  class="jumbotron subhead" id="overview">

            <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                <ul class="nav nav-pills">

                    <li>
                        <a href="#">Billing</a><span class="divider"></span>
                    </li>
                    <li  class="active">
                        <a href="#"> Deposit Payment - <%=mgr.getVisitById(visitid).getPatientid()%> | <%=mgr.getPatientByID(mgr.getVisitById(visitid).getPatientid()).getFname()%> <%=mgr.getPatientByID(mgr.getVisitById(visitid).getPatientid()).getLname()%></a><span class="divider"></span>
                    </li>

                </ul>
            </div>

        </header>

        <%@include file="widgets/loading.jsp" %>

        <section class="container-fluid" style="margin-top: -30px;" id="dashboard">

            <%if (session.getAttribute("lasterror") != null) {%>
            <div class="alert hide <%=session.getAttribute("class")%> span12 center">
                <b> <%=session.getAttribute("lasterror")%>  </b>
            </div>
            <br/>
            <div style="margin-bottom: 20px;" class="clearfix"></div>
            <%session.removeAttribute("lasterror");
                }%>

            <div class="row-fluid">

                <%@include file="widgets/leftsidebar.jsp" %>


                <div style="display: none;" class="span8 thumbnail main-c">

                    <table class="example display">
                        <thead>
                            <tr>
                                <th style="font-size: 12px;"> Folder Number</th>
                                <th style="font-size: 12px;"> Patient Name </th>
                                <th style="font-size: 12px;"> Payment Type </th>
                                <th style="font-size: 12px;"> Date of Birth  </th>
                                <th style="font-size: 12px;"> Requested On </th>
                                <th style="text-transform: capitalize; font-size: 12px;"> <%--=(String) session.getAttribute("unit")--%></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="text-transform: uppercase; color: #4183C4; font-weight: bolder; font-size: 18px;" class="patient" rel="popover" data-original-title="<span style='text-align:center;'> <h3>Patient Information Summary </h3> <h5><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></h5> <h5><b> Date of Birth :</b> <%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%></h5> </span>"
                                    data-content="<table class='table table-bordered'> <tr> <td> Gender  </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getGender()%> </td> </tr> <tr> <td> Employer </td> <td> <%=mgr.getPatientByID(vst.getPatientid()).getEmployer()%> </td>  </tr> <tr> <td> Sponsor </td> <td> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td> </tr> <tr>
                                    <td> Policy Number </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%> </td> </tr> <tr> <td> Benefit Plan </td> <td> <%=mgr.sponsorshipDetails(vst.getPatientid()).getBenefitplan()%> </td> </tr>  </table> "> <%=vst.getPatientid()%>   </td>
                                <td><%=mgr.getPatientByID(vst.getPatientid()).getFname()%> <%=mgr.getPatientByID(vst.getPatientid()).getMidname()%> <%=mgr.getPatientByID(vst.getPatientid()).getLname()%></td>
                                <td><%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()) == null ? mgr.sponsorshipDetails(vst.getPatientid()).getType() : mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%> </td>

                                <td><%=formatter.format(mgr.getPatientByID(vst.getPatientid()).getDateofbirth())%> </td>

                                        <!--<td><%=mgr.sponsorshipDetails(vst.getPatientid()).getMembershipid()%>   </td>  -->

                                <td><%=formatter.format(vst.getDate())%> </td>

                                <td>
                                    <button class="btn btn-info btn-small" id="<%=vst.getVisitid()%>_link">
                                        Make Payment
                                    </button>
                                </td>
                            </tr>


                        </tbody>
                    </table>

                </div>


                <div class="clearfix"></div>



        </section>

        <%@include file="widgets/footer.jsp" %>
        <div class="dialog" id="<%=vst.getVisitid()%>_dialog" title="<img src='images/danpongclinic.png' width='120px;'  class='pull-left' style='margin-top: 0px; padding: 0px;'/> <span style='font-size: 18px; position: absolute; right: 3%; top: 29%; text-transform: uppercase;'> DEPOSIT PAYMENT FOR | <%= mgr.getPatientByID(vst.getPatientid()).getFname()%> <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>  |  <%= mgr.getPatientByID(vst.getPatientid()).getPatientid()%> </span>"> 

            <span class="pull-left">
                <dl class="dl-horizontal">
                    <dt style="text-align: left;" >Date:</dt>
                    <dd><%= formatter.format(vst.getDate())%> </dd>
                    <dt style="text-align: left;" >Invoice No.</dt>
                    <dd style="text-transform: uppercase;">INV<%=vst.getVisitid()%></dd>
                    <% session.setAttribute("visit_id", vst.getVisitid() + "");%>
                    <dt style="text-align: left;" >Account</dt>
                    <dd style="text-transform: capitalize;"><%=mgr.sponsorshipDetails(vst.getPatientid()).getType()%> Patient</dd>
                    <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private")) {%>
                    <dt style="text-align: left"> Insured By: </dt>
                    <dd> <%=mgr.getSponsor(mgr.sponsorshipDetails(vst.getPatientid()).getSponsorid()).getSponsorname()%></dd>

                    <% }%>
                    <dt style="text-align: left;" >Name:</dt>
                    <dd><%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                        <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                        <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                    </dd>
                    <dt style="text-align: left;" >Card No:</dt>
                    <dd style="text-transform: uppercase;">
                        <b> <%= vst.getPatientid()%> </b>
                    </dd>

                </dl>

            </span>

            <div class="clearfix">
            </div>    
            <form action="action/accountsaction.jsp" method="POST">
                <div class="center thumbnail">

                    <span style="font-weight: bolder;" class="lead"> <u> DEPOSIT PAYMENT </u> </span>

                    <table class="table">
                        <% if(vst.getDepositedAmount() > 0){ %>
                        <tr>
                            <td style="font-size: 18px;">
                               Previously Deposited Total
                            </td>
                            <td style="text-align: right; font-size: 18px;">
                                <%= df.format(vst.getDepositedAmount()) %>
                            </td>
                        </tr>
                        
                        <% } %>
                        
                        <tr>
                            <td style="font-size: 18px;">
                                Deposited Amount
                            </td>
                            <td style="text-align: right">
                                GHS <input style="text-align: right; height: 30px; font-size: 22px;" type="text" class="input-small amountpaidinput<%= vst.getVisitid()%>" name="amountdeposited" value="" placeholder="0.00"/>

                            </td>
                        </tr>

                    </table>


                </div>
                <div style="margin-bottom: 10px;" class="clearfix">

                </div>
                <button style="width: 45%" type="button" onclick='printSelection(document.getElementById("print<%=vst.getVisitid()%>")); return false' class="btn btn-info btn-large pull-left">
                    <i class="icon-print icon-white"></i>  Print Receipt 
                </button>
                <input type="hidden" name="visitid" value="<%=vst.getVisitid()%>"/>
                <button id="saveDeposit" name="action" value="depositpayment" onclick="printSelection(document.getElementById('print<%=vst.getVisitid() %>')); document.form.submit(); return false" style="width: 45%" type="submit" disabled="disabled" class="btn btn-danger btn-large pull-right">
                    <i class="icon-arrow-right icon-white"></i>  Save Transaction
                </button>

            </form>
        </div>



        <div style="text-align: center; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif" id="print<%=vst.getVisitid()%>" style="display: none">
            <section class="hide" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="container">

                    <div style="margin-bottom: -15px;" class="row">
                        <div class="span3" style="float: left;">
                            <img src="images/danpongclinic.png" width="100px;" style="margin-top: 30px;" />
                        </div>

                        <img src="images/danpongaddress.png" width="100px;" style="float: right; margin-top: 20px;" /> 


                    </div>
                </div>

                <div style="clear: both;"></div>

                <hr style="border: solid #000000 0.5px ;"  />

                <div style="text-align: center;  margin-top: 0px;" class="row center ">

                    <h3 style=" margin-top: 5px;text-align: center; color: #FF4242; width: 100%; letter-spacing: 0px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; margin-bottom: 4px; margin-top: 2px; font-size: 14px; "> 

                        <% if (mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("nhis") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("private") || mgr.sponsorshipDetails(vst.getPatientid()).getType().equalsIgnoreCase("cooperate")) {%> 
                        OFFICIAL INVOICE 
                        <% } else {%> OFFICIAL RECEIPT <% }%> </h3>

                </div>
                <hr class="row" style="border-top: 2px solid #000;;margin-top: 0px;" >


                <div style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;" class="row center">
                    <table style="width: 300px; float: left; margin-left: 6px; font-size:  12px;">
                        <tr>
                            <td style="line-height: 25px;">
                                Date
                            </td>
                            <td style="line-height: 25px;">
                                <%= formatter.format(vst.getDate())%>
                            </td>
                        </tr>


                        <tr>
                            <td style="line-height: 25px;">
                                Account
                            </td>
                            <td style="line-height: 25px;">
                                <%=mgr.sponsorshipDetails(vst.getPatientid()).getType()%> Patient
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 25px;">
                                Name:
                            </td>
                            <td style="line-height: 25px;">
                                <%= mgr.getPatientByID(vst.getPatientid()).getFname()%>
                                <%= mgr.getPatientByID(vst.getPatientid()).getMidname()%>
                                <%= mgr.getPatientByID(vst.getPatientid()).getLname()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 25px;">
                                Folder Number
                            </td>
                            <td style="line-height: 25px; text-transform: uppercase">
                                <%= vst.getPatientid()%>
                            </td>
                        </tr>


                    </table>



                    <div style="clear: both;"></div>

                    <hr class="row" style="border-top: 2px solid  #000;
                        margin-top: 5px;" >
                    <div class="row center">

                        <h3 style="font-weight:300; font-size: 13px; letter-spacing: 2px;  margin-top: 5px;text-align: center; width: 100%; letter-spacing: 2px;">
                            INPATIENT DEPOSIT</h3>

                    </div>

                    <table style="width: 100%" cellspacing="0">
                        <thead>
                            <tr  style=" border: solid 1px black ; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
                                <th style="border: solid 1px black ; border-spacing: 0px; text-align: left; padding-bottom:  7px; padding-top: 5px; border-right: none; padding-left: 15px; text-decoration: underline;">Description </th>

                                <th style="text-align: right;  border: solid 1px black ; padding-bottom:  7px; padding-top: 5px; padding-right: 5px;  border-left: none; text-decoration: underline;">
                                    Total
                                </th>

                            </tr>
                        </thead>
                        <tbody style="font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">




                            <tr>
                                <td style="padding-left: 15px; line-height: 25px;">
                                    Deposited Amount
                                </td>
                                <td style="text-align: right;  margin-right: 20px;" class="amountpaidtext<%=vst.getVisitid()%>">

                                </td>
                            </tr>



                        </tbody>
                    </table>

                </div>
                <div style="clear: both"></div>

                <div style=" position: absolute; bottom: 10px; width: 100%; text-align: center; font: 12px lighter;  font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">

                    Served by  <%= mgr.getStafftableByid(user.getStaffid()).getLastname()%> <br/> 
                    Wishing You Speedy Recovery <br /> Thank you
                </div>
                <!--  <img src="images/danpongfooter.png" width="100%" style="position: absolute; bottom: 0px; "/>   -->    
            </section> 
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

        <script type="text/javascript" src="js/jquery.filter_input.js "></script>
        <!--initiate accordion-->
        <script type="text/javascript">
    
    
            function printSelection(node){

                var content=node.innerHTML
                var pwin=window.open('','print_content','width=400,height=900');

                pwin.document.open();
                pwin.document.write('<html><body onload="window.print()">'+content+'</body></html>');
                pwin.document.close();
 
                setTimeout(function(){pwin.close();},1000);

            }
    
    
            $(function() {
        
                $('.decimal').live("keyup",function(){inputControl($(this),'float');});
        
        
        
        
                $("input:checkbox").attr("checked", true);
                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                $(".menu").fadeIn();
                $(".main-c").fadeIn();
                $("#sidebar-toggle-container").fadeIn();
                $(".navbar").fadeIn();
                $(".footer").fadeIn();
                $(".subnav").fadeIn();
                $(".alert").fadeIn();
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
                    "sPaginationType" : "full_numbers",
                    "iDisplayLength" : 25,
                    "aaSorting" : [],
                    "bSort" : true,
                    "sScrollY" : 400

                }); 
        
                $('#sidebar-toggle').click(function(e) {
                    e.preventDefault();
                    $('#sidebar-toggle i').toggleClass('icon-chevron-left icon-chevron-right');
                    $('.menu').animate({width: 'toggle'}, 0);
                    $('.menu').toggleClass('span3 hide');
                    $('.main-c').toggleClass('span8');
                
                });
                $(".patient").popover({

                    placement : 'right',
                    animation : true

                });
            });

                
            $("#<%= vst.getVisitid()%>_dialog").dialog({
                autoOpen : true,
                width : "90%",
                modal :true,
                position: "top"
            });
  
            $("#<%= vst.getVisitid()%>_link").click(function(){
                $("#<%=vst.getVisitid()%>_dialog").dialog('open');   
            })
            
            
            $(".amountpaidinput<%= vst.getVisitid()%>").live('keyup',function(){
           
                var amountpaid = $(".amountpaidinput<%= vst.getVisitid()%>").attr("value");
                
                amountpaid = parseFloat(amountpaid).toFixed(2);
                
                if(isNaN(amountpaid)){
                    amountpaid = 0.00;
                    $("#saveDeposit").attr("disabled,disabled");
                }else{
                    if(amountpaid > 0){
                        $("#saveDeposit").removeAttr("disabled");
                    }else{
                        $("#saveDeposit").attr("disabled,disabled");
                    }
                }
                            
                
                
                
                
                $(".amountpaidtext<%= vst.getVisitid()%>").html(amountpaid)
               
            });
    
        </script>

    </body>
</html>