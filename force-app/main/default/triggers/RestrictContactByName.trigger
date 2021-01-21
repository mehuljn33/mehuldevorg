trigger RestrictContactByName on Contact (before insert,before update, after insert, after update) {
   if( (Trigger.isInsert || Trigger.isUpdate ) && Trigger.isAfter){
   ContactTriggerHandler.afterInsertUpdate(Trigger.new, Trigger.oldMap)  ;  
   }
   if( (Trigger.isInsert || Trigger.isUpdate )  && Trigger.isBefore){
   ContactTriggerHandler.beforeInsertUpdate(Trigger.new, Trigger.oldMap)  ;  
   }   
 


}