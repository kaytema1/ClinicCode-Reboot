<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="entities.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.HMSHelper"%>
<%@page import="java.text.DateFormat"%>
<meta charset="utf-8">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  ExtendedHMSHelper mg = new ExtendedHMSHelper();
    DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");

    Date dt = new Date();
    //System.out.println(dateFormat.format(date));
    List allpatients = mg.listPatients();
    List medbillpatients = mg.listUnitVisitations("account");
    List dispensingpatients = mg.listPharmordersByStatus("Approved");
    List procedurepatients = mg.listPatientProcedures("Cashier");
    List newprocedures = mg.listPatientProcedures("Not Done");
    List outstandingbills = mg.listDebtors();
    List opdpatients = mg.listUnitVisitations("vitals");
    List walkingprocedures = mg.listWalkinProcedures("Cashier");
    List newwalkingprocedures = mg.listWalkinProcedures("Not Done");
    List bedassignments = mg.listUnitVisitations("ward");
    List secondaryconsulting = mg.listSecondaryConsultation("consultation");
    List labresults = mg.listLabordersByStatus("Completed");
    List vjs = mg.listRecentVisits(dateformat.format(dt), "In Patient");
    List outs = mg.listRecentVisits(dateformat.format(dt), "Out Patient");
    List labs = mg.listUnitVisitations("Laboratory", dateformat.format(dt));
    List pharmacy = mg.listPharmordersByStatus("Pharmacy");;
    List dispensaryOrders = mg.listPatientTreatmentsByStatus("No");
    List dis = mg.listPharmordersByStatus("Settled");
    List accs = mg.listPharmordersByStatus("Account");
    List vis = mg.listPharmordersByStatus("Records");
    List reg = mg.listRecentVisits(dateformat.format(dt));
    List rms = mg.listUnitVisitations("Room 1", dateformat.format(dt));
    List newInpatients = mg.listVisitationsAtUnit("deposits");
    List scheduledAppiontments = mg.listScheduledAppointments(0);
    List visitsConsult = mg.listUnitVisitations("consultation");
    List newpharmOrders = mg.listPharmordersByStatus("Not Done");
    List patientBedsList = mg.listPatientBed();;
     List visitsToday = mg.listRecentVisits(dateformat.format(dt));

%>


<ul style="display: none;" class="menu span3">
    <%
        String perm = (String) session.getAttribute("unit");
        int role = (Integer) session.getAttribute("role");
        String[] perms = perm.split("_");
        if (role == 1 || role == 4) {
    %>
    <%}
        if (role == 8 || role == 1 || role == 4) {
    %>
    <li class="item1">
        <a  href="#"><i class="icon-folder-close"></i> Records</a>
        <ul>
            <li class="subitem1">
                <a href="records.jsp">Front Desk </a>
            </li>

            <li class="subitem3">
                <a href="listpatients.jsp">Find Patients <span><%=allpatients.size()%></span></a>
            </li>
            <li class="subitem3">
                <a href="findclinicpatient.jsp">Update Patient Details</a>
            </li>
            
        </ul>

    </li>
     <li class="item1">
        <a  href="#"><i class="icon-tasks"></i> In-Patients </a>
        <ul>
            <li class="subitem1">
                <a href="bedassignment.jsp">Bed Assignment <span> <%=bedassignments.size()%> </span></a>
            </li>
            <li class="subitem1">
                <a href="nursesinpatients.jsp"> All In Patients <span> <%=patientBedsList.size()%> </span></a>
            </li>
        </ul>

    </li>
    <li class="item1">
        <a  href="#"><i class="icon-tasks"></i> Procedures</a>
        <ul>
            <li class="subitem2">
                <a href="walk-inprocedures.jsp">Walk-In Procedures </a>
            </li>
        </ul>

    </li>
    
   

    <li class="item1">
        <a  href="#"><i class="icon-calendar"></i> Appointments</a>
        <ul>
            <li class="subitem3">
                <a href="addappointment.jsp">New Appointment </a>
            </li>
            <li class="subitem3">
                <a href="viewscheduled.jsp">Booked Appointments  </a>
            </li>
            <li class="subitem3">
                <a href="appointment.jsp">Appointment Calendar </a>
            </li>
        </ul>
        <%}%>


        <%  if (role == 2 || role == 1 || role == 4) {%>
    <li class="item4">
        <a href="#"><i class="icon-shopping-cart"></i> Billing</a>
        <ul>
            <li class="subitem1">
                <a href="billing.jsp"> Billing</a>
            </li>
            <li class="subitem1">
                <a href="registrationnconsultationbills.jsp"> Registration & Consultation Bills <span><%=medbillpatients.size()%></span></a>
            </li>
            <li>
                <a href="outstandinclinicbills.jsp"> Outstanding Bills <span><%=dispensingpatients.size() + procedurepatients.size()%></span></a>
            </li>
            
            <li>
                <a href="walk-inprocedurepaymentlist.jsp">Walk-in Procedure Bills <span><%= walkingprocedures.size()%></span></a>

            </li>
            
            <li>
                <a href="inpatientdepositshub.jsp">Deposit Payment</a>

            </li>
            <li class="subitem1">
                <a href="account_search.jsp">Patient Bill Summaries </a><span></span>
            </li>
            <!-- <li class="subitem1">
                 <a href="dispensary.jsp">Dispensing Bills<span><%=dispensingpatients.size()%></span></a>
             </li>
             <li class="subitem1">
                 <a href="procedurepricing.jsp">Procedure Bills<span><%=procedurepatients.size()%></span></a>
             </li>
 
             <li class="subitem1">
                 <a href="outstandingbills.jsp">Outstanding Bills<span><%=outstandingbills.size()%></span></a>
             </li>
 
             <li class="subitem1">
                 <a href="account_search.jsp">Patient Bill Summaries </a><span></span>
             </li>  -->


        </ul>
    </li>
    <%}%>
    <%  if (role == 7 || role == 1 || role == 4) {%>
    <li class="item1">
        <a  href="#"><i class="icon-folder-open"></i> Nurses Station</a>
        <ul>
            <li class="subitem2">
                <a href="opd.jsp">Nurses Enquiry  <span><%= opdpatients.size()%></span></a>
            </li>
            </ul>

    </li>
    



    <li class="item1">
        <a  href="#"><i class="icon-tasks"></i> Procedures</a>
        <ul>

            <li class="subitem2">
                <a href="readyprocedureslist.jsp">Procedures to Perform <span><%= newprocedures.size() + newwalkingprocedures.size()%></span> </a>
            </li>
            <li class="subitem2">
                <a href="walk-inprocedures.jsp">Walk-In Procedures </a>
            </li>
        </ul>

    </li>
    
    <li class="item2">
        <a href="#"> <i class=" icon-th"></i> Wards
        </a> 
        <ul>
            <li class="subitem1">
                <a href="bedassignment.jsp">Bed Assignment <span> <%=bedassignments.size()%> </span></a>
            </li>
            <li class="subitem1">
                <a href="nursesinpatients.jsp"> All In Patients <span> <%=patientBedsList.size()%> </span></a>
            </li>

            <%List wards = mg.listWard();
                for (int h = 0; h < wards.size(); h++) {
                    Ward ward = (Ward) wards.get(h);

            %>
            <li class="subitem1">
                <a href="nurseswardlist.jsp?type=<%=ward.getType()%>_<%=ward.getWardid()%>"><%=ward.getWardname()%></a>
            </li>
            <%}%>
        </ul>
    </li> 
    <%}
        if (role == 3 || role == 1 || role == 4) {
    %>
    <li class="item2">
        <a href="#"> <i class=" icon-eye-open"></i> Consultation
        </a> 
        <ul>
            <li class="subitem1">
                <a href="consultingroom.jsp">Consulting Patients <span><%=visitsConsult.size()%></span></a>
            </li>
            <li class="subitem2">
                <a href="reviewpatients.jsp">Review Patients  <span> <%=visitsToday.size()%> </span> </a>
            </li>

            <li class="subitem5">
                <a href="labresultsearch.jsp">Laboratory Results Search</a>
            </li> 
            <li class="subitem5">
                <a href="listpatientsforfolder.jsp">Find Patients Folder <span><%=allpatients.size()%></span> </a>
            </li> 
            <li class="subitem2">
                <a href="readyprocedureslist.jsp">Procedures to Perform <span><%= newprocedures.size() + newwalkingprocedures.size()%></span> </a>
            </li>

        </ul>
    </li>

    <%}%>


    <%
        if (role == 3 || role == 1 || role == 4) {%>
    <li class="item2">
        <a href="#"> <i class=" icon-th"></i> Wards
        </a> 
        <ul>
            <li class="subitem1">
                <a href="bedassignment.jsp">Bed Assignment <span> <%=bedassignments.size()%> </span></a>
            </li>
            <li class="subitem1">
                <a href="inpatients.jsp"> In Patients <span> <%=bedassignments.size()%> </span></a>
            </li>

            <%List wards = mg.listWard();
                for (int h = 0; h < wards.size(); h++) {
                    Ward ward = (Ward) wards.get(h);

            %>
            <li class="subitem1">
                <a href="wardlist.jsp?type=<%=ward.getType()%>_<%=ward.getWardid()%>"><%=ward.getWardname()%></a>
            </li>
            <%}%>
        </ul>
    </li> 


    <li class="item2">
        <a href="#"> <i class=" icon-list-alt"></i> Medical Utility Reports
        </a> 
        <ul>
            <li class="subitem1">
                <a href="consultingroom.jsp">Diagnoses Report</a>
            </li>
            <li class="subitem2">
                <a href="readyprocedures.jsp">Prescription Report </a>
            </li>
            


        </ul>
    </li>
    <%}
        if (role == 5 || role == 1 || role == 4) {%>
    <li class="item4">
        <a href="#"><i class="icon-adjust"></i> Dispensing </a>
        <ul>
            <li class="subitem1">
                <a href="prescriptionorders.jsp">Prescription Orders <span><%=newpharmOrders.size()%></span></a>
            </li>
            <li class="subitem1">
                <a href="readytodispense.jsp">Dispensing <span><%=dis.size()%></span></a>
            </li>
            <li class="subitem1">
                <a href="dispensinghistory.jsp">Dispensing Order History </a>
            </li>

        </ul>
    </li>


    <li class="item4">
        <a href="#"><i class="icon-list"></i> Dispensary Stock</a>
        <ul>
            <li class="subitem1">
                <a href="dispensarymakerequest.jsp">Make Stock Request </a>
            </li>
            <li class="subitem3">
                <a href="delivered.jsp">Stock Deliveries</a>
            </li>
            <li class="subitem3">
                <a href="addmedicine.jsp">New Medicine</a>
            </li>
        </ul>
    </li>
    <%}%>

    <%   if (role == 10 || role == 1 || role == 4) {%>
    <li class="item4">
        <a href="#"><i class="icon-list-alt"></i> Inventory</a>
        <ul><li class="subitem1">
                <a href="additemtostock.jsp">Add Items to Stock</a>
            </li>
            <li class="subitem1">
                <a href="allrequests.jsp">Requisitions</a>
            </li>
            <li class="subitem1">
                <a href="transfers.jsp">Transfers</a>
            </li>
            <li class="subitem1">
                <a href="purchaseorder.jsp">Purchase Order</a>
            </li>
            <li class="subitem1">
                <a href="managerpurchaseorder.jsp">Approve Stock Manager Approval</a>
            </li>
            <li class="subitem1">
                <a href="accountspurchaseorder.jsp">Pending Accounts Approval</a>
            </li>

            <li class="subitem1">
                <a href="approvedorders.jsp">Approved Orders</a>
            </li>
            <li class="subitem1">
                <a href="submittedorders.jsp">Submitted Orders</a>
            </li>
            <li class="subitem1">
                <a href="goodsreceived.jsp">Receiving Goods</a>
            </li>
            <li class="subitem1">
                <a href="invoice.jsp">Invoices</a>
            </li>
            <!--li class="subitem2">
                <a href="addType.jsp">Add Item Type</a>
            </li-->

            <!--li class="subitem4">
                <a href="check.jsp">Check Expiry</a>
            </li-->
            <li class="subitem4">
                <a href="addSupplier.jsp">Add Supplier</a>
            </li>
            <li class="subitem4">
                <a href="addmanufacturer.jsp">Add Manufacture</a>
            </li>
        </ul>
    </li>
    <%}
        if (role == 1 || role == 4) {%>
    <li class="item4">
        <a href="#"><i class="icon-picture"></i> Reports </a>
        <ul>
            <li class="subitem3">
                <a href="printedcards.jsp">ID Cards Tracking</a>
            </li>
            <li class="subitem3">
                <a href="anballdepartments.jsp">Departmental Bill Summary</a>
            </li>
            <li class="subitem3">
                <a href="anballpatientsrevenues.jsp">Patients Bill Report</a>
            </li>
            <li class="subitem3">
                <a href="anballsponsorsrevenues.jsp">Sponsors Bill Report</a>
            </li>
            <li class="subitem2">
                <a href="emrdashboard.jsp">At-A-Glance Dashboard</a>
            </li>
            <li class="subitem3">
                <a href="patientutilization.jsp">Patient Utilization</a>
            </li>
            <li class="subitem4">
                <a href="patientmedicalanalysis.jsp">Patient Medical Analysis</a>
            </li>
            <li class="subitem4">
                <a href="patientbilling.jsp">Patient Billing</a>
            </li>

        </ul>
    </li>


    <li class="item4">
        <a href="#"><i class="icon-cog"> </i> Admin Panel</a>
        <ul>

            <li class="subitem1">
                <a href="adminpanel.jsp">Admin Home</a>
            </li>


        </ul>
    </li>
    <%}%>

</ul>

