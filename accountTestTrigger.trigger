trigger accountTestTrigger on Account (before insert, before update) {
    
    List<Contact> contacts = [ Select Id, salutation, firstName, lastName, email, description from Contact where accountId IN :Trigger.New];
    
    for ( Contact C : contacts ){
        C.Description = C.salutation + ' ' + C.firstName + ' ' + C.lastName ;
    }
    
    update contacts;
}