public with sharing class CaseTriggerHandler {
    public CaseTriggerHandler() {
        //constructor
    }

    //if case origin is phone then set a priority should be high.
    public static void updateCasePriorityDependonOrigin(List<Case> caseList) {
        for(Case cse : caseList) {
            if(cse.Origin == 'Phone') {
                cse.Priority = 'High';
            }
        }
    }

    //Whenever a user attempts to delete a Case record, check:
    //If the user deleting the Case is not a System Administrator,
    //Prevent the deletion by throwing an “Insufficient Privilege” error message

    public static void preventCaseDeletion(List<Case> caseList) {
        Id currentUserId = UserInfo.getUserId();
        Id SystemAdministratorId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        for(Case cse : caseList) {
            if(currentUserId != SystemAdministratorId) {
                cse.addError('Insufficient Privilege');
            }
        }
    }
}