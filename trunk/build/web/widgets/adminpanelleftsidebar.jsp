<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="entities.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.HMSHelper"%>
<%@page import="java.text.DateFormat"%>
<%  ExtendedHMSHelper mg = new ExtendedHMSHelper();
    DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");

    Date dt = new Date();
    //System.out.println(dateFormat.format(date));
    List vjs = mg.listRecentVisits(dateformat.format(dt), "In Patient");
    List outs = mg.listRecentVisits(dateformat.format(dt), "Out Patient");
    List labs = mg.listUnitVisitations("Laboratory", dateformat.format(dt));
    List pharmacy = mg.listPharmordersByStatus("Pharmacy");;
    List dis = mg.listPharmordersByStatus("Settled");
    List accs = mg.listPharmordersByStatus("Account");
    List rms = mg.listUnitVisitations("Room 1", dateformat.format(dt));
%>

<div style="height: 100%; position: fixed;" class="span3">
    <ul style="display: none;"  class="menu hide">
        <%
            String perm = (String) session.getAttribute("unit");
            int role = (Integer) session.getAttribute("role");
            String[] perms = perm.split("_");

            if (role == 1 || role == 4) {%>
        <li class="item4">
            <a href="#"><i class="icon-star-empty"></i> Facility Configurations </a>
            <ul>
                <li class="subitem4">
                    <a href="facility_setup.jsp">Facility Setup</a>
                </li>
                <li class="subitem4">
                    <a href="addunit.jsp">Unit Management</a>
                </li>
                <li class="subitem4">
                    <a href="adddepartment.jsp">Department Management</a>
                </li>
                <li class="subitem4">
                    <a href="addward.jsp">Ward Management</a>
                </li>
                <li class="subitem4">
                    <a href="addroom.jsp">Room Management</a>
                </li>
                <li class="subitem4">
                    <a href="addbed.jsp">Bed Management</a>
                </li>
                <li class="subitem4">
                    <a href="addconsultingroom.jsp">Consulting Rooms</a>
                </li>
                <li class="subitem4">
                    <a href="addconcharges.jsp">Consultation Fees</a>
                </li>
                <li class="subitem2">
                    <a href="addregfee.jsp">Registration Fees</a>
                </li>

                
            </ul>
        </li>
        <li class="item4">
            <a href="#"><i class="icon-list"></i> Stock & Inventory </a>
            <ul>
                
                <li class="subitem4">
                    <a href="additemtostock.jsp">Inventory Management</a>
                </li>
                <li class="subitem4">
                    <a href="addSupplier.jsp">Supplier Management</a>
                </li>
                <li class="subitem4">
                    <a href="addmanufacturer.jsp">Manufacturer Management</a>
                </li>
                
            </ul>
        </li>
        <li class="item4">
            <a href="#"><i class="icon-file"></i> Health Data Administration </a>
            <ul>
                <li class="subitem4">
                    <a href="addsymptom.jsp">Symptoms Management.</a>
                </li>
                <li class="subitem4">
                    <a href="addallergy.jsp">Allergies Management</a>
                </li>
                <li class="subitem4">
                    <a href="addclerking.jsp">Exam Questions</a>
                </li>
                <li class="subitem4">
                    <a href="adddosage.jsp">Dosage Settings</a>
                </li>
                <li class="subitem4">
                    <a href="addprocedure.jsp">Procedure Management</a>
                </li>
                <li class="subitem4">
                    <a href="adddiagnosis.jsp">NHIS Diagnosis</a>
                </li>
            </ul>

        </li>
        <li class="item4">
            <a href="#"><i class="icon-user"></i> User & Patient  </a>
            <ul>
                <li class="subitem1">
                    <a href="addappointmenttype.jsp">Appointments Management</a>
                </li>
                <li class="subitem4">
                    <a href="listpatients.jsp">Patient Management</a>
                </li>
                <li class="subitem4">
                    <a href="addsponsor.jsp">Sponsorship Management</a>
                </li>
                <li class="subitem2">
                    <a href="addstaff.jsp">Staff Management</a>
                </li>
                <li class="subitem3">
                    <a href="addpermission.jsp">Permissions Management</a>
                </li>
                <li class="subitem4">
                    <a href="addrole.jsp">Roles Management</a>
                </li>


            </ul>
        </li>
        


        <li class="item4">
            <a href="#"><i class="icon-picture"></i> Reports </a>
            <ul>    
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
            <a href="#"><i class="icon-cog"> </i> Clinic Panel</a>
            <ul>

                <li class="subitem1">
                    <a href="clinicreception.jsp">Home</a>
                </li>

                <%}%>
            </ul>
        </li>

    </ul>
</div>