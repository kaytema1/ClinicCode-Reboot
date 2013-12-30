<%-- 
    Document   : patientcount
    Created on : Dec 5, 2012, 8:58:05 AM
    Author     : drac852002
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entities.*"%>
<%@page import="java.util.List"%>
<%@page import="entities.ExtendedHMSHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ExtendedHMSHelper mgr = new ExtendedHMSHelper();

    if ("family".equalsIgnoreCase(request.getParameter("action"))) {
        String string = request.getParameter("id");

        List list = mgr.listPatients();
        //out.print(list.size());
        int count = 1;
        for (int i = 0; i < list.size(); i++) {
            Patient patient = (Patient) list.get(i);
            if (patient.getPatientid().contains(string)) {
                count = count + 1;
            }
        }
        out.print(string + "" + count);
        return;
    }
    if ("credit".equalsIgnoreCase(request.getParameter("action"))) {
        String string = request.getParameter("id");
        //ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        List list = mgr.listPatients();
        //out.print(list.size());
        int count = 1;
        for (int i = 0; i < list.size(); i++) {
            Patient patient = (Patient) list.get(i);
            if (patient.getPatientid().contains(string)) {
                count = count + 1;
            }
        }
        out.print(string + "" + count);
        return;
    }
    if ("insurance".equalsIgnoreCase(request.getParameter("action"))) {
        String string = request.getParameter("id");
        // ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        List list = mgr.listPatients();
        //out.print(list.size());
        int count = 1;
        for (int i = 0; i < list.size(); i++) {
            Patient patient = (Patient) list.get(i);
            if (patient.getPatientid().contains(string)) {
                count = count + 1;
            }
        }
        out.print(string + "" + count);
        return;
    }
    if ("coperate".equalsIgnoreCase(request.getParameter("action"))) {
        String string = request.getParameter("id");
        // ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        List list = mgr.listPatients();
        //out.print(list.size());
        int count = 1;
        for (int i = 0; i < list.size(); i++) {
            Patient patient = (Patient) list.get(i);
            if (patient.getPatientid().contains(string)) {
                count = count + 1;
            }
        }
        out.print(string + "" + count);
        return;
    }
    if ("coperateid".equalsIgnoreCase(request.getParameter("action"))) {
        /* String string = request.getParameter("abbreviation");
         ExtendedHMSHelper mgr = new ExtendedHMSHelper();
         List list = mgr.listPatients();
         Sponsorship sponsorship = mgr.getSponsor(string);
         // String abbreviation = sponsorship.getAbbreviations();
         String strings = "";
         // ArrayList<String> array = null;
         //out.print(list.size());
         int count = 1;
         for (int i = 0; i < list.size(); i++) {
         Patient patient = (Patient) list.get(i);
         if (patient.getPatientid().contains(abbreviation)) {
         //array.add(patient.getPatientid());
         strings= strings+"-"+patient.getPatientid();
         }
         }
         out.print(strings);
         return;*/
    }
    if ("password".equalsIgnoreCase(request.getParameter("action"))) {
        if (Password.check(request.getParameter("password"), request.getParameter("check"))) {
            out.print(true);
        } else {
            out.print(false);
        }
    }
    if ("patientdiscount".equalsIgnoreCase(request.getParameter("action"))) {

        String username = request.getParameter("username") == "" ? "" : request.getParameter("username");
        String password = request.getParameter("password") == "" ? "" : request.getParameter("password");

        List staffPermission = mgr.listStaffPermissions(username);
        StaffPermission permission = null;
        ArrayList<Integer> permissionIds = new ArrayList<Integer>();
        if (staffPermission.size() > 0 || staffPermission != null) {
            for (int i = 0; i < staffPermission.size(); i++) {
                permission = (StaffPermission) staffPermission.get(i);
                if (permission != null) {
                    permissionIds.add(permission.getPermissionid());
                }
            }

        }

        Users user = (Users) mgr.getUserById(username);
        if (user != null) {
            if (Password.check(password, user.getPassword())) {
                //if (permissionIds.contains(72) || permissionIds.contains(16)) {
                    out.print(1);
                //} else {
                  //  out.print(0);
                //}
            } else {
                out.print(0);
            }
        } else {
            out.print(0);
        }
    }
    if ("patientauthorization".equalsIgnoreCase(request.getParameter("action"))) {
        String username = request.getParameter("username") == "" ? "" : request.getParameter("username");
        String password = request.getParameter("password") == "" ? "" : request.getParameter("password");
        List staffPermission = mgr.listStaffPermissions(username);
        StaffPermission permission = null;
        ArrayList<Integer> permissionIds = new ArrayList<Integer>();
        if (staffPermission.size() > 0 || staffPermission != null) {
            for (int i = 0; i < staffPermission.size(); i++) {
                permission = (StaffPermission) staffPermission.get(i);
                if (permission != null) {
                    permissionIds.add(permission.getPermissionid());
                }
            }

        }
        Users user = (Users) mgr.getUserById(username);
        if (user != null) {
            if (Password.check(password, user.getPassword())) {
                //if (permissionIds.contains(73)) {
                    out.print(1);
                //} else {
                   // out.print(0);
               // }
            } else {
                out.print(0);
            }
        } else {
            out.print(0);
        }
    }
    if ("savediscount".equalsIgnoreCase(request.getParameter("action"))) {
        double percentage = request.getParameter("percentage") == "" ? 0 : Double.parseDouble(request.getParameter("percentage"));
        double actual = request.getParameter("actual") == "" ? 0.0 : Double.parseDouble(request.getParameter("actual"));
        double newcharge = request.getParameter("newcharge") == "" ? 0.0 : Double.parseDouble(request.getParameter("newcharge"));
        String status = request.getParameter("status") == "" ? "" : request.getParameter("status");
        String staffid = request.getParameter("staff") == "" ? "" : request.getParameter("staff");
        int visitid = request.getParameter("visit") == "" ? 0 : Integer.parseInt(request.getParameter("visit"));
        String reason = request.getParameter("reason") == "" ? "" : request.getParameter("reason");
        PatientDiscount patientDiscount = mgr.addDiscount(visitid, mgr.getVisitById(visitid).getPatientid(), percentage, actual, newcharge, staffid, status, reason);
        if (patientDiscount != null) {
            out.print("successfully discounted");
        } else {
            out.print("sorry there was a problem");
        }
    }
    if ("pharmdiscount".equalsIgnoreCase(request.getParameter("action"))) {
        double percentage = request.getParameter("percentage") == "" ? 0 : Double.parseDouble(request.getParameter("percentage"));
        double actual = request.getParameter("actual") == "" ? 0.0 : Double.parseDouble(request.getParameter("actual"));
        double newcharge = request.getParameter("newcharge") == "" ? 0.0 : Double.parseDouble(request.getParameter("newcharge"));
        String status = request.getParameter("status") == "" ? "" : request.getParameter("status");
        String staffid = request.getParameter("staff") == "" ? "" : request.getParameter("staff");
        String orderid = request.getParameter("visit") == "" ? "" : request.getParameter("visit");
        String reason = request.getParameter("reason") == "" ? "" : request.getParameter("reason");
        PharmacyDiscount patientDiscount = mgr.addPharmDiscount(orderid, mgr.getPharmorder(orderid).getPatientid(), percentage, actual, newcharge, staffid, status, reason);
        if (patientDiscount != null) {
            out.print("successfully discounted");
        } else {
            out.print("sorry there was a problem");
        }
    }
    if ("labdiscount".equalsIgnoreCase(request.getParameter("action"))) {
        double percentage = request.getParameter("percentage") == "" ? 0 : Double.parseDouble(request.getParameter("percentage"));
        double actual = request.getParameter("actual") == "" ? 0.0 : Double.parseDouble(request.getParameter("actual"));
        double newcharge = request.getParameter("newcharge") == "" ? 0.0 : Double.parseDouble(request.getParameter("newcharge"));
        String status = request.getParameter("status") == "" ? "" : request.getParameter("status");
        String staffid = request.getParameter("staff") == "" ? "" : request.getParameter("staff");
        String labid = request.getParameter("visit") == "" ? "" : request.getParameter("visit");
        String patid = request.getParameter("patid") == "" ? "" : request.getParameter("patid");
        String reason = request.getParameter("reason") == "" ? "" : request.getParameter("reason");
        LabDiscount patientDiscount = mgr.addLabDiscount(labid, patid, percentage, actual, newcharge, staffid, status, reason);
        if (patientDiscount != null) {
            out.print("successfully discounted");
        } else {
            out.print("sorry there was a problem");
        }
    }
    if ("treatment".equalsIgnoreCase(request.getParameter("action"))) {
        String string = request.getParameter("id");
        String batch = string.split("><")[1];
        int qty = mgr.getTreatment(batch).getQuantity();
        out.print(qty);

    }
%>