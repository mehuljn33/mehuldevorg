public class Util{

	public static Contact newContact(Integer i, Boolean isInsert){
		Contact con = new Contact();

			con.FirstName = 'John'+i;
			con.LastName = '999999999'+i;
			con.Email = 'John'+i+'@test.c';
		
        if(isInsert){
            insert con;
        }
            
        return con;
	}
}