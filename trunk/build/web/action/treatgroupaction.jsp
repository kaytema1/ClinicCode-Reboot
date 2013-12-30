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
            //String code = request.getParameter("name");
            String description = request.getParameter("description");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.addTherapeuticGroup(description);
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
            mgr.updateTherapeuticGroup(Integer.parseInt(code), desc);
            out.print("Category updated successfully");
            return;
        }
        if ("deletegroup".equals(request.getParameter("action"))) {
            String code = request.getParameter("id");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.deleteTherapeuticGroup(Integer.parseInt(code));
            out.print("Category deleted successfully");
            return;
        }

        if ("detailtreatment".equals(request.getParameter("action"))) {

            String diagnosticgroup = request.getParameter("group");
            String medicine = request.getParameter("treatment");
            String gdrg = request.getParameter("gdrg");
            String cost = request.getParameter("price");
            String groupid = request.getParameter("tgroup");
            String unitprice = request.getParameter("uprice");
            if (diagnosticgroup.equals("") || medicine.equalsIgnoreCase("") || gdrg.equalsIgnoreCase("") || unitprice.equalsIgnoreCase("")) {
                out.print("No field cannot be empty");
                return;
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            double price = 0.0;
            int therapeuticgroup = 0;
            try {
                price = Double.parseDouble(cost);
                therapeuticgroup = Integer.parseInt(groupid);
            } catch (NumberFormatException ex) {

                out.print("Price field cannot be empty");
                return;
            }
            mgr.addNhistreatment(medicine, unitprice, price, gdrg, therapeuticgroup, diagnosticgroup);
            out.print("added successfully");
            return;
        }
        if ("edittreatment".equals(request.getParameter("action"))) {
            String diagnosticgroup = request.getParameter("group");
            String medicine = request.getParameter("treat");
            String gdrg = request.getParameter("gdrg");
            String cost = request.getParameter("price");
            String groupid = request.getParameter("tgroup");
            String unitprice = request.getParameter("uprice");
            String id = request.getParameter("id");
            if (diagnosticgroup.equals("") || medicine.equalsIgnoreCase("") || gdrg.equalsIgnoreCase("") || unitprice.equalsIgnoreCase("")) {
                out.print("No field cannot be empty");
                return;
            }
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            double price = 0.0;
            int therapeuticgroup = 0;
            int tid = 0;
            try {
                price = Double.parseDouble(cost);
                therapeuticgroup = Integer.parseInt(groupid);
                tid = Integer.parseInt(id);
            } catch (NumberFormatException ex) {

                out.print("Price field cannot be empty");
                return;
            }
            mgr.updateNhistreatment(tid, medicine, unitprice, price, gdrg, therapeuticgroup, diagnosticgroup);
            out.print("added successfully");
            return;
        }
        if ("deletetreatment".equals(request.getParameter("action"))) {
            String code = request.getParameter("id");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            mgr.deleteNhistreatment(Integer.parseInt(code));
            return;
        }
        if ("treatmentbatch".equals(request.getParameter("action"))) {
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            String batch = request.getParameter("batch");
            ItemsTable itemsTable = (ItemsTable) mgr.getItemTable(batch.trim());
            mgr.addNewTreament(batch, mgr.getStockItem(itemsTable.getCode()).getDescription(), itemsTable.getPurchasingprice(), mgr.getStockItem(itemsTable.getCode()).getIcd10(), itemsTable.getCode(), 0);
            out.print("added to dispensary inventory successfully");
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