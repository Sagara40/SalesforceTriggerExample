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
}