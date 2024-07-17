public with sharing class SendRequestToHunter {
    public class SendRequestToHunter{
        public static void SendRequestToHunter(List<Contact> listCon, Map<Id,Contact> oldMap){
        List<Id> conIds = new List<id> ();
        for (Contact con : listCon) {
            if(con.FirstName != oldMap.get (con.id).FirstName && con.LastName != oldMap.get (con.id) .LastName) {
                conIds.add(con.Id);
            }
        }
        SendRequestToHunter(conIds [0]);
    }
    @future(callout = true)
    public static void SendRequestToHunter(Id conIds) {
        Contact conRec = [SELECT Id, FirstName, LastName, Domain_Name__c FROM Contact WHERE Id = :conIds];
        Http ht = new Http();
        HttpRequest htReq = new HttpRequest();
        //https://api.hunter.io/v2/email-finder?domain=reddit.com&first_name=Alexis&last_name=Ohanian&api_key=ae55129fd27d2efce270c11759fc70522e62d2b0
        String endPointURL = 'https://api.hunter.io/v2/email-finder?domain='+conRec.Domain_Name__c+'&first_name='+conRec.FirstName;
        endPointURL+= '&last_name='+conRec.LastName+'&api_key='+Label.Hunter_API;
        //Custom label -->
        htReq.setEndpoint (endPointURL); htReq.setMethod ('GET');
        HttpResponse htRes = ht.send (htReq) ;
        System.debug ('htRes :::::: '+htRes);
        if(htRes.getStatusCode() == 200){
            String responseBody = htRes.getBody();
            System.debug ('responseBody :::::' +responseBody);
            HunterApex ha = (HunterApex)System.JSON.deserialize(responseBody, HunterApex.class);
            System.debug ('HunterApex :::::'+ha.data.email);
            conRec.Email = ha.data.email;
            update conRec;
           }
    }
    }
}