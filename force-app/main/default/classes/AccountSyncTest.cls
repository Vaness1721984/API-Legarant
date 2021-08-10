@isTest
private class AccountSyncTest {
    @isTest static void testCreateNewAccount() {
ID thisAccountId = AccountSync.createNewAccount('Test123');
Account thisAccount = [SELECT Name FROM Account WHERE Id =:thisAccountId];
System.assertEquals(thisAccount.Name, 'Test123');
    }

    @isTest static void testUpdateAccount() {
Id recordId = createTestRecord();
RestRequest request = new RestRequest();
request.requestURI = 'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/AccountSync/V1/' + recordId;
request.httpMethod = 'PUT';
request.addHeader('Content-Type', 'application/json');
request.requestBody = Blob.valueOf('{"Name":"Test456"}');
RestContext.request = request;
Id thisAccountId = AccountSync.updateAccount('Test456');
Account thisAccount = [SELECT Id,Name FROM Account WHERE Id=:thisAccountId];
System.assertEquals(thisAccount.Name, 'Test456');
    }

    @isTest static void testDeleteAccount() {
Id recordId = CreateTestRecord();
RestRequest request = new RestRequest();
request.requestURI =  'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/AccountSync/V1/' + recordId;
request.httpMethod = 'GET';
RestContext.request = request;
AccountSync.deleteAccount();
List<Account> Acc = [SELECT Id FROM Account WHERE Id =:recordId];
System.assert(acc.size() == 0);
    }

    // Helper method
static Id CreateTestRecord(){
    Account accountTest = new Account(
        Name = 'Test2021');
        insert accountTest;
        return accountTest.Id;
}

}
