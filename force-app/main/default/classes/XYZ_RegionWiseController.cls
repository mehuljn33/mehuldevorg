public class XYZ_RegionWiseController {
    public List<Contact> lstContact {get;set;}
    public List<Contact> lstTopReps {get;set;}
    public Contact objContact {get;set;}
    public Integer TOP_REP_SIZE {get;set;} 
    public String CURRENT_FY {get;set;}
    public XYZ_RegionWiseController() {
        objContact = new Contact();
        lstContact = new List<Contact>();
        lstTopReps = new List<Contact>();
        //Constant variables
        TOP_REP_SIZE = 3;
        CURRENT_FY = '2017-2018';
    }
    
    // Load Contact list based on Region selection
    public pagereference loadSalesRep(){
        
        lstContact = [Select Id, Name, Email, Phone, XYZ_Total_Deals__c,(Select Id, Name, Amount from Opportunities__r) 
                      FROM Contact 
                      where XYZ_FinancialYear__c =:CURRENT_FY AND XYZ_Region__c=:objContact.XYZ_Region__c
                      ORDER BY XYZ_Total_Deals__c Desc];
                      
        system.debug('@@lstContact' + lstContact);
        lstTopReps.clear();
        if ( lstContact.size() >= TOP_REP_SIZE ) {
            for (Integer i=0; i < TOP_REP_SIZE ; i++) {
                lstTopReps.add(lstContact[i]);
            }                                            
        } else {
            lstTopReps.addAll(lstContact);
        }
        return null;
    }
       
    
}