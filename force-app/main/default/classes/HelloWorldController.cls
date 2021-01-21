public with sharing class HelloWorldController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> mymethod(){
        List<Contact> lstCon = [Select Id, Email,LastName from Contact limit 10];
        return lstCon;
        //return 'from method 1';
    }

    @AuraEnabled(cacheable=true)
    public static String mymethod2(String strText){
      // Contact objcon = [Select Id, LastName from Contact limit 10]; 
       return strText + ' addtional';
    }

    @AuraEnabled(cacheable=true)
    public static void processSelected(List<Contact> lstContacts) {
        system.debug('@@lstContacts' + lstContacts);
    }
}