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

        if ("addprocedure".equals(request.getParameter("action"))) {
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            double cost = Double.parseDouble(price);

            Procedure it = null;
            it = mgr.addProcedure(code, description, cost);
            session.setAttribute("item", it);
            out.print("Procedure successfully added");
            return;
        }
        if ("editprocedure".equals(request.getParameter("action"))) {
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String price = request.getParameter("price");

            Procedure it = null;
            double cost = Double.parseDouble(price);
            it = mgr.updateProcedure(code, description, cost);
            session.setAttribute("item", it);
            out.print("Changes saved successfully");
            return;
        }
        if ("deleteprocedure".equals(request.getParameter("action"))) {
            String name = request.getParameter("id");
            mgr.deleteProcedure(name);
            out.print("Procedure successfully removed");
            return;
        }
        if ("Procedure Receipt".equals(request.getParameter("action"))) {
            String amountdue = request.getParameter("amountdue");
            String order = request.getParameter("orderid");
            mgr.updateProcedureorders(Integer.parseInt(order), Double.parseDouble(amountdue));
            mgr.updateProcedureorders(Integer.parseInt(order), "Dispensary");
            out.print("Procedure successfully updated");
            return;
        }
        if ("Forward to Dispense".equals(request.getParameter("action"))) {
            String order = request.getParameter("orderid");
            // mgr.updateProcedureorders(Integer.parseInt(order), Double.parseDouble(amountdue));
            mgr.updateProcedureorders(Integer.parseInt(order), "Dispensed");
            session.setAttribute("lasterror", "Saved soccessfully");
            response.sendRedirect("../procedurerequest.jsp");
            return;
        }
        if ("Procedure Performed".equals(request.getParameter("action"))) {
            String order = request.getParameter("orderid");
            // mgr.updateProcedureorders(Integer.parseInt(order), Double.parseDouble(amountdue));
            mgr.updateProcedureorders(Integer.parseInt(order), "Performed");
            session.setAttribute("lasterror", "Saved soccessfully");
            response.sendRedirect("../readyprocedures.jsp");
            return;
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("addprocedure.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>