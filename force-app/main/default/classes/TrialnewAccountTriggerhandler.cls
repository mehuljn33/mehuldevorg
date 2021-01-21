public class TrialnewAccountTriggerhandler{
    public static void afterInsert(Map<Id, account> newMap){
     //createOppty(newmap.values());
     //errorTest(newMap);
     createContact(newMap);
     List<Account> lstAcc = newMap.Values(); 
     for (account acc : lstacc) {
        // acc.addError('Contact cannot be created random sexy boy');
     }
     
     List<account>  acclist = [select id, name from account where id in :newMap.keySet()];
        system.debug('after insert newmap' + newmap);
      List<account>  acclist2 = [select id, name from account ];
      system.debug('acclist2 in after insert'+accList2.size());
       acclist[0].NumberofLocations__c = 10;
         update acclist;
    }

    public static void beforeInsert(list<account> newlist){
        String strtest;
      
            List<account>  acclist2 = [select id, name from account ];
      system.debug('acclist2 in before insert'+accList2.size());
    
    }
    
    public static void afterUpdate(Map<Id, account> oldMap, list<account> newlist){
            
         system.debug('###after' + newlist[0].Position__r.case__c);
        
    }    

    public static void beforeUpdate(Map<Id, account> oldMap, list<account> newlist){
     
      system.debug('###before' + newlist[0].position__r.case__c);
    
    }
 
     
    public static void createContact(Map<Id, account> newMap){
        List<Account> lstAcc = newMap.Values();
        List<Contact> lstCon = new List<Contact>();
        contact objcon = new contact();
        for (integer i = 0; i<4 ; i++) {
            objcon = new contact(lastname = 'testingAcc' + i);
            objcon.accountid = lstAcc[0].id;
            lstcon.add(objcon);
        }
        
        
        
    }
    
    public static void createOppty(List<account> newlist){
      List<opportunity> opptylist= new List<opportunity>();
      Opportunity opp ; 
      decimal lim;
      date dT = system.today();
      date date1 = date.newinstance(2016,10,13);
      for(account acc : newlist){
          lim = acc.NumberofLocations__c == null ? 0 : acc.NumberofLocations__c;
          for(decimal i=0;i<lim;i++){
           opp = new opportunity(accountid = acc.id, name = acc.name+i, CloseDate = date1, stagename = 'Prospecting');
           opptylist.add(opp);
          }
      }
      try{
      insert opptylist;
      }
      catch(Exception e){
      newlist[0].adderror(e.getMessage());
      }
      
      
    }
    
    public static void errorTest(Map<Id, account> newMap){
        for(Account acc : newMap.values()){
            acc.addError('cant insert');

        } 
        return;
        system.debug('after add error');        
    }
}