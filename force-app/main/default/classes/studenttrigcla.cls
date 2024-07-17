public with sharing class studenttrigcla {
    public static void Prepednamestu(List<student__c>Listu) {
        if (Trigger.isBefore && Trigger.isInsert) {
            for(student__c stu : Listu){
                if (stu.gender__c == 'Male') {
                    system.System.debug('Entering into if loop@@@@@@@');
                    stu.Name__c = 'Mr. '+ stu.Name__c;     
                }else{
                    System.debug('Entering into else loop@@@@@@@');
                    stu.Name__c = 'Ms '+ stu.Name__c;
                }
            }
            
        }

    }
}