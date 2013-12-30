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

        if ("addduration".equals(request.getParameter("action"))) {
            String durationOption = null;
            



            try {
                durationOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            DurationOptions duraOption = mgr.addDurationOptions(durationOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Duration Option Saved Successfully!");
            response.sendRedirect("../adddurationoptions.jsp");
            out.print("Duration Option Option Saved Successfully");
            return;
        }
        if ("editduration".equals(request.getParameter("action"))) {
            String durationOption = null;
            int durationOptionId = -1;
           
            try {
                durationOption = request.getParameter("option");
                durationOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../adddurationoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../adddurationoptions.jsp");
                return;
            }

            DurationOptions duration = null;
            duration = mgr.updateDurationOptions(durationOptionId, durationOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Duration Option Edited Successfully");
            response.sendRedirect("../adddurationoptions.jsp");
            return;
        }

        if ("deleteduration".equals(request.getParameter("action"))) {

            int durationId = 1;

            try {

                durationId = Integer.parseInt(request.getParameter("durationId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../adddurationoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../adddurationoptions.jsp");
                return;
            }




            DurationOptions dura = null;
            dura = mgr.deleteDurationOption(durationId);
            
            
           
            out.print("Duration Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Duration Option Deleted Successfully");
            response.sendRedirect("../adddurationoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../adddurationoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>