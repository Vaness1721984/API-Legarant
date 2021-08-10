@RestResource(urlMapping='/ContractSync/V1/*')
global with sharing class ContractSync {
        
  @HttpPost
    global static Id createNewContract(String Status, Id AccountId, Date StartDate, Integer ContractTerm) {

  Contract thisContract = new Contract(
            Status=Status,
             AccountId = AccountId,
            StartDate = StartDate,
            ContractTerm = ContractTerm);
                    insert thisContract;
                  return thisContract.Id;
    }

@HttpPut
global static Id updateContract(String Status, Id AccountId, Date StartDate, Integer ContractTerm){
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
Contract result = [SELECT Id FROM Contract WHERE Id = :id];
    Contract thisContract = new Contract(); 
    thisContract.Id = id;  
    thisContract.Status=Status;
    thisContract.AccountId=AccountId;
    thisContract.StartDate=StartDate;
    thisContract.ContractTerm=ContractTerm;
             update thisContract;
             return thisContract.Id;
}
}