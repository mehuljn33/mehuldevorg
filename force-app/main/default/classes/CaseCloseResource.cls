@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
    @HttpPost
    global static void closeCase(String strReason) {
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id opportunityId = uriParts[2];
        // Call the service
        CaseService.closeCases(new Set<ID> { opportunityId }, strReason);
    }
}