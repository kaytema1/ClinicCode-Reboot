<%-- 
    Document   : delete
    Created on : Jul 20, 2012, 2:18:04 PM
    Author     : lisandro
--%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="entities.Appoint"%>
<%@page import="entities.*"%>
<%@page import="helper.HibernateUtil"%>
<% try {
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        sess.beginTransaction();
        HMSHelper its = new HMSHelper();

        if ("deleteappointment".equals(request.getParameter("action"))) {
            
            String appId = request.getParameter("appPatient") == null ? null : request.getParameter("appPatient");
            System.out.println(appId);
            int appID = Integer.parseInt(appId.trim());
            its.deleteAppointment(appID);
            

            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Appointment Deleted Successfully");
            response.sendRedirect("../viewscheduled.jsp");
        }

        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("appointment.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        String q = request.getParameter("id").trim();
        int id = Integer.parseInt(q);


        its.honorAppointment(id);

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