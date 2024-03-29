package entities;
// Generated Nov 29, 2013 11:26:33 AM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * InventoryItems generated by hbm2java
 */
@Entity
@Table(name="inventory_items"
    ,catalog="extended"
)
public class InventoryItems  implements java.io.Serializable {


     private String itemCode;
     private TherapeuticGroup therapeuticGroup;
     private UnitsOfMeasure unitsOfMeasure;
     private ItemForm itemForm;
     private String itemDescription;
     private int quantityOnHand;
     private String manufacturer;
     private double priceMarkup;
     private double percentageMarkup;
     private int reorderLevel;
     private int minimumStockLevel;
     private String strength;
     private String activeIngredients;
     private int reorderQty;
     private Integer maximumStockLevel;
     private boolean vatable;
     private String location;
     private Set<PharmacyItem> pharmacyItems = new HashSet<PharmacyItem>(0);
     private Set<PurchaseOrderItems> purchaseOrderItemses = new HashSet<PurchaseOrderItems>(0);
     private Set<LaboratoryItem> laboratoryItems = new HashSet<LaboratoryItem>(0);
     private Set<ItemBatch> itemBatchs = new HashSet<ItemBatch>(0);
     private Set<Requisition> requisitions = new HashSet<Requisition>(0);
     private Set<Dosage> dosages = new HashSet<Dosage>(0);
     private Set<DispensaryItems> dispensaryItemses = new HashSet<DispensaryItems>(0);

    public InventoryItems() {
    }

	
    public InventoryItems(String itemCode, TherapeuticGroup therapeuticGroup, ItemForm itemForm, String itemDescription, int quantityOnHand, String manufacturer, double priceMarkup, double percentageMarkup, int reorderLevel, int minimumStockLevel, String strength, int reorderQty, boolean vatable, String location) {
        this.itemCode = itemCode;
        this.therapeuticGroup = therapeuticGroup;
        this.itemForm = itemForm;
        this.itemDescription = itemDescription;
        this.quantityOnHand = quantityOnHand;
        this.manufacturer = manufacturer;
        this.priceMarkup = priceMarkup;
        this.percentageMarkup = percentageMarkup;
        this.reorderLevel = reorderLevel;
        this.minimumStockLevel = minimumStockLevel;
        this.strength = strength;
        this.reorderQty = reorderQty;
        this.vatable = vatable;
        this.location = location;
    }
    public InventoryItems(String itemCode, TherapeuticGroup therapeuticGroup, UnitsOfMeasure unitsOfMeasure, ItemForm itemForm, String itemDescription, int quantityOnHand, String manufacturer, double priceMarkup, double percentageMarkup, int reorderLevel, int minimumStockLevel, String strength, String activeIngredients, int reorderQty, Integer maximumStockLevel, boolean vatable, String location, Set<PharmacyItem> pharmacyItems, Set<PurchaseOrderItems> purchaseOrderItemses, Set<LaboratoryItem> laboratoryItems, Set<ItemBatch> itemBatchs, Set<Requisition> requisitions, Set<Dosage> dosages, Set<DispensaryItems> dispensaryItemses) {
       this.itemCode = itemCode;
       this.therapeuticGroup = therapeuticGroup;
       this.unitsOfMeasure = unitsOfMeasure;
       this.itemForm = itemForm;
       this.itemDescription = itemDescription;
       this.quantityOnHand = quantityOnHand;
       this.manufacturer = manufacturer;
       this.priceMarkup = priceMarkup;
       this.percentageMarkup = percentageMarkup;
       this.reorderLevel = reorderLevel;
       this.minimumStockLevel = minimumStockLevel;
       this.strength = strength;
       this.activeIngredients = activeIngredients;
       this.reorderQty = reorderQty;
       this.maximumStockLevel = maximumStockLevel;
       this.vatable = vatable;
       this.location = location;
       this.pharmacyItems = pharmacyItems;
       this.purchaseOrderItemses = purchaseOrderItemses;
       this.laboratoryItems = laboratoryItems;
       this.itemBatchs = itemBatchs;
       this.requisitions = requisitions;
       this.dosages = dosages;
       this.dispensaryItemses = dispensaryItemses;
    }
   
     @Id 
    
    @Column(name="item_code", unique=true, nullable=false, length=100)
    public String getItemCode() {
        return this.itemCode;
    }
    
    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="therapeutic_group", nullable=false)
    public TherapeuticGroup getTherapeuticGroup() {
        return this.therapeuticGroup;
    }
    
    public void setTherapeuticGroup(TherapeuticGroup therapeuticGroup) {
        this.therapeuticGroup = therapeuticGroup;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="unit_of_issue")
    public UnitsOfMeasure getUnitsOfMeasure() {
        return this.unitsOfMeasure;
    }
    
    public void setUnitsOfMeasure(UnitsOfMeasure unitsOfMeasure) {
        this.unitsOfMeasure = unitsOfMeasure;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="form_id", nullable=false)
    public ItemForm getItemForm() {
        return this.itemForm;
    }
    
    public void setItemForm(ItemForm itemForm) {
        this.itemForm = itemForm;
    }
    
    @Column(name="item_description", nullable=false)
    public String getItemDescription() {
        return this.itemDescription;
    }
    
    public void setItemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
    }
    
    @Column(name="quantity_on_hand", nullable=false)
    public int getQuantityOnHand() {
        return this.quantityOnHand;
    }
    
    public void setQuantityOnHand(int quantityOnHand) {
        this.quantityOnHand = quantityOnHand;
    }
    
    @Column(name="manufacturer", nullable=false, length=500)
    public String getManufacturer() {
        return this.manufacturer;
    }
    
    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }
    
    @Column(name="price_markup", nullable=false, precision=22, scale=0)
    public double getPriceMarkup() {
        return this.priceMarkup;
    }
    
    public void setPriceMarkup(double priceMarkup) {
        this.priceMarkup = priceMarkup;
    }
    
    @Column(name="percentage_markup", nullable=false, precision=22, scale=0)
    public double getPercentageMarkup() {
        return this.percentageMarkup;
    }
    
    public void setPercentageMarkup(double percentageMarkup) {
        this.percentageMarkup = percentageMarkup;
    }
    
    @Column(name="reorder_level", nullable=false)
    public int getReorderLevel() {
        return this.reorderLevel;
    }
    
    public void setReorderLevel(int reorderLevel) {
        this.reorderLevel = reorderLevel;
    }
    
    @Column(name="minimum_stock_level", nullable=false)
    public int getMinimumStockLevel() {
        return this.minimumStockLevel;
    }
    
    public void setMinimumStockLevel(int minimumStockLevel) {
        this.minimumStockLevel = minimumStockLevel;
    }
    
    @Column(name="strength", nullable=false)
    public String getStrength() {
        return this.strength;
    }
    
    public void setStrength(String strength) {
        this.strength = strength;
    }
    
    @Column(name="active_ingredients", length=1000)
    public String getActiveIngredients() {
        return this.activeIngredients;
    }
    
    public void setActiveIngredients(String activeIngredients) {
        this.activeIngredients = activeIngredients;
    }
    
    @Column(name="reorder_qty", nullable=false)
    public int getReorderQty() {
        return this.reorderQty;
    }
    
    public void setReorderQty(int reorderQty) {
        this.reorderQty = reorderQty;
    }
    
    @Column(name="maximum_stock_level")
    public Integer getMaximumStockLevel() {
        return this.maximumStockLevel;
    }
    
    public void setMaximumStockLevel(Integer maximumStockLevel) {
        this.maximumStockLevel = maximumStockLevel;
    }
    
    @Column(name="vatable", nullable=false)
    public boolean isVatable() {
        return this.vatable;
    }
    
    public void setVatable(boolean vatable) {
        this.vatable = vatable;
    }
    
    @Column(name="location", nullable=false)
    public String getLocation() {
        return this.location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<PharmacyItem> getPharmacyItems() {
        return this.pharmacyItems;
    }
    
    public void setPharmacyItems(Set<PharmacyItem> pharmacyItems) {
        this.pharmacyItems = pharmacyItems;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<PurchaseOrderItems> getPurchaseOrderItemses() {
        return this.purchaseOrderItemses;
    }
    
    public void setPurchaseOrderItemses(Set<PurchaseOrderItems> purchaseOrderItemses) {
        this.purchaseOrderItemses = purchaseOrderItemses;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<LaboratoryItem> getLaboratoryItems() {
        return this.laboratoryItems;
    }
    
    public void setLaboratoryItems(Set<LaboratoryItem> laboratoryItems) {
        this.laboratoryItems = laboratoryItems;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<ItemBatch> getItemBatchs() {
        return this.itemBatchs;
    }
    
    public void setItemBatchs(Set<ItemBatch> itemBatchs) {
        this.itemBatchs = itemBatchs;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<Requisition> getRequisitions() {
        return this.requisitions;
    }
    
    public void setRequisitions(Set<Requisition> requisitions) {
        this.requisitions = requisitions;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<Dosage> getDosages() {
        return this.dosages;
    }
    
    public void setDosages(Set<Dosage> dosages) {
        this.dosages = dosages;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="inventoryItems")
    public Set<DispensaryItems> getDispensaryItemses() {
        return this.dispensaryItemses;
    }
    
    public void setDispensaryItemses(Set<DispensaryItems> dispensaryItemses) {
        this.dispensaryItemses = dispensaryItemses;
    }




}


