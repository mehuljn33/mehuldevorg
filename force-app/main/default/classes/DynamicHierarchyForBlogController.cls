public with sharing class DynamicHierarchyForBlogController 
{
 public String objectApiName {get;set;}
 public String fieldApiName {get;set;}
 public String nameField {get;set;}
 public String currentsObjectId {get;set;}
 public String topParentId {get;set;}
 public String jsonMapsObjectString {get;set;}
 private String jsonString;
 private Map<String, Set<String>> sObjectIdMap ;
 private Map<String, sObject> selectedsObjectMap ;
 private Map<String, sObject> allsObjectMap;

 public DynamicHierarchyForBlogController() 
 {

  
  currentsObjectId = Apexpages.currentPage().getParameters().get('id');
     sObjectIdMap = new Map<String, Set<string>>();
  selectedsObjectMap = new Map<String, sObject>();
  allsObjectMap = new Map<String, sObject>();
 }
 
 public String getjsonMapString()
 {
  retrieveInfo();
  return jsonString;
 }
 
 public void retrieveInfo()
 {
  String dynamicQuery = 'SELECT ID ,' + fieldApiName + ' , ' + nameField + ' FROM ' + objectApiName + ' ORDER BY ' + fieldApiName + '  LIMIT 50';
  system.debug(dynamicQuery);
  for(sObject obj: Database.query(dynamicQuery))
  {
   allsObjectMap.put(obj.id,obj);
  }

  if(currentsObjectId != null)
  {
   String dQuery = 'SELECT ID, '+ fieldApiName +' FROM ' + objectApiName + ' WHERE id =\'' + currentsObjectId +'\'';
   List<sObject> objList = Database.query(dQuery);
   currentsObjectId = objList[0].Id;
   system.debug('currentsObjectId' + currentsObjectId);
   retrieveTopParent(currentsObjectId);
   system.debug('topParentId' + topParentId);
   retrieveAllChildRecords(new Set<String>{topParentId});
   system.debug('sObjectIdMap' + sObjectIdMap );
   for(String str : sObjectIdMap.keySet())
   {
    selectedsObjectMap.put(str,allsObjectMap.get(str));
   }
   jsonString = JSON.serialize(sObjectIdMap);
   jsonMapsObjectString = JSON.serialize(selectedsObjectMap);
  }
 }

 public void retrieveTopParent(String sObjectId)
 {
  system.debug('sObjectId' + sObjectId);
  system.debug('allsObjectMap' + allsObjectMap);
  system.debug('fieldApiName' + fieldApiName);
  system.debug('allsObjectMap.keySet().contains(sObjectId)' + allsObjectMap.keySet().contains(sObjectId));
  if(allsObjectMap.keySet().contains(sObjectId) && allsObjectMap.get(sObjectId).get(fieldApiName) != null)
  {
   topParentId = String.valueOf(allsObjectMap.get(sObjectId).get(fieldApiName));
   retrieveTopParent(topParentId);
  }
 }

 public void retrieveAllChildRecords(Set<String> sObjectIdSet)
 {
  if(sObjectIdSet.size() > 0)
  { 
   Set<String> allChildsIdSet = new Set<String>();
   for(String str : sObjectIdSet)
   {
    Set<String> childsObjectIdSet = new Set<String>();
    for(sObject obj : allsObjectMap.values())
    {
     if(obj.get(fieldApiName) != null && String.valueOf(obj.get(fieldApiName)) == str)
     {
      childsObjectIdSet.add(obj.Id);
      allChildsIdSet.add(obj.Id);
     }
    }
    sObjectIdMap.put(str,childsObjectIdSet);
   }
   retrieveAllChildRecords(allChildsIdSet);
  }
 }
}