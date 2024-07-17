public class testCallOutExmaple{
    public String instanceUrl;
    public String getAccessToken (){
        String clientId = '3MVG93inh8Bkz5nbsS2F1kT..lBIFMgfX02QJ45KzY93SdR84GqArj9tHORyPTn0NWzMIgFpZeMwngxmQ1ANv';
        String clientSecret = 'DE89385162BDA16BCF882136DA9BFD9EACA7C03D6954EF4E767ACE36960628E9';
        String username = 'naveenragam9908@gmail.com';
        String password = 'Sana@22331Do1TZsYzUauz0S7FFnLuTuQ';
        String reqbody = 'grant_type=password'+'&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        
        HttpRequest req = new HttpRequest ();
        req.setBody (reqbody);
        req.setMethod( 'POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token'); // Use 'https://test.salesforce.com/services/oauth2/token' for sandbox orgs
        Http h1 = new Http();
        HttpResponse res = h1.send (req);
        
        resWrapper response = (resWrapper) JSON.deserialize(res.getBody (), resWrapper.class);
        this.instanceUrl = response.instance_url; // Save the instance URL for later use
        return response.access_token;
    }
    public class resWrapper{
        public String id;
        public String instance_url;
        public String access_token;
    }

    public String fetchDataFromTargetEnvironment() {
        String endpointUrl = this.instanceUrl + '/services/data/v58.0/sobjects/Account/';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + getAccessToken());
        request.setHeader('Content-Type', 'application/json');
        
        Http ht = new Http();
        HttpResponse response = ht.send(request);
        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else {
            System.debug(response.getBody()); // Log the error details
            return 'Error: ' + response.getStatusCode() + ' - ' + response.getStatus();
        }
    }

    
    public String createDataInTargetEnvironment(String accountJson) {
        String endpointUrl = this.instanceUrl + '/services/data/v58.0/sobjects/Account/';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + getAccessToken());
        request.setHeader('Content-Type', 'application/json');
        request.setBody(accountJson);
        
        Http ht = new Http();
        HttpResponse response = ht.send(request);
        if (response.getStatusCode() == 201) { // HTTP 201 indicates the record was created successfully
            return response.getBody();
        } else {
            System.debug(response.getBody()); // Log the error details
            return 'Error: ' + response.getStatusCode() + '-' + response.getStatus();
        }
    }
}
