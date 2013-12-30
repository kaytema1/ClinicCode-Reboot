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

        if ("groups".equals(request.getParameter("action"))) {
            String code = request.getParameter("name");
            String description = request.getParameter("description");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.addGroup(code, description);
            out.print("Category added successfully");
            return;
        }
        if ("editgroups".equals(request.getParameter("action"))) {
            String code = request.getParameter("code");
            String desc = request.getParameter("desc");
            if (desc.equalsIgnoreCase("") || code.equalsIgnoreCase("")) {
                out.println("field Cannot be empty");
                return;
            }
            //String conid = request.getParameter("uid");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.updateGroupings(code, desc);
            out.print("Category updated successfully");
            return;
        }
        if ("deletegroup".equals(request.getParameter("action"))) {
            String code = request.getParameter("id");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.deleteGroup(code);
            out.print("Category deleted successfully");
            return;
        }

        if ("coregroup".equals(request.getParameter("action"))) {
            String group = request.getParameter("group");
            String desc = request.getParameter("desc");
            String grdg = request.getParameter("gdrg");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.addCoreGroup(grdg, desc, group);
            out.print("added successfully");
            return;
        }
        if ("editcoregroup".equals(request.getParameter("action"))) {
            String group = request.getParameter("group");
            String desc = request.getParameter("desc");
            String id = request.getParameter("id");
            String gdrg = request.getParameter("gdrg");
            int intid = 0;
            if (desc.equalsIgnoreCase("") || group.equalsIgnoreCase("") || gdrg.equalsIgnoreCase("")) {
                out.println("field Cannot be empty");
                return;
            }
            try {
                intid = Integer.parseInt(id);
            } catch (NumberFormatException ex) {
                out.println("field Cannot be empty");
                return;
            }

            //String conid = request.getParameter("uid");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.updateGroupings(intid, desc, gdrg, group);
            out.print("updated successfully");
            return;
        }
        if ("deletecoregroup".equals(request.getParameter("action"))) {
            String code = request.getParameter("id");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.deleteCoreGroup(Integer.parseInt(code));
            out.print("deleted successfully");
            return;
        }

        if ("detaildiagnosis".equals(request.getParameter("action"))) {
            String icd10 = request.getParameter("icd10");
            String group = request.getParameter("group");
            String grdg = request.getParameter("gdrg");
            String diagnosis = request.getParameter("diagnosis");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.addNHISDiagnosis(grdg, diagnosis, icd10, group);
            out.print("added successfully");
            return;
        }
        if ("editdiagnosis".equals(request.getParameter("action"))) {
            String group = request.getParameter("group");
            String diag = request.getParameter("diag");
            String id = request.getParameter("id");
            String gdrg = request.getParameter("gdrg");
            String icd = request.getParameter("icd");
            int intid = 0;
            if (group.equalsIgnoreCase("") || diag.equalsIgnoreCase("") || gdrg.equalsIgnoreCase("")) {
                out.println("field Cannot be empty");
                return;
            }
            try {
                intid = Integer.parseInt(id);
            } catch (NumberFormatException ex) {
                out.println("field Cannot be empty");
                return;
            }

            //String conid = request.getParameter("uid");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.updateNHISDiagnosis(intid, diag, gdrg, icd, group);
            out.print("updated successfully");
            return;
        }
        if ("deletediagnosis".equals(request.getParameter("action"))) {
            String code = request.getParameter("id");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.deleteNHISDiagnosis(Integer.parseInt(code));
            out.print("deleted successfully");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        out.print("Consultation room could not be added please try again");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>