<%-- 
    Document   : addDrugAction
    Created on : Jan 1, 2013, 2:26:15 AM
    Author     : ddr
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="entities.Stafftable"%>
<%@page import="entities.PurchaseOrderItems"%>
<%@page import="entities.ItemBatch"%>
<%@page import="entities.Invoice"%>
<%@page import="entities.ExtendedHMSHelper"%>
<%@page import="entities.TransactionEntityManager"%>
<%@page import="entities.InventoryItems"%>
<%@page import="entities.Supplier"%>
<%@page import="entities.PurchaseOrder"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
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
        response.sendRedirect("index.jsp");
    }
    HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
    TransactionEntityManager mgr = new TransactionEntityManager();
    ExtendedHMSHelper mg = new ExtendedHMSHelper();
    Date dt = new Date();
        DateFormat ft;
        ft = new SimpleDateFormat("yyyy-MM-dd");
    if (request.getParameter("action").equals("addgoods")) {
        Invoice invoice = new Invoice();
        ItemBatch batch = new ItemBatch();
        InventoryItems inventoryItems = new InventoryItems();
        PurchaseOrder order = new PurchaseOrder();
        PurchaseOrderItems items = new PurchaseOrderItems();
        Supplier s = new Supplier();
        Stafftable s1 = new Stafftable();
        Stafftable stafftable = (Stafftable)mgr.getStringObject(s1, user.getStaffid());
        //List goods = method.listObjects("from GoodsReceived");
        //int num = users.size() + 1;
        String orderid = request.getParameter("orderid");
        PurchaseOrder purchaseOrder = (PurchaseOrder) mgr.getIntegerObject(order, Integer.parseInt(orderid));
        String supplierinv = request.getParameter("supplierinv");
        String supplierid = request.getParameter("supplier");
        String invoicedate = request.getParameter("invoicedate");
        String percentagediscount = request.getParameter("percentagediscount");
        String pricediscount = request.getParameter("pricediscount");
        String comment = request.getParameter("comment");

        String discount = request.getParameter("netdiscount");
        String nettotal = request.getParameter("nettotal");
        String totalTax = request.getParameter("totaltax");
        String subtotal = request.getParameter("subtotal");
        //String[] modules = request.getParameterValues("modules");
        String[] itemcodes = request.getParameterValues("itemcode");
        String[] batchnumbers = request.getParameterValues("batchnumber");
        String[] qtyreceiveds = request.getParameterValues("qtyreceived");
        String[] totalamount = request.getParameterValues("totalamount");
        String[] purchaseprices = request.getParameterValues("purchaseprice");
        String[] taxedtotalamount = request.getParameterValues("taxedtotalamount");
        String[] taxamount = request.getParameterValues("taxamount_");
        String[] discounts = request.getParameterValues("discount_");
        String[] nettotals = request.getParameterValues("nettotal_");
        String[] expireDates = request.getParameterValues("expiredate");
        //String[] warehouses = request.getParameterValues("warehouse");
        //System.out.println("here " + orderid);
        if (items != null && itemcodes.length == batchnumbers.length && itemcodes.length == qtyreceiveds.length && itemcodes.length == purchaseprices.length && itemcodes.length == totalamount.length) {
            Supplier supplier = (Supplier) mgr.getIntegerObject(s, Integer.parseInt(supplierid));
            invoice.setComment(comment);
            invoice.setDateReceived(new Date());
            invoice.setInvoiceAmount(Double.parseDouble(subtotal));
            invoice.setInvoiceDate(ft.parse(invoicedate));
            invoice.setNetTotal(Double.parseDouble(nettotal));
            invoice.setPercentageDiscount(Double.parseDouble(percentagediscount));
            invoice.setPriceDiscount(Double.parseDouble(pricediscount));
            invoice.setPurchaseOrder(purchaseOrder);
            invoice.setStafftable(stafftable);
            invoice.setSupplier(supplier);
            invoice.setSupplierInvoice(supplierinv);
            invoice.setTaxAmount(Double.parseDouble(totalTax));
            invoice.setVatValue(Double.parseDouble("17.5"));
            mgr.save(invoice);

            //System.out.println("length measure house"+itemcodes[0]);
            for (int i = 0; i < itemcodes.length; i++) {
                InventoryItems ii = (InventoryItems)mgr.getStringObject(inventoryItems, itemcodes[i]);
                batch.setDateReceived(new Date());
                batch.setExpiryDate(ft.parse(expireDates[i]));
                batch.setInventoryItems(ii);
                batch.setInvoice(invoice);
                batch.setItemBatch(batchnumbers[i]);
                batch.setPurchasePrice(Double.parseDouble(purchaseprices[i]));
                batch.setQuantityOnHand(Integer.parseInt(qtyreceiveds[i]));
                batch.setQuantityReceived(Integer.parseInt(qtyreceiveds[i]));
                double sp = Double.parseDouble(purchaseprices[i])+1.4;
                batch.setSellingPrice(sp);
                int qty = inventoryItems.getQuantityOnHand();
                batch.setReceivedValue(sp*qty);
                batch.setValueOnHand(sp*qty);
                batch.setInvoice(invoice);
                inventoryItems.setQuantityOnHand(qty+Integer.parseInt(qtyreceiveds[i]));
                mgr.update(ii);
                mgr.save(batch);
                
            }
            response.sendRedirect("../goods_received.jsp");
        } else {
            response.sendRedirect("../submittedorder.jsp");
        }
        // objectSession.getTransaction().commit();

    }
    if (request.getParameter("action").equals("edituser")) {


        // objectSession.getTransaction().commit();
        response.sendRedirect("../adduser.jsp");
    }
    if (request.getParameter("action").equals("updateprofile")) {

        response.sendRedirect("../adduser.jsp");
    }
    if (request.getParameter("action").equals("deleteuser")) {
        String staffID = request.getParameter("staffnumber");
        //User user = (User) objectSession.get(User.class, staffID);
        //objectSession.delete(user);
        // objectSession.getTransaction().commit();
        response.sendRedirect("../adduser.jsp");
    }
    //out.print(num);
%>
