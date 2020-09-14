public class ExecuteQueryController {

	public String queryStringToBeExecuted;		//query to be executed
    public String tempQuery;
    public list<string> fieldsOfRecord {get;set;}		//fields to be displayed
    public list<sObject> resultFetched {get;set;}		//all fetched record
    public boolean showResult {get;set;}		//a boolean variable used for result table rendering
    public boolean noRecords {get;set;}			//a boolean varible used for no record rendering
    public boolean checkFlag;
    public String sortExpression{		
    	get{
        	return sortExp;
        }
        set{
        	if (value == sortExp)
            	sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
            else
            	sortDirection = 'ASC';
                sortExp = value;
        }
    }
    private String sortDirection = 'ASC';
    private String sortExp = 'Id';
    public ApexPages.StandardSetController setController{get;set;}
    
    //data members for handling pagination
    Public Integer pageSize = 10;
    public Boolean hasPrevious{
       get{
           if(setController == null){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: '));
               return false;
           }
           else
           return setController.getHasPrevious();
       }
       set;
   	}
    public Boolean hasNext{
       get{
           if(setController == null){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: '));
               return false;
           }
           else
           return setController.getHasNext();
       }
       set;
   	}
    public Integer pageNumber{
       get{
           if(setController == null){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: '));
               return 1;
           }
           else
           return setController.getPageNumber();
       }
       set;
   	}
    public Integer getResultSize(){
        if(setController == null){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: '));
               return 1;
           }
           else
       return setController.getResultSize();
   	}
    public Integer getPageSize(){
        if(setController == null){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: '));
               return 1;
           }
           else
       return setController.getPageSize();
   	}
    
    
    //constructor
    public ExecuteQueryController() { 
    	showResult = false;
        noRecords = true;
        fieldsOfRecord = new List<String>();  
        tempQuery = '';
    }
    
    //getter setter
    public void setQueryStringToBeExecuted (String s) {
        queryStringToBeExecuted = s;
        if(queryStringToBeExecuted != tempQuery){
            setController = null;
        }
        runQuery();
  	}
    
  	public String getQueryStringToBeExecuted() {
    	return queryStringToBeExecuted;
  	} 
    
    public String getSortDirection(){
    	if (sortExpression == null || sortExpression == '')
        	return 'ASC';
        else
            return sortDirection;
    }
       
    public void setSortDirection(String value){  
    	sortDirection = value;
    }
    
   	//function for handling query
    public Boolean runQuery(){
    
        try{
            fieldsOfRecord.clear();
            if(setController == null){
                tempQuery = queryStringToBeExecuted;
                setController = new ApexPages.StandardSetController(Database.getQueryLocator(queryStringToBeExecuted));
        		setController.setPageSize(10);
        		resultFetched = setController.getRecords();
            } 
            
            if(resultFetched.size() == 0){
           		noRecords = true;
            }
            else{
                noRecords = false;
                Set<String> tempSetOfFields = (Set<String>)(resultFetched[0].getPopulatedFieldsAsMap().keySet());
                fieldsOfRecord = new List<String>(tempSetOfFields);
                sortExp = 'Id';
                sortDirection = 'ASC';
                system.debug(fieldsOfRecord);
            }
			showResult = true;
        } 
        catch(exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: ' + e));
        }
        
        return true;
	}
  
    private void setResultFetched(){
		resultFetched = setController.getRecords();
    }
    
	public void previous(){
    	setController.previous();
       	setResultFetched();
    }
   
    public void next(){
       system.debug(resultFetched);
       setController.next();
       setResultFetched();
       system.debug(resultFetched);
   }
   
    public void first() {
       setController.first();
       setResultFetched();
   }
   
    public void last() {
       setController.last();
       setResultFetched();
   }
        
    public void sortRecord(){
    	system.debug('I am in sorting '+queryStringToBeExecuted);
        queryStringToBeExecuted += ' ORDER BY ' +sortExpression  + ' ' + sortDirection;
        setController = new ApexPages.StandardSetController(Database.getQueryLocator(queryStringToBeExecuted));
        setController.setPageSize(10);
        resultFetched = setController.getRecords();
	}
}