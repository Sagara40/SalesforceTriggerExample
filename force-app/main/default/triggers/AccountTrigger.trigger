trigger AccountTrigger on Account (before insert, before update, after insert, after update, after delete, after undelete) {

    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        AccountTriggerHandler.preventAccountCreationWithPrivateOwnership(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate) {
        AccountTriggerHandler.updateWebsiteOnRelatedContacts(trigger.new, trigger.oldMap);
    }
    if(trigger.isAfter && trigger.isInsert) {
        AccountTriggerHandler.createContactsOnAccountCreation(trigger.new);
    }
}