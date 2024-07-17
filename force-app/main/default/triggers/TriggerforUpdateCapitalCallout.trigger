
    trigger TriggerforUpdateCapitalCallout on Account (after update) {
        Set<String> countries = new Set<String>();
    
        for (Account acc : Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(acc.Id);
            if (acc.BillingCountry != oldAccount.BillingCountry) {
                countries.add(acc.BillingCountry);
            }
        }
    
        if (!countries.isEmpty()) {
            UpdateCapitalCalloutAccountContactapi.updateCapitalField(new List<String>(countries));
        }
    }