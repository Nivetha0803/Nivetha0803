public class AccountTriggerHandler {
    public static void afterUpdate(List<Account> accList){
        Set<Id> accIds = new Set<Id>();
        For(Account acc: accList)
        {
            if(acc.Id!=null)
            {
                 accIds.add(acc.Id);
                 System.debug('@@@ Account id is'+accIds);
            }
         
        }
        
        List<Contact> updateCon = new List<Contact>();
        List<Contact> conOfAcc = [SELECT ID, AccountId, LastName,Email,phone FROM Contact WHERE AccountId IN:accIds];
        For(Account existAcc : accList)
        {
            System.debug('@@@ existAcc is'+existAcc);
           
             // Account oldAcc = oldMap.get(existAcc.Id);
               // oldOpp = oMap.get(newOpp.Id);
             system.debug('&& existAcc.Id is '+existAcc.Id);
           For(Contact con : conOfAcc)
                {
                    system.debug('&& con is '+con);
                    con.Phone = existAcc.Phone;
                    con.Email = existAcc.Email__c;
                   con.Industry__c = existAcc.Industry;
                    updateCon.add(con);
                    system.debug('$$$$ update contact is' +updateCon);
                   system.debug('$$$$ update contact phone is' +con.Phone);  
                }
             
            }
        if(!updateCon.isEmpty())
        {
            update updateCon;
            system.debug('$$$$ update contact is' +updateCon);
        }
    }
}