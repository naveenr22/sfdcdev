trigger accountrattrig on Contact (before insert) {
    if(trigger.isBefore){
     trigcontactcls.accratactr(trigger.new);
    }
}