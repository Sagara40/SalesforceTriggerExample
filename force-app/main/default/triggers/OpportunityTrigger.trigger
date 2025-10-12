trigger OpportunityTrigger on Opportunity (before insert,before update, after insert, after update, after delete, after undelete) {
    if(trigger.isAfter && trigger.isUpdate) {
        OpportunityTriggerHandler.createTaskOnClosedWon(trigger.new, trigger.oldMap);
    }
}