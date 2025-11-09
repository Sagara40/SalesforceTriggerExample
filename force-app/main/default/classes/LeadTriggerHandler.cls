public with sharing class LeadTriggerHandler {
    public LeadTriggerHandler() {
        //constructor
    }

    //whenever Lead is Updated then Lead Status should be set to working - contacted.
    public static void setLeadStatusToWorkingContacted(List<Lead> leadList) {
        for(Lead lead : leadList) {
            lead.Status = 'Working - Contacted';
        }
    }

    //Whenever a Lead record is updated, check its Industry field: 
    //If Industry = Healthcare: 
    //Set Lead Source to Purchased List 
    //Set SIC Code to 700 
    //Set Primaryz to Yes

    public static void updateLeadBasedOnLeadSource(List<Lead> leadList) {
        for(Lead led : leadList) {
            if(led.Industry == 'Healthcare') {
                led.LeadSource = 'Purchased List';
                led.SICCode__c = '700';
                led.Primary__c = 'Yes';
            }
        }
    }

    //Whenever a Lead record is created, automatically create a Task for the Lead Owner with:
    //Subject: Follow Up with Customer
    //priority: High
    //Status: Not Started

    public static void createTaskOnLeadCreation(List<Lead> leadList) {
        List<Task> taskList = new List<Task>();
        for(Lead lead : leadList) {
            taskList.add(new Task(
                Subject = 'Follow Up with Customer',
                Priority = 'High',
                Status = 'Not Started',
                WhoId = lead.Id,
                OwnerId = lead.OwnerId
            ));
        }
        if(!taskList.isEmpty()) {
            insert taskList;
        }
    } 
    //Whenever a user attempts to delete a Lead record, check if:
    //Status = ‘Worked - Contacted’
    //If this condition is true, prevent the deletion of the record by adding an error message to ensure that 
    //important leads with this status remain in the CRM system for tracking, reporting, and follow-ups.

    public static void preventLeadDeletion(List<Lead> leadList) {
        for(Lead lead : leadList) {
            if(lead.Status == 'Working - Contacted') {
                lead.addError('Cannot delete lead with status Working - Contacted');
            }
        }
    }
}