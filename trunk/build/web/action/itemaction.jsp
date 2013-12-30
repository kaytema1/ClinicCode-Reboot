<%-- 
    Document   : addDrugAction
    Created on : Jan 1, 2013, 2:26:15 AM
    Author     : ddr
--%>

<%@page import="entities.LaboratoryItem"%>
<%@page import="entities.DispensaryItems"%>
<%@page import="entities.ItemForm"%>
<%@page import="entities.InventoryItems"%>
<%@page import="entities.PharmacyItem"%>
<%@page import="entities.UnitsOfMeasure"%>
<%@page import="entities.TherapeuticGroup"%>
<%@page import="entities.InventoryItems"%>
<%@page import="entities.TransactionEntityManager"%>
<%@page import="helper.HibernateUtil"%>
<%@page import="entities.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    /**
     * ************ Adding a User ****************
     */
    Users u = (Users) session.getAttribute("user");
    HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
    TransactionEntityManager method = new TransactionEntityManager();

    if (u == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    if (request.getParameter("action").equals("additem")) {
        String itemDescription = request.getParameter("itemdescription");
        String[] codes = itemDescription.split(" ");
        String code = "";
        InventoryItems inventoryItem = new InventoryItems();
        if (codes.length == 1) {
            code = codes[0].substring(0, 6).toUpperCase();
            InventoryItems item = (InventoryItems) method.getStringObject(inventoryItem, code);
            int value = 0;
            String val = "";
            if (item != null) {
                val = item.getItemCode().length() == 6 ? "0" : item.getItemCode().substring(6);
                value = Integer.parseInt(val) + 1;
                code = code + "" + val;
            }
        } else if (codes.length == 2) {
            code = codes[0].substring(0, 4).toUpperCase() + codes[1].substring(0, 4).toUpperCase();
            InventoryItems item = (InventoryItems) method.getStringObject(inventoryItem, code);
            int value = 0;
            String val = "";
            if (item != null) {
                val = item.getItemCode().length() == 6 ? "0" : item.getItemCode().substring(6);
                value = Integer.parseInt(val) + 1;
                code = code + "" + val;
            }
        } else if (codes.length == 3) {
            code = codes[0].substring(0, 2).toUpperCase() + codes[1].substring(0, 2).toUpperCase() + codes[2].substring(0, 2).toUpperCase();
            InventoryItems item = (InventoryItems) method.getStringObject(inventoryItem, code);
            int value = 0;
            String val = "";
            if (item != null) {
                val = item.getItemCode().length() == 6 ? "0" : item.getItemCode().substring(6);
                value = Integer.parseInt(val) + 1;
                code = code + "" + val;
            }
        }
        
        //String code = request.getParameter("code");

        String reorderLevel = request.getParameter("reorder");
        String minimumStockLevel = request.getParameter("minimumstocklevel");
        String maximumStockLevel = request.getParameter("maximumstocklevel");
        String location = request.getParameter("location");
        String unitofmeasure = request.getParameter("unitofmeasure");
        String therapeuticGroup = request.getParameter("therapeutic");
        String itemForm = request.getParameter("itemform");
        String itemStrength = request.getParameter("itemstrength");
        String manufacturer = request.getParameter("manufacturer");
        String activeIngredients = request.getParameter("activeingredients");
        String percentageMarkup = request.getParameter("percentagemarkup");
        String valueMarkup = request.getParameter("valuemarkup");
        String vatable = request.getParameter("vatable");
        System.out.println(activeIngredients);
        //String[] suppliers = request.getParameterValues("supplier");
        try {
            inventoryItem.setItemCode(code);
            inventoryItem.setItemDescription(itemDescription);
            ItemForm form = new ItemForm();
            ItemForm itemForm1 = (ItemForm)method.getIntegerObject(form, Integer.parseInt(itemForm));
            inventoryItem.setItemForm(itemForm1);
            inventoryItem.setStrength(itemStrength);
            inventoryItem.setActiveIngredients(activeIngredients);
            inventoryItem.setManufacturer(manufacturer);
            
            //inventoryItem.setItemType(Integer.parseInt(itemType));
            inventoryItem.setMaximumStockLevel(Integer.parseInt(maximumStockLevel));
            inventoryItem.setMinimumStockLevel(Integer.parseInt(minimumStockLevel));
            inventoryItem.setReorderLevel(Integer.parseInt(reorderLevel));
            TherapeuticGroup g = new TherapeuticGroup();
            UnitsOfMeasure measure = new UnitsOfMeasure();
            TherapeuticGroup group = (TherapeuticGroup) method.getIntegerObject(g, Integer.parseInt(therapeuticGroup));
            UnitsOfMeasure unitsOfMeasure = (UnitsOfMeasure) method.getIntegerObject(measure, Integer.parseInt(unitofmeasure));
            inventoryItem.setTherapeuticGroup(group);
            inventoryItem.setUnitsOfMeasure(unitsOfMeasure);
            inventoryItem.setQuantityOnHand(0);
            inventoryItem.setReorderQty(Integer.parseInt(maximumStockLevel) - Integer.parseInt(reorderLevel));
            inventoryItem.setPercentageMarkup(Double.parseDouble(percentageMarkup));
            inventoryItem.setPriceMarkup(Double.parseDouble(valueMarkup));
            inventoryItem.setVatable(Boolean.parseBoolean(vatable));
            inventoryItem.setLocation(location);

            method.save(inventoryItem);
            
            if(location.equalsIgnoreCase("PHY")){
              PharmacyItem pharmacyItem = new PharmacyItem();
              pharmacyItem.setInventoryItems(inventoryItem);
              pharmacyItem.setActiveIngredients(inventoryItem.getActiveIngredients());
              pharmacyItem.setItemCode(inventoryItem.getItemCode());
              pharmacyItem.setItemDescription(inventoryItem.getItemDescription());
              pharmacyItem.setItemForm(inventoryItem.getItemForm());
              pharmacyItem.setManufacturer(inventoryItem.getManufacturer());
              pharmacyItem.setMaximumStockLevel(inventoryItem.getMaximumStockLevel());
              pharmacyItem.setMinimumStockLevel(inventoryItem.getMinimumStockLevel());
              pharmacyItem.setPercentageMarkup(inventoryItem.getPercentageMarkup());
              pharmacyItem.setPriceMarkup(inventoryItem.getPriceMarkup());
              pharmacyItem.setQuantityOnHand(inventoryItem.getQuantityOnHand());
              pharmacyItem.setReorderLevel(inventoryItem.getReorderLevel());
              pharmacyItem.setReorderQty(inventoryItem.getReorderQty());
              pharmacyItem.setStrength(inventoryItem.getStrength());
              pharmacyItem.setTherapeuticGroup(inventoryItem.getTherapeuticGroup());
              pharmacyItem.setUnitsOfMeasure(inventoryItem.getUnitsOfMeasure());
              pharmacyItem.setVatable(inventoryItem.isVatable());
              method.save(pharmacyItem);
            }
            if(location.equalsIgnoreCase("LAB")){
              LaboratoryItem pharmacyItem = new LaboratoryItem();
              pharmacyItem.setInventoryItems(inventoryItem);
              pharmacyItem.setActiveIngredients(inventoryItem.getActiveIngredients());
              pharmacyItem.setItemCode(inventoryItem.getItemCode());
              pharmacyItem.setItemDescription(inventoryItem.getItemDescription());
              pharmacyItem.setItemForm(inventoryItem.getItemForm());
              pharmacyItem.setManufacturer(inventoryItem.getManufacturer());
              pharmacyItem.setMaximumStockLevel(inventoryItem.getMaximumStockLevel());
              pharmacyItem.setMinimumStockLevel(inventoryItem.getMinimumStockLevel());
              pharmacyItem.setPercentageMarkup(inventoryItem.getPercentageMarkup());
              pharmacyItem.setPriceMarkup(inventoryItem.getPriceMarkup());
              pharmacyItem.setQuantityOnHand(inventoryItem.getQuantityOnHand());
              pharmacyItem.setReorderLevel(inventoryItem.getReorderLevel());
              pharmacyItem.setReorderQty(inventoryItem.getReorderQty());
              pharmacyItem.setStrength(inventoryItem.getStrength());
              pharmacyItem.setTherapeuticGroup(inventoryItem.getTherapeuticGroup());
              pharmacyItem.setUnitsOfMeasure(inventoryItem.getUnitsOfMeasure());
              pharmacyItem.setVatable(inventoryItem.isVatable());
              method.save(pharmacyItem);
            }
            if(location.equalsIgnoreCase("DIS")){
              DispensaryItems pharmacyItem = new DispensaryItems();
              pharmacyItem.setInventoryItems(inventoryItem);
              pharmacyItem.setActiveIngredients(inventoryItem.getActiveIngredients());
              pharmacyItem.setItemCode(inventoryItem.getItemCode());
              pharmacyItem.setItemDescription(inventoryItem.getItemDescription());
              pharmacyItem.setItemForm(inventoryItem.getItemForm());
              pharmacyItem.setManufacturer(inventoryItem.getManufacturer());
              pharmacyItem.setMaximumStockLevel(inventoryItem.getMaximumStockLevel());
              pharmacyItem.setMinimumStockLevel(inventoryItem.getMinimumStockLevel());
              pharmacyItem.setPercentageMarkup(inventoryItem.getPercentageMarkup());
              pharmacyItem.setPriceMarkup(inventoryItem.getPriceMarkup());
              pharmacyItem.setQuantityOnHand(inventoryItem.getQuantityOnHand());
              pharmacyItem.setReorderLevel(inventoryItem.getReorderLevel());
              pharmacyItem.setReorderQty(inventoryItem.getReorderQty());
              pharmacyItem.setStrength(inventoryItem.getStrength());
              pharmacyItem.setTherapeuticGroup(inventoryItem.getTherapeuticGroup());
              pharmacyItem.setUnitsOfMeasure(inventoryItem.getUnitsOfMeasure());
              pharmacyItem.setVatable(inventoryItem.isVatable());
              method.save(pharmacyItem);
              method.save(pharmacyItem); 
            }
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
        response.sendRedirect("../addmedicine.jsp");
        return;
    }
    if (request.getParameter("action").equals("edititem")) {
        String code = request.getParameter("code");
        InventoryItems item = new InventoryItems();
        InventoryItems inventoryItem = (InventoryItems) method.getStringObject(item, code);

        String itemDescription = request.getParameter("itemdescription");
        String gdrg = request.getParameter("gdrg");
        String icd10 = request.getParameter("icd10");
        String reorderLevel = request.getParameter("reorderlevel");
        String minimumStockLevel = request.getParameter("minimumstocklevel");
        String maximumStockLevel = request.getParameter("maximumstocklevel");
        String itemType = request.getParameter("itemtype");
        String unitofmeasure = request.getParameter("unitofmeasure");
        String groupDescription = request.getParameter("groupdescription");
        String status = request.getParameter("status");
        inventoryItem.setItemCode(code);
        inventoryItem.setItemDescription(itemDescription);
        inventoryItem.setMaximumStockLevel(Integer.parseInt(maximumStockLevel));
        inventoryItem.setMinimumStockLevel(Integer.parseInt(minimumStockLevel));
        inventoryItem.setReorderLevel(Integer.parseInt(reorderLevel));
        TherapeuticGroup g = new TherapeuticGroup();
        UnitsOfMeasure measure = new UnitsOfMeasure();

        TherapeuticGroup group = (TherapeuticGroup) method.getIntegerObject(g, Integer.parseInt(groupDescription));
        UnitsOfMeasure unitsOfMeasure = (UnitsOfMeasure) method.getIntegerObject(measure, Integer.parseInt(unitofmeasure));
        inventoryItem.setTherapeuticGroup(group);
        inventoryItem.setUnitsOfMeasure(unitsOfMeasure);
        method.update(inventoryItem);
        response.sendRedirect("../edititem.jsp");
    }
    if (request.getParameter("action").equals("deleteitem")) {
        String code = request.getParameter("code");
        InventoryItems item = new InventoryItems();
        InventoryItems inventoryItem = (InventoryItems) method.getStringObject(item, code);

        method.delete(inventoryItem);
        response.sendRedirect("../adduser.jsp");
    }
    if (request.getParameter("action").equals("addtopharm")) {
        String code = request.getParameter("itemid");
        InventoryItems item = new InventoryItems();
        InventoryItems inventoryItem = (InventoryItems) method.getStringObject(item, code);
        PharmacyItem pharmacyItem = new PharmacyItem();
        pharmacyItem.setTherapeuticGroup(inventoryItem.getTherapeuticGroup());
        pharmacyItem.setItemCode(inventoryItem.getItemCode());
        pharmacyItem.setItemDescription(inventoryItem.getItemDescription());
        pharmacyItem.setMaximumStockLevel(inventoryItem.getMaximumStockLevel());
        pharmacyItem.setMinimumStockLevel(inventoryItem.getMinimumStockLevel());
        pharmacyItem.setQuantityOnHand(inventoryItem.getQuantityOnHand());
        // pharmacyItem.set(inventoryItem.getQuantityOnHand());
        pharmacyItem.setReorderLevel(inventoryItem.getReorderLevel());
        pharmacyItem.setReorderQty(inventoryItem.getReorderQty());
        pharmacyItem.setUnitsOfMeasure(inventoryItem.getUnitsOfMeasure());
        method.save(pharmacyItem);
        response.sendRedirect("../updatepharmacyitem.jsp?itemcode=" + pharmacyItem.getItemCode());
    }
    if (request.getParameter("action").equals("addpharmaitem")) {
        String code = request.getParameter("code");
        PharmacyItem pharmacyItem = new PharmacyItem();
        PharmacyItem inventoryItem = (PharmacyItem) method.getStringObject(pharmacyItem, code);

        String itemDescription = request.getParameter("itemdescription");
        String gdrg = request.getParameter("gdrg");
        String icd10 = request.getParameter("icd10");
        String reorderLevel = request.getParameter("reorderlevel");
        String minimumStockLevel = request.getParameter("minimumstocklevel");
        String maximumStockLevel = request.getParameter("maximumstocklevel");
        String unitofmeasure = request.getParameter("unitofmeasure");
        String groupDescription = request.getParameter("groupdescription");
        String status = request.getParameter("status");
        inventoryItem.setItemCode(code);
        inventoryItem.setItemDescription(itemDescription);
        inventoryItem.setMaximumStockLevel(Integer.parseInt(maximumStockLevel));
        inventoryItem.setMinimumStockLevel(Integer.parseInt(minimumStockLevel));
        inventoryItem.setReorderLevel(Integer.parseInt(reorderLevel));
        TherapeuticGroup g = new TherapeuticGroup();
        UnitsOfMeasure measure = new UnitsOfMeasure();
        TherapeuticGroup group = (TherapeuticGroup) method.getIntegerObject(g, Integer.parseInt(groupDescription));
        UnitsOfMeasure unitsOfMeasure = (UnitsOfMeasure) method.getIntegerObject(measure, Integer.parseInt(unitofmeasure));
        inventoryItem.setTherapeuticGroup(group);
        inventoryItem.setUnitsOfMeasure(unitsOfMeasure);
        method.update(inventoryItem);
        response.sendRedirect("../inventory.jsp");
    }
    //out.print(num);
%>
