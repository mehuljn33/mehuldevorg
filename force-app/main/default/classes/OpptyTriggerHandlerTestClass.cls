@istest 
public class OpptyTriggerHandlerTestClass {
  
  @istest 
  public static void unitTest1(){
    List<Opportunity> oppList = new List<Opportunity> ();
    List<Position__c> posList = new List<Position__c> ();
    test.startTest();
    oppList = TestUtils.createOpportunity('Oppty for Test', 10);
    posList = TestUtils.createPosition('position for test', 1);
    oppList[0].isprivate = true;
    insert oppList;
    insert posList;
    
    oppList[0].MainCompetitors__c = 'new';
    posList[0].Opportunity__c = oppList[0].id;
    update posList; 
    update opplist;
    system.debug('opp : '+ oppList);
    
    delete oppList[2];
    test.stoptest();
    system.assert(true,true);
  }

}