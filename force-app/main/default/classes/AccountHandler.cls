public with sharing class AccountHandler 
{
  public static Account insertNewAccount(String accountName)
  {
    try
    {
        Account acct = new Account(Name = accountName);
        insert acct;
        return acct;
    } 
    catch (DmlException e) 
    {
        return null;
    }

  }


  public static void calculate(){
  // line 1
  // line2
  }
  
  @future
  public static void callQueue() {
      integer i ;
  }

}