<%@page import="entities.Stafftable"%>
<!-- Navbar
        ================================================== -->
<div class="navbar navbar-fixed-top hide">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
            <a class="brand" href="#"><img src="images/logo.png" width="200px;" /></a>

            <div style="margin-top: 10px;" class="nav-collapse">

                <ul class="nav pull-right">

                    <li class="dropdown">
                        <a href="#">
                            <% Stafftable staff = (Stafftable) mgr.getStafftableByid(user.getStaffid());                                %>
                            Logged in as  :<span style="color: #4183C4;">   <%=mgr.getStafftableByid(user.getStaffid()).getOthername() %> <%=mgr.getStafftableByid(user.getStaffid()).getLastname()%>   </span> 
                        </a>

                    </li>
                    <li class="divider-vertical"></li>
                    <li>
                        <a href="#">
                            <span>   <%= mgr.getRoleByid(staff.getRole()).getRolename()%>  </span>
                        </a>
                    </li>


                    <li class="divider-vertical"></li>

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-user"></i> User Actions <b class="caret"></b></a>
                        <ul class="dropdown-menu">

                            <li>
                                <a href="staffprofile.jsp"><i class="icon-user"></i> My Profile </a>
                            </li>

                            <li>
                                <a href="#"><i class="icon-question-sign"></i> Help </a>
                            </li>
                            <li>
                                <a href="#"><i class="icon-share"></i> Feedback </a>
                            </li>
                            <li class="divider"></li>

                            <li>
                                <a href="logout.jsp"><i class="icon-off"></i> Log Out</a>
                            </li>

                        </ul>
                    </li>
                    <li>
                        <a href="" style="padding: 3px;"  class="btn btn-mini"><i class="icon-refresh"> </i>  Reload </a>
                    </li>
                    <li>
                        <button class="btn btn-inverse" type="button" value="Back" onclick="window.history.back()" >
                            <i class="icon icon-white icon-arrow-left"></i>   Back
                        </button>
                        </li>
                 <!--   <li>
                        <a href="" style="padding: 3px;"  class="btn btn-mini"><i class="icon-arrow-left "> </i> Back </a>
                    </li>  -->
                </ul>
            </div>
        </div>
    </div>
</div>