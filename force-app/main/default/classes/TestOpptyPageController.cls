public class TestOpptyPageController {
    public Opportunity oppty ; 
    public static String rTName {get;set;}
    public TestOpptyPageController(ApexPages.StandardController stdController){
        this.oppty = (Opportunity)stdController.getRecord();
        setRTName(); 
    }
    
    public static void setRTName(){
        Id rtId;  
        rtId = apexpages.currentPage().getparameters().get('RecordType');
		rTName = Opportunity.SObjectType.getDescribe().getRecordTypeInfosById().get(rtId).getName();
    }
}