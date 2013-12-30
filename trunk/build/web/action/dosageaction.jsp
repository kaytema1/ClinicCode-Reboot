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
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("dosage".equals(request.getParameter("action"))) {
            String shortcut = null;
            String description = null;

            try {
                shortcut = request.getParameter("shortcut");
                description = request.getParameter("description");
            } catch (NullPointerException e) {
                out.print("No field can be empty");
                return;
            }
          
            HMSHelper mgr = new HMSHelper();
            Dosage dosage = null;
            dosage = mgr.addDosage(shortcut, description);
            session.setAttribute("lasterror", "Shortcut Successfully Added");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../adddosage.jsp");
            out.print("Shortcut Successfully Added");
           return;
        }   
        if ("update".equals(request.getParameter("action"))) {
            
            String shortcut = null;
            String description = null;

            try {
                
                shortcut = request.getParameter("shortcut");
                description = request.getParameter("description");
            } catch (NullPointerException e) {
                out.print("No field can be empty");
                return;
            }
          
            HMSHelper mgr = new HMSHelper();
            Dosage dosage = null;
            dosage = mgr.updateDosage(shortcut,description);
            session.setAttribute("lasterror", "Shortcut Successfully Edited");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../adddosage.jsp");
            out.print("Shortcut Successfully Added");
            
           return;
        }
        if ("delete".equals(request.getParameter("action"))) {
            
            String shortcut = null;
            String description = null;
            //int id=0;

            try {
                shortcut = request.getParameter("shortcut");
              
            } catch (NumberFormatException e) {
                out.print("No field can be empty");
                return;
            }
          
            HMSHelper mgr = new HMSHelper();
            Dosage dosage = null;
            dosage = mgr.deleteDosage(shortcut);
            session.setAttribute("lasterror", "Shortcut Successfully Deleted");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../adddosage.jsp");
            out.print("Shortcut Successfully Deleted");
            
           return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../adddosage.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>