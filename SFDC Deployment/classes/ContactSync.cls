@RestResource(urlMapping='/ContactSync/V1/*')
global with sharing class ContactSync {
        
  @HttpPost
    global static Id createNewContact(String Salutation, String FirstName, String LastName, Date Birthdate,String Phone, String Email) {
// Retrieve list of Contacts based on Email
    List<Contact> ctcList = [SELECT Id FROM Contact WHERE Email =: Email] ;
    // Condition if list is not empty i.e. email exists in SFDC
    Contact ctc = (ctcList != null&&ctcList.size()>0)?ctcList[0]:null;
        if (ctc != null) {
            // Return the Contact Id
            return ctc.Id;
        }
        // Condition if list is empty i.e. email doesn't exist in SFDC
        else{
            // Creation of a new Contact
  Contact thisContact = new Contact(
            Salutation=Salutation,
             FirstName = FirstName,
            LastName = LastName,
            Birthdate = Birthdate,
                 Phone = Phone,
                 Email = Email);
                    insert thisContact;
                    // Return the Contact Id
                  return thisContact.Id;
    }
}

@HttpPut
global static Id updateContact(String Salutation, String FirstName, String LastName, Date Birthdate, String Phone, String Email){
    // Add the Contact Id as a parameter in the URL
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
// Retrieve the Contact based on the Id
Contact result = [SELECT Id FROM Contact WHERE Id = :id];
    Contact thisContact = new Contact(); 
    thisContact.Id = id;  
    thisContact.Salutation=Salutation;
         thisContact.FirstName = FirstName;
        thisContact.LastName = LastName ;
        thisContact.Birthdate = Birthdate ;
             thisContact.Phone = Phone ;
             thisContact.Email = Email;
             // Update the fields Salutation, ..., Email on the Contact
             update thisContact;
             // Return the Contact Id
             return thisContact.Id;
}

@HttpPatch
global static Id deleteContact(){
    // Add the Contact Id as a parameter in the URL
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
// Retrieve value of Deactivated__c field based on the Id
Contact result = [SELECT Deactivated__c FROM Contact WHERE Id = :id];
    Contact thisContact = new Contact(); 
    thisContact.Id = id; 
    thisContact.Deactivated__c = true;  
    // Update field Deactivated__c to true on the Contact
             update thisContact;
             // Return the Contact Id
             return thisContact.Id;
}


}