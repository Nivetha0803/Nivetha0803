public class CustomerTriggerHandler {
    Public static void afterInsert(List<Customer__c> listOfCustom)
    {
        List<Account> accList = new List<Account>();
        String customId = '';
        Set<Id> AccId = new Set<Id>();
        For(Customer__c custom :listOfCustom )
        {
            System.debug(custom);
            AccId.add(custom.Account_Id__c);
            customId+=custom.Name+';'; 
            System.debug('customId'+ customId);
            
        }
       For(Account accList1 : [SELECT Id, Name, Customer_Ids__c FROM Account Where ID IN: AccId])
        {
            System.debug('list of Account is' +accList1);
            accList1.Customer_Ids__c+=customId;
            //accList1.Customer_Ids__c+=customId != null ? customId : null;
            System.debug(accList1.Customer_Ids__c);
            accList.add(accList1);
        }
        if(!accList.isEmpty())
        {
            update accList;
            System.debug('updated Account is' +accList);
        }
    }
    
    
    Public static void afterUpdate(List<Customer__c> listOfCustom, Map<Id,Customer__c> oldMap)
    {
        Set<Id> AccountId = new Set<Id>();
         String customId = '';
        For(Customer__c cc:listOfCustom)
        {
          Customer__c  oldrecord = oldMap.get(cc.id);
          if(oldrecord.Type__c=='New' && cc.Type__c=='Existing')
            {
             AccountId.add(cc.Account_Id__c);
             System.debug('Account id is' +AccountId);
             customId+=cc.Name+';'; 

            }
        }
        String customid1;
        for(Customer__c cc: [SELECT Account_Id__c, Id, Type__c, Name FROM Customer__c where Account_Id__c IN:AccountId])
        {
            customid1 =  cc.Name+';';
            system.debug(customid1);
        }
        
        List<Account> listOfAccount = new List<Account>() ;
        For(Account  acc : [SELECT Id, Name, Customer_Ids__c FROM Account Where ID IN: AccountId])
        {  
            system.debug(customid1);
            system.debug(acc.Customer_Ids__c);
    
            //customid1+=';';
            System.debug(customid1);
         acc.Customer_Ids__c = (acc.Customer_Ids__c).remove(customid1);
           
            system.debug(acc.Customer_Ids__c);
         listOfAccount.add(acc);   
        }
        
       update listOfAccount;
        system.debug(listOfAccount);
        
        
        
        /* Map<Id,Account> mapOfIds = new Map<Id,Account>();
       
         For(Customer__c cc:listOfCustom)
        {
          mapOfIds.put(cc.Account_Id__c,new Account(Id = cc.Account_Id__c,Customer_Ids__c=null));
        }
        For(Account aa:[SELECT Id, Name, Customer_Id__c ,(select id,Name,Account_Id__c FROM Customers__r) FROM Account Where Id IN :mapOfIds.keyset()])
        {
            List<String> tmp = New List<String>();
            for(Customer__c custom : aa.Customers__r)
            {
                tmp.add(custom.Name);
            }
            
            if(!tmp.isEmpty())
            {
             mapOfIds.get(aa.id).Customer_Ids__c = String.join(tmp, ';') ;  
            }
            update mapOfIds.values();
        }*/
       
        
        
        Map<Id,String> mapOfIds = new Map<Id,String>();
        For(Customer__c cc:listOfCustom)
           {
               System.debug(cc);
          Customer__c  oldrecord = oldMap.get(cc.id);
               system.debug(oldrecord);
          if(oldrecord.Type__c=='New' && cc.Type__c=='Existing')
            {
                system.debug(oldrecord);
                if(!mapOfIds.containsKey(cc.Account_Id__c))
                {
                    mapOfIds.put(cc.Account_Id__c, cc.Name ) ; 
                    system.debug('mapOfIds=='+mapOfIds);
                }
                //mapOfIds.get(cc.Account_Id__c).add(cc.Name);
                System.debug(mapOfIds);
            }
        }
        
        List<Account> listOfAccDelete = new List<Account>();
        String SetOfAccDelete ;
        For(Account acc: [SELECT Id, Name, Customer_Ids__c FROM Account Where Id IN :mapOfIds.keyset()])
        { 
            String listOfString = acc.Customer_Ids__c;
            system.debug(listOfString.split('/'));
            Set<String> sets = new Set<String>{listOfString};
            
        /* For(string sss : mapOfIds.get(acc.id))
         {
                 SetOfAccDelete.remove(sss);

         }
         System.debug(SetOfAccDelete);
         listOfAccDelete.add(SetOfAccDelete);*/
     }
            
        
           
        
        
        //update listOfAccDelete;
       // System.debug(listOfAccDelete);
        
            
    }
    
}