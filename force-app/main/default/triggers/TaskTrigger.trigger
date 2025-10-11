trigger TaskTrigger on Task (before insert, before update, after insert, after update, after delete, after undelete) {
    if(trigger.isBefore && trigger.isInsert) {
        TaskTriggerHandler.setPriorityToHigh(trigger.new);
    } 
}