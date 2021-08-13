@isTest
private class ContractSyncTest {
    @isTest static void testCreateNewContract() {
         // Call the method to test and add parameters
        Id thisContractId = ContractSync.createNewContract('Draft', '0010900000btFSLAA2', Date.valueOf('2022-01-01'), 24);
        // Retrieve Id & ContractTerm of the created Contract 
        Contract thisContract = [SELECT Id, ContractTerm FROM Contract WHERE Id =:thisContractId];
        // Verify the ContractTerm is equal to the created Contract
        System.assertEquals(thisContract.ContractTerm, 24);
    }

    @isTest static void testUpdateContract(){
         // Set up a test request
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/ContractSync/V1/' + recordId;
        request.httpMethod = 'PUT';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Status":"Activated"}');
        RestContext.request = request;
        // Update all fields of existing record (only Status has changed)
        Id thisContractId = ContractSync.updateContract('Activated', '0010900000btFSLAA2', Date.valueOf('2022-01-01') , 12);
        // Retrieve Id & Status of the updated Contract
        Contract thisContract = [SELECT Id, Status FROM Contract WHERE Id=:thisContractId];
        // Verify the Status is equal to the updated Contract
        System.assertEquals(thisContract.Status, 'Activated'); 
    }

    // Helper method
static Id CreateTestRecord(){
    // Create test record for Contract
    Contract contractTest = new Contract(
     Status = 'Draft',
     AccountId = '0010900000btFSLAA2',
     StartDate = Date.valueOf('2022-01-01'),
     ContractTerm = 12
        );
        insert contractTest;
        return contractTest.Id;
}
}
