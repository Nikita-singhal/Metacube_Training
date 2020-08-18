public class AccountContactIdAdder {
    public static void addContactId(Id contactId){
        Contact contact = [Select AccountId From Contact Where Id = :contactId];
        Account account = [Select Id, ContactIds__c From Account Where Id = :contact.AccountId Limit 1];
        List<Contact> contactIdList = [Select Id From Contact Where AccountId = :account.Id];
        String contactIds;
        for(Contact C : contactIdList){
            if(account.ContactIds__c.contains(C.Id) == False){
                contactIds = contactIds + C.Id + ', ' ;
                
            }
        }
        account.ContactIds__c = account.ContactIds__c + contactIds;
        update account;
        /*if(account.ContactIds__c == NULL){
            String contactIds;
            for(Contact C : contactIdList){
                contactIds = contactIds + C.Id + ', ';
            }
            account.ContactIds__c = contactIds;
            update account;
        }
        
        else{
            for(Contact C : contactIdList){
                if(account.ContactIds__c.contains(C.Id) == False){
                    account.ContactIds__c = account.ContactIds__c + C.Id + ', ';
                    update account;
                }
            }
            
        }*/
    }
}