@isTest
private class ContractSyncTest {
    @isTest static void testCreateNewContract() {
        Id thisContractId = ContractSync.createNewContract('Draft', '0010900000btFSLAA2', Date.valueOf('2022-01-01'), 24);
        Contract thisContract = [SELECT Id, ContractTerm FROM Contract WHERE Id =:thisContractId];
        System.assertEquals(thisContract.ContractTerm, 24);
    }

    @isTest static void testUpdateContract(){
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://legarant7-dev-ed.my.salesforce.com/services/apexrest/ContractSync/V1/' + recordId;
        request.httpMethod = 'PUT';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Status":"Activated"}');
        RestContext.request = request;
        Id thisContractId = ContractSync.updateContract('Activated', '0010900000btFSLAA2', Date.valueOf('2022-01-01') , 12);
        Contract thisContract = [SELECT Id, Status FROM Contract WHERE Id=:thisContractId];
        System.assertEquals(thisContract.Status, 'Activated'); 
    }

    // Helper method
static Id CreateTestRecord(){
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
