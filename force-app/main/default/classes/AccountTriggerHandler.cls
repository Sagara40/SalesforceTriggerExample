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

    //Whenever an Account’s Website field is updated, 
    //automatically update the Website field on 
    //all related child Contacts to match the new Account website.

    public static void updateWebsiteOnRelatedContacts(List<Account> AccountList, Map<Id, Account> oldMap) {
        Map<Id,String> accoountToWebsiteMap = new Map<Id,String>();
        for(Account acc : AccountList) {
            if(acc.Website != null && acc.Website != oldMap.get(acc.Id).Website ) {
                accoountToWebsiteMap.put(acc.Id,acc.Website);
            }
        }
        List<Contact> contactList = [SELECT Id, AccountId, Website__c FROM Contact WHERE AccountId IN :accoountToWebsiteMap.keySet()];

        for(Contact con : contactList) {
            con.Website__c = accoountToWebsiteMap.get(con.AccountId);
        }
        if(!contactList.isEmpty()) {
            update contactList;
        }
    }
}