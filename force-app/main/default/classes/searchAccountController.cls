
    public class searchAccountController{
        @AuraEnabled
        public static List<Account> getAccounts (String enteredkeyword) {
        String searchKey = enteredkeyword+ '%';
        List<Account> listAcc= [Select Id, Name, Industry, Phone from Account Where Name LIKE : searchKey];
        System.debug ('The list of Accounts are ***************YVYYY' +listAcc);
        return listAcc;
        
        }
        
        }
