public class BatchApexErrorTriggerHandler {
    public static void afterInsert(list<BatchApexErrorEvent> newList){
        List<BatchLeadConvertErrors__c > lstBL = new List<BatchLeadConvertErrors__c >();
        BatchLeadConvertErrors__c objBL = new BatchLeadConvertErrors__c ();
        for ( BatchApexErrorEvent objB : newList){
        	objBL.AsyncApexJobId__c = objB.AsyncApexJobId; 
            objBL.Records__c = objB.JobScope;
            objBL.StackTrace__c = objB.StackTrace;
            lstBL.add(objBL);
        }
        
        update lstBL;
    }
}