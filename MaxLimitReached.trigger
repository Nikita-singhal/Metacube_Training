trigger MaxLimitReached on Student__c (before insert) {
    
    Student__c S = Trigger.New[0];
    Decimal noOfStudents = [Select count() from Student__c where Class__c = :S.Class__c];
    Decimal classMaxSize = [Select MaxSize__c from Class__c where Id = :S.Class__c][0].MaxSize__c; 
    if(noOfStudents == classMaxSize){
        S.addError('The Max limit of class '+S.Class__c+' has reached');
    }
}