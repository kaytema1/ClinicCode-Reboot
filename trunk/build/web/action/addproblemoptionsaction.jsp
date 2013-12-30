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

        if ("addproblem".equals(request.getParameter("action"))) {
            String problemOption = null;
            



            try {
                problemOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            ProblemOptions probOption = mgr.addProblemOptions(problemOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Problem Option Saved Successfully!");
            response.sendRedirect("../addproblemoptions.jsp");
            out.print("Problem Option Option Saved Successfully");
            return;
        }
        if ("editproblem".equals(request.getParameter("action"))) {
            String problemOption = null;
            int problemOptionId = -1;
           
            try {
                problemOption = request.getParameter("option");
                problemOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addproblemoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addproblemoptions.jsp");
                return;
            }

            ProblemOptions problem = null;
            problem = mgr.updateProblemOptions(problemOptionId, problemOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Problem Option Edited Successfully");
            response.sendRedirect("../addproblemoptions.jsp");
            return;
        }

        if ("deleteproblem".equals(request.getParameter("action"))) {

            int problemId = 1;

            try {

                problemId = Integer.parseInt(request.getParameter("problemId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addproblemoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addproblemoptions.jsp");
                return;
            }




            ProblemOptions cond = null;
            cond = mgr.deleteProblemOption(problemId);
            
            
           
            out.print("Problem Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Problem Option Deleted Successfully");
            response.sendRedirect("../addproblemoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addproblemoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>