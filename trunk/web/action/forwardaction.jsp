<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil,org.hibernate.Session,java.util.Date" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }

        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        sess.beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();
// DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        // if this is an appointment, go ahead and update appointment as honoured
        String appPatient = request.getParameter("appPatient") == null ? "" : request.getParameter("appPatient");
        //  System.out.println("app : " + appPatient);
        if (!appPatient.isEmpty()) {
            int appId = 0;
            Appoint appoint;
            try {
                appId = Integer.parseInt(appPatient);

                mgr.honorAppointment(appId);
            } catch (Exception e) {
                response.sendRedirect("../viewscheduled.jsp");
                return;
            }
        }


        if (request.getParameter("patientid") != null) {
            Patient p = mgr.getPatientByID(request.getParameter("patientid"));
            session.setAttribute("patient", p);
            response.sendRedirect("../index.jsp");
            return;
        }

        if ("forward".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("unitid");
            Patient p = (Patient) session.getAttribute("patient");
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String previous = mgr.getPatientFolder(patientid).getStatus();
            int type = -1;
            try {
                type = Integer.parseInt(request.getParameter("contype"));
            } catch (NumberFormatException e) {
                response.sendRedirect("../records.jsp");
                return;
            }
            if (patientid.equals("")) {
                response.sendRedirect("../records.jsp");
                return;
            }
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            Date date = new Date();

            String l = mgr.stepOverVisit(patientid, dateFormat.format(date));

            if (l.equalsIgnoreCase("Yes")) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Patient is Already Logged In!");
                response.sendRedirect("../records.jsp");
                return;
            }
            Consultation con = mgr.getConsultationId(type);
            Visitationtable visit = mgr.createNewVisit(patientid, "", "", unitName, "records", type, "");
            PatientBills bill = (PatientBills) mgr.addPatientBills(visit.getVisitid(), "Consultation Bill", p.getPatientid(), con.getAmount(), 0, "Not Paid", 0, 0, 0, 0, user.getStaffid());
            session.setAttribute("visit_id", "" + visit.getVisitid());
            String sponsorType = mgr.sponsorshipDetails(patientid).getType();
            String insuranceid = mgr.sponsorshipDetails(patientid).getSponsorid();
            Patient pt = mgr.getPatientByID(patientid);

            int lastid = pt.getLastClaimId() == null ? 0 : pt.getLastClaimId();
            mgr.updatePatientLastVisit(pt.getPatientid(), visit.getVisitid());

            Date lastVisit = null;
            int days = 0;
            int claimid = 0;
            int age = mgr.getAge(mgr.getPatientByID(patientid).getDateofbirth());
            List list = mgr.listClaimsWithType(sponsorType);
            if (list != null) {
                claimid = list.size() + 1;
            } else {
                claimid = 1;
            }

            //out.print("claimid " + claimid);
            if (sponsorType.equalsIgnoreCase("NHIS")) {
                if (pt.getLastVisitId() > 0) {
                    lastVisit = mgr.getVisitById(pt.getLastVisitId()).getDate();
                    days = mgr.countDaysBetween(lastVisit, visit.getDate());
                    if (lastid > 0) {
                        out.print(lastid);
                        Claimtable c = mgr.getClaim(lastid);
                        if (days < 8) {
                            if (c.getSecondVisit() != null) {
                                if (c.getThirdVisit() != null) {
                                    if (c.getFourthVisit() != null) {
                                        Claimtable claimtable = mgr.addClaim(sponsorType, claimid, visit.getVisitid(), patientid, "Pending", age, insuranceid);
                                        mgr.updatePatientLastClaimid(pt.getPatientid(), claimtable.getTableid());
                                    } else {
                                        mgr.updateClaim4thVisit(c.getTableid(), new Date(), visit.getVisitid());
                                    }
                                } else {
                                    mgr.updateClaim3rdVisit(c.getTableid(), new Date(), visit.getVisitid());
                                }
                            } else {
                                mgr.updateClaim2ndVisit(c.getTableid(), new Date(), visit.getVisitid());
                            }

                        } else {
                            Claimtable claimtable = mgr.addClaim(sponsorType, claimid, visit.getVisitid(), patientid, "Pending", age, insuranceid);
                            mgr.updatePatientLastClaimid(pt.getPatientid(), claimtable.getTableid());

                        }

                    } else {
                        Claimtable claimtable = mgr.addClaim(sponsorType, claimid, visit.getVisitid(), patientid, "Pending", age, insuranceid);
                        mgr.updatePatientLastClaimid(pt.getPatientid(), claimtable.getTableid());
                    }
                } else {
                    Claimtable claimtable = mgr.addClaim(sponsorType, claimid, visit.getVisitid(), patientid, "Pending", age, insuranceid);
                    mgr.updatePatientLastClaimid(pt.getPatientid(), claimtable.getTableid());
                }
            }
            if (sponsorType.equalsIgnoreCase("Private")) {
                Claimtable claimtable = mgr.addClaim(sponsorType, claimid, visit.getVisitid(), patientid, "Pending", age, insuranceid);
                mgr.updatePatientLastClaimid(pt.getPatientid(), claimtable.getTableid());
            }
            // mgr.updatePatientLastVisit(pt.getPatientid(), visit.getVisitid());


            out.print("age " + age);
            out.print("days " + days);
            System.out.println(unitName + "+++++++++++++++++++++++++++++++++++++++++");
            mgr.updateFolderLocation("records", unitName, patientid);
            Patientconsultation consultation = mgr.addPatientConsultation(visit.getVisitid(), type);
            
            //mgr.updatePatientBills(visit.getVisitid(), mgr.getConsultationId(consultation.getTypeid()).getAmount(), 0, "Not Paid");
            mgr.updateVisitTotalBill(visit.getVisitid(), con.getAmount());
            List<PatientBills> patientBills = mgr.listPatientBillByPatientid(patientid);
            if (patientBills != null) {
                
                for (PatientBills bills : patientBills) {
                    String dd = dateFormat.format(bills.getDate());
                    String dt = dateFormat.format(visit.getDate());
                    System.out.println("here at least "+dt+" "+dd);
                    if (dt.equalsIgnoreCase(dd)) {
                        
                        mgr.updatePatientBills(bills.getId(), visit.getVisitid());
                        mgr.updateVisitTotalBill(visit.getVisitid(), bills.getTotalBill());
                    }
                }
            }

            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", " Patient Forwarded Successfully!");
            response.sendRedirect("../records.jsp");
            return;

        }
        if ("dispensedrugs".equals(request.getParameter("action"))) {
            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String[] ptid = request.getParameterValues("dispensed[]") == null ? null : request.getParameterValues("dispensed[]");
            String visit = request.getParameter("visitid");
            String orderid = request.getParameter("orderid");

            int visitid = - 1;
            try {
                visitid = Integer.parseInt(visit);
            } catch (NumberFormatException e) {
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../pharmacy.jsp");
                return;
            }


            if (patientid != null) {
                // System.out.println(patientid);
                mgr.updateFolderLocation("dispensary", "records", patientid);
                mgr.updateVisitationStatus(visitid, "records", "dispensary");
                /*    if (copaid != null) {
                 for (int r = 0; r < copaid.length; r++) {
                 // double amount = request.getParameter("secondarysupportreg"+copaid[r])==null?0 : Double.parseDouble(request.getParameter("secondarysupportreg"+copaid[r]));
                 mgr.updatePatientTreatment(Integer.parseInt(copaid[r]), 0.0, Boolean.TRUE);
                 }
                 // response.sendRedirect("../readytodispensed.jsp");
                 }
                 if (isprivateSupport != null) {
                 for (int r = 0; r < isprivateSupport.length; r++) {
                 //double amount = request.getParameter("privatesupportreg"+isprivateSupport[r])==null?0 : Double.parseDouble(request.getParameter("privatesupportreg"+isprivateSupport[r]));
                 mgr.updatePatientTreatment(Integer.parseInt(isprivateSupport[r]), Boolean.TRUE, 0.0);
                 }
                 //response.sendRedirect("../pharmacy.jsp");
                 }
                 * 
                 * */
                if (ptid != null) {
                    mgr.updateDispensed(orderid, "Dispensed");
                    for (int r = 0; r < ptid.length; r++) {

                        //Patienttreatment patienttreatment = mgr.getPatientTreatment(Integer.parseInt(ptid[r]));
                        mgr.updatePatientTreatment(Integer.parseInt(ptid[r]), "Dispensed");
                        Patienttreatment patientTreatment = (Patienttreatment) mgr.getPatientTreatment(Integer.parseInt(ptid[r]));
                        // %%%%%        int itenQty = mgr.getTreatment(patientTreatment.getTreatmentid()).getQuantity() - patientTreatment.getQuantity();
                        // %%%%%       mgr.updateTreatmentQuantity(mgr.getTreatment(patientTreatment.getTreatmentid()).getBatchNumber(), itenQty);
                    }
                    session.setAttribute("class", "alert-success");
                    session.setAttribute("lasterror", "Treatment Dispensed Succesfully");
                    response.sendRedirect("../readytodispensed.jsp");
                    return;
                }
                /* if (afford != null) {
                 mgr.updateDispensed(orderid, "account");
                 double price = 0.0;

                 for (int r = 0; r < afford.length; r++) {

                 price = (mgr.getPatientTreatment(Integer.parseInt(afford[r])).getPrice() * mgr.getPatientTreatment(Integer.parseInt(afford[r])).getQuantity()) + price;
                 mgr.updatePatientTreatment(Integer.parseInt(afford[r]), "Afford", 0.0);
                 }
                 double pp = price + mgr.getPatientBill(visitid).getTotalBill();
                 double pd = mgr.getPatientBill(visitid).getAmountPaid();
                 mgr.updatePatientBills(visitid, pp, pd, "Debt");
                 response.sendRedirect("../pharmacy.jsp");
                 } 

                 session.setAttribute("lasterror", "Successfully forwarded");

                 return;*/
            }
            session.setAttribute("lasterror", "Error Occured Please Try Again");
            response.sendRedirect("../prescriptionorders.jsp");
            return;
            //String registrationDate = request.getParameter("dor");
        }

        if ("Forward".equals(request.getParameter("laboratory"))) {

            String patientid = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String id[] = request.getParameterValues("ids[]") == null ? null : request.getParameterValues("ids[]");
            String labid = request.getParameter("labid") == null ? "Laboratory" : request.getParameter("labid");
            //String[] results = request.getParameterValues("results[]") == null ? null : request.getParameterValues("results[]");
            String[] affords = request.getParameterValues("afford[]") == null ? null : request.getParameterValues("afford[]");

            String visit = request.getParameter("visitid");
            String loc = request.getParameter("from");

            int visitid = - 1;
            int orderid = -1;
            try {
                visitid = Integer.parseInt(visit);
                orderid = Integer.parseInt(labid);
            } catch (NumberFormatException e) {
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../laboratory.jsp");
                return;
            }

            //  int pid =  - 1;

            try {
                String prev = mgr.getVisitById(visitid).getPreviouslocstion();
                String[] prevs = prev.split("_");
                String status = "";
                System.out.println("id : " + id);
                System.out.println("ids length : " + id.length);
                // laboratory
                if (affords != null) {
                    out.print(affords.length);
                    for (int r = 0; r < affords.length; r++) {
                        //Patienttreatment patienttreatment = mgr.getPatientTreatment(Integer.parseInt(ptid[r]));
                        String result = request.getParameter("results" + id[r]) == "" ? "" : request.getParameter("results" + id[r]);
                        String concen = request.getParameter("concentration" + id[r]) == "" ? "" : request.getParameter("concentration" + id[r]);
                        String rnge = request.getParameter("range" + id[r]) == "" ? "" : request.getParameter("range" + id[r]);
                        String notes = request.getParameter("comment" + id[r]) == "" ? "" : request.getParameter("comment" + id[r]);

                        mgr.updatePatientInvestigation(Integer.parseInt(id[r]), result, concen, rnge, "Performed", notes, 0.0);
                        // mgr.updateLaborders(1, "",new Date());
                    }


                }
                session.setAttribute("lasterror", "Successfully forwarded");
                response.sendRedirect("../laboratory.jsp");
                return;
            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../laboratory.jsp");
                return;
            }
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            session.setAttribute("lasterror", "Please try again");
            response.sendRedirect("../laboratory.jsp");
            return;
        } else {
            session.setAttribute("lasterror", "Please try again");
            response.sendRedirect("../laboratory.jsp");
            return;
        }
    }%>