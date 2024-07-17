
    public class BatchclsforAccountHistroy implements Database.Batchable<sObject> {
    
        public Database.QueryLocator start(Database.BatchableContext bc) {
            // Query accounts and related account history
            String query = 'SELECT Id, Name, (SELECT Field, CreatedDate, CreatedBy.Name FROM Histories ORDER BY CreatedDate DESC) FROM Account';
            return Database.getQueryLocator(query);
        }
        
        public void execute(Database.BatchableContext bc, List<Account> scope) {
            List<Account> accountsToUpdate = new List<Account>();
            
            for (Account account : scope) {
                String accountHistoryDescription = '';
                
                for (AccountHistory history : account.Histories) {
                    // Append account history details to the description
                    accountHistoryDescription += history.CreatedDate.format('MM/dd/yyyy, h:mm a') + ' - ' + history.Field + ' - ' + history.CreatedBy.Name + '\n';
                }
                
                // Update the account description with the account history
                account.Description = accountHistoryDescription;
                
                accountsToUpdate.add(account);
            }
            
            // Update the accounts with the updated description
            update accountsToUpdate;
        }
        
        public void finish(Database.BatchableContext bc) {
            // Execute any post-processing operations
        }
    }
    
    
