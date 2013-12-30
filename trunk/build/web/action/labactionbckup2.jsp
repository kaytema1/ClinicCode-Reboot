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



        // 1. Save New Labs : labpatientsearch.jsp
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
                int toadd = lst.size() + 1;
                String orderid = y + "DML" + toadd;
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

                    mgr.addPatientInvestigation(patientid, "CODE", Integer.parseInt(investigationcode[1]), "", Double.parseDouble(investigationcode[0]), id, formatter.format(date), "No", investigationnote, 0, laborder.getOrderid());
                    invId = Integer.parseInt(investigationcode[1]);

                    subInvsList = mgr.listSubInvUnderMainInv(invId);
                    System.out.println(".ssze  : " + subInvsList.size());
                    if (!subInvsList.isEmpty()) {
                        System.out.println("not empty at all !!!");
                        for (int p = 0; p < subInvsList.size(); p++) {
                            subInv = (Investigation) subInvsList.get(p);
                            mgr.addPatientInvestigation(patientid, "CODE", subInv.getDetailedInvId(), "", 0.0, id, formatter.format(date), "No", investigationnote, 0, orderid);
                        }
                    }
                    //}
                }
                redirect = "../detailrequest.jsp?labid=" + laborder.getOrderid() + "&patientid=" + patientid;
                /*if (mgr.sponsorshipDetails(patientid).getType().equalsIgnoreCase("CASH")) {
                 redirect = "../detailrequest.jsp";
                 }*/

                session.setAttribute("lasterror", "Forwarded Successfully");
                response.sendRedirect(redirect);
                return;
            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../labreception.jsp");
                return;
            }
        }



        // 2. Saving Payment Made!
        
        if ("actionforward".equals(request.getParameter("action"))) {
            String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");
            String patient = request.getParameter("patient") == null ? "" : request.getParameter("patient");
            String amountpaid = request.getParameter("amountpaid") == null ? "0.0" : request.getParameter("amountpaid");
            String useme = request.getParameter("useme") == null ? "0.0" : request.getParameter("useme");
            //double 
            List list = mgr.patientInvestigationByOrderId(labid);
            if (list != null) {
                for (int r = 0; r < list.size(); r++) {
                    Patientinvestigation patientinvestigation = (Patientinvestigation) list.get(r);
                    if (patientinvestigation.isCopaid()) {
                        mgr.updatePatientInvestigation(patientinvestigation.getId(), Boolean.TRUE, Double.parseDouble(request.getParameter("secondarysupport" + patientinvestigation.getId())));

                    }
                    if (patientinvestigation.isIsPrivate()) {
                        mgr.updatePatientInvestigation(patientinvestigation.getId(), Double.parseDouble(request.getParameter("privatesupport" + patientinvestigation.getId())), Boolean.TRUE);
                    }
                    mgr.updatePatientInvestigationPayment(patientinvestigation.getId());

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
            response.sendRedirect("../labreception.jsp");
        }
        
        
        //3. Updating status to Forward to Main Laboratory
        
        if ("phlembotomy".equals(request.getParameter("action"))) {

            String labid = request.getParameter("labid") == null ? "" : request.getParameter("labid");
            mgr.updateLabordersStatus(labid, new Date(), "Not Done");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Forwarded Successfully");
            response.sendRedirect("../phlembotomy.jsp");
            return;
        }
        
        
        
        //4. Main Laboratory Saving Activity
        
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
            if (affords.length < size) {
                status = "Incomplete";
            }
            try {
                mgr.updateLabordersStatus(labid, new Date(), status);
                System.out.println("id : " + id);
                System.out.println("ids length : " + id.length);
                // laboratory
                if (affords != null) {
                    out.print(affords.length);
                    for (int r = 0; r < affords.length; r++) {


                        //Patienttreatment patienttreatment = mgr.getPatientTreatment(Integer.parseInt(ptid[r]));
                        String result = request.getParameter("results" + affords[r]) == "" ? "" : request.getParameter("results" + affords[r]);
                        String concen = request.getParameter("concentration" + affords[r]) == "" ? "" : request.getParameter("concentration" + affords[r]);
                        String rnge = request.getParameter("range" + affords[r]) == "" ? "" : request.getParameter("range" + affords[r]);
                        String notes = request.getParameter("comment" + affords[r]) == "" ? "" : request.getParameter("comment" + affords[r]);

                        System.out.println("result : " + result);
                        int incomingPatInvId = Integer.parseInt(id[r]);
                        patInv = mgr.getPatientInvById(incomingPatInvId);

                        if (mgr.listSubInvUnderMainInv(patInv.getInvestigationid()).isEmpty()) {

                            if (request.getParameter("results" + affords[r]).equalsIgnoreCase("")) {
                                mgr.updatePatientInvestigation(Integer.parseInt(affords[r]), result, concen, rnge, "Pending", notes, 0.0);
                            } else {
                                mgr.updatePatientInvestigation(Integer.parseInt(affords[r]), result, concen, rnge, "Performed", notes, 0.0);
                            }
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
                                List details = mgr.getDetRefRangeByDetInvId(investigation.getDetailedInvId());
                                for (int y = 0; y < details.size(); y++) {
                                    RefRangeDet rangeDet = (RefRangeDet) details.get(y);
                                    if (Integer.parseInt(rangeDet.getDetFrom()) < age && Integer.parseInt(rangeDet.getDetTo()) > age) {
                                        int archiveid = investigation.getDetailedInvId();
                                        int detailedid = investigation.getDetailedInvId();
                                        String detfrom = rangeDet.getDetFrom();
                                        String detto = rangeDet.getDetTo();
                                        String fupper = rangeDet.getFUpper();
                                        String flower = rangeDet.getFLower();
                                        String mupper = rangeDet.getMUpper();
                                        String mlower = rangeDet.getMLower();
                                        System.out.println("ArchiveDetRefRange +++++++++++++++++++++++++++++++++");
                                        mgr.archiveDetailedRefRange(detailedid, detfrom, detto, mlower, mupper, flower, fupper, labid, patInv.getId());
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
                                     System.out.println("UniversalDetRefRange +++++++++++++++++++++++++++++++++");
                                    mgr.archivedUniversalRefRange(detid, selected, lower, upper, paragraphic, labid, aid);
                                }
                            }
                        }





                    }
                    session.setAttribute("lasterror", "Successfully forwarded");
                    response.sendRedirect("../laboratory_n.jsp");
                    return;

                }

            } catch (NullPointerException e) {
                e.printStackTrace();
                session.setAttribute("lasterror", "Please try again");
                response.sendRedirect("../laboratory_n.jsp");
                return;
            }

        }
        








    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>
    
    
    
    