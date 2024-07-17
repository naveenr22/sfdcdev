trigger TriggerBefdelstudentas3krec on student__c (before delete) {
     {
        // Collect all student Ids that are going to be deleted
        Set<Id> studentIds = new Set<Id>();
        for(student__c student : Trigger.old) {
            System.debug('entered into for loop in stidclidl#####');
            studentIds.add(student.Id);
        }
    
        // Query all associated AS3K__c records
        List<AS3K_invoice__c> recordsToDelete =[SELECT Id FROM AS3K_invoice__c WHERE student__r.Id IN :studentIds];
        System.debug('stored client to stu ####'+recordsToDelete);
    
        // Delete associated AS3K__c records
        if(!recordsToDelete.isEmpty()){
            delete recordsToDelete;
            System.debug('clie dele ####');
        }
    }
    
}