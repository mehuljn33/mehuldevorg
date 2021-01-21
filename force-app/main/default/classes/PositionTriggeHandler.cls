public class PositionTriggeHandler {
    
    public static void afterInsert(Map<Id, position__c> newMap){
        
        Map<Id, String> caseIdList = new Map<Id, String>();
        for(Position__c pos : newMap.values()){
          caseIdList.put(pos.case__c, pos.Functional_area__c);
        }                             
        displayPLonCase(caseIdList);
        
        
    } 
    
    public static void afterUpdate(Map<id, position__c> oldMap, Map<id, position__c> newMap){
        createAccount(oldMap,newMap);
        updateAccount(oldMap,newMap);
    }
    
    public static void afterDelete(List<position__c> oldList){
         system.debug('\ndelete oldList : '+ oldList);
    }


    public static void beforeInsert(List<position__c> newList){
        displayDate(null,newList);
        
    } 
    
    public static void beforeUpdate(Map<id, position__c> oldMap, Map<id, position__c> newMap){
        displayDate(oldMap,newMap.values());
    }
    
    public static void beforeDelete(List<position__c> oldList){
         system.debug('\ndelete oldList : '+ oldList);
    }
    
    
    public static void displayDate(Map<id, position__c>oldMap, List<Position__c> newList){
       for(Position__c pos : newList){
         if( (oldMap!=null && (pos.Functional_area__c != oldMap.get(pos.id).Functional_area__c) ) || oldMap == null )
         {
           pos.Job_description__c = string.valueof( system.today() + 7) ;
         }

       }
      
    }
    
     public static void displayPLonCase(Map<Id, String> caseIdList){
        List<Case> caseList = [select id, EngineeringReqNumber__c from Case where id IN : caseIdList.keySet()]; 
        
        for(case cas : caseList ){
          cas.EngineeringReqNumber__c = caseIdList.get(cas.id) ;
        }
        update caseList ; 
    }
    
    public static void createAccount(Map<id, position__c> oldMap, Map<id, position__c> newMap){
       Account acc;
       List<account> accList = new List<account>();
       for(position__c pos : newMap.values() ){
              if(pos.Max_Pay__c != oldMap.get(pos.id).Max_Pay__c && pos.Max_Pay__c > 5000) {
                system.debug ('in if of create account');
                acc = new Account(name = pos.name + ' account', position__c = pos.id, SLA__c = 'Gold', SLASerialNumber__c = '345', SLAExpirationDate__c = system.today() + 15);
                accList.add(acc);
              }
 
       }
       
       if(!accList.isEmpty()){
         try{
           insert accList ; 
         }
         catch(Exception e){
           for(position__c pos : newMap.values()){
             pos.addError('can not be edited because : ' + e.getmessage() );
           }
         }
         
       }
     
    }
    
    public static void updateAccount(Map<id, position__c> oldMap, Map<id, position__c> newMap){
       
       List<account> accList = new List<account>();
       List<position__c> posList = new List<position__c>();
       List<position__c> posRecords = new List<position__c>();
       for(position__c pos : newMap.values() ){
              if(pos.Min_Pay__c != oldMap.get(pos.id).Min_Pay__c && pos.Min_Pay__c > 1000) {
                posList.add(pos);
              }
       }
       
       posRecords = [select id, name, Min_Pay__c, (select Contact_Total__c from accounts__r)
                     from position__c
                     where Id in :posList];
                     
            system.debug('posRecords : ' + posRecords);             
      
       for(position__c pos : posRecords){
         for(Account acc : pos.accounts__r){
           acc.Contact_Total__c = pos.Min_Pay__c;
           accList.add(acc);
         }
       }
                     
       system.debug('acclist : ' + acclist);
       if(!accList.isEmpty()){
         try{
           update accList ; 
         }
         catch(Exception e){
           for(position__c pos : newMap.values()){
             pos.addError('can not be edited because : ' + e.getmessage() );
           }
         }
         
       }
     
    }
    
}