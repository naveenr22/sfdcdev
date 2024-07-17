trigger drtriggeronlead on Lead (before insert) {
      if(Trigger.isBefore){
        triggeronLead.drprepleadname(Trigger.new);
      }
}