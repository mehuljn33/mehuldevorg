Trigger Oppty_Trigger on Opportunity (After insert, After delete, After update) {
    if (trigger.isAfter && trigger.isInsert) {
      OpptyTriggerHandler.afterInsert(trigger.new);  
    }
    if (trigger.isAfter && trigger.isUpdate) {
        system.debug('inside after trigger oppty');
      OpptyTriggerHandler.afterUpdate(trigger.new, trigger.oldMap);  
    }
    if (trigger.isAfter && trigger.isDelete) {
      OpptyTriggerHandler.afterDelete(trigger.old);  
    }    
}