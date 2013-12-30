<%-- 
    Document   : prescriptionaction
    Created on : Nov 8, 2013, 4:30:33 AM
    Author     : emmanueladdo-yirenkyi
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        TransactionEntityManager mg = new TransactionEntityManager();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        Date date = new Date();


        if ("approveprescription".equalsIgnoreCase(request.getParameter("action"))) {
            String approvedOrder = request.getParameter("orderid");
            String status = request.getParameter("status");
            String overalltotal = request.getParameter("overalltotal");
            String approvedPrescriptions[] = request.getParameterValues("afford[]");
            Patienttreatment p = new Patienttreatment();
            DispensaryBatch db = new DispensaryBatch();
            DispensaryItems di = new DispensaryItems();
            GeneralStockMovement generalStockMovement = new GeneralStockMovement();
            //double total = 0.0;
            
            if (approvedOrder != "") {

                if (approvedPrescriptions != null) {
                    if (approvedPrescriptions.length > 0) {

                        for (int x = 0; x < approvedPrescriptions.length; x++) {
                            String prescriptionId = approvedPrescriptions[x];
                            int prescripId = Integer.parseInt(prescriptionId);
                            String batch = request.getParameter("batch" + prescriptionId);
                            System.out.println("tetsting where "+batch);
                            DispensaryBatch dispensaryBatch = (DispensaryBatch) mg.getStringObject(db, batch);
                            //DispensaryItems dispensaryItems = (DispensaryItems) mg.getStringObject(di, dispensaryBatch.getDispensaryItems().getItemCode());
                            DispensaryItems dispensaryItems = dispensaryBatch.getDispensaryItems();
                            //dispensaryBatch.setQuantityOnHand(dispensaryBatch.getQuantityOnHand()-);
                            String pricePiece = request.getParameter("priceduepiece" + prescriptionId);
                            String amountduepiece = request.getParameter("amountduepiece" + prescriptionId);
                            Patienttreatment patienttreatment = (Patienttreatment) mg.getIntegerObject(p, prescripId);
                            patienttreatment.setPrice(Double.parseDouble(pricePiece));
                            patienttreatment.setTotal(Double.parseDouble(amountduepiece));
                            // total = total + Double.parseDouble(amountduepiece);
                            patienttreatment.setDispensed("Approved");

                            dispensaryBatch.setQuantityOnHand(dispensaryBatch.getQuantityOnHand() - patienttreatment.getQuantity());
                            dispensaryBatch.setValueOnHand(dispensaryBatch.getValueOnHand() - Double.parseDouble(overalltotal));

                            dispensaryItems.setQuantityOnHand(dispensaryItems.getQuantityOnHand() - patienttreatment.getQuantity());
                            //dispensaryItems.set(dispensaryItems.set);

                            generalStockMovement.setDateOfMovement(new Date());
                            generalStockMovement.setDispensaryBatch(dispensaryBatch);
                            generalStockMovement.setQuantityAfterTransfer(dispensaryBatch.getQuantityOnHand() - patienttreatment.getQuantity());
                            generalStockMovement.setQuantityB4Transfer(dispensaryBatch.getQuantityOnHand());
                            generalStockMovement.setQuantityTransferred(patienttreatment.getQuantity());
                            generalStockMovement.setReason("Dispensary Sales");
                            generalStockMovement.setStafftableByIssuedBy(mgr.getStafftableByid(user.getStaffid()));

                            PatientTreatmentBatch treatmentBatch = new PatientTreatmentBatch();
                            treatmentBatch.setPatienttreatment(patienttreatment);
                            treatmentBatch.setDispensaryBatch(dispensaryBatch);
                            mg.update(patienttreatment);
                            mg.save(treatmentBatch);
                            mg.update(dispensaryBatch);
                            mg.update(dispensaryItems);
                            Patienttreatment pat = mgr.updatePatientTreatment(prescripId, "Approved");

                        }


                    }
                    Pharmorder pharmorder = null;
                    TransitionOrder order = new TransitionOrder();
                    if (status.equalsIgnoreCase("BOTH")) {
                        pharmorder = mgr.updateDispensed(approvedOrder, "Approved");
                        pharmorder.setTotalAmount(Double.parseDouble(overalltotal));
                        mg.update(pharmorder);
                        order.setStatus("Pharmacy");
                        order.setPatientId(pharmorder.getPatientid());
                        order.setPharmorder(pharmorder);
                        order.setDateOfOrder(new Date());
                        TransitionOrder pharmacy = (TransitionOrder) mg.save(order);
                        List<Patienttreatment> patientTreatses = mg.listObjects("from Patienttreatment where orderid='" + approvedOrder + "'");
                        for (Patienttreatment p1 : patientTreatses) {
                            if(p1.getDispensaryItems()==null){
                            p1.setTransitionOrder(pharmacy);
                            mg.update(p1);}
                        }
                       // mg.save(pharmorder);
                        /* List l = mg.listObjects("from TransitionOrder");
                         String order = "T" + l.size() + 1;
                         Pharmacyorder pharmacyorder = new Pharmacyorder();
                         pharmacyorder.setOrderId(order);
                         pharmacyorder.setDate(new Date());
                         pharmacyorder.setOutstandingAmount(0.0);
                         pharmacyorder.setRequestedBy(pharmorder.getFromdoc());
                         pharmacyorder.setTotalCost(Double.parseDouble(overalltotal));
                         pharmacyorder.setAmountPaid(0.0);
                         mg.save(pharmacyorder);*/
                    }
                    if (status.equalsIgnoreCase("NON")) {
                        pharmorder = mgr.updateDispensed(approvedOrder, "Approved");
                        pharmorder.setTotalAmount(Double.parseDouble(overalltotal));
                        mg.update(pharmorder);
                    }
                    if (status.equalsIgnoreCase("CREATE")) {
                        /*List l = mg.listObjects("from Pharmacyorder");
                         String order = "PHY" + l.size() + 1;
                         Pharmacyorder pharmacyorder = new Pharmacyorder();
                         pharmacyorder.setOrderId(order);
                         pharmacyorder.setDate(new Date());
                         pharmacyorder.setOutstandingAmount(0.0);
                         pharmacyorder.setRequestedBy(pharmorder.getFromdoc());
                         pharmacyorder.setTotalCost(Double.parseDouble(overalltotal));
                         pharmacyorder.setAmountPaid(0.0);*/
                        order.setStatus("Pharmacy");
                        order.setPatientId(pharmorder.getPatientid());
                        //order.setPharmorder(approvedOrder);
                        order.setDateOfOrder(new Date());
                        TransitionOrder pharmacy = (TransitionOrder) mg.save(order);
                        List<Patienttreatment> patientTreatses = mg.listObjects("from Patienttreatment where orderid='" + approvedOrder + "'");
                        for (Patienttreatment p1 : patientTreatses) {
                            p1.setTransitionOrder(pharmacy);
                            mg.update(p1);
                        }
                        //mg.save(pharmorder);
                    }

                }
                session.setAttribute("lasterror", "Prescription Order Updated Successfully");
                session.setAttribute("class", "alert-success");
                response.sendRedirect("../prescriptionorders.jsp");
                return;
            }
            session.setAttribute("lasterror", "Error Occured, Please Try Again");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../prescriptionorders.jsp");
            return;
        }



        if ("dispensingbillpayment".equalsIgnoreCase(request.getParameter("action"))) {
            String pharmOrderId = request.getParameter("orderid") == null ? "" : request.getParameter("orderid");
            String patientId = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
            String amountpaid = request.getParameter("amountpaidinput") == null ? "0.0" : request.getParameter("amountpaidinput");
            String amountdue = request.getParameter("amountdueinput") == null ? "0.0" : request.getParameter("amountdueinput");

            Pharmorder pharmOrder = (Pharmorder) mgr.getPharmorder(pharmOrderId);
            String orderid = "";
            if (pharmOrder != null) {
                orderid = pharmOrder.getOrderid();
            }
            boolean secSponsorFound = true;
            boolean hasMultipleSponsors = false;

            String primarySponsorValue = "0.0";
            String secondarySponsorValue = "0.0";
            String outOfPocketValue = "0.0";

            double primarySponsorAmnt;
            double secSponsorAmnt;
            double outOfPocketAmnt;
            int curPatTreatId;
            Sponsorhipdetails patientSponsors = mgr.sponsorshipDetails(patientId);
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
            List list = mgr.listPatientTreatmentsByOrderid(pharmOrder.getOrderid());
            // ----->
            if (list != null) {
                for (int r = 0; r < list.size(); r++) {
                    amntPaid = 0;
                    Patienttreatment patTreat = (Patienttreatment) list.get(r);
                    curPatTreatId = patTreat.getTreatmentid();
                    // System.out.println("patientinvestigation id : " + patientinvestigation.getInvestigationid());
                    // curPatientInvId = patientinvestigation.getInvestigationid();
                   /* if (patientinvestigation.isCopaid()) {
                     mgr.updatePatientInvestigation(patientinvestigation.getId(), Boolean.TRUE, Double.parseDouble(request.getParameter("secondarysupport" + patientinvestigation.getId())));
                     }
                     if (patientinvestigation.isIsPrivate()) {
                     mgr.updatePatientInvestigation(patientinvestigation.getId(), Double.parseDouble(request.getParameter("privatesupport" + patientinvestigation.getId())), Boolean.TRUE);
                     }
                
                     */
                    if (hasMultipleSponsors) {
                        primarySponsorValue = request.getParameter(curPatTreatId + "_primarysponsor_" + primarySponsorId) == null ? "0.0" : request.getParameter(curPatTreatId + "_primarysponsor_" + primarySponsorId);
                        System.out.println("primarysponsorvalue is : " + primarySponsorValue);

                        if (secSponsorFound) {
                            secondarySponsorValue = request.getParameter(curPatTreatId + "_secondarysponsor_" + secSponsorId) == null ? "0.0" : request.getParameter(curPatTreatId + "_secondarysponsor_" + secSponsorId);
                        }
                        outOfPocketValue = request.getParameter(curPatTreatId + "_outofpocket") == null ? "0.0" : request.getParameter(curPatTreatId + "_outofpocket");
                        System.out.println(curPatTreatId + "_primarysponsor_" + primarySponsorId + " gave us " + primarySponsorValue);
                        System.out.println(curPatTreatId + "_secondarysponsor_" + secSponsorId + " gave us " + secondarySponsorValue);
                        System.out.println(curPatTreatId + "_outofpocket gave us " + outOfPocketValue);

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
                                po.setTransactionId(pharmOrderId);
                                po.setTransactionType("Dispensary Payment");
                                po.setItemId(curPatTreatId + "");
                                po.setPrimarySponsorId(primarySponsorId);
                                po.setPrimarySponsorAmount(primarySponsorAmnt);
                                po.setSecSponsorId(secSponsorId);
                                po.setSecSponsorAmount(secSponsorAmnt);
                                po.setOutOfPocketId((11 + ""));
                                po.setOutOfPocketAmount(outOfPocketAmnt);
                                po.setDatePaid(mgr.getCurrentDate());
                                po.setTimePaid(mgr.getCurrentTime());
                                po.setStaffId(user.getStaffid());
                                po.setPatientId(patientId);
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
            if (mgr.sponsorshipDetails(patientId).getType().equalsIgnoreCase("CASH")) {
                if (Double.parseDouble(amountpaid) >= Double.parseDouble(amountdue)) {
                    //mgr.updateLaborders(labid, Double.parseDouble(amountdue), Double.parseDouble(amountpaid), 0.0);
                    mgr.updatePharmorderStatus(orderid, date, "Settled");
                    mgr.updatePharmorder(orderid, Double.parseDouble(amountdue), Double.parseDouble(amountpaid), 0.0);
                } else {
                    mgr.updatePharmorderStatus(orderid, date, "Outstanding");
                    mgr.updatePharmorder(orderid, Double.parseDouble(amountdue), Double.parseDouble(amountpaid), (Double.parseDouble(amountdue) - Double.parseDouble(amountpaid)));
                }
                mgr.updatePharmorderReceivedBy(orderid, user.getStaffid());
                
            } else {
                mgr.updatePharmorder(orderid, Double.parseDouble(amountdue), Double.parseDouble(amountdue), 0.0);


                mgr.updatePharmorderReceivedBy(orderid, user.getStaffid());
                mgr.updatePharmorderStatus(orderid, date, "Settled");
            }


            if (!hasMultipleSponsors) {

                try {
                    amntPaid = Double.parseDouble(amountpaid);
                    System.out.println("amntPaid : " + amntPaid);
                } catch (Exception e) {
                    amntPaid = 0;
                }

                if (amntPaid > 0) {
                    
                    
                    System.out.println("in here");
                    PaymentObject po = new PaymentObject();
                    po.setTransactionId(pharmOrderId);
                    po.setTransactionType("Dispensary Payment");
                    po.setOutOfPocketId((11 + ""));
                    po.setOutOfPocketAmount(amntPaid);
                    po.setDatePaid(mgr.getCurrentDate());
                    po.setTimePaid(mgr.getCurrentTime());
                    po.setStaffId(user.getStaffid());
                    po.setPatientId(patientId);
                    po.setStatus("status");
                    po.setTotalAmountPaid(amntPaid);
                    
                    mgr.addPaymentObject(po);
                }
            } else {
                System.out.println("out here");
            }
            response.sendRedirect("../billing.jsp");
        }




    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>