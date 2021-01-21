trigger TestOpptyTrigger on Opportunity (after insert,after update, after delete,before insert, before update, before delete) {
    
    if(Trigger.isAfter){
      if(Trigger.isInsert){    
       TestOpptyTriggerHandler.afterInsert(trigger.newMap);
       }
      if(Trigger.isUpdate){    
       TestOpptyTriggerHandler.afterUpdate(trigger.newMap, trigger.oldMap);
       }
      if(Trigger.isDelete){    
       TestOpptyTriggerHandler.afterDelete(trigger.old);
       }              
    }

    
    if(Trigger.isBefore){
      if(Trigger.isInsert){    
       TestOpptyTriggerHandler.beforeInsert(trigger.new);
       }
      if(Trigger.isUpdate){    
       TestOpptyTriggerHandler.beforeUpdate(trigger.newMap, trigger.oldMap);
       }
      if(Trigger.isDelete){    
       TestOpptyTriggerHandler.beforeDelete(trigger.oldMap);
       }       
             
    }

}