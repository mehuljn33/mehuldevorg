public with sharing class ItemBuyerController {
    @AuraEnabled(cacheable=true)
    public static List<CFS_Item__c> getItems(){
        List<CFS_Item__c> lstItem = [Select Id, Name, 
                                    Book_Author__c, Book_name__c,Book_Publication__c
                                    FROM CFS_Item__c 
                                    Where Book_name__c != null 
                                    Limit 10];
        return lstItem;                            
    }
    
    @AuraEnabled(cacheable=true)
    public static List<CMS_Customer_Item__c> getCustItems(String strItemId){
        system.debug('@strItemId' + strItemId);
        List<CMS_Customer_Item__c> lstItem = [Select Id, Name, CSF_Customer__r.Name, 
                                    Item_Code__c, Status__c,CSF_Customer__r.Id
                                    FROM CMS_Customer_Item__c 
                                    Where CSF_Item__c =: strItemId 
                                    Limit 10];
        return lstItem;                            
    }
}