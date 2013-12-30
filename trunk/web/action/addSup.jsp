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

        if ("addsupplier".equals(request.getParameter("action"))) {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            Supplier it = null;
            it = mgr.addSupplierProper(name, address, telephone, email);
            //session.setAttribute("item", it);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Supplier Saved Successfully!");
            response.sendRedirect("../addSupplier.jsp");
            out.print("Supplier Saved Successfully!");
            return;
        }
        if ("editsupplier".equals(request.getParameter("action"))) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            Supplier it = null;
            it = mgr.updateSupplier(Integer.parseInt(id), name, address, telephone, email);
            session.setAttribute("item", it);
            session.setAttribute("class", "alert-success");

            session.setAttribute("lasterror", "Supplier Modified Successfully!");
            response.sendRedirect("../addSupplier.jsp");
            out.print("Changes saved successfully");
            return;
        }
        if ("deletesupplier".equals(request.getParameter("action"))) {
            String name = request.getParameter("id");
            mgr.deleteSupplierByid(Integer.parseInt(name));
            session.setAttribute("class", "alert-success");

            session.setAttribute("lasterror", "Supplier Modified Successfully!");
            response.sendRedirect("../addSupplier.jsp");
            out.print("Supplier successfully remove");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addSupplier.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            session.setAttribute("class", "alert-error");

            session.setAttribute("lasterror", "Please Try Again!");
            response.sendRedirect("../addSupplier.jsp");
            throw (ServletException) ex;
            
        } else {
            session.setAttribute("class", "alert-error");

            session.setAttribute("lasterror", "Please Try Again!");
            response.sendRedirect("../addSupplier.jsp");
            throw new ServletException(ex);
        }
    }%>