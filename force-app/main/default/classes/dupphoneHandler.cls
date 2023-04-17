public class dupphoneHandler {
 

    /*   public static void findDuplicateRecords(List<Contact> Cons){
         Set<String> lastNameSet = new Set<String>();
 For(Contact c:cons)
 {
     lastNameSet.add(c.LastName);  
 }
 
      /* List<Contact> listOFContact = [SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                      MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                      FROM Contact WHERE LastName LIKE : lastNameSet];*/
              
       // System.debug('list of contact is >'+listOFContact) ;     
   /* List<Datacloud.FindDuplicatesResult > findDuplicatesResult = Datacloud.FindDuplicates.findDuplicates(lastNameSet);
         System.debug('FindDuplicatesResult is >'+findDuplicatesResult) ;   
    Datacloud.DuplicateResult duplicateResult = findDuplicatesResult.get(0).getDuplicateResults().get(0);
            System.debug('duplicateResult is >'+duplicateResult) ;   
    Datacloud.MatchResult matchResult = duplicateResult.getMatchResults()[0];
           System.debug('matchResult is >'+matchResult) ;  
    List<Datacloud.MatchRecord> matchRecords = matchResult.getMatchRecords();
           System.debug('matchRecords is >'+matchRecords) ;  
    
    List<SObject> duplicates = new List<SObject>();
    for(Datacloud.MatchRecord matchRecord : matchRecords){
        SObject duplicate = matchRecord.getRecord();
        System.debug('Match Record: ' + duplicate);
        duplicates.add(duplicate);
    }
    return duplicates;
}*/
                                               
    

}