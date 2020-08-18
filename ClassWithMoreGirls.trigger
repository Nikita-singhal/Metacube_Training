trigger ClassWithMoreGirls on Class__c (before delete) {
	List<Class__c> classes = Trigger.Old;
    List<Student__c> students = [Select Id, sex__c, Class__c from Student__c Where Class__c IN :classes];
    for(Class__c C : classes){
        Integer count=0 ;
        for(Student__c S : students){
            if(S.Class__c==C.Id && S.Sex__c=='Female')
                count++ ;
        }
        if(count>1)
            C.addError('Class with more than 1 female student is not allowed to be deleted') ;
    }
}