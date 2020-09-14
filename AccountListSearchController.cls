public class AccountListSearchController {
    
    public Account acc{get;set;}
    
    List<String> conditions = new List<String>();
    
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                List<Account> accounts = [SELECT Name, BillingCity, BillingState, BillingCountry From Account];
                con = new ApexPages.StandardSetController(accounts);
                this.con.setPageSize(pageSize);
            }
            return con;
        }
        set;
    }
    
    public Integer pageSize {
        get;set;
    }
    
    public Integer pageNumber {
        get {
          	return con.getPageNumber();
        }
        set;
    }
    
    public boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
    
    public boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
    
    public Integer resultSize {
        get {
            return con.getResultSize();
        }
        set;
    }
    
    public AccountListSearchController(){
		acc = new Account();
        pageSize = 10;
    }
    
    public void filteredSearch(){
        
        conditions.clear();
        String strQuery = 'SELECT Name, BillingCity, BillingState, BillingCountry From Account';
        
		if(acc.BillingCity != null){
   			conditions.add('BillingCity = \'' + acc.BillingCity + '\'');
 		}
        if(acc.BillingState != null){
   			conditions.add('BillingState = \'' + acc.BillingState + '\'');
 		}
        if(acc.BillingCountry != null){
   			conditions.add('BillingCountry = \'' + acc.BillingCountry + '\'');
 		}	
        if (conditions.size() > 0) {
   			strQuery += '  WHERE ' + conditions[0];
   			for (Integer i = 1; i < conditions.size(); i++)
        	strQuery += '  AND ' + conditions[i];
  		}
        con = new ApexPages.StandardSetController(Database.getQueryLocator(strQuery));
                this.con.setPageSize(PageSize);
    }
    
    // Initialize setCon and return a list of records
    public List<Account> getAccounts() {
        List<Account> completeResultSet = con.getRecords();
        return completeResultSet;
    }
    
    public void first(){
		con.first();
    }
    
    public void last(){
		con.last();
    }

    public void previous(){
		con.previous();
    }

    public void next(){
		con.next();
    }


}