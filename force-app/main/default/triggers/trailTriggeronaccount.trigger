trigger trailTriggeronaccount on Account (before insert) {
     if(trigger.isAfter){
        for(Account acc: trigger.new){
            acc.Industry='Agriculture';

        }
     }
        for(Account acc:trigger.new){
            acc.Rating='hot';
        }
        
}