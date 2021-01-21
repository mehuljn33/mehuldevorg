public class TestUtils {
    
    public static List<Opportunity> createOpportunity(String opptyname, Integer count){
        List<Opportunity> oppList = new List<Opportunity> ();
        Opportunity opp;
        for(Integer i=0; i<count; i++){
          opp = new Opportunity(name = opptyname + 'i', stagename = 'Prospecting', Closedate = system.today() + 7) ; 
          oppList.add(opp);
        }
      
        return oppList;
    }


    public static List<Position__c> createPosition(String posname, Integer count){
        List<Position__c> posList = new List<Position__c> ();
        Position__c pos;
        for(Integer i=0; i<count; i++){
          pos = new Position__c(name = posname + 'i') ; 
          posList.add(pos);
        }
      
        return posList;
    }
}