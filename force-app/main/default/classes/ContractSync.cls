@RestResource(urlMapping='/ContractSync/V1/*')
global with sharing class ContractSync {
        
  @HttpPost
    global static Id createNewContract(String Status, Id AccountId, Date StartDate, Integer ContractTerm) {
// Creation of a new Contract
  Contract thisContract = new Contract(
            Status=Status,
             AccountId = AccountId,
            StartDate = StartDate,
            ContractTerm = ContractTerm);
                    insert thisContract;
                    // Return the Contract Id
                  return thisContract.Id;
    }

@HttpPut
global static Id updateContract(String Status, Id AccountId, Date StartDate, Integer ContractTerm){
  // Add the Contract Id as a parameter in the URL
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
// Retrieve the Contract based on the Id
Contract result = [SELECT Id FROM Contract WHERE Id = :id];
    Contract thisContract = new Contract(); 
    thisContract.Id = id;  
    thisContract.Status=Status;
    thisContract.AccountId=AccountId;
    thisContract.StartDate=StartDate;
    thisContract.ContractTerm=ContractTerm;
    // Update the fields Status, ..., ContractTerm on the Account 
             update thisContract;
              // Return the Contract Id
             return thisContract.Id;
}
}