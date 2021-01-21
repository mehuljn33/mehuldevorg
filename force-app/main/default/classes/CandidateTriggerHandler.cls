public class CandidateTriggerHandler {
    
    public void beforeInsert(List<Candidate__c> newCandidates) {
        calculateAge(newCandidates,null);
        preventDuplicate(newCandidates); 
       
    }

    public void beforeUpdate(List<Candidate__c> newCandidates, Map<Id, Candidate__c> oldCandidateMap) {
        calculateAge(newCandidates, oldCandidateMap);
        List<Candidate__c> changedrecords = new List<Candidate__c>();
        for(Candidate__c can : newCandidates){
            if(can.First_Name__c != oldCandidateMap.get(can.Id).First_Name__c || can.Email__c != oldCandidateMap.get(can.Id).Email__c  || can.Mobile__c != oldCandidateMap.get(can.Id).Mobile__c ){
                changedrecords.add(can);
                
            }
            
        }
        preventDuplicate(changedrecords); 
       
    }
    
    public static void calculateAge(List<Candidate__c> newCandidate,Map<Id, Candidate__c> oldCandidateMap) {
        Boolean isInsert = (oldCandidateMap == null ? true : false);
        for(Candidate__c can : newCandidate) {
            if(can.Date_of_Birth__c != null && (isInsert || can.Date_of_Birth__c != oldCandidateMap.get(can.Id).Date_of_Birth__c)){
                Date startDate = Date.today();
                Integer days = can.Date_of_Birth__c.daysBetween(startDate);
                can.Age__c = Integer.valueOf(days/365); 
            } else if(can.Date_of_Birth__c == null) {
                can.addError('DOB_cant_be_null');
            }
        }
        
    }
    
        public void preventDuplicate(List<Candidate__c> newCandidates){
        Set<String> fname = new Set<String>();
        Set<String> email = new Set<String>();
        Set<String> mobile = new Set<String>();

        for(Candidate__c can : newCandidates){
            fname.add(can.First_Name__c);
            email.add(can.Email__c);
            mobile.add(can.Mobile__c);
        }

         System.debug('1'+fname+''+email+''+mobile);    
            
        List<Candidate__c> existing = [SELECT First_Name__c, Email__c, Mobile__c
                                      FROM Candidate__c
                                      WHERE First_Name__c IN : fname AND 
                                      Email__c IN : email AND
                                      Mobile__c IN : mobile];

        Set<String> unique = new Set<String>();                              
        for(Candidate__c can : existing){
            unique.add(can.First_Name__c + can.Email__c + can.Mobile__c);
        }

        System.debug('2'+ unique);     	
        for(Candidate__c can : newCandidates){
            if( unique.contains(can.First_Name__c + can.Email__c + can.Mobile__c) ){
                can.addError('duplicate value found');
            }

        }                              


    }


    
    
    
}