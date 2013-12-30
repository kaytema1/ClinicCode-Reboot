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
        if ("patient".equals(request.getParameter("action"))) {

            //    try {
            int specimen = request.getParameter("specimen") == null ? 0 : Integer.parseInt(request.getParameter("specimen"));
            String nhisrate = request.getParameter("nhisrate") == "" ? "0.0" : request.getParameter("nhisrate");
            String labType = request.getParameter("type") == "" ? "NA" : request.getParameter("type");
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            boolean hasantibiotic = request.getParameter("hasantibiotic") == null ? Boolean.FALSE : Boolean.parseBoolean(request.getParameter("hasantibiotic"));
            boolean subheading = request.getParameter("subheading") == null ? Boolean.FALSE : Boolean.parseBoolean(request.getParameter("subheading"));

            String sRate = request.getParameter("rate") == "" ? "" : request.getParameter("rate");
            String referenceType = request.getParameter("optionsRadios") == "" ? "" : request.getParameter("optionsRadios");
            String lowRefRange = "", uppRefRange = "", paraRange = "";
            System.out.println("referenceType : " + referenceType);
            String groupUnder = request.getParameter("combo") == "" ? "NA" : request.getParameter("combo");
            System.out.println("groupUnder : " + groupUnder);
            String detClickCount = "", detFrom = "", detTo = "", mLow = "", mHigh = "", fLow = "", fHigh = "";
            boolean saveUni = false, saveDet = false, saveNone = false, saveAntibiotics = false;

            int selected = 0, rowCount = 0;

            if (referenceType.equals("uni")) {

                // get which type has been selected
                String univeralOption = request.getParameter("UniveralOption") == "" ? "" : request.getParameter("UniveralOption");
                System.out.println("UniveralOption : " + univeralOption);

                if (univeralOption.equals("duo")) {

                    lowRefRange = request.getParameter("lowRefRange") == "" ? "" : request.getParameter("lowRefRange");

                    System.out.println("lowRefRange : " + lowRefRange);

                    uppRefRange = request.getParameter("uppRefRange") == "" ? "" : request.getParameter("uppRefRange");

                    System.out.println("uppRefRange : " + uppRefRange);
                    selected = 2;

                } else if (univeralOption.equals("one")) {
                    paraRange = request.getParameter("paraRange") == "" ? "" : request.getParameter("paraRange");

                    System.out.println("paraRange : " + paraRange);
                    selected = 1;
                }
                saveUni = true;
            } else if (referenceType.equals("det")) {

                detClickCount = request.getParameter("detClickCount") == "" ? "" : request.getParameter("detClickCount");
                System.out.println("detClickCount : " + detClickCount);

                try {
                    rowCount = Integer.parseInt(detClickCount);
                    saveDet = true;
                } catch (Exception e) {
                    session.setAttribute("lasterror", "Error Please Try Again");
                    session.setAttribute("class", "alert-error");
                    response.sendRedirect("../addsubinv.jsp");
                    return;
                }

            } else if (referenceType.equals("non")) {
                saveNone = true;
            }
            String units = request.getParameter("units") == "" ? "NA" : request.getParameter("units");
            String interpretation = request.getParameter("interpretation") == "" ? "NA" : request.getParameter("interpretation");

            String sResultOptions = request.getParameter("resultsoptions") == "" ? "NA" : request.getParameter("resultsoptions");

            String hiddencount = request.getParameter("hiddencount") == "" ? "NA" : request.getParameter("hiddencount");


            System.out.println("+++++++++++++++++++++++ sResultOptions : " + sResultOptions);

            String antibioticQtn = request.getParameter("resultsoptions_antibiotics");
            System.out.println("antibioticQtn : " + antibioticQtn);

            String antibioticsCount = request.getParameter("hiddencount_antibiotics");
            System.out.println("antibioticsCount : " + antibioticsCount);

            System.out.println("+++++++++++++++++++++++ hiddencount : " + hiddencount);
            //String registrationDate = request.getParameter("dor");
            double rate = 0;

            int labTypeId = 0;
            int typeOfTestId = 0;
            double nrate = 0;
            int groupUnderId = 0;
            boolean resultOptions = false;
            try {
                System.out.println("caught him here labType ++++++++ " + labType);
                labTypeId = Integer.parseInt(labType);

                if (sResultOptions.equals("Yes")) {
                    resultOptions = true;
                }

                try {
                    groupUnderId = Integer.parseInt(groupUnder.trim());
                } catch (Exception w) {

                    w.printStackTrace();
                    System.out.println("error with groupunderid");
                    session.setAttribute("lasterror", "Error Please Try Again");
                    session.setAttribute("class", "alert-error");

                    response.sendRedirect("../addsubinv.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("error with maillabid");
                session.setAttribute("lasterror", "Error Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../addsubinv.jsp");
                return;
            }
            Date date = new Date();
            java.sql.Date colTime = new java.sql.Date(date.getTime());

            HMSHelper mgr = new HMSHelper();
            Investigation p = null;
            LabtypeDetailedinv lbMainTest = null;
            MaininvSubinv mainInvSubInv = null;
            PossibleinvResults posInvResult = null;
            DetailedinvPosinvresults detailedInvResult = null;
            DetailedinvRefrangeType dIRefRangeT = null;
            List listOfAntibiotics = null;
            List<LabAntibiotic> allAntibiotics = new ArrayList<LabAntibiotic>();
            LabAntibiotic antibiotic;
            //      Folder f = null;
            //     Sponsorhipdetails sd = null;
            //  p = null;

            if (antibioticQtn != null) {
                if (antibioticQtn.equalsIgnoreCase("Yes")) {
                    listOfAntibiotics = mgr.listAllAntibiotics();

                    if (!listOfAntibiotics.isEmpty()) {
                        for (int i = 0; i < listOfAntibiotics.size(); i++) {
                            antibiotic = (LabAntibiotic) listOfAntibiotics.get(i);
                            allAntibiotics.add(antibiotic);
                        }
                    }
                    saveAntibiotics = true;
                }
            }


            p = mgr.createDetailedInvestigation(code, name, 0, antibioticQtn, "NA", labTypeId, 2, groupUnderId,
                    units, interpretation, "NA", "NA", "NA", "NA", "NA",
                    colTime, resultOptions, referenceType, hasantibiotic, nrate, specimen, subheading);

            System.out.println("p p p p : " + p);

            if (p == null) {
                session.setAttribute("lasterror", "patient details could not be saved please try again");
                session.setAttribute("lasterror", "Error Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../addsubinv.jsp");
                return;
            }

            int mainTestId = p.getDetailedInvId();
            System.out.println("main and sub " + groupUnderId + " " + mainTestId);

            mainInvSubInv = mgr.addMainTestSubTest(groupUnderId, mainTestId);
            if (mainInvSubInv == null) {
                session.setAttribute("lasterror", "main sub association rejected please try again");
                session.setAttribute("lasterror", "Error Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../addsubinv.jsp");
                return;
            }
            //     }

            if (resultOptions) {  // detailed inv has associated results
                System.out.println("we goin home");

                // first save the result on its own


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
                                session.setAttribute("lasterror", "Error Please Try Again");
                                session.setAttribute("class", "alert-error");
                                response.sendRedirect("../addsubinv.jsp");
                                return;
                            }

                            // if successful associate this possible result with detailed investigation
                            detailedInvResult = mgr.addDetInvPosResult(p.getDetailedInvId(), posInvResult.getPosinvResultId());
                            if (detailedInvResult == null) {
                                session.setAttribute("lasterror", "detailed investigation result not saved please try again");
                                session.setAttribute("lasterror", "Error Please Try Again");
                                session.setAttribute("class", "alert-error");
                                response.sendRedirect("../addsubinv.jsp");
                                return;
                            }
                        }
                    }
                }
            }

            if (saveUni) {

                mgr.addUniversalRefRange(p.getDetailedInvId(), selected, lowRefRange, uppRefRange, paraRange);


            }
            if (saveDet) {

                for (int y = 1; y <= rowCount; y++) {

                    detFrom = request.getParameter("age_from" + y) == "" ? "" : request.getParameter("age_from" + y);
                    detTo = request.getParameter("age_to" + y) == "" ? "" : request.getParameter("age_to" + y);
                    mLow = request.getParameter("male_lower" + y) == "" ? "" : request.getParameter("male_lower" + y);
                    mHigh = request.getParameter("male_higher" + y) == "" ? "" : request.getParameter("male_higher" + y);
                    fLow = request.getParameter("female_lower" + y) == "" ? "" : request.getParameter("female_lower" + y);
                    fHigh = request.getParameter("female_higher" + y) == "" ? "" : request.getParameter("female_higher" + y);

                    System.out.println("detfrom : " + y + " " + detFrom + " " + detTo + " " + mLow + " " + mHigh + " " + fLow + " " + fHigh);

                    mgr.addDetailedRefRange(p.getDetailedInvId(), detFrom, detTo, mLow, mHigh, fLow, fHigh);
                }
            }

            // if investigation has antibiotics, save them

            if (saveAntibiotics) {
                try {
                    String countAntigen;
                    String status = "Unknown";
                    String param = "selected_antibiotics";
                    int countOfSelAntibiotics = Integer.parseInt(antibioticsCount);

                    if (countOfSelAntibiotics > 0) {
                        for (int i = 1; i <= countOfSelAntibiotics; i++) {
                            param = "selected_antibiotics" + i;
                            //     System.out.println("param : " + param);
                            countAntigen = request.getParameter(param);
                            //     System.out.println("countAntigen : " + countAntigen);

                            if (countAntigen != null) {
                                if (!countAntigen.isEmpty()) {
                                    if (!allAntibiotics.isEmpty()) {
                                        for (LabAntibiotic labAnti : allAntibiotics) {
                                            if (labAnti.getName().equalsIgnoreCase(countAntigen)) {
                                                // save investigation with this antibiotic
                                                mgr.addInvAntibiotic(p.getDetailedInvId(), labAnti.getId(), status);
                                                break;
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }
                } catch (Exception e) {
                }
            }


            session.setAttribute("lasterror", "Detailed Investigation Saved Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("patient", p);
              
            response.sendRedirect("../addsubinv.jsp");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            // throw (ServletException) ex;
            session.setAttribute("lasterror", "An error occurred please try again later");
            response.sendRedirect("../addsubinv.jsp");
        } else {
            // throw new ServletException(ex);
            session.setAttribute("lasterror", "An error occurred please try again later");
            response.sendRedirect("../addsubinv.jsp");
        }
    }%>