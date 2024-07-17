public with sharing class trigcontactcls {
    public static void singleduplicprevconema(List<Contact> Lisco) {
        Set<String> conlasna = new Set<String>();
        Set<String> conlasem = new Set<String>();
        
        for (Contact contact : Lisco) {
            if (contact.Email != null && conlasem.contains(contact.Email)) {
                contact.addError('Duplicate Email found');
            } else {
                conlasem.add(contact.Email);
            }
            
            if (contact.LastName != null && conlasna.contains(contact.LastName)) {
                contact.addError('Duplicate Last Name found');
            } else {
                conlasna.add(contact.LastName);
            }
        }
    }
    
    public static void accratactr(List<Contact> listCon) {
        Set<Id> accountIds = new Set<Id>();
        
        for(Contact con : listCon) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Rating, Industry FROM Account WHERE Id IN :accountIds]);
        
        for(Contact con : listCon) {
            if (con.AccountId != null && accountMap.containsKey(con.AccountId)) {
                Account relatedAccount = accountMap.get(con.AccountId);
                con.Account_rating__c = relatedAccount.Rating;
                con.Account_Industry__c = relatedAccount.Industry;
            }
        }
    }
    
    public static void restrictcreatingconta(List<Contact> listcon){
        Set<Id> accids = new Set<Id>();
        Map<Id,Integer> mapa = new Map<Id,Integer>();
        
        for(Contact con : listcon){
            if(con.AccountId != null){
                accids.add(con.AccountId);
            }
        }
        
        if(!accids.isEmpty()){
            List<Account> lisacc = [SELECT id, Name,(SELECT Id FROM Contacts) FROM Account WHERE Id IN: accids];
            
            for(Account acc : lisacc){
                mapa.put(acc.Id, acc.Contacts.size());
            }
            
            for(Contact con : listcon){
                if(mapa.get(con.AccountId) >= 10){
                    con.addError('You cannot create more than 2 contacts');
                }
            }
        }
    }
    
    public static void createAccfornewConifnoCon(List<Contact> liscon){
        List<Account> accountsToInsert = new List<Account>();
        Map<Contact, Account> contactToAccountMap = new Map<Contact, Account>();
        
        for(Contact con : liscon){
            if(con.AccountId == null){
                Account newAcc = new Account(Name = con.LastName);
                accountsToInsert.add(newAcc);
                contactToAccountMap.put(con, newAcc);
            }
        }
        
        if(!accountsToInsert.isEmpty()){
            insert accountsToInsert;
        }
        
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact con : contactToAccountMap.keySet()){
            Account acc = contactToAccountMap.get(con);
            con.AccountId = acc.Id;
            contactsToUpdate.add(con);
        }
        
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
}
