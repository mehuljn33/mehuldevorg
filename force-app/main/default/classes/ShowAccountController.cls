public class ShowAccountController{
    public List<Account> accList{get;set;}
    public ShowAccountController(){
        accList = [SELECT Name, AccountNumber, Type, Rating
                   FROM Account
                   LIMIT 10];
    }
}