trigger TeacherTeachesHindi on Teach__c (before insert,before update) {
    for(Teach__c teacher : Trigger.New){
        if(teacher.Subject__c.contains('Hindi')){
        	teacher.addError('Hindi teachers are not allowed');
    	}
    }
    
}