
 
    public class FutureUpdConMailAdrsfromBilAcAd {
        @future
        public static void updateContactAddresses(Id accountId, String street, String city, String state, String postalCode, String country) {
            List<Contact> contactsToUpdate = [SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact WHERE AccountId = :accountId];
    
            for(Contact c : contactsToUpdate) {
                c.MailingStreet = street;
                c.MailingCity = city;
                c.MailingState = state;
                c.MailingPostalCode = postalCode;
                c.MailingCountry = country;
            }
    
            update contactsToUpdate;
        }
    }
    
