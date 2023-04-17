public class conFuzzyextend {
 
    public static void updateExist(Id conid){
        
        Contact cc = [ SELECT Id,Dup_Checker__c,Name, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                   MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                   FROM Contact WHERE ID =:conid ]; 
       system.debug( 'dup phone is'+conid);
        system.debug( 'dup phone is'+cc.Name); 
         cc.IsDuplicate_A__c = 'Yes';   
         cc.Dup_Checker__c=true;
            Update cc;
        
    }
     
  
  
   public static void updateEmail(Id cid){
        
        Contact c = [ SELECT Id,Dup_Checker__c, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                   MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                   FROM Contact WHERE ID =:cid ]; 
        
          c.IsDuplicate_B__c = 'Yes';  
          c.Dup_Checker__c=true;
          Update c;
    }
   public static void updateAddress(Id ctid){
        
        Contact c1 = [ SELECT Id,Dup_Checker__c,Name, Duplicate_Address__c,Languages__c,LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                   MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                   FROM Contact WHERE Id =:ctid ]; 
        system.debug( 'dup mailcity is'+c1);
        system.debug( 'dup mailcity is'+c1.Name); 
          c1.Dup_Checker__c=true;
          c1.IsDuplicate_C__c = 'Yes';   
       system.debug('dup mailcity is'+ c1.IsDuplicate_C__c);
          Update c1;
        system.debug('dup mailcity is'+ c1.IsDuplicate_C__c);
        system.debug( 'dup mailcity is'+c1); 
        system.debug( 'dup mailcity is'+c1.Name); 
       
    }
}