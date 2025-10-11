public with sharing class TaskTriggerHandler {
    public TaskTriggerHandler() {
        //constructor
    }
    // where task record is created set priority to high.
    public static void setPriorityToHigh(List<Task> taskList) {
        for(Task t : taskList) {
            t.Priority = 'High';
        }
    }
}