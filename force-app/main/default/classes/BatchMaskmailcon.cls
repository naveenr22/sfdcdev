
public class LeadEmail implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Email FROM Contact]);
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Contact> leadsToUpdate = new List<Contact>();

        for (sObject record : scope) {
            Contact lead = (Contact)record;
            if (Contact.Email != null && Contact.Email != '') {
                // Mask the email by replacing characters with '*'
                Contact.Email = maskEmail(Contact.Email);
                leadsToUpdate.add(Contact);
            }
        }

        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Optional: Add any post-processing logic here
    }

    // Helper method to mask the email
    private String maskEmail(String email) {
        Integer atIndex = email.indexOf('@');
        if (atIndex > 0) {
            String maskedLocalPart = email.substring(0, atIndex).replaceAll('[a-zA-Z0-9]', '*');
            String domainPart = email.substring(atIndex);
            return maskedLocalPart + domainPart;
        }
        return email;
    }
}