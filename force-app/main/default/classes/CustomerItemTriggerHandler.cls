/*
@Author : Mehul Jain
@Date : 18/11/2109
@Description : Trigger handler for Customer Item Trigger.
*/

public class CustomerItemTriggerHandler{
    
    //Method to handle after insert operations
    public static void afterInsert(List<CMS_Customer_Item__c> newList) {
        
        try { 
            //Map to Hold List of Item names per customerid
            Map<Id, List<String> > mapCustIdToItems = new Map<Id, List<String> >();
            //Map to Hold Sum of Purchase amount per customer
            Map<Id, Integer> mapcustIdToAmount = new Map<Id, Integer>();
            List<String> lstItemNames = new List<String>();
            Integer intAmount = 0;
            
            for (CMS_Customer_Item__c objCI : newList) {
                system.debug('@@objCI' + objCI);
                //Populate Map1
                if ( mapCustIdToItems.containsKey(objCI.CSF_Customer__c) ) {
                    lstItemNames = mapCustIdToItems.get(objCI.CSF_Customer__c);
                    lstItemNames.add(objCI.Item_Name__c);
                    mapCustIdToItems.put(objCI.CSF_Customer__c,lstItemNames);
                } else {
                    lstItemNames = new List<String>();
                    lstItemNames.add(objCI.Item_Name__c);
                    mapCustIdToItems.put(objCI.CSF_Customer__c,lstItemNames);
                    
                }
                
                //Populate Map2
                if ( mapcustIdToAmount.containsKey(objCI.CSF_Customer__c) ) {
                    intAmount = mapcustIdToAmount.get(objCI.CSF_Customer__c);
                    intAmount += Integer.valueOf(objCI.Borrowed_Price__c);
                    mapcustIdToAmount.put(objCI.CSF_Customer__c,intAmount);
                } else {
                    lstItemNames.add(objCI.Item_Name__c);
                    mapcustIdToAmount.put(objCI.CSF_Customer__c,Integer.valueOf(objCI.Borrowed_Price__c));
                }
            }
            
            system.debug('@mapcustIdToAmount' + mapcustIdToAmount);
            system.debug('@mapCustIdToItems' + mapCustIdToItems);
            
            //Sending sms to the respective customers
            for (Id objCustId : mapcustIdToAmount.keyset()) {
                //sending Customerid, Item names list, total purchase amount
                sendSMS (objCustId,mapCustIdToItems.get(objCustId),mapcustIdToAmount.get(objCustId));
            }
            
        } catch (Exception e) {
            ItemSearchController.createErrorLogs('CustomerItemTriggerHandler', 'afterInsert', e.getMessage() + ' : ' + e.getStackTraceString());
        }
        
    }
    
    //Method to perform SMS integration callout
    @future(callout=true)
    public static void sendSMS (Id idCustomer, List<String> lstItems, Integer intAmount) {
        try {
            Set<string> setItemNames = new Set<String>();
            String strItemNames = '';
            CFS_Customer__c objCust = new CFS_Customer__c();
            String strMessage ;
            String strMobile ;
            String strURL ;
            
            List<CFS_Customer__c> lstCustomer = [Select Id, Name, Email__c, Mobile__c from CFS_Customer__c where Id=: idCustomer];
            
            if (! lstCustomer.isEmpty() ) {
                objCust = lstCustomer[0];
            }
            
            //Creating Line spaced string from the list of strings
            for( String str : lstItems){
                if ( !setItemNames.contains(str) ) {
                    strItemNames += '\n' + str;
                }
                setItemNames.add(str);
            }
            
            strMessage = 'Hi '+objCust.Name+', You have succesfully borrowed the following items :'+strItemNames+'\n at a total cost of INR '+intAmount+' from ConForceSo library. Details sent on '+objCust.Email__c +'.';
            system.debug('@@strMessage' + strMessage);
            
            //Removal of all special characters from the mobile number
            strMobile = objCust.Mobile__c.replaceAll('\\D','');
    
            strMessage = EncodingUtil.URLENCODE(strMessage,'UTF-8');
            strURL = 'https://www.smsgatewayhub.com/api/mt/SendSMS?APIKey=RKOAlR5U0E2F3j6wkd6yCA&senderid=SMSTST&channel=2&DCS=0&flashsms=0&number='+strMobile+'&text='+strMessage+'&route=1';
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(strURL);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            if (response != null) {
                createIntegrationLogs('CustomerItemTriggerHandler', 'sendSMS', strURL, response.getBody());
            } else {
                createIntegrationLogs('CustomerItemTriggerHandler', 'sendSMS', strURL, 'Response is null');
            }
            
        } catch (Exception e) {
            ItemSearchController.createErrorLogs('CustomerItemTriggerHandler', 'sendSMS', e.getMessage() + ' : ' + e.getStackTraceString());
        }
        
    }
    
    public static void createIntegrationLogs( String strClassName, String strMethodName, String strRequest, String strResponse) {
        CFS_Error_Log__c objError = new CFS_Error_Log__c();
        objError.Class_Name__c = strClassName;
        objError.Method_Name__c = strMethodName;
        objError.Request__c = strRequest;
        objError.Request__c = strResponse;
        objError.Type__c = 'Integration Exception';
        
        Database.insert(objError);
        
    }
}