public class StudentDetailPDFController {
    
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                List<Student__c> studentList = [SELECT Id, Name, First_Name__c, Last_Name__c, Class__r.Name, Generate_PDF__c FROM Student__c];
        		con = new ApexPages.StandardSetController(studentList);
            }
            return con;
        }
        set;
    }
    
    // Initialize setCon and return a list of records
    public List<Student__c> getStudents() {
        return (List<Student__c>) con.getRecords();
    }
    
    public PageReference attachPDF(){
        Id stdId = ApexPages.currentPage().getParameters().get('stdId');
        PageReference studentPage = new PageReference('/'+ stdId);
        Student__c currentStudent = [Select Id,(Select Id from Attachments), Generate_PDF__c from Student__c where Id =:stdId];
        List<Attachment> currentAttachment = currentStudent.Attachments;
        if(currentAttachment.size() > 0)
            delete currentAttachment;
   
        PageReference PDFPage = Page.StudentDetailsPDF;
        PDFPage.getParameters().put('id',currentStudent.Id);
        Blob pageBlob = PDFPage.getContent();
        Attachment attachPDFFile = new Attachment();
        attachPDFFile.Body = pageBlob;
        attachPDFFile.parentId = stdId;
        attachPDFFile.Name = stdId + '.pdf';
        insert attachPDFFile;
        return studentPage;
    }
    
}