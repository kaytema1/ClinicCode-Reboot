<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        HMSHelper mgr = new HMSHelper();

        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("addmedicalhistory".equals(request.getParameter("action"))) {
            String medicalHistoryOption = null;
            



            try {
                medicalHistoryOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            MedicalHistories medHistoryOption = mgr.addMedicalHistory(medicalHistoryOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Medical History Saved Successfully!");
            response.sendRedirect("../addmedicalhistoryoptions.jsp");
            out.print("Medical History Option Saved Successfully");
            return;
        }
        if ("editmedicalhistory".equals(request.getParameter("action"))) {
            String medicalHistoryOption = null;
            int medicalHistoryOptionId = -1;
           
            try {
                medicalHistoryOption = request.getParameter("option");
                medicalHistoryOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addmedicalhistoryoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addmedicalhistoryoptions.jsp");
                return;
            }

            MedicalHistories medicalHistory = null;
            medicalHistory = mgr.updateMedicalHistory(medicalHistoryOptionId, medicalHistoryOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Medical History Edited Successfully");
            response.sendRedirect("../addmedicalhistoryoptions.jsp");
            return;
        }

        if ("deletemedicalhistory".equals(request.getParameter("action"))) {

            int medicalHistoryId = -1;

            try {

                medicalHistoryId = Integer.parseInt(request.getParameter("medicalHistoryId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addmedicalhistoryoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addmedicalhistoryoptions.jsp");
                return;
            }




            MedicalHistories medHistory = null;
            medHistory = mgr.deleteMedicalHistory(medicalHistoryId);
            
            
           
            out.print("Medical History Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Medical History Deleted Successfully");
            response.sendRedirect("../addmedicalhistoryoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addmedicalhistoryoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>