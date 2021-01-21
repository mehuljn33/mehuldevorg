public class DisplayOwnerController {
    public Account acct;
    public String message{get;set;}  
    public String name{get;set;}
    public String email{get;set;}
    public String phone{get;set;}
    public Boolean exists;
    public DisplayOwnerController(ApexPages.StandardController stdController){
        message ='The owner values are : ';
        exists = true;
        try{
        //this.acct = (Account)stdController.getrecord();
        acct = [SELECT Owner.Name, Owner.Phone, Owner.Email from Account WHERE Id =: stdController.getrecord().Id ];
        }
        catch(System.Exception e){
        exists = false;
        }
    }

    
    public void displayOwner(){
    
            if(exists){
             name = (acct.Owner.Name!=null ? '\nAccount Owner Name : ' + acct.Owner.Name : ' ');
             phone =(acct.Owner.Phone!=null ? '\nAccount Owner Phone : ' + acct.Owner.Phone : ' ');
             email = (acct.Owner.Email!=null ?'\nAccount Owner Email : ' + acct.Owner.Email : ' ');
        }
        else{
            message = 'The record does not exist';
        }
        
    }
}