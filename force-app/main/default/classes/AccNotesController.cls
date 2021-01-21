public class AccNotesController{

public String id{get;set;}
public User myUser{get;set;}
public List<SelectOption> accList {get;set;}
public List<SelectOption> accNotesList {get;set;}
public String accId {get;set;}
public Boolean showNotes {get;set;}

public AccNotesController(){
    myUser = new User();
    id= ApexPages.currentPage().getParameters().get('id');
        System.debug('test commit debug for 21 jan v1');
        if(id == null){
        myUser.id = userinfo.getuserId();
        myUser.Email = userinfo.getUserEmail();
        }
        else{
        myUser=[Select Name, Email, Alias  
                from User 
                where Id=: id];
        }
        accList = new List<SelectOption>();
        accId='';       
        System.debug('test');
    }


    public void showAccPickList(){
        for(Account acc : [SELECT Name,AccountNumber,Phone
                           FROM Account
                           WHERE User__r.Id=: id]){
        accList.add(new SelectOption(acc.Id,acc.Name));
        }
    }       

    public void showNotesPickList(){
        showNotes = true;
        for(AccountNotes__c accNotes : [SELECT Notes__r.Title__c 
                           FROM AccountNotes__c 
                           WHERE Account__r.Id = :accId]){
        accNotesList.add(new SelectOption(accNotes.Id,accNotes.Notes__r.Title__c));
        }
    } 
    
    public static void fetchAccounts() {
        List<Account> acc = new List<Account>();
        system.RunAs(new User(Id='00528000001kSyT')) {
            acc = Experiment.returnAccounts();
        }
        
        system.debug('@@acc' + acc);
    }      

}