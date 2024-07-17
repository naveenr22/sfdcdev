public with sharing class handlerforaccrattr {
    public static void accratactr(List<Account>Listac) {
        for(Account ac:Listac){
            If(ac.Rating=='Hot'){
                ac.is_Active__c=True;
            }
            else {
                ac.is_Active__c=False;
            }
        }

    }
}