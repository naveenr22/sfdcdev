/*trigger dupemaillncontactPrev on Contact (before insert, before update, after insert) {

  if (Trigger.isBefore) {
      if (Trigger.isInsert || Trigger.isUpdate) {
        //   trigcontactcls.createAccfornewConifnoCon(Trigger.new);
      }
  }
  else if (Trigger.isAfter) {
      if (Trigger.isInsert) {
          trigcontactcls.singleduplicprevconema(Trigger.new);
          trigcontactcls.restrictcreatingconta(Trigger.new);
      }
  }
}

trigger dupemaillncontactPrev on Contact (after insert , after update) {
  if(trigger.isAfter && trigger.isupdate){
    RequestHunt.RequestHunt(trigger.new,trigger.oldMap);
  }
}*/