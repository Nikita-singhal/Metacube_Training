global class CreateNewContactFromEmail implements Messaging.InboundEmailHandler {
	
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
 
    	Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
        Messaging.InboundEmail.textAttachment tAttachment = email.textAttachments[0];
        String MyFile = tAttachment.body;
    	
    	// New Contact object to be created
        List<Contact> newContacts;
        
    	try {
            DomContactXMLDocument parseXML = new DomContactXMLDocument();
            newContacts = parseXML.parseResponseDom(MyFile);
      
            insert newContacts;       
    	}
    
   		catch (Exception e) {
       		System.debug('Exception arise -------- : ' + e);
   		}
   
   		result.success = true;
   
   		return result;
  	}
}