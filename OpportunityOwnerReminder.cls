public class OpportunityOwnerReminder implements Schedulable{
	
    public void execute(SchedulableContext ctx){
        Date lastDate = Date.today()-30;
        List<Opportunity> opportunity = [Select Id,OwnerId From Opportunity where LastModifiedDate < :lastDate];
        for(Opportunity O : opportunity){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {};
        	toAddresses[0] = [Select SenderEmail From User where Id = :O.OwnerId].toString();
			mail.setToAddresses(toAddresses);
			mail.setSenderDisplayName('Salesforce Support');
			mail.setSubject('Reminder for Updating Opportunity');
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
    }
}