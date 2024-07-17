
@RestResource(urlMapping='/accountOperations/*')
global class WebServiceExample {
@HttpGet
    global static List<Account> getAccounts () {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response; 
    // String accountId = req. requestURI.substring(req.requestURI.lastIndex0f('/')+1);
    List<Account> result = [SELECT Id,Name, Phone, Website FROM Account];
    return result;
    }
@HttpPost
    global static String createAccount (String accountName, String accountPhone) {
    Account newAccount = new Account ();
    newAccount.Name = accountName;
    newAccount.Phone = accountPhone;
    try {
    insert newAccount;
    return 'Account created successfully with Id: ' + newAccount.Id;
    } catch (Exception e) {
    return 'Account creation failed. Error: ' + e.getMessage ();
    }
    }
}