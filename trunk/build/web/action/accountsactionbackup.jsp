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
            int cardBillId = 0;
            int registrationBillId = 0;
            int consultationBillId = 0;
            if (cardBillString != ""){
                cardBillId = Integer.parseInt(cardBillString);
                
            }
            
            if (registrationBillString != ""){
                registrationBillId = Integer.parseInt(registrationBillString);
            }
            
            if (consultationBillString != ""){
                consultationBillId = Integer.parseInt(consultationBillString);
            }
            
            
            
            String regFee = request.getParameter("regFee");
            //String copay = request.getParameter("copaid");

            System.out.println("regFee : " + regFee);
            RegFee rFee = null;
            List curRFees;
            int rFeeId = 0;
            PatientRegistration pRegg = null;
            // PatientBills bills = mgr.getPatientBill(vi)
            if (regFee != null) {
                boolean copay = request.getParameter("copaidreg") == null ? Boolean.FALSE : Boolean.TRUE;
                boolean isprivateSupportReg = request.getParameter("isprivateSupportreg") == null ? Boolean.FALSE : Boolean.TRUE;
                double privatesupportReg = request.getParameter("privatesupportreg") == "" ? 0.0 : Double.parseDouble(request.getParameter("privatesupportreg"));
                double secondarysupportReg = request.getParameter("secondarysupportreg") == "" ? 0.0 : Double.parseDouble(request.getParameter("secondarysupportreg"));
                String session_id = (String) session.getAttribute("visit_id");
                System.out.println("Session Id: " + session_id);
                int sessionid = Integer.parseInt(session_id);
                PatientBills patientBills = mgr.getPatientBill(sessionid);
                if (!regFee.isEmpty()) {
                    String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
                    System.out.println("patientid : " + patientid);
                    curRFees = mgr.listCurrentRegFee("Yes");
                    if (!curRFees.isEmpty()) {
                        rFee = (RegFee) curRFees.get(0);
                        if (rFee != null) {
                            rFeeId = rFee.getId();

                            List registration = mgr.getPatientReg(patientid);

                            if (registration != null && registration.size() > 0) {
                                pRegg = (PatientRegistration) registration.get(0);

                                if (pRegg != null) {
                                    mgr.updatePatientRegistration(pRegg.getRegId(), Boolean.TRUE,
                                            Double.parseDouble(regFee), new java.sql.Date(new java.util.Date().getTime()), rFeeId, copay, isprivateSupportReg, secondarysupportReg, privatesupportReg);
                                    mgr.updatePatientBills(patientBills.getVisitid(), Double.parseDouble(regFee), Double.parseDouble(regFee), "Full");
                                }
                            }

                        }
                    }
                }
            }

            double amountpaid = request.getParameter("amountpaid") == "" ? 0.0 : Double.parseDouble(request.getParameter("amountpaid"));
            String status = request.getParameter("status") == "" ? "unpaid" : request.getParameter("status");
            String patid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String uame = request.getParameter("unitid") == null ? "Accounts" : request.getParameter("unitid");
            String vis = request.getParameter("cid");

            boolean secpay = request.getParameter("copay") == null ? Boolean.FALSE : Boolean.TRUE;
            boolean isprivateSupport = request.getParameter("isprivateSupportcon") == null ? Boolean.FALSE : Boolean.TRUE;
            double privatesupport = request.getParameter("privatesupportcon") == "" ? 0.0 : Double.parseDouble(request.getParameter("privatesupportcon"));
            double secondarysupport = request.getParameter("secondarysupportcon") == "" ? 0.0 : Double.parseDouble(request.getParameter("secondarysupportcon"));
            String vid = request.getParameter("visitid");
            String status1 = "Debt";
            int visid = - 1;
            int vint = -1;

            // Boolean secpaid = Boolean.parseBoolean(secpay);
            //double amountpiad;
            try {
                visid = Integer.parseInt(vis);
                vint = Integer.parseInt(vid);
            } catch (NumberFormatException e) {
                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../billing.jsp");
                return;
            }


            if (patid != null) {
                System.out.println(visid);
                PatientBills bills = mgr.getPatientBill(vint);
                double total = bills.getTotalBill();
                mgr.updatePatientConsultation(visid, amountpaid, status, secpay, isprivateSupport, secondarysupport, privatesupport);
                if (((bills.getTotalBill()) - amountpaid) < 0) {
                    status1 = "Advance";
                }
                if (((bills.getTotalBill()) - amountpaid) == 0) {
                    status1 = "Full";
                }
                mgr.updatePatientBills(bills.getVisitid(), total, amountpaid, status1);
                mgr.updateFolderLocation("account", uame, patid);
                mgr.updateVisitationStatus(vint, uame, "account");
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