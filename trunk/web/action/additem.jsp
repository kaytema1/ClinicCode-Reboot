<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();
        if ("additem".equals(request.getParameter("action"))) {
            String description = request.getParameter("description") == null ? "" : request.getParameter("description");
            String types = request.getParameter("type") == null ? "" : request.getParameter("type");
            String icd10 = request.getParameter("icd10") == null ? "" : request.getParameter("icd10");
            String markup = request.getParameter("markup") == null ? "" : request.getParameter("markup");
            String unitofpricing = request.getParameter("unitprice") == null ? "" : request.getParameter("unitprice");
            String group = request.getParameter("diagnostic") == null ? "" : request.getParameter("diagnostic");
            String theragroup = request.getParameter("therapeutic") == null ? "0" : request.getParameter("therapeutic");
            int reorderlevel = request.getParameter("reorder") == null ? 0 : Integer.parseInt(request.getParameter("reorder"));
            int emergencylevel = request.getParameter("emergency") == null ? 0 : Integer.parseInt(request.getParameter("emergency"));
            String code = "";
            double markUp = 0.0;
            int typeid = - 1;
            int theragrp = 0;
            String[] codes = description.split(" ");
            if (codes.length == 1) {
                code = codes[0].substring(0, 6).toUpperCase();
                StockItems item = mgr.getStockItem(code);
                int value = 0;
                String val = "";
                if (item != null) {
                    val = item.getCode().length() == 6 ? "0" : item.getCode().substring(6);
                    value = Integer.parseInt(val) + 1;
                    code = code + "" + val;
                }
            } else if (codes.length == 2) {
                code = codes[0].substring(0, 4).toUpperCase() + codes[1].substring(0, 4).toUpperCase();
                StockItems item = mgr.getStockItem(code);
                int value = 0;
                String val = "";
                if (item != null) {
                    val = item.getCode().length() == 6 ? "0" : item.getCode().substring(6);
                    value = Integer.parseInt(val) + 1;
                    code = code + "" + val;
                }
            } else if (codes.length == 3) {
                code = codes[0].substring(0, 2).toUpperCase() + codes[1].substring(0, 2).toUpperCase() + codes[2].substring(0, 2).toUpperCase();
                StockItems item = mgr.getStockItem(code);
                int value = 0;
                String val = "";
                if (item != null) {
                    val = item.getCode().length() == 6 ? "0" : item.getCode().substring(6);
                    value = Integer.parseInt(val) + 1;
                    code = code + "" + val;
                }
            }
            try {
                markUp = Double.parseDouble(markup);
                typeid = Integer.parseInt(types);
                // grp = Integer.parseInt(group);
                theragrp = Integer.parseInt(theragroup);
                StockItems stockItems = mgr.addStockItem(code, icd10, description, typeid, markUp, unitofpricing, group, theragrp, reorderlevel, emergencylevel);
            } catch (NumberFormatException ex) {
                out.print("Mark Up field should not be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            } catch (NullPointerException ex) {
                out.print("No field should be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            } /*catch (Exception ex) {
             out.print("error");
             return;
             }*/
            out.print("Stock Item Added Successfully");
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "Stock Item Added Successfully");
            return;
        }
        if ("addlabitem".equals(request.getParameter("action"))) {
            String description = request.getParameter("description") == null ? "" : request.getParameter("description");
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            String markUp = request.getParameter("markup") == null ? "" : request.getParameter("markup");
            String staffid = request.getParameter("staffid") == null ? "" : request.getParameter("staffid");
            int maximum = request.getParameter("maximum") == null ? 0 : Integer.parseInt(request.getParameter("maximum"));
            int reorderlevel = request.getParameter("reorder") == null ? 0 : Integer.parseInt(request.getParameter("reorder"));
            int emergencylevel = request.getParameter("emergency") == null ? 0 : Integer.parseInt(request.getParameter("emergency"));
            //String code = "";
            //String markUp = Double.parseDouble(markup);

            try {

                LabStockItem stockItems = mgr.addLabStockItem(code, description, reorderlevel, markUp, emergencylevel, maximum, staffid, new Date());
            } catch (NumberFormatException ex) {
                out.print("Mark Up field should not be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            } catch (NullPointerException ex) {
                out.print("No field should be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            } /*catch (Exception ex) {
             out.print("error");
             return;
             }*/
            out.print("Stock Item Added Successfully");
            session.setAttribute("class", "alert-error");
            session.setAttribute("lasterror", "Stock Item Added Successfully");
            return;
        }
        if ("edititems".equals(request.getParameter("action"))) {
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            String icd10 = request.getParameter("icd10") == null ? "" : request.getParameter("icd10");
            String description = request.getParameter("description") == null ? "" : request.getParameter("description");
            String type = request.getParameter("type") == null ? "" : request.getParameter("type");
            String unitprice = request.getParameter("unitprice") == null ? "" : request.getParameter("unitprice");
            String markup = request.getParameter("markup") == null ? "" : request.getParameter("markup");
            String reorder = request.getParameter("reorder") == null ? "0" : request.getParameter("reorder");
            String emergency = request.getParameter("emergency") == null ? "0" : request.getParameter("emergency");
            String quantity = request.getParameter("quantity") == null ? "0" : request.getParameter("quantity");
            String theragroup = request.getParameter("theragroup") == null ? "0" : request.getParameter("theragroup");
            String diagnostic = request.getParameter("diagnostic") == null ? "" : request.getParameter("diagnostic");
            double markUp = 0;
            int typeid = 0;
            int thera = 0;
            int reOrder = 0;
            int qty = 0;
            int emerg = 0;
            try {
                markUp = Double.parseDouble(markup);
                typeid = Integer.parseInt(type);
                thera = Integer.parseInt(theragroup);
                qty = Integer.parseInt(quantity);
                reOrder = Integer.parseInt(reorder);
                emerg = Integer.parseInt(emergency);
                StockItems stockItems = mgr.updateStockItems(code, icd10, description, typeid, markUp, unitprice, qty, emerg, reOrder, thera, diagnostic);
            } catch (NumberFormatException ex) {
                out.print("Mark Up field should not be empty!");
                session.setAttribute("class", "error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            } catch (NullPointerException ex) {
                out.print("No field sould be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            }
            out.print("Stock Item Edited Successfully!");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Please Try Again");
            return;
        }
        if ("editlabitems".equals(request.getParameter("action"))) {
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            String description = request.getParameter("description") == null ? "" : request.getParameter("description");
            String markup = request.getParameter("markup") == null ? "" : request.getParameter("markup");
            String reorder = request.getParameter("reorder") == null ? "0" : request.getParameter("reorder");
            String emergency = request.getParameter("emergency") == null ? "0" : request.getParameter("emergency");
            String maximum = request.getParameter("maximum") == null ? "0" : request.getParameter("maximum");
            double markUp = 0;
            int max = 0;
            int reOrder = 0;
            int emerg = 0;
            try {
                //markUp = Double.parseDouble(markup);
                max = Integer.parseInt(maximum);
                reOrder = Integer.parseInt(reorder);
                emerg = Integer.parseInt(emergency);
                LabStockItem stockItems = mgr.updateLabStockItem(code, description, reOrder, markup, emerg, max);
            } catch (NumberFormatException ex) {
                out.print("Mark Up field should not be empty!");
                session.setAttribute("class", "error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            } catch (NullPointerException ex) {
                out.print("No field sould be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            }
            out.print("Stock Item Edited Successfully!");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Please Try Again");
            return;
        }
        if ("deleteitems".equals(request.getParameter("action"))) {
            String code = request.getParameter("id") == null ? "" : request.getParameter("id");

            try {
                StockItems stockItems = mgr.deleteStockItem(code);
            } catch (NullPointerException ex) {
                out.print("Stock Item code cannot be empty!");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Please Try Again");
                return;
            }
            out.print("Stock Item Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Stock Item Deleted Successfully");
            return;
        }
        if ("additemstock".equals(request.getParameter("action"))) {
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            String qty = request.getParameter("quantity") == null ? "0" : request.getParameter("quantity");
            String batchno = request.getParameter("batchno") == null ? null : request.getParameter("batchno");
            String unitprice = request.getParameter("unitprice") == null ? "0.0" : request.getParameter("unitprice");
            String expirydate = request.getParameter("expirydate") == null ? null : request.getParameter("expirydate");
            // String reorder = request.getParameter("reorder") == null ? "0.0" : request.getParameter("reorder");
            //String emergency = request.getParameter("emergency") == null ? "0.0" : request.getParameter("emergency");
            String supplier = request.getParameter("supplier") == null ? "0" : request.getParameter("supplier");
            String manufacturer = request.getParameter("manufacturer") == null ? "0" : request.getParameter("manufacturer");
            String location = request.getParameter("location") == null ? "" : request.getParameter("location");

            double price = 0.0;
            int quantity = 0;
            //int reOrder = 0;
            //int emergencyLevel = - 1;
            int spl = 0;
            int manu = 0;
            double dispensingprice = 0.0;
            double pharmacypricing = 0.0;
            double nhispricing = 0.0;
            double laboratorypricing = 0.0;
            expirydate = expirydate.replace("/", "-");
            String[] dates = expirydate.split("-");
            String dt = dates[2] + "-" + dates[1] + "-" + dates[0];
            DateFormat formatter;
            Date date;
            formatter = new SimpleDateFormat("YYYY-MM-DD");
            date = (Date) formatter.parse(dt);
            int itemquantity = 0;
            try {
                price = Double.parseDouble(unitprice);
                quantity = Integer.parseInt(qty);
                //reOrder = Integer.parseInt(reorder);
                //emergencyLevel = Integer.parseInt(emergency);
                spl = Integer.parseInt(supplier);
                manu = Integer.parseInt(manufacturer);
                dispensingprice = (mgr.getStockItem(code).getMarkUp() / 100) * price;
                pharmacypricing = (mgr.getStockItem(code).getMarkUp() / 100) * price;
                nhispricing = (mgr.getStockItem(code).getMarkUp() / 100) * price;
                laboratorypricing = (mgr.getStockItem(code).getMarkUp() / 100) * price;
                List l = mgr.listItemsByIemCode(code);
                StockItems items = (StockItems) mgr.getStockItem(code);
                itemquantity = quantity + l.size() + items.getQunaity();
                mgr.updateStockItemQuantity(code, itemquantity);
                ItemsTable itemsTable = mgr.addItem(code, quantity, batchno, date, manu, spl, 0, 0, price, dispensingprice, pharmacypricing, laboratorypricing, nhispricing, location);
            } catch (NumberFormatException ex) {
                out.print("Some fields are empty");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-success");
                return;
            } catch (NullPointerException ex) {
                out.print("No field sould be empty!");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-success");
                return;
            }
            out.print("Stock Item Added Successfully!");
            session.setAttribute("lasterror", "Stock Item Added Successfully!");
            session.setAttribute("class", "alert-success");
            return;
        }
        if ("additemlabstock".equals(request.getParameter("action"))) {
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            String qty = request.getParameter("quantity") == null ? "0" : request.getParameter("quantity");
            String batchno = request.getParameter("batchno") == null ? null : request.getParameter("batchno");
            String unitprice = request.getParameter("unitprice") == null ? "0.0" : request.getParameter("unitprice");
            String expirydate = request.getParameter("expirydate") == null ? "2013/07/07" : request.getParameter("expirydate");
            String supplier = request.getParameter("supplier") == null ? "0" : request.getParameter("supplier");
            String manudate = request.getParameter("manudate") == null ? "2013/07/07" : request.getParameter("manudate");

            double price = 0.0;
            int quantity = 0;
            int spl = 0;
            expirydate = expirydate.replace("/", "-");
            manudate = manudate.replace("/", "-");
            String[] dates = expirydate.split("-");
            String dt = dates[2] + "-" + dates[1] + "-" + dates[0];
            DateFormat formatter;
            Date date;
            formatter = new SimpleDateFormat("YYYY-MM-DD");
            date = (Date) formatter.parse(dt);

            String[] manus = manudate.split("-");
            String mnaudt = manus[2] + "-" + manus[1] + "-" + manus[0];
            DateFormat formatter1;
            Date mandate;
            formatter1 = new SimpleDateFormat("YYYY-MM-DD");
            mandate = (Date) formatter.parse(mnaudt);
            int itemquantity = 0;
            try {
                price = Double.parseDouble(unitprice);
                quantity = Integer.parseInt(qty);
                spl = Integer.parseInt(supplier);
                //List l = mgr.listItemsByIemCode(code);
                //StockItems items = (StockItems) mgr.getStockItem(code);
                //itemquantity = quantity + l.size() + items.getQunaity();
                //mgr.addLabStock(distId, batchNumber, manuDate, exDate, qty, unitPrice, totalPrice, staffId, dateAdded)
                LabStock labStock = mgr.addLabStock(batchno, spl, code, mandate, quantity, date, price, quantity * price, current.getStaffid());
            } catch (NumberFormatException ex) {
                out.print("Some fields are empty");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-success");
                return;
            } catch (NullPointerException ex) {
                out.print("No field sould be empty!");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-success");
                return;
            }
            out.print("Stock Item Added Successfully!");
            session.setAttribute("lasterror", "Stock Item Added Successfully!");
            session.setAttribute("class", "alert-success");
            return;
        }
        if ("editlabitemstock".equals(request.getParameter("action"))) {
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            int qty = request.getParameter("quantity") == null ? 0 : Integer.parseInt(request.getParameter("quantity"));
            String batchno = request.getParameter("batchno") == null ? null : request.getParameter("batchno");
            Double unitprice = request.getParameter("unitprice") == null ? 0 : Double.parseDouble(request.getParameter("unitprice"));
            String expirydate = request.getParameter("expirydate") == null ? "2013/07/07" : request.getParameter("expirydate");
            int supplier = request.getParameter("supplier") == null ? 0 : Integer.parseInt(request.getParameter("supplier"));
            String manudate = request.getParameter("manufacturer") == null ? "2013/07/07" : request.getParameter("manufacturer");

            Double total = request.getParameter("total") == null ? 0 : Double.parseDouble(request.getParameter("total"));
            double price = 0.0;
            int quantity = 0;
            int spl = 0;
            expirydate = expirydate.replace("/", "-");
            manudate = manudate.replace("/", "-");
            String[] dates = expirydate.split("-");
            String dt = dates[2] + "-" + dates[1] + "-" + dates[0];
            DateFormat formatter;
            Date date;
            formatter = new SimpleDateFormat("YYYY-MM-DD");
            date = (Date) formatter.parse(dt);

            String[] manus = manudate.split("-");
            String mnaudt = manus[2] + "-" + manus[1] + "-" + manus[0];
            DateFormat formatter1;
            Date mandate;
            formatter1 = new SimpleDateFormat("YYYY-MM-DD");
            mandate = (Date) formatter.parse(mnaudt);
            int itemquantity = 0;
            int tqty = mgr.getLabStockItem(code).getQuantity();
                mgr.updateLabStockItemQty(code,(tqty+qty));
           // double total = 0.0;
            try {
                //price = Double.parseDouble(unitprice);
                //quantity = Integer.parseInt(qty);
                //spl = Integer.parseInt(supplier);
               // total = Double.parseDouble(totall);
                //List l = mgr.listItemsByIemCode(code);
                //StockItems items = (StockItems) mgr.getStockItem(code);
                //itemquantity = quantity + l.size() + items.getQunaity();
                //mgr.addLabStock(distId, batchNumber, manuDate, exDate, qty, unitPrice, totalPrice, staffId, dateAdded)
                LabStock labStock = mgr.updateLabStock(batchno, supplier, code, mandate, qty, date, unitprice, unitprice*qty, current.getStaffid());
                
                //return;
            } catch (NumberFormatException ex) {
                out.print("Some fields are empty "+total);
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-success");
                return;
            } catch (NullPointerException ex) {
                out.print("No field sould be empty!");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-success");
                return;
            }
            out.print("Stock Item Added Successfully!");
            session.setAttribute("lasterror", "Stock Item Added Successfully!");
            session.setAttribute("class", "alert-success");
            return;
        }
        if ("edititemstock".equals(request.getParameter("action"))) {
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            String qty = request.getParameter("quantity") == null ? "0" : request.getParameter("quantity");
            String batchno = request.getParameter("batchno") == null ? null : request.getParameter("batchno");
            String unitprice = request.getParameter("unitprice") == null ? "0.0" : request.getParameter("unitprice");
            String expirydate = request.getParameter("expirydate") == null ? null : request.getParameter("expirydate");
            String reorder = request.getParameter("reorder") == null ? "0.0" : request.getParameter("reorder");
            String emergency = request.getParameter("emergency") == "" ? "0" : request.getParameter("emergency");
            String supplier = request.getParameter("supplier") == null ? "0" : request.getParameter("supplier");
            String manufacturer = request.getParameter("manufacturer") == null ? "0" : request.getParameter("manufacturer");
            String location = request.getParameter("location") == null ? "" : request.getParameter("location");
            String dispensing = request.getParameter("dispensing") == "" ? "0.0" : request.getParameter("dispensing");
            String pharmacy = request.getParameter("pharmacy") == null ? "0" : request.getParameter("pharmacy");
            String laboratory = request.getParameter("laboratory") == null ? "0" : request.getParameter("laboratory");
            String nhis = request.getParameter("nhis") == null ? "0" : request.getParameter("nhis");

            int quantity = -1;
            double price = 0.0;
            int reOrder = -1;
            double dispensary = 0;
            double pharmaprice = -1;
            double nhisprice = 0.0;
            double lab = 0.0;
            int manu = -1;
            int spl = 0;
            int emer = 0;
            expirydate = expirydate.replace("/", "-");
            String[] dates = expirydate.split("-");
            String dt = dates[2] + "-" + dates[1] + "-" + dates[0];
            DateFormat formatter;
            Date date;
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date) formatter.parse(dt);
            try {
                quantity = Integer.parseInt(qty);
                price = Double.parseDouble(unitprice);
                reOrder = Integer.parseInt(reorder);
                pharmaprice = Double.parseDouble(pharmacy);
                nhisprice = Double.parseDouble(nhis);
                lab = Double.parseDouble(laboratory);
                manu = Integer.parseInt(manufacturer);
                spl = Integer.parseInt(supplier);
                dispensary = Double.parseDouble(dispensing);
                emer = Integer.parseInt(emergency.trim());
                // markUp = Double.parseDouble(markup);
                // typeid = Integer.parseInt(type);
                ItemsTable itemsTable = mgr.updateItem(code, quantity, batchno, date, manu, spl, 0, 0, price, dispensary, pharmaprice, lab, nhisprice, location);
            } catch (NumberFormatException ex) {
                out.print(emergency + "<br/>" + pharmaprice);
                return;
            } catch (NullPointerException ex) {
                out.print("No field should be empty!");
                session.setAttribute("lasterror", "Please Try Again");
                session.setAttribute("class", "alert-error");

                return;
            }
            out.print("Stock Item Edited Successfully!");
            session.setAttribute("lasterror", "Stock Item Edited Successfully!");
            session.setAttribute("class", "alert-success");
            return;
        }
        if ("deleteitemstock".equals(request.getParameter("action"))) {
            String id = request.getParameter("id") == null ? "" : request.getParameter("id");
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            int stockqty = mgr.getStockItem(code).getQunaity();
            int itemqty = mgr.getItemTable(id).getQuantity();
            try {
                mgr.updateStockItemQuantity(code, (stockqty - itemqty));
                ItemsTable stockItems = mgr.deleteItem(id);
                //
            } catch (NullPointerException ex) {
                out.print("Item field code cannot be empty!");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-error");
                return;
            }
            out.print("Stock Item Deleted Successfully");
            session.setAttribute("lasterror", "Please Try Again!");
            session.setAttribute("class", "alert-error");
            return;
        }
        if ("inuse".equals(request.getParameter("action"))) {
            int qty = request.getParameter("startqty") == null ? 0 : Integer.parseInt(request.getParameter("startqty"));
            String code = request.getParameter("code") == null ? "" : request.getParameter("code");
            int stockqty = mgr.getLabStock(code).getQty();
            int itemqty = mgr.getLabStockItem(mgr.getLabStock(code).getItemId()).getQuantity();
            try {
                mgr.addStockLabItemBatchInfo(0,code,qty,new Date(),current.getStaffid());
                mgr.updateLabStockItemQty(code, (itemqty-qty));
                //
            } catch (NullPointerException ex) {
                out.print("Item field code cannot be empty!");
                session.setAttribute("lasterror", "Please Try Again!");
                session.setAttribute("class", "alert-error");
                return;
            }
            out.print("Stock Item Deleted Successfully");
            session.setAttribute("lasterror", "Please Try Again!");
            session.setAttribute("class", "alert-error");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../inventoryindex.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>