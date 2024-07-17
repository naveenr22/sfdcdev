
    public class BatchMaskmailonLead implements Database.Batchable<sObject> {
        public Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator([SELECT Id, Email FROM Lead]);
        }
    
        public void execute(Database.BatchableContext bc, List<sObject> scope) {
            List<Lead> leadsToUpdate = new List<Lead>();
    
            for (sObject record : scope) {
                Lead lead = (Lead)record;
                if (lead.Email != null && lead.Email != '') {
                    // Mask the email by replacing characters with '*'
                    lead.Email = maskEmail(lead.Email);
                    leadsToUpdate.add(lead);
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
