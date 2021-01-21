@IsTest

public class TestOpportunityTrigger {
    
    @IsTest
    public static void testMethodPostiveInsert() {
        List<Contact> lstCon = TestUtility.createContact(1,false);
        insert lstCon;
        
        List<Opportunity> lstopp = TestUtility.createOpportunity(5,false);
        lstOpp[0].Amount = 2000;
        lstOpp[1].Amount = 3000;
        
        lstOpp[0].XYZ_Contact__c = lstCon[0].id;
        lstOpp[1].XYZ_Contact__c = lstCon[0].id;
        
        test.startTest();
        insert lstOpp;
        
        List<Contact> lstConToTest = [Select Id, XYZ_Total_Deals__c from Contact where id=:lstCon[0].id];
        system.debug('@@lstConToTest Insert' + lstConToTest);
        system.Assert(Integer.valueOf(lstConToTest[0].XYZ_Total_Deals__c) == 5000,true);
        
        test.stopTest();
        
    }
    
    @IsTest
    public static void testMethodPostiveUpdate() {
        List<Contact> lstCon = TestUtility.createContact(1,false);
        insert lstCon;
        
        List<Opportunity> lstopp = TestUtility.createOpportunity(5,false);
        lstOpp[0].Amount = 2000;
        lstOpp[1].Amount = 3000;
        
        lstOpp[0].XYZ_Contact__c = lstCon[0].id;
        lstOpp[1].XYZ_Contact__c = lstCon[0].id;
        
        test.startTest();
        insert lstOpp;
        
        lstOpp[0].Amount = 1500;
        
        update lstOpp;
        List<Contact> lstConToTest = [Select Id, XYZ_Total_Deals__c from Contact where id=:lstCon[0].id];
        system.debug('@@lstConToTest Update' + lstConToTest);
        system.Assert(Integer.valueOf(lstConToTest[0].XYZ_Total_Deals__c) == 4500,true);
        
        test.stopTest();
        
    }
    
    @IsTest
    public static void testMethodPostiveDelete() {
        List<Contact> lstCon = TestUtility.createContact(1,false);
        insert lstCon;
        
        List<Opportunity> lstopp = TestUtility.createOpportunity(5,false);
        lstOpp[0].Amount = 2000;
        lstOpp[1].Amount = 3000;
        
        lstOpp[0].XYZ_Contact__c = lstCon[0].id;
        lstOpp[1].XYZ_Contact__c = lstCon[0].id;
        
        test.startTest();
        insert lstOpp;
        
        delete lstOpp[0];
        List<Contact> lstConToTest = [Select Id, XYZ_Total_Deals__c from Contact where id=:lstCon[0].id];
        system.debug('@@lstConToTest Delete' + lstConToTest);
        system.Assert(Integer.valueOf(lstConToTest[0].XYZ_Total_Deals__c) == 3000,true);
        
        test.stopTest();
        
    }
}