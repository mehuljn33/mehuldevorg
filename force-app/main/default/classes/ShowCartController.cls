public class ShowCartController {
    public List<Product2> myCart{get;set;} 
    public ShowCartController(){
        myCart = new List<Product2>();
        myCart = ShoppingCartController.cart;
        recalculate();
    }
    public void recalculate(){
        for(Product2 temp : myCart){
			temp.Subtotal__c = temp.Quantity__C * temp.Price__c;            
        }
    }
}