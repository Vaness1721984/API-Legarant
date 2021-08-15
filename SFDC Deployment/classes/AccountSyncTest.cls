@isTest
private class AccountSyncTest {
    @isTest static void testCreateNewAccount() {
        // Call the method to test and add a parameter 
ID thisAccountId = AccountSync.createNewAccount('Test123');
// Retrieve the name of the created Account 
Account thisAccount = [SELECT Name FROM Account WHERE Id =:thisAccountId];
// Verify the Name is equal to the created Account
System.assertEquals(thisAccount.Name, 'Test123');
    }

    @isTest static void testUpdateAccount() {
        // Set up a test request
Id recordId = createTestRecord();
RestRequest request = new RestRequest();
request.requestURI = 'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/AccountSync/V1/' + recordId;
request.httpMethod = 'PUT';
request.addHeader('Content-Type', 'application/json');
request.requestBody = Blob.valueOf('{"Name":"Test456"}');
RestContext.request = request;
// Update Name of existing record to 'Test456'
Id thisAccountId = AccountSync.updateAccount('Test456');
// Retrieve Name & Id of the updated Account
Account thisAccount = [SELECT Id,Name FROM Account WHERE Id=:thisAccountId];
// Verify the Name is equal to the updated Account
System.assertEquals(thisAccount.Name, 'Test456');
    }

    @isTest static void testDeleteAccount() {
     // Set up a test request    
Id recordId = CreateTestRecord();
RestRequest request = new RestRequest();
request.requestURI =  'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/AccountSync/V1/' + recordId;
request.httpMethod = 'GET';
RestContext.request = request;
 // Call the method to test
AccountSync.deleteAccount();
// Retrieve list of Ids after deletion
List<Account> Acc = [SELECT Id FROM Account WHERE Id =:recordId];
// Verify record is deleted i.e. list size is equal to zero
System.assert(acc.size() == 0);
    }

    // Helper method
static Id CreateTestRecord(){
    // Create test record for Account
    Account accountTest = new Account(
        Name = 'Test2021');
        insert accountTest;
        return accountTest.Id;
}

}
