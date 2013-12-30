<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("login".equals(request.getParameter("action"))) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String unit = request.getParameter("unit");
            if (username.equals("") || password.equals("") || unit.equals("")) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Sorry, Please Complete All Fields !");
                response.sendRedirect("../index.jsp");
                return;
            }

            HMSHelper mgr = new HMSHelper();
            Boolean exists = mgr.findUserById(username);
            Users user = null;
            if (exists) {
                user = mgr.getUserById(username);

            } else {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Username Doesn't Exist");
                response.sendRedirect("../index.jsp");
                return;

            }
            //List list = mgr.login(username, password);
            // String[] redirect = unit.split("_");
            //Password password1 = new Password();
            if (Password.check(password, user.getPassword())) {
                session.setAttribute("lasterror", "Signed in Successfully");
                session.setAttribute("class", "alert-success");
                session.setAttribute("staff", user);
                //session.setAttribute("staffPermission", user);
                List staffPermission = mgr.listStaffPermissions(user.getStaffid());
                StaffPermission permission = null;
                ArrayList<Integer> permissionIds = new ArrayList<Integer>();
                if (staffPermission.size() > 0 || staffPermission != null) {
                    for (int i = 0; i < staffPermission.size(); i++) {
                        permission = (StaffPermission) staffPermission.get(i);
                        if (permission != null) {
                            permissionIds.add(permission.getPermissionid());
                        }
                    }

                }
                session.setAttribute("staffPermission", permissionIds);
                int role = mgr.getStafftableByid(user.getStaffid()).getRole();
                if (unit.equals("Clinic")) {
                    response.sendRedirect("../clinicreception.jsp");
                    session.setAttribute("unit", unit);
                    session.setAttribute("role", role);
                    return;
                }
                if (unit.equals("Pharmacy")) {
                    response.sendRedirect("../pharmacyreception.jsp");
                    session.setAttribute("unit", unit);
                    session.setAttribute("role", role);
                    return;
                }
                if (unit.equals("Diagnostics")) {
                    response.sendRedirect("../labregistration.jsp");
                    session.setAttribute("unit", unit);
                    session.setAttribute("role", role);
                    return;
                }
                if (unit.equals("General Accounting")) {
                    response.sendRedirect("../accountreception.jsp");
                    session.setAttribute("unit", unit);
                    session.setAttribute("role", role);
                    return;
                }
                if (unit.equals("Stores & Inventory")) {
                    response.sendRedirect("../dashboard.jsp");
                    session.setAttribute("unit", unit);
                    session.setAttribute("role", role);
                    return;
                }
            }
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "Invalid Username or Password");
            response.sendRedirect("../index.jsp");
            return;

        }


        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        session.setAttribute("class", "alert-error");
        session.setAttribute("lasterror", "Invalid Username or Password");
        response.sendRedirect("../index.jsp");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>