@isTest
private class LeadProcessorTest {

    @testSetup 
    static void setup() {
        List<Lead> lstLead = new List<Lead>();
        // insert 10 leads
        for(Integer i=0; i<200; i++) {
            lstLead.add(new Lead(LastName='Lead '+i, Company = 'New York', Status = 'Open - Not Contacted'));
        }
        insert lstLead;

    }
    

    static testmethod void test() {        
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where Company = 'New York']);
    }
    
}