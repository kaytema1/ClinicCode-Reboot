<%-- 
    Document   : labnpharmactions
    Created on : Jun 21, 2012, 8:23:35 PM
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
            response.sendRedirect("index.jsp");
        }
        TransactionEntityManager mg = new TransactionEntityManager();
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        Date dt = new Date();
        DateFormat ft;
        ft = new SimpleDateFormat("yyyy-MM-dd");

        if ("addvital".equals(request.getParameter("action"))) {
            String temp = request.getParameter("temp") == null ? "0.0" : request.getParameter("temp");
            String pulse = request.getParameter("pulse") == null ? "0.0" : request.getParameter("pulse");
            String systolic = request.getParameter("systolic") == null ? "0.0" : request.getParameter("systolic");
            String diatolic = request.getParameter("diatolic") == null ? "0.0" : request.getParameter("diatolic");
            String id = request.getParameter("id") == null ? "0.0" : request.getParameter("id");

            try {
                double temperature = Double.parseDouble(temp);
                double pul = Double.parseDouble(pulse);
                double sys = Double.parseDouble(systolic);
                double dia = Double.parseDouble(diatolic);
                int code = Integer.parseInt(id);
                Vitalcheck vitalcheck = mgr.addVitalCheck(code, temperature, pul, sys, dia);
            } catch (NumberFormatException ex) {
                out.print("There was an error please try again");
            } catch (NullPointerException ex) {
                out.print("There was an error please try again");
            }
            out.print("successfully added");
            return;
        }

        if ("Forward".equals(request.getParameter("action"))) {
            String patientid = request.getParameter("patientid") == null ? "" : request.getParameter("patientid");
            int id = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
            System.out.println(id);

            if (!patientid.equalsIgnoreCase("") || id != 0) {
                String conditions[] = request.getParameterValues("conditions") == null ? null : request.getParameterValues("conditions");
                String conditionnote = request.getParameter("conditionnote") == null ? "" : request.getParameter("conditionnote");
                String onsets[] = request.getParameterValues("onsets") == null ? null : request.getParameterValues("onsets");
                String onsetnote = request.getParameter("onsetnote") == null ? "" : request.getParameter("onsetnote");
                String bodyparts[] = request.getParameterValues("bodyparts") == null ? null : request.getParameterValues("bodyparts");
                String bodypartnote = request.getParameter("bodypartnote") == null ? "" : request.getParameter("bodypartnote");
                String durations[] = request.getParameterValues("durations") == null ? null : request.getParameterValues("durations");
                String durationnote = request.getParameter("durationnote") == null ? "" : request.getParameter("durationnote");
                String characteristics[] = request.getParameterValues("characteristics") == null ? null : request.getParameterValues("characteristics");
                String characteristicnote = request.getParameter("characteristicnote") == null ? "" : request.getParameter("characteristicnote");
                String aggravations[] = request.getParameterValues("aggravations") == null ? null : request.getParameterValues("aggravations");
                String aggravationnote = request.getParameter("aggravationnote") == null ? "" : request.getParameter("aggravationnote");
                String reliefs[] = request.getParameterValues("reliefs") == null ? null : request.getParameterValues("reliefs");
                String reliefnote = request.getParameter("reliefnote") == null ? "" : request.getParameter("reliefnote");
                String treatments[] = request.getParameterValues("treatments") == null ? null : request.getParameterValues("treatments");
                String treatmentnote = request.getParameter("treatmentnote") == null ? "" : request.getParameter("treatmentnote");
                String majorexaminationfindings = request.getParameter("majorexaminationfindings") == "" ? "" : request.getParameter("majorexaminationfindings");
                String immunizations[] = request.getParameterValues("immunizations") == null ? null : request.getParameterValues("immunizations");
                String surgeries[] = request.getParameterValues("surgeries") == null ? null : request.getParameterValues("surgeries");
                String occupation = request.getParameter("occupation") == null ? "" : request.getParameter("occupation");
                String systemic_reviews[] = request.getParameterValues("systemic_reviews") == null ? null : request.getParameterValues("systemic_reviews");

                String patient_allergies[] = request.getParameterValues("patient_allergies") == null ? null : request.getParameterValues("patient_allergies");

                String patient_medical_histories[] = request.getParameterValues("patient_medical_histories") == null ? null : request.getParameterValues("patient_medical_histories");

                String family_history_counter = request.getParameter("family_history_counter") == null ? null : request.getParameter("family_history_counter");

                String patient_family_histories[] = request.getParameterValues("patient_family_histories") == null ? null : request.getParameterValues("patient_family_histories");
                String family_history_relations[] = request.getParameterValues("family_history_relations") == null ? null : request.getParameterValues("family_history_relations");
                String family_history_durations[] = request.getParameterValues("family_history_durations") == null ? null : request.getParameterValues("family_history_durations");

                String social_history_counter = request.getParameter("social_history_counter") == null ? null : request.getParameter("social_history_counter");

                String patient_social_histories[] = request.getParameterValues("patient_social_histories") == null ? null : request.getParameterValues("patient_social_histories");
                String social_history_durations[] = request.getParameterValues("social_history_durations") == null ? null : request.getParameterValues("social_history_durations");

                String diagnosis[] = request.getParameterValues("diaglist") == null ? null : request.getParameterValues("diaglist");
                String treatment[] = request.getParameterValues("data") == null ? null : request.getParameterValues("data");
                String labtest[] = request.getParameterValues("labtest") == null ? null : request.getParameterValues("labtest");
                String qnas[] = request.getParameterValues("anss[]") == null ? null : request.getParameterValues("anss[]");
                String procedures[] = request.getParameterValues("procedures") == null ? null : request.getParameterValues("procedures");
                String questions[] = request.getParameterValues("ans") == null ? null : request.getParameterValues("ans");
                // String newans[] = request.getParameterValues("newanswers[]") == null ? null : request.getParameterValues("newanswers[]");
                String vitals = request.getParameter("vitals") == null ? "" : request.getParameter("vitals[]");
                String unitName = request.getParameter("unitid") == null ? "" : request.getParameter("unitid");
                String prescriptionnote = request.getParameter("prescription_notes") == null ? "" : request.getParameter("prescription_notes");
                String investigationnote = "";
                String admit = request.getParameter("admission") == null ? "Out Patient" : request.getParameter("admission");
                String notes = request.getParameter("further") == null ? "" : request.getParameter("further");
                String complaints = request.getParameter("complaints") == null ? "" : request.getParameter("complaints");
                String summary = request.getParameter("visit_summary") == null ? "" : request.getParameter("visit_summary");

                String nonexistant = request.getParameter("nonexistant") == null ? null : request.getParameter("nonexistant");
                // String[] code = treatments
                int conditionId = 0;
                int onsetId = 0;
                int bodyPartId = 0;
                int durationId = 0;
                int characteristicId = 0;
                int aggravationId = 0;
                int reliefId = 0;
                int treatmentId = 0;
                int allergyId = 0;
                int medicalHistoryId = 0;
                int systemReviewId = 0;
                int familyhistoryId = 0;
                String familyrelation = "";
                int familydurationId = 0;

                int socialhistoryId = 0;
                int socialdurationId = 0;


                /* int familyCounter = Integer.parseInt(family_history_counter);
                 int socialCounter = Integer.parseInt(social_history_counter);
                 */

                if (conditions != null) {

                    for (int i = 0; i < conditions.length; i++) {

                        conditionId = Integer.parseInt(conditions[i]);
                        if (conditionId > 0) {
                            PatientConditions patientCondition = mgr.addPatientCondition(conditionId, patientid, id);
                            System.out.println(patientCondition.getConditionId());
                        }
                    }

                }

                if (conditionnote != "") {
                    PatientConditionNotes patientConditionNote = mgr.addPatientConditionNote(conditionnote, patientid, id);
                }

                if (onsets != null) {

                    for (int i = 0; i < onsets.length; i++) {

                        onsetId = Integer.parseInt(onsets[i]);
                        if (onsetId > 0) {
                            PatientOnsets patientOnset = mgr.addPatientOnsets(onsetId, patientid, id);
                        }
                    }

                }

                if (onsetnote != "") {
                    PatientOnsetNotes patientOnsetNote = mgr.addPatientOnsetNote(onsetnote, patientid, id);
                }

                if (bodyparts != null) {

                    for (int i = 0; i < bodyparts.length; i++) {

                        bodyPartId = Integer.parseInt(bodyparts[i]);
                        if (bodyPartId > 0) {
                            PatientBodyParts patientBodyPart = mgr.addPatientBodyParts(bodyPartId, patientid, id);
                        }
                    }

                }

                if (bodypartnote != "") {
                    PatientBodyPartNotes patientBodyPartNote = mgr.addPatientBodyPartNote(bodypartnote, patientid, id);
                }




                if (durations != null) {

                    for (int i = 0; i < durations.length; i++) {

                        durationId = Integer.parseInt(durations[i]);
                        if (durationId > 0) {
                            PatientDurations patientDuration = mgr.addPatientDuration(durationId, patientid, id);
                        }
                    }

                }

                if (durationnote != "") {
                    PatientDurationNotes patientDurationNote = mgr.addPatientDurationNote(durationnote, patientid, id);
                }

                if (characteristics != null) {

                    for (int i = 0; i < characteristics.length; i++) {

                        characteristicId = Integer.parseInt(characteristics[i]);
                        if (characteristicId > 0) {
                            PatientCharacteristics patientCharacteristic = mgr.addPatientCharacteristic(characteristicId, patientid, id);
                        }
                    }

                }

                if (characteristicnote != "") {
                    PatientCharacteristicNotes patientCharacteristicNote = mgr.addPatientCharacteristicNote(characteristicnote, patientid, id);
                }


                if (aggravations != null) {

                    for (int i = 0; i < aggravations.length; i++) {

                        aggravationId = Integer.parseInt(aggravations[i]);
                        if (aggravationId > 0) {
                            PatientAggravations patientAggravation = mgr.addPatientAggravation(aggravationId, patientid, id);
                        }
                    }

                }

                if (aggravationnote != "") {
                    PatientAggravationNotes patientAggravationNote = mgr.addPatientAggravationNote(aggravationnote, patientid, id);
                }


                if (reliefs != null) {

                    for (int i = 0; i < reliefs.length; i++) {

                        reliefId = Integer.parseInt(reliefs[i]);
                        if (reliefId > 0) {
                            PatientReliefs patientRelief = mgr.addPatientRelief(reliefId, patientid, id);
                        }
                    }

                }

                if (reliefnote != "") {
                    PatientReliefNotes patientReliefNote = mgr.addPatientReliefNote(reliefnote, patientid, id);
                }

                if (treatments != null) {

                    for (int i = 0; i < treatments.length; i++) {

                        treatmentId = Integer.parseInt(treatments[i]);
                        if (treatmentId > 0) {
                            PatientTreats patientTreat = mgr.addPatientTreats(treatmentId, patientid, id);
                        }
                    }

                }

                if (treatmentnote != "") {
                    PatientTreatmentNotes patientTreatmentNote = mgr.addPatientTreatmentNote(treatmentnote, patientid, id);
                }



                if (patient_allergies != null) {

                    for (int i = 0; i < patient_allergies.length; i++) {

                        allergyId = Integer.parseInt(patient_allergies[i]);
                        if (allergyId > 0) {
                            PatientAllergies patientAllergy = mgr.addPatientAllergiess(patientid, allergyId);
                        }
                    }

                }

                if (patient_medical_histories != null) {

                    for (int i = 0; i < patient_medical_histories.length; i++) {

                        medicalHistoryId = Integer.parseInt(patient_medical_histories[i]);
                        if (medicalHistoryId > 0) {
                            PatientMedicalHistory patientMedicalHistory = mgr.addPatientMedicalHistory(medicalHistoryId, id, patientid, dt);
                        }
                    }

                }



                if (systemic_reviews != null) {

                    for (int i = 0; i < systemic_reviews.length; i++) {

                        systemReviewId = Integer.parseInt(systemic_reviews[i]);
                        if (systemReviewId > 0) {
                            PatientSystemicReviews patientReviews = mgr.addPatientSystemicReview(systemReviewId, id, patientid, dt);
                        }
                    }

                }

                if (patient_family_histories != null) {

                    for (int i = 0; i < patient_family_histories.length; i++) {

                        familyhistoryId = Integer.parseInt(patient_family_histories[i]);
                        familyrelation = family_history_relations[i];
                        familydurationId = Integer.parseInt(family_history_durations[i]);
                        if (familyhistoryId > 0) {
                            PatientFamilyHistory patientFamilyHistory = mgr.addPatientFamilyHistory(familyhistoryId, id, familydurationId, patientid, familyrelation, dt);
                        }
                    }

                }


                if (patient_social_histories != null) {
                    for (int i = 0; i < patient_social_histories.length; i++) {

                        socialhistoryId = Integer.parseInt(patient_social_histories[i]);
                        socialdurationId = Integer.parseInt(social_history_durations[i]);
                        if (socialhistoryId > 0) {
                            PatientSocialHistory patientSocialHistory = mgr.addPatientSocialHistory(socialhistoryId, id, socialdurationId, patientid, dt);
                        }
                    }

                }


                String immunization = "";

                if (immunizations.length > 0) {

                    for (int i = 0; i < immunizations.length; i++) {

                        immunization = immunizations[i].trim();
                        if (!immunization.equalsIgnoreCase("")) {

                            PatientImmunizations patientImmunization = mgr.addPatientImmnunization(patientid, id, immunization);
                        }
                    }

                }


                String surgery = "";

                if (surgeries.length > 0) {

                    for (int i = 0; i < surgeries.length; i++) {

                        surgery = surgeries[i].trim();
                        if (!surgery.equalsIgnoreCase("")) {

                            PatientSurgeries patientSurgery = mgr.addPatientSurgery(patientid, id, surgery);
                        }
                    }

                }
                if (!occupation.equalsIgnoreCase("")) {
                    Patient patient = mgr.updatePatientOccupation(patientid, occupation);
                }

                if (!majorexaminationfindings.equalsIgnoreCase("")) {
                    PatientMajorExaminations major = mgr.addPatientMajorExamination(patientid, id, majorexaminationfindings);
                }



                if (labtest == null) {
                    out.print("empty");
                }
                Date date = new Date();
                DateFormat formatter;
                formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                int qty = 0;
                if (treatment != null) {
                    List lst = mgr.listPharmorders();
                    String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                    String y = yr.substring(2);
                    int toadd = lst.size() + 1;
                    String orderid = y + "DPH" + toadd;
                    Pharmorder pharmorder = mgr.addPharmOrder(orderid, patientid, user.getStaffid(), new Date(), id, user.getStaffid());
                    DispensaryItems db = new DispensaryItems();
                    PharmacyItem pb = new PharmacyItem();
                    // mgr.updatePatientBills(id, totalBill, amounPaid, status);
                    // String[] treatments = treatment.split("<>");
                    Dosage d = new Dosage();

                    for (int i = 0; i < treatment.length; i++) {
                        Patienttreatment patienttreatment = new Patienttreatment();
                        String[] treatmentcode = treatment[i].split("><");
                        String[] dosages = treatmentcode[1].split("-");
                        String selectedTreatmentId = treatmentcode[0];
                        int selectedDosageId = Integer.parseInt(dosages[0]);
                        String selectedDuration = treatmentcode[2];

                        try {
                            //qty = Integer.parseInt(treatmentcode[3]);
                            qty = 0;
                        } catch (NumberFormatException e) {
                            qty = 0;
                        }
                        //call get treatmentbyCode to retrieve item price
                        //double price = mgr.sponsorshipDetails(patientid).getType().equalsIgnoreCase("NHIS") ? mgr.getItemTable(treatmentcode[1]).getNhisprice() : mgr.getItemTable(treatmentcode[1]).getDispensaryprice();
                        //PatientBills treatmentBill = mgr.addPatientBills(id,"Treatment Bill", patientid, totalBills, amountPaid, status, 0,0, 0, 0, user.getStaffid());

                        Dosage dosage = (Dosage) mg.getIntegerObject(d, selectedDosageId);
                        patienttreatment.setDosage(dosage);
                        patienttreatment.setQuantity(dosage.getQuantity());
                        patienttreatment.setPharmorder(pharmorder);
                        patienttreatment.setVisitationid(id);
                        patienttreatment.setCopaid(Boolean.FALSE);
                        patienttreatment.setDispensed("No");
                        patienttreatment.setIsPrivate(Boolean.FALSE);
                        patienttreatment.setDuration(treatmentcode[2]);
                        if (treatmentcode[3].equals("dispensary")) {
                            System.out.println(selectedTreatmentId);
                            DispensaryItems dispensaryBatch = (DispensaryItems) mg.getStringObject(db, selectedTreatmentId);
                            System.out.println(dispensaryBatch);
                            patienttreatment.setDispensaryItems(dispensaryBatch);
                            patienttreatment.setPrice(0.0);
                            patienttreatment.setTotal(0.0);
                        }
                        if (treatmentcode[3].equals("pharmacy")) {
                            System.out.println(selectedTreatmentId);
                            PharmacyItem pharmacyBatch = (PharmacyItem) mg.getStringObject(pb, selectedTreatmentId);
                            patienttreatment.setPharmacyItem(pharmacyBatch);
                            patienttreatment.setPrice(0);
                            patienttreatment.setTotal(0.0);
                        }
                        if (treatmentcode[3].equals("treatment")) {
                            double price = mgr.getTreatment(Integer.parseInt(selectedTreatmentId)).getPrice();
                            patienttreatment.setTreatmentid(Integer.parseInt(selectedTreatmentId));
                            patienttreatment.setPrice(0);
                            patienttreatment.setTotal(0.0);
                        }
                        //patienttreatment.setNetTotal(netTotal);
                        patienttreatment.setAmounpaid(0.0);

                        // patienttreatment.setVatValue(vatValue);

                        //mgr.addPatientTreatment(patientid,"CODE", selectedTreatmentId, dosage, price, "No", id, formatter.format(date), selectedDuration, qty, pharmorder);
                        // mgr.addPatientTreatment(patientid, "CODE", selectedTreatmentId, treatmentcode[4], price, "No", id, formatter.format(date), prescriptionnote, qty, treatmentcode[2], orderid);
                        // }
                        mg.save(patienttreatment);
                        if (admit.equalsIgnoreCase("In Patient")) {
                            //mgr.addDosageMonitor(id, Integer.parseInt(treatmentcode[1]), "", "", "", null);
                        }
                    }
                }
                /**
                 * if (labtest != null) { List lst = mgr.listLaborders(); String
                 * yr = "" + Calendar.getInstance().get(Calendar.YEAR); String y
                 * = yr.substring(2); int toadd = lst.size() + 1; String orderid
                 * = y + "DML" + toadd; // String orderid = "";
                 * mgr.addLaborders(orderid, user.getStaffid(), id, patientid,
                 * "Clinic"); // String[] investigations =
                 * investigation.split("<>"); for (int i = 0; i <
                 * labtest.length; i++) { String[] investigationcode =
                 * labtest[i].split("><"); //call get treatmentbyCode to
                 * retrieve item price // mgr.addPatientTreatment(patientid,
                 * investigationcode[1], investigationcode[0], "", 0.0, "", id,
                 * formatter.format(date)); if
                 * (mgr.sponsorshipDetails(patientid).getType().equals("NHIS"))
                 * { mgr.addPatientInvestigation(patientid, "CODE",
                 * Integer.parseInt(investigationcode[1]), "",
                 * mgr.getNhisInvestigation(Integer.parseInt(investigationcode[1])).getRate(),
                 * id, formatter.format(date), "No", investigationnote, 0,
                 * orderid); } else { mgr.addPatientInvestigation(patientid,
                 * "CODE", Integer.parseInt(investigationcode[1]), "",
                 * mgr.getInvestigation(Integer.parseInt(investigationcode[1])).getRate(),
                 * id, formatter.format(date), "No", investigationnote, 0,
                 * orderid);
                 *
                 * }
                 *
                 * }
                 * } *
                 */
                // --- Start Nezer 19th Dec
                if (labtest != null) {
                    List lst = mgr.listTransitLabsInClinic();
                    String yr = "" + Calendar.getInstance().get(Calendar.YEAR);
                    String y = yr.substring(2);
                    int toadd = lst.size() + 1;
                    // String orderid = y + "DML" + toadd;
                    String orderid = y + "TLA" + toadd;
                    String patientID = "";

                    //              Patient patient = (Patient) mgr.getPatientByID(patientid);
                    //              List list = mgr.listLabPatientExist(patient.getFname(), patient.getLname(), patient.getDateofbirth() + "");
                    //              if (list.size() > 1 || list == null || !list.isEmpty()) {
                    //                  LabPatient labPatient = (LabPatient) list.get(0);
                    //                  patientID = labPatient.getPatientid();
                    //              } else {
                    //                  patientID = (y + "LP" + (mgr.listLabPatients().size() + 1));
                    //                  LabPatient labPatient = mgr.addNewLabPatient(patientID, patient.getLname(), patient.getFname(), patient.getMidname(), patient.getGender(), patient.getAddress(), patient.getEmployer(), patient.getDateofbirth() + "", patient.getContact(), patient.getEmergencyperson(), patient.getEmergencycontact(), patient.getEmail(), patient.getCountry(), patient.getCity(), patient.getMaritalstatus(), patient.getImglocation(), patientid);
                    // Sponsorhipdetails sponsorhipdetails = (Sponsorhipdetails) mgr.sponsorshipDetails(patientid);
                    // mgr.createPatientSponsorshipDetails(patientID, sponsorhipdetails.getMembershipid(), sponsorhipdetails.getType(), sponsorhipdetails.getBenefitplan(), sponsorhipdetails.getSponsorid(), sponsorhipdetails.getDependentnumber(), sponsorhipdetails.getSecondaryType());
                    //  }


                    // String orderid = "";
                    //mgr.addLaborders(orderid, user.getStaffid(), id, patientid, "Clinic");
                    mgr.addTransitLabs(orderid, patientid, user.getStaffid(), id);
                    // String[] investigations = investigation.split("<>");
                    int invId;
                    Investigation subInv;
                    List subInvsList;
                    for (int i = 0; i < labtest.length; i++) {
                        String[] investigationcode = labtest[i].split("><");
                        //call get treatmentbyCode to retrieve item price
                        // mgr.addPatientTreatment(patientid, investigationcode[1], investigationcode[0], "", 0.0, "", id, formatter.format(date));

                        System.out.println("getting insyd here");
                        mgr.addPatientInvestigation(patientid, "CODE", Integer.parseInt(investigationcode[1]), "", mgr.getInvestigation(Integer.parseInt(investigationcode[1])).getRate(), id, formatter.format(date), "No", investigationnote, 0, orderid);
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
                        // }

                    }
                }

                // --- End Nezer 19th Dec

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
                if (questions != null) {
                    // String[] diagnoses = diagnosis.split("<>");
                    for (int i = 0; i < questions.length; i++) {
                        String[] diagnosescode = questions[i].split("_");
                        //call get treatmentbyCode to retrieve item price
                        mgr.addPatientClerking(id, Integer.parseInt(diagnosescode[0].trim()), Integer.parseInt(diagnosescode[1].trim()));
                    }
                }
                if (procedures != null) {
                    double total = 0.0;
                    Procedureorders procedureorders = mgr.addProcedureOrder(id, patientid, 0.0, user.getStaffid());
                    for (int index = 0; index < procedures.length; index++) {
                        String sym = procedures[index];
                        String[] syms = sym.split("><");
                        total = total + Double.parseDouble(syms[2]);
                        mgr.updateProcedureordersTotal(procedureorders.getOrderid(), total);
                        mgr.addPatientProcedure(patientid, syms[1], procedureorders.getOrderid());
                    }
                    PatientBills bills = (PatientBills) mgr.addPatientBills(0, "Procedure Bill", patientid, total, 0, "Not-Paid", 0, 0, 0, 0, user.getStaffid());

                }
                if (admit.equalsIgnoreCase("In Patient")) {
                    mgr.admitPatience(id, admit, new Date());
                    //mgr.addDosageMonitor(id, patienttreatmentid, "", "", "", null);
                }
                if (nonexistant != null) {
                    // Diagnosis d = mgr.addANewDiagnosis("NA", nonexistant, "gdrg");
                    //  mgr.addPatientDiagnosis(patientid, d.getId(), "CODE", id, formatter.format(date));
                }
                mgr.updateVisitNotes(id, notes);
                mgr.updateVisitationComplaints(id, complaints);
                mgr.updateVisitNotes(id, summary);
                mgr.updateVisitation(patientid, id, unitName, "consultation");
                mgr.updateVisitation(id, user.getStaffid());
                //String registrationDate = request.getParameter("dor");

                mgr.updateFolderLocation("consultation", unitName, patientid);
                if (admit.equalsIgnoreCase("In Patient")) {
                    mgr.updateVisitationStatus(id, "ward", "consultation");
                    mgr.updateFolderLocation("consultation", "ward", patientid);

                    //mgr.addDosageMonitor(id, patienttreatmentid, "", "", "", null);
                }
            }
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        // System.out.println("here" + id);
        session.setAttribute("lasterror", "Patient Forwarded Successfully");
        session.setAttribute("class", "alert-success");
        response.sendRedirect("../consultingroom.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }
%>