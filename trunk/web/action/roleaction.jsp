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
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        HMSHelper mgr = new HMSHelper();
        if ("addrole".equals(request.getParameter("action"))) {
            String rolename = request.getParameter("rolename") == null ? "" : request.getParameter("rolename");
            String roledescription = request.getParameter("roledescription") == null ? "" : request.getParameter("roledescription");
            if (!rolename.isEmpty()) {
                Roletable roletable = mgr.addRole(rolename, roledescription);
                if (roletable != null) {
                    out.print("Role Successfully Added");
                    session.setAttribute("lasterror", "Role Successfully Added");
                    session.setAttribute("class", "alert-success");
                    response.sendRedirect("../addrole.jsp");
                    return;

                } else {
                    out.print("Role Name Cannot Be Empty!");
                    return;
                }

            }

            out.print("Role Successfully Added");
            session.setAttribute("lasterror", "Error Occured Please Try Again");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("../addrole.jsp");
            return;

        }



        if ("edit".equals(request.getParameter("action"))) {
            String rolename = request.getParameter("uname") == null ? "" : request.getParameter("uname");
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            String roledescription = request.getParameter("desc") == null ? "" : request.getParameter("desc");
            int id = 0;
            try {
                id = Integer.parseInt(uid);
            } catch (NumberFormatException ex) {
                out.print("Role Name Cannot Be Empty!");
                return;
            }
            if (!rolename.isEmpty() || !roledescription.isEmpty()) {
                Roletable roletable = mgr.updateRoletable(id, rolename, roledescription);
                if (roletable != null) {
                    out.print("Role Successfully Added");
                    session.setAttribute("lasterror", "Role Successfully Edited");
                    session.setAttribute("class", "alert-success");
                    response.sendRedirect("../addrole.jsp");
                    return;
                } else {
                    out.print("Role Name Cannot Be Empty!");
                    return;
                }

            }
            out.print("Role Name Cannot Be Empty!");
            return;

        }
        if ("delete".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == null ? "" : request.getParameter("id");
            int roleid = 0;
            try {
                roleid = Integer.parseInt(id);
            } catch (NumberFormatException ex) {
                out.print("Role Name Cannot Be Empty!");
                return;

            }
            //  if (!rolename.isEmpty()) {
            Roletable roletable = mgr.deleteRole(roleid);
            if (roletable != null) {
                out.print("Role Successfully Added");
                return;
            } else {
                out.print("Role Name Cannot Be Empty!");
                return;
            }


        }
        out.print("here at least");
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addrole.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>

