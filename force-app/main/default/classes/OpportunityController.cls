
    public with sharing class OpportunityController {
        @AuraEnabled
        public static List<Opportunity> getClosedWonOpportunities() {
            return [SELECT Name, StageName, CloseDate, Probability FROM Opportunity WHERE StageName = 'Closed Won'];
        }
    }
    
