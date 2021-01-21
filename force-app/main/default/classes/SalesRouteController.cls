public with sharing class SalesRouteController {
    @AuraEnabled(cacheable=true)
    public static List<Event> getEventList(Date dtSelected) {

        List<Event> lstEvent = [Select Id, Subject, OwnerId, StartDateTime, EndDateTime,
                                Street__c, City__c, Country__c 
                                from Event 
                                where OwnerId = '00528000001XHym'
                                and DAY_ONLY(StartDateTime) =: dtSelected
                                ];
                              
        return lstEvent ;                       
    }

    @AuraEnabled(cacheable=true)
    public static String getMarkers(List<Event> lstEvent){
        system.debug('@@lstEvent' + lstEvent);
        List<MarkerWrapper> lstMarkWrapper = new List<MarkerWrapper>();
        MarkerWrapper objMarkWrap;
        MarkerLocation objMarkLoc;
        for(Event objEvent : lstEvent){
            objMarkWrap = new MarkerWrapper();
            objMarkWrap.icon = 'custom:custom26';
            objMarkWrap.title = objEvent.Subject;
            
            objMarkLoc = new MarkerLocation();
            objMarkLoc.Street = objEvent.Street__c;
            objMarkLoc.City = objEvent.City__c;
            objMarkLoc.Country = objEvent.Country__c;

            objMarkWrap.location = objMarkLoc;
            
            lstMarkWrapper.add(objMarkWrap);
        }
        system.debug('@@lstMarkWrapper' + lstMarkWrapper);
        //Added comment
        return JSON.serialize(lstMarkWrapper);
        //return lstMarkWrapper;
    }

    @AuraEnabled(cacheable=true)
    public static String getAccountName(String strSLA){
        List<Account> lstAcc = [Select Id, Name from Account where SLA__c =:strSLA Limit 1];
        system.debug('@lstAcc' + lstAcc);
        if(!lstAcc.isEmpty())
            return lstAcc[0].Name;    
        else 
            return null;
    }

    public class MarkerWrapper{
        public MarkerLocation location;
        public String icon;
        public String title;
    }

    public class MarkerLocation{
        public String Street;
        public String City;
        public String Country;
    }
}