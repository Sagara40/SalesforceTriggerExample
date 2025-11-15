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
    //Whenever an Opportunity Stage is modified, automatically update the Opportunity Amount field based on the calculation:
    //Amount = Probability x Expected Revenue
    public static void updateAmountBasedOnProbabilityAndExpectedRevenue(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (opp.StageName != oldOpp.StageName) {
                opp.Amount = opp.Probability * opp.ExpectedRevenue;
            }
        }
    }

    //Whenever an Opportunity record is deleted, automatically:
    //Create a Task for the Opportunity’s related Account Owner
    //The task should instruct them to investigate why the Opportunity was deleted and submit the information

    public static void createTaskOnOpportunityDeletion(List<Opportunity> oldList) {
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Id> accountToOwnerIdMap = new Map<Id,Id>();
        for (Opportunity opp : oldList) {
            if(opp.AccountId != null) {
             accountIds.add(opp.AccountId);
            }           
        }
        List<Task> taskList = new List<Task>();
        for (Account acc : [SELECT Id, OwnerId FROM Account WHERE Id IN :accountIds]) {
            accountToOwnerIdMap.put(acc.Id,acc.OwnerId);
        }
        for(Id ids:accountIds){
            taskList.add(new Task(
                WhatId = ids,
                OwnerId = accountToOwnerIdMap.get(ids),
                Subject = 'Investigate Opportunity Deletion',
                Priority = 'High',
                Status = 'Not Started'
            ));
        }
        if (!taskList.isEmpty()) {  
            insert taskList;
        }
    }

    //Whenever an Opportunity’s Stage is updated to Closed Lost, automatically:
    //Remove all Opportunity Team Members associated with that Opportunity
    public static void removeOpportunityTeamMembersOnClosedLost(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        Set<Id> opportunityIds = new Set<Id>();
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (opp.StageName == 'Closed Lost' && oldOpp.StageName != 'Closed Lost') {
                opportunityIds.add(opp.Id);
            }

        }
        List<OpportunityTeamMember> opportunityTeamMemberList = [SELECT Id FROM OpportunityTeamMember
                            WHERE OpportunityId IN :opportunityIds];
        if (!opportunityTeamMemberList.isEmpty()) {
            delete opportunityTeamMemberList;
        }

    }
}