public class Salesforce2Integ {
    // Replace these with your actual values
    static final String CLIENT_ID = '3MVG93inh8Bkz5nbsS2F1kT..lBIFMgfX02QJ45KzY93SdR84GqArj9tHORyPTn0NWzMIgFpZeMwngxmQ1ANv';
    static final String CLIENT_SECRET = 'DE89385162BDA16BCF882136DA9BFD9EACA7C03D6954EF4E767ACE36960628E9';
    static final String USERNAME = 'naveenragam9908@gmail.com';
    static final String PASSWORD = 'Sana@22331Do1TZsYzUauz0S7FFnLuTuQ';
    static final String ENDPOINT = 'https://login.salesforce.com'; // Change to https://test.salesforce.com for a sandbox

    public class AuthenticationResponse {
        public String access_token;
        public String instance_url;
    }

    public static String getAccessToken() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(ENDPOINT + '/services/oauth2/token');
        request.setMethod('POST');
        String credentials = 'grant_type=password' +
                            '&client_id=' + CLIENT_ID +
                            '&client_secret=' + CLIENT_SECRET +
                            '&username=' + USERNAME +
                            '&password=' + PASSWORD;

        request.setBody(credentials);

        HttpResponse response = http.send(request);
        AuthenticationResponse authResponse = (AuthenticationResponse) JSON.deserialize(response.getBody(), AuthenticationResponse.class);

        return authResponse.access_token;
    }

    public static List<Account> getAccounts() {
        String accessToken = getAccessToken();
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setEndpoint(ENDPOINT + '/services/data/v52.0/query/?q=SELECT+Name,Id+FROM+Account+LIMIT+10');
        request.setMethod('GET');
    
        HttpResponse response = http.send(request);
    
        // Parse the JSON response
        Map<String, Object> resultsMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> records = (List<Object>) resultsMap.get('records');
    
        List<Account> accounts = new List<Account>();
        for (Object recordObj : records) {
            Map<String, Object> recordMap = (Map<String, Object>) recordObj;
            Account a = new Account();
            a.Id = (Id) recordMap.get('Id');
            a.Name = (String) recordMap.get('Name');
            accounts.add(a);
        }
    
        return accounts;
    }
    

    public static void postAccount() {
        String accessToken = getAccessToken();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(ENDPOINT + '/services/data/v52.0/sobjects/Account/');
        request.setMethod('POST');
        request.setBody('{"Name" : "Test Account from Org1"}');

        HttpResponse response = http.send(request);
        // Check the response status and take the necessary action
    }

    public static void patchAccount(Id accountId) {
        String accessToken = getAccessToken();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(ENDPOINT + '/services/data/v52.0/sobjects/Account/' + accountId + '?_HttpMethod=PATCH');
        request.setMethod('POST');
        request.setBody('{"Name" : "Updated Test Account from Org1"}');

        HttpResponse response = http.send(request);
        // Check the response status and take the necessary action
    }
}
