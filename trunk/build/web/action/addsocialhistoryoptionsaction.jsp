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

        if ("addsocialhistory".equals(request.getParameter("action"))) {
            String socialHistoryOption = null;
            



            try {
                socialHistoryOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            SocialHistories socHistoryOption = mgr.addSocialHistory(socialHistoryOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Social History Saved Successfully!");
            response.sendRedirect("../addsocialhistoryoptions.jsp");
            out.print("Social History Option Saved Successfully");
            return;
        }
        if ("editsocialhistory".equals(request.getParameter("action"))) {
            String socialHistoryOption = null;
            int socialHistoryOptionId = -1;
           
            try {
                socialHistoryOption = request.getParameter("option");
                socialHistoryOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addsocialhistoryoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addsocialhistoryoptions.jsp");
                return;
            }

            SocialHistories socialHistory = null;
            socialHistory = mgr.updateSocialHistory(socialHistoryOptionId, socialHistoryOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Social History Edited Successfully");
            response.sendRedirect("../addsocialhistoryoptions.jsp");
            return;
        }

        if ("deletesocialhistory".equals(request.getParameter("action"))) {

            int socialHistoryId = 1;

            try {

                socialHistoryId = Integer.parseInt(request.getParameter("socialHistoryId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addsocialhistoryoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addsocialhistoryoptions.jsp");
                return;
            }




            SocialHistories socHistory = null;
            socHistory = mgr.deleteSocialHistory(socialHistoryId);
            
            
           
            out.print("Social History Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Social History Deleted Successfully");
            response.sendRedirect("../addsocialhistoryoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addsocialhistoryoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>