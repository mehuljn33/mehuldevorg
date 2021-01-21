@IsTest
public class CandidateTriggerHandlerTest {

	public static testmethod void testDOBIsNull (){
    // test insert        
	Candidate__c can = Utilitycls.createCandidate(0,false);
    Boolean notInserted = false;    
    test.startTest();
    can.Date_of_Birth__c = null;
    try{    
    	insert can;   
    }
    catch(DmlException e){
        notInserted = true;
    }
	System.assertEquals(notInserted, true);
	notInserted = false;
    
    // test update    
	can = Utilitycls.createCandidate(7,true);
    can.Date_of_Birth__c = date.newInstance(1990,6,6);    
    update can;
    can.Date_of_Birth__c = null;
    try{    
    	update can;   
    }
    catch(DmlException e){
        notInserted = true;
    }
	System.assertEquals(notInserted, true);
    test.stopTest();    
	}

    public static testmethod void VerifyAge (){
    //test insert    
		Utilitycls.createCandidate(6,true);    
        test.startTest();
        Candidate__c can = [SELECT Candidate__c.Date_of_Birth__c FROM Candidate__c wHERE Candidate__c.First_Name__c = 'John6' LIMIT 1]; 
        Integer days = can.Date_of_Birth__c.daysBetween(Date.today());        
		System.assertEquals(Integer.valueOf(days/365), 25);
        
    //test update
    	can.Date_of_Birth__c = date.newInstance(1991,6,6);
        update can;
        days = can.Date_of_Birth__c.daysBetween(Date.today());        
    	System.assertEquals(Integer.valueOf(days/365), 24);
    	test.stopTest();
	}
    
    public static testmethod void testDuplicate (){
        // test insert
        List<Candidate__c> canList = new List<Candidate__c>();
        Boolean notInserted = false;
        test.startTest();
        for(Integer i = 1;i<=5;i++){
        canList.add(Utilitycls.createCandidate(i,false));
        }
        insert canList ;
		Candidate__c can = Utilitycls.createCandidate(3,false);
        try{    
            insert can;   
        }
        catch(Exception e){  
            notInserted = true;
            can.addError('Duplicate entry not allowed');
        }
        System.assertEquals(notInserted, true);
        notInserted = false;
       
 
        //test update
        can = [SELECT Candidate__c.First_name__c, Candidate__c.Mobile__c, Candidate__c.Date_of_Birth__c FROM Candidate__c WHERE Candidate__C.First_name__c = 'John4' LIMIT 1]; 
		can.First_Name__c = 'John2';
		can.Mobile__c = '9999999992';
		can.Email__c = 'John3@test.c';
        update can;							// successfull update
        
		can.Email__c = 'John2@test.c';
        
        try{    
            update can;   					// unsuccessfull update
        }
        catch(Exception e){  
            notInserted = true;
            can.addError('Duplicate entry not allowed');
        }
        System.assertEquals(notInserted, true);         
        test.stopTest();
	}

}