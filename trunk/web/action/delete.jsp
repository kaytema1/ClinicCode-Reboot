<%-- 
    Document   : delete
    Created on : Jul 20, 2012, 2:18:04 PM
    Author     : lisandro
--%>
<%@page import="java.util.List"%>
<%@page import="entities.Appoint"%>
<%@page import="entities.*"%>
<%@page import="helper.HibernateUtil"%>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("appointment.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        String q = request.getParameter("id").trim();
        int id = Integer.parseInt(q);
        
        HMSHelper its = new HMSHelper();
        its.deleteAppointment(id);

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../appointment.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>