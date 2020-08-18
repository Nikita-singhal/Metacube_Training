trigger CustomStatusIsReset on Class__c (after update) {
	List<Class__c> classes = [Select Id, MyCount__c From Class__c where Id IN :Trigger.New AND Custom_Status__c = 'Reset'];
	List<Class__c> classList = new List<Class__c>();
	for ( Class__c C : classes ){
		if (Trigger.oldMap.get(C.Id).Custom_status__c != 'Reset')
			classList.add(C);
	} 
    List<Student__c> students = [Select Id From Student__c where Class__c IN :classList];
    
    if(students.size()>0)
    	delete students;
    
}