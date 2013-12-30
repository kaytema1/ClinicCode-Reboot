<%-- 
    Document   : update
    Created on : Jul 20, 2012, 11:57:49 AM
    Author     : lisandro
--%>
<%@page import="java.util.List"%>
<%@page import="entities.*"%>
<%@page import="entities.HMSHelper"%>
<%@page import="helper.HibernateUtil"%>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("appointment.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        HMSHelper its = new HMSHelper();


        String start1 = request.getParameter("start");
        String allDay1 = request.getParameter("allday");
        String end1 = request.getParameter("end");
        String title = request.getParameter("title");
        String id = request.getParameter("id").trim();

        try {

            //List itmss = its.EditAppointment(title);
            Appoint appoint = its.getAppointmentById(Integer.parseInt(id));
        
            its.updateAppointment(start1, allDay1, end1, title, appoint.getDoctorId(), appoint.getPatientId(), appoint.getContent(), Integer.parseInt(id));

        } catch (NullPointerException e) {
            session.setAttribute("lasterror", "Appointment could not be updated");
            response.sendRedirect("../appointment.jsp");
            return;
        } catch (NumberFormatException e) {
            session.setAttribute("lasterror", "Appointment could not be updated");
            response.sendRedirect("../appointment.jsp");
            return;
        }


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