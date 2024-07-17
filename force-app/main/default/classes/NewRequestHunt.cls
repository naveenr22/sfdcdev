    public class NewRequestHunt{
        public static void NewRequestHunt(List<Contact> listCon, Map<Id,Contact> oldMap){
            Set<Id> conIds = new Set<id> ();
            for (Contact con : listCon) {
                if(con.FirstName != oldMap.get (con.id).FirstName && con.LastName != oldMap.get (con.id) .LastName) {
                    conIds.add(con.Id);
                }
            }
            if(!system.isFuture()){
                NewRequestHunt(conIds);
                system.debug('ConIDs@@@@' +conIds);
            }
        }
        @future(callout = true)
        public static void NewRequestHunt(set<Id> conIds) {
            // 
            if(!conIds.isEmpty()){
                List<Contact> conRec = [SELECT Id, FirstName, LastName, Domain_Name__c FROM Contact WHERE Id = :conIds];
                Http ht = new Http();
                HttpRequest htReq = new HttpRequest();
                //https://api.hunter.io/v2/email-finder?domain=reddit.com&first_name=Alexis&last_name=Ohanian&api_key=ae55129fd27d2efce270c11759fc70522e62d2b0
                String endPointURL = 'https://api.hunter.io/v2/email-finder?domain='+conRec[0].Domain_Name__c;
                endPointURL+='&first_name='+conRec[0].FirstName;
                endPointURL+= '&last_name='+conRec[0].LastName;
                endPointURL+='&api_key='+Label.Hunter_Api;
                System.debug('endpointURL'+endPointURL );
                system.debug('COntact ID@@@@@' +conRec[0]);
                //Custom label -->
                htReq.setEndpoint(endPointURL); 
                htReq.setMethod('GET');
                HttpResponse htRes = ht.send (htReq) ;
                System.debug ('htRes :::::: '+htRes);
                if(htRes.getStatusCode() == 200){
                    String responseBody = htRes.getBody();
                    System.debug ('responseBody :::::' +responseBody);
                    
                    NewHunterWrapper ha = (NewHunterWrapper)System.JSON.deserialize(responseBody, NewHunterWrapper.class);
                    System.debug('HunterApex :::::'+ha.data.email);
                    
                    Contact tempc=new Contact(Id=conRec[0].id);
                    tempc.Email = ha.data.email;
                    update tempc;
                }
            }
        }
    }
