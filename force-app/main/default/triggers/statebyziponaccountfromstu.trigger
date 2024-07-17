trigger statebyziponaccountfromstu on Account (before insert,before update) {
    
        // Collect all the state identifiers from Accounts
        Set<String> stateIds = new Set<String>();
        for (Account acc : Trigger.new) {
            stateIds.add(acc.State_Info_Id__c);  // replace with the actual field name that corresponds to '75078'
        }
    
        // Query State Information object to get state details
        Map<String, State_Information__c> stateMap = new Map<String, State_Information__c>();
        for (State_Information__c stateInfo : [SELECT Id, State__c FROM State_Information__c WHERE Id IN :stateIds]) {
            stateMap.put(stateInfo.Id, stateInfo);
        }
    
        // Update Account's BillingState
        for (Account acc : Trigger.new) {
            if (stateMap.containsKey(acc.State_Info_Id__c)) {
                acc.BillingState = stateMap.get(acc.State_Info_Id__c).State__c;
            }
        }
    }
    
    
    /*
        Map<String, String> stateInfo = new Map<String, String>();
       // stateInfo.put('75078', 'Texas');  // Example mapping of zip code to state
        
        // Get the state based on the zip code
        for (Account acc : Trigger.new) {
            if (stateInfo.containsKey(acc.BillingPostalCode)) {
                acc.BillingState = stateInfo.get(acc.BillingPostalCode);
            }
    }
    */

