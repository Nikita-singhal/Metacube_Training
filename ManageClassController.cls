public class ManageClassController {
    
    public Class__c classSelected{get;set;}
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                setCon();
            }
            return con;
        }
        set;
    }
 
    public void setCon(){
        List<Class__c> classList = [SELECT Id, Name, ClassTeacher__r.Name, Fee__c FROM Class__c];
        con = new ApexPages.StandardSetController(classList);
    }
    
    // Initialize setCon and return a list of records
    public List<Class__c> getClasses() {
        return (List<Class__c>) con.getRecords();
    }
    
    public void deleteClass(){
        Id classId = ApexPages.currentPage().getParameters().get('classToBeDeleted');
        classSelected = [ Select Id from Class__c where Id =: classId ];
        delete classSelected;
        classSelected = null;
        setCon();
    }
    
    public void editClassData(){
        Id classId = ApexPages.currentPage().getParameters().get('classToBeEdited');
        classSelected = [ Select Id, Name, MaxSize__c, Board__c, Fee__c, ClassTeacher__c from Class__c where Id =: classId ];
        
    }
    
    public void save(){
        update classSelected;
        classSelected = null;
        setCon();
    }
}