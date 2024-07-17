
    public class FutureAccocreforContact {
        @future
        public static void updateContactMailingAddresses(String accountIdsJson) {
            List<String> accountIds = (List<String>) JSON.deserialize(accountIdsJson, List<String>.class);
            List<Contact> contactsToUpdate = new List<Contact>();
            
            // Query contacts associated with the changed accounts
            List<Contact> contacts = [SELECT Id, AccountId, Account.ShippingStreet, Account.ShippingCity, Account.ShippingState,
                                       Account.ShippingPostalCode, Account.ShippingCountry
                                       FROM Contact
                                       WHERE AccountId IN :accountIds];
            
            // Update the mailing address of each contact
            for (Contact contact : contacts) {
                contact.MailingStreet = contact.Account.ShippingStreet;
                contact.MailingCity = contact.Account.ShippingCity;
                contact.MailingState = contact.Account.ShippingState;
                contact.MailingPostalCode = contact.Account.ShippingPostalCode;
                contact.MailingCountry = contact.Account.ShippingCountry;
                
                contactsToUpdate.add(contact);
            }
            
            // Perform the contact update
            if (!contactsToUpdate.isEmpty()) {
                update contactsToUpdate;
            }
        }
    }
