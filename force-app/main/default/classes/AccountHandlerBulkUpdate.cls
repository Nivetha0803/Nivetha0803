public class AccountHandlerBulkUpdate {
    public static void accountBulkUpdate(List<Account> acclist,Map<Id,Account> oldMap)
    {
        
        set<Id> setId = new set<Id>();        
        List<Opportunity> opplist = new List<Opportunity>();
        for(Account acc : acclist)
        {      
            if(acc.Type!=oldMap.get(acc.id).Type)
            {
             setId.add(acc.id);
            }
        List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :setId];
        for(Opportunity opp:relatedOpps){
          if ((opp.Probability >= 50) && (opp.Probability < 100)) 
          {
            opp.Description = 'New description for opportunity.';
            // Update once for each opportunity -- not efficient!
            opplist.add(opp);  
          }  
        }
        }

        update opplist;
        system.debug(opplist);
    }

}