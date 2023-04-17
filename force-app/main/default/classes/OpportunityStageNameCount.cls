public class OpportunityStageNameCount {
    public static void afterInsert(List<Opportunity> triggerNew)
    {
        Map <Id, List<Opportunity>> mapConIdOppList = new Map <Id, List <Opportunity> >();
        Set < Id > conIds = new Set < Id >();    
        List<Contact> updateCon = new List<Contact>();
        Integer noOfProspects;
        Integer noOfClosedWon;
        Integer noOfClosedLost;
        for(Opportunity Opp : triggerNew)
        {
            if ( !mapConIdOppList.containsKey( Opp.Contact__c ) ) {
                mapConIdOppList.put( Opp.Contact__c, new List < Opportunity >());
            }
            mapConIdOppList.get( Opp.Contact__c ).add( Opp );
            system.debug('$$mapConIdOppList is ' +mapConIdOppList);
            system.debug('$$mapConIdOppList is ' +mapConIdOppList.keyset());
            system.debug('$$mapConIdOppList is ' +mapConIdOppList.values());
            conIds.add( Opp.Contact__c);
            system.debug('$$contact ids' +conIds);  
        }
        if ( !conIds.isEmpty() ) {
            List < Contact > listCon = [Select Id,Total_No_Of_Prospecting__c,Total_No_Of_Closed_Won__c,Total_No_Of_Closed_Lost__c FROM Contact WHERE ID IN:conIds];
            for(Opportunity newOpp: triggerNew)
            {
                system.debug('$$stage name is' +newOpp.StageName);
                for ( Contact con : listCon ) {
                    noOfProspects = 0;
                    noOfClosedWon = 0;
                    noOfClosedLost = 0;
                    if ( mapConIdOppList.containsKey( con.Id ) ) {
                        if(newOpp.StageName=='Prospecting')
                        {
                            noOfProspects += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$noOfProspects is' +noOfProspects);   
                        }
                        else if((newOpp.StageName=='Closed Won'))
                        {
                            noOfClosedWon += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$ noOfClosedWon is' + noOfClosedWon);  
                        }
                        else if((newOpp.StageName=='Closed Lost'))
                        {
                            noOfClosedLost += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$ noOfClosedLost is' + noOfClosedLost);  
                        }
                    }
                    
                    con.Total_No_Of_Prospecting__c = con.Total_No_Of_Prospecting__c == null ? noOfProspects : ( con.Total_No_Of_Prospecting__c + noOfProspects );
                        system.debug('$$con.Total_No_Of_Prospecting__c is' +con.Total_No_Of_Prospecting__c);
                    con.Total_No_Of_Closed_Won__c = con.Total_No_Of_Closed_Won__c == null ? noOfClosedWon : ( con.Total_No_Of_Closed_Won__c + noOfClosedWon );
                        system.debug('$$ con.Total_No_Of_Closed_Won__c is' + con.Total_No_Of_Closed_Won__c);
                    con.Total_No_Of_Closed_Lost__c = con.Total_No_Of_Closed_Lost__c == null ? noOfClosedLost : ( con.Total_No_Of_Closed_Lost__c + noOfClosedLost );
                        system.debug('$$  con.Total_No_Of_Closed_Lost__c is' +  con.Total_No_Of_Closed_Lost__c);
                    updateCon.add(con);
                    system.debug('$$updateCon is' +updateCon);
                }      
            }
        }
        
        if(!updateCon.isEmpty())
        {
            Update updateCon;   
            system.debug('update the contacts  is '+updateCon);
        }
    }
    
// after update 
    
   public static void afterUpdate(List<Opportunity> triggerNew,Map<Id,Opportunity> oldMap)
    {   
       Map <Id, List<Opportunity>> mapConIdOppList = new Map <Id, List <Opportunity>>();
       Set < Id > conIds = new Set < Id >();    
       List<Contact> updateCon = new List<Contact>();
       Integer noOfProspects;
       Integer noOfClosedWon;
       Integer noOfClosedLost;
    
        for (Opportunity Opp : triggerNew) {
            
            Id oldConId = oldMap.get( Opp.Id ).Contact__c;
            
            if ( Opp.Contact__c!=null  ) {
                
                if ( !mapConIdOppList.containsKey ( Opp.Contact__c) ) {
                    
                    mapConIdOppList.put ( Opp.Contact__c, new List < Opportunity >() );
                }
                mapConIdOppList.get( Opp.Contact__c ).add ( Opp );
                ConIds.add ( Opp.Contact__c );
            }
        }
    
        if (!conIds.isEmpty()) {
            List < Contact > listCon = [Select Id,Total_No_Of_Prospecting__c,Total_No_Of_Closed_Won__c,Total_No_Of_Closed_Lost__c FROM Contact WHERE ID IN:conIds];
            for(Opportunity newOpp: triggerNew)
            {
                Id oldConId = oldMap.get( newOpp.Id ).id;
                system.debug('$$stage name is' +newOpp.StageName);
                for ( Contact con : listCon ) {
                    noOfProspects = 0;
                    noOfClosedWon = 0;
                    noOfClosedLost = 0;
                    if ( mapConIdOppList.containsKey( con.Id ) ) {
                        system.debug('$$mapConIdOppList is' +mapConIdOppList);   
                        if(newOpp.StageName=='Prospecting' && (oldMap.get(newOpp.Id).StageName=='Closed Won'))
                        {
                            system.debug('$$newOpp.StageName is' +newOpp.StageName);    
                            noOfProspects += mapConIdOppList.get(con.Id).size();
                            noOfClosedWon -=mapConIdOppList.get(con.Id).size();
                            system.debug('$$noOfProspects is' +noOfProspects);  
                            system.debug('$$noOfProspects is' +noOfClosedWon);  
                        }
                        else if( newOpp.StageName=='Prospecting' && (oldMap.get(newOpp.Id).StageName=='Closed Lost'))
                        {
                            noOfProspects += mapConIdOppList.get( con.Id ).size();
                            noOfClosedLost-=mapConIdOppList.get( con.Id ).size();
                            system.debug('$$noOfProspects is' +noOfProspects);  
                            system.debug('$$noOfClosedLost is' +noOfClosedLost);  
                        }
                        if(newOpp.StageName=='Closed Won' && (oldMap.get(newOpp.Id).StageName=='Closed Lost'))
                        {
                            noOfClosedWon += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$ noOfClosedWon is' + noOfClosedWon);
                            noOfClosedLost-=mapConIdOppList.get( con.Id ).size();  
                            system.debug('$$noOfClosedLost is' +noOfClosedLost); 
                        }
                        else if(newOpp.StageName=='Closed Won' && (oldMap.get(newOpp.Id).StageName=='Prospecting'))
                        {
                            
                            noOfClosedWon += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$ noOfClosedWon is' + noOfClosedWon); 
                            noOfProspects -= mapConIdOppList.get( con.Id ).size();
                            system.debug('$$noOfProspects is' +noOfProspects);  
                        }
                        if(newOpp.StageName=='Closed Lost' && (oldMap.get(newOpp.Id).StageName=='Prospecting'))
                        {
                            noOfClosedLost += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$ noOfClosedWon is' + noOfClosedLost);
                            noOfProspects-=mapConIdOppList.get( con.Id ).size();  
                            system.debug('$$noOfClosedLost is' +noOfProspects); 
                        }
                        else if(newOpp.StageName=='Closed Lost' && (oldMap.get(newOpp.Id).StageName=='Closed Won'))
                        {
                            noOfClosedLost += mapConIdOppList.get( con.Id ).size();
                            system.debug('$$ noOfClosedLost is' + noOfClosedLost);
                            noOfClosedWon -=mapConIdOppList.get( con.Id ).size();  
                            system.debug('$$noOfClosedWon is' +noOfClosedWon); 
                        } 
                    }
                    
                    con.Total_No_Of_Prospecting__c = con.Total_No_Of_Prospecting__c == null ? noOfProspects : ( con.Total_No_Of_Prospecting__c + noOfProspects );
                        system.debug('$$con.Total_No_Of_Prospecting__c is' +con.Total_No_Of_Prospecting__c);
                    con.Total_No_Of_Closed_Won__c = con.Total_No_Of_Closed_Won__c == null ? noOfClosedWon : ( con.Total_No_Of_Closed_Won__c + noOfClosedWon );
                        system.debug('$$ con.Total_No_Of_Closed_Won__c is' + con.Total_No_Of_Closed_Won__c);
                    con.Total_No_Of_Closed_Lost__c = con.Total_No_Of_Closed_Lost__c == null ? noOfClosedLost : ( con.Total_No_Of_Closed_Lost__c + noOfClosedLost );
                        system.debug('$$  con.Total_No_Of_Closed_Lost__c is' +  con.Total_No_Of_Closed_Lost__c);
                    updateCon.add(con);
                    system.debug('$$updateCon is' +updateCon);
                }      
            }
            
            Update updateCon;
            system.debug('update the contacts  is '+updateCon);
        }
      } 
    
    // After delete
    
      public static void afterdelete(List<Opportunity> triggerOld)
      {
          Set < Id > conIds = new Set < Id >();    
         List<Contact> updateCon = new List<Contact>();
         Map <Id, List< Opportunity>> mapConIdDelOppList = new Map <Id, List <Opportunity>>();
         Integer noOfProspects;
         Integer noOfClosedWon;
         Integer noOfClosedLost;
          
        for( Opportunity Opp : triggerOld) {
        
            if (Opp.Contact__c!=null) {
            
                if ( !mapConIdDelOppList.containsKey( Opp.Contact__c) ) {
                
                    mapConIdDelOppList.put(Opp.Contact__c, new List <Opportunity >() );
                    
                }
                
                mapConIdDelOppList.get(Opp.Contact__c).add(Opp);    
                conIds.add(Opp.Contact__c);
                
            }
          }  
          
          if(!conIds.IsEmpty()){
              List < Contact > listCon = [Select Id,Total_No_Of_Prospecting__c,Total_No_Of_Closed_Won__c,Total_No_Of_Closed_Lost__c FROM Contact WHERE ID IN:conIds];
           for(Opportunity oldOpp: triggerOld)
           {
               for(Contact con :listCon)
               {
                  noOfProspects = 0;
                  noOfClosedWon = 0;
                  noOfClosedLost = 0;
                   
                    if (mapConIdDelOppList.containsKey(con.Id)) {
                       if(oldOpp.StageName == 'Prospecting')
                       {
                        noOfProspects -= mapConIdDelOppList.get(con.Id).size();   
                       }
                    else if(oldOpp.StageName == 'Closed Won')
                       {
                    noOfClosedWon -= mapConIdDelOppList.get(con.Id).size();
                       }
                     else if(oldOpp.StageName == 'Closed Lost'){
                         noOfClosedLost  -=  mapConIdDelOppList.get(con.Id).size();
                        }
                }
                   
                   con.Total_No_Of_Prospecting__c = con.Total_No_Of_Prospecting__c == null ? noOfProspects : ( con.Total_No_Of_Prospecting__c + noOfProspects );
                        system.debug('$$con.Total_No_Of_Prospecting__c is' +con.Total_No_Of_Prospecting__c);
                    con.Total_No_Of_Closed_Won__c = con.Total_No_Of_Closed_Won__c == null ? noOfClosedWon : ( con.Total_No_Of_Closed_Won__c + noOfClosedWon );
                        system.debug('$$ con.Total_No_Of_Closed_Won__c is' + con.Total_No_Of_Closed_Won__c);
                    con.Total_No_Of_Closed_Lost__c = con.Total_No_Of_Closed_Lost__c == null ? noOfClosedLost : ( con.Total_No_Of_Closed_Lost__c + noOfClosedLost );
                        system.debug('$$  con.Total_No_Of_Closed_Lost__c is' +  con.Total_No_Of_Closed_Lost__c);
                    updateCon.add(con);
                    system.debug('$$updateCon is' +updateCon);  
               }
               
           }
              if(!updateCon.isEmpty())
              {
                  Update updateCon;
                   system.debug('$$updateCon is' +updateCon);  
              }
          }
      }   
}