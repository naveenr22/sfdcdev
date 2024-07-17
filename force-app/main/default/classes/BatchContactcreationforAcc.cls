        global class BatchContactcreationforAcc implements Database.Batchable<sObject> {
            global Database.QueryLocator start(Database.BatchableContext bc) {
                // Query the Accounts without any Contacts
                String query = 'SELECT Id, Name,Rating FROM Account WHERE Id NOT IN (SELECT AccountId FROM Contact)';
                return Database.getQueryLocator(query);
            }
            
            global void execute(Database.BatchableContext bc, List<Account> scope) {
                List<Contact> newContacts = new List<Contact>();
                
                // Create a new Contact for each Account in the batch
                for (Account acc : scope) {
                    Contact con = new Contact();
                    con.FirstName = +'Child'; // Set the desired Contact details here
                    con.LastName = acc.Name+acc.Rating;
                    con.AccountId = acc.Id;
                    
                    newContacts.add(con);
                }
                
                // Insert the Contacts
                if (!newContacts.isEmpty()) {
                    insert newContacts;
                }
            }
            
            global void finish(Database.BatchableContext bc) {
                // Perform any post-processing tasks if needed
            }
        }

    
    
