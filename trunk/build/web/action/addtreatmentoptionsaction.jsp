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

        if ("addtreatment".equals(request.getParameter("action"))) {
            String treatmentOption = null;
            



            try {
                treatmentOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            TreatmentOptions treatOption = mgr.addTreatmentOptions(treatmentOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Treatment Option Saved Successfully!");
            response.sendRedirect("../addtreatmentoptions.jsp");
            out.print("Treatment Option Option Saved Successfully");
            return;
        }
        if ("edittreatment".equals(request.getParameter("action"))) {
            String treatmentOption = null;
            int treatmentOptionId = -1;
           
            try {
                treatmentOption = request.getParameter("option");
                treatmentOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addtreatmentoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addtreatmentoptions.jsp");
                return;
            }

            TreatmentOptions treatment = null;
            treatment = mgr.updateTreatmentOptions(treatmentOptionId, treatmentOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Treatment Option Edited Successfully");
            response.sendRedirect("../addtreatmentoptions.jsp");
            return;
        }

        if ("deletetreatment".equals(request.getParameter("action"))) {

            int treatmentId = 1;

            try {

                treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addtreatmentoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addtreatmentoptions.jsp");
                return;
            }




            TreatmentOptions treat = null;
            treat = mgr.deleteTreatmentOption(treatmentId);
            
            
           
            out.print("Treatment Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Treatment Option Deleted Successfully");
            response.sendRedirect("../addtreatmentoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addtreatmentoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>