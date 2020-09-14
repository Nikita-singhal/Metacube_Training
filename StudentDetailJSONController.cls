public class StudentDetailJSONController {
    
    private final Student__c student;
    public String JSONString {get;set;}
    
	public StudentDetailJSONController (ApexPages.StandardController stdController) {
        this.student = (Student__c)stdController.getRecord();
    }
    
    public void convertToJSON(){
		JSONString = JSON.serializePretty(student);
    }
}