public class StudentProcessor {
    
    public static List<Student__c> studentListByClass( Id classId ){
        List<Student__c> studentList = [ Select First_Name__c, Last_Name__c From Student__c where Class__r.Id = :classId ] ;
        return studentList ;
    }
    
    public static Map<Class__c,Set<Id>> classStudentMap(){
        Map<Class__c, Set<Id>> classList = new Map<Class__c, Set<Id>>() ;
        List<Class__c> classIdsList = [ Select Id From Class__c ] ;
        List<Student__c> studentList = [ Select Id From Student__c where Class__r.Id IN :ClassIdsList ] ;
        for( Class__c C :  classIdsList) {
            Set<Id> studentIds = new Set<Id>() ;
            for( Student__c S : studentList ) {
                if ( S.Class__c == C.Id ) {
                    studentIds.add(S.Id) ;
                }
            }
            classList.put(C, studentIds) ;
        }
        return classList ;
    }
}