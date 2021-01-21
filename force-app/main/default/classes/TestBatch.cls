global class TestBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name FROM Account where name like \'test%\'';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        system.debug(scope);
         for(Account a : scope)
         {
             a.Name = a.Name + 'Updated';            
         }
         update scope;
    }   
    
    global void finish(Database.BatchableContext BC) {
         Messaging.SingleEmailMessage mail = 
      new Messaging.SingleEmailMessage();
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
       List<String> sendTo = new List<String>();
      sendTo.add('mehuljn33@gmail.com');
      mail.setToAddresses(sendTo);
    
      mail.setReplyTo('mehuljn33@hotmail.com');
      mail.setSenderDisplayName('Official Bank of Nigeria');
    
        List<String> ccTo = new List<String>();
      ccTo.add('mehuljain.cse15@jecrc.ac.in');
      mail.setCcAddresses(ccTo);

       mail.setSubject('URGENT BUSINESS PROPOSAL');
      String body = 'email sent through code';
 	   mail.setPlainTextBody(body);
       mails.add(mail);
  	 Messaging.sendEmail(mails);
        system.debug('mail sent');
  }  
}