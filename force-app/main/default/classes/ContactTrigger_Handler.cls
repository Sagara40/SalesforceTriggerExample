public with sharing class ContactTrigger_Handler {
    public ContactTrigger_Handler() {

    }
    //Whenever a Contact record is created, check if it has a Parent Account associated:
    //If no Parent Account is provided, prevent the Contact record from being created by adding an 
    //Error message to the user.

    public static void preventContactCreationWithoutParentAccount(List<Contact> contactList) {
        for(Contact con : contactList) {
            if(con.AccountId == null) {
                con.addError('Parent Account is required');
            }
        }
    }

    //Whenever a new Contact record is being created, check if there already exists a Contact with the same:
    //Last Name || Email || Phone
    public static void preventDuplicateContactCreation(List<Contact> contactList) {
        Set<String> lastNameSet = new Set<String>();
        Set<String> emailSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        for(Contact con : contactList) {
            lastNameSet.add(con.LastName);
            emailSet.add(con.Email);
            phoneSet.add(con.Phone);
        }
        List<Contact> existingContactList = [SELECT Id, LastName, Email, Phone FROM Contact WHERE LastName IN :lastNameSet AND Email IN :emailSet AND Phone IN :phoneSet];
        for(Contact con : contactList) {
            for(Contact existingCon : existingContactList) {
                if(con.LastName == existingCon.LastName || con.Email == existingCon.Email || con.Phone == existingCon.Phone) {
                    con.addError('Duplicate Contact found');
                }
            }
        }
    }
}