trigger TestAccountTrigger on Account (after insert, after update, before update, before insert) {
  if(trigger.isafter && trigger.isinsert){  
    TrialAccountTriggerhandler.afterInsert(trigger.newmap);
  }

   if(trigger.isafter && trigger.isupdate){  
   TrialAccountTriggerhandler.afterUpdate(trigger.oldmap, trigger.new);
  }
    
   if(trigger.isbefore && trigger.isinsert){  
    system.debug('@@insert' + trigger.new[0].candidate_age__c);
    system.debug('@@insert' + trigger.new[0].candidate__r.age__c);
    TrialAccountTriggerhandler.beforeInsert(trigger.new);
  }

   if(trigger.isbefore && trigger.isupdate){  
    system.debug('@@update' + trigger.new[0].candidate_age__c);
    TrialAccountTriggerhandler.beforeUpdate(trigger.oldmap, trigger.new);
    
    if (trigger.new[0].Rating != trigger.old[0].Rating) {
        trigger.new[0].Type = 'Prospect';
    }
    
    if (trigger.new[0].Type != trigger.old[0].Type) {
        trigger.new[0].Industry = 'Other';
    }
    
    
    
    
  }
}