public class OpptyTriggerHandler{
    public static void afterInsert(List<Opportunity> newList) {
        List<Id> lstContactId= new List<Id>();
        for(Opportunity objOpp : newList){
            lstContactId.add(objOpp.XYZ_Contact__c);
        }
        
        calculateAmount(lstContactId);
    }
    
    public static void afterUpdate(List<Opportunity> newList, Map<Id,Opportunity> oldMap) {
        List<Id> lstContactId= new List<Id>();
        for(Opportunity objOpp : newList){
            if (objOpp.Amount != oldMap.get(objOpp.id).Amount)
                lstContactId.add(objOpp.XYZ_Contact__c);
        }
        
        calculateAmount(lstContactId);
    }
    
    public static void afterDelete(List<Opportunity> oldList) {
        List<Id> lstContactId= new List<Id>();
        for(Opportunity objOpp : oldList){
            lstContactId.add(objOpp.XYZ_Contact__c);
        }
        
        calculateAmount(lstContactId);
    }
    
    //Calculate Roll up summary field on Parent 
    public static void calculateAmount(List<Id> lstContactIds){
        system.debug('@@cal' + lstContactIds);
        List<Contact> lstContact = new List<Contact>();
        for(Contact objCon : [SELECT XYZ_Total_Deals__c,(SELECT id, Amount FROM Opportunities__r) FROM Contact WHERE id =: lstContactIds]){
            objCon.XYZ_Total_Deals__c = 0;
            for (Opportunity obj : objCon.Opportunities__r) {
                system.debug('@@obj ' + obj );
                objCon.XYZ_Total_Deals__c += obj.Amount;
            }
            lstContact.add(objCon);
        }
        
        update lstContact;
    }
}