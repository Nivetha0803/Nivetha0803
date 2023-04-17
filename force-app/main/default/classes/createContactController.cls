public with sharing class createContactController {
    @AuraEnabled(cacheable=true)
    
    public static String contactInsert(string conObj ,string accountId)
    {
        
            
            contact con = new contact();
            con.LastName=conObj;
            con.AccountId=accountId;
            
            insert con;
            system.debug('con-->'+con);
            return con.Id;
        
        
    }
    @AuraEnabled
    public static List<Account> AccountFetch(){
        
        system.debug('Account Find');
        List<Account> accList = [SELECT id ,Name FROM Account limit 100];
        return accList ;
    }  
}