public class AddPrimaryContact implements Queueable {
    
    private Contact accounts;
    private string  state;
    
    public AddPrimaryContact(Contact records, String stateAbbr) {
        this.accounts = records;
        this.state = stateAbbr;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [select id, (select id, name from contacts) from Account where billingstate = :state LIMIT 200];
        List<Contact> lstContacts = new List<Contact>();
        Contact acc;
        for (Account account : accounts) {
            for (Contact con : account.contacts)  {  
                acc = con.clone(false, false, false, false); 
                lstContacts.add(acc);
                // perform other processing or callout
            }
        }
        insert lstContacts;
    }
    
}