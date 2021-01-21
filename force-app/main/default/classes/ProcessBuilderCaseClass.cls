public class ProcessBuilderCaseClass {
	@InvocableMethod
    public static void UpdateCase(List<id> CaseIds){
        system.debug('invocable');
        List<Position__c> posList = new List<Position__c> ();
        List<Case> caseList = [select id, EngineeringReqNumber__c, (Select id, RecordTypeId from positions__r) from case where id in :caseids];
        for(Case cas : caseList){
      
            cas.EngineeringReqNumber__c = '12345' ; 
            for(position__c pos : cas.positions__r){
                pos.recordtypeId = recordTypeId('Position__c', 'IT Position'); // use specific method for retrieving RT ids from name
                posList.add(pos);
            }
            system.debug('in for');
        }
        
        update caseList;
        update posList;
    }
    
     public static Id recordTypeId(string obj,string recName){
        Id recTypeId;
        if(obj!= null && recName != null){
            recTypeId= Schema.getGlobalDescribe().get(obj).getDescribe().getRecordTypeInfosByName().get(recName).getRecordTypeId();
        }  
        return recTypeId;  
     }
    
}