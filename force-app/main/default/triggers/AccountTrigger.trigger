trigger AccountTrigger on Account (before insert, before update, after insert, after update, after delete, after undelete) {

    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        AccountTriggerHandler.preventAccountCreationWithPrivateOwnership(trigger.new);
    }
}