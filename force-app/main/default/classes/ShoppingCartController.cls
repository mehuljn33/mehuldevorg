public class ShoppingCartController{
    public List<Product2> productList {get;set;}
    public List<Product2> cart {get;set;}
    public Integer grandTotal {get;set;}
    public Id idToRemove {get;set;}
    public ShoppingCartController(){
                cart = new List<Product2>();
        		grandTotal = 0;
    }
    public void fetchList(){
        productList = new List<Product2>();
        productList = [SELECT Name, ProductCode, Added_to_cart__c, Price__c, Subtotal__c, Quantity__c
                       FROM Product2 LIMIT 50];
    }

    public PageReference addToCart(){
        for(Product2 selected : productList){
            if(selected.Added_to_cart__c == true){
                cart.add(selected);
            }
        }
        System.debug(cart);
        PageReference pageRef= new PageReference('/apex/ShowCart');
        pageRef.setRedirect(false);       
        return pageRef;
      }
    
    public void recalculate(){
        grandTotal = 0;
        for(Product2 temp : cart){
            if(temp.Quantity__c < 50){
				temp.Subtotal__c = temp.Quantity__c * temp.Price__c;
            }
            else{
		       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid quantity'));
            }
                
			grandTotal+=(Integer)temp.Subtotal__c;
			System.debug(grandTotal);            
        }
        
    }
 
   public PageReference removeFromCart(){

        for(Integer i=0;i<cart.size();i++){
            if(cart.get(i).Id == idToRemove){
                cart.remove(i);
            }
        }

        return null;
    }

}