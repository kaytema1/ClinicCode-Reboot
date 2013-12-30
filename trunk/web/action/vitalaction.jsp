<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil,org.hibernate.Session,java.util.Date" %>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");

        }
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        sess.beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();

        if ("Forward".equals(request.getParameter("action"))) {
            int visitid = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
            String vital = request.getParameter("vitals") == "" ? "No symptom stated" : request.getParameter("vitals");
            String temperature = request.getParameter("temp") == "" ? "0.0" : request.getParameter("temp");
            String weight = request.getParameter("weight") == "" ? "0.0" : request.getParameter("weight");
            String height = request.getParameter("height") == "" ? "0.0" : request.getParameter("height");
            String systolic = request.getParameter("systolic") == "" ? "0.0" : request.getParameter("systolic");
            String diatolic = request.getParameter("diatolic") == "" ? "0.0" : request.getParameter("diatolic");
            String pulse = request.getParameter("pulse") == "" ? "0.0" : request.getParameter("pulse");
            String forward = request.getParameter("conroom") == "" ? "Room 1" : request.getParameter("conroom");
            String bptype = request.getParameter("bptype");
            int conditionId = 0;
            int onsetId = 0;
            int reliefId = 0;

            String conditions[] = request.getParameterValues("conditions") == null ? null : request.getParameterValues("conditions");
            String conditionnote = request.getParameter("conditionnote") == null ? "" : request.getParameter("conditionnote");
            String onsets[] = request.getParameterValues("onsets") == null ? null : request.getParameterValues("onsets");
            String onsetnote = request.getParameter("onsetnote") == null ? "" : request.getParameter("onsetnote");
            String reliefs[] = request.getParameterValues("reliefs") == null ? null : request.getParameterValues("reliefs");
            String reliefnote = request.getParameter("reliefnote") == null ? "" : request.getParameter("reliefnote");


            String[] symptoms = request.getParameterValues("symptoms") == null ? null : request.getParameterValues("symptoms");
            String[] allergies = request.getParameterValues("allergies") == null ? null : request.getParameterValues("allergies");
            String symptomnote = request.getParameter("symptomnote") == null ? "" : request.getParameter("symptomnote");
            String[] procedures = request.getParameterValues("procedures") == null ? null : request.getParameterValues("procedures");

            String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
            String id = request.getParameter("id") == null ? "" : request.getParameter("id");
            System.out.println("content " + id);
            String content = "" + temperature + "-" + weight + "-" + height + "-" + systolic + ":" + diatolic + "-" + pulse + "-" + vital + "";
            if (patientid.equalsIgnoreCase("") || id.equalsIgnoreCase("")) {
                session.setAttribute("lasterror", "Vitals could not be saved, Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../vital.jsp");
                return;
            }
            if (symptoms != null) {
                for (int index = 0; index < symptoms.length; index++) {
                    String sym = symptoms[index];
                    String[] syms = sym.split("><");
                    mgr.addVisitSymptoms(Integer.parseInt(id), patientid, Integer.parseInt(syms[1]), symptomnote);
                }
            }
            if (allergies != null) {
                for (int index = 0; index < allergies.length; index++) {
                    String sym = allergies[index];
                    String[] syms = sym.split("><");
                    mgr.addPatientAllergiess(patientid, Integer.parseInt(syms[1]));
                }
            }
            if (procedures != null) {
                double total = 0.0;
                Procedureorders procedureorders = mgr.addProcedureOrder(Integer.parseInt(id), patientid, 0.0, current.getStaffid());
                for (int index = 0; index < procedures.length; index++) {
                    String sym = procedures[index];
                    String[] syms = sym.split("><");
                    total = total + Double.parseDouble(syms[2]);
                    mgr.updateProcedureordersTotal(procedureorders.getOrderid(), total);
                    mgr.addPatientProcedure(patientid, syms[1], procedureorders.getOrderid());
                    
                }
                PatientBills bills = (PatientBills) mgr.addPatientBills(0,"Procedure Bill", patientid, total , 0, "Not-Paid", 0, 0, 0, 0, current.getStaffid());
            
            }
            if (conditions != null) {

                for (int i = 0; i < conditions.length; i++) {

                    conditionId = Integer.parseInt(conditions[i]);
                    if (conditionId > 0) {
                        
                        NursesPatientConditions patientCondition = mgr.addNursesPatientCondition(conditionId, patientid, visitid, current.getStaffid());
                        //System.out.println(patientCondition.getConditionId());
                    }
                }

            }

            if (conditionnote != "") {
                NursesPatientConditionNotes patientConditionNote = mgr.addNursesPatientConditionNote(conditionnote, patientid, visitid, current.getStaffid());
            }

            if (onsets != null) {

                for (int i = 0; i < onsets.length; i++) {

                    onsetId = Integer.parseInt(onsets[i]);
                    if (onsetId > 0) {
                        NursesPatientOnsets patientOnset = mgr.addNursesPatientOnsets(onsetId, patientid, visitid,current.getStaffid());
                    }
                }

            }

            if (onsetnote != "") {
                NursesPatientOnsetNotes patientOnsetNote = mgr.addNursesPatientOnsetNote(onsetnote, patientid, visitid,current.getStaffid());
            }

            if (reliefs != null) {

                for (int i = 0; i < reliefs.length; i++) {

                    reliefId = Integer.parseInt(reliefs[i]);
                    if (reliefId > 0) {
                        NursesPatientReliefs patientRelief = mgr.addNursesPatientRelief(reliefId, patientid, visitid, current.getStaffid() );
                    }
                }

            }

            if (reliefnote != "") {
                NursesPatientReliefNotes patientReliefNote = mgr.addNursesPatientReliefNote(reliefnote, patientid, visitid,current.getStaffid());
            }


            double temp = Double.parseDouble(temperature);
            double wt = Double.parseDouble(weight);
            double ht = Double.parseDouble(height);
            double sys = Double.parseDouble(systolic);
            double dia = Double.parseDouble(diatolic);
            double pul = Double.parseDouble(pulse);
            mgr.addVitals(Integer.parseInt(id), patientid, temp, wt, ht, sys, dia, pul, vital);
            mgr.updateVisitation(patientid, Integer.parseInt(id), forward, "account");

            mgr.updateFolderLocation("account", forward, patientid);

            mgr.addNursingTableVitals(Integer.parseInt(id), current.getStaffid(), "doc", new java.util.Date());

            session.setAttribute("lasterror", "Vital Successfully Saved!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../opd.jsp");
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>