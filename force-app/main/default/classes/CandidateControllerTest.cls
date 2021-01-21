@IsTest
public class CandidateControllerTest{

	static List<Candidate__c> canList = new List<Candidate__c>();
	static List<Position__C> posList = new List<Position__C>();
	static List<Job_Application__c> jaList = new List<Job_Application__c>();

	public static testmethod void testFetchData(){
		canList.add(Utilitycls.createCandidate(0,true));
        canList.add(canList.get(0));
		posList.add(Utilitycls.createPosition('Consultant','mehul jain',true));
		posList.add(Utilitycls.createPosition('Project Manager','Cynthia Capobianco',true));
		jaList.add(Utilitycls.createJA('John0','Consultant',true));
		jaList.add(Utilitycls.createJA('John0','Project Manager',true));
        

		test.startTest();
		System.debug('1'+canList.get(0));
		System.debug('2'+posList.get(0));
		System.debug('3'+jaList.get(0));

        CandidateController testobj = new CandidateController();
		testobj.fetchData();
        Integer i = 0;
        System.debug('size of candwrap'+testobj.mapCandWrapper.get('Jaipur').size());
		for(CandidateController.CandidateWrapper testWrap : testobj.mapCandWrapper.get('Jaipur')){	
            System.assertEquals(canList.get(i).First_Name__c,testWrap.candidateName);
			System.assertEquals(posList.get(i).Hiring_Manager__r.FirstName,testWrap.hiringManagerName);
//			System.assertEquals(jaList.get(i++).Name,testWrap.jobAppName);
            System.debug(canList.get(i).First_Name__c+testWrap.candidateName);
			System.debug(posList.get(i).Hiring_Manager__r.FirstName+testWrap.hiringManagerName);
			System.debug(jaList.get(i++).Name+testWrap.jobAppName);
		}
		test.stopTest();
	}
}