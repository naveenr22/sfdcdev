trigger Practise on Case (before insert, before update) {
      for(Case c : trigger.new){
        if(String.isBlank(c.Reason)){
            c.Reason.addError('required field');
        }
      }
}