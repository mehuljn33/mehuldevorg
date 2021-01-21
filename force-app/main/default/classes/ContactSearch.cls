public with sharing class ContactSearch 
{
  public static List<Contact> searchForContacts(String lname, String pcode)
  {
    return [SELECT Name fROM Contact WHERE LastName =: lname AND MailingPostalCode =: pcode];
  }  

}