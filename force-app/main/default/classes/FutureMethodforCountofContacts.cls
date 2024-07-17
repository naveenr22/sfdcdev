
    public class FutureMethodforCountofContacts {
        @future
        public static void updateAccountContactCount(Set<Id> accountIds) {
            List<Account> accountsToUpdate = [SELECT Id, count_of_contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];
    
            for(Account acc : accountsToUpdate) {
                acc.count_of_contacts__c = acc.Contacts.size();
            }
    
            update accountsToUpdate;
        }
    }
   
