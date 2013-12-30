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

        if ("addbodypart".equals(request.getParameter("action"))) {
            String bodyPartOption = null;
            



            try {
                bodyPartOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            BodyPartOptions bPartOption = mgr.addBodyPartOptions(bodyPartOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Body Part Option Saved Successfully!");
            response.sendRedirect("../addbodypartoptions.jsp");
            out.print("Body Part Option Option Saved Successfully");
            return;
        }
        if ("editbodypart".equals(request.getParameter("action"))) {
            String bodyPartOption = null;
            int bodyPartOptionId = -1;
           
            try {
                bodyPartOption = request.getParameter("option");
                bodyPartOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addbodypartoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addbodypartoptions.jsp");
                return;
            }

            BodyPartOptions bodyPart = null;
            bodyPart = mgr.updateBodyPartOptions(bodyPartOptionId, bodyPartOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Body Part Option Edited Successfully");
            response.sendRedirect("../addbodypartoptions.jsp");
            return;
        }

        if ("deletebodypart".equals(request.getParameter("action"))) {

            int bodyPartId = 1;

            try {

                bodyPartId = Integer.parseInt(request.getParameter("bodyPartId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addbodypartoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addbodypartoptions.jsp");
                return;
            }




            BodyPartOptions bPart = null;
            bPart = mgr.deleteBodyPartOption(bodyPartId);
            
            
           
            out.print("Body Part Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Body Part Option Deleted Successfully");
            response.sendRedirect("../addbodypartoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addbodypartoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>