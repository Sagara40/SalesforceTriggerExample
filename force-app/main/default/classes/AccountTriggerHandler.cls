public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {
        //constructor
    }
    //Whenever an Account record is created or updated, check the following conditions:
    //Industry = Banking
    //Type = Prospect
    //Ownership = Private
    //If all these conditions are met, prevent the user from setting Ownership as Private by 
    //adding an error message to ensure proper compliance with business data rules.

    public static void preventAccountCreationWithPrivateOwnership(List<Account> accountList) {
        for(Account acc : accountList) {
            if(acc.Industry == 'Banking' && acc.Type == 'Prospect' && acc.Ownership == 'Private') {
                acc.addError('Ownership cannot be set to Private for Banking Prospect Accounts');
            }
        }
    }
}