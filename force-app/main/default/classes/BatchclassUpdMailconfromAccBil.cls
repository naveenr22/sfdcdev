
    public class BatchclassUpdMailconfromAccBil implements Database.Batchable<sObject> {

        public Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator([
                SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry,
                       Account.BillingStreet, Account.BillingCity, Account.BillingState, Account.BillingPostalCode, Account.BillingCountry
                FROM Contact
                WHERE MailingStreet = null OR MailingCity = null OR MailingState = null OR MailingPostalCode = null OR MailingCountry = null
            ]);
        }
   
        public void execute(Database.BatchableContext bc, List<Contact> scope) {
            List<Contact> contactsToUpdate = new List<Contact>();
    
            for (Contact contact : scope) {
                if (contact.Account != null && contact.Account.BillingStreet != null &&
                    contact.Account.BillingCity != null && contact.Account.BillingState != null &&
                    contact.Account.BillingPostalCode != null && contact.Account.BillingCountry != null) {
                    
                    contact.MailingStreet = contact.Account.BillingStreet;
                    contact.MailingCity = contact.Account.BillingCity;
                    contact.MailingState = contact.Account.BillingState;
                    contact.MailingPostalCode = contact.Account.BillingPostalCode;
                    contact.MailingCountry = contact.Account.BillingCountry;
                    
                    contactsToUpdate.add(contact);
                }
            }
    
            update contactsToUpdate;
        }
    
        public void finish(Database.BatchableContext bc) {
            // Optional: Add any post-processing logic here
        }
    }
