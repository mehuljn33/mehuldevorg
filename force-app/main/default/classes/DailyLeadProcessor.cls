global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        List<Lead> ld = [SELECT Id, LeadSource 
            FROM Lead 
            WHERE LeadSource = '' 
            LIMIT 200
            ];
      
        for(Lead l : ld) {
          l.LeadSource = 'Dreamforce' ; 
        }
    }
    
}