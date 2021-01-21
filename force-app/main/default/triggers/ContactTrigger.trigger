trigger ContactTrigger on Contact (before insert,before update,after insert,after update) {
   
        
    if(Trigger.isBefore && Trigger.isInsert) {
        system.debug('@@@@@BI');
        system.debug('trigger.new' + trigger.new);
        system.debug('trigger.old' + trigger.old);
        
        trigger.new[0].FirstName = 'newbefore';
        
     } 
     
     if(Trigger.isBefore && Trigger.isUpdate) {
     system.debug('@@@@@BU');
        system.debug('trigger.new' + trigger.new);
        system.debug('trigger.old' + trigger.old);
        trigger.new[0].FirstName = 'newbeforeupd';
       
     }  
     
     if(Trigger.isAfter && Trigger.isInsert) {
     system.debug('@@@@@AI');
        system.debug('trigger.new' + trigger.new);
        system.debug('trigger.old' + trigger.old);
        list<contact> lst = new list<contact>();
        for (contact con : trigger.new) {
            contact cont = new contact(id = con.id);
            cont.firstname = 'newafter';
            lst.add(cont);
        }
        update lst;
        
     }  
     
     if(Trigger.isAfter && Trigger.isUpdate) {
     system.debug('@@@@@AU');
        system.debug('trigger.new' + trigger.new);
        system.debug('trigger.old' + trigger.old);
        list<contact> lst = new list<contact>();
        for (contact con : trigger.new) {
            contact cont = new contact(id = con.id);
            if (con.firstname != trigger.oldmap.get(con.id).firstname) {
            cont.firstname = 'newafter';
            lst.add(cont);
            }
        }
        if ( !lst.isEmpty() )
        update lst;
        
     }   
}