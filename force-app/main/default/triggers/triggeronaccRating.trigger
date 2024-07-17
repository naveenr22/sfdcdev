trigger triggeronaccRating on Contact (before insert,before update) {

    If(trigger.isBefore&&trigger.isUpdate){
        trigcontactcls.accratactr(Trigger.New);
    }

}