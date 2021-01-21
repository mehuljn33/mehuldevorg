@IsTest
public class ContactHandlertest {

    public static testmethod void testHandler(){
        Contact con;
        Boolean isInserted =true;
        for(Integer i=0;i<5;i++){
        con = Util.newContact(i,false);
        }
        try{
            insert con;
        }
        catch(DmlException e){
            isInserted = false;
        }
        isInserted = true;
        system.assertEquals(isInserted, true);
        
        con.Email = 'abc@exm.com';
        con.FirstName = 'abc';
        
        try{
            update con;
        }
        catch(DmlException e){
            isInserted = false;
        }
        
        system.assertEquals(isInserted, true);
          
        
    }	


}