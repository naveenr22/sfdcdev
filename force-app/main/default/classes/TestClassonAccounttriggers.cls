@isTest
public class TestClassonAccounttriggers {
    @isTest
    static void testUpdateShipAddress() {
        // Setup test data
        Account acc = new Account(Name='flight' + DateTime.now().getTime(), BillingStreet='Street1', BillingCity='City1', BillingState='State1', BillingPostalCode='12345', Copy_address__c=true);
        
        List<Account> listAcc = new List<Account>{acc};

        // Call the method to test
        Test.startTest();
        accpunthandler.updateshipadress(listAcc);
        Test.stopTest();

        insert listAcc;

        // Assert expected results
        Account resultAccount = [SELECT ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode FROM Account WHERE Id=:acc.Id];
        System.assertEquals('City1', resultAccount.ShippingCity);
        System.assertEquals('State1', resultAccount.ShippingState);
        System.assertEquals('12345', resultAccount.ShippingPostalCode);
    }
/*
    @isTest
    static void testRestrictDuplicateAccounts() {
        // Setup test data
        Account acc1 = new Account(Name='Test1' + DateTime.now().getTime());
        Account acc2 = new Account(Name='Test2' + DateTime.now().getTime());
        insert acc1;
        insert acc2;
        
        acc2.Name = acc1.Name;

        List<Account> listAcc = new List<Account>{acc2};
        Map<Id,Account> oldMap = new Map<Id,Account>{acc2.Id => acc2};

        // Call the method to test
        Test.startTest();
        try {
            accpunthandler.restrictDuplicateAccounts(listAcc, oldMap, false, true);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('This is the duplicate Account'));
        }
        Test.stopTest();

        // Assert expected results
        Account resultAccount = [SELECT Name FROM Account WHERE Id=:acc2.Id];
        System.assertEquals(acc2.Name, resultAccount.Name);
    }
*/
    @isTest
    static void testStatusOfRecord() {
        // Setup test data
        Account acc = new Account(Name='Flight2' + DateTime.now().getTime(), Last_Record_Status_Change__c=Date.today().addDays(-1));
        insert acc;
        List<Account> lisac = new List<Account>{acc};
        Map<Id,Account> oldmap = new Map<Id,Account>{acc.Id => acc};
        acc.Last_Record_Status_Change__c = Date.today();

        // Call the method to test
        Test.startTest();
        accpunthandler.statusOfRecord(lisac, oldmap);
        Test.stopTest();

        // Assert expected results
        Account resultAccount = [SELECT Last_Record_Status_Change__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(Date.today(), resultAccount.Last_Record_Status_Change__c);
    }

    @isTest
    static void testRestrictdleacchavingmoreopp() {
        // Setup test data
        Account acc = new Account(Name='Flight3' + DateTime.now().getTime());
        insert acc;
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i=0; i<11; i++) {
            opps.add(new Opportunity(Name='Opp'+i, StageName='Prospecting', CloseDate=Date.today().addDays(1), AccountId=acc.Id));
        }
        insert opps;
        List<Account> oldac = new List<Account>{acc};

        // Call the method to test
        Test.startTest();
        try {
            accpunthandler.restrictdleacchavingmoreopp(oldac);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('You can\'t delete account since this is related to multiple opportunities'));
        }
        Test.stopTest();

        // Assert expected results
        Account resultAccount = [SELECT Id FROM Account WHERE Id=:acc.Id];
        System.assertNotEquals(null, resultAccount);
    }
    @isTest
    static void testAvoidDelContact() {
        // Setup test data
        Account acc = new Account(Name='Flight4' + DateTime.now().getTime());
        insert acc;
        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;
        List<Account> newAccounts = new List<Account>{acc};

        // Call the method to test
        Test.startTest();
        try {
            accpunthandler.avoiddelcontact(newAccounts, null);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('You can\'t delete this account as it is related to a Contact.'));
        }
        Test.stopTest();

        // Assert expected results
        Account resultAccount = [SELECT Id FROM Account WHERE Id=:acc.Id];
        System.assertNotEquals(null, resultAccount);
    }

    @isTest
    static void testCreateContactCreation() {
        // Setup test data
        Account acc = new Account(Name='Flight5' + DateTime.now().getTime(), Create_Contact__c=true);
        insert acc;
        List<Account> listAcc = new List<Account>{acc};

        // Call the method to test
        Test.startTest();
        accpunthandler.createContactCreation(listAcc);
        Test.stopTest();

        // Assert expected results
        Contact resultContact = [SELECT LastName FROM Contact WHERE AccountId=:acc.Id];
        System.assertEquals('Test Contact', resultContact.LastName);
    }
    @isTest
    static void testCreateConOppCas() {
        // Setup test data
        Account acc = new Account(Name='Flight6' + DateTime.now().getTime(), Create_contact__c=true, Create_opportunity__c=true, Create_case__c=true);
        insert acc;
        List<Account> lisac = new List<Account>{acc};

        // Call the method to test
        Test.startTest();
        accpunthandler.createConOppCas(lisac);
        Test.stopTest();

        // Assert expected results
        Contact resultContact = [SELECT LastName FROM Contact WHERE AccountId=:acc.Id];
        System.assertEquals('Test  Contact', resultContact.LastName);
        
        Opportunity resultOpp = [SELECT Name FROM Opportunity WHERE AccountId=:acc.Id];
        System.assertEquals('TestOpportunity', resultOpp.Name);
        
        Case resultCase = [SELECT Id FROM Case WHERE AccountId=:acc.Id];
        System.assertNotEquals(null, resultCase.Id);
    }

    @isTest
    static void testUpdateAllContacts() {
        // Setup test data
        Account acc = new Account(Name='Flight7' + DateTime.now().getTime(), Is_Active__c=true);
        insert acc;
        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id, Active__c=false);
        insert con;
        List<Account> listAcc = new List<Account>{acc};
        Map<Id,Account> oldMap = new Map<Id,Account>{acc.Id => acc};

        // Call the method to test
        Test.startTest();
        accpunthandler.updateAllContacts(listAcc, oldMap);
        Test.stopTest();

        // Assert expected results
        Contact resultContact = [SELECT Active__c FROM Contact WHERE Id=:con.Id];
        System.assertEquals(true, resultContact.Active__c);
    }
}


