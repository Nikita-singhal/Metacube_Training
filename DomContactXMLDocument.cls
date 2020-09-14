public class DomContactXMLDocument {
 
    public List<Contact> parseResponseDom(String file){
        
        Dom.Document doc = new Dom.Document();
        doc.load(file);
       
        //Retrieve the root element for this document.
        Dom.XMLNode contacts = doc.getRootElement();
        List<Dom.XMLNode> contactList = contacts.getChildElements();
        
        List<Contact> contactsToBeInserted = new List<Contact>();
        
        for(Dom.XMLNode C : contactList){
            
            String firstName = C.getChildElement('fname', null).getText();
            String lastName = C.getChildElement('lname', null).getText();
            String mobileNum = C.getChildElement('mobile', null).getText();
            String department = C.getChildElement('department', null).getText();
            String birthDate = C.getChildElement('birthdate', null).getText();
            
            contactsToBeInserted.add(new Contact(FirstName = firstName, LastName = lastName, MobilePhone = mobileNum, 
                                                 Department = department, Birthdate = Date.parse(birthDate) ));
        }
        return contactsToBeInserted; 
    }
}