trigger UpdateClassMyCount on Student__c (after insert) {
    List<Student__c> students = [Select Id, Class__r.MyCount__c From Student__c where Id IN :Trigger.New] ;
    for(Student__c S : students){
        Class__c newclass = S.Class__r ;
        newClass.MyCount__c += 1 ;
        update newClass ;
    }

    /*List<Class__c> classList = [SELECT Id, MyCount__c FROM Class__c];
    for ( Class__c C : classList ){
        C.MyCount__c = [Select count() from Student__c where class__c = :C.Id];
    }
    update classList;*/
}