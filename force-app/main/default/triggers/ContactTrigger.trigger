trigger ContactTrigger on Contact (before insert, before update, after insert, after update, after delete, after undelete) {

    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        ContactTrigger_Handler.preventContactCreationWithoutParentAccount(trigger.new);
    }
}