trigger OrderEventTrigger on Order_Event__e (after insert) {
    list<Task> lstTask = new List<Task>();
    Task objTask ; 
    for(Order_Event__e event : trigger.new){
        if( event.Has_Shipped__c == true ) {
            objTask  = new Task();
            objTask.Priority = 'Medium';
            objTask.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            objTask.OwnerId = event.CreatedById;
            lstTask.add(objTask);
        }
        
    }
    
    insert lstTask;
}