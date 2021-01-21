public class AccountProcessor{
   
    @future
    public static void countContacts(List<Id> lstAccId) {
        
        List<Account> lstAccountUpdate = new List<Account>();
        
        List<Account> accListSFDC = [ SELECT Id, (Select Id from Contacts)
                                      FROM Account 
                                      WHERE Id IN: lstAccId ];
                                      
        for(Account acc : accListSFDC) {
            acc.Number_of_Contacts__c = acc.Contacts.size();
            lstAccountUpdate.add(acc);
        }                             
        
        update lstAccountUpdate;
    }
}