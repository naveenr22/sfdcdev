
    public class UserTaskAssign {
        @future
        public static void reassignTasks(Id oldUserId, Id newUserId) {
            List<Task> tasksToReassign = [SELECT Id, OwnerId FROM Task WHERE OwnerId = :oldUserId];
    
            for(Task t : tasksToReassign) {
                t.OwnerId = newUserId;
            }
    
            update tasksToReassign;
        }
    }
    
