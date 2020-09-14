public class OpportunityBillToContactController {
    
	private final Opportunity opp;
    public String contactToBeAdded{get;set;}
    public List<Contact> relatedContacts {
        get {
            return [Select Id, Name, Title from Contact where Account.Id = :opp.Manager__c];
        }
        set;
    }
    
    public OpportunityBillToContactController (ApexPages.StandardController stdController) {
        this.opp = (Opportunity)stdController.getRecord();
    }
    
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>(); 
        for(Contact C : relatedContacts){
            options.add(new SelectOption(C.Id, 'Name : ' + C.Name + '\nTitle : ' + C.Title ));
        }
        return options; 
	}
    
    /*public void getSelected(){
        contactToBeAdded = ApexPages.currentPage().getParameters().get('contactId');
        System.debug('contact : '+contactToBeAdded);
    }*/
    
    public PageReference saveContactToBill(){
        opp.BillToContact__c = contactToBeAdded;
        update opp;
        return returnToOpp();
    }
    
    public PageReference clearContactToBill(){
        opp.BillToContact__c = null;
        update opp;
        return returnToOpp();
    }
     
    public PageReference returnToOpp(){
        PageReference result = new PageReference('/'+ opp.Id);
        return result;
    }
}