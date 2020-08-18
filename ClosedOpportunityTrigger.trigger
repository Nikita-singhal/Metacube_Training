trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Opportunity> opportunity = Trigger.New;
    List<Task> tasks = new List<Task>();
    for(Opportunity O : opportunity){
        if(O.StageName == 'Closed Won'){
            tasks.add(new Task(Subject = 'Follow Up Test Task', WhatId = O.Id));
        }
    }
    insert tasks;
}