@isTest
private class ContactSyncTest {
    @isTest static void testCreateNewContact() {
        Id thisContactId = ContactSync.createNewContact('Mr', 'John', 'Doe', Date.valueOf('1984-02-17'), '+331234567890', 'john.doe@gmail.com');
        Contact thisContact = [SELECT Id, Email FROM Contact WHERE Id =:thisContactId];
        System.assertEquals(thisContact.Email, 'john.doe@gmail.com');
    }

    @isTest static void testUpdateContact() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/ContactSync/V1/' + recordId;
        request.httpMethod = 'PUT';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Phone":"+411234567891"}');
        RestContext.request = request;
        Id thisContactId = ContactSync.updateContact('Mr','John', 'Doe', Date.valueOf('1984-02-17'), '+411234567891' ,'john.doe@gmail.com');
        Contact thisContact = [SELECT Id,Phone FROM Contact WHERE Id=:thisContactId];
        System.assertEquals(thisContact.Phone, '+411234567891');    
    }

    @isTest static void testDeleteContact() {
        Id recordId = CreateTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI =  'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/ContactSync/V1/' + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Deactivated__c" : "true"}');
        RestContext.request = request;
        Id thisContactId = ContactSync.deleteContact();
        Contact thisContact = [SELECT Id, Deactivated__c FROM Contact WHERE Id =:thisContactId];
        System.assertEquals(thisContact.Deactivated__c, true);
    }

// Helper method
static Id CreateTestRecord(){
    Contact contactTest = new Contact(
        Salutation = 'Mr',
        FirstName = 'John',
        LastName = 'Doe',
        Birthdate = Date.valueOf('1984-02-17'),
        Phone = '+331234567890',
        Email = 'john.doe@gmail.com'
        );
        insert contactTest;
        return contactTest.Id;
}

}
