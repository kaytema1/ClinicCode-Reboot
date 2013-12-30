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

        if ("editlabresultoptions".equals(request.getParameter("action"))) {
            int labid = Integer.parseInt(request.getParameter("labid"));

            int selected = 0, rowCount = 0;

            String sResultOptions = request.getParameter("resultsoptions") == null ? "NA" : request.getParameter("resultsoptions");
            System.out.println("sResultOptions : " + sResultOptions);
            String hiddencount = request.getParameter("hiddencount") == "" ? "NA" : request.getParameter("hiddencount");
            
            double rate = 0;
            double nrate = 0;
            int labTypeId = 0;
            int typeOfTestId = 0;
            int groupUnderId = 0;
            boolean resultOptions = false;
            try {
                
                if (sResultOptions.equals("Yes")) {
                    resultOptions = true;
                }

            } catch (Exception e) {
                out.print(e.getMessage());
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
            List<DetailedinvPosinvresults> prs = mgr.listDetailedInvPosResults(p.getDetailedInvId());
            if (prs != null) {
                for (int z = 0; z < prs.size(); z++) {
                    DetailedinvPosinvresults detailedinvPosinvresults = prs.get(z);
                    if (detailedinvPosinvresults != null) {
                        System.out.println("got to the end of it");
                        try {
                        mgr.deletePossibleResult(detailedinvPosinvresults.getDetailedinvPosinvresultId());
                                               } catch(Exception e) {
                                                   
                                               }
                    }
                }
            }
            if (resultOptions) {  // detailed inv has associated results
                

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

                        if (!resOptions.equals("NA") && resOptions != null && !resOptions.isEmpty()) {

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
            
            // if investigation has antibiotics, save them
            session.setAttribute("succ", "Detailed Investigation Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("patient", p);
            response.sendRedirect("../editmainlab.jsp?id=" + labid);
            return;

            // }
        }

                if ("editsublabresultoptions".equals(request.getParameter("action"))) {
            int labid = Integer.parseInt(request.getParameter("labid"));

            int selected = 0, rowCount = 0;

            String sResultOptions = request.getParameter("resultsoptions") == null ? "NA" : request.getParameter("resultsoptions");
            System.out.println("sResultOptions : " + sResultOptions);
            String hiddencount = request.getParameter("hiddencount") == "" ? "NA" : request.getParameter("hiddencount");
            
            double rate = 0;
            double nrate = 0;
            int labTypeId = 0;
            int typeOfTestId = 0;
            int groupUnderId = 0;
            boolean resultOptions = false;
            try {
                
                if (sResultOptions.equals("Yes")) {
                    resultOptions = true;
                }

            } catch (Exception e) {
                out.print(e.getMessage());
                response.sendRedirect("../editsublab.jsp?id=" + labid);
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
            List<DetailedinvPosinvresults> prs = mgr.listDetailedInvPosResults(p.getDetailedInvId());
            if (prs != null) {
                for (int z = 0; z < prs.size(); z++) {
                    DetailedinvPosinvresults detailedinvPosinvresults = prs.get(z);
                    if (detailedinvPosinvresults != null) {
                        System.out.println("got to the end of it");
                        try {
                        mgr.deletePossibleResult(detailedinvPosinvresults.getDetailedinvPosinvresultId());
                                               } catch(Exception e) {
                                                   
                                               }
                    }
                }
            }
            if (resultOptions) {  // detailed inv has associated results
                

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

                        if (!resOptions.equals("NA") && resOptions != null && !resOptions.isEmpty()) {

                            posInvResult = mgr.addPosInvResult(resOptions);

                            if (posInvResult == null) {
                                session.setAttribute("lasterror", "possible result not saved please try again");
                                response.sendRedirect("../editsublab.jsp?id=" + labid);
                                return;
                            }
                            // if successful associate this possible result with detailed investigation
                            detailedInvResult = mgr.addDetInvPosResult(p.getDetailedInvId(), posInvResult.getPosinvResultId());
                            if (detailedInvResult == null) {
                                session.setAttribute("lasterror", "detailed investigation result not saved please try again");
                                response.sendRedirect("../editsublab.jsp?id=" + labid);
                                return;
                            }
                        }
                    }
                }
            }
            
            // if investigation has antibiotics, save them
            session.setAttribute("succ", "Detailed Investigation Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("patient", p);
            response.sendRedirect("../editsublab.jsp?id=" + labid);
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