<%-- 
    Document   : updatetitle
    Created on : Jul 22, 2012, 10:13:25 AM
    Author     : lisandro
--%>

<%@page import="java.util.List"%>
<%@page import="entities.*"%>
<%@page import="entities.HMSHelper"%>
<%@page import="helper.HibernateUtil"%>
<% try {
    Users current = (Users) session.getAttribute("staff");
            if(current == null){
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("appointment.jsp");
            }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();




        String title = request.getParameter("newtitle");
        String start = request.getParameter("start");

        HMSHelper its = new HMSHelper();
        List itmss = its.EditTitle(start);
        for (int i = 0; i < itmss.size(); i++) {
            Appoint app = (Appoint) itmss.get(i);
            String doctorId = app.getDoctorId();
            String patientId = app.getPatientId();
            String allDay = app.getAllday();
            String content = app.getContent();
            // String start =  app.getStart();
            String end = app.getEnd();
            int id = app.getId();
            System.out.println(title + "allDay" + allDay);

            System.out.println("ere");



            Appoint updateApp = null;

            updateApp = its.updateAppointment(start, allDay, end, title, doctorId, patientId, content, id);

            session.setAttribute("item", updateApp);
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