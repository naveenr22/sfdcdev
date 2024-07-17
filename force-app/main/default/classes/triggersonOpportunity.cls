public with sharing class triggersonOpportunity {
    public static void populateoppownerdet(List<Opportunity>lisop) {
        Set<Id> OwnerIds=new set<Id>();
        for(Opportunity op:lisop){
            OwnerIds.add(op.OwnerId);
        }
        Map<Id,User>mapIdtooppown=new Map<Id, User>([select Id, Phone,Email from User WHERE Id IN :OwnerIds]);
        for(Opportunity op:lisop){
            User uRec = mapIdtooppown.get(op.OwnerId);
            op.Phone__c=uRec.Phone;
            op.Email__c=uRec.Email;
        
        }

    }
    public static void updatedateonstage(List<Opportunity>lisop, Map<Id,Opportunity>oldmap){
        System.debug('triggereed:::::::');
        for(Opportunity op: lisop){
            if(op.StageName=='Prospect'){
                op.Prospecting_date__c=System.today();
                System.debug('::::::entered to if');
            }
            else if(op.StageName=='Qualification'){
                op.Qualification_date__c=System.today();
            }
            else if(op.StageName=='Needs Analysis'){
                op.Needs_analysis_date__c=System.today();
            }
            else if(op.StageName=='Value Proposition'){
                op.value_proposition_date__c=System.today();
            }
            else if(op.StageName=='Id. Decision Makers'){
                op.Decision_makers_date__c=System.today();
            }
            else if(op.StageName=='Perception Analysis'){
                op.Perception_analysis_date__c=System.today();
            }
            else if(op.StageName=='Proposal/Price Quote'){
                op.Perception_analysis_date__c=System.today();
            }
            else if(op.StageName=='Negotiation/Review'){
                op.Perception_analysis_date__c=System.today();
            }
            else if(op.StageName=='Closed Won'){
                op.closed_won_date__c=System.today();
            }
            else{
                op.Closed_lost_date__c=System.today();
            }

        }
    }

    public static void stagechangecheisval(List<Opportunity>lisop,Map<Id,Opportunity>oldmap){
        System.debug('entered to trigger###');
        for(Opportunity op : lisop){
            Opportunity oldopp=oldmap.get(op.Id);
          if(op.StageName=='Closed Won' && op.StageName!=oldopp.StageName)
           {
              op.isValueCheck__c=True;
           }
        }


        }

        public static void restrictOpportunityCreation(List<Opportunity> newOpportunities) {
            Set<Id> accountIds = new Set<Id>();
            Map<Id, Integer> accountIdToContactCountMap = new Map<Id, Integer>();
    
            for (Opportunity opp : newOpportunities) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
    
            if (!accountIds.isEmpty()) {
                List<Account> accountsWithContacts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];
    
                for (Account acc : accountsWithContacts) {
                    accountIdToContactCountMap.put(acc.Id, acc.Contacts.size());
                }
    
                for (Opportunity opp : newOpportunities) {
                    if (opp.AccountId != null && accountIdToContactCountMap.containsKey(opp.AccountId) && accountIdToContactCountMap.get(opp.AccountId) > 1) {
                        opp.addError('Cannot create opportunity for an Account with more than 1 contacts');
                    }
                }
            }
        }
        public static void updateAccount (List<Opportunity> listOpp, Map<Id, Opportunity> oldMap) {
            Set<Id> accIds = new Set<Id>();
            for(Opportunity oppRec : listOpp) {
            if(oppRec.AccountId != null){
            if (oppRec.StageName == 'Closed Won' && oppRec.StageName != oldMap.get(oppRec.id).StageName) {
            accIds.add(oppRec.AccountId);
                            }
                        }
                    }
            if(!accIds.isEmpty()){
                List<Account> listAcc = [SELECT id FROM Account WHERE Id IN : accIds];
                for(Account acc : listAcc) {
                acc.Is_Active__c = true;
                }
                if(!listAcc.isEmpty()){
                update listAcc;
    }
            }
        }
  
     }
    

        
    


