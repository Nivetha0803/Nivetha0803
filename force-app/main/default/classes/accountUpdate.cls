public class accountUpdate {
 public  void updateAccount(string accname,string accnumber)
 {
     try{
         Account acc=[SELECT Id,Name,AccountNumber FROM Account WHERE Name =: accname];
         acc.AccountNumber = accnumber;
         update acc;
     }
     catch(exception e){
         system.debug('exception===>'+e.getMessage());
         
     }
 }
}