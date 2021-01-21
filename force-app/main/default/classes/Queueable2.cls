public class Queueable2 implements Queueable,Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        // Your processing logic here 
        Http http = new Http();  
        String requestBody = '{"name":"test","salary":"123","age":"23"}';      
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://dummy.restapiexample.com/api/v1/create');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(requestBody);
        
        HttpResponse response = http.send(req);
        system.debug('@@response for Q2' +response.getBody()  );
        CFS_Error_Log__c obj = new CFS_Error_Log__c();
        obj.Request__c = 'test2';
        obj.Response__c = 'test2';
        insert obj;
        
    }
}