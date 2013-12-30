<%-- 
    Document   : registrationaction
    Created on : Mar 30, 2012, 11:22:44 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,helper.HibernateUtil"%>
<!DOCTYPE html>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("records.jsp");
        }
        // HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        sess.beginTransaction();
        if ("newstock".equals(request.getParameter("action"))) {
            //String patientID = request.getParameter("patientid");

            String stockitemid = request.getParameter("stockitemid") == "" ? "" : request.getParameter("stockitemid");
            String distributorid = request.getParameter("distributorid") == "" ? "" : request.getParameter("distributorid");
            String batchnumber = request.getParameter("batchnumber") == "" ? "" : request.getParameter("batchnumber");
            String manudate = request.getParameter("manudate") == "" ? "" : request.getParameter("manudate");
            String expirydate = request.getParameter("expirydate") == "" ? "" : request.getParameter("expirydate");
            String qty = request.getParameter("qty") == "" ? "" : request.getParameter("qty");
            String unitprice = request.getParameter("unitprice") == "" ? "" : request.getParameter("unitprice");

            String totalprice = request.getParameter("totalprice") == "" ? "" : request.getParameter("totalprice");



            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            int sId = 0, dId = 0, lsidId = 0;
            double quantity = 0, tot = 0;
            LabStockItemDistributor lsid;
            List distributors, stockItems;
            try {
                sId = Integer.parseInt(stockitemid);
                dId = Integer.parseInt(distributorid);
                quantity = Double.parseDouble(qty);

                distributors = mgr.listLabStockItemDistributorByIds(sId, dId);

                System.out.println("distributors.length : " + distributors.size());
                if (!distributors.isEmpty()) {  // item distributor already exists
                    lsid = (LabStockItemDistributor) distributors.get(0);
                    lsidId = lsid.getId();
                    tot = lsid.getTotalLevel() + quantity;
                    quantity += lsid.getCurrentLevel();


                    mgr.updateLSID(lsidId, quantity, tot);


                } else { // item distributor does not exist
                    // save item distributor
                    lsid = mgr.addLabStockItemDistributor(sId, dId, quantity, 0, quantity);

                    if (lsid != null) {
                        lsidId = lsid.getId();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Stock could not be saved, Please Try Again");
                response.sendRedirect("../listlabstockitems.jsp");
                return;
            }


            LabStock labStock = null;

            labStock = mgr.addLabStock(lsidId, batchnumber,
                    mgr.convertStringToUtilDate(manudate), mgr.convertStringToUtilDate(expirydate), quantity,
                    Double.parseDouble(unitprice), Double.parseDouble(totalprice), current.getStaffid(), new java.sql.Timestamp(new java.util.Date().getTime()));

            if (labStock == null) {
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Stock could not be saved, Please Try Again");
                response.sendRedirect("../listlabstockitems.jsp");
                return;
            }

            // increase current qty , n total qty

            stockItems = mgr.listLabStockItemById(sId);
            double sItemExistingLevel, sItemNewCurrentLevel, incomingQty;
            double sItemExistingTotLevel = 0, sItemNewTotLevel = 0;
            String batchInUse = "No";

            if (!stockItems.isEmpty()) {
                LabStockItem sItem = (LabStockItem) stockItems.get(0);
                if (sItem != null) {
                    sItemExistingLevel = sItem.getCurrentLevel();

                    incomingQty = Double.parseDouble(qty);
                    sItemNewCurrentLevel = sItemExistingLevel + incomingQty;

                    sItemExistingTotLevel = sItem.getTotalLevel();
                    sItemNewTotLevel = sItemExistingTotLevel + incomingQty;

                    if (sItemExistingLevel == 0) {
                        batchInUse = "Yes";
                    }

                    mgr.updateLSI(sItem.getId(), sItemNewCurrentLevel, sItemNewTotLevel);

                    // add the batch information
                    sItemExistingTotLevel += 1;

                    mgr.addStockLabItemBatchInfo(sId, batchnumber, sItemExistingTotLevel, sItemNewTotLevel, batchInUse);

                } else {
                    session.setAttribute("class", "alert-error");
                    session.setAttribute("lasterror", "Stock Item Could Not Be Updated, Please Try Again");
                    response.sendRedirect("../listlabstockitems.jsp");
                    return;
                }
            }



            response.sendRedirect("../listlabstockitems.jsp");
            return;


        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();

    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            // throw (ServletException) ex;
            out.print(ex.getMessage());
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "An Error Occurred. Please Try Again Later");
            response.sendRedirect("../listlabstockitems.jsp");
        } else {
            // throw new ServletException(ex);
            out.print(ex.getMessage());
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "An Error Occurred. Please Try Again Later");
            response.sendRedirect("../listlabstockitems.jsp");
        }
    }%>