public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {
        //constructor
    }
    
    //Whenever an Opportunity is marked as Closed Won, automatically create a Task for the Opportunity Owner with:
    //Subject: Split Revenue Among Team
    //Priority: High

    private static Boolean hasRun = false;

    public static void createTaskOnClosedWon(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        if (hasRun) return;
        hasRun = true;
        List<Task> taskList = new List<Task>();
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                taskList.add(new Task(
                    WhatId = opp.Id,
                    OwnerId = opp.OwnerId,
                    Subject = 'Split Revenue Among Team',
                    Priority = 'High',
                    Status = 'Not Started'
                ));
            }
        }
        if (!taskList.isEmpty()) {
            insert taskList;
        }
    }
}