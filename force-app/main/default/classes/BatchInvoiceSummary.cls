
    public class BatchInvoiceSummary implements Database.Batchable<sObject>, Database.Stateful {
        private Integer totalRecordsProcessed = 0;
        private Integer totalSuccessRecords = 0;
        private Integer totalErrorRecords = 0;
    
        public Database.QueryLocator start(Database.BatchableContext bc) {
            String query = 'SELECT Id, (SELECT Id, Amount__c FROM AS3K_invoice__c) FROM student__c';
            return Database.getQueryLocator(query);
        }
    
        public void execute(Database.BatchableContext bc, List<student__c> students) {
            List<student__c> studentsToUpdate = new List<student__c>();
            
            for (student__c student : students) {
                try {
                    // Count the number of AS2K invoices and sum of the invoice amount
                    student.Count_of_Invoice__c = student.AS3K_invoice__c.size();
                    //student.Invoice_Amount_Sum__c = 0;
                
    
                    for (AS3K_invoice__c invoice : student.AS3K_invoice__c) {
                        student.Invoice_Amount_Sum__c += invoice.Amount__c;
                    }
                    
                    studentsToUpdate.add(student);
                    totalSuccessRecords++;
                } catch (Exception e) {
                    totalErrorRecords++;
                }
                totalRecordsProcessed++;
            }
    
            update studentsToUpdate;
        }
    
        public void finish(Database.BatchableContext bc) {
            System.debug('Total records processed: ' + totalRecordsProcessed);
            System.debug('Total success records: ' + totalSuccessRecords);
            System.debug('Total error records: ' + totalErrorRecords);
        }
    }
   