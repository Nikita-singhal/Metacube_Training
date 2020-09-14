public class ExecuteQueryPageController {

    Public String query{get;set;}
    public boolean showQueryResult{get;set;}
    
    Public ExecuteQueryPageController(){
        showQueryResult = false;
        query = '';
    }
    
    Public void passQuery(){
        showQueryResult = true;
        system.debug('Query to execute : ' + query);
    }
}