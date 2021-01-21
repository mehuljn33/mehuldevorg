@isTest
public class TestRestrictContactByName {
@isTest static void test1()
{    
Contact con=new Contact(LastName='INVALIDNAME');
try
{
   insert con;    
}
catch(Exception e)
{
   System.assert(e.getMessage().contains('is not allowed for DML'));
}
}    
}