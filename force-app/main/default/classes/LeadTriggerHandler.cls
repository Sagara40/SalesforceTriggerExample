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
}