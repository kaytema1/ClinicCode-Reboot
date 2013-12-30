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

        if ("symptom".equals(request.getParameter("action"))) {
            String wardName = null;
            
            try {
                wardName = request.getParameter("name");
               
            }catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Symptoms ward = null;
            ward = mgr.addSymptom(wardName);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Symptom Added Successfully");
            response.sendRedirect("../addsymptom.jsp");
            out.print("Symptom successfully Added");
            return;
        }
        if ("symptomedit".equals(request.getParameter("action"))) {
            String wardName = null;
            int numberOfBeds = -1;
            int wardid = numberOfBeds - 1;
            
            try {
                wardName = request.getParameter("uname");
               
                wardid = Integer.parseInt(request.getParameter("uid"));
               
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Symptoms ward = null;
            ward = mgr.updateSymptom(wardid, wardName);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Symptom Edited Successfully");
            response.sendRedirect("../addsymptom.jsp");
            out.print("Symptom Added Successfully");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {

            int wardid = -1;

            try {

                wardid = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            } ;

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Symptoms ward = null;
            ward = mgr.deleteSymptom(wardid);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Symptom Deleted Successfully");
            response.sendRedirect("../addsymptom.jsp");
            out.print("Symptom was successfully removed");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addsymptom.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>