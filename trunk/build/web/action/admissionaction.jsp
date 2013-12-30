<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
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

        if ("dosagemeter".equals(request.getParameter("value"))) {
            String id = request.getParameter("id") == null ? "" : request.getParameter("id");
            String morning = request.getParameter("morning") == null ? "" : request.getParameter("morning");
            String afternoon = request.getParameter("afternoon") == null ? "" : request.getParameter("afternoon");
            String evening = request.getParameter("evening") == null ? "" : request.getParameter("evening");
            int visitid = request.getParameter("visitid") == null ? 0 : Integer.parseInt(request.getParameter("visitid"));
            int ptmentid = request.getParameter("treamentid") == null ? 0 : Integer.parseInt(request.getParameter("treamentid"));
            // HMSHelper mgr = new HMSHelper();

            out.print(id + "" + morning + "" + afternoon + "" + evening + "" + visitid + "" + ptmentid);
            int did = -1;

            try {
                did = Integer.parseInt(id);
                // wardName = request.getParameter("name");
                //Dosagemonitor dmonitor = mgr.updateDosage(did, morning, afternoon, evening, ptmentid, visitid, new Date());

            } catch (NumberFormatException e) {
                // out.print(e.getMessage());
                out.print("Error, Please Again");
                return;

            } catch (NullPointerException e) {
                out.print("Error, Please Again");
                // out.print(e.getMessage());
                return;
            }

            out.print("Successfully Updated");
            return;
        }

        if ("treatments".equals(request.getParameter("value"))) {

            //String[] id = request.getParameterValues("select[]") == null ? new String[0] : request.getParameterValues("select[]");
            String prescription = request.getParameter("prescription") == null ? "" : request.getParameter("prescription");
            int visitid = request.getParameter("visitid") == null ? 0 : Integer.parseInt(request.getParameter("visitid"));
            String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
            String[] treatments = request.getParameterValues("select[]") == null ? null : request.getParameterValues("select[]");

            int qty = -1;
            Date date = new Date();
            DateFormat formatter;
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            if (visitid == 0) {
                out.print("Error, Please Again");
                return;
            }
            //visitid  = -1;

            try {
                //visitid = Integer.parseInt(request.getParameter(id));
                // out.print(treatments.length);
                for (int i = 0; i < treatments.length; i++) {
                    String[] treatmentcode = treatments[i].split("><");

                    try {
                        qty = Integer.parseInt(treatmentcode[3]);
                    } catch (NumberFormatException e) {
                        qty = 0;
                    }

                    // mgr.addDosageMonitor(visitid, Integer.parseInt(treatmentcode[1]), "", "", "", null);

                }
                out.print("Successfully Added");
                return;

            } catch (NumberFormatException e) {
                out.print("Error, Please Again");
                return;

            } catch (NullPointerException e) {
                out.print("Error, Please Again");
                return;
            }
            // out.print(id.length);

        }

        if ("investigations".equals(request.getParameter("value"))) {

            //String[] id = request.getParameterValues("select[]") == null ? new String[0] : request.getParameterValues("select[]");
            String investigationnotes = request.getParameter("investigation") == null ? "" : request.getParameter("investigation");
            int visitid = request.getParameter("visitid") == null ? 0 : Integer.parseInt(request.getParameter("visitid"));
            String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
            String[] investigations = request.getParameterValues("select[]") == null ? null : request.getParameterValues("select[]");

            //HMSHelper mgr = new HMSHelper();
            int qty = -1;
            Date date = new Date();
            DateFormat formatter;
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            if (visitid == 0) {
                out.print("Error, Please Again");
                return;
            }
            List lst = mgr.listLaborders();
            String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
            String y = yr.substring(2);
            int toadd = lst.size() + 1;
            String orderid = y + "DML" + toadd;
            //visitid  = -1;

            try {
                //visitid = Integer.parseInt(request.getParameter(id));
                // out.print(treatments.length);
                for (int i = 0; i < investigations.length; i++) {
                    String[] investigationcode = investigations[i].split("><");
                    //call get treatmentbyCode to retrieve item price
                    // mgr.addPatientTreatment(patientid, investigationcode[1], investigationcode[0], "", 0.0, "", id, formatter.format(date));
                    mgr.addPatientInvestigation(patientid, "CODE", Integer.parseInt(investigationcode[1]), "", mgr.getInvestigation(Integer.parseInt(investigationcode[1])).getRate(), visitid, formatter.format(date), "", investigationnotes, 0, orderid);

                }
                out.print("Successfully Added");
                return;

            } catch (NumberFormatException e) {
                out.print("Error, Please Again");
                return;

            } catch (NullPointerException e) {
                out.print("Error, Please Again");
                return;
            }
            // out.print(id.length);

        }

        if ("addnotes".equals(request.getParameter("value"))) {
            String id = request.getParameter("visitid") == null ? "" : request.getParameter("visitid");
            String notes = request.getParameter("notes") == null ? "" : request.getParameter("notes");
            String doctorsid = request.getParameter("doctorsid") == null ? "" : request.getParameter("doctorsid");

            //HMSHelper mgr = new HMSHelper();

            out.print(id + "" + notes + "" + doctorsid);
            int did = -1;

            try {
                did = Integer.parseInt(id);
                // wardName = request.getParameter("name");
                Admissionnotes dmonitor = mgr.addAdmissionNoteint(did, doctorsid, notes);
                out.print("Successfully Added");
                return;

            } catch (NumberFormatException e) {
                out.print("id error");
                return;

            } catch (NullPointerException e) {
                out.print("empty");
                return;
            }


        }
        if ("forward".equals(request.getParameter("action"))) {
            // HMSHelper mgr = new HMSHelper();
            String notes = request.getParameter("notes") == null ? "" : request.getParameter("notes");
            String location = request.getParameter("location") == null ? "" : request.getParameter("location");
            String id = request.getParameter("visitid") == null ? "" : request.getParameter("visitid");
            String patientstatus = request.getParameter("patientstatus") == null ? "" : request.getParameter("patientstatus");
            String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
            if ("Transfer".equalsIgnoreCase(patientstatus)) {
                Transferlocation transferlocation = mgr.addTransferLocation(Integer.parseInt(id), new Date(), location, "doctorid", 0, notes);
                mgr.dischargePatience(Integer.parseInt(id), patientstatus, new Date());
                mgr.updateVisitationStatus(Integer.parseInt(id), "Records", mgr.getPatientFolder(patientid).getStatus());
                mgr.updateFolderLocation(mgr.getPatientFolder(patientid).getStatus(), "Records", patientid);
                out.print("empty" + location);
            }
            if ("Discharge".equalsIgnoreCase(patientstatus) || "Dead".equalsIgnoreCase(patientstatus)) {
                Visitationtable visitationtable = mgr.dischargePatience(Integer.parseInt(id), "In Patient", new Date());
                mgr.updateVisitationStatus(Integer.parseInt(id), "Records", mgr.getPatientFolder(patientid).getStatus());
                mgr.updateFolderLocation(mgr.getPatientFolder(patientid).getStatus(), "Records", patientid);
                out.print("mm" + location);
            }
            out.print("out" + patientstatus);
        }
        if ("addiagnosis".equals(request.getParameter("action"))) {
            String diagnosis[] = request.getParameterValues("diag[]");
            String patientid = request.getParameter("patientid");
            int id = Integer.parseInt(request.getParameter("visitid"));
            Date date = new Date();
            DateFormat formatter = null;
            if (diagnosis != null) {
                // String[] diagnoses = diagnosis.split("<>");
                for (int i = 0; i < diagnosis.length; i++) {
                    String[] diagnosescode = diagnosis[i].split("><");
                    //call get treatmentbyCode to retrieve item price
                    // mgr.addPatientDiagnosis(patientid, diagnosescode[1], diagnosescode[0], "", 0.0, "", id, formatter.format(date));
                    if (mgr.sponsorshipDetails(patientid).getType().equals("NHIS")) {
                        mgr.addPatientDiagnosis(patientid, Integer.parseInt(diagnosescode[1]), mgr.getNHISdiagnosis(Integer.parseInt(diagnosescode[1])).getGdrg(), id, formatter.format(date));
                    } else {
                        mgr.addPatientDiagnosis(patientid, Integer.parseInt(diagnosescode[1]), "CODE", id, formatter.format(date));
                    }

                }
            }
            out.print("successfully added");
            return;
        }
        if ("addtreatment".equals(request.getParameter("action"))) {
            String treatment[] = request.getParameterValues("medicines[]");
            String patientid = request.getParameter("patientid");
            String prescriptionnote = request.getParameter("prescription_notes") == null ? "" : request.getParameter("prescription_notes");
            int id = Integer.parseInt(request.getParameter("visitid"));
            if (treatment != null) {
                List lst = mgr.listPharmorders();
                int qty = 0;
                Date date = new Date();
                DateFormat formatter;
                formatter = new SimpleDateFormat("yyyy-MM-dd");
                String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                String y = yr.substring(2);
                int toadd = lst.size() + 1;
                String orderid = y + "DPH" + toadd;
                mgr.addPharmOrder(orderid, patientid, user.getStaffid(), new Date(), id);

                for (int i = 0; i < treatment.length; i++) {
                    String[] treatmentcode = treatment[i].split("><");

                    try {
                        qty = Integer.parseInt(treatmentcode[3]);
                    } catch (NumberFormatException e) {
                        qty = 0;
                    }
                    //call get treatmentbyCode to retrieve item price
                    if (mgr.sponsorshipDetails(patientid).getType().equals("NHIS")) {
                        mgr.addPatientTreatment(patientid, "CODE", Integer.parseInt(treatmentcode[1]), treatmentcode[4], mgr.getNhistreatment(Integer.parseInt(treatmentcode[1])).getPrice(), "No", id, formatter.format(date), prescriptionnote, qty, mgr.getNhistreatment(Integer.parseInt(treatmentcode[1])).getGdrg(), orderid);
                    } else {
                        mgr.addPatientTreatment(patientid, "CODE", Integer.parseInt(treatmentcode[1]), treatmentcode[4], mgr.getTreatment(Integer.parseInt(treatmentcode[1])).getPrice(), "No", id, formatter.format(date), prescriptionnote, qty, treatmentcode[2], orderid);
                    }

                }
            }
            out.print("successfully added");
            return;
        }
        if ("addlaboratory".equals(request.getParameter("action"))) {
            String labtest[] = request.getParameterValues("laboratories[]");
            String investigationnote = request.getParameter("investigation_note") == null ? "" : request.getParameter("investigation_note");
            String patientid = request.getParameter("patientid");
            int id = Integer.parseInt(request.getParameter("visitid"));
            Date date = new Date();
            DateFormat formatter;
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            if (labtest != null) {
                List lst = mgr.listLaborders();
                String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                String y = yr.substring(2);
                int toadd = lst.size() + 1;
                String orderid = y + "DML" + toadd;
                // String orderid = "";
                mgr.addLaborders(orderid, user.getStaffid(), id, patientid, "Clinic");
                // String[] investigations = investigation.split("<>");
                for (int i = 0; i < labtest.length; i++) {
                    String[] investigationcode = labtest[i].split("><");
                    //call get treatmentbyCode to retrieve item price
                    // mgr.addPatientTreatment(patientid, investigationcode[1], investigationcode[0], "", 0.0, "", id, formatter.format(date));
                    if (mgr.sponsorshipDetails(patientid).getType().equals("NHIS")) {
                        mgr.addPatientInvestigation(patientid, "CODE", Integer.parseInt(investigationcode[1]), "", mgr.getNhisInvestigation(Integer.parseInt(investigationcode[1])).getRate(), id, formatter.format(date), "No", investigationnote, 0, orderid);
                    } else {
                        mgr.addPatientInvestigation(patientid, "CODE", Integer.parseInt(investigationcode[1]), "", mgr.getInvestigation(Integer.parseInt(investigationcode[1])).getRate(), id, formatter.format(date), "No", investigationnote, 0, orderid);

                    }

                }
            }
            out.print("successfully added");
            return;
        }
        if ("addprocedure".equals(request.getParameter("action"))) {
            String procedures[] = request.getParameterValues("procs[]");
            String patientid = request.getParameter("patientid");
            int id = Integer.parseInt(request.getParameter("visitid"));
            if (procedures != null) {
                double total = 0.0;
                Procedureorders procedureorders = mgr.addProedureOrder(id, patientid, 0.0);
                for (int index = 0; index < procedures.length; index++) {
                    String sym = procedures[index];
                    String[] syms = sym.split("><");
                    total = total + Double.parseDouble(syms[2]);
                    mgr.updateProcedureordersTotal(procedureorders.getOrderid(), total);
                    mgr.addPatientProcedure(patientid, syms[1], procedureorders.getOrderid());
                }
            }
            out.print("successfully added");
            return;
        }
        if ("addcomplaints".equals(request.getParameter("action"))) {
            String content = request.getParameter("content");
            String userid = request.getParameter("doctorid");
            int id = Integer.parseInt(request.getParameter("visitid"));
            mgr.addAdmissionNoteint(id, userid, content);
            out.print("successfully added");
            return;
        }
        if ("addexamination".equals(request.getParameter("action"))) {
            String questions[] = request.getParameterValues("answers[]") == null ? null : request.getParameterValues("answers[]");
            int id = Integer.parseInt(request.getParameter("visitid"));
            if (questions != null) {
                // String[] diagnoses = diagnosis.split("<>");
                for (int i = 0; i < questions.length; i++) {
                    String[] diagnosescode = questions[i].split("_");
                    //call get treatmentbyCode to retrieve item price
                    mgr.addPatientClerking(id, Integer.parseInt(diagnosescode[0].trim()), Integer.parseInt(diagnosescode[1].trim()));
                }
            }
            out.print("successfully added");
            return;
        }
        if ("Forward".equals(request.getParameter("action"))) {
            String content = request.getParameter("admission");
            String patientid = request.getParameter("patientid");
            int id = Integer.parseInt(request.getParameter("visitid"));
            String userid = request.getParameter("userid");
            String diagnosis = request.getParameter("diagnosis");
            String note = request.getParameter("notes");
            String location = request.getParameter("location");
            // String bed = request.getParameter("bedid");
            //Integer bedid = Integer.parseInt(bed);
            if (content.equalsIgnoreCase("Discharge")) {
                mgr.dischargePatience(id, "Discharge", new Date());
                mgr.updateBedStatus(mgr.getPatientBed(id).getBedid(), Boolean.FALSE);
                String ward_room = mgr.getBed(mgr.getPatientBed(id).getBedid()).getWardOrRoom().split("_")[0];
                if (ward_room.equalsIgnoreCase("ward")) {
                    mgr.updateWardInfoDed(Integer.parseInt(mgr.getBed(mgr.getPatientBed(id).getBedid()).getWardOrRoom().split("_")[1]));
                } else {
                    mgr.updateRoomStatusDed(Integer.parseInt(mgr.getBed(mgr.getPatientBed(id).getBedid()).getWardOrRoom().split("_")[1]));
                }
            }
            if (content.equalsIgnoreCase("Transfer")) {
                mgr.addTransferLocation(id, new Date(), location, userid, Integer.parseInt(diagnosis), note);
                mgr.updateBedStatus(mgr.getPatientBed(id).getBedid(), Boolean.FALSE);
                String ward_room = mgr.getBed(mgr.getPatientBed(id).getBedid()).getWardOrRoom().split("_")[0];
                if (ward_room.equalsIgnoreCase("ward")) {
                    mgr.updateWardInfoDed(Integer.parseInt(mgr.getBed(mgr.getPatientBed(id).getBedid()).getWardOrRoom().split("_")[1]));
                } else {
                    mgr.updateRoomStatusDed(Integer.parseInt(mgr.getBed(mgr.getPatientBed(id).getBedid()).getWardOrRoom().split("_")[1]));
                }
            }
            // mgr.addAdmissionNoteint(id, userid, content);
            session.setAttribute("lasterror", "Admission Accepted");
            mgr.updateFolderLocation((String) session.getAttribute("unit"), "records", patientid);
            mgr.updateVisitationStatus(id, "records", (String) session.getAttribute("unit"));

            out.print("successfully added");
            response.sendRedirect("../ward.jsp?type=" + request.getParameter("type"));
            return;
        }
        if ("dosagemonitor".equals(request.getParameter("action"))) {

            String nurse = request.getParameter("nurse");
            int quantity = 0;
            String medicine = request.getParameter("medicine");
            int id = 0;
            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));

                id = Integer.parseInt(request.getParameter("visitid"));
            } catch (NumberFormatException ex) {
                out.print("Could not be added added some important data is missiing check quantity");
                return;
            }
            Dosagemonitor dosagemonitor = null;
            dosagemonitor = mgr.addDosageMonitor(id, medicine, quantity, nurse);
            if (dosagemonitor != null) {
                //System.out.println(id+" "+medicine+" "+start+" "+end+" "+nurse+" "+quantity+" "+allday);
                out.print("successfully added");
                return;
            }
            out.print("Could not be added added");
            return;
        }
        if ("deletedosagemonitor".equals(request.getParameter("action"))) {
            int dosage = -1;
            try {
                dosage = Integer.parseInt(request.getParameter("dosageid"));
            } catch (NumberFormatException ex) {
                out.print("Could not be added added some important data is missiing check quantity");
                return;
            }
            Dosagemonitor dosagemonitor = null;
            dosagemonitor = mgr.deleteDosagemonitor(dosage);
            if (dosagemonitor != null) {
                //System.out.println(id+" "+medicine+" "+start+" "+end+" "+nurse+" "+quantity+" "+allday);
                out.print("successfully removed");
                return;
            }
            out.print("Could not be added added");
            return;
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../ward.jsp?type=" + request.getParameter("type"));
        // out.print(id+""+morning+""+afternoon+""+evening);
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>