public with sharing class CaseService {
    public static void closeCases(Set<ID> caseIds, string reason) {
        List<Case> caseList = [SELECT Id, Status, Reason FROM Case WHERE Id IN :caseIds];
        for ( Case caseRecord : caseList) {
            caseRecord.Status = 'Closed';
            caseRecord.Reason = reason;
        }
        update caseList;
    }
}