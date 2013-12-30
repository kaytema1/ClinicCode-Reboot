<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("allergy".equals(request.getParameter("action"))) {
            String name = null;
            String type = null;
            String reactions = null;
            String suggestions = null;

            try {
                name = request.getParameter("name");
                type = request.getParameter("type");
                reactions = request.getParameter("reaction");
                suggestions = request.getParameter("suggestion");

            } catch (NullPointerException e) {
                out.print("Please Try Again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Allergies ward = null;
            ward = mgr.addAllergiess(name, type, reactions, suggestions);
            out.print("Allergy Successfully Added");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Allergy Added Successfully");
            response.sendRedirect("../addallergy.jsp");
            return;
        }
        if ("allergyedit".equals(request.getParameter("action"))) {
            String name = null;
            int uid = -1;
            String rxn = null;
            String suggestion = null;
            String type = null;

            try {
                name = request.getParameter("uname");
                rxn = request.getParameter("rxn");
                suggestion = request.getParameter("suggestion");
                type = request.getParameter("type");
                uid = Integer.parseInt(request.getParameter("uid"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Allergies ward = null;
            ward = mgr.updateAllergies(uid, name, type, rxn, suggestion);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Allergy Edited Successfully");
            response.sendRedirect("../addallergy.jsp");
            out.print("Allergy Edited Successfully");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {

            int wardid = -1;

            try {

                wardid = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            };

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Allergies ward = null;
            ward = mgr.deleteAllergy(wardid);
            out.print("Allergy was successfully removed");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Allergy Removed Successfully");
            response.sendRedirect("../addallergy.jsp");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        session.setAttribute("class", "alert-error");
        session.setAttribute("lasterror", "Error Please Try Again");
        response.sendRedirect("../addallergy.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>