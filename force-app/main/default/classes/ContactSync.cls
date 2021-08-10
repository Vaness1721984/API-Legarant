@RestResource(urlMapping='/ContactSync/V1/*')
global with sharing class ContactSync {
        
  @HttpPost
    global static Id createNewContact(String Salutation, String FirstName, String LastName, Date Birthdate,String Phone, String Email) {

    List<Contact> ctcList = [SELECT Id FROM Contact WHERE Email =: Email] ;
    Contact ctc = (ctcList != null&&ctcList.size()>0)?ctcList[0]:null;
        if (ctc != null) {
            return ctc.Id;
        }
        else{
  Contact thisContact = new Contact(
            Salutation=Salutation,
             FirstName = FirstName,
            LastName = LastName,
            Birthdate = Birthdate,
                 Phone = Phone,
                 Email = Email);
                    insert thisContact;
                  return thisContact.Id;
    }
}

@HttpPut
global static Id updateContact(String Salutation, String FirstName, String LastName, Date Birthdate, String Phone, String Email){
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
Contact result = [SELECT Id FROM Contact WHERE Id = :id];
    Contact thisContact = new Contact(); 
    thisContact.Id = id;  
    thisContact.Salutation=Salutation;
         thisContact.FirstName = FirstName;
        thisContact.LastName = LastName ;
        thisContact.Birthdate = Birthdate ;
             thisContact.Phone = Phone ;
             thisContact.Email = Email;
             update thisContact;
             return thisContact.Id;
}

@HttpPatch
global static Id deleteContact(){
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
Contact result = [SELECT Deactivated__c FROM Contact WHERE Id = :id];
    Contact thisContact = new Contact(); 
    thisContact.Id = id; 
    thisContact.Deactivated__c = true;  
             update thisContact;
             return thisContact.Id;
}


}