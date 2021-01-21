trigger PositionTrigger on Position__c (after insert, after update, after delete, before insert, before update, before delete) {
    if(trigger.isAfter){
       if(Trigger.isInsert){    
       PositionTriggeHandler.afterInsert(trigger.newMap);
       }
      if(Trigger.isUpdate){    
       PositionTriggeHandler.afterUpdate(trigger.oldMap, trigger.newMap);
       }
      if(Trigger.isDelete){    
       PositionTriggeHandler.afterDelete(trigger.old);
       }   
    }
    
    
    if(trigger.isBefore){
       if(Trigger.isInsert){    
       PositionTriggeHandler.beforeInsert(trigger.new);
       }
      if(Trigger.isUpdate){    
       PositionTriggeHandler.beforeUpdate(trigger.oldMap, trigger.newMap);
       }
      if(Trigger.isDelete){    
       PositionTriggeHandler.beforeDelete(trigger.old);
       }   
    }

}