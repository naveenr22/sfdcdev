trigger triggeronCountofContacts on Contact (before insert, after insert, after update, after delete, after undelete) {
    Set<Id> accIds = new Set<Id>();

    if(trigger.isBefore && trigger.isInsert) {
        for(Contact con : trigger.new){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
    }
    else if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete || trigger.isDelete)){
        for(Contact con : (trigger.isDelete ? trigger.old : trigger.new)){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
    }
    else if(trigger.isUpdate){
        for(Contact con: Trigger.new){
            if(con.AccountId != Trigger.oldMap.get(con.Id).AccountId){
                accIds.add(con.AccountId);
                accIds.add(Trigger.oldMap.get(con.Id).AccountId);
            }
        }
    }

    if(!accIds.isEmpty()){
        FutureMethodforCountofContacts.updateAccountContactCount(accIds);
    }
}
