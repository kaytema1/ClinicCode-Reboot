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
 * DispensaryItems generated by hbm2java
 */
@Entity
@Table(name="dispensary_items"
    ,catalog="extended"
)
public class DispensaryItems  implements java.io.Serializable {


     private String itemCode;
     private TherapeuticGroup therapeuticGroup;
     private UnitsOfMeasure unitsOfMeasure;
     private ItemForm itemForm;
     private InventoryItems inventoryItems;
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
     private Set<Patienttreatment> patienttreatments = new HashSet<Patienttreatment>(0);
     private Set<DispensaryBatch> dispensaryBatchs = new HashSet<DispensaryBatch>(0);

    public DispensaryItems() {
    }

	
    public DispensaryItems(String itemCode, TherapeuticGroup therapeuticGroup, UnitsOfMeasure unitsOfMeasure, ItemForm itemForm, InventoryItems inventoryItems, String itemDescription, int quantityOnHand, String manufacturer, double priceMarkup, double percentageMarkup, int reorderLevel, int minimumStockLevel, String strength, String activeIngredients, int reorderQty, boolean vatable) {
        this.itemCode = itemCode;
        this.therapeuticGroup = therapeuticGroup;
        this.unitsOfMeasure = unitsOfMeasure;
        this.itemForm = itemForm;
        this.inventoryItems = inventoryItems;
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
        this.vatable = vatable;
    }
    public DispensaryItems(String itemCode, TherapeuticGroup therapeuticGroup, UnitsOfMeasure unitsOfMeasure, ItemForm itemForm, InventoryItems inventoryItems, String itemDescription, int quantityOnHand, String manufacturer, double priceMarkup, double percentageMarkup, int reorderLevel, int minimumStockLevel, String strength, String activeIngredients, int reorderQty, Integer maximumStockLevel, boolean vatable, Set<Patienttreatment> patienttreatments, Set<DispensaryBatch> dispensaryBatchs) {
       this.itemCode = itemCode;
       this.therapeuticGroup = therapeuticGroup;
       this.unitsOfMeasure = unitsOfMeasure;
       this.itemForm = itemForm;
       this.inventoryItems = inventoryItems;
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
       this.patienttreatments = patienttreatments;
       this.dispensaryBatchs = dispensaryBatchs;
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
    @JoinColumn(name="unit_of_issue", nullable=false)
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
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_code", unique=true, nullable=false, insertable=false, updatable=false)
    public InventoryItems getInventoryItems() {
        return this.inventoryItems;
    }
    
    public void setInventoryItems(InventoryItems inventoryItems) {
        this.inventoryItems = inventoryItems;
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
    
    @Column(name="active_ingredients", nullable=false, length=1000)
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
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="dispensaryItems")
    public Set<Patienttreatment> getPatienttreatments() {
        return this.patienttreatments;
    }
    
    public void setPatienttreatments(Set<Patienttreatment> patienttreatments) {
        this.patienttreatments = patienttreatments;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="dispensaryItems")
    public Set<DispensaryBatch> getDispensaryBatchs() {
        return this.dispensaryBatchs;
    }
    
    public void setDispensaryBatchs(Set<DispensaryBatch> dispensaryBatchs) {
        this.dispensaryBatchs = dispensaryBatchs;
    }




}


