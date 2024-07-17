trigger UpdatestudonclientactiveAfterUpdate on Client__c (after update) {
    System.debug('clientstudenactive#####');
        // Collect all client Ids that are going to be updated to active
        Set<Id> activeClientIds = new Set<Id>();
        for(Client__c client : Trigger.new) {
            System.debug('Entere for loop clistu#####');
            Client__c oldClient = Trigger.oldMap.get(client.Id);
            if(client.isActive__c==True && !oldClient.isActive__c==True) {
                System.debug('Entere If loop clistu#####');
                activeClientIds.add(client.Id);
            }
        }
        System.debug('no of clients active:'+activeClientIds.size());
    
        // Query all associated Student__c records
        List<Student__c> studentsToUpdate = [SELECT Id, isActive__c FROM Student__c WHERE Client__c IN :activeClientIds];
         System.debug('list of stutoupd####'+studentsToUpdate.size());
        // Update associated Student__c records to active
        for(Student__c student : studentsToUpdate) {
            student.isActive__c = true;
            System.debug('Updatestutrueforlop clistu#####');
        }
    
        // Use DML operation to update the students
        if(!studentsToUpdate.isEmpty()){
            update studentsToUpdate;
        }
    }
    

