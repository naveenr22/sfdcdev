
trigger FuturetrigUserTaskAssign on User (after update) {
        for(User u : Trigger.new) {
            User oldUser = Trigger.oldMap.get(u.Id);
            if(oldUser.Delegated_User__c != u.Delegated_User__c) {
                UserTaskAssign.reassignTasks(oldUser.Delegated_User__c, u.Delegated_User__c);
            }
        }
    }
    
