public class OpportunityStatusChangedEmailController {
    
	public void sendEmail(Id oppId)
        {
            Opportunity opp = [Select Id,Owner.Email from Opportunity where Id = :oppId];
            User owner = opp.Owner;
            List<String> toAddress = new List<String>();
            toAddress.add(owner.Email);
            //Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate('00X2w000000d99h', UserInfo.getUserId(), oppId);
            //mail.setTargetObjectId(UserInfo.getUserId()); 
            mail.setTemplateId('00X2w000000d99h'); 
      		mail.setToAddresses(toAddress); 
            mail.setBccSender(false); 
            mail.setUseSignature(false); 
            mail.setSenderDisplayName('Salesforce'); 
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
}