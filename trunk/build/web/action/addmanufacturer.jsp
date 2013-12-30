<%-- 
    Document   : addSup
    Created on : Jul 5, 2012, 5:56:46 PM
    Author     : Lisandro
--%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<% try {
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();

        if ("addmanufacturer".equals(request.getParameter("action"))) {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            Manufacturer it = null;
            it = mgr.addManufacturer(name, telephone, address, email);
            session.setAttribute("item", it);
            out.print("Manufacturer Added Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Manufacturer Added Successfully");
            response.sendRedirect("../addmanufacturer.jsp");
            return;
        }
        if ("editmanufacturer".equals(request.getParameter("action"))) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            Manufacturer it = null;
            it = mgr.updateManufaturer(Integer.parseInt(id), name, telephone, address, email);
            session.setAttribute("item", it);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Manufacturer Edited Successfully");
            response.sendRedirect("../addmanufacturer.jsp");
            
            out.print("Changes saved successfully");
            return;
        }
        if ("deletemanufacturer".equals(request.getParameter("action"))) {
            String name = request.getParameter("id");
            mgr.deleteManufacturer(Integer.parseInt(name));
            out.print("Manufacturer successfully remove");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Manufacturer Removed Successfully");
            response.sendRedirect("../addmanufacturer.jsp");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addmanufacturer.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>