
trigger Apitriginsertrecindestorg on Account (after insert) {
        testCallOutExample te = new testCallOutExample();
        for(Account a : Trigger.new){
            String jsonAccount = JSON.serialize(a);
            
            te.createDataInTargetEnvironment(jsonAccount);
        }
    }
    

