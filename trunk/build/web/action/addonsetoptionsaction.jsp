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

        if ("addonset".equals(request.getParameter("action"))) {
            String onsetOption = null;
            



            try {
                onsetOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            OnsetOptions bPartOption = mgr.addOnsetOptions(onsetOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Onset Option Saved Successfully!");
            response.sendRedirect("../addonsetoptions.jsp");
            out.print("Onset Option Option Saved Successfully");
            return;
        }
        if ("editonset".equals(request.getParameter("action"))) {
            String onsetOption = null;
            int onsetOptionId = -1;
           
            try {
                onsetOption = request.getParameter("option");
                onsetOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addonsetoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addonsetoptions.jsp");
                return;
            }

            OnsetOptions bodyPart = null;
            bodyPart = mgr.updateOnsetOptions(onsetOptionId, onsetOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Onset Option Edited Successfully");
            response.sendRedirect("../addonsetoptions.jsp");
            return;
        }

        if ("deleteonset".equals(request.getParameter("action"))) {

            int onsetId = 1;

            try {

                onsetId = Integer.parseInt(request.getParameter("onsetId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addonsetoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addonsetoptions.jsp");
                return;
            }




            OnsetOptions bPart = null;
            bPart = mgr.deleteOnsetOption(onsetId);
            
            
           
            out.print("Onset Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Onset Option Deleted Successfully");
            response.sendRedirect("../addonsetoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addonsetoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>