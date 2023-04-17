public class ContactTriggerHandler {
 
    public static void afterInsert(List<Contact> conList)
    {
        Integer countOfCon;
        Map <Id, List<Contact>> mapAccIdOppList = new Map <Id, List <Contact>>();
        List<Account> UpdAcc = new List<Account>();
        List<Task> tasklist = new List<Task>(); 
        Set<Id> conId =  new Set<Id>();
        Set<Id> accOfConId = new Set<Id>();
        For(Contact cc : conList)
        {
            if(!mapAccIdOppList.containsKey(cc.AccountId)){
                mapAccIdOppList.put(cc.AccountId,new List<Contact>());
            }
             mapAccIdOppList.get(cc.AccountId).add(cc); // add values with key
            accOfConId.add( cc.AccountId);
            system.debug('&&& set of con ids '+mapAccIdOppList);
        }
      
        
         
        List<Account> listOfacc = [SELECT ID,Name, Total_number_of_Contact_Counts__c FROM Account WHERE ID IN :accOfConId];
        system.debug('@@@ list of account is '+listOfacc);
        List<Task> conTasks = [SELECT id, subject FROM Task WHERE Whoid IN: conId];
        System.debug('tasks:' + conTasks);
        For(Contact cc : conList)
        {
            countOfCon=0;
            Task tsk = new Task();
	        tsk.whoId=cc.id;
	        tsk.Subject='Follow up Task';
	        tasklist.add(tsk);
            For(Account acc : listOfacc)
            {
                if( mapAccIdOppList.containsKey(acc.Id))
                {
                  countOfCon += mapAccIdOppList.get(acc.Id).size(); 
                  system.debug('$$$ countOfCon'+countOfCon);

                }
                 acc.Total_number_of_Contact_Counts__c = acc.Total_number_of_Contact_Counts__c == null ? countOfCon : ( acc.Total_number_of_Contact_Counts__c + countOfCon );
                 UpdAcc.add(acc);
                 system.debug('$$$ total no of acc contacts '+acc.Total_number_of_Contact_Counts__c);
                 system.debug('$$$ total no of acc contacts '+UpdAcc);
               }
            
            
            
        }
        if(!tasklist.isEmpty())
        {
           insert  tasklist;
        }
        
         
    
        
        if(!UpdAcc.isEmpty())
        {
         Update UpdAcc;
         System.debug('$$$ Updated account is '+UpdAcc);

        }
    }
    // after update
    public static void afterUpdate(List<Contact> conList,Map<Id,Contact> oldMap)
    {
      Integer countOfCon;
        Map <Id, List<Contact>> mapAccIdOppList = new Map <Id, List <Contact>>();
        List<Account> UpdAcc = new List<Account>();
        List<Task> tasklist = new List<Task>(); 
        Set<Id> conId =  new Set<Id>();
        Set<Id> accOfConId = new Set<Id>();  
        For(Contact cc : conList)
        {
             Task tsk = new Task();
	        tsk.whoId=cc.id;
	        tsk.Subject='Follow up Task';
	        tasklist.add(tsk);
            if(!mapAccIdOppList.containsKey(cc.AccountId)){
                mapAccIdOppList.put(cc.AccountId,new List<Contact>());
            }
             mapAccIdOppList.get(cc.AccountId).add(cc); // add values with key
            accOfConId.add( cc.AccountId);
            system.debug('&&& set of con ids '+mapAccIdOppList);
        }
         
   
       
        List<Account> listOfacc = [SELECT ID,Name, Total_number_of_Contact_Counts__c FROM Account WHERE ID IN :accOfConId];
            for(Contact newCon: conList)
            {
                Id oldConId = oldMap.get( newCon.Id ).AccountId;
                
                  For(Account acc : listOfacc)
            {
                if( mapAccIdOppList.containsKey(acc.Id))
                {
                    if(newCon.AccountId!=oldConId)
                    {
                      countOfCon -= mapAccIdOppList.get(acc.Id).size(); 
                  system.debug('$$$ countOfCon'+countOfCon);
   
                    }
                 
                }
                 acc.Total_number_of_Contact_Counts__c = acc.Total_number_of_Contact_Counts__c == null ? countOfCon : ( acc.Total_number_of_Contact_Counts__c + countOfCon );
                 UpdAcc.add(acc);
                 system.debug('$$$ total no of acc contacts '+acc.Total_number_of_Contact_Counts__c);
                 system.debug('$$$ total no of acc contacts '+UpdAcc);
               }
                      
                   
                }      
            
          
 if(!tasklist.isEmpty())
        {
           insert  tasklist;
        }    
if(!UpdAcc.isEmpty())
        {
         Update UpdAcc;
         System.debug('$$$ Updated account is '+UpdAcc);

        }
    }
}