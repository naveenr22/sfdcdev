trigger trigstudent on Student__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        studenttrigcla.Prepednamestu(Trigger.New);
        
    }

}