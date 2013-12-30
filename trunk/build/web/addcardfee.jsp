

<%@page import="java.text.DecimalFormat"%>
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
            boolean foundCardFees = false;

            DecimalFormat df = new DecimalFormat();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            df.setMinimumFractionDigits(2);
        %>


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
                            <a href="#">Card Printing Fee Management</a><span class="divider"></span>
                        </li>

                    </ul>
                </div>

            </header>

            <%@include file="widgets/loading.jsp" %>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">


                    <%@include file="widgets/adminpanelleftsidebar.jsp" %>
                    <%

                        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

                        // HMSHelper mgr = new HMSHelper();

                        List cardFees = mgr.listCardFees();
                        // List registration = mgr.getPatientReg(vst.getPatientid());
                        if (!cardFees.isEmpty()) {
                            foundCardFees = true;
                        }



                    %>     
                    <div style="margin-top: 0px; "class="span9 offset3 content1">

                        <div style="padding-bottom: 80px;" class="span9 thumbnail  content">
                            <ul style="margin-left: 0px; padding-bottom: 15px;" class="breadcrumb">
                                <li>
                                    <h4>Card Issuance Fee</h4>

                                </li>
                                <li class="pull-right">
                                    <a href="#" class="btn btn-small btn-info new_link">
                                        <i class="icon-plus-sign icon-white"></i> Modify Card Issuance Fee 
                                    </a>
                                </li>

                            </ul>
                            <table class="example">
                                <thead>
                                    <tr>

                                        <th>
                                            Date Modified
                                        </th>
                                        <th>
                                            Card Issuance Fee  (GH&#162)
                                        </th>
                                        <th>
                                            Status
                                        </th>


                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        int cardFeeId = 0;
                                        CardFee cardFee;

                                        for (int p = 0; p < cardFees.size(); p++) {
                                            cardFee = (CardFee) cardFees.get(p);
                                            cardFeeId = cardFee.getId();
                                    %>
                                    <tr>

                                        <td>
                                            <%=formatter.format(cardFee.getDateAdded())%>
                                        </td>
                                        <td style="text-align: right; padding-right: 20px;">
                                            <%= df.format(cardFee.getCardFee())%>
                                        </td>
                                        <td>
                                            <% if (cardFee.getStatus().equalsIgnoreCase("Yes")) {%>

                                            <label class="label label-success center"> Active </label>

                                            <% } else {%>

                                            <label class="label label-important center">  Inactive </label>

                                            <% }%>
                                        </td>

                                    </tr>
                                    <%
                                        }
                                    %>




                                </tbody>


                            </table>

                            <div class="new">

                                <form id="cardfee" class="form-horizontal" action="action/cardfeeaction.jsp" method="post" name="items" > 
                                    <!-- onsubmit="return validateForm();"  -->

                                    <fieldset>

                                        <div class="control-group">

                                            <div class="control-group">
                                                <label class="control-label" for="input01">Card Issuance Fee : </label>
                                                <div class="controls">
                                                    <p class="help-inline"> GH&#162</p>
                                                    <input type="text" class="input-small"  name="cardFee">

                                                </div>
                                            </div>

                                            <div class="form-actions">
                                                <button class="btn btn-info btn-small" type="submit" name="action" value="units" id="b">
                                                    <i class="icon-plus-sign icon-white"> </i> Save New Card Issuance Fee 
                                                </button>

                                            </div>
                                    </fieldset>
                                </form>
                            </div>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>


            </section>

            <%@include file="widgets/footer.jsp" %>

        </div><!-- /container -->    


        <%@include file="widgets/javascripts.jsp" %>
        <script type="text/javascript">
            $(".new").dialog({
                autoOpen : false,
                width : 600,
                modal :true,
                title: 'Modify Card Issuance Fee Fee'

            });
            
            $(".new_link").click(function(){
      
                $(".new").dialog('open');
    
            })
            
            
            $(document).ready(function(){
        
        
                $('#cardfee').validate({
                            
                    rules: {
                        cardFee: {
                            required: true,
                            minlength : 2
                                    
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
                })
        
        
            })
        </script>
    </body>
</html>