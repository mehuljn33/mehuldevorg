/*
@Author : Mehul Jain
@Date : 17/11/2109
@Description : Server side controller for the Item search component.
*/

public class ItemSearchController {
     
    //Return the result list of items using filters on search area
    @AuraEnabled
    Public static List<CFS_Item__c> getItemList( String strKeyword, String strType, String strCategory ){
        List<CFS_Item__c> lstItem ;
        try {
            //Create matcher string
            String strSearch = '%' + strKeyWord + '%';
            //Book and AV Record type developer names
            String strBookRT = 'CFS_Book';
            String strAVRT = 'CFS_AVEquipment';
            String strQuery = 'SELECT Id, Name, CurrencyIsoCode, RecordTypeId, CFS_Category__c, CFS_Is_Active__c,' + 
                               'CFS_Inventory_Count__c, CFS_Purchase_Price__c, Discount_Category__c, Total_Revenue__c,'+ 
                               'Currently_Borrowed__c, Units_Available__c, Book_name__c, Book_Author__c, Book_Publication__c,'+ 
                               'Video_Name__c, Video_Publication__c, Video_Director__c '+ 
                               'FROM CFS_Item__c';
                               
            //building dynamic query based on Category and Item type chosen
            if (strType == 'Books') {
                strQuery += ' where recordtype.developername = :strBookRT';
                if ( strKeyword != null ) {
                    strQuery += ' and (Book_name__c like :strSearch OR Book_Author__c like :strSearch OR Book_Publication__c like :strSearch) ';
                }
                
            } else {
                strQuery += ' where recordtype.developername = :strAVRT';
                if ( strKeyword != null ) {
                    strQuery += ' and (Video_Name__c like :strSearch OR Video_Publication__c like :strSearch OR Video_Director__c like :strSearch) ';
                }
            }
            //Adding category to the where clause
            if ( strCategory != '') {
                    strQuery += ' and CFS_Category__c = :strCategory';
            }
            system.debug('@@strQuery' + strQuery);
            
            //Fetch list of items by making DML
            lstItem = Database.Query(strQuery); 
            
        } catch (Exception e) {
            createErrorLogs('ItemSearchController', 'getItemList', e.getMessage() + ' : ' + e.getStackTraceString());
        }
        return lstItem;
    }
    
    //Create Customer Item junction records and transfer to client side controller
    @AuraEnabled
    public static List<CMS_Customer_Item__c> createCI(string lstids, Id customerId) {
        List<CMS_Customer_Item__c> lstCustItem = new List<CMS_Customer_Item__c>();
        try {
            List<string> lstItemIds = (List<string>) JSON.deserialize(lstids, List<string>.class);
            List<CFS_Item__c> lstCI = new List<CFS_Item__c>();
            Map<String, Integer> mapRTToLimit = new Map<String, Integer>();
            CMS_Customer_Item__c objCustItem ; 
            
            //Fetch the customer details
            List<CFS_Customer__c> lstCFS = [Select Id, Email__c from CFS_Customer__c where Id =: customerId];
            //Fetch list based on Item sfdcid or Item Name for rapid checkout
            lstCI = [Select Id,Name,Currently_Borrowed__c,CFS_Purchase_Price__c,Book_name__c,Video_Name__c,Discount_Category__c,Units_Available__c,RecordType.Developername
                     from CFS_Item__c 
                     where Id IN: lstItemIds OR Name IN: lstItemIds];
                     
                                                          
            List<Item_wise_Matrix__mdt> lstItemMatrix = [Select MasterLabel,Borrowing_rate_per_Day__c,Concurrent_Borrowing_limit__c
                                                         from Item_wise_Matrix__mdt]; 
            //Creating map of Item based matrix
            for ( Item_wise_Matrix__mdt objMatrix : lstItemMatrix ) {
                mapRTToLimit.put(objMatrix.MasterLabel,Integer.valueOf(objMatrix.Borrowing_rate_per_Day__c));
            }          
            //Map the customer item fields from Parent Item field        
            for ( CFS_Item__c objCI : lstCI ) {
                objCustItem = new CMS_Customer_Item__c();
                objCustItem.End_Date__c = system.today().addDays(30);
                objCustItem.Start_Date__c = system.today();
                objCustItem.CSF_Customer__c = customerId;
                objCustItem.CSF_Item__c = objCI.Id;
                //Borrowed price kept at 2 per day for AV and 1 per day for Books
                objCustItem.Borrowed_Price__c = mapRTToLimit.get(objCI.RecordType.Developername)*30 ;
                objCustItem.Item_s_Purchase_Price__c = objCI.CFS_Purchase_Price__c;
                objCustItem.Item_type__c= objCI.RecordType.Developername.containsIgnoreCase('BOOK') ? 'Book' : 'AV' ;
                objCustItem.Item_Name__c = objCI.RecordType.Developername.containsIgnoreCase('BOOK') ? objCI.Book_name__c  : objCI.Video_Name__c; 
                objCustItem.Customer_Email__c = lstCFS[0].Email__c;
                objCustItem.Item_Code__c = objCI.Name;
                lstCustItem.add(objCustItem);
            }    
               
        } catch (Exception e) {
            createErrorLogs('ItemSearchController', 'createCI', e.getMessage() + ' : ' + e.getStackTraceString());
        }   
        
        return lstCustItem;   
    }
    
    //Insert the final customer Item records into Salesforce Database
    @AuraEnabled
    public static String insertCI (String lstCI) {
        List<CMS_Customer_Item__c > lstToInsert = new List<CMS_Customer_Item__c>();
        system.debug('@@lstToInsert' + lstToInsert);
        try {
            lstToInsert= (List<CMS_Customer_Item__c >) JSON.deserialize(lstCI, List<CMS_Customer_Item__c >.class);
            insert lstToInsert;
        }catch (Exception e) {
            createErrorLogs('ItemSearchController', 'insertCI', e.getMessage() + ' : ' + e.getStackTraceString());
        }
        return 'Success';
    }
    
    //Calculate the total late fee for current customer
    @AuraEnabled
    public static Integer calculateLateFee(String customerId) {
        Decimal intTotalLateFee = 0;
        try {
            //Fetch total late fee for the customer using aggregate query
            List<AggregateResult> lstLateFee = [Select CSF_Customer__c,SUM(Late_Fees__c) From CMS_Customer_Item__c 
                                                        Where CSF_Customer__c = :customerId
                                                        Group by CSF_Customer__c];
            
            if ( !lstLateFee.isEmpty() ) {
                intTotalLateFee  = (Decimal)lstLateFee[0].get('expr0');
                system.debug('@@intTotalLateFee' + intTotalLateFee);
            }   
        } catch (Exception e) {
            createErrorLogs('ItemSearchController', 'calculateLateFee', e.getMessage() + ' : ' + e.getStackTraceString());
        }
        
        return Integer.valueOf(intTotalLateFee) ;                                       
                                                    
    }
    
    //Validate if the items are currently borrowed by the user or checked out by him
    @AuraEnabled
    public static String verifyItems(String customerId, String strCIList) {
        String strInvalidItems = '';
        try {
            Integer intCurrentBorrowed ;
            Integer intMaxAllowed = Integer.valueOf(Label.Max_Number_of_Items_per_user);
            List<CMS_Customer_Item__c > lstCI = (List<CMS_Customer_Item__c >) JSON.deserialize(strCIList, List<CMS_Customer_Item__c >.class);
            //Fetch list of all checked out or currently borrowed items by the current user
            List<CMS_Customer_Item__c> lstExistingItem = [Select Id, CSF_Item__c ,Status__c,
                                                          CSF_Customer__r.Currently_Borrowed_Items__c,
                                                          CSF_Item__r.Currently_Borrowed__c,
                                                          CSF_Item__r.RecordType.DeveloperName
                                                          from CMS_Customer_Item__c 
                                                          where CSF_Customer__c =: customerId and 
                                                          (Status__c = 'Check out' OR Status__c = 'Borrow')];
                                                                                              
            Set<String> setCheckedOutItems = new Set<String>();
            if ( !lstExistingItem.isEmpty()) {
                intCurrentBorrowed = (Integer)lstExistingItem[0].CSF_Customer__r.Currently_Borrowed_Items__c;
                //Set of existing item ids
                for (CMS_Customer_Item__c objCI : lstExistingItem ) {
                    setCheckedOutItems.add(objCI.CSF_Item__c);
                }           
                
                for (CMS_Customer_Item__c objCI : lstCI) {
                    //Checking if the shopping cart contains any of the existing item ids
                    if (setCheckedOutItems.contains(objCI.CSF_Item__c)){
                        strInvalidItems += objCI.Item_Name__c + ', ';
                    }
                    
                } 
                //Removing last occurence of comma                                   
                strInvalidItems = strInvalidItems.substringBeforeLast(',');
                
            
                if ( strInvalidItems != '' ) {
                    return 'Please remove the following items since you already have checked them out or currently borrowed : '+strInvalidItems;
                } else if ( lstCI.size() + intCurrentBorrowed  > intMaxAllowed  ) {
                    Integer intRowsToRemove = lstCI.size() + intCurrentBorrowed  - intMaxAllowed ;
                    return 'Please remove at least '+intRowsToRemove+' rows to proceed since you already have '+intCurrentBorrowed +' items currently brrowed. Maximum borrow limit per person is '+intMaxAllowed +'.';
                } else {
                    return '';
                }
            } 
        
        } catch (Exception e) {
            createErrorLogs('ItemSearchController', 'verifyItems', e.getMessage() + ' : ' + e.getStackTraceString());
        } 
        return '';   
        
    }
    
    @AuraEnabled
    public static Map<String, String> fetchCategories(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = CFS_Item__c.CFS_Category__c.getDescribe();
        List<Schema.PicklistEntry> objPL = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry p:objPL){
        	options.put(p.getValue(), p.getLabel());
        } 
        return options;
    } 
    
    public static void createErrorLogs(String strClassName, String strMethodName, String strErrorMessage) {
        CFS_Error_Log__c objError = new CFS_Error_Log__c();
        objError.Class_Name__c = strClassName;
        objError.Method_Name__c = strMethodName;
        objError.Error_Message__c = strErrorMessage;
        objError.Type__c = 'Code Exception';
        
        Database.insert(objError);
        
    }
}