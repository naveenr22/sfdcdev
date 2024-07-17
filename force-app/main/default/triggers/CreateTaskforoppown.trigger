trigger CreateTaskforoppown on Opportunity (after insert) {

     List<Task> newTasks = new List<Task>();
        for (Opportunity opp : Trigger.new) {
            Task newTask = new Task();
             newTask.Subject = opp.Name + ' Task';
             newTask.WhatId = opp.Id;
             newTask.OwnerId = opp.OwnerId;
             newTasks.add(newTask);
        }
        if (!newTasks.isEmpty()) {
            insert newTasks;
        }
    }