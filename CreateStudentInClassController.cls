public class CreateStudentInClassController {
	private final Class__c currentClass;
    public String studentName{get;set;}
    
    public CreateStudentInClassController(ApexPages.StandardController stdController) {
        this.currentClass = (Class__c)stdController.getRecord();
    }
    
    public void createNewStudent(){
        String fname = studentName.substringBefore(' ');
        String lname = studentName.substringAfter(' ');
        Student__c newStudent = new Student__c( Name = studentName ,First_Name__c = fname , Last_Name__c = lname , class__c = currentClass.Id );
        insert newStudent;
        studentName = null;
    }
}