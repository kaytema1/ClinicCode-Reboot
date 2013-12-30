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

        if ("addrelief".equals(request.getParameter("action"))) {
            String reliefOption = null;
            



            try {
                reliefOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            ReliefOptions relOption = mgr.addReliefOptions(reliefOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Relief Option Saved Successfully!");
            response.sendRedirect("../addreliefoptions.jsp");
            out.print("Relief Option Option Saved Successfully");
            return;
        }
        if ("editrelief".equals(request.getParameter("action"))) {
            String reliefOption = null;
            int reliefOptionId = -1;
           
            try {
                reliefOption = request.getParameter("option");
                reliefOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addreliefoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addreliefoptions.jsp");
                return;
            }

            ReliefOptions relief = null;
            relief = mgr.updateReliefOptions(reliefOptionId, reliefOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Relief Option Edited Successfully");
            response.sendRedirect("../addreliefoptions.jsp");
            return;
        }

        if ("deleterelief".equals(request.getParameter("action"))) {

            int reliefId = 1;

            try {

                reliefId = Integer.parseInt(request.getParameter("reliefId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addreliefoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addreliefoptions.jsp");
                return;
            }




            ReliefOptions rel = null;
            rel = mgr.deleteReliefOption(reliefId);
            
            
           
            out.print("Relief Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Relief Option Deleted Successfully");
            response.sendRedirect("../addreliefoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addreliefoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>