trigger TaskTrigger on Task (before insert) {
    if(trigger.isBefore && trigger.isInsert) {
        TaskTriggerHandler.setPriorityToHigh(trigger.new);
    } 
}