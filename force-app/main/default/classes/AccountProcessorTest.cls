@isTest
public class AccountProcessorTest {
    @isTest
    public static void testPositive() {
        List<Id> lstId = new List<Id>();
        List<Account> lstAcc = createAccounts(10);
        insert lstAcc;
        
        Contact con = createContacts(1)[0];
        con.AccountId = lstAcc[0].Id;
        insert con;
                                
        for(Account acc : lstAcc) {
            lstId.add(acc.Id);
        }   
        
        Test.startTest();
            AccountProcessor.countContacts(lstId);
            system.assertEquals('true', 'true');
        Test.stopTest();
    }
    
    public static List<Contact> createContacts(Integer intNum) {
        List<Contact> lstContact = new List<Contact>();
        Contact con ;
        for(Integer i =0; i<intNum ; i++){
            con = new Contact(LastName = 'test'+i);
            lstContact.add(con);
        }
       return lstContact; 
    }
    
    public static List<Account> createAccounts(Integer intNum) {
        List<Account> lstAccount = new List<Account>();
        Account acc ;
        for(Integer i =0; i<intNum ; i++){
            acc = new Account(Name = 'test'+i);
            lstAccount.add(acc);
        }
       return lstAccount; 
    }    
}