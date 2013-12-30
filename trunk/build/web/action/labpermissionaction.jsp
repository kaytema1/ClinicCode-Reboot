<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
    Users current = (Users) session.getAttribute("staff");
            if(current == null){
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("units".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("name");
            int department = Integer.parseInt(request.getParameter("department"));
            HMSHelper mgr = new HMSHelper();
            Permission unit = null;
            unit = mgr.addPermission(unitName,1);
            out.print("Permission Successfully Added");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("id");

            HMSHelper mgr = new HMSHelper();

            mgr.deletePermission(Integer.parseInt(unitName));
            out.print("Permission Successfully Removed");
            return;
        }
        if ("edit".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("uname");
            String id = request.getParameter("uid");

            if (unitName.equalsIgnoreCase("")) {
                out.print("Permission Name is empty");
                return;
            }
            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();
            Permission unit = null;
            unit = mgr.updatePermission(Integer.parseInt(id), unitName);
            out.print("Permission Successfully Updated");
            return;
        }
        if ("setpermission".equals(request.getParameter("action"))) {
            HMSHelper mgr = new HMSHelper();
            String[] permissions = request.getParameterValues("permission[]") == null ? new String[0] : request.getParameterValues("permission[]");
            String staffid = request.getParameter("staffid");
            List perms = mgr.listStaffPermissions(staffid);
            for (int p = 0; p < perms.size(); p++) {
                StaffPermission staffPermission = (StaffPermission) perms.get(p);
                mgr.deleteStaffPermissionWhereStaffid(staffPermission.getId());
            }
            if (permissions.length > 0) {
                for (int i = 0; i < permissions.length; i++) {
                   mgr.addStaffPermission(Integer.parseInt(permissions[i]), staffid);
                }
                out.print("Permissions set for staff");
                response.sendRedirect("../labstaffmanagement.jsp");
                return;
            }
            //for()
            out.print("Please select permissions for the staff");
            response.sendRedirect("../labstaffmanagement.jsp");
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