<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,helper.HibernateUtil"%>
<!DOCTYPE html>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        // HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        sess.beginTransaction();

        if ("editlabreference".equals(request.getParameter("action"))) {
            int labid = Integer.parseInt(request.getParameter("labid"));
            //   try {
            //    String labType = request.getParameter("type") == "" ? "NA" : request.getParameter("type");
            //      String code = request.getParameter("code");
            //     String name = request.getParameter("name");
            //      String typenhis = request.getParameter("nhis") == null ? "NA" : request.getParameter("nhis");
            //     int specimen = request.getParameter("specimen") == null ? 0 : Integer.parseInt(request.getParameter("specimen"));
            //out.print(typenhis);
            //      String sRate = request.getParameter("rate") == "" ? "" : request.getParameter("rate");
            //       String nhisrate = request.getParameter("nhisrate") == "" ? "0.0" : request.getParameter("nhisrate");
            String referenceType = request.getParameter("optionsRadios") == "" ? "" : request.getParameter("optionsRadios");
            String lowRefRange = "", uppRefRange = "", paraRange = "";
            System.out.println("referenceType : " + referenceType);
            String detClickCount = "", detFrom = "", detTo = "", mLow = "", mHigh = "", fLow = "", fHigh = "";
            boolean saveUni = false, saveDet = false, saveNone = false, saveAntibiotics = false;

            int selected = 0, rowCount = 0;

            if (referenceType.equals("uni")) {

                // get which type has been selected
                String univeralOption = request.getParameter("UniveralOption") == "" ? "" : request.getParameter("UniveralOption");
                
                if(univeralOption == null || univeralOption.isEmpty()) {
                        response.sendRedirect("../editmainlab.jsp?id=" + labid);
                        return;
                }
                
                if (univeralOption.equals("duo")) {

                    lowRefRange = request.getParameter("lowRefRange") == "" ? "" : request.getParameter("lowRefRange");

                    uppRefRange = request.getParameter("uppRefRange") == "" ? "" : request.getParameter("uppRefRange");

                    if (lowRefRange == null || lowRefRange.isEmpty() || uppRefRange == null || uppRefRange.isEmpty()) {
                        response.sendRedirect("../editmainlab.jsp?id=" + labid);
                         return;
                    }

                    selected = 2;

                } else if (univeralOption.equals("one")) {
                    paraRange = request.getParameter("paraRange") == "" ? "" : request.getParameter("paraRange");

                    if (paraRange == null ||  paraRange.isEmpty()) {
                        response.sendRedirect("../editmainlab.jsp?id=" + labid);
                         return;
                    }

                    selected = 1;
                }
                saveUni = true;
            } else if (referenceType.equals("det")) {

                detClickCount = request.getParameter("detClickCount") == "" ? "" : request.getParameter("detClickCount");

                try {
                    rowCount = Integer.parseInt(detClickCount);
                    saveDet = true;
                } catch (Exception e) {
                    response.sendRedirect("../editmainlab.jsp?id=" + labid);
                    return;
                }

            } else if (referenceType.equals("non")) {
                saveNone = true;
            }

            //    String units = request.getParameter("units") == "" ? "NA" : request.getParameter("units");
            //      String interpretation = request.getParameter("interpretation") == "" ? "NA" : request.getParameter("interpretation");
            String sResultOptions = request.getParameter("resultsoptions") == null ? "NA" : request.getParameter("resultsoptions");
            System.out.println("sResultOptions : " + sResultOptions);
            String hiddencount = request.getParameter("hiddencount") == "" ? "NA" : request.getParameter("hiddencount");
            String antibioticQtn = request.getParameter("resultsoptions_antibiotics");

            String antibioticsCount = request.getParameter("hiddencount_antibiotics");

            double rate = 0;
            double nrate = 0;
            int labTypeId = 0;
            int typeOfTestId = 0;
            int groupUnderId = 0;
            boolean resultOptions = false;
            try {

                /*         if (!sRate.isEmpty()) {
                 rate = Double.parseDouble(sRate);
                 }
                 if (!nhisrate.isEmpty()) {
                 nrate = Double.parseDouble(nhisrate);

                 }
                 */
                //   labTypeId = Integer.parseInt(labType);
                if (sResultOptions.equals("Yes")) {
                    resultOptions = true;
                }

                if (saveNone) {
                    resultOptions = false;
                }
            } catch (Exception e) {
                out.print(e.getMessage());
                System.out.println("caught him here ++++++++ " + nrate + " " + rate + " " + labTypeId + " " + sResultOptions);
                response.sendRedirect("../editmainlab.jsp?id=" + labid);
                return;
            }



            Date date = new Date();
            java.sql.Date colTime = new java.sql.Date(date.getTime());

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Investigation p = mgr.getDetailedInvById(labid);
            Nhisinvestigation nhisinvestigation = null;
            //     LabtypeDetailedinv lbMainTest = null;
            MaininvSubinv mainInvSubInv = null;
            PossibleinvResults posInvResult = null;
            DetailedinvPosinvresults detailedInvResult = null;
            DetailedinvRefrangeType dIRefRangeT = null;
            List listOfAntibiotics = null;


            // if (typenhis.equals("NA")) {
       /*     System.out.println("in here qwerpo 2");
             p = mgr.updateDetailedInvestigation(labid, code, name, rate, antibioticQtn, "NA", labTypeId, 1, groupUnderId,
             units, interpretation, "NA", "NA", "NA", "NA", "NA",
             colTime, resultOptions, referenceType, Boolean.FALSE, nrate, specimen, Boolean.FALSE);
             System.out.println("p p p p : " + p);

             if (p == null) {
             session.setAttribute("lasterror", "Error Occurred Please Try Again!");
             response.sendRedirect("../editmainlab.jsp?id=" + labid);
             return;
             }
             */
            int mainTestId = p.getDetailedInvId();
            //     if (typeOfTestId == 1) {  // main test, associate with lab type

            System.out.println("mainTestId " + mainTestId);
            //delete labtype id
    /*        List invids = mgr.listLabtypeDetailedinvId(mainTestId);
             if (invids != null || invids.size() > 0) {
             for (int x = 0; x < invids.size(); x++) {
             LabtypeDetailedinv detailedinv = (LabtypeDetailedinv) invids.get(x);
             if (detailedinv != null) {

             mgr.deleteLabTypeMain(mainTestId);
             }
             }
             }
             //       lbMainTest = mgr.addLabTypeMainTest(labTypeId, mainTestId);

             /*        if (lbMainTest == null) {
             session.setAttribute("lasterror", "labtype main association rejected please try again");
             response.sendRedirect("../editmainlab.jsp?id=" + labid);
             return;
             }
             * */
            List prs = mgr.listDetailedInvPosResults(p.getDetailedInvId());
            if (prs != null) {
                for (int z = 0; z < prs.size(); z++) {
                    DetailedinvPosinvresults detailedinvPosinvresults = (DetailedinvPosinvresults) prs.get(z);
                    if (detailedinvPosinvresults != null) {
                        System.out.println("got to the end of it");
                        mgr.deletePossibleResult(p.getDetailedInvId());
                    }
                }
            }
            if (resultOptions) {  // detailed inv has associated results
                System.out.println("we goin home");

                String resOptions = "";
                String param = "option";


                if (!hiddencount.equalsIgnoreCase("NA")) {
                    int positiveResCount = Integer.parseInt(hiddencount);

                    for (int q = 1; q <= positiveResCount; q++) {
                        param = "option";


                        param = param + q;

                        System.out.println("param : " + param);
                        resOptions = request.getParameter(param) == "" ? "NA" : request.getParameter(param);
                        System.out.println("resOptions : " + resOptions);

                        if (!resOptions.equals("NA") && resOptions != null) {

                            posInvResult = mgr.addPosInvResult(resOptions);

                            if (posInvResult == null) {
                                session.setAttribute("lasterror", "possible result not saved please try again");
                                response.sendRedirect("../editmainlab.jsp?id=" + labid);
                                return;
                            }
                            // if successful associate this possible result with detailed investigation
                            detailedInvResult = mgr.addDetInvPosResult(p.getDetailedInvId(), posInvResult.getPosinvResultId());
                            if (detailedInvResult == null) {
                                session.setAttribute("lasterror", "detailed investigation result not saved please try again");
                                response.sendRedirect("../editmainlab.jsp?id=" + labid);
                                return;
                            }
                        }
                    }
                }
            }
            List refUnis = mgr.getUniRefRangeByDetInvId(p.getDetailedInvId());
            if (refUnis != null && refUnis.size() > 0) {
                for (int w = 0; w < refUnis.size(); w++) {
                    RefRangeUni rangeUni = (RefRangeUni) refUnis.get(w);
                    if (rangeUni != null) {
                        mgr.deleteUniversalResult(rangeUni.getId());
                    }
                }

            }
            List refDets = mgr.getDetRefRangeByDetInvId(p.getDetailedInvId());
            if (refDets != null && refDets.size() > 0) {
                for (int w = 0; w < refDets.size(); w++) {
                    RefRangeDet rangeUni = (RefRangeDet) refDets.get(w);
                    if (refDets != null) {
                        mgr.deleteDetailResult(rangeUni.getId());
                    }
                }

            }

            if (saveNone) {

                p.setRefRangeType("non");
                mgr.updateDetailedInvestigation(p);
            }
            if (saveUni) {

                p.setRefRangeType("uni");
                mgr.updateDetailedInvestigation(p);
                mgr.addUniversalRefRange(p.getDetailedInvId(), selected, lowRefRange, uppRefRange, paraRange);
            }
            if (saveDet) {

                p.setRefRangeType("det");
                mgr.updateDetailedInvestigation(p);
                boolean emptyValuesFound = false;
                System.out.println("rowcount : " + rowCount);
                for (int y = 1; y <= rowCount; y++) {
                    System.out.println("y : " + y);
                    emptyValuesFound = false;
                    detFrom = request.getParameter("age_from" + y) == "" ? "" : request.getParameter("age_from" + y);
                    detTo = request.getParameter("age_to" + y) == "" ? "" : request.getParameter("age_to" + y);
                    mLow = request.getParameter("male_lower" + y) == "" ? "" : request.getParameter("male_lower" + y);
                    mHigh = request.getParameter("male_higher" + y) == "" ? "" : request.getParameter("male_higher" + y);
                    fLow = request.getParameter("female_lower" + y) == "" ? "" : request.getParameter("female_lower" + y);
                    fHigh = request.getParameter("female_higher" + y) == "" ? "" : request.getParameter("female_higher" + y);

                    System.out.println("detfrom : " + y + " " + detFrom + " " + detTo + " " + mLow + " " + mHigh + " " + fLow + " " + fHigh);
//delete existing
                    if(detFrom == null || detFrom.isEmpty() || detTo == null || detTo.isEmpty() || mLow == null || mLow.isEmpty() || mHigh == null || mHigh.isEmpty() || fLow == null || fLow.isEmpty() || fHigh == null || fHigh.isEmpty()) {
                        emptyValuesFound = true;
                    }
                    if(!emptyValuesFound) {
                    mgr.addDetailedRefRange(p.getDetailedInvId(), detFrom, detTo, mLow, mHigh, fLow, fHigh);
                                       }
                }
            }

            // if investigation has antibiotics, save them
            session.setAttribute("succ", "Detailed Investigation Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("patient", p);
            response.sendRedirect("../editmainlab.jsp?id=" + labid);
            return;

            // }
        }



        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();

        // throw new ServletException(ex);
        ex.getStackTrace();
        ex.printStackTrace();
        session.setAttribute("lasterror", "Error Occurred Please Try Again");
        response.sendRedirect("../reordermaininv.jsp");

    }%>