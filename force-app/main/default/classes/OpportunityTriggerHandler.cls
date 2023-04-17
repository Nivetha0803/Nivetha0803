public class OpportunityTriggerHandler {
   //  before insert 
    public static void OpportunityInsert(List<Opportunity> triggerNew)
    {
         Set<String> setExistOppIdUpdate = new Set<String>();
         id existOppId;
         Set<String> conSet = new Set<String>();
         double d;
         List<Opportunity> listOfOpp = new List<Opportunity>();
        
        For(Opportunity newOpp : triggerNew)
        {
            if(newOpp.Contact__c!=null)
            {
              conSet.add(newOpp.Contact__c) ;  
            }
            
            System.debug('### setOfOpp contacts is' +conSet);
            System.debug('### setOfOpp contacts is' +conSet.size());
        }
        if(!conSet.isEmpty())
        {
            listOfOpp = [ SELECT Contact__c, Name,Description, ContactId, Amount,Total_Amount__c, Id FROM Opportunity  WHERE Contact__c IN:conSet ];
            System.debug('### listOfOpp is' +listOfOpp);
        }
        
        if(!listOfOpp.isEmpty())
        {
            System.debug('### listOfOpp is' +listOfOpp);   
            for(Opportunity newOpp : triggerNew)
            {
                if(newOpp.Contact__c!=null && newOpp.Total_Amount__c!=null)
                {
                  d=0;
                system.debug('&&newopp is' +newOpp);
                for(Opportunity existOpp:listOfOpp)
                {
                    if(existOpp.Contact__c!=null )
                    {
                       //  existOppId=existOpp.Id;
                     system.debug('$$exist opp id is'+existOppId); 
                     system.debug('$$exist opp  is'+existOpp); 
                     d=d+existOpp.Amount;
                     system.debug('$$d is'+d);   
                    }
                 
                }
                    newOpp.Total_Amount__c=d+newOpp.Amount; // calculates existamount+newamount
                system.debug('$$opp con is'+newOpp.Amount ); 
                }
               
              } 
            } 
            }
                                
    
    
    //after insert
    public static void afterInsert(List<Opportunity> triggerNew)
     {
        set<Id> setIds = new set<Id>();
        List<Opportunity> updateOpp = new List<Opportunity>();
        for(Opportunity newOpp:triggerNew)
        {
            if(newOpp.Contact__c!= null)
            { 
                setIds.add(newOpp.Contact__c);
                system.debug('@@setIds'+setIds);
            }
        }
        if(!setIds.isEmpty()){
            for(Opportunity existop1 : [SELECT ID,Name,Total_Amount__c,Contact__c FROM Opportunity WHERE Contact__c IN:setIds])
            {
                for(Opportunity newop1:triggerNew)
                {
                    existop1.Total_Amount__c = newop1.Total_Amount__c;
                    system.debug('@@ existop1.totalamount is'+ existop1.Total_Amount__c );
                    updateOpp.add(existop1);
                    system.debug('@@update op'+updateOpp);
                }
            } 
            if(!updateOpp.isEmpty())
        {
            Update updateOpp;  
            system.debug('@@update op'+updateOpp);
        }
        } 
        
        
      }
        
     
    
    
    // before update
    
    public static void opportunityUpdate(List<Opportunity> triggerNew,Map<Id,Opportunity> oldMap)
    {
      
        Set<String> setExistOppIdUpdate = new Set<String>();
        Set<String> conSet = new Set<String>();
        double d;
        List<Opportunity> listOfOpp = new List<Opportunity>();
        
        For(Opportunity newOpp : triggerNew)
        {
            
            conSet.add(newOpp.Contact__c) ;
            System.debug('### setOfOpp contacts is' +conSet);
            System.debug('### setOfOpp contacts is' +conSet.size());
        }
        if(!conSet.isEmpty())
        {
            listOfOpp = [ SELECT Contact__c, Name,Description, ContactId, Amount,Total_Amount__c, Id FROM Opportunity  WHERE Contact__c IN:conSet ];
            System.debug('### listOfOpp is' +listOfOpp);
        }
        
        if(!listOfOpp.isEmpty())
        {
            System.debug('### listOfOpp is' +listOfOpp);   
            for(Opportunity newOpp : triggerNew)
            {
              d=0;
                system.debug('&&newopp is' +newOpp);
               for(Opportunity existOpp:listOfOpp)
                {
                     if(existOpp.id!=newOpp.Id && newOpp.Amount!=oldMap.get(newOpp.Id).Amount)
                    {
                    d=d+existOpp.Amount;
                    system.debug('$$d is'+d);  
                    newOpp.Total_Amount__c=d+newOpp.Amount;
                    system.debug('$$opp con is'+newOpp.Amount );   
                    system.debug('$$opp con is'+ newOpp.Total_Amount__c );   
                }
               } 
             }
        }
        
        
        
    }
     



// After update
  
    public static void afterUpdate(List<Opportunity> triggerNew,Map<Id,Opportunity> oldMap)
    {
      set<Id> setIds = new set<Id>();
        List<Opportunity> updateOpp = new List<Opportunity>();
        for(Opportunity newOpp:triggerNew)
        {
            if(newOpp.Contact__c!= null)
            { 
                setIds.add(newOpp.Contact__c);
                system.debug('@@setIds'+setIds);
            }
        }
        
        if(!setIds.isEmpty()){
            for(Opportunity existop1 : [SELECT ID,Name,Total_Amount__c,Contact__c FROM Opportunity WHERE Contact__c IN:setIds])
            {
                for(Opportunity newop1:triggerNew)
                {
                    if(existop1.Id!=newop1.Id && newop1.Amount!=oldMap.get(newop1.Id).Amount)
                    {
                      existop1.Total_Amount__c = newop1.Total_Amount__c;
                    system.debug('@@ existop1.totalamount is'+ existop1.Total_Amount__c );
                    updateOpp.add(existop1);
                    system.debug('@@update op'+updateOpp);   
                    }
                   
                }
            } 
            if(!updateOpp.isEmpty())
        {
            Update updateOpp;  
            system.debug('@@update op'+updateOpp);
        }
            
            
        } 
    }
    
   //after delete
   
    public static void afterdelete(List<Opportunity> triggerold)
    {
        set<Id> setIds = new set<Id>();
        List<Opportunity> listOfOpp = new List<Opportunity>();
        
        for(Opportunity opp  : triggerold)
        {
            setIds.add(opp.Contact__c);
        }
        for(Opportunity pp: triggerold)
        {
            system.debug(pp.Amount);
            system.debug(pp.Total_Amount__c);
            for(Opportunity opp1 : [SELECT Id, Name,Amount,Total_Amount__c,Contact__c FROM Opportunity WHERE Contact__c IN : setIds])
            { 
                if(opp1.Total_Amount__c!=null)
                {
                 opp1.Total_Amount__c = opp1.Total_Amount__c - pp.Amount;
                listOfOpp.add(opp1);
                system.debug('list of opp is '+listOfOpp);   
                }
                
            }   
        }
        
        
        if(!listOfOpp.isEmpty())
        {
            update listOfOpp;
            system.debug('delete the opp' +listOfOpp);
        
      
        }
        
    }
    
    
    
    
    
    
    
    
    
}