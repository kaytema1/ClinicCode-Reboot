<%-- 
    Document   : labnpharmactions
    Created on : Jun 21, 2012, 8:23:35 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
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

        if ("Dispensary".equals(request.getParameter("action"))) {
            String codes[] = request.getParameterValues("labtest") == null ? null : request.getParameterValues("labtest");
            String[] qtys = request.getParameterValues("qty[]") == null ? null : request.getParameterValues("qty[]");
            System.out.println(codes);

            // String[] code = treatments
            if (codes == null || qtys == null) {
                out.print("empty");
                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");
                response.sendRedirect("../accounts.jsp");
                return;
            }
            if (codes != null && qtys != null) {
                InventoryItems inventoryItems = new InventoryItems();
                Stafftable s = new Stafftable();
                Stafftable stafftable = (Stafftable) mgr.getStringObject(s, user.getStaffid());
                for (int i = 0; i < codes.length; i++) {
                    Requisition requisition = new Requisition();
                    requisition.setDateOfRequest(new Date());
                    InventoryItems items = (InventoryItems) mgr.getStringObject(inventoryItems, codes[i]);
                    System.out.println(codes[i]);
                    requisition.setInventoryItems(items);
                    //requisition.setInventoryItems(inventoryItems);
                    requisition.setStatus("Pending");
                    requisition.setLocation("Dispensary");
                    requisition.setStafftableByRequestedBy(stafftable);
                    requisition.setQuantityRequested(Integer.parseInt(qtys[i]));
                    //mgr.addRequisitions(codes[i], user.getStaffid(), "Dispensary", Integer.parseInt(qtys[i]));
                    //out.print(codes[i] + " " + qtys[i]);
                    mgr.save(requisition);
                }
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Request Created Successfully");
                response.sendRedirect("../dispensarymakerequest.jsp");
                return;
            }
        }

        if ("edititemstock".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == "" ? "" : request.getParameter("id");
            String code = request.getParameter("code") == "" ? "" : request.getParameter("code");
            String qtys = request.getParameter("qty") == "" ? "" : request.getParameter("qty");
            System.out.println(code);
            //ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            // String[] code = treatments
            if (code.isEmpty()) {
                out.print("Choose an item");
            }
            int qty = -1;
            int ids = -1;
            try {
                qty = Integer.parseInt(qtys);
                ids = Integer.parseInt(id);
                //Requisition requisitions = mgr.updateRequisition(ids, code, qty);
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Request Edited Successfully");
                response.sendRedirect("../dispensarymakerequest.jsp");
                out.print("Changes saved");
            } catch (NumberFormatException e) {
                out.print("Quantity field cannot be empty");
                // Requisition requisitions = mgr.updateRequisition(ids, code, qty);
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Complete All Fields");
                response.sendRedirect("../dispensarymakerequest.jsp");
            } catch (NullPointerException e) {
                out.print("Sorry try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Complete All Fields");
                response.sendRedirect("../dispensarymakerequest.jsp");
            }
        }
        if ("postitems".equals(request.getParameter("action"))) {
            // ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            String requestid = request.getParameter("requestid") == "" ? "" : request.getParameter("requestid");
            String[] batchnumbers = request.getParameterValues("checkus[]") == null ? null : request.getParameterValues("checkus[]");
            //  String batch = request.getParameter("batch") == "" ? "" : request.getParameter("batch");
            ItemBatch batch = new ItemBatch();
            PharmacyBatch pb = new PharmacyBatch();
            DispensaryBatch db = new DispensaryBatch();
            LaboratoryBatch lb = new LaboratoryBatch();
            DispensaryItems di = new DispensaryItems();
            PharmacyItem pi = new PharmacyItem();
            LaboratoryItem li = new LaboratoryItem();
            Invoice i = new Invoice();
            Requisition r = new Requisition();
            int qty = -1;
            int ids = -1;
            int tt = 0;

            try {
                ids = Integer.parseInt(requestid);
                if (batchnumbers != null) {
                    for (int t = 0; t < batchnumbers.length; t++) {
                        System.out.println("test ets " + requestid);
                        //out.print(batchnumbers[t]);
                        Requisition requisition = (Requisition) mgr.getIntegerObject(r, ids);
                        ItemBatch itemBatch = (ItemBatch) mgr.getStringObject(batch, batchnumbers[t]);
                        qty = Integer.parseInt(request.getParameter("quantity_" + batchnumbers[t]));
                        tt = +qty;
                        if (requisition.getLocation().equals("Dispensary")) {
                            DispensaryItems dispensaryItems = (DispensaryItems) mgr.getStringObject(di, itemBatch.getInventoryItems().getItemCode());
                            db.setDateReceived(new Date());
                            db.setExpiryDate(itemBatch.getExpiryDate());
                            db.setInvoice(itemBatch.getInvoice());
                            db.setItemBatch(itemBatch.getItemBatch());
                            db.setPurchasePrice(itemBatch.getPurchasePrice());
                            int qtyOnHnd = db.getQuantityOnHand() + qty;
                            db.setQuantityOnHand(qtyOnHnd);
                            db.setQuantityReceived(qty);
                            db.setSellingPrice(itemBatch.getSellingPrice());
                            db.setReceivedValue(qty * itemBatch.getSellingPrice());
                            db.setValueOnHand(qtyOnHnd * db.getSellingPrice());
                            db.setDispensaryItems(dispensaryItems);
                            mgr.save(db);
                        }
                        if (requisition.getLocation().equals("Laboratory")) {
                             LaboratoryItem laboratoryItem = (LaboratoryItem) mgr.getStringObject(li, itemBatch.getInventoryItems().getItemCode());
                            lb.setDateReceived(new Date());
                            lb.setExpiryDate(itemBatch.getExpiryDate());
                            lb.setInvoice(itemBatch.getInvoice());
                            lb.setItemBatch(itemBatch.getItemBatch());
                            lb.setPurchasePrice(itemBatch.getPurchasePrice());
                            int qtyOnHnd = lb.getQuantityOnHand() + qty;
                            lb.setQuantityOnHand(qtyOnHnd);
                            lb.setQuantityReceived(qty);
                            lb.setSellingPrice(itemBatch.getSellingPrice());
                            lb.setReceivedValue(qty * itemBatch.getSellingPrice());
                            lb.setValueOnHand(qtyOnHnd * lb.getSellingPrice());
                            lb.setLaboratoryItem(laboratoryItem);
                            mgr.save(lb);
                        }
                        if (requisition.getLocation().equals("Pharmacy")) {
                            PharmacyItem pharmacyItem = (PharmacyItem) mgr.getStringObject(pi, itemBatch.getInventoryItems().getItemCode());
                            pb.setItemBatch(itemBatch.getItemBatch());
                            pb.setDateReceived(new Date());
                            pb.setExpiryDate(itemBatch.getExpiryDate());
                            pb.setInvoice(itemBatch.getInvoice());
                            
                            pb.setPurchasePrice(itemBatch.getPurchasePrice());
                            int qtyOnHnd = pb.getQuantityOnHand() + qty;
                            pb.setQuantityOnHand(qtyOnHnd);
                            pb.setQuantityReceived(qty);
                            pb.setSellingPrice(itemBatch.getSellingPrice());
                            pb.setReceivedValue(qty * itemBatch.getSellingPrice());
                            pb.setValueOnHand(qtyOnHnd * pb.getSellingPrice());
                            pb.setPharmacyItem(pharmacyItem);
                            mgr.save(pb);
                        }
                        
                        // mgr.addPostedItem(ids, qty, batchnumbers[t]);

                    }
                }
                // Requisitions requisitions = mgr.updateRequisition(ids, tt, user.getStaffid());
                out.print("items posted successfully");
                session.setAttribute("class", "alert-success");
                session.setAttribute("lasterror", "Posted Successfully");
                response.sendRedirect("../allrequests.jsp");
                return;
            } catch (NumberFormatException e) {
                out.print("Quantity field cannot be empty");
                return;
            } catch (NullPointerException e) {
                e.printStackTrace();
                out.print(ids);
            }
        }
        if ("acceptpost".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == "" ? "" : request.getParameter("id");
            String code = request.getParameter("code") == "" ? "" : request.getParameter("code");


            int qty = -1;
            int ids = -1;
            int qtty = 0;
            int qqty = 0;
            int intqty = 0;
            int qtyupdate = 0;
            try {
                // qty = Integer.parseInt(qtys);
                ids = Integer.parseInt(id);
                //Requisitions requisitions = mgr.updateRequisition(ids);
                // qtty = mgr.getStockItem(code).getQunaity();
                // qqty = mgr.getRequisition(ids).getDeliveredquantity();
                qtyupdate = (qtty - qqty);
                //intqty = mgr.getTreatment(treatmentid);
                List list = mg.listPostedItemsByRequestid(ids);
                if (list != null) {
                    for (int t = 0; t < list.size(); t++) {
                        PostedItems pi = (PostedItems) list.get(t);
                        mgr.updateItemQuantity(pi.getBatchNumber(), pi.getQunatity());
                        //mgr.updateTreatmentQuantity(pi.getBatchNumber(), pi.getQunatity());
                    }
                }
                //mgr.updateStockItemQuantity(code, qtyupdate);

                //mgr.updateT

                if (qtyupdate < 0) {
                    out.print("Not enough stock to deliver, you have only " + qtty + " in stock");
                    return;
                }
                //mgr.getStockItem(code).setQunaity(qtyupdate);
                out.print("items received successfully");
                return;
            } catch (NumberFormatException e) {

                out.print("Some fields are empty, kindly make sure all fields are set");
            } catch (NullPointerException e) {
                e.printStackTrace();
                out.print(ids);
            }
        }
        if ("deleteitemstock".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == "" ? "" : request.getParameter("id");

            //ExtendedHMSHelper mgr = new ExtendedHMSHelper();

            int ids = -1;
            try {

                ids = Integer.parseInt(id);
                //Requisition  requisitions = mg.deleteRequisition(ids);
                out.print("Deleted successfully");
            } catch (NumberFormatException e) {
                out.print("Quantity field cannot be empty");
            } catch (NullPointerException e) {
                e.printStackTrace();
                out.print("Sorry try again");
            }
        }
        if ("canceldelivery".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == "" ? "" : request.getParameter("id");

            //ExtendedHMSHelper mgr = new ExtendedHMSHelper();

            int ids = -1;
            try {

                ids = Integer.parseInt(id);
                //Requisitions requisitions = mgr.cancelRequisition(ids);
                out.print("Cancelled successfully");
            } catch (NumberFormatException e) {
                out.print("Quantity field cannot be empty");
            } catch (NullPointerException e) {
                e.printStackTrace();
                out.print("Sorry try again");
            }
        }
        if ("delpost".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == "" ? "" : request.getParameter("id");

            //ExtendedHMSHelper mgr = new ExtendedHMSHelper();

            int ids = -1;
            try {

                ids = Integer.parseInt(id);
                //Requisition requisitions = mg.cancelPost(ids);
                out.print("Post Stopped Successfully");
            } catch (NumberFormatException e) {
                out.print("Quantity field cannot be empty");
            } catch (NullPointerException e) {
                e.printStackTrace();
                out.print("Sorry try again");
            }
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        // System.out.println("here" + id);
        session.setAttribute("lasterror", "Request Modified Successfully");
        session.setAttribute("class", "alert-success");
        //response.sendRedirect("../dispensarymakerequest.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }
%>