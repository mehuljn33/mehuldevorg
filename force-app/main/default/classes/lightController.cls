public with sharing class lightController{
    
    public list<Account> Boats{get;set;}
    
    @AuraEnabled
    public static Account getAcc(String recordId) {
         system.debug('recordid' + recordid);
         Account acc = [SELECT Name, Id FROM Account where name =: recordId limit 1];
         system.debug('acc' + acc);
        return acc;
    }
    
    
}