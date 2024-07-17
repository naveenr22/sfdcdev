@isTest
public class TestclassOpportunity {
    @isTest static void testAllMethods() {
        // Setup test data
        Account acc = new Account(Name='Test Account');
        insert acc;

        Contact cont1 = new Contact(LastName='Contact 1', AccountId=acc.Id);
        Contact cont2 = new Contact(LastName='Contact 2', AccountId=acc.Id);
        insert new List<Contact>{cont1, cont2};

        // Test restrictOpportunityCreation method
        Test.startTest();
        Opportunity opp = new Opportunity(
            Name='Test Opportunity',
            StageName='Prospect',
            CloseDate=System.today(),
            AccountId=acc.Id
        );
        Database.SaveResult sr = Database.insert(opp, false);
        Test.stopTest();
        System.assert(!sr.isSuccess(), 'Opportunity should not be created for Account with more than one Contact');
        System.assert(sr.getErrors()[0].getMessage() == 'Cannot create opportunity for an Account with more than 1 contacts', 'Error message should match');

        // Delete one Contact to allow Opportunity creation
        delete cont2;

        // Test updatedateonstage and stagechangecheisval methods
        opp = new Opportunity(
            Name='Test Opportunity',
            StageName='Prospect',
            CloseDate=System.today(),
            AccountId=acc.Id
        );
        insert opp;

        // Validate that the Prospecting_date__c is set
        opp = [SELECT Prospecting_date__c FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(System.today(), opp.Prospecting_date__c, 'Prospecting_date__c should be set to today');

        // Test stage change
        opp.StageName = 'Closed Won';
        update opp;

        // Validate that the isValueCheck__c is set to true and Closed_won_date__c is set
        opp = [SELECT isValueCheck__c, closed_won_date__c FROM Opportunity WHERE Id = :opp.Id];
        System.assert(opp.isValueCheck__c, 'isValueCheck__c should be set to true');
        System.assertEquals(System.today(), opp.closed_won_date__c, 'closed_won_date__c should be set to today');

        // Test updateAccount method
        acc = [SELECT Is_Active__c FROM Account WHERE Id = :acc.Id];
        System.assert(acc.Is_Active__c, 'Account should be active after Opportunity is closed');
    }
}
