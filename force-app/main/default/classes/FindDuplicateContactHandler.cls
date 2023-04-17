public class FindDuplicateContactHandler {
 public static void duplicateInsert(List<Contact> conList)
     {
        Map<String ,Contact> mapDupWiseContact = new Map<String,Contact>();
        Map<String,Contact> mapDupWiseEmail = new Map<String,Contact>();
        Map<String,Contact> mapDupWiseAddress = new Map<String,Contact>();
        
        Set<String> lastNameSet = new Set<String>();
        Set<String> firstNameSet = new Set<String>(); 
        Set<String> phoneSet = new Set<String>();    
        Set<String> emailSet = new Set<String>();   
        Set<String> addressSet = new Set<String>();
        List<Contact> conts1 = new List<Contact> ();
        List<Contact> conts2 = new List<Contact>();   
        List<Contact> conts3 = new List<Contact>();
        
        String lastName;
        String firstName;
         String phone;
        
        For(Contact con : conList)
        {
            if(con.LastName!=null )
              {
               lastName = con.LastName;
               if (lastName != null) lastName = lastName.left(3);
               // lastNameSet.add((con.LastName.left(3))+'%');   
                //  System.debug('lastnameset is '+lastNameSet);
                System.debug('lastnameset is '+lastName);
              }
            if(con.FirstName!=null)
              {
                  firstName = con.FirstName;
                  if (firstName != null) firstName = firstName.left(3);
              //  firstNameSet.add((con.FirstName.left(3))+'%');    
                     System.debug('firstnameset is '+firstNameSet);
                  System.debug('firstnameset is '+firstName);
              }
              if(con.Phone!=null)
              {
                phoneSet.add(con.Phone);    
              }   
                if(con.Email!=null)
              {
                emailSet.add(con.Email);    
              }   
             if(con.MailingStreet!=null || con.MailingCity!=null || con.MailingState!=null ||
               con.MailingCountry!=null || con.MailingPostalCode!=null)
              {
               addressSet.add(con.MailingStreet);
               addressSet.add('%'+con.MailingCity+'%');
               addressSet.add('%'+con.MailingState+'%');
               addressSet.add('%'+con.MailingCountry+'%');
               addressSet.add(con.MailingPostalCode);
              }
          }
        System.debug('To display the lastname is >' +lastNameSet);
        System.debug('To display the firstname is >' +firstNameSet);
        System.debug('To display the Phone no is >' +phoneSet);
        System.debug('To display the email is> '+emailSet);
        System.debug('To display the email is> '+addressSet);

 // First criteria ==>(lastname(fuzzy),firstname(fuzzy),phone(exact))   
  
     
         
    List<Contact> listOfContact =  [SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                      MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                      FROM Contact ];
                                                          
        System.debug('list of duplicate phonecontacts >'+ listOfContact);        
        For(Contact con: listOfContact)
        {
            con.IsDuplicate_A__c = 'Yes';  
             con.IsDuplicate_B__c = '';
            System.debug('list of contact is '+con);
            mapDupWiseContact.put(con.FirstName,con);   
            mapDupWiseContact.put(con.LastName,con);   
            mapDupWiseContact.put(con.Phone,con);    
            conts1.add(con);
            System.debug('conts is '+conts1); 
            System.debug('mapDupWiseContact is '+mapDupWiseContact); 
        }
        System.debug('mapDupWiseContact is '+mapDupWiseContact); 
        Update conts1;
        System.debug('the updation of existing dup contact> '+conts1);

        
       For(Contact con : conList)
         {
             For(Contact c: listOfContact)
             {
              if(mapDupWiseContact.containsKey(c.LastName)
                   &&  mapDupWiseContact.containsKey(c.Phone)
                   &&  mapDupWiseContact.containsKey(c.FirstName))   
              {
                    System.debug('mapDupWiseContact is '+mapDupWiseContact);
                    con.IsDuplicate_A__c = 'Yes';
                   con.IsDuplicate_B__c = '';
                    System.debug('con is '+con.IsDuplicate_A__c);
              }
             }
           System.debug('con is '+con.IsDuplicate_A__c);
          }
        
   // Second criteria ==>(lastname(fuzzy),firstname(fuzzy),email(exact))   
   
     
     List<Contact> listOfEmail =  [SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                      MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                      FROM Contact WHERE (LastName LIKE:lastNameSet AND  Email =:emailSet AND FirstName LIKE:firstNameSet)];
            
                                          
           System.debug('list of duplicate email contacts is > '+listOfEmail);
        
              For(Contact con: listOfEmail)
               {
                con.IsDuplicate_B__c = 'Yes';
                    con.IsDuplicate_A__c = '';
                System.debug('list of duplicate email contacts is > '+con);
                mapDupWiseEmail.put(con.LastName,con); 
                mapDupWiseEmail.put(con.Email,con); 
                 mapDupWiseEmail.put(con.FirstName,con);    
                System.debug('mapDupWiseEmail is '+mapDupWiseEmail);
                 conts2.add(con);  
               }
        Update conts2;
        System.debug('the updation of existing dup contact> '+conts2);
        
        For(Contact con : conList)
            {
               For(Contact c: listOfEmail)
                {
                if(mapDupWiseEmail.containsKey(c.FirstName) && mapDupWiseEmail.containsKey(c.LastName)
                   &&  mapDupWiseEmail.containsKey(c.Email))                   
                 {
                    System.debug('mapDupWiseContact is '+mapDupWiseEmail);
                    con.IsDuplicate_B__c = 'Yes';
                     con.IsDuplicate_A__c = '';
                    System.debug('con is '+con.IsDuplicate_B__c);
                }
                    
             }
          } 
        
 // Third criteria ==>(lastname(fuzzy),firstname(fuzzy),Address(Fuzzy))    
     
    List<Contact> listOfAddress =  [SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                      MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                       FROM Contact WHERE( LastName LIKE:lastNameSet AND FirstName LIKE:firstNameSet AND (MailingStreet LIKE:addressSet OR MailingCity LIKE:addressSet
                                           OR MailingState LIKE:addressSet OR MailingCountry LIKE:addressSet OR MailingPostalCode LIKE:addressSet))];
                                                                                                                         
            System.debug('list of duplicate Address contacts is>' + listOfAddress);            
            For(Contact con: listOfAddress)
            {
                con.IsDuplicate_C__c = 'Yes';
                System.debug('list of duplicate Address contacts is>' + con); 
                mapDupWiseAddress.put(con.LastName,con);
                mapDupWiseAddress.put(con.FirstName,con);
                mapDupWiseAddress.put(con.MailingState,con); 
                mapDupWiseAddress.put(con.MailingCity,con);
                mapDupWiseAddress.put(con.MailingStreet,con);
                mapDupWiseAddress.put(con.MailingCountry,con);
                mapDupWiseAddress.put(con.MailingPostalCode,con);
                System.debug('mapDupWiseAddress is '+mapDupWiseAddress);
                conts3.add(con);
               } 
        Update conts3;
        System.debug('the updation of existing dup contact> '+conts3);
        
      For(Contact con : conList)
          {
              For(Contact c: listOfAddress)
              {
                if ((mapDupWiseAddress.containsKey(c.LastName)) && (mapDupWiseAddress.containsKey(c.FirstName))
                   &&(mapDupWiseAddress.containsKey(c.MailingStreet)) && (mapDupWiseAddress.containsKey(c.MailingCity))
                   && (mapDupWiseAddress.containsKey(c.MailingState)) && (mapDupWiseAddress.containsKey(c.MailingCountry))
                    && (mapDupWiseAddress.containsKey(c.MailingPostalCode)))
                 {
                    System.debug('mapDupWiseContact is '+mapDupWiseAddress);
                    con.IsDuplicate_C__c = 'Yes';
                    System.debug('con is '+con.IsDuplicate_C__c);
                } 
                  else
                  {
                      con.IsDuplicate_C__c = '';
                  }
              }
            
           }
     }  
   
    
    // Before Update Duplicate method 
	 
    public static void duplicateUpdate(List<Contact> conList,Map<Id,Contact> conOldMap)
    {
         Set<String> lastNameSet = new Set<String>();
        Set<String> firstNameSet = new Set<String>(); 
        Set<String> phoneSet = new Set<String>();    
        Set<String> emailSet = new Set<String>();   
        Set<String> addressSet = new Set<String>();
        List<Contact> conts1 = new List<Contact> ();
        List<Contact> conts2 = new List<Contact>();   
        List<Contact> conts3 = new List<Contact>();
         Boolean b=false;   
        Map<String ,Contact> mapDupWiseContact = new Map<String,Contact>();
        Map<String,Contact> mapDupWiseEmail = new Map<String,Contact>();
        Map<String,Contact> mapDupWiseAddress = new Map<String,Contact>();     
         List<Contact> consUp1 = new List<Contact>(); 
        Set<Id> newId =  new Set<Id>();
        
        
        For(Contact con : conList)
        {
            Contact oldMap = conOldMap.get(con.id);
             if(con.LastName!=oldMap.LastName && con.LastName!=null )
              {
          
                lastNameSet.add('%'+con.LastName+'%'); 
                  system.debug('lastname is >>'+lastNameSet);
             }
            if(con.FirstName!=oldMap.FirstName && con.FirstName!=null)
              {
                
                firstNameSet.add('%'+con.FirstName+'%'); 
                  system.debug('firstname is >>'+firstNameSet);
           }
            if(con.Phone!=oldMap.Phone && con.Phone!=null)
              {
                
                phoneSet.add(con.Phone); 
                   system.debug('phone is >>'+phoneSet);
             }
             if(con.Email!=oldMap.Email && con.Email!=null)
              {
                
                phoneSet.add(con.Email); 
                   system.debug('phone is >>'+phoneSet);
             }
             }
        System.debug('To display the lastname is >' +lastNameSet);
        System.debug('To display the firstname is >' +firstNameSet);
        System.debug('To display the Phone no is >' +phoneSet);
      
        
       List<Contact> listOfContact = [ SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                         MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                              FROM Contact]; 
              System.debug('listOfContact is '+listOfContact);
                          
      
        For(Contact con: listOfContact)
        {
            mapDupWiseContact.put(con.LastName,con);
            mapDupWiseContact.put(con.FirstName,con);
            mapDupWiseContact.put(con.Phone,con);
            System.debug('mapDupWiseContact is '+mapDupWiseContact);
            
        //   con.IsDuplicate_A__c = 'Yes';
            
        //   conts1.add(con);
        }
      // Update conts1;
         System.debug('the list of update phone is '+listOfContact);
   
         For(Contact con:conList)
        {
          For(Contact con1: listOfContact)
            {
               if( con.Phone == con1.Phone )
                   {
                       con.IsDuplicate_A__c = 'Yes';
                       newId.add(con1.Id);
                      
                     break;
                System.debug('the list of update lastName is '+ con.IsDuplicate_A__c);
                System.debug('the list of update lastName is '+ con1.IsDuplicate_A__c);
                System.debug('the list of update lastName is '+ consUp1);
                    } 
                else
                {
                    con.IsDuplicate_A__c='';
                                
                    System.debug('the list of update lastName is '+ con.IsDuplicate_A__c);
                    System.debug('the list of update lastName is '+ con1.IsDuplicate_A__c);
                    System.debug('the list of update lastName is '+ consUp1);
                 }
           }
            
           }
      
          List<Contact> cons1 = [ SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                         MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                              FROM Contact WHERE ID IN:newId];   
        For(Contact cc:cons1 )
        {
            if(b==false)
            {
               cc.IsDuplicate_A__c = 'Yes';
            }
         
            if(b==true)
            {
               cc.IsDuplicate_A__c = '';  
            }
        }
        
    // for Email update    
         For(Contact con:conList)
        {
          For(Contact con1: listOfContact)
            {
               if( con.Email == con1.Email)
                   {
                       con.IsDuplicate_B__c = 'Yes';
                       con.IsDuplicate_A__c = '';
                       newId.add(con1.Id);
                      
                     break;
                System.debug('the list of update lastName is '+ con.IsDuplicate_B__c);
                System.debug('the list of update lastName is '+ con1.IsDuplicate_B__c);
                System.debug('the list of update lastName is '+ consUp1);
                    } 
                else
                {
                    con.IsDuplicate_B__c='';
                    con.IsDuplicate_A__c = '';
                     b=true;             
                    System.debug('the list of update lastName is '+ con.IsDuplicate_B__c);
                    System.debug('the list of update lastName is '+ con1.IsDuplicate_B__c);
                    System.debug('the list of update lastName is '+ consUp1);
                 }
           }
            
           }
      
          List<Contact> cons2 = [ SELECT Id, LastName, FirstName, Email,Phone,MailingState, MailingStreet, MailingCity,
                                         MailingPostalCode, MailingCountry,IsDuplicate_A__c, IsDuplicate_B__c, IsDuplicate_C__c,MailingAddress
                                              FROM Contact WHERE ID IN:newId];   
        For(Contact cc:cons2 )
        {
            if(b==false)
            {
               cc.IsDuplicate_B__c = 'Yes';
            }
         
            if(b==true)
            {
               cc.IsDuplicate_B__c = '';  
            }
        }
}
}