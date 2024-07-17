public class BatchAs3kStudentsameOwner implements Database.Batchable<sObject>  {
    public Database.QueryLocator start(Database.BatchableContext bc) {
                   // Query all Student records
                   String query = 'SELECT Id, OwnerId, AS3K_invoice__r.OwnerId FROM student__c WHERE AS3K_invoice__c != null';
                   return Database.getQueryLocator(query);
               }
               
               public void execute(Database.BatchableContext bc, List<student__c> scope) {
                   List<student__c> studentsToUpdate = new List<student__c>();
                   
                   for (student__c student : scope) {
                       // Update student owner to be the same as AS3K invoice owner
                       student.OwnerId = student.AS3K_invoice__r.OwnerId;
                       
                       studentsToUpdate.add(student);
                   }
                  
                   // Update the students with the updated owner
                   update studentsToUpdate;
               }
               
               public void finish(Database.BatchableContext bc) {
                   // Execute any post-processing operations
               }
           }
