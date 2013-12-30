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

        if ("addaggrevation".equals(request.getParameter("action"))) {
            String aggrevationOption = null;
            



            try {
                aggrevationOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            AggrevationOptions aggravOption = mgr.addAggrevationOptions(aggrevationOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Aggrevation Option Saved Successfully!");
            response.sendRedirect("../addaggrevationoptions.jsp");
            out.print("Aggrevation Option Option Saved Successfully");
            return;
        }
        if ("editaggrevation".equals(request.getParameter("action"))) {
            String aggrevationOption = null;
            int aggrevationOptionId = -1;
           
            try {
                aggrevationOption = request.getParameter("option");
                aggrevationOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addaggrevationoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addaggrevationoptions.jsp");
                return;
            }

            AggrevationOptions aggrevation = null;
            aggrevation = mgr.updateAggrevationOptions(aggrevationOptionId, aggrevationOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Aggrevation Option Edited Successfully");
            response.sendRedirect("../addaggrevationoptions.jsp");
            return;
        }

        if ("deleteaggrevation".equals(request.getParameter("action"))) {

            int aggrevationId = 1;

            try {

                aggrevationId = Integer.parseInt(request.getParameter("aggrevationId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addaggrevationoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addaggrevationoptions.jsp");
                return;
            }




            AggrevationOptions aggrav = null;
            aggrav = mgr.deleteAggrevationOption(aggrevationId);
            
            
           
            out.print("Aggrevation Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Aggrevation Option Deleted Successfully");
            response.sendRedirect("../addaggrevationoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addaggrevationoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>