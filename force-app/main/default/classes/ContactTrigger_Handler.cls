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
}