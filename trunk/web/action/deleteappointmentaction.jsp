<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();


        if ("deleteappointment".equals(request.getParameter("action"))) {

            int appointmentid = -1;

            try {

                appointmentid = Integer.parseInt(request.getParameter("appPatient"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            };

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Appoint appointment = null;
            appointment = mgr.deleteAppointment(appointmentid);
            out.print("Symptom was successfully removed");
            
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../viewscheduled.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>