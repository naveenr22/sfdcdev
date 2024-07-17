public class sumHours {
    public static Integer sumHours() {
             List<AS3K_Time_Sheet__c> contacts = [SELECT Hours__c FROM AS3K_Time_Sheet__c];
        Integer totalHours = 0;

        for(AS3K_Time_Sheet__c c : contacts){
            try {
                totalHours += Integer.valueOf(c.Hours__c);
            } catch(Exception e) {
                System.debug('Invalid integer value in Hours__c picklist for Contact Id: ' + c.Id);
            }
        }

        return totalHours;
    }


}