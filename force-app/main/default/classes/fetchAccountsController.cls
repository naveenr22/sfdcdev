public class fetchAccountsController {
    @AuraEnabled
    public static List<Account> fetchAccounts () {
    List<Account> listAcc = [SELECT Id, Name, Industry, Rating
    FROM Account LIMIT 20];
    return listAcc;
    }
    }