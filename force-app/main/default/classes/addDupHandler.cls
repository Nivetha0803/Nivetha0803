public class addDupHandler {
public static void addressUpdate(Id dupId)
{
    Contact c1 = [ SELECT Id,Dup_Checker__c,Name, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                   MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                   FROM Contact WHERE Id =:dupId ]; 
        system.debug( 'dup mailcity is'+c1);
        system.debug( 'dup mailcity is'+c1.Name); 
        
          c1.IsDuplicate_C__c = 'Yes';   
        system.debug('dup mailcity is'+ c1.IsDuplicate_C__c);
          Update c1;
        system.debug('dup mailcity is'+ c1.IsDuplicate_C__c);
        system.debug( 'dup mailcity is'+c1); 
        system.debug( 'dup mailcity is'+c1.Name); 
}
}