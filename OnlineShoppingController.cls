public class OnlineShoppingController {
    
    //purchaseOrder data members
	public List<PurchaseOrder__c> purchaseOrders;
    public Integer purchaseOrderResultSize{get;set;}
    public Integer purchaseOrderPageSize{get;set;}
    public Integer purchaseOrderPageNumber{get;set;}
    public Integer purchaseOrderOffSet{get;set;}
    public boolean purchaseOrderHasPrevious{
        get{
            purchaseOrderHasPrevious = purchaseOrderHasPreviousCheck();
            return purchaseOrderHasPrevious;
        }
        set;
    }
    public boolean purchaseOrderHasNext{
        get{
            purchaseOrderHasNext = purchaseOrderHasNextCheck();
            return purchaseOrderHasNext;
        }
        set;
    }
    
    //product data members
	public Map<Id,Product2> products;
    public Map<Id,Decimal> quantityList;
    public boolean showProducts{get;set;}
    public string searchProductText{get;set;}
    public Integer productResultSize{get;set;}
    public Integer productPageSize{get;set;}
    public Integer productPageNumber{get;set;}
    public Integer productOffSet{get;set;}
    public boolean productHasPrevious{
        get{
            productHasPrevious = productHasPreviousCheck();
            return productHasPrevious;
        }
        set;
    }
    public boolean productHasNext{
        get{
            productHasNext = productHasNextCheck();
            return productHasNext;
        }
        set;
    }
    
    //cart data members
    public Map<Id, PurchaseOrderLineItem__c> cartItems;
    public Map<Id,boolean> itemsToBeAddedInCart{get;set;}
    public boolean showCartItems{get;set;}
    public boolean checkQuantityValue{get;set;}
    
    //generated order data members
    public boolean showOrderItems{get;set;}
    public String invoiceNumber{
        get{
            Integer randomNum1 = Integer.valueOf(Math.random()*10000) ;
            Integer randomNum2 = Integer.valueOf(Math.random()*10000) ;
            invoiceNumber = '#' + randomNum1 + randomNum2 ;
        	return invoiceNumber; 
        }   
        set;
    }
    public Date orderDate{
        get{
            orderDate = Date.today();
            return orderDate;
        }
        set;
    }
    public Decimal billAmount{get;set;}
    
    //constructor
    public OnlineShoppingController(){
        //purchaseOrder initialization
		setPurchaseOrders();
        
        //product initialization
        setProducts();
        
        //cart initialization
        itemsToBeAddedInCart = new Map<Id,boolean>();
        for ( Id key : products.keySet()){
        	itemsToBeAddedInCart.put( key, false );
        }
    }
    
    // purchaseOrder functions
    public void setPurchaseOrders(){
        purchaseOrders = [SELECT Name, Order_Price__c, Order_Status__c, CreatedDate From PurchaseOrder__c order by CreatedDate desc];
        purchaseOrderResultSize = purchaseOrders.size();
        purchaseOrderPageSize = 10;
        purchaseOrderPageNumber = 1;
        purchaseOrderOffSet = 0;
    }
    
    public List<PurchaseOrder__c> getPurchaseOrders() {
        List<PurchaseOrder__c> orders = new List<PurchaseOrder__c>();
        Integer lastRecord = purchaseOrderPageSize;
        Integer lastPage = Integer.valueOf(Math.ceil(Decimal.valueOf(purchaseOrderResultSize)/purchaseOrderPageSize));
        if( Math.mod(purchaseOrderResultSize, purchaseOrderPageSize) != 0 && purchaseOrderPageNumber == lastPage ){
            lastRecord = Math.mod(purchaseOrderResultSize, purchaseOrderPageSize);
        }
        for(Integer i = purchaseOrderOffSet ; i < purchaseOrderOffSet+lastRecord ; i++ )
            	orders.add(purchaseOrders.get(i));
        return orders;
    }
    
    public void purchaseOrderFirst(){
        purchaseOrderPageNumber = 1;
        purchaseOrderOffSet = 0;
    }
    
    public void purchaseOrderLast(){
        purchaseOrderPageNumber = Integer.valueOf(Math.ceil(Decimal.valueOf(purchaseOrderResultSize)/purchaseOrderPageSize));
        purchaseOrderOffSet = (purchaseOrderPageNumber-1) * purchaseOrderPageSize ;
    }
    
    public void purchaseOrderPrevious(){
        purchaseOrderPageNumber -- ;
        purchaseOrderOffSet -= purchaseOrderPageSize;
    }
    
    public void purchaseOrderNext(){
        purchaseOrderPageNumber ++ ;
        purchaseOrderOffSet += purchaseOrderPageSize;
    }
    
    public boolean purchaseOrderHasPreviousCheck(){
        if( purchaseOrderPageNumber == 1 )
            return false;
        else
            return true;
    }
    
    public boolean purchaseOrderHasNextCheck(){
        if( purchaseOrderPageNumber == Integer.valueOf(Math.ceil(Decimal.valueOf(purchaseOrderResultSize)/purchaseOrderPageSize)) )
            return false;
        else
            return true;
    }
    
    //product functions
    public void setProducts(){
        List<Product2> productList = [SELECT Name, ProductCode, Description, Price_Per_Unit__c, Quantity_Available__c From Product2];
        products = new Map<Id,Product2>();
        quantityList = new Map<Id,Decimal>();
        for(Product2 P : productList){
            products.put(P.id, P);
            quantityList.put(P.Id,P.Quantity_Available__c);
        }
        productResultSize = products.size();
        productPageSize = 10;
        productPageNumber = 1;
        productOffSet = 0;
        searchProductText = null;
    }
    
    public List<Product2> getProducts() {
        List<Product2> productList = new List<Product2>();
        
        List<Product2> searchedProducts = new List<Product2>();
        if( String.isNotBlank(searchProductText) ){
            for( Id P : products.keySet() ){
                if(products.get(P).Name.startsWithIgnoreCase(searchProductText))
                    searchedProducts.add(products.get(P));
            }
            productOffSet = 0;
        	productPageNumber = 1;
        }
        else{
            for( Id P : products.keySet() ){
            	searchedProducts.add(products.get(P));
            }
        }   
        productResultSize = searchedProducts.size();
        if( productResultSize > 0 ){
            Integer lastRecord = productPageSize;
        	Integer lastPage = Integer.valueOf(Math.ceil(Decimal.valueOf(productResultSize)/productPageSize));
        	if( Math.mod(productResultSize, productPageSize) != 0 && productPageNumber == lastPage ){
            	lastRecord = Math.mod(productResultSize, productPageSize);
        	}
        
        	for(Integer i = productOffSet ; i < productOffSet+lastRecord ; i++ ){
            	productList.add(searchedProducts.get(i));
        	}
        }
       	return productList;
    }
    
    public void showProductList(){
        this.showProducts = true;
    }
    
    public void productFirst(){
        productPageNumber = 1;
        productOffSet = 0;
    }
    
    public void productLast(){
        productPageNumber = Integer.valueOf(Math.ceil(Decimal.valueOf(productResultSize)/productPageSize));
        productOffSet = (productPageNumber-1) * productPageSize ;
    }
    
    public void productPrevious(){
        productPageNumber -- ;
        productOffSet -= productPageSize;
    }
    
    public void productNext(){
        productPageNumber ++ ;
        productOffSet += productPageSize;
    }
    
    public boolean productHasPreviousCheck(){
        if( productPageNumber == 1 )
            return false;
        else
            return true;
    }
    
    public boolean productHasNextCheck(){
        if( productPageNumber == Integer.valueOf(Math.ceil(Decimal.valueOf(productResultSize)/productPageSize)) )
            return false;
        else
            return true;
    }
    
    //cart functions
    public void addToCart(){
        cartItems = new Map<Id, PurchaseOrderLineItem__c>();
        for(Id Q : quantityList.keySet()){
            products.get(Q).Quantity_Available__c = quantityList.get(Q);
        }
        for ( Id key : itemsToBeAddedInCart.keySet()){
            if ( ( itemsToBeAddedInCart.get(key) == true ) && ( products.get(key).Quantity_Available__c > 0 ) ) {
                String pname = products.get(key).Name ;
                String pcode = products.get(key).ProductCode ;
                Decimal pricePerunit = products.get(key).Price_Per_Unit__c ;
                cartItems.put(key,new PurchaseOrderLineItem__c(
                    ProductName__c = pname, ProductCode__c = pcode, Price_Per_Unit__c = pricePerUnit, Product__c = key, Quantity__c = 1 
                ));
                products.get(key).Quantity_Available__c --;
            }        
        }
        if ( cartItems.size() > 0 ){
            this.showCartItems = true ;
        }
    }
    
    public List<PurchaseOrderLineItem__c> getCartItems(){
        List<PurchaseOrderLineItem__c> items = new List<PurchaseOrderLineItem__c>();
        items.addAll(cartItems.values());
        return items;
    }
    
    public void changeQuantity(){
        Id itemToBeChanged = ApexPages.currentPage().getParameters().get('itemId');
        Integer quantity = Integer.valueOf(cartItems.get(itemToBeChanged).Quantity__c);
        if( quantity > 0 && quantity <= products.get(itemToBeChanged).Quantity_Available__c){
            checkQuantityValue = false ;
            products.get(itemToBeChanged).Quantity_Available__c = quantityList.get(itemToBeChanged) - quantity ;
        }
        else {
            checkQuantityValue = true ;
            cartItems.get(itemToBeChanged).Quantity__c = 1;
            products.get(itemToBeChanged).Quantity_Available__c = quantityList.get(itemToBeChanged) - 1 ;
        }
        
    }
    
    public void deleteItem(){
        Id itemToBeDeleted = ApexPages.currentPage().getParameters().get('deleteSelectedItem');
        Integer quantity = Integer.valueOf(cartItems.get(itemToBeDeleted).Quantity__c);
        cartItems.remove(itemToBeDeleted);
        products.get(itemToBeDeleted).Quantity_Available__c = products.get(itemToBeDeleted).Quantity_Available__c + quantity;
    }
    
    public void checkOut(){
        billAmount = 0;
        for (Id POLI : cartItems.keySet()){
            billAmount += cartItems.get(POLI).Price_Per_Unit__c * cartItems.get(POLI).Quantity__c ;
        }
        this.showOrderItems = true;
    }
    
    //generated order function
    public void placeOrder(){
        PurchaseOrder__c newOrder = new PurchaseOrder__c(Order_Price__c=billAmount,Order_Status__c='pending');
        insert newOrder;
        setPurchaseOrders();
        showOrderItems = false;
        showCartItems = false;
        showProducts = false;
    }
}