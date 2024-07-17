trigger poplateowneremailphnonopp on Opportunity (before insert, before update,after insert, after update)
 {

                if(Trigger.isBefore){
                   // triggersonOpportunity.populateoppownerdet(Trigger.new);
                }
                if(trigger.isInsert && trigger.isUpdate){
                   triggersonOpportunity.updatedateonstage(trigger.new,trigger.oldMap);
                }
               if(trigger.isUpdate){
                triggersonOpportunity.stagechangecheisval(trigger.new,trigger.oldMap);
               }
               triggersonOpportunity.restrictOpportunityCreation(trigger.new);
               if(Trigger.isAfter){
                if (Trigger.isUpdate) {
                    triggersonOpportunity.updateAccount(Trigger.New, Trigger.oldMap);
        }

}
 }