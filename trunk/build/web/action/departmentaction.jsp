<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
     Users user = (Users) session.getAttribute("staff");
            if(user == null){
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("units".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("name");

            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();
            Department unit = null;
            unit = mgr.addDepartment(unitName);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Department Saved Successfully!");
            
            response.sendRedirect("../adddepartment.jsp");
            out.print("Deparment Saved Successfully");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("id");

            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();

            mgr.deleteDepartment(Integer.parseInt(unitName));
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Department Deleted Successfully!");
            
            response.sendRedirect("../adddepartment.jsp");
            out.print("Deparment Successfully Removed");
            return;
        }
        if ("edit".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("uname");
            String id = request.getParameter("uid");

            if (unitName.equalsIgnoreCase("")) {
                out.print("Deparment Name is empty");
                return;
            }
            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();
            Department unit = null;
            unit = mgr.updateDepartment(Integer.parseInt(id), unitName);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Unit Edited Successfully!");
            
            response.sendRedirect("../adddepartment.jsp");
            out.print("Deparment Successfully Updated");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        out.print("There was a problem please try again");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>