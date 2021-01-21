public class TestUtility{

    public static List<Account> createAccount(Integer intCount, Boolean isInsert){
        List<Account> lstAcc = new List<Account>();
        Account objAcc;
        for (Integer i=0; i< intCount; i++) {
            objAcc = new Account(Name='Test Account' + i);
            lstAcc.add(objAcc);
        }
        if (isInsert)
            insert lstAcc;
        return lstAcc;
    }
    
    public static List<Contact> createContact(Integer intCount, Boolean isInsert){
        List<Contact> lstCon = new List<Contact>();
        Contact objCon;
        for (Integer i=0; i< intCount; i++) {
            objCon = new Contact(LastName='Test Contact'+i);
            lstCon.add(objCon);
        }
        if (isInsert)
            insert lstCon;
        return lstCon;
    }
    
    public static List<Opportunity> createOpportunity(Integer intCount, Boolean isInsert) {
        List<Opportunity> lstOpp = new List<Opportunity>();
        Opportunity objOpp;
        for (Integer i=0; i< intCount; i++) {
            objOpp = new Opportunity(Name='Test Oppty' + i, StageName = 'Prospecting', CloseDate = System.today());
            lstOpp.add(objOpp);
        } 
        if (isInsert)
            insert lstOpp;
        return lstOpp;   
    }
}