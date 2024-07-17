public class AccountSearchController {
    @AuraEnabled
    public static List<Account> getAccounts(String enteredkeyword){
        
        System.debug('---------------enteredkeyword-----------------'+enteredkeyword);
        List<String> paramsList = enteredkeyword.split(',');
        String accountName = '';
        String billingAddress = '';
        String postalCode = '';
        System.debug('---------------paramsList-----------------'+paramsList);
        
        for (String param : paramsList) {
            param = param.trim();
            if (!String.isEmpty(param)) {
                if (accountName == '') {
                    System.debug('-------------param---------------'+param);
                    accountName = param;
                } else if (billingAddress == '') {
                    System.debug('-------------param---------------'+param);
                    billingAddress = param;
                } else if (postalCode == '') {
                    System.debug('-------------param---------------'+param);
                    postalCode = param;
                }
            }
        }
        //SELECT Name, BillingCity FROM Account WHERE  Name LIKE '%brahma%' AND BillingCity LIKE '%amp%' 
        
        String query = 'SELECT Name, BillingCity, BillingPostalCode FROM Account WHERE ';
        
        if (!String.isEmpty(accountName)) {
            query += ' Name LIKE \'%' + accountName + '%\'';
        }
        if (!String.isEmpty(billingAddress)) {
            query += ' AND BillingCity LIKE \'%' + billingAddress + '%\'';
        }
        if (!String.isEmpty(postalCode)) {
            query += ' AND BillingPostalCode LIKE \'%' + postalCode + '%\'';
        }
        System.debug('-------------query---------------'+query);
        return Database.query(query);   
    }
    
}