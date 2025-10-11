trigger LeadTrigger on Lead (before insert, before update, after insert, after update, after delete, after undelete) {
    if(trigger.isBefore && trigger.isUpdate) {
        LeadTriggerHandler.setLeadStatusToWorkingContacted(trigger.new);
    }
}