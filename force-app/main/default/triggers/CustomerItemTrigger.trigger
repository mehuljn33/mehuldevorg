trigger CustomerItemTrigger on CMS_Customer_Item__c (after insert) {
    if (trigger.isAfter && trigger.IsInsert) {
        //CustomerItemTriggerHandler.afterInsert(trigger.new);
        List<CFS_Customer__c> lst = [Select id, Currently_Borrowed_Items__c from CFS_Customer__c where id =: Trigger.new[0].CSF_Customer__c];
        system.debug('@@lst ' + lst[0].Currently_Borrowed_Items__c);
        
        System.enqueueJob(new Queueable1 ());
    }
}