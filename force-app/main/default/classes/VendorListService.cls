public class VendorListService {
    @AuraEnabled(cacheable=true)
    public static List<String> getVendorEmails(String domain) {
        List<VendorsList__c> vendors = [
            SELECT Email__c FROM VendorsList__c WHERE Email__c LIKE :('%' + domain + '%')
        ];
        
        List<String> emails = new List<String>();
        for(VendorsList__c vendor : vendors) {
            emails.add(vendor.Email__c);
        }
        return emails;
    }
}
