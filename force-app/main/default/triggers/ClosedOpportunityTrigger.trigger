trigger ClosedOpportunityTrigger on Opportunity (before insert,before update) {
    
   OpportunityHandler oh=new OpportunityHandler();
   if(Trigger.isInsert ||Trigger.isUpdate)
    {
        oh.onUpdate(Trigger.new, Trigger.old);   
    }

}