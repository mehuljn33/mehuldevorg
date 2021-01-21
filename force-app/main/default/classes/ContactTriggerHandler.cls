public class ContactTriggerHandler{
    public static void beforeInsertUpdate(List<Contact> newContacts, Map<Id,Contact> oldMap){
        for(Contact con : newContacts){
                con.Track_History__c = 'newbefore';
        }
    }
    public static void afterInsertUpdate(List<Contact> newContacts, Map<Id,Contact> oldMap){
    List<Contact> conList = new List<Contact>();
     List<Contact> newconList = new List<Contact>();
        for(Contact con : newContacts){
                con.Track_History__c = 'newafter';
                conList.add(con);
        }
        for(Contact con : conList){
          Contact c = new Contact(id = con.Id,Track_History__c = con.Track_History__c);
          newconList.add(c);
        }
        update newconList;
    }    
  }