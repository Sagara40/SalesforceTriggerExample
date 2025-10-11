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
}