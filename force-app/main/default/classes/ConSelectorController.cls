public with sharing class ConSelectorController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(String strSearchKey){
        List<String> lstErrorString ; 
        lstErrorString.add('test');
        strSearchKey = '%' + strSearchKey + '%';
        List<Account> lstAcc = [Select Id,Name,Phone from Account where Name like : strSearchKey];
        if ( lstAcc != null ){
            return lstAcc;
        } else {
            return null;
        }
    }

    @AuraEnabled
    public static String updateSelectedCon(Account objContact){
        system.debug('@@@objContact' + objContact);
        update objContact;
        return 'Success';
    }

    @AuraEnabled(cacheable=true)
    public static Account returnAccount(Account objAcc){
        return objAcc;
    }
}