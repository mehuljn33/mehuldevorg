public class RandomContactFactory {
public static list<contact> generateRandomContacts(integer n, String s)
{
List<Contact>newlst=new List<Contact>();
for(integer i=0;i<n;i++)
{
 Contact con=new Contact();
 con.LastName=s;
 con.FirstName='test'+i;
 newlst.add(con);   
}
return newlst;   
}
}