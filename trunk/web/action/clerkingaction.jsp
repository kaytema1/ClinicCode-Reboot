<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        HMSHelper mgr = new HMSHelper();


        if ("clerking".equals(request.getParameter("action"))) {
            String reviewQuestion = null;
            int category = 0;


            try {
                reviewQuestion = request.getParameter("name");
                category = Integer.parseInt(request.getParameter("category"));

            } catch (NullPointerException e) {
                session.setAttribute("lasterror", "Review Question Not Saved!");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../addclerking.jsp");
                out.print("Question field cannot be empty");
                return;

            }
            Clerkingquestion clerkingquestion = mgr.addClerkingQuestion(reviewQuestion, 0, category);
            session.setAttribute("lasterror", "Review Question Saved Successfully");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addclerking.jsp");
            out.print("Review Question Saved Successfully");
            return;
        }
        if ("editclerking".equals(request.getParameter("action"))) {
            String reviewQuestion = null;
            int reviewQuestionId = -1;
            int categoryId = -1;
            
            try {
                reviewQuestion = request.getParameter("name");
                reviewQuestionId  = Integer.parseInt(request.getParameter("questionId"));
                categoryId = Integer.parseInt(request.getParameter("category"));
                
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }
            
            Clerkingquestion ward = null;
            ward = mgr.updateClerking(reviewQuestionId, reviewQuestion,categoryId);
            session.setAttribute("lasterror", "Review Question Edited Successfully");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addclerking.jsp");
            out.print("Review Question Edited Successfully");
            return;
        }
        if ("deleteclerking".equals(request.getParameter("action"))) {

            int reviewQuestionId = -1;

            try {

                reviewQuestionId = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            
            Clerkingquestion reviewQuestion = null;
            reviewQuestion = mgr.deleteClerking(reviewQuestionId);
            session.setAttribute("lasterror", "Review Question Deleted Successfully");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addclerking.jsp");
            out.print("Review Question Deleted Successfully");
            return;
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addclerking.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>