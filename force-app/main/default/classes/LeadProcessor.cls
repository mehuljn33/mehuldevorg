global class LeadProcessor implements 
    Database.Batchable<sObject> {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> lstLead = new List<Lead>();
        for (Lead ld : scope) {
            ld.LeadSource = 'Dreamforce';
            lstLead.add(ld);
        }
        update lstLead;
    }    

    global void finish(Database.BatchableContext bc){
    }    

}