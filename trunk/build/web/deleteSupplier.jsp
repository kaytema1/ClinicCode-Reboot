<%-- 
    Document   : deleteSupplier
    Created on : Jul 9, 2012, 12:44:52 PM
    Author     : Lisandro
--%>


<%@page import="helper.HibernateUtil"%>
<%@page import="entities.*"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Users user = (Users) session.getAttribute("staff");
            if(user == null){
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            } %>
<!DOCTYPE html>
<%
    try {

        //HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        String id1 = request.getParameter("id");
        int id = Integer.parseInt(id1);
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        HMSHelper itm = new HMSHelper();

        Post itmss = itm.deleteSupplier(id);



        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("listSuppliers.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    }








%>