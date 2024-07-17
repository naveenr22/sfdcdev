trigger UpdateAcbilladtoConmailadrsAfterUpdate on Account (after update) {
    
        // Collect all Account Ids that have had their Billing Address updated
        Set<Id> updatedAccountIds = new Set<Id>();
        for(Account acc : Trigger.new) {
            Account oldAcc = Trigger.oldMap.get(acc.Id);
            if(acc.BillingStreet != oldAcc.BillingStreet || acc.BillingCity != oldAcc.BillingCity || 
               acc.BillingState != oldAcc.BillingState || acc.BillingPostalCode != oldAcc.BillingPostalCode ||
               acc.BillingCountry != oldAcc.BillingCountry) {
                updatedAccountIds.add(acc.Id);
            }
        }
    
        // Query all associated Contact records
        List<Contact> contactsToUpdate = [SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry 
                                          FROM Contact WHERE AccountId IN :updatedAccountIds];
    
        // Create a map for easy access to new Account data
        Map<Id, Account> newAccountMap = Trigger.newMap;
    
        // Update associated Contact Mailing Address fields
        for(Contact cont : contactsToUpdate) {
            Account parentAcc = newAccountMap.get(cont.AccountId);
            cont.MailingStreet = parentAcc.BillingStreet;
            cont.MailingCity = parentAcc.BillingCity;
            cont.MailingState = parentAcc.BillingState;
            cont.MailingPostalCode = parentAcc.BillingPostalCode;
            cont.MailingCountry = parentAcc.BillingCountry;
        }
    
        // Use DML operation to update the contacts
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
    
