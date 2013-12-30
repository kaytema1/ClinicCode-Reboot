<%-- 
    Document   : listdosage
    Created on : Oct 29, 2013, 4:32:20 AM
    Author     : drac852002
--%>

<%@page import="entities.TransactionEntityManager"%>
<%@page import="entities.InventoryItems"%>
<%@page import="entities.Users"%>
<%@page import="entities.PharmacyItem"%>
<%@page import="entities.PharmacyBatch"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.Set"%>
<%@page import="entities.UnitsOfMeasure"%>
<%@page import="java.util.List"%>
<%@page import="entities.Dosage"%>
<%@page import="helper.HibernateUtil"%>
<%@page import="org.hibernate.Transaction"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JSONObject json = new JSONObject();
    // JSONArray dosagesList = new JSONArray();
    Users u = (Users) session.getAttribute("user");
    HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
    TransactionEntityManager mgr = new TransactionEntityManager();
    if (request.getParameter("action").equals("getdosages")) {
        String itemCode = request.getParameter("itemcode");
        
        InventoryItems ii = new InventoryItems();
        InventoryItems inventoryItem1 = (InventoryItems)mgr.getStringObject(ii,itemCode);
        //UnitsOfMeasure measure = inventoryItem1.getUnitsOfMeasure();
        Set<Dosage> dosages = inventoryItem1.getDosages();
        //String dosage = "";
        JSONArray arr = new JSONArray();
        JSONObject dosageJson = new JSONObject();
        for (Dosage d : dosages) {
            String dosage = d.getDosageId() + "-" + d.getDescription() ;
            JSONObject subjson = new JSONObject();
            subjson.put("name", dosage);
            subjson.put("id", d.getShortCode());
            arr.add(subjson);
            
        }
        json.put("success", "1");
        json.put("data",arr);
        out.write(json.toString());
        return;
    }
    
   /* if (request.getParameter("action").equals("getdosages")) {
        String itemCode = request.getParameter("itemcode");
        
        PharmacyItem ii = new PharmacyItem();
        PharmacyItem inventoryItem1 = (PharmacyItem)mgr.getStringObject(ii,itemCode);
        UnitsOfMeasure measure = inventoryItem1.getUnitsOfMeasure();
        /*Set<Dosage> dosages = measure.getDosages();
        Set<PharmacyBatch> batchs = inventoryItem1.getPharmacyBatchs();
        String dosage = "";
        JSONArray arr = new JSONArray();
        //JSONObject dosageJson = new JSONObject();
        for (Dosage d : dosages) {
            dosage = dosage + "," + d.getDosageId() + "_" + d.getDescription();
            JSONObject subjson = new JSONObject();
            subjson.put("name", d.getDescription());
            subjson.put("id", d.getDosageId());
            arr.add(subjson);
        }
        json.put("success", "1");
        //json.put("data",arr);
        //System.out.println(json.toString());
        out.write(json.toString());
        return;
    }
    if (request.getParameter("action").equals("getbatch")) {
        String itemCode = request.getParameter("itemcode");
        
        PharmacyItem ii = new PharmacyItem();
        PharmacyItem inventoryItem1 = (PharmacyItem)mgr.getStringObject(ii,itemCode);
        //UnitsOfMeasure measure = inventoryItem1.getUnitsOfMeasure();
        //Set<Dosage> dosages = measure.getDosages();
        Set<PharmacyBatch> batchs = inventoryItem1.getPharmacyBatchs();
        String dosage = "";
       /* JSONArray arr = new JSONArray();
        //JSONObject dosageJson = new JSONObject();
        for (PharmacyBatch d : batchs) {
            dosage = dosage + "," + d.getBatchNumber() + "_" + d.getSellingPrice();
            JSONObject subjson = new JSONObject();
            subjson.put("name", d.getPharmacyItem().getItemDecription());
            subjson.put("id", dosage);
            arr.add(subjson);
        }
        json.put("success", "1");
        json.put("data",arr);
        //System.out.println(json.toString());
        out.write(json.toString());
        return;
    }
    if (request.getParameter("action").equals("getqty")) {
        String itemCode = request.getParameter("qtycode");
        //System.out.println(itemCode);
        Dosage dosage = new Dosage();
        Dosage dosage1 = (Dosage) mgr.getIntegerObject(dosage, Integer.parseInt(itemCode));    
        out.print(dosage1.getQuantity());
        return;
    }
*/

%>
