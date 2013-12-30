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

        if ("addcategory".equals(request.getParameter("action"))) {
            String categoryName = null;
            boolean isActive = true;



            try {
                categoryName = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            ClerkingCategories category = mgr.addClerkingCategory(categoryName, isActive);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Category Saved Successfully!");
            response.sendRedirect("../addclerkingcategory.jsp");
            out.print(category.getCategoryName() + " Saved Successfully");
            return;
        }
        if ("editcategory".equals(request.getParameter("action"))) {
            String categoryName = null;
            int categoryId = -1;
            boolean isActive = true;
            try {
                categoryName = request.getParameter("uname");
                categoryId = Integer.parseInt(request.getParameter("uid"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;
            }

            ClerkingCategories category = null;
            category = mgr.updateClerkingCategory(categoryId, categoryName, isActive);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Edited Successfully");
            response.sendRedirect("../addclerkingcategory.jsp");
            return;
        }

        if ("deletecategory".equals(request.getParameter("action"))) {

            int categoryId = -1;

            try {

                categoryId = Integer.parseInt(request.getParameter("categoryId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                //response.sendRedirect("../addclerkingcategory.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                //response.sendRedirect("../addclerkingcategory.jsp");
                return;
            }




            ClerkingCategories category = null;
            category = mgr.deleteClerkingCategory(categoryId);
            categoryId = category.getId();
            
            List categoryQuestions = mgr.listClerkQuestionsbyCategoryId(categoryId);
            if (categoryQuestions != null) {
                for (int r = 0; r < categoryQuestions.size(); r++) {
                    Clerkingquestion clerkingquestion = (Clerkingquestion) categoryQuestions.get(r);
                    mgr.deleteQuestion(clerkingquestion.getClerkid());
                }
            }
            out.print("Category Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Category Deleted Successfully");
            //response.sendRedirect("../addclerkingcategory.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addclerkingcategory.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>