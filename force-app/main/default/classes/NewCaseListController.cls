public class NewCaseListController {
    
    public List<Case> newCases{get;set;}
    public List<Case> getNewCases(){
        
        newCases = [SELECT id,CaseNumber FROM Case
                    WHERE status = 'New'];
        
        return newCases;
    }

}