@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        // add 100 child accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i, billingstate = 'NY'
            ));
        }
        insert accounts;
        for (Integer i = 0; i < 50; i++) {
            contacts.add(new Contact(
                LastName='Test contact'+i, Accountid = accounts[i].Id
            ));
        }
        insert contacts;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        List<Contact> contacts = [select id, account.billingstate, name from contact where account.billingstate = 'NY'];
        // Create our Queueable instance
        // startTest/stopTest block to force async processes to run
        Test.startTest();   
        for(Integer i = 0; i < 50; i++){
        AddPrimaryContact updater = new AddPrimaryContact(contacts[i], 'NY');
        System.enqueueJob(updater);
        }
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from contact where account.billingstate = 'NY']);
    }
    
}