@RestResource(urlMapping='/AccountSync/V1/*')
global with sharing class AccountSync {
        
  @HttpPost
    global static Id createNewAccount(String Name) {

  Account thisAccount = new Account(
             Name = Name);
                    insert thisAccount;
                  return thisAccount.Id;
    }

@HttpPut
global static Account updateAccount(String Name){
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
Account result = [SELECT Id FROM Account WHERE Id = :id];
    Account thisAccount = new Account(); 
    thisAccount.Id = id;  
    thisAccount.Name=Name;
             update thisAccount;
             return thisAccount;
}

@HttpDelete
global static String deleteAccount(){
    RestRequest request = RestContext.request;
String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
Account thisAccount = [SELECT Id FROM Account WHERE Id = :id];
             delete thisAccount;
             return 'The Account ' + thisAccount.Id + ' has been deleted';
}

    }