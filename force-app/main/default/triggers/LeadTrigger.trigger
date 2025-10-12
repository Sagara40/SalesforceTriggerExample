trigger LeadTrigger on Lead (before insert, before update, after insert, after update, after delete, after undelete) {
    if(trigger.isBefore && trigger.isUpdate) {
        LeadTriggerHandler.setLeadStatusToWorkingContacted(trigger.new);
    }
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        LeadTriggerHandler.updateLeadBasedOnLeadSource(trigger.new);
    }
    if(trigger.isAfter && trigger.isInsert) {
        LeadTriggerHandler.createTaskOnLeadCreation(trigger.new);
    }
}