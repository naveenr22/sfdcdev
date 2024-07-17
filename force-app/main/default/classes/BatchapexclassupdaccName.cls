
    public class BatchapexclassupdaccName implements Database.Batchable<sObject> {
        public Database.QueryLocator start(Database.BatchableContext BC) {
            String query = 'SELECT Id, Name FROM Account';
            return Database.getQueryLocator(query);
        }
    
        public void execute(Database.BatchableContext BC, List<Account> scope) {
            for (Account acc : scope) {
                acc.Name += ' Updated from batch Job';
            }
            update scope;
        }
    
        public void finish(Database.BatchableContext BC) {
            // You can add any post-processing logic here
        }
    }
