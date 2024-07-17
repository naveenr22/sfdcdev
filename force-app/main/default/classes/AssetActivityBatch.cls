
    global class AssetActivityBatch implements Database.Batchable<sObject> {
    
        global Database.QueryLocator start(Database.BatchableContext BC) {
            String query = 'SELECT Id, ActivationDate__c FROM Asset WHERE ActivationDate__c != null';
            return Database.getQueryLocator(query);
        }
        
        global void execute(Database.BatchableContext BC, List<Asset> records) {
            List<Task> tasksToInsert = new List<Task>();
    
            for(Asset a : records) {
                Integer monthsElapsed = a.ActivationDate__c.monthsBetween(Date.today());
                Date today = Date.today();
    
                if(monthsElapsed <= 3) {
                    tasksToInsert.add(new Task(
                        WhatId = a.Id,
                        Subject = '3 Month Survey',
                        ActivityDate = today.addMonths(3)
                    ));
                }
    
                if(monthsElapsed <= 6) {
                    tasksToInsert.add(new Task(
                        WhatId = a.Id,
                        Subject = '6 Month Survey',
                        ActivityDate = today.addMonths(6)
                    ));
                }
    
                if(monthsElapsed <= 9) {
                    tasksToInsert.add(new Task(
                        WhatId = a.Id,
                        Subject = '9 Month Survey',
                        ActivityDate = today.addMonths(9)
                    ));
                }
    
                tasksToInsert.add(new Task(
                    WhatId = a.Id,
                    Subject = '12 Month Survey',
                    ActivityDate = today.addMonths(12)
                ));
            }
    
            if(!tasksToInsert.isEmpty()) {
                insert tasksToInsert;
            }
        }
        
        global void finish(Database.BatchableContext BC) {
            // optional post-processing
        }
    }
    
