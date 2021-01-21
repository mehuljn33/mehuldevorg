public class AnimalLocatorMock implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"name": "hs"}');
            response.setStatusCode(200);
            return response; 
        }
    }