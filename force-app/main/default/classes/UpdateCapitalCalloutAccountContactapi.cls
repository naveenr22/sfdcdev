    
    public class UpdateCapitalCalloutAccountContactapi {
        @future(callout = true)
        public static void updateCapitalField(List<String> countryNames) {
            String endpoint = 'http://api.countrylayer.com/v2/name/';
            String accessKey = Label.Countrylayer_Api; // Better to store it in Custom Settings/Metadata
            
            for (String country : countryNames) {
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(endpoint + country + '?access_key=' + accessKey);
                request.setMethod('GET');
                HttpResponse response = http.send(request);
    
                if (response.getStatusCode() == 200) {
                    List<CountryResponse> countries = (List<CountryResponse>) JSON.deserialize(response.getBody(), List<CountryResponse>.class);
                    if (!countries.isEmpty()) {
                        updateAccounts(country, countries[0].capital);
                    }
                }
        }
        }
        private static void updateAccounts(String countryName, String capital) {
            List<Account> accountsToUpdate = [SELECT Id, Capital__c FROM Account WHERE BillingCountry = :countryName];
            for (Account acc : accountsToUpdate) {
                acc.Capital__c = capital;
            }
            update accountsToUpdate;
        }
    

        
    }