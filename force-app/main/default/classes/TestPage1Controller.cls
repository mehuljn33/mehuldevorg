public class TestPage1Controller {
  public List<SelectOption> myList {get;set;}
  public String selection {get;set;}
  public List<account> records {get;set;}
  public integer total {get;set;}
  public integer quantity {get;set;}
    public list<contact> contacts {get;set;}
    public string contid {get;set;}
    public string selected {get;set;}
    public string[] selectedIds {get;set;}
    public Map<id, integer> mapAccLocation ; 
    public Id recid {get;set;}
    public Integer location {get;set;}
    
    
  public TestPage1Controller(ApexPages.standardController stdController){
   mapAccLocation = new  Map<id, integer>();  
   selectedIds = new list<string>();   
   quantity = 0;
   records = [select id, name, SLASerialNumber__c, NumberofLocations__c, Total_of_locations__c
              from account 
              where Candidate__c != null];
   contacts = [select id, name, account.name
               from contact
               where accountid = :stdController.getid()];
      contid='jhjhnkjnk';
    selection = 'a';
    myList = new List<SelectOption> ();
    myList.add(new SelectOption('a','a'));
    myList.add(new SelectOption('b','b'));
    myList.add(new SelectOption('c','c'));
    myList.add(new SelectOption('d','d'));
  }
  
    public pageReference calculate(){
        system.debug('in calculate of apex' + quantity);
         
        total = quantity*10;
        return null;
    }
    
    public void  mydel(){
        system.debug('id='+contid);
       selection = 'new'+contid;
    }
    
    public void addToselectedlist(){
        selectedIds.add(selected);
        system.debug('selected list-'+selectedIds);
        system.debug('parameter:'+ApexPages.currentPage().getParameters().get('iop'));
    }
    
    public void updateLocations(){
      mapAccLocation.put(recid, location);
      system.debug('map of acc id to location'+mapAccLocation);
    }
    
}