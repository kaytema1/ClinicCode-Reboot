<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="entities.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.HMSHelper"%>
<%@page import="java.text.DateFormat"%>
<%
    HMSHelper mg = new HMSHelper();
    ExtendedHMSHelper mgr1 = new ExtendedHMSHelper();
    DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
    ArrayList<Integer> permissions = (ArrayList<Integer>) session.getAttribute("staffPermission");
    Date dt = new Date();
    //System.out.println(dateFormat.format(date));
    List vjs = mg.listRecentVisits(dateformat.format(dt), "In Patient");
    List outs = mg.listRecentVisits(dateformat.format(dt), "Out Patient");
    List labs = mg.listUnitVisitations("Laboratory", dateformat.format(dt));
    List pharmacy = mg.listUnitVisitations("Laboratory", dateformat.format(dt));
    
    List accs = mg.listUnitVisitations("Laboratory", dateformat.format(dt));
    List rms = mg.listUnitVisitations("Room 1", dateformat.format(dt));
    List labsnotdone = mg.listLabordersByStatus("Not Done");
    List dispatchedLabs = mg.listLabordersByStatus("Dispatched");
    List returnedLabs = mg.listLabordersByStatus("Returned");
    returnedLabs.addAll(dispatchedLabs);
    List newLabs = mg.listLabordersByStatuses("Approved", "Out-Complete");
    List notcompletedLabs = mg.listLabordersByStatus("Out-Complete");
    List phlem = mg.listLabordersByStatus("Phlem");
    List completedLabs = mg.listLabordersByStatus("Completed");
    List debtors = mg.listOutstanding();
    //List second = mgr.listLabordersByStatus("Incomplete");
    List incompleteLabs = mg.listLabordersByStatus("Incomplete");
    if (completedLabs.size() > 0) {
        incompleteLabs.addAll(completedLabs);
    }

    List patientsFromClinic = mgr1.listTransitLabs();
    List labPatients = mg.listLabPatients();

%>


<ul style="display: none; margin-left: 5px;"  class="menu hide span3">
    <%String perm = (String) session.getAttribute("unit");
        int role = (Integer) session.getAttribute("role");
        String[] perms = perm.split("_");
        if (role == 9) {
    %>
    <li class="item1">
        <a  href="#"><i class="icon-folder-close"></i> Reception / Cashier</a>
        <ul>

            <li class="subitem1"> 
                <a href="labreception.jsp"> Front Desk </a>
            </li>
            <li class="subitem2">
                <a href="quicklistlabpatients.jsp">Find Lab Patient <span><%=labPatients.size()%></span> </a>
            </li>  
            <%if (permissions.contains(6)) {%>
            <li class="subitem3">
                <a href="fromclinic.jsp">Clinic Requests <span><%=patientsFromClinic.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(23)) {%>
            <li class="subitem3">
                <a href="laboutstandingbills.jsp">Outstanding Bills <span><%=debtors.size()%></span></a>
            </li>
            <%}%>
            <li class="subitem2">
                <a href="findlabpatient.jsp">Update Patient Details  </a>
            </li> 

            <li class="subitem2">
                <a href="labpatienthistory.jsp">  Archived Receipts </a>
            </li> 
            <% if (permissions.contains(85)) {%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Lab Reports Status</a>
            </li>
            <%}%>

        </ul>

    </li>
    <li class="item1">
        <a  href="#"><i class="icon-folder-open"></i> Laboratory Activities </a>
        <ul>
            <!--<li class="subitem1">
                <a href="records.jsp">Front Desk </a>
            </li>-->
            <%if (permissions.contains(26)) {%>
            <li class="subitem2">
                <a href="phlembotomy.jsp">Sample Collection <span><%=phlem.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(8) || permissions.contains(27)) {%>
            <li class="subitem2">
                <a href="laboratory_n.jsp">Results Entry <span><%=labsnotdone.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(28)) {%>
            <li class="subitem2">
                <a href="pendingresults.jsp">Outstanding Lab Tests <span><%=notcompletedLabs.size()%></span></a>
            </li>
            <%}%>
        </ul>

    </li>
    <li class="item1">
        <a  href="#"><i class="icon-hdd "></i> Completed Tests</a>
        <ul>
            <% if (permissions.contains(24)) {%>
            <li class="subitem3">
                <a href="readyfordispatch.jsp">New Laboratory Results <span><%=newLabs.size()%></span></a>
            </li>
            <%}%>
            <% if (permissions.contains(25)) {%>
            <li class="subitem3">
                <!-- <a href="dispatched.jsp">Laboratory Archive <span>%=returnedLabs.size()%></span></a>  -->
                <a href="completedlabsearch.jsp">Results Archive</a>
            </li>
            <%}%>


        </ul>
    </li>
    <li class="item4">
        <a href="#"><i class="icon-picture"></i> Sales Reports  </a>
        <ul>
            <% if (permissions.contains(75)) {%>
            <li class="subitem1">
                <a href="insurancesummarybystaff.jsp">Sales by Staff</a>
            </li>
            <!-- <li class="subitem2">
                 <a href="labsalesbystaff.jsp">Staff Sales Report</a>
             </li>  -->
            <%}%>
            <% if (permissions.contains(76)) {%>
            <li class="subitem2">
                <a href="labpatienthistory.jsp">Patient Visits</a>
            </li>
            <%}%>
            <% if (permissions.contains(80)) {%>
            <li class="subitem2">
                <a href="laboutstandingpaymentsmade.jsp">Outstanding Payments</a>
            </li>
            <%}%>
            <% if (permissions.contains(81)) {%>
            <li class="subitem2">
                <a href="laboutstandingpayments.jsp">Current Outstanding Bills</a>
            </li>
            <%}%>
            <% if (permissions.contains(82)) {%>
            <li class="subitem2">
                <a href="labsponsorshipreports.jsp">Sponsorship Breakdown</a>
            </li>
            <%}%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Lab Reports Status</a>
            </li>
        </ul>
    </li>


    <li class="item4">
        <a href="#"><i class="icon-cog"></i> Utility Reports  </a>
        <ul>

            <% if (permissions.contains(77)) {%>
            <li class="subitem2">
                <a href="labtestloadreports.jsp">Test Load Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(78)) {%>
            <li class="subitem2">
                <a href="labtestbooking.jsp">Test Booking Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(85)) {%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Report Tracking</a>
            </li>
            <%}%>
            <% if (permissions.contains(83)) {%>
            <li class="subitem2">
                <a href="labfacilityreferrals.jsp">Facility Referrals Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(84)) {%>
            <li class="subitem2">
                <a href="labdoctorreferrals.jsp">Doctors Referrals Report</a>
            </li>
            <%}%>

            <% if (permissions.contains(74)) {%>
            <li class="subitem2">
                <a href="labpricelist.jsp">Laboratory Price List</a>
            </li>
            <%}%>


        </ul>
    </li>



    <%}
        if (role == 6) {%>
    <li class="item1">
        <a  href="#"><i class="icon-folder-close"></i> Reception / Cashier</a>
        <ul>
            <li class="subitem1">
                <a href="labreception.jsp"> Front Desk </a>
            </li>
            <li class="subitem2">
                <a href="quicklistlabpatients.jsp">Find Lab Patient <span><%=labPatients.size()%></span> </a>
            </li>  
            <%if (permissions.contains(6)) {%>
            <li class="subitem3">
                <a href="fromclinic.jsp">Clinic Requests <span><%=patientsFromClinic.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(23)) {%>
            <li class="subitem3">
                <a href="laboutstandingbills.jsp">Outstanding Bills <span><%=debtors.size()%></span></a>
            </li>
            <%}%>
        </ul>

    </li>

    <li class="item1">
        <a  href="#"><i class="icon-folder-open"></i> Laboratory Activities </a>
        <ul>

            <%if (permissions.contains(26)) {%>
            <li class="subitem2">
                <a href="phlembotomy.jsp">Sample Collection <span><%=phlem.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(8) || permissions.contains(27)) {%>
            <li class="subitem2">
                <a href="laboratory_n.jsp">Results Entry <span><%=labsnotdone.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(9) || permissions.contains(29)) {%>
            <li class="subitem1">
                <a href="labvetted.jsp">Results Scrutiny<span><%=incompleteLabs.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(28)) {%>
            <li class="subitem2">
                <a href="pendingresults.jsp">Outstanding Lab Tests <span><%=notcompletedLabs.size()%></span></a>
            </li>
            <%}%>
        </ul>

    </li>
    <li class="item1">
        <a  href="#"><i class="icon-arrow-down"></i> Completed Tests</a>
        <ul>
            <% if (permissions.contains(24)) {%>
            <li class="subitem3">
                <a href="readyfordispatch.jsp">New Laboratory Results <span><%=newLabs.size()%></span></a>
            </li>
            <%}%>
            <% if (permissions.contains(25)) {%>
            <li class="subitem3">
                <!-- <a href="dispatched.jsp">Laboratory Archive <span>%=returnedLabs.size()%></span></a>  -->
                <a href="completedlabsearch.jsp">Results Archive</a>
            </li>
            <%}%>
        </ul>
    </li>
    <li class="item4">
        <a href="#"><i class="icon-picture"></i> Sales Reports  </a>
        <ul>
            <% if (permissions.contains(75)) {%>
            <li class="subitem1">
                <a href="insurancesummarybystaff.jsp">Sales by Staff</a>
            </li>
            <!-- <li class="subitem2">
                 <a href="labsalesbystaff.jsp">Staff Sales Report</a>
             </li>  -->
            <%}%>
            <% if (permissions.contains(76)) {%>
            <li class="subitem2">
                <a href="labpatienthistory.jsp">Patient Visits</a>
            </li>
            <%}%>
            <% if (permissions.contains(80)) {%>
            <li class="subitem2">
                <a href="laboutstandingpaymentsmade.jsp">Outstanding Payments</a>
            </li>
            <%}%>
            <% if (permissions.contains(81)) {%>
            <li class="subitem2">
                <a href="laboutstandingpayments.jsp">Current Outstanding Bills</a>
            </li>
            <%}%>
            <% if (permissions.contains(82)) {%>
            <li class="subitem2">
                <a href="labsponsorshipreports.jsp">Sponsorship Breakdown</a>
            </li>
            <%}%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Lab Reports Status</a>
            </li>
        </ul>
    </li>


    <li class="item4">
        <a href="#"><i class="icon-cog"></i> Utility Reports  </a>
        <ul>

            <% if (permissions.contains(77)) {%>
            <li class="subitem2">
                <a href="labtestloadreports.jsp">Test Load Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(78)) {%>
            <li class="subitem2">
                <a href="labtestbooking.jsp">Test Booking Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(85)) {%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Report Tracking</a>
            </li>
            <%}%>
            <% if (permissions.contains(83)) {%>
            <li class="subitem2">
                <a href="labfacilityreferrals.jsp">Facility Referrals Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(84)) {%>
            <li class="subitem2">
                <a href="labdoctorreferrals.jsp">Doctors Referrals Report</a>
            </li>
            <%}%>

            <% if (permissions.contains(74)) {%>
            <li class="subitem2">
                <a href="labpricelist.jsp">Laboratory Price List</a>
            </li>
            <%}%>


        </ul>
    </li>
    <%}
        if (role == 13) {
    %>
    <li class="item1">
        <a  href="#"><i class="icon-folder-close"></i> Reception / Cashier</a>
        <ul>
            <li class="subitem1">
                <a href="labreception.jsp"> Front Desk </a>
            </li>
            <li class="subitem2">
                <a href="quicklistlabpatients.jsp">Find Lab Patient <span><%=labPatients.size()%></span> </a>
            </li>  
            <%if (permissions.contains(6)) {%>
            <li class="subitem3">
                <a href="fromclinic.jsp">Clinic Requests <span><%=patientsFromClinic.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(23)) {%>
            <li class="subitem3">
                <a href="laboutstandingbills.jsp">Outstanding Bills <span><%=debtors.size()%></span></a>
            </li>
            <%}%>
            <li class="subitem2">
                <a href="findlabpatient.jsp">Update Patient Details  </a>
            </li> 
        </ul>
    </li>
    <li class="item3">
        <a href="#"><i class="icon-check"></i> Main Lab Activities  </a>
        <ul>
            <%if (permissions.contains(26)) {%>
            <li class="subitem2">
                <a href="phlembotomy.jsp">Sample Collection <span><%=phlem.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(8) || permissions.contains(27)) {%>
            <li class="subitem2">
                <a href="laboratory_n.jsp">Results Entry <span><%=labsnotdone.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(9) || permissions.contains(29)) {%>
            <li class="subitem1">
                <a href="labvetted.jsp">Results Scrutiny<span><%=incompleteLabs.size()%></span></a>
            </li>
            <%}%>
            <%if (permissions.contains(28)) {%>
            <li class="subitem2">
                <a href="pendingresults.jsp">Outstanding Lab Tests <span><%=notcompletedLabs.size()%></span></a>
            </li>
            <%}%>

        </ul>
    </li>
    <li class="item1">
        <a  href="#"><i class="icon-arrow-down"></i> Completed Tests</a>
        <ul>
            <% if (permissions.contains(24)) {%>
            <li class="subitem3">
                <a href="readyfordispatch.jsp">New Laboratory Results <span><%=newLabs.size()%></span></a>
            </li>
            <%}%>
            <% if (permissions.contains(25)) {%>
            <li class="subitem3">
                <!-- <a href="dispatched.jsp">Laboratory Archive <span>%=returnedLabs.size()%></span></a>  -->
                <a href="completedlabsearch.jsp">Results Archive</a>
            </li>
            <%}%>
        </ul>
    </li>

    <li class="item4">
        <a href="#"><i class="icon-picture"></i> Sales Reports  </a>
        <ul>
            <% if (permissions.contains(75)) {%>
            <li class="subitem1">
                <a href="insurancesummarybystaff.jsp">Sales by Staff</a>
            </li>
            <!-- <li class="subitem2">
                 <a href="labsalesbystaff.jsp">Staff Sales Report</a>
             </li>  -->
            <%}%>
            <% if (permissions.contains(76)) {%>
            <li class="subitem2">
                <a href="labpatienthistory.jsp">Patient Visits</a>
            </li>
            <%}%>
            <% if (permissions.contains(80)) {%>
            <li class="subitem2">
                <a href="laboutstandingpaymentsmade.jsp">Outstanding Payments</a>
            </li>
            <%}%>
            <% if (permissions.contains(81)) {%>
            <li class="subitem2">
                <a href="laboutstandingpayments.jsp">Current Outstanding Bills</a>
            </li>
            <%}%>
            <% if (permissions.contains(82)) {%>
            <li class="subitem2">
                <a href="labsponsorshipreports.jsp">Sponsorship Breakdown</a>
            </li>
            <%}%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Lab Reports Status</a>
            </li>
        </ul>
    </li>


    <li class="item4">
        <a href="#"><i class="icon-cog"></i> Utility Reports  </a>
        <ul>

            <% if (permissions.contains(77)) {%>
            <li class="subitem2">
                <a href="labtestloadreports.jsp">Test Load Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(78)) {%>
            <li class="subitem2">
                <a href="labtestbooking.jsp">Test Booking Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(85)) {%>
            <li class="subitem2">
                <a href="labreporttracking.jsp">Report Tracking</a>
            </li>
            <%}%>
            <% if (permissions.contains(83)) {%>
            <li class="subitem2">
                <a href="labfacilityreferrals.jsp">Facility Referrals Report</a>
            </li>
            <%}%>
            <% if (permissions.contains(84)) {%>
            <li class="subitem2">
                <a href="labdoctorreferrals.jsp">Doctors Referrals Report</a>
            </li>
            <%}%>

            <% if (permissions.contains(74)) {%>
            <li class="subitem2">
                <a href="labpricelist.jsp">Laboratory Price List</a>
            </li>
            <%}%>


        </ul>
    </li>

    <li class="item4">
        <a href="#"><i class="icon-picture"></i> Laboratory Inventory  </a>
        <ul>
            <!--li class="subitem2">
                <a href="labdashboard.jsp">Lab Reports Dashboard</a>
            </li-->
            <% if (permissions.contains(33) || permissions.contains(61) || permissions.contains(62)) {%>
            <li class="subitem2">
                <a href="addlabitem.jsp">New Diagnostic Item</a>
            </li>
            <%}%>
            <% if (permissions.contains(33) || permissions.contains(65) || permissions.contains(74)) {%>
            <li class="subitem2">
                <a href="addlabitems.jsp">Receive Item</a>
            </li>
            <%}%>
            <% if (permissions.contains(33) || permissions.contains(71) || permissions.contains(74)) {%>
            <li class="subitem2">
                <a href="inuse.jsp">Items In Use</a>
            </li>
            <%}%>

        </ul>
    </li>
    <li class="item3">
        <a href="#"><i class="icon-hdd"></i> Laboratory Health Data </a>
        <ul>
            <% if (permissions.contains(33) || permissions.contains(37) || permissions.contains(38)) {%>
            <li class="subitem4">
                <a href="addlabtype.jsp">Lab Classifications</a>
            </li>
            <%}%>
            <% if (permissions.contains(42) || permissions.contains(41) || permissions.contains(33)) {%>
            <li class="subitem4">
                <a href="reordermaininv.jsp">Main Investigations</a>
            </li> 
            <%}%>
            <% if (permissions.contains(45)) {%>
            <li class="subitem4">
                <a href="addsubinv.jsp">New Sub Investigations</a>
            </li> 
            <%}%>
            <% if (permissions.contains(46)) {%>
            <li class="subitem4">
                <a href="reordersubinv.jsp">View Sub Investigations</a>
            </li> 
            <%}%>
            <% if (permissions.contains(33) || permissions.contains(49) || permissions.contains(50)) {%>
            <li class="subitem4">
                <a href="profile.jsp">Laboratory Profiles </a>
            </li>  
            <%}%>
            <% if (permissions.contains(33) || permissions.contains(53) || permissions.contains(54)) {%>
            <li class="subitem4">
                <a href="addlabantibiotic.jsp">Antibiotics Management</a>
            </li> 
            <%}%>
            <% if (permissions.contains(33) || permissions.contains(57) || permissions.contains(59)) {%>
            <li class="subitem4">
                <a href="addspecimen.jsp">Specimen Management</a>
            </li>
            <%}%>

        </ul>
    </li>

    <li class="item3">
        <a href="#"><i class="icon-cog"></i> Laboratory Configurations </a>
        <ul>
            <% if (permissions.contains(30)) {%>
            <li class="subitem4">

                <a href="lab_setup.jsp">Lab Code Setup</a>
            </li>
            <li class="subitem4">

                <a href="labprintsettings.jsp">Report Print Setting</a>
            </li>
            <%}%>
            <% if (permissions.contains(31)) {%>
            <li class="subitem4">
                <a href="labpricesetup.jsp">Laboratory Price Setup</a>
            </li>
            <%}%>
            <% if (permissions.contains(33)) {%>
            <li class="subitem4">
                <a href="addDoctor.jsp">Referring Doctors</a>
            </li> 
            <%}%>
            <% if (permissions.contains(33)) {%>
            <li class="subitem4">
                <a href="addFacility.jsp">Referring Facilities</a>
            </li>
            <%}%>
        </ul>
    </li>


    <li class="item4">
        <a href="#"><i class="icon-user"> </i> Admin Panel</a>
        <ul>

            <li class="subitem1">
                <a href="labadminpanel.jsp">Admin Home</a>
            </li>



            
        </ul>
    </li>
    
    <% }

            %>

</ul>
