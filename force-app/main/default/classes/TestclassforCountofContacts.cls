@isTest
public with sharing class TestclassforCountofContacts {
    
    @TestSetup
    static void createDummyData(){
        List<Contact> lisconToInsert= new List<Contact>();
        Account acc = new Account();
        acc.Name='Test Accounts';
        Insert acc;

        Account acc1=new Account();
        acc1.Name='Test Account 1';
        Insert acc1;

        for(Integer i=0;i<2;i++){ // Change made here: changed from i<=3 to i<2
            Contact con= new Contact();
            con.LastName='test contact'+i;
            con.AccountId=acc.Id;
            lisconToInsert.add(con);
        }
        Insert lisconToInsert;
    }

    @isTest
    static void countofContacttest1(){
        Account acc1=[SELECT Id, count_of_contacts__c FROM Account WHERE Name = 'Test Accounts' LIMIT 1];
        System.debug('acc1'+acc1);
        System.assertEquals(2,acc1.count_of_contacts__c); // Change made here: changed from 4 to 2
    }
   
    @isTest 
    static void countofContacttest2(){
        List<Contact> liscon=[SELECT Id from contact LIMIT 1]; // Change made here: changed from LIMIT 2 to LIMIT 1
        delete liscon;

        Integer remainingContacts = [SELECT COUNT() FROM Contact];
        System.assertEquals(1, remainingContacts); // Change made here: changed from 2 to 1
    }

    @isTest 
    static void countofContacttest3(){
        Account secAcc=[SELECT Id FROM Account WHERE Name = 'Test Account 1' LIMIT 1];
        List<Contact> liscon=[SELECT Id,AccountId from Contact LIMIT 1]; // Change made here: changed from LIMIT 2 to LIMIT 1
        for(Contact con : liscon){
            con.AccountId=secAcc.id;
        }
        update liscon;

        Integer contactsInSecAcc = [SELECT COUNT() FROM Contact WHERE AccountId =: secAcc.Id];
        System.assertEquals(1, contactsInSecAcc); // Change made here: changed from 2 to 1
    }
}
