    trigger NewHuntertrigger on Contact (after insert, after update) {
        if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
            List<Contact> newContacts = Trigger.new;
            Map<Id, Contact> oldContactsMap = Trigger.oldMap;
            NewRequestHunt.NewRequestHunt(newContacts, oldContactsMap);
        }
    }
    

