trigger JATrigger on Job_Application__c (before insert, after insert, before update, after update) {
    if(trigger.isAfter && trigger.isUpdate){
        system.debug('@@trigger.new after' + trigger.new);
        list<job_application__c> lst ;
        //update lst;
        trigger.new[0].addError('error234!!');
    }
    
    if(trigger.isBefore && trigger.isUpdate){
        system.debug('@@trigger.new before' + trigger.new);
        list<job_application__c> lst;
       // trigger.new[0].addError('error!!');
        //update lst;
        
        Account a = new Account(name = 'Acme1');
        Database.SaveResult[] lsr = Database.insert(
            new Account[]{a, new Account(Name = 'Acme2')},
            false);
    }
}