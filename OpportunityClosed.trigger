trigger OpportunityClosed on Opportunity (after update) {
	List<Opportunity> opportunities = [Select Id,StageName,CloseDate From Opportunity where Id IN :Trigger.New];
    for(Opportunity O : opportunities){
        if(O.StageName == 'Closed Won' || O.StageName == 'Closed Lost'){
            O.CloseDate = Date.today();
        }
    }
}