/**
 * Created by mjain on 24-Feb-20.
 */

public class CaseService {
    public static void closeCases(Set<Id> setIds, String strCloseReason) {
        List<Case> lstCase =  [SELECT Id, Reason
                                FROM Case
                                WHERE Id IN: setIds
                              ];

        for(Case objCase : lstCase){
            objCase.Reason = strCloseReason;
            objCase.Status = 'Closed';
        }

        update lstCase;
    }
}