@isTest
public class SendContactEmailWithXML {
	
    @isTest static void testNewContactFromEmail(){
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
        email.subject = 'Check Email Service';
        env.fromAddress = 'nikitasinghalmitrc@gmail.com';
        System.debug('from address ----------------' + env.fromAddress + ' -------------------');
        Messaging.InboundEmail.TextAttachment txtAttachment = new Messaging.InboundEmail.TextAttachment();
        txtAttachment.body = '<?xml version="1.0" encoding="UTF-8"?>\n'+
            					'<contacts>\n'+	
            						'<contact>\n' + 
            							'<fname>Pinky</fname>\n' + 
            							'<lname>Singhal</lname>\n' +
        								'<mobile>6657876545</mobile>\n' + 
            							'<department>Production</department>\n' +
        								'<birthdate>10/8/1976</birthdate>\n' + 
            					'</contact>\n' +
    							'<contact>\n' + 
            						'<fname>Pradeep</fname>\n' + 
            						'<lname>Singhal</lname>\n' + 
            						'<mobile>6787654567</mobile>\n' + 
            						'<department>Technology</department>\n' + 
            						'<birthdate>1/6/1970</birthdate>\n' + 
            						'</contact>\n' + 
            					'</contacts>';
        txtAttachment.fileName = 'contacts.xml' ;
        txtAttachment.mimeTypeSubType = 'text/xml';
        System.debug('New attachment created------------------------------');
        
        email.textAttachments = new Messaging.InboundEmail.TextAttachment[]{txtAttachment};
           
        System.debug('test starting--------------------------------------------');
        CreateNewContactFromEmail addContactsCheck = new CreateNewContactFromEmail();
        Messaging.InboundEmailResult result = addContactsCheck.handleInboundEmail(email, env);
        System.debug('test finished--------------------------------------------');
        
        System.assertEquals(1, [select count() from Contact Where FirstName = 'Pinky']);
       	System.assertEquals(1, [select count() from Contact Where FirstName = 'Pradeep']);
    }
}