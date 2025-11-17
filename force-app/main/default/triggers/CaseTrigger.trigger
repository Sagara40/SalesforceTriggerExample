trigger CaseTrigger on Case (before insert, before update, after insert, after update, after delete, after undelete) {

    if(trigger.isBefore && (trigger.isUpdate) || trigger.isInsert) {
        CaseTriggerHandler.updateCasePriorityDependonOrigin(trigger.new);
    }
    if(trigger.isBefore && trigger.isDelete) {
        CaseTriggerHandler.preventCaseDeletion(trigger.old);
    }
}