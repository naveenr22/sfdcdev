@isTest
public class testclassforTrigonContacts {
    
    @isTest static void testMethods() {
        //Create a test account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        //Create a test contact
        Contact testContact = new Contact(LastName = 'Test', Email = 'test@example.com', AccountId = testAccount.Id);
        insert testContact;
        
        //Test the createAccfornewConifnoCon method
        Contact newContact = new Contact(LastName = 'Test 2', Email = 'test2@example.com');
        List<Contact> contacts = new List<Contact>();
        insert newContact;
        Test.startTest();
        trigcontactcls.createAccfornewConifnoCon(contacts);
        Test.stopTest();
        newContact = [SELECT AccountId FROM Contact WHERE Id = :newContact.Id];
        System.assertNotEquals(null, newContact.AccountId, 'The AccountId should not be null');
        
        //Test the singleduplicprevconema method
        try {
            newContact = new Contact(LastName = 'Test', Email = 'test@example.com', AccountId = testAccount.Id);
            contacts = new List<Contact>{newContact};
            insert contacts;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Duplicate Email found'), 'Exception message should contain "Duplicate Email found"');
        }
        
        //Test the restrictcreatingconta method
        contacts = new List<Contact>();
        for(Integer i = 0; i < 11; i++) {
            contacts.add(new Contact(LastName = 'Test '+i, Email = 'test'+i+'@example.com', AccountId = testAccount.Id));
        }
        try {
            insert contacts;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('You cannot create more than 2 contacts'), 'Exception message should contain "You cannot create more than 2 contacts"');
        }
    }
}
