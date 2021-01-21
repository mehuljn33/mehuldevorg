/*
@Author : Mehul Jain
@Date : 17/11/2109
@Description : Test class for the Server side controller for the Item search component.
*/

@IsTest
public class TestItemSearchController {
    private static CFS_Item__c objItem1;
    private static CFS_Item__c objItem2;
    private static CFS_Customer__c objCustomer;
    
    public static testmethod void testCase1(){
        createData();
        Test.startTest();
        List<CMS_Customer_Item__c> lstCI = new List<CMS_Customer_Item__c>();
        ItemSearchController.getItemList('Test', 'Books', '');
        ItemSearchController.getItemList('Test', 'AV', '');
        lstCI = ItemSearchController.createCI(JSON.serialize(new List<String>{objItem1.Id, objItem2.Id}), objCustomer.id);
        ItemSearchController.calculateLateFee(String.valueOf(objCustomer.Id));
        ItemSearchController.verifyItems(objCustomer.Id, JSON.serialize(lstCI));
        ItemSearchController.insertCI(JSON.serialize(lstCI));
        ItemSearchController.insertCI(JSON.serialize(new List<String>{'test1', 'test2'}));
        ItemSearchController.fetchCategories();
        List<CMS_Customer_Item__c> lstCustItem = [select id from CMS_Customer_Item__c ];
        system.assert(lstCustItem.size() > 0);
        Test.stopTest();
    }
    
    public static void createData () {
        Id idRTBook =  Schema.SObjectType.CFS_Item__c.getRecordTypeInfosByDeveloperName().get('CFS_Book').getRecordTypeId();
        Id idRTAV =  Schema.SObjectType.CFS_Item__c.getRecordTypeInfosByDeveloperName().get('CFS_AVEquipment').getRecordTypeId();
        List<CFS_Item__c> lstItem = new List<CFS_Item__c >();
        objItem1 = new CFS_Item__c();
        objItem1.Recordtypeid = idRTBook;
        objItem1.Book_Name__c = 'Test Book1';
        
        objItem2 = new CFS_Item__c();
        objItem2.Recordtypeid = idRTAV;
        objItem2.Video_Name__c = 'Test Video1';
        lstItem.add(objItem1);
        lstItem.add(objItem2);
        
        insert lstItem;
        
        
        objCustomer = new CFS_Customer__c();
        objCustomer.Name = 'Test User';
        objCustomer.Email__c = 'test@test.com';
        objCustomer.Mobile__c = '9999800887';
        
        insert objCustomer;
    }
}