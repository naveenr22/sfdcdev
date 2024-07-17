trigger Accountshiptobil on Account (before insert, before update, after insert, after update, after delete, after undelete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            accpunthandler.updateshipadress(Trigger.new);
            accpunthandler.statusOfRecord(Trigger.new, Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            accpunthandler.createContactCreation(Trigger.new);
            accpunthandler.createConOppCas(Trigger.new);
            accpunthandler.updateAllContacts(Trigger.new, Trigger.oldMap);
        }
        
        if (Trigger.isDelete) {
            accpunthandler.restrictdleacchavingmoreopp(Trigger.old);
            accpunthandler.avoiddelcontact(Trigger.old, Trigger.oldMap);
        }
    }
}
