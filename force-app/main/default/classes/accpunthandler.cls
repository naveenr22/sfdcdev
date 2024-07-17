public with sharing class accpunthandler {
    public static void updateshipadress(List<Account>listAcc) {
        for(Account acc:listAcc){
            if(acc.Copy_address__c==True){
                acc.ShippingState=acc.BillingState;
                acc.ShippingCity=acc.BillingCity;
                acc.ShippingPostalCode=acc.BillingPostalCode;
            }
        }
    }
    
    public static void statusOfRecord(List<Account> lisac, Map<Id, Account> oldmap) {
        if (!lisac.isEmpty() && oldmap != null) {
            for (Account a : lisac) {
                Account oldAccount = oldmap.get(a.Id);
                if (oldAccount != null && a.Last_Record_Status_Change__c != oldAccount.Last_Record_Status_Change__c) {
                    a.Last_Record_Status_Change__c = System.today();
                }
            }
        }
    }
    
    public static void restrictdleacchavingmoreopp(List<Account> oldac) {
        if(oldac == null) {
            return; // or throw an error, depending on your use case
        }
        Set<Id> accIds = new Set<Id>();
        for (Account acc : oldac) {
            if(acc != null) {
                accIds.add(acc.Id);
            }
        }
        if (!accIds.isEmpty()) {
            List<Account> lisacc = [SELECT Id, Name, (SELECT Id FROM Opportunities) FROM Account WHERE Id IN :accIds];
            for (Account acc : lisacc) {
                if (acc.Opportunities != null && acc.Opportunities.size() > 10) {                
                    acc.addError('You can\'t delete account since this is related to multiple opportunities ');
                }
            }
        }
    }
    
    public static void avoiddelcontact(List<Account> newAccounts, Map<Id, Account> oldMap) {
        Set<Id> accIds = new Set<Id>();
        for (Account acc : newAccounts) {
            accIds.add(acc.Id);
        }
        if (!accIds.isEmpty()) {
            List<Account> accountsWithContacts = [SELECT Id, Name, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds];
    
            for (Account acc : accountsWithContacts) {
                if (!acc.Contacts.isEmpty()) {
                    acc.addError('You can\'t delete this account as it is related to a Contact.');
                }
            }
        }
    }
    
    public static void createContactCreation (List<Account> listAcc) {
        List<Contact> listConToInsert = new List<Contact>();
        for (Account acc : listAcc) {
        if(acc.Create_Contact__c == true){
        Contact con = new Contact();
        con.LastName = acc.Name + ' Contact';
        listConToInsert.add(con);
        }
    }
        if(!listConToInsert.isEmpty()){
        insert listConToInsert;
        }
    }

    public static void createConOppCas(List<Account>lisac){
        List<Contact> lisconInsert = new List<Contact>();
        List<Opportunity> lisOppInsert = new List<Opportunity>();
        List<Case> liscaseInsert = new List<Case>();
    
        for(Account acc: lisac){
            if(acc.Create_contact__c == True){
                Contact con = new Contact();
                con.LastName = acc.Name + '  Contact';
                con.Birthdate = System.today().addYears(-20);
                lisconInsert.add(con);
                
                Opportunity opp = new Opportunity();
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today().addDays(20);
                opp.Name = acc.Name + ' Opportunity';
                lisOppInsert.add(opp);
    
                Case cas = new Case();
                cas.Status = 'New';
                cas.Origin = 'Phone';
                liscaseInsert.add(cas);
            }
        }
        if(!lisconInsert.isEmpty()){
            insert lisconInsert;
        }
        if(!lisOppInsert.isEmpty()){
            insert lisOppInsert;
        }
        if(!liscaseInsert.isEmpty()){
            insert liscaseInsert;
        }
    }
    
    public static void updateAllContacts(List<Account> listAcc, Map<Id,Account> oldMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc: listAcc){
            if(acc.is_Active__c == true){
                accIds.add(acc.Id);
            }
        }
        if(!accIds.isEmpty()){
            List<Contact> listcon = [SELECT Id, Active__c FROM Contact WHERE AccountId IN: accIds];
            for(Contact con: listcon){
                con.Active__c = true;
            }
            if(!listcon.isEmpty()){
                update listcon;
            }
        }
    }
    
}
