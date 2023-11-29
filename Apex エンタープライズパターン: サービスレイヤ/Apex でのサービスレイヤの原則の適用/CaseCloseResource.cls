@RestResource(URLMapping = '/case/*/close')
global with sharing class CaseCloseResource {
    @HttpPost
    global static void closeCase(String closureReason) {
        //Parse request
        RestRequest req = RestContext.request;
        String[] idsList = req.requestURI.split('/');
        ID caseIDs = idsList[2];
        //Call the service
        CaseService.closeCases(new Set<ID> {caseIDs}, closureReason);
    }
}