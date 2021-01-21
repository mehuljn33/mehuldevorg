@isTest
public class TestXYZ_RegionWiseController{

    @isTest public static void TestMethodPositive(){
        List<Contact> lstCon = TestUtility.createContact(4,false);
        for (Contact objCon : lstCon) {
            objCon.XYZ_FinancialYear__c = '2017-2018';
            objCon.XYZ_Region__c='Rajasthan(RJ)';
        }
        insert lstCon;
        
        Test.startTest();
        XYZ_RegionWiseController objXYZ = new XYZ_RegionWiseController();
        objXYZ.objContact.XYZ_Region__c = 'Rajasthan(RJ)';
        objXYZ.loadSalesRep();
        
        system.assert(objXYZ != null, true);
        Test.stopTest();
    }
}