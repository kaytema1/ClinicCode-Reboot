<%-- 
   Document   : sponsoraction
   Created on : Mar 30, 2012, 11:54:06 PM
   Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil,org.hibernate.Session,java.util.Date" %>
<% try {
        String redirect = "";
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        Date date = new Date();
        DateFormat formatter;
        formatter = new SimpleDateFormat("yyyy-MM-dd");
        int qty = 0;
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        sess.beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        if (request.getParameter("patientid") != null) {
            LabPatient p = mgr.getLabPatientByID(request.getParameter("patientid"));
            session.setAttribute("patient", p);
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../labreception.jsp");
            return;
        }
        if ("forward".equals(request.getParameter("action"))) {
            int id = 0;
            String physician = request.getParameter("refer") == null ? "" : request.getParameter("refer");
            String facility = request.getParameter("hospital") == null ? "" : request.getParameter("hospital");
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            //String physicians = request.getParameter("refer") == null ? "" : request.getParameter("refer");
            //String hospital = request.getParameter("hospital") == null ? "" : request.getParameter("hospital");
            String labtest[] = request.getParameterValues("labtest1") == null ? null : request.getParameterValues("labtest1");
            String investigationnote = request.getParameter("investigation_note") == null ? "" : request.getParameter("investigation_note");
            String referalDoctor = request.getParameter("refer") == null ? "" : request.getParameter("refer");
            //out.print(labtest.length);
            try {

                List lst = mgr.listLaborders();
                String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                String y = yr.substring(2);
                FolderNumbering folderNumbering = (FolderNumbering) mgr.getFolderNumbering(1);
                int toadd = folderNumbering.getDiagnosticStartNumber() + folderNumbering.getDiagnosticCounter() + 1;
                String orderid = y + "" + folderNumbering.getFolderAbbreviationDiagnostics() + "" + toadd;
                mgr.updateDiagnosticCounter(1, toadd);
                Laborders laborder = null;
                Date dt = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("2013-01-14");
                String today = dateFormat.format(dt);
                List list = mgr.hasPatientBeenHereToday(patientid, today);
                System.out.println("is here was here " + list.size());
                int invId;
                Investigation subInv;
                List subInvsList;
                if (list != null && list.size() > 0) {
                    laborder = (Laborders) list.get(0);
                } else {
                    laborder = mgr.addLaborders(orderid, referalDoctor, physician, facility, id, patientid, "Pending Payment", user.getStaffid());
                }
                // String[] investigations = investigation.split("<>");
                for (int i = 0; i < labtest.length; i++) {
                    String[] investigationcode = labtest[i].split("><");

                    mgr.addPatientInvestigation(patientid, "CODE", Integer.parseInt(investigationcode[1]), "", Double.parseDouble(investigationcode[0]), id, formatter.format(date), "Pending", investigationnote, 0, laborder.getOrderid());
                    invId = Integer.parseInt(investigationcode[1]);

                    subInvsList = mgr.listSubInvUnderMainInv(invId);
                    System.out.println(".ssze  : " + subInvsList.size());
                    if (!subInvsList.isEmpty()) {
                        System.out.println("not empty at all !!!");
                        for (int p = 0; p < subInvsList.size(); p++) {
                            subInv = (Investigation) subInvsList.get(p);
                            mgr.addPatientInvestigation(patientid, "CODE", subInv.getDetailedInvId(), "", 0.0, id, formatter.format(date), "Pending", investigationnote, 0, orderid);
                        }
                    }
                    //}
                }
                redirect = "../detailrequest.jsp?labid=" + laborder.getOrderid() + "&patientid=" + patientid;
                /*if (mgr.sponsorshipDetails(patientid).getType().equalsIgnoreCase("CASH")) {
                 redirect = "../detailrequest.jsp";
                 }*/
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Forwarded Successfully");
                response.sendRedirect(redirect);
                return;
            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                response.sendRedirect("../labreception.jsp");
                return;
            }
        }
        if ("Forward".equals(request.getParameter("labvetted"))) {
            int id = 0;
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");
            String vetted = "Approved";
            String vettedby = request.getParameter("vettedby") == null ? "" : request.getParameter("vettedby");
            if (vetted == null) {
                session.setAttribute("class", "alert-success");
                session.setAttribute("last-error", "Forwarded Successfully");
                response.sendRedirect("../readyfordispatch.jsp");
                return;
            }

            mgr.updateLaborderScrutinize(labid, vettedby);
            mgr.updateLabordersStatus(labid, new Date(), vetted);
            List l = mgr.patientInvestigationByOrderId(labid);
            for (int r = 0; r < l.size(); r++) {
                Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(r);
                if (request.getParameter("vetted_" + patientinvestigation.getId()) != null || request.getParameter("note_" + patientinvestigation.getId()) != null) {
                    mgr.updatePatientInvestigation(patientinvestigation.getId(), request.getParameter("vetted_" + patientinvestigation.getId()), request.getParameter("note_" + patientinvestigation.getId()));
                }
                if (patientinvestigation.getPerformed().equalsIgnoreCase("Pending")) {
                    mgr.updateLabordersStatus(labid, new Date(), "Out-Complete");
                }
            }

            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Forwarded Successfully");
            response.sendRedirect("../readyfordispatch.jsp");
            return;

        }
        if ("dispatch".equals(request.getParameter("action"))) {

            String labid = request.getParameter("name") == null ? "" : request.getParameter("name");
            String uname = labid.split("_")[0];
            boolean complete = false;
            if (uname.equalsIgnoreCase("clinic")) {
                //mgr.updateLabordersStatus(labid.split("_")[1], new Date(), "Returned");
                List l = mgr.patientInvestigationByOrderId(labid.split("_")[1]);

                for (int r = 0; r < l.size(); r++) {
                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(r);


                    if (patientinvestigation.getPerformed().equalsIgnoreCase("Performed")) {
                        complete = true;

                    }
                    if (patientinvestigation.getPerformed().equalsIgnoreCase("Pending")) {
                        complete = false;
                        break;
                    }

                }

                if (complete == true) {
                    mgr.updateLabordersStatus(labid.split("_")[1], new Date(), "Returned");
                } else {
                    mgr.updateLabordersStatus(labid.split("_")[1], new Date(), "Out-Complete");
                }



            }
            if (uname.equalsIgnoreCase("print")) {
                //mgr.updateLabordersStatus(labid.split("_")[1], new Date(), "Dispatched");
                List l = mgr.patientInvestigationByOrderId(labid.split("_")[1]);

                for (int r = 0; r < l.size(); r++) {
                    Patientinvestigation patientinvestigation = (Patientinvestigation) l.get(r);

                    if (patientinvestigation.getPerformed().equalsIgnoreCase("Performed")) {
                        complete = true;
                    }
                    if (patientinvestigation.getPerformed().equalsIgnoreCase("Pending")) {
                        complete = false;
                        break;
                    }

                }
                System.out.println("Complete is " + complete);

                if (complete == true) {
                    mgr.updateLabordersStatus(labid.split("_")[1], new Date(), "Dispatched");
                    System.out.println("Complete: ++++++++++++++");
                } else {
                    mgr.updateLabordersStatus(labid.split("_")[1], new Date(), "Out-Complete");
                    System.out.println("Out-Complete: +++++++++++++");
                }
            }
            out.print("Successfully forwarded");

        }
        if ("actionforward".equals(request.getParameter("action"))) {
            String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");
            String patient = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String amountpaid = request.getParameter("amountpaid") == null ? "0.0" : request.getParameter("amountpaid");
            String useme = request.getParameter("useme") == null ? "0.0" : request.getParameter("useme");
            //double 
            List list = mgr.patientInvestigationByOrderId(labid);
            System.out.println("list.size : " + list.size());

            // <-----
            boolean secSponsorFound = true, hasMultipleSponsors = false;
            String primarySponsorValue = "0.0", secondarySponsorValue = "0.0", outOfPocketValue = "0.0";
            double primarySponsorAmnt, secSponsorAmnt, outOfPocketAmnt;
            int curPatientInvId;
            Sponsorhipdetails patientSponsors = mgr.sponsorshipDetails(patient);
            String primarySponsorId = patientSponsors.getSponsorid();
            if (primarySponsorId == null || primarySponsorId.isEmpty()) {
                primarySponsorId = "";
            }

            String secSponsorId = patientSponsors.getSecondarySponsor();
            if (secSponsorId == null || secSponsorId.isEmpty()) {
                secSponsorFound = false;
                secSponsorId = "";
            }

            System.out.println("amountPaid : " + amountpaid);
            double amntPaid = 0;
            try {
                amntPaid = Double.parseDouble(amountpaid);
                System.out.println("amntPaid : " + amntPaid);
                if (amntPaid == 0) {
                    hasMultipleSponsors = true;
                } else {
                    hasMultipleSponsors = false;
                }
            } catch (Exception e) {
                amntPaid = 0;
                hasMultipleSponsors = false;
            }
            System.out.println("multiple : " + hasMultipleSponsors);

            // ----->
            if (list != null) {
                for (int r = 0; r < list.size(); r++) {
                    amntPaid = 0;
                    Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(r);
                    System.out.println("patientinvestigation id : " + patientinvestigation.getInvestigationid());
                    curPatientInvId = patientinvestigation.getInvestigationid();
                    if (patientinvestigation.isCopaid()) {
                        mgr.updatePatientInvestigation(patientinvestigation.getId(), Boolean.TRUE, Double.parseDouble(request.getParameter("secondarysupport" + patientinvestigation.getId())));
                    }
                    if (patientinvestigation.isIsPrivate()) {
                        mgr.updatePatientInvestigation(patientinvestigation.getId(), Double.parseDouble(request.getParameter("privatesupport" + patientinvestigation.getId())), Boolean.TRUE);
                    }
                    if (hasMultipleSponsors) {
                        primarySponsorValue = request.getParameter(curPatientInvId + "_primarysponsor_" + primarySponsorId) == null ? "0.0" : request.getParameter(curPatientInvId + "_primarysponsor_" + primarySponsorId);
                        System.out.println("primarysponsorvalue is : " + primarySponsorValue);

                        if (secSponsorFound) {
                            secondarySponsorValue = request.getParameter(curPatientInvId + "_secondarysponsor_" + secSponsorId) == null ? "0.0" : request.getParameter(curPatientInvId + "_secondarysponsor_" + secSponsorId);
                        }
                        outOfPocketValue = request.getParameter(curPatientInvId + "_outofpocket") == null ? "0.0" : request.getParameter(curPatientInvId + "_outofpocket");
                        System.out.println(curPatientInvId + "_primarysponsor_" + primarySponsorId + " gave us " + primarySponsorValue);
                        System.out.println(curPatientInvId + "_secondarysponsor_" + secSponsorId + " gave us " + secondarySponsorValue);
                        System.out.println(curPatientInvId + "_outofpocket gave us " + outOfPocketValue);

                        try {

                            if (primarySponsorValue == null || primarySponsorValue.isEmpty()) {
                                primarySponsorValue = "0.0";
                            }
                            if (secondarySponsorValue == null || secondarySponsorValue.isEmpty()) {
                                secondarySponsorValue = "0.0";
                            }
                            if (outOfPocketValue == null || outOfPocketValue.isEmpty()) {
                                outOfPocketValue = "0.0";
                            }

                            System.out.println("primarySponsorValue sec : " + primarySponsorValue);
                            primarySponsorAmnt = Double.parseDouble(primarySponsorValue);
                            secSponsorAmnt = Double.parseDouble(secondarySponsorValue);
                            outOfPocketAmnt = Double.parseDouble(outOfPocketValue);

                            amntPaid = primarySponsorAmnt + secSponsorAmnt + outOfPocketAmnt;
                            System.out.println("amountpaid last show :  " + amntPaid);
                            if (amntPaid > 0) {
                                PaymentObject po = new PaymentObject();
                                po.setTransactionId(labid);
                                po.setTransactionType("Lab Payment");
                                po.setItemId(curPatientInvId + "");
                                po.setPrimarySponsorId(primarySponsorId);
                                po.setPrimarySponsorAmount(primarySponsorAmnt);
                                po.setSecSponsorId(secSponsorId);
                                po.setSecSponsorAmount(secSponsorAmnt);
                                po.setOutOfPocketId((11 + ""));
                                po.setOutOfPocketAmount(outOfPocketAmnt);
                                po.setDatePaid(mgr.getCurrentDate());
                                po.setTimePaid(mgr.getCurrentTime());
                                po.setStaffId(user.getStaffid());
                                po.setPatientId(patient);
                                po.setStatus("status");
                                po.setTotalAmountPaid(amntPaid);

                                mgr.addPaymentObject(po);
                            }

                        } catch (Exception f) {
                            // Emma what should happen here
                            System.out.println("amountpaid in catch : " + amntPaid);
                            System.out.println("*****************************");
                            f.printStackTrace();
                        }

                    }
                }
            }
            if (mgr.sponsorshipDetails(patient).getType().equalsIgnoreCase("CASH")) {
                      mgr.updateLaborders(labid, Double.parseDouble(useme), Double.parseDouble(amountpaid), (Double.parseDouble(useme) - Double.parseDouble(amountpaid)));
                      mgr.updateLaborderReceivedBy(labid, user.getStaffid());
                     mgr.updateLabordersStatus(labid, date, "Phlem");
            } else {
                      mgr.updateLaborders(labid, Double.parseDouble(useme), Double.parseDouble(useme), 0.0);
                      mgr.updateLaborderReceivedBy(labid, user.getStaffid());
                      mgr.updateLabordersStatus(labid, date, "Phlem");
            }


            if (!hasMultipleSponsors) {
                if (amntPaid > 0) {
                    System.out.println("in here");
                    PaymentObject po = new PaymentObject();
                    po.setTransactionId(labid);
                    po.setTransactionType("Lab Payment");
                    po.setOutOfPocketId((11 + ""));
                    po.setOutOfPocketAmount(amntPaid);
                    po.setDatePaid(mgr.getCurrentDate());
                    po.setTimePaid(mgr.getCurrentTime());
                    po.setStaffId(user.getStaffid());
                    po.setPatientId(patient);
                    po.setStatus("status");
                    po.setTotalAmountPaid(amntPaid);

                    mgr.addPaymentObject(po);
                }
            } else {
                System.out.println("out here");
            }
            response.sendRedirect("../labreception.jsp");
        }
        if ("settle".equals(request.getParameter("action"))) {

            String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");
            Double difference = request.getParameter("difference") == null ? 0.0 : Double.parseDouble(request.getParameter("difference"));
            Laborders laborders = mgr.updateLaborders(labid, difference);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Settled Successfully");
            response.sendRedirect("../print.jsp");
            return;
        }
        if ("Outstanding Bills".equals(request.getParameter("action"))) {

            String labid = request.getParameter("orderid") == null ? "" : request.getParameter("orderid");
            Double difference = request.getParameter("extra_amount") == null ? 0.0 : Double.parseDouble(request.getParameter("extra_amount"));
            String patient = request.getParameter("patientId") == null ? "" : request.getParameter("patientId");
            Laborders laborders = mgr.updateLaborders(labid, difference);


            PaymentObject po = new PaymentObject();
            po.setTransactionId(labid);
            po.setTransactionType("Lab Payment");
            po.setOutOfPocketId((11 + ""));
            po.setOutOfPocketAmount(difference);
            po.setDatePaid(mgr.getCurrentDate());
            po.setTimePaid(mgr.getCurrentTime());
            po.setStaffId(user.getStaffid());
            po.setPatientId(patient);
            po.setStatus("status");
            po.setTotalAmountPaid(difference);

            mgr.addPaymentObject(po);

            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Forwarded Successfully");
            response.sendRedirect("../readyfordispatch.jsp");
            return;
        }
        if ("phlembotomy".equals(request.getParameter("action"))) {

            String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");
            mgr.updateLabordersStatus(labid, new Date(), "Not Done");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Forwarded Successfully");
            response.sendRedirect("../phlembotomy.jsp");
            return;
        }
        if ("profile".equals(request.getParameter("action"))) {
            double amount = request.getParameter("amount") == "" ? 0.0 : Double.parseDouble(request.getParameter("amount"));
            String description = request.getParameter("description") == "" ? "" : request.getParameter("description");
            String labtest[] = request.getParameterValues("labtest1") == null ? null : request.getParameterValues("labtest1");
            Profile profile = (Profile) mgr.addProfile(description, amount);
            if (profile != null && labtest != null) {
                for (int r = 0; r < labtest.length; r++) {
                    // out.print(labtest[r]);
                    ProfileDetails profileDetails = mgr.addLabToProfile(profile.getProfileId(), Integer.parseInt(labtest[r]));
                }
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Profile Saved Successfully");
            }

            response.sendRedirect("../profile.jsp");
            return;
        }
        if ("deleteprofile".equals(request.getParameter("action"))) {
            int profileid = request.getParameter("profileid") == "" ? 0 : Integer.parseInt(request.getParameter("profileid"));
            List list = mgr.listProfileLab(profileid);
            for (int r = 0; r < list.size(); r++) {
                ProfileDetails profileDetails = (ProfileDetails) list.get(r);
                mgr.deleteDetailLab(profileDetails.getDetailId());
            }
            mgr.deleteProfile(profileid);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Profile Deleted Successfully");
            response.sendRedirect("../profile.jsp");
            return;
        }

        if ("deletedetail".equals(request.getParameter("action"))) {
            int profileid = request.getParameter("detailid") == "" ? 0 : Integer.parseInt(request.getParameter("detailid"));
            mgr.deleteDetailLab(profileid);
            session.setAttribute("lasterror", "Successfully deleted");
            response.sendRedirect("../profile.jsp");
            return;
        }
        if ("specimen".equals(request.getParameter("action"))) {
            String specimen = request.getParameter("specimen") == null ? "" : request.getParameter("specimen");
            mgr.addSpecimen(specimen);
            session.setAttribute("lasterror", "Successfully Added");
            response.sendRedirect("../addspecimen.jsp");
            return;
        }
        if ("updatespecimen".equals(request.getParameter("action"))) {
            String specimen = request.getParameter("specimen") == null ? "" : request.getParameter("specimen");
            int id = Integer.parseInt(request.getParameter("id"));
            mgr.updateSpecimen(id, specimen);
            session.setAttribute("lasterror", "Successfully Added");
            response.sendRedirect("../addspecimen.jsp");
            return;
        }
        if ("updatespecimen".equals(request.getParameter("action"))) {
            String specimen = request.getParameter("specimen") == null ? "" : request.getParameter("specimen");
            int id = Integer.parseInt(request.getParameter("id"));
            mgr.updateSpecimen(id, specimen);
            session.setAttribute("lasterror", "Successfully Added");
            response.sendRedirect("../addspecimen.jsp");
            return;
        }

        if ("deleteinvestivation".equals(request.getParameter("action"))) {
            int id = request.getParameter("id") == "" ? 0 : Integer.parseInt(request.getParameter("id"));
            mgr.deleteInvestigation(id);
            out.print("Successfully deleted");

            return;
        }

        if ("antibiotictreatment".equals(request.getParameter("action"))) {
            String resistant[] = request.getParameterValues("resistant[]") == null ? null : request.getParameterValues("resistant[]");
            String sensitive[] = request.getParameterValues("sensitive[]") == null ? null : request.getParameterValues("sensitive[]");
            String pinvestigation = request.getParameter("pinvestigation") == null ? null : request.getParameter("pinvestigation");
            if (resistant != null) {
                for (int z = 0; z < resistant.length; z++) {
                    InvestigationResistantSusc investigationResistantSusc = mgr.addInvestigationSusc(Integer.parseInt(pinvestigation), Integer.parseInt(resistant[z]), 0);
                }
            }
            if (sensitive != null) {
                for (int z = 0; z < sensitive.length; z++) {
                    InvestigationResistantSusc investigationResistantSusc = mgr.addInvestigationSusc(Integer.parseInt(pinvestigation), 0, Integer.parseInt(sensitive[z]));
                }
            }
            if (sensitive != null) {
            }
            /* out.print(resistant.length);
             out.print(sensitive.length);
             out.print(pinvestigation);*/
            session.setAttribute("lasterror", "Successfully deleted");
            response.sendRedirect("../laboratory_n.jsp");
            return;
        }


        if ("OutstandingForward".equals(request.getParameter("laboratory"))) {
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String id[] = request.getParameterValues("ids[]") == null ? null : request.getParameterValues("ids[]");
            String labid = request.getParameter("labid") == null ? "Laboratory" : request.getParameter("labid");
            String[] affords = request.getParameterValues("afford[]") == null ? null : request.getParameterValues("afford[]");
            String visit = request.getParameter("visitid");
            String loc = request.getParameter("from");
            String status = "Completed";
            int visitid = - 1;
            int orderid = -1;
            Patientinvestigation patInv;

            int size = mgr.patientInvestigationByOrderId(labid).size();
            if ((affords.length > 0) && affords.length < size) {
                status = "Incomplete";
            }
            try {
                mgr.updateLabordersStatus(labid, new Date(), status);
                System.out.println("id : " + id);
                System.out.println("ids length : " + id.length);
                // laboratory



                if (affords != null) {
                    System.out.print("Affords Length" + affords.length);
                    for (int r = 0; r < affords.length; r++) {
                        //Patienttreatment patienttreatment = mgr.getPatientTreatment(Integer.parseInt(ptid[r]));
                        String result = request.getParameter("results" + affords[r]) == "" ? "" : request.getParameter("results" + affords[r]);
                        String concen = request.getParameter("concentration" + affords[r]) == "" ? "" : request.getParameter("concentration" + affords[r]);
                        String rnge = request.getParameter("range" + affords[r]) == "" ? "" : request.getParameter("range" + affords[r]);
                        String notes = request.getParameter("comment" + affords[r]) == "" ? "" : request.getParameter("comment" + affords[r]);

                        System.out.println("result : " + result);
                        int incomingPatInvId = Integer.parseInt(id[r]);
                        patInv = mgr.getPatientInvById(incomingPatInvId);

                        // patInv.getInvestigationid returns the investigationid

                        //Investigation ig = mgr.getInvestigation(patInv.getInvestigationid());
                        //System.out.println("iguana : " + ig.getName() + " " + ig.getGroupedUnderId() + " " + ig.getRefRangeType());

                        //       if (mgr.listSubInvUnderMainInv(patInv.getInvestigationid()).isEmpty()) {
                        if (result != "") {
                            mgr.updatePatientInvestigation(Integer.parseInt(affords[r]), result, concen, rnge, "Performed", notes, 0.0);
                        }

                    }
                }
                if (mgr.patientInvestigationByOrderId(labid) != null) {
                    System.out.print("All Length" + size);
                    for (int r = 0; r < size; r++) {
                        int incomingPatInvId = Integer.parseInt(id[r]);
                        patInv = mgr.getPatientInvById(incomingPatInvId);
                        Investigation investigation = mgr.getInvestigation(patInv.getInvestigationid());

                        Calendar dob = Calendar.getInstance();
                        Date dateOfBirth = patientid.contains("C") || patientid.contains("c") ? mgr.getPatientByID(patientid).getDateofbirth() : mgr.getLabPatientByID(patientid).getDateofbirth();
                        dob.setTime(dateOfBirth);
                        Calendar today = Calendar.getInstance();
                        int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
                        if (today.get(Calendar.DAY_OF_YEAR) <= dob.get(Calendar.DAY_OF_YEAR)) {
                            age--;
                        }

                        if (investigation.getRefRangeType().equalsIgnoreCase("det")) {
                            System.out.println("iguana 2 : i entered");
                            List details = mgr.getDetRefRangeByDetInvId(investigation.getDetailedInvId());
                            System.out.println("Detailed Size: " + details.size());
                            for (int y = 0; y < details.size(); y++) {
                                RefRangeDet rangeDet = (RefRangeDet) details.get(y);
                                if (Integer.parseInt(rangeDet.getDetFrom()) < age && Integer.parseInt(rangeDet.getDetTo()) > age) {
                                    //int archiveid = investigation.getDetailedInvId();
                                    int detailedid = investigation.getDetailedInvId();
                                    String detfrom = rangeDet.getDetFrom();
                                    String detto = rangeDet.getDetTo();
                                    String fupper = rangeDet.getFUpper();
                                    String flower = rangeDet.getFLower();
                                    String mupper = rangeDet.getMUpper();
                                    String mlower = rangeDet.getMLower();
                                    System.out.println("Detailed ID: " + detailedid);
                                    System.out.println("Size detail: " + details.size());
                                    System.out.println("Patient Investigation ID: " + patInv.getId());
                                    System.out.println("Patient Investigation ID2: " + patInv.getInvestigationid());
                                    ArchivedRefRangeDet archivedRefRangeDet = mgr.getRefDet(patInv.getId());
                                    if (archivedRefRangeDet == null) {
                                        mgr.archiveDetailedRefRange(detailedid, detfrom, detto, mlower, mupper, flower, fupper, labid, patInv.getId());
                                    }
                                }
                            }
                        }
                        if (investigation.getRefRangeType().equalsIgnoreCase("uni")) {
                            List ranges = mgr.getUniRefRangeByDetInvId(investigation.getDetailedInvId());
                            RefRangeUni rangeUni = (RefRangeUni) ranges.get(0);
                            if (rangeUni != null) {
                                int aid = patInv.getId();
                                int detid = rangeUni.getDetailedinvRefrangeTypeId();
                                int selected = rangeUni.getSelected();
                                String lower = rangeUni.getLowerRefRange() == null ? "" : rangeUni.getLowerRefRange();
                                String upper = rangeUni.getUpperRefRange() == null ? "" : rangeUni.getUpperRefRange();
                                String paragraphic = rangeUni.getParagraphic() == null ? "" : rangeUni.getParagraphic();
                                mgr.archivedUniversalRefRange(detid, selected, lower, upper, paragraphic, labid, aid);
                            }
                        }
                    }
                }
                session.setAttribute("lasterror", "Successfully forwarded");
                response.sendRedirect("../pendingresults.jsp");
                return;

            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../pendingresults.jsp");
                return;
            }

        }



        if ("Forward".equals(request.getParameter("laboratory"))) {
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String id[] = request.getParameterValues("ids[]") == null ? null : request.getParameterValues("ids[]");
            String labid = request.getParameter("labid") == null ? "Laboratory" : request.getParameter("labid");
            String[] affords = request.getParameterValues("afford[]") == null ? null : request.getParameterValues("afford[]");
            String visit = request.getParameter("visitid");
            String loc = request.getParameter("from");
            String status = "Completed";
            int visitid = - 1;
            int orderid = -1;
            Patientinvestigation patInv;

            int size = mgr.patientInvestigationByOrderId(labid).size();
            if ((affords.length > 0) && affords.length < size) {
                status = "Incomplete";
            }
            try {
                mgr.updateLabordersStatus(labid, new Date(), status);
                System.out.println("id : " + id);
                System.out.println("ids length : " + id.length);
                // laboratory



                if (affords != null) {
                    System.out.print("Affords Length" + affords.length);
                    for (int r = 0; r < affords.length; r++) {
                        //Patienttreatment patienttreatment = mgr.getPatientTreatment(Integer.parseInt(ptid[r]));
                        String result = request.getParameter("results" + affords[r]) == "" ? "" : request.getParameter("results" + affords[r]);
                        String concen = request.getParameter("concentration" + affords[r]) == "" ? "" : request.getParameter("concentration" + affords[r]);
                        String rnge = request.getParameter("range" + affords[r]) == "" ? "" : request.getParameter("range" + affords[r]);
                        String notes = request.getParameter("comment" + affords[r]) == "" ? "" : request.getParameter("comment" + affords[r]);

                        System.out.println("result : " + result);
                        int incomingPatInvId = Integer.parseInt(id[r]);
                        patInv = mgr.getPatientInvById(incomingPatInvId);

                        // patInv.getInvestigationid returns the investigationid

                        //Investigation ig = mgr.getInvestigation(patInv.getInvestigationid());
                        //System.out.println("iguana : " + ig.getName() + " " + ig.getGroupedUnderId() + " " + ig.getRefRangeType());

                        //       if (mgr.listSubInvUnderMainInv(patInv.getInvestigationid()).isEmpty()) {
                        if (result != "") {
                            mgr.updatePatientInvestigation(Integer.parseInt(affords[r]), result, concen, rnge, "Performed", notes, 0.0);
                        }

                    }
                }
                if (mgr.patientInvestigationByOrderId(labid) != null) {
                    System.out.print("All Length" + size);
                    for (int r = 0; r < size; r++) {
                        int incomingPatInvId = Integer.parseInt(id[r]);
                        patInv = mgr.getPatientInvById(incomingPatInvId);
                        Investigation investigation = mgr.getInvestigation(patInv.getInvestigationid());

                        Calendar dob = Calendar.getInstance();
                        Date dateOfBirth = patientid.contains("C") || patientid.contains("c") ? mgr.getPatientByID(patientid).getDateofbirth() : mgr.getLabPatientByID(patientid).getDateofbirth();
                        dob.setTime(dateOfBirth);
                        Calendar today = Calendar.getInstance();
                        int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
                        if (today.get(Calendar.DAY_OF_YEAR) <= dob.get(Calendar.DAY_OF_YEAR)) {
                            age--;
                        }

                        if (investigation.getRefRangeType().equalsIgnoreCase("det")) {
                            System.out.println("iguana 2 : i entered");
                            List details = mgr.getDetRefRangeByDetInvId(investigation.getDetailedInvId());
                            System.out.println("Detailed Size: " + details.size());
                            for (int y = 0; y < details.size(); y++) {
                                RefRangeDet rangeDet = (RefRangeDet) details.get(y);
                                if (Integer.parseInt(rangeDet.getDetFrom()) < age && Integer.parseInt(rangeDet.getDetTo()) > age) {
                                    //int archiveid = investigation.getDetailedInvId();
                                    int detailedid = investigation.getDetailedInvId();
                                    String detfrom = rangeDet.getDetFrom();
                                    String detto = rangeDet.getDetTo();
                                    String fupper = rangeDet.getFUpper();
                                    String flower = rangeDet.getFLower();
                                    String mupper = rangeDet.getMUpper();
                                    String mlower = rangeDet.getMLower();
                                    System.out.println("Detailed ID: " + detailedid);
                                    System.out.println("Size detail: " + details.size());
                                    System.out.println("Patient Investigation ID: " + patInv.getId());
                                    System.out.println("Patient Investigation ID2: " + patInv.getInvestigationid());
                                    ArchivedRefRangeDet archivedRefRangeDet = mgr.getRefDet(patInv.getId());
                                    if (archivedRefRangeDet == null) {
                                        mgr.archiveDetailedRefRange(detailedid, detfrom, detto, mlower, mupper, flower, fupper, labid, patInv.getId());
                                    }
                                }
                            }
                        }
                        if (investigation.getRefRangeType().equalsIgnoreCase("uni")) {
                            List ranges = mgr.getUniRefRangeByDetInvId(investigation.getDetailedInvId());
                            RefRangeUni rangeUni = (RefRangeUni) ranges.get(0);
                            if (rangeUni != null) {
                                int aid = patInv.getId();
                                int detid = rangeUni.getDetailedinvRefrangeTypeId();
                                int selected = rangeUni.getSelected();
                                String lower = rangeUni.getLowerRefRange() == null ? "" : rangeUni.getLowerRefRange();
                                String upper = rangeUni.getUpperRefRange() == null ? "" : rangeUni.getUpperRefRange();
                                String paragraphic = rangeUni.getParagraphic() == null ? "" : rangeUni.getParagraphic();
                                mgr.archivedUniversalRefRange(detid, selected, lower, upper, paragraphic, labid, aid);
                            }
                        }
                    }
                }
                session.setAttribute("lasterror", "Successfully forwarded");
                response.sendRedirect("../labvetted.jsp");
                return;

            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../laboratory_n.jsp");
                return;
            }

        }

        //---- End Nezer 19th Dec
        if ("fromclinic".equals(request.getParameter("action"))) {
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String isprivateSupportcon[] = request.getParameterValues("isprivateSupportcon[]") == null ? null : request.getParameterValues("isprivateSupportcon[]");
            String copay[] = request.getParameterValues("copay[]") == null ? null : request.getParameterValues("copay[]");
            String labid = request.getParameter("labid") == null ? "Laboratory" : request.getParameter("labid");
            String[] affords = request.getParameterValues("performed[]") == null ? null : request.getParameterValues("performed[]");
            Double amountpaid = request.getParameter("amountpaid") == null ? 0.0 : Double.parseDouble(request.getParameter("amountpaid"));
            Double amountdue = request.getParameter("amountdue") == null ? 0.0 : Double.parseDouble(request.getParameter("amountdue"));
            String visit = request.getParameter("visitid");
            String loc = request.getParameter("from");
            String status = "Phlem";

            List lst = mgr.listLaborders();
            String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
            String y = yr.substring(2);
            int toadd = lst.size() + 1;
            String orderid = y + "DML" + toadd;

            mgr.addLaborders(orderid, user.getStaffid(), user.getStaffid(), "Danpong Clinic", Integer.parseInt(visit), patientid, "Phlem", user.getStaffid());
            /// mgr.addTransitLabs(orderid, patientid, user.getStaffid(), id);
            List ls = mgr.patientInvestigationByOrderId(labid);
            
            
            
            try {

                for (int i = 0; i < ls.size(); i++) {
                    Patientinvestigation patientinvestigation = (Patientinvestigation) ls.get(i);
                    mgr.updatePatientInvestigation(patientinvestigation.getId(), orderid);
                }
                mgr.updateLabordersStatus(orderid, new Date(), status);
                mgr.updateLaborders(orderid, amountdue, amountpaid, (amountdue - amountpaid));
                if (affords != null) {
                    out.print(affords.length);
                    for (int r = 0; r < affords.length; r++) {
                        mgr.updatePatientInvestigationPayment(Integer.parseInt(affords[r]));
                    }
                }
                if (isprivateSupportcon != null) {
                    for (int r = 0; r < isprivateSupportcon.length; r++) {
                        // double amount = request.getParameter("privatesupportcon"+isprivateSupportcon[r])==""?0.0:Double.parseDouble(request.getParameter("privatesupportcon"+isprivateSupportcon[r]));
                        mgr.updatePatientInvestigation(Integer.parseInt(isprivateSupportcon[r]), 0.0, Boolean.TRUE);
                    }
                }
                if (copay != null) {
                    for (int r = 0; r < copay.length; r++) {
                        // double amount = request.getParameter("secondarysupportcon"+copay[r])==""?0.0:Double.parseDouble(request.getParameter("privatesupportcon"+copay[r]));
                        mgr.updatePatientInvestigation(Integer.parseInt(copay[r]), Boolean.TRUE, 0.0);
                    }
                }
                mgr.updateTransitClinicLabs(labid);
                session.setAttribute("lasterror", "Successfully forwarded");
                redirect = "../fromclinicdetails.jsp?labid=" + orderid + "&patientid=" + patientid;

                response.sendRedirect(redirect);
                return;
            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../fromclinic.jsp");
                return;
            }
        }

        if ("doctor".equals(request.getParameter("action"))) {

            String name = request.getParameter("name") == null ? "" : request.getParameter("name");
            String facility = request.getParameter("beds") == null ? "" : request.getParameter("beds");
            mgr.addDoctor(name, facility);
            out.print("Successfully added");
            session.setAttribute("lasterror", "Doctor Successfully Saved!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addDoctor.jsp");
            return;

        }

        if ("doctoredit".equals(request.getParameter("action"))) {
            String name = request.getParameter("uname") == null ? "" : request.getParameter("uname");
            String facility = request.getParameter("occupied") == null ? "" : request.getParameter("occupied");
            int id = request.getParameter("uid") == null ? 0 : Integer.parseInt(request.getParameter("uid"));
            if (id == 0) {
                out.print("can't update please try again");
                session.setAttribute("lasterror", "Error Occured");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../addDoctor.jsp");
                return;
            }

            mgr.updateDoctosInfo(id, name, facility);
            out.print("changes saved");
            session.setAttribute("lasterror", "Doctor Successfully Edited!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addDoctor.jsp");
            return;
        }

        if ("deletedoctor".equals(request.getParameter("action"))) {
            int id = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
            //out.print(id);
            if (id == 0) {
                out.print("can't update please try again");
                session.setAttribute("lasterror", "Error Occured");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../addDoctor.jsp");
                return;
            }
            mgr.deleteDocotr(id);
            out.print("Successfully deleted");
            session.setAttribute("lasterror", "Doctor Successfully Deleted!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addDoctor.jsp");

        }

        if ("facility".equals(request.getParameter("action"))) {

            String name = request.getParameter("name") == null ? "" : request.getParameter("name");
            String facility = request.getParameter("beds") == null ? "" : request.getParameter("beds");
            mgr.addFacility(name, facility);
            out.print("Successfully added");
            session.setAttribute("lasterror", "Facilty Successfully Saved!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addFacilty.jsp");
            return;

        }

        if ("facilityedit".equals(request.getParameter("action"))) {
            String name = request.getParameter("uname") == null ? "" : request.getParameter("uname");
            String facility = request.getParameter("occupied") == null ? "" : request.getParameter("occupied");
            int id = request.getParameter("uid") == null ? 0 : Integer.parseInt(request.getParameter("uid"));
            if (id == 0) {
                out.print("can't update please try again");
                return;
            }

            mgr.updateFacility(id, name, facility);
            out.print("changes saved");
            session.setAttribute("lasterror", "Facilty Successfully Edited!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addFacilty.jsp");
            return;
        }

        if ("deletefacility".equals(request.getParameter("action"))) {
            int id = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
            if (id == 0) {
                out.print("can't update please try again");
                return;
            }
            mgr.deleteFacility(id);
            out.print("Successfully deleted");
            session.setAttribute("lasterror", "Facilty Successfully Deleted!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addFacilty.jsp");

        }

        HibernateUtil.getSessionFactory()
                .getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory()
                .close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();




        if (ServletException.class
                .isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>