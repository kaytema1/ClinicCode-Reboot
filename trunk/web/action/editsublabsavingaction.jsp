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

        if ("editsublab".equals(request.getParameter("action"))) {

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Investigation invToEdit;
            int labid = Integer.parseInt(request.getParameter("labid"));
            //   try {
            String labType = request.getParameter("type") == "" ? "NA" : request.getParameter("type");
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String typenhis = request.getParameter("nhis") == null ? "NA" : request.getParameter("nhis");
            int specimen = request.getParameter("specimen") == null ? 0 : Integer.parseInt(request.getParameter("specimen"));
            //out.print(typenhis);
            String sRate = request.getParameter("rate") == "" ? "" : request.getParameter("rate");
            String nhisrate = request.getParameter("nhisrate") == "" ? "0.0" : request.getParameter("nhisrate");
            String sGrpUnderId = request.getParameter("grpunderid") == "" ? "" : request.getParameter("grpunderid");
            String sTypeOfTest = request.getParameter("typeoftestid") == "" ? "" : request.getParameter("typeoftestid");
            //       String lowRefRange = "", uppRefRange = "", paraRange = "";
            //        System.out.println("referenceType : " + referenceType);
            //        String detClickCount = "", detFrom = "", detTo = "", mLow = "", mHigh = "", fLow = "", fHigh = "";
            //        boolean saveUni = false, saveDet = false, saveNone = false;
            boolean saveAntibiotics = false;

            int selected = 0, rowCount = 0;

            /**
             * if (referenceType.equals("uni")) {
             *
             * // get which type has been selected String univeralOption =
             * request.getParameter("UniveralOption") == "" ? "" :
             * request.getParameter("UniveralOption"); if
             * (univeralOption.equals("duo")) {
             *
             * lowRefRange = request.getParameter("lowRefRange") == "" ? "" :
             * request.getParameter("lowRefRange");
             *
             * uppRefRange = request.getParameter("uppRefRange") == "" ? "" :
             * request.getParameter("uppRefRange");
             *
             * selected = 2;
             *
             * } else if (univeralOption.equals("one")) { paraRange =
             * request.getParameter("paraRange") == "" ? "" :
             * request.getParameter("paraRange");
             *
             * selected = 1; } saveUni = true; } else if
             * (referenceType.equals("det")) {
             *
             * detClickCount = request.getParameter("detClickCount") == "" ? ""
             * : request.getParameter("detClickCount");
             *
             * try { rowCount = Integer.parseInt(detClickCount); saveDet = true;
             * } catch (Exception e) {
             * response.sendRedirect("../editmainlab.jsp?id=" + labid); return;
             * }
             *
             * } else if (referenceType.equals("non")) { saveNone = true; }
             */
            String units = request.getParameter("units") == "" ? "NA" : request.getParameter("units");
            String interpretation = request.getParameter("interpretation") == "" ? "NA" : request.getParameter("interpretation");
            //       String sResultOptions = request.getParameter("resultsoptions") == null ? "NA" : request.getParameter("resultsoptions");

            //        String hiddencount = request.getParameter("hiddencount") == "" ? "NA" : request.getParameter("hiddencount");
            String antibioticQtn = request.getParameter("resultsoptions_antibiotics");

            String antibioticsCount = request.getParameter("hiddencount_antibiotics");

            double rate = 0;
            double nrate = 0;
            int labTypeId = 0;
            int typeOfTestId = 0;
            int groupUnderId = 0;
            boolean resultOptions = false;
            
            try {

                labTypeId = Integer.parseInt(labType);

                invToEdit = mgr.getDetailedInvById(labid);

                groupUnderId = Integer.parseInt(sGrpUnderId);
                
                typeOfTestId = Integer.parseInt(sTypeOfTest);
                //       if (sResultOptions.equals("Yes")) {
                //           resultOptions = true;
                //        }

                //      if (saveNone) {
                //           resultOptions = false;
                //       }
            } catch (Exception e) {
                out.print(e.getMessage());
                System.out.println("caught him here ++++++++ " + groupUnderId + " " + rate + " " + labTypeId + " ");
                session.setAttribute("lasterror", "Error Occurred, Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../editsublab.jsp?id=" + labid);
                return;
            }



            Date date = new Date();
            java.sql.Date colTime = new java.sql.Date(date.getTime());


            Investigation p = null;
            Nhisinvestigation nhisinvestigation = null;
            LabtypeDetailedinv lbMainTest = null;
            MaininvSubinv mainInvSubInv = null;
            PossibleinvResults posInvResult = null;
            DetailedinvPosinvresults detailedInvResult = null;
            DetailedinvRefrangeType dIRefRangeT = null;
            List listOfAntibiotics = null;


            // if (typenhis.equals("NA")) {

            //    public Investigation updateDetailedInvestigation(int labid, String code, String name, double rate, String lowBound, 
            // String highBound, int labTypeId, int typeOfTestId, int groupUnderId, String units,
            //    String interpretation, String defaultValue, String rangeFrom,
            //     String rangeUpTo, String comments, String reportCollDays, Date reportCollTime,
            //     boolean resultOptions, String referenceType, boolean hasantibiotic, double nhisrate, int specimen, boolean isSubheading)

            p = mgr.updateDetailedInvestigation(labid, code, name, rate, antibioticQtn, "NA", labTypeId, typeOfTestId, groupUnderId,
                    units, interpretation, "NA", "NA", "NA", "NA", "NA",
                    colTime, resultOptions, invToEdit.getRefRangeType(), Boolean.FALSE, nrate, specimen, Boolean.FALSE);
            System.out.println("p p p p : " + p);

            if (p == null) {
                session.setAttribute("lasterror", "Error Occurred Please Try Again!");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../editsublab.jsp?id=" + labid);
                return;
            }



            // if investigation has antibiotics, save them
            session.setAttribute("lasterror", "Sub Investigation Edited Successfully");
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