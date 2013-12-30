<%-- 
    Document   : saveDrugType
    Created on : Jul 17, 2012, 8:57:11 AM
    Author     : lisandro
--%>

<%@page import="entities.*"%>

<%@page import="helper.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<% Users user = (Users) session.getAttribute("staff");
            if(user == null){
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            } %>

<% try {
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
       

        if ("Add Drug Type".equals(request.getParameter("addDrugType"))) {
            String drugType = request.getParameter("drugType");
            
            String q = request.getParameter("id");
            int id = Integer.parseInt(q);
            
        

System.out.println(drugType+"" );
        System.out.println("ere");
           

           HMSHelper its = new HMSHelper();
            Drugtype it = null;
            

            it = its.addDrugType(drugType);
         
            session.setAttribute("item", it);
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("application.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>