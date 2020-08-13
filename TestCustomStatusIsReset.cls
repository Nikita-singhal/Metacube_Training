@isTest
private class TestCustomStatusIsReset {
	
    @isTest static void statusIsReset(){
    	Class__c newClass = new Class__c(Name = 'New Class', MaxSize__c = 10, Custom_Status__c = 'Open');
        insert newClass;
        List<Student__c> students = new List<Student__c>();
        for(Integer i=0;i<2;i++){
            students.add(new Student__c(Last_Name__c = 'New Student '+i ,sex__c = 'Male',Class__c = newClass.Id));
        }
        insert students;
        newClass.Custom_Status__c = 'Reset';
        Test.startTest();
        update newClass;
        Test.stopTest();
        System.assertEquals(0,[Select MyCount__c From Class__c where Id = :newClass.Id][0].MyCount__c);
        //System.assertEquals(0,[Select count() From Student__c where Class__c = :newClass.Id]);
    }
    
    /*@isTest static void statusIsNotReset(){
        
    }*/
}