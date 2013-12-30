<%-- 
    Document   : addDrugAction
    Created on : Jan 1, 2013, 2:26:15 AM
    Author     : ddr
--%>

<%@page import="entities.Stafftable"%>
<%@page import="entities.TransactionEntityManager"%>
<%@page import="java.util.Date"%>
<%@page import="entities.PurchaseOrder"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="entities.Supplier"%>
<%@page import="entities.InventoryItems"%>
<%@page import="entities.PurchaseOrderItems"%>
<%@page import="helper.HibernateUtil"%>
<%@page import="entities.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    /**
     * ************ Adding a User ****************
     */
    Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        TransactionEntityManager method = new TransactionEntityManager();
    if (request.getParameter("action").equals("additem")) {

        PurchaseOrderItems purchaseOrderItems = new PurchaseOrderItems();
        InventoryItems ii = new InventoryItems();
        String[] items = request.getParameterValues("items");
        
        if (items != null || items.length > 0) {
            
            //Set<PurchaseOrderItems> purchaseOrderItemses = new HashSet<PurchaseOrderItems>();
            PurchaseOrder purchaseOrder = new PurchaseOrder();
            purchaseOrder.setDateOfOrder(new Date());
            Stafftable u = new Stafftable();
            
            Stafftable stafftable = (Stafftable)method.getStringObject(u, user.getStaffid());
            System.out.println("stafftable ");
            purchaseOrder.setStafftableByOrderingStaff(stafftable);
            purchaseOrder.setStatus("Pending");
            purchaseOrder.setLocation("Warehouse");
           // purchaseOrder.setStafftableByOrderingStaff(stafftableByOrderingStaff);
           // purchaseOrder.setPurchaseOrderItemses(purchaseOrderItemses);
            method.save(purchaseOrder);
            //if (items.length > 0 && quantities.length > 0) {
            for (int i = 0; i < items.length; i++) {
                int qty = Integer.parseInt(request.getParameter("quantity_"+items[i]));
                InventoryItems inventoryItem = (InventoryItems) method.getStringObject(ii, items[i]);
                purchaseOrderItems.setInventoryItems(inventoryItem);
                purchaseOrderItems.setPurchaseOrder(purchaseOrder);
                purchaseOrderItems.setQuantityOrdered(qty);
                purchaseOrderItems.setQuantityDelivered(0);
                method.save(purchaseOrderItems);
            }
        }
        // objectSession.getTransaction().commit();
        response.sendRedirect("../purchaseorder.jsp");
        //return;
    }
    if (request.getParameter("action").equals("deleteorder")) {
        String code = request.getParameter("orderid");
        PurchaseOrder purchaseOrder1 = new PurchaseOrder();
        PurchaseOrder purchaseOrder = (PurchaseOrder) method.getIntegerObject(purchaseOrder1, Integer.parseInt(code));
        method.delete(purchaseOrder);
        response.sendRedirect("../purchaseorder.jsp");
    }
    if ("updateqty".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == "" ? "" : request.getParameter("id");
            String qtys = request.getParameter("qty") == "" ? "" : request.getParameter("qty");
            //String pageid = request.getParameter("page") == "" ? "" : request.getParameter("page");
            int qty = -1;
            int ids = -1;
            try {
                qty = Integer.parseInt(qtys);
                ids = Integer.parseInt(id);
                PurchaseOrderItems requisition = new PurchaseOrderItems();
                PurchaseOrderItems r = (PurchaseOrderItems)method.getIntegerObject(requisition, ids);
                r.setQuantityOrdered(qty);
                PurchaseOrderItems requisitions = (PurchaseOrderItems)method.update(r);
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Request Edited Successfully");
                //response.sendRedirect("../dispensarymakerequest.jsp");
                out.print("Changes saved");
            } catch (NumberFormatException e) {
                out.print("Quantity field cannot be empty");
                // Requisition requisitions = mgr.updateRequisition(ids, code, qty);
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Complete All Fields");
                //response.sendRedirect("../dispensarymakerequest.jsp");
            } catch (NullPointerException e) {
                out.print("Sorry try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Complete All Fields");
                //response.sendRedirect("../dispensarymakerequest.jsp");
            }
        }
    if (request.getParameter("action").equals("deleteitems")) {
        String[] items = request.getParameterValues("items");
        if (items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                PurchaseOrderItems purchaseOrderItems1 = new PurchaseOrderItems();
                PurchaseOrderItems purchaseOrderItems = (PurchaseOrderItems) method.getIntegerObject(purchaseOrderItems1, Integer.parseInt(items[i]));
                method.delete(purchaseOrderItems);
            }
        }
        //objectSession.getTransaction().commit();
        response.sendRedirect("../purchaseorder.jsp");
    }
    if (request.getParameter("action").equals("managerapproveorder")) {
        String code = request.getParameter("orderid");
        String status ="Pending";
        PurchaseOrder purchaseOrder1 = new PurchaseOrder();
        PurchaseOrder purchaseOrder = (PurchaseOrder) method.getIntegerObject(purchaseOrder1, Integer.parseInt(code));
        if(purchaseOrder.getStafftableByApprovedByAccount() != null){
            status = "Approved";
        }
        Stafftable s = new Stafftable();
        Stafftable stafftable = (Stafftable)method.getStringObject(s, user.getStaffid());
        purchaseOrder.setStafftableByApprovedByManager(stafftable);
        purchaseOrder.setStatus(status);
        method.update(purchaseOrder);
        response.sendRedirect("../managerpurchaseorder.jsp");
    }
        if (request.getParameter("action").equals("accountsapproveorder")) {
        String code = request.getParameter("orderid");
        String status = "Pending";
        PurchaseOrder purchaseOrder1 = new PurchaseOrder();
        PurchaseOrder purchaseOrder = (PurchaseOrder) method.getIntegerObject(purchaseOrder1, Integer.parseInt(code));
        if(purchaseOrder.getStafftableByApprovedByManager() != null){
            status = "Approved";
        }
        Stafftable s = new Stafftable();
        Stafftable stafftable = (Stafftable)method.getStringObject(s, user.getStaffid());
        purchaseOrder.setStafftableByApprovedByAccount(stafftable);
        purchaseOrder.setStatus(status);
        method.update(purchaseOrder);
        response.sendRedirect("../accountspurchaseorder.jsp");
    }
    if (request.getParameter("action").equals("submitorder")) {
        String code = request.getParameter("orderid");
        PurchaseOrder purchaseOrder1 = new PurchaseOrder();
        PurchaseOrder purchaseOrder = (PurchaseOrder) method.getIntegerObject(purchaseOrder1, Integer.parseInt(code));
        purchaseOrder.setStatus("Submitted");
        method.update(purchaseOrder);
        response.sendRedirect("../submittedorders.jsp");
    }
    if (request.getParameter("action").equals("additems")) {
        String code = request.getParameter("orderid");
        PurchaseOrder purchaseOrder1 = new PurchaseOrder();
        PurchaseOrder purchaseOrder = (PurchaseOrder) method.getIntegerObject(purchaseOrder1, Integer.parseInt(code));
        String[] items = request.getParameterValues("items");
        String[] quantities = request.getParameterValues("quantity");
        if (items.length > 0 && quantities.length > 0) {
            for (int i = 0; i < items.length; i++) {
                PurchaseOrderItems purchaseOrderItems = new PurchaseOrderItems();
                InventoryItems ii = new InventoryItems();
                InventoryItems inventoryItem = (InventoryItems) method.getStringObject(ii, items[i]);
                purchaseOrderItems.setInventoryItems(inventoryItem);
                purchaseOrderItems.setPurchaseOrder(purchaseOrder);
                purchaseOrderItems.setQuantityOrdered(Integer.parseInt(quantities[i]));
                method.save(purchaseOrderItems);
            }
        }
        //objectSession.getTransaction().commit();
        response.sendRedirect("../purchaseorder.jsp");
    }
    //out.print(num);
%>
