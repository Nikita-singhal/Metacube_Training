trigger OpportunityStatusChange on Opportunity (After update) {
	Map<Id,Opportunity> newOppMap = Trigger.NewMap;
    Map<Id,Opportunity> oldOppMap = Trigger.OldMap;
    
    for ( Id key : newOppMap.keySet()) {
        if( newOppMap.get(key).StageName != oldOppMap.get(key).StageName ){
            OpportunityStatusChangedEmailController sendMail = new OpportunityStatusChangedEmailController();
            sendMail.sendEmail(key);
        }
    }
}