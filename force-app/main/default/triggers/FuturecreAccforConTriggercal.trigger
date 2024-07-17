

    trigger FuturecreAccforConTriggercal on Account (after update) {
        Set<Id> accountIds = new Set<Id>();
        
        // Check if the shipping address has changed for any updated accounts
        for (Account account : Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(account.Id);
            
            if (account.ShippingStreet != oldAccount.ShippingStreet ||
                account.ShippingCity != oldAccount.ShippingCity ||
                account.ShippingState != oldAccount.ShippingState ||
                account.ShippingPostalCode != oldAccount.ShippingPostalCode ||
                account.ShippingCountry != oldAccount.ShippingCountry) {
                accountIds.add(account.Id);
            }
        }
        
        // Invoke the future method to update the contact mailing addresses
        if (!accountIds.isEmpty()) {
            List<id> accountIdsList = new List<id>(accountIds);
            String accountIdsJson = JSON.serialize(accountIdsList);
            FutureAccocreforContact.updateContactMailingAddresses(accountIdsJson);
        }
    }