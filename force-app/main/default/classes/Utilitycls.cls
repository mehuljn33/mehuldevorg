public class Utilitycls {


	public static Candidate__c createCandidate(Integer i, Boolean isInsert){
		Candidate__c can1 = new Candidate__c();

			can1.First_Name__c = 'John'+i;
			can1.Mobile__c = '999999999'+i;
			can1.Email__c = 'John'+i+'@test.c';
            can1.SSN__c = '678' + i;
            can1.Date_of_Birth__c = date.newInstance(1990,6,5+i);
            can1.City__c = 'Jaipur';
		
        if(isInsert){
            insert can1;
        }
            
        return can1;

	}


	public static Position__c createPosition(String posName, String Hir_mgr, Boolean isInsert){
		Position__c pos1 = new Position__c();
        pos1.Name = posName;
		pos1.Hiring_Manager__r = [SELECT Id, FirstName 
                                  FROM User 
                                  WHERE Name =:Hir_mgr LIMIT 1];
        pos1.Hiring_Manager__c = pos1.Hiring_Manager__r.Id;
        System.debug('hrmng'+pos1.Hiring_Manager__r.FirstName);				// issue
		
        if(isInsert){
            insert pos1;
        }
            
        return pos1;

	}


	public static Job_Application__c createJA(String candName, String posName, Boolean isInsert){
		Job_Application__c ja1 = new Job_Application__c();
		ja1.Candidate__c = [SELECT Id
                                  FROM Candidate__c 
                                  WHERE First_Name__c =:candName LIMIT 1].Id;
		ja1.Position__c = [SELECT Id 
                                  FROM Position__c 
                                  WHERE Name =:posName LIMIT 1].Id;
        

        if(isInsert){
            insert ja1;
        }
         System.debug('ja1name'+ja1.Name);   
        return ja1;

	}

}