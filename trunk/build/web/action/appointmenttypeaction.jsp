<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }

        System.out.println("+++++++++++++++++++++++++");


        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("apType".equals(request.getParameter("action"))) {
            String name = request.getParameter("name");
            String desc = request.getParameter("desc");

            HMSHelper mgr = new HMSHelper();
            AppointmentType apType = null;
            apType = mgr.addAppointmentType(name, desc, user.getStaffid(), new java.sql.Date(new java.util.Date().getTime()));
            out.print("Appointment Type Successfully Added");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Appointment Type Added Successfully");

            response.sendRedirect("../addappointmenttype.jsp");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("id");

            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();

            mgr.deleteAppointmentType(Integer.parseInt(unitName));
            out.print("Appointment Type Successfully Removed");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Appointment Type Removed Successfully");
            response.sendRedirect("../addappointmenttype.jsp");
            return;
        }
        if ("edit".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("uname");
            String description = request.getParameter("udescription");
            int id = Integer.parseInt(request.getParameter("uid"));

            if (unitName.equalsIgnoreCase("")) {
                out.print("Lab Type Name is empty");
                return;
            }
            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();
            AppointmentType unit = null;
            unit = mgr.updateAppointmentType(id, unitName, description);
            out.print("Appointment Type Successfully Updated");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Appointment Type Deleted Successfully");
            response.sendRedirect("../addappointmenttype.jsp");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        out.print("There was a problem please try again");
        response.sendRedirect("../addappointmenttype.jsp");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>