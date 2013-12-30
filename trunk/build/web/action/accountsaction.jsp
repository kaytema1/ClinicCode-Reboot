<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();


        if ("depositpayment".equals(request.getParameter("action"))) {

            double amountDeposited = request.getParameter("amountdeposited") == null ? 0.0 : Double.parseDouble(request.getParameter("amountdeposited"));
            String visitIdString = request.getParameter("visitid") == "" ? "" : request.getParameter("visitid");

            int visitid = 0;
            if (!visitIdString.equalsIgnoreCase("")) {
                try {
                    visitid = Integer.parseInt(visitIdString);
                } catch (NumberFormatException ex) {
                    session.setAttribute("class", "alert-error");
                    session.setAttribute("lasterror", "Please Try Again");
                    response.sendRedirect("../inpatientdepositshub.jsp");
                    ex.printStackTrace();
                }



            }


            Visitationtable vst = mgr.getVisitById(visitid);

            if (vst == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Select Patient With Initiated Visit");
                response.sendRedirect("../inpatientdepositshub.jsp");
            }

            vst = mgr.updateDeposit(vst.getVisitid(), amountDeposited);
            vst = mgr.updateTotalAmountPaid(vst.getVisitid(), amountDeposited);
            vst = mgr.updateVisitationStatus(vst.getVisitid(), "ward");
            if (amountDeposited > 0) {
                PaymentObject po = new PaymentObject();
                po.setTransactionId(vst.getVisitid() + "");
                po.setTransactionType("Deposit Payment");
                po.setItemId("");
                po.setPrimarySponsorId(11 + "");
                po.setPrimarySponsorAmount(amountDeposited);
                po.setSecSponsorId("");
                po.setSecSponsorAmount(0.0);
                po.setOutOfPocketId((11 + ""));
                po.setOutOfPocketAmount(amountDeposited);
                po.setDatePaid(mgr.getCurrentDate());
                po.setTimePaid(mgr.getCurrentTime());
                po.setStaffId(user.getStaffid());
                po.setPatientId(vst.getPatientid());
                po.setStatus("status");
                po.setTotalAmountPaid(amountDeposited);

                mgr.addPaymentObject(po);
            }

            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Deposit Saved Successfully");
            response.sendRedirect("../billing.jsp");
            return;
        }

        if ("Pharmacy Receipt".equals(request.getParameter("action"))) {
            String tids[] = request.getParameterValues("pid[]") == null ? null : request.getParameterValues("pid[]");
            String paid[] = request.getParameterValues("paid[]") == null ? null : request.getParameterValues("paid[]");
            // String vids[] = request.getParameterValues("vid[]") == null ? null : request.getParameterValues("vid[]");
            // String checks[] = request.getParameterValues("checks[]") == null ? null : request.getParameterValues("checks[]");

            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String unitName = request.getParameter("unitid") == null ? "Accounts" : request.getParameter("unitid");
            Double paidamount = request.getParameter("amountdue") == null ? 0.0 : Double.parseDouble(request.getParameter("amountdue"));
            Double combined = 0.0;
            String visit = request.getParameter("visitid");
            String orderid = request.getParameter("orderid");
            int visitid = - 1;
            //double amountpiad;
            try {
                visitid = Integer.parseInt(visit);
            } catch (NumberFormatException e) {

                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../dispensary.jsp");
                return;
            }
            if (patientid != null) {
                // System.out.println(patientid);
                // / if (tids != null) {
                List orders = mgr.listPatientTreatmentsByOrderid(orderid);
                for (int r = 0; r < orders.size(); r++) {
                    Patienttreatment patienttreatment = (Patienttreatment) orders.get(r);
                    // double amountpaid = 
                    combined = combined + (patienttreatment.getPrice() * patienttreatment.getQuantity());
                    if (patienttreatment.getCopaid()) {
                        double amount = request.getParameter("secondarysupport" + patienttreatment.getId()) == null ? 0.0 : Double.parseDouble(request.getParameter("secondarysupport" + patienttreatment.getId()));
                        mgr.updatePatientTreatment(patienttreatment.getId(), amount, Boolean.TRUE);
                    }
                    if (patienttreatment.getIsPrivate()) {
                        double amount = request.getParameter("privatesupport" + patienttreatment.getId()) == null ? 0.0 : Double.parseDouble(request.getParameter("privatesupport" + patienttreatment.getId()));
                        mgr.updatePatientTreatment(patienttreatment.getId(), Boolean.TRUE, amount);
                    }
                    mgr.updatePatientTreatment(patienttreatment.getId(), "paid", 0.0);
                }
                double diff = combined - paidamount;

                mgr.updateFolderLocation("account", unitName, patientid);
                mgr.updateVisitationStatus(visitid, unitName, "account");
                mgr.updateDispensed(orderid, "Settled");
                mgr.updateAmounts(orderid, paidamount, diff);
                double dd = mgr.getPatientBill(visitid).getTotalBill();
                double dt = mgr.getPatientBill(visitid).getAmountPaid() + paidamount;
                String status = "Debt";
                if ((dd - dt) < 0) {
                    status = "Advance";
                }
                if ((dd - dt) == 0) {
                    status = "Full";
                }
                mgr.updatePatientBills(visitid, dd, dt, status);
                session.setAttribute("lasterror", "Saved Successfully");
                session.setAttribute("class", "alert-success");
                response.sendRedirect("../dispensary.jsp");
                return;
                /*}

                 mgr.updateFolderLocation("account", unitName, patientid);
                 mgr.updateVisitationStatus(visitid, unitName, "account");
                 session.setAttribute("lasterror", "Successfully forwarded");
                 response.sendRedirect("../billing.jsp");
                 return;*/
            }
        }


        if ("walk-inprocedurepayment".equals(request.getParameter("action"))) {

            double amountpaid = request.getParameter("amountpaidinput") == null ? 0.0 : Double.parseDouble(request.getParameter("amountpaidinput"));
            String orderid = request.getParameter("orderid") == "" ? "" : request.getParameter("orderid");
            Procedureorderswalkin order = mgr.getProcedureorderswalking(orderid);

            if (order != null) {

                if (amountpaid > 0 && amountpaid >= order.getTotal()) {
                    mgr.updateProcedureorders(orderid, order.getTotal());




                    session.setAttribute("class", "alert-success");
                    session.setAttribute("lasterror", "Payment Made Successfully!");
                    response.sendRedirect("../billing.jsp");
                    return;
                }

            }

            session.setAttribute("lasterror", "Please Ensure That Full Payment is Made");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../billing.jsp");
            return;
        }

        if ("performprocedures".equals(request.getParameter("action"))) {

            String patientOrder = request.getParameter("patientOrder") == "" ? "" : request.getParameter("patientOrder");
            String walkingOrder = request.getParameter("walkinOrder") == "" ? "" : request.getParameter("walkinOrder");


            String orderid = request.getParameter("orderid") == "" ? "" : request.getParameter("orderid");

            if (walkingOrder != "") {

                Procedureorderswalkin order = mgr.getProcedureorderswalking(orderid);


                if (order != null) {
                    mgr.updateProcedureorderswalkinStatus(order.getOrderid(), "Performed", user.getStaffid());
                    session.setAttribute("lasterror", "Procedure Forwarded Successfully");
                    session.setAttribute("class", "alert-success");
                    response.sendRedirect("../readyprocedureslist.jsp");
                    return;
                }
            } else if (patientOrder != "") {

                Procedureorders order = mgr.getProcedureorders(Integer.parseInt(orderid));


                if (order != null) {
                    mgr.updateProcedureorders(order.getOrderid(), "Performed", user.getStaffid());
                    session.setAttribute("lasterror", "Procedure Forwarded Successfully");
                    session.setAttribute("class", "alert-success");
                    response.sendRedirect("../readyprocedureslist.jsp");
                    return;
                }
            }

            session.setAttribute("lasterror", "Please Try Again");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../readyprocedureslist.jsp");
            return;
        }
        if ("Laboratory Receipt".equals(request.getParameter("action"))) {
            // String tids[] = request.getParameterValues("pid[]") == null ? null : request.getParameterValues("pid[]");
            String vids[] = request.getParameterValues("vid[]") == null ? null : request.getParameterValues("vid[]");
            String checks[] = request.getParameterValues("checks[]") == null ? null : request.getParameterValues("checks[]");

            String pid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String uName = request.getParameter("unitid") == null ? "Accounts" : request.getParameter("unitid");
            String amountSettled = request.getParameter("amountsettled") == null ? "0.0" : request.getParameter("amountsettled");
            String amountDue = request.getParameter("amountdue") == null ? "0.0" : request.getParameter("amountdue");
            String vst = request.getParameter("visitid");
            int vstid = - 1;
            Double amts = 0.0;
            Double amtdue = 0.0;
            //double amountpiad;
            try {
                vstid = Integer.parseInt(vst);
                amts = Double.parseDouble(amountSettled);
                amtdue = Double.parseDouble(amountDue);
            } catch (NumberFormatException e) {
                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../billing.jsp");
                return;
            }

            if (pid != null) {

                if (vids != null) {

                    if (checks != null) {
                        for (int r = 0; r < checks.length; r++) {

                            mgr.updatePatientInvestigationPayment(Integer.parseInt(checks[r]));

                        }
                    }
                    List l = mgr.listLabordersByVisitid(vstid);
                    Laborders lb = (Laborders) l.get(0);
                    if (lb != null) {
                        //mgr.updateLaborders(lb.getOrderid(), amts, amtdue);
                    }

                    mgr.updateFolderLocation((String) session.getAttribute("unit"), uName, pid);
                    mgr.updateVisitationStatus(vstid, uName, (String) session.getAttribute("unit"));
                    session.setAttribute("class", "alert-success");
                    session.setAttribute("lasterror", "Saved Successfully!");
                    response.sendRedirect("../billing.jsp");
                    return;
                }
                mgr.updateFolderLocation((String) session.getAttribute("unit"), uName, pid);
                mgr.updateVisitationStatus(vstid, uName, (String) session.getAttribute("unit"));

                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Forwarded Successfully!");
                response.sendRedirect("../billing.jsp");
                return;
            }
        }
        if ("Consultation Receipt".equals(request.getParameter("action"))) {

            String cardBillString = request.getParameter("cardbillid");
            String registrationBillString = request.getParameter("registrationbillid");
            String consultationBillString = request.getParameter("consutlationbillid");

            double cardBill = 0;
            double registrationBill = 0;
            double consultationBill = 0;
            double consultationFeePaid = 0;

            // double amountdue = request.getParameter("amountdue") == "" ? 0.0 : Double.parseDouble(request.getParameter("amountdue"));
            double amountpaid = request.getParameter("amountpaid") == "" ? 0.0 : Double.parseDouble(request.getParameter("amountpaid"));
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");

            String status = request.getParameter("status") == "" ? "Not Paid" : request.getParameter("status");
            String uame = request.getParameter("unitid") == null ? "Accounts" : request.getParameter("unitid");
            String vis = request.getParameter("cid");

            boolean secpay = request.getParameter("copay") == null ? Boolean.FALSE : Boolean.TRUE;
            boolean isprivateSupport = request.getParameter("isprivateSupportcon") == null ? Boolean.FALSE : Boolean.TRUE;
            double privatesupport = 0;  //request.getParameter("privatesupportcon") == "" ? 0.0 : Double.parseDouble(request.getParameter("privatesupportcon"));
            double secondarysupport = 0; //request.getParameter("secondarysupportcon") == "" ? 0.0 : Double.parseDouble(request.getParameter("secondarysupportcon"));
            String vid = request.getParameter("visitid");
            String status1 = "Not Paid";
            int visid = - 1;
            int vint = -1;

            try {
                visid = Integer.parseInt(vis);
                vint = Integer.parseInt(vid);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../registrationnconsultationbills.jsp");
                return;
            }
            Visitationtable vst = mgr.getVisitById(vint);
            Patient p = null;
            if (!patientid.equalsIgnoreCase("")) {
                p = mgr.getPatientByID(patientid);
            }

            if (p != null & amountpaid > 0) {

                int cardBillId = 0;
                int registrationBillId = 0;
                int consultationBillId = 0;
                double totalBill = 0.0;


                if (cardBillString != "") {
                    cardBillId = Integer.parseInt(cardBillString);

                }

                if (registrationBillString != "") {
                    registrationBillId = Integer.parseInt(registrationBillString);

                }

                if (consultationBillString != "") {
                    consultationBillId = Integer.parseInt(consultationBillString);
                }


                if (cardBillId > 0) {
                    PatientBills bill = mgr.getPatientBill(cardBillId);
                    totalBill = totalBill + bill.getTotalBill();
                    mgr.updatePatientBills(bill.getId(), bill.getTotalBill(), "Paid");
                    cardBill = bill.getTotalBill();
                    vst = mgr.updateTotalAmountPaid(vst.getVisitid(), bill.getTotalBill());
                    if (bill.getTotalBill() > 0) {
                        PaymentObject po = new PaymentObject();
                        po.setTransactionId(vst.getVisitid() + "");
                        po.setTransactionType("Card Payment");
                        po.setItemId("");
                        po.setPrimarySponsorId(11 + "");
                        po.setPrimarySponsorAmount(bill.getTotalBill());
                        po.setSecSponsorId("");
                        po.setSecSponsorAmount(0.0);
                        po.setOutOfPocketId((11 + ""));
                        po.setOutOfPocketAmount(bill.getTotalBill());
                        po.setDatePaid(mgr.getCurrentDate());
                        po.setTimePaid(mgr.getCurrentTime());
                        po.setStaffId(user.getStaffid());
                        po.setPatientId(vst.getPatientid());
                        po.setStatus("status");
                        po.setTotalAmountPaid(bill.getTotalBill());

                        mgr.addPaymentObject(po);
                    }
                }


                if (registrationBillId > 0) {
                    System.out.println("reg bill check me out " + registrationBillId);
                    PatientBills bill = mgr.getPatientBill(registrationBillId);
                    totalBill = totalBill + bill.getTotalBill();
                    registrationBill = bill.getTotalBill();
                    List patient_registrations = mgr.listPatientRegistrationsByPatientId(bill.getPatientid());
                    for (int xy = 0; xy < patient_registrations.size(); xy++) {
                        PatientRegistration registration = (PatientRegistration) patient_registrations.get(xy);
                        mgr.updatePatientRegistration(registration.getRegId(), Boolean.TRUE);

                    }


                    mgr.updatePatientBills(bill.getId(), bill.getTotalBill(), "Paid");
                    vst = mgr.updateTotalAmountPaid(vst.getVisitid(), bill.getTotalBill());
                    if (bill.getTotalBill() > 0) {
                        PaymentObject po = new PaymentObject();
                        po.setTransactionId(vst.getVisitid() + "");
                        po.setTransactionType("Registration Payment");
                        po.setItemId("");
                        po.setPrimarySponsorId(11 + "");
                        po.setPrimarySponsorAmount(bill.getTotalBill());
                        po.setSecSponsorId("");
                        po.setSecSponsorAmount(0.0);
                        po.setOutOfPocketId((11 + ""));
                        po.setOutOfPocketAmount(bill.getTotalBill());
                        po.setDatePaid(mgr.getCurrentDate());
                        po.setTimePaid(mgr.getCurrentTime());
                        po.setStaffId(user.getStaffid());
                        po.setPatientId(vst.getPatientid());
                        po.setStatus("status");
                        po.setTotalAmountPaid(bill.getTotalBill());

                        mgr.addPaymentObject(po);
                    }


                }

                if (consultationBillId > 0) {
                    PatientBills bill = mgr.getPatientBill(consultationBillId);
                    mgr.updatePatientConsultation(visid, amountpaid, status, secpay, isprivateSupport, secondarysupport, privatesupport);
                    consultationFeePaid = amountpaid - (cardBill + registrationBill);

                    if (((bill.getTotalBill()) - consultationFeePaid) < 0) {
                        status1 = "Partly Paid";
                    }
                    if (((bill.getTotalBill()) - consultationFeePaid) == 0) {
                        status1 = "Paid";
                    }

                    double total = bill.getTotalBill();
                    totalBill = totalBill + bill.getTotalBill();
                    mgr.updatePatientBills(bill.getId(), total, total, "Paid");
                    mgr.updateFolderLocation("account", uame, p.getPatientid());
                    mgr.updateVisitationStatus(vint, uame, "account");


                    mgr.updateVisitTotalBill(visid, total);
                    vst = mgr.updateTotalAmountPaid(vst.getVisitid(), bill.getTotalBill());
                    if (bill.getTotalBill() > 0) {
                        PaymentObject po = new PaymentObject();
                        po.setTransactionId(vst.getVisitid() + "");
                        po.setTransactionType("Consultation Payment");
                        po.setItemId("");
                        po.setPrimarySponsorId(11 + "");
                        po.setPrimarySponsorAmount(bill.getTotalBill());
                        po.setSecSponsorId("");
                        po.setSecSponsorAmount(0.0);
                        po.setOutOfPocketId((11 + ""));
                        po.setOutOfPocketAmount(bill.getTotalBill());
                        po.setDatePaid(mgr.getCurrentDate());
                        po.setTimePaid(mgr.getCurrentTime());
                        po.setStaffId(user.getStaffid());
                        po.setPatientId(vst.getPatientid());
                        po.setStatus("status");
                        po.setTotalAmountPaid(bill.getTotalBill());

                        mgr.addPaymentObject(po);
                    }
                }


                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Bill Paid Successfully!");
                response.sendRedirect("../registrationnconsultationbills.jsp");
                return;

            }
            session.setAttribute("lasterror", "Error Occured Please Please Try Again 2");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../registrationnconsultationbills.jsp");
            return;
        }
        if ("Procedure Receipt".equals(request.getParameter("action"))) {

            double amountpaid = request.getParameter("amountpaid") == null ? 0.0 : Double.parseDouble(request.getParameter("amountpaid"));
            String order = request.getParameter("orderid") == "" ? "unpaid" : request.getParameter("orderid");
            String patid = request.getParameter("patient") == null ? "" : request.getParameter("patient");

            String[] secpay = request.getParameterValues("copay[]") == null ? null : request.getParameterValues("copay[]");
            String[] isprivateSupport = request.getParameterValues("isprivateSupportcon[]") == null ? null : request.getParameterValues("isprivateSupportcon[]");
            String visit = request.getParameter("visitid");
            int visitid = - 1;
            int orderid = -1;
            int vint = -1;
            // Boolean secpaid = Boolean.parseBoolean(secpay);
            //double amountpiad;
            try {
                visitid = Integer.parseInt(visit);
                orderid = Integer.parseInt(order);
            } catch (NumberFormatException e) {
                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../billing.jsp");
                return;
            }


            if (patid != null) {
                mgr.updateProcedureorders(orderid, amountpaid);
                mgr.updateProcedureorders(orderid, "Not Done");
                if (isprivateSupport != null) {
                    for (int r = 0; r < isprivateSupport.length; r++) {
                        double amount = request.getParameter("privatesupportcon" + isprivateSupport[r]) == null ? 0.0 : Double.parseDouble(request.getParameter("privatesupportcon" + isprivateSupport[r]));
                        mgr.updatePatientProcedure(Integer.parseInt(isprivateSupport[r]), amount, Boolean.TRUE);
                    }
                }
                if (secpay != null) {
                    for (int r = 0; r < secpay.length; r++) {
                        double amount = request.getParameter("secondarysupportcon" + secpay[r]) == null ? 0.0 : Double.parseDouble(request.getParameter("privatesupportcon" + isprivateSupport[r]));
                        mgr.updatePatientProcedure(Integer.parseInt(secpay[r]), Boolean.TRUE, amount);
                    }
                }
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Forwarded Successfully!");
                response.sendRedirect("../billing.jsp");
                return;
            }
            session.setAttribute("lasterror", "Please Try Again");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../billing.jsp");
            return;
        }
        if ("Outstanding Bills".equalsIgnoreCase(request.getParameter("action"))) {
            double payment = request.getParameter("extra_amount") == null ? 0.0 : Double.parseDouble(request.getParameter("extra_amount"));
            int visitid = request.getParameter("visitid") == null ? 0 : Integer.parseInt(request.getParameter("visitid"));
            double pp = mgr.getPatientBill(visitid).getTotalBill();
            double dt = mgr.getPatientBill(visitid).getAmountPaid() + payment;
            String status = "Debt";
            if ((pp - dt) < 0) {
                status = "Advance";
            }
            if ((pp - dt) == 0) {
                status = "Full";
            }
            mgr.updatePatientBills(visitid, pp, dt, status);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Forwarded Successfully!");
            response.sendRedirect("../outstandingbills.jsp");
            return;
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../billing.jsp");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>