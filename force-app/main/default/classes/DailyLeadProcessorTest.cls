@isTest
public class DailyLeadProcessorTest{
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @isTest
    private static void test() {
        List<Lead> lstLead = new List<Lead>();
        for(Integer i=0; i<200; i++){
            Lead l = new Lead(LastName = 'test'+i, Company = 'test', Status = 'Open - Not Contacted', LeadSource = '');
            lstLead.add(l);
        }
        
        insert lstLead;
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor()); 
        Test.stopTest(); 
        
    }
}