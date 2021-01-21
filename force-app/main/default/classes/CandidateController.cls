public class CandidateController {

	CandidateWrapper obj;
	List<CandidateWrapper> wrapObj = new List<CandidateWrapper>();
	public Map<String, List<CandidateWrapper>> mapCandWrapper = new Map<String, List<CandidateWrapper>>();
	List<SelectOption> listCity = new List<SelectOption>();

	public CandidateController() {
			
	}

	public class CandidateWrapper {
		public String candidateName;
		public String jobAppName;
		public String hiringManagerName;

		public CandidateWrapper() {
			candidateName = '';
			jobAppName = '';
			hiringManagerName = '';
		}
	}

	public void fetchData() {
				
		for(Candidate__c can : [SELECT First_Name__c, City__c,
									(SELECT Name, Position__r.Hiring_Manager__r.FirstName FROM Job_Applications__r) 
									FROM Candidate__c]) {
			for(Job_Application__c ja : can.Job_Applications__r) {
				obj = new CandidateWrapper();
				obj.candidateName = can.First_Name__c;
				obj.jobAppName = ja.Name;
				obj.hiringManagerName = ja.Position__r.Hiring_Manager__r.FirstName;
				wrapObj.add(obj);
				System.debug('created obj'+ obj);
			}

			if(!mapCandWrapper.containsKey(can.City__c)) {
				mapCandWrapper.put(can.City__c, new List<CandidateWrapper>());
				listCity.add(new SelectOption(can.City__c, can.City__c));
			}
						
			mapCandWrapper.get(can.City__c).addAll(wrapObj);	

		}


	}
}