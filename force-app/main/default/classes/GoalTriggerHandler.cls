public class GoalTriggerHandler {
    public static void afterInsert(List<Goal__c> goalList)
    {
        Set<Id> contactIds  = new Set<Id>();
        Set<String> goalYears = new Set<String>();
        List<Goal__c> setGoals = new List<Goal__c>();
        Map<string,set<Id>> contactYearGoalMap  = new Map<string,set<Id>>(); // year is id and get the values of integer
        Map<Id,Goal__c> mapOfGoal = new Map<Id,Goal__c>();
        Map<Id,string> mapOfGoalYears = new Map<Id,string>();
        Map<Id,Map<String,Set<Goal__c>>> mapOfGoalCount = new Map<Id,Map<String,Set<Goal__c>>>();
        Map<Goal__c,Set<String>> mapOfYears = new Map<Goal__c,Set<String>>();
        integer i =1;
        //Id goalIds;
        
        
        for(Goal__c goal : goalList )
        {
            if(goal.Set_Date__c!=null)
            {
                contactIds.add(goal.Contact__c);
                system.debug('contactId==>' +contactIds);
            }
            system.debug('contactId==>' +contactIds);
        }
        
        Map<Id,Contact> mapOfContacts = new Map<Id,Contact>([Select Id, Name FROM Contact WHERE ID IN:contactIds]);
        
        Map<Id,Map<String,Affiliated_Goals__c>> mapOfAffGoals = new Map<Id,Map<String,Affiliated_Goals__c>>();
        List<Affiliated_Goals__c> listOfAffGoals = [SELECT Year_exist__c, Id, Goal__c, Participant_360__c FROM Affiliated_Goals__c WHERE Goal__c IN:goalList ];
        System.debug('listOfAffGoals:' +listOfAffGoals);
        List<Affiliated_Goals__c> listOfAffGoals1 = [SELECT Year_exist__c, Id, Goal__c, Participant_360__c FROM Affiliated_Goals__c WHERE Goal__c IN:goalList ORDER BY Year_exist__c ASC];
        System.debug('listOfAffGoals:' +listOfAffGoals);
        
        if(listOfAffGoals!=null)
        {
            System.debug('listOfAffGoals :' +listOfAffGoals);
            For(Affiliated_Goals__c AffGoals : listOfAffGoals)
            {
                system.debug('AffGoals:' +AffGoals);
                if(mapOfAffGoals.containsKey(AffGoals.Goal__c))
                {
                    system.debug(mapOfAffGoals);
                    mapOfAffGoals.get(AffGoals.Goal__c).put(String.valueOf(AffGoals.Year_exist__c),AffGoals);
                    System.debug('mapOfAffGoals:' +mapOfAffGoals);
                }
                else 
                {
                    if(AffGoals.Year_exist__c != null)
                        mapOfAffGoals.put(AffGoals.Goal__c,new Map<String,Affiliated_Goals__c>{String.valueOf(AffGoals.Year_exist__c) => AffGoals});
                    System.debug('mapOfAffGoals:' +mapOfAffGoals);
                }
                System.debug('mapOfAffGoals:' +mapOfAffGoals);
            }
        }
        system.debug('mapOfAffGoals:' +mapOfAffGoals);
        
        
        Set<String> years = new Set<String>();
        for(Goal__c goal : goalList)
        {
            if(goal.Set_Date__c!=null )
            {
                System.debug('goal:' +goal.Set_Date__c);
                years.add(String.valueOf(goal.Set_Date__c.year()));
                system.debug(years);
            }
            mapOfYears.put(goal,years);
            system.debug('mapOfYears :' +mapOfYears);
            system.debug('mapOfYears :' +mapOfYears.keyset());
            system.debug('mapOfYears :' +mapOfYears.values());
        }
        for(Goal__c goal :goalList )
        {
            system.debug('goal==>' +goal);
            if(mapOfYears.get(goal)!=null)
            {
                System.debug('mapOfYears :' +mapOfYears);
                System.debug('mapOfYears :' +mapOfYears.keyset());
                System.debug('mapOfYears :' +mapOfYears.values());
                for(String year : mapOfYears.get(goal))
                {
                    System.debug('year:' +year);
                    if(mapOfGoalCount.containsKey(goal.Contact__c))
                    {
                        System.debug('mapOfGoalCount:' +mapOfGoalCount);
                        if(mapOfGoalCount.get(goal.Contact__c).containsKey(year))
                        {
                            System.debug('mapOfGoalCount:' +mapOfGoalCount);
                            mapOfGoalCount.get(goal.Contact__c).get(year).add(goal); 
                            system.debug('mapOfGoalCount' +mapOfGoalCount);         
                        }
                        else{
                            mapOfGoalCount.get(goal.Contact__c).put(year,new Set<Goal__c>{goal}); 
                            system.debug('mapOfGoalCount' +mapOfGoalCount);         
                        }
                    } 
                    else
                    {
                        mapOfGoalCount.put(goal.Contact__c, new Map<String, Set<Goal__c>>{year => new Set<Goal__c>{goal}}); 
                        system.debug('mapOfGoalCount' +mapOfGoalCount);         
                    }
                }
            }
        }
        System.debug('mapOfGoalCount' +mapOfGoalCount);         
        
        Map<Id,Map<string,Participant_360__c>> contactYearP360 = new Map<Id,Map<string,Participant_360__c>>();
        for(Participant_360__c p30List: [ SELECT Id, Contact__c, Name,Participant_360_Name__c,Total_number_of_Goal_Counts1__c, Goals_Created_IDs_Jan__c,Participated_Year__c,Goals_Created_ID__c, Total_number_of_AffGoal_Counts__c 
                                         FROM Participant_360__c
                                         WHERE  Contact__c IN: contactIds])
        {
            System.debug('p30List :' +p30List);
            if(contactYearP360.containsKey(p30List.Contact__c))
            {
                System.debug('contactYearP360 :' +contactYearP360);
                contactYearP360.get(p30List.Contact__c).put(String.valueOf(p30List.Participated_Year__c),p30List);
                System.debug('contactYearP360 :' +contactYearP360);
            }
            else
            {
                System.debug('contactYearP360 :' +contactYearP360);
                contactYearP360.put(p30List.Contact__c,new Map<String,Participant_360__c>{String.valueOf(p30List.Participated_Year__c) => p30List }) ; 
                System.debug('contactYearP360 :' +contactYearP360);
                System.debug('contactYearP360 :' +contactYearP360.keyset());
                System.debug('contactYearP360 :' +contactYearP360.values());
            }
            
        }
        
        List<Participant_360__c> listOfP360 = new List<Participant_360__c>(); 
        
        for(Id contactId : mapOfGoalCount.keyset())
        {
            
            System.debug('mapOfYears:' +contactId);
            for(String year : mapOfGoalCount.get(contactId).keyset())
            {
                System.debug('year :' +year);
                Set<Goal__c> setOfGoal = mapOfGoalCount.get(contactId).get(year);
                System.debug('setOfGoal==>' +setOfGoal);
                System.debug('setOfGoal==>' +setOfGoal.size());
                
                List<Goal__c> newGoals = new List<Goal__c>();
                String goalIds = '';
                for(Goal__c gg : setOfGoal)
                {
                    newGoals.add(gg);
                    goalIds+=gg.Name+';';
                    System.debug('gg:' +newGoals.size());
                    System.debug('goalIds' + goalIds);
                    if(gg.Set_Date__c!=null && string.valueOf(gg.Set_Date__c.year()) == year)
                    {
                        System.debug('gg' +gg);
                    }
                    system.debug(newGoals.size());   
                }
                if(contactYearP360.get(contactId) != null  && contactYearP360.get(contactId).get(year) != null)
                {
                    System.debug('conp360: '+contactYearP360.get(contactId).get(year));
                    Participant_360__c p360 = contactYearP360.get(contactId).get(year);
                    System.debug(p360);
                    p360.Goals_Created_IDs_Jan__c+= goalIds;
                    //p360.Goals_Created_IDs_Jan__c += goalIds != null ? goalIds : ' ';
                    System.debug(p360.Goals_Created_IDs_Jan__c);
                    p360.Total_number_of_Goal_Counts1__c +=newGoals.size();
                    System.debug(p360.Total_number_of_Goal_Counts1__c);
                    listOfP360.add(p360);
                    System.debug('listOfP360:' +listOfP360);
                }
                else
                {
                    //Goal__c goal1 = mapOfGoal.values();
                    Participant_360__c p360 = new Participant_360__c();
                    p360.Contact__c = contactId;
                    System.debug('contactId:' +p360.Contact__c);
                    p360.Name = mapOfContacts.get(contactId).Name+' - '+' Participant360 '+' : '+string.valueOf(year);
                    System.debug('p360Name==>' +p360.Name);
                    p360.Participated_Year__c = String.valueOf(year);  // year is must
                    System.debug('p360Participated_Year__c==>' +p360.Participated_Year__c);
                    p360.Goals_Created_IDs_Jan__c = goalIds;
                    //p360.Goals_Created_IDs_Jan__c = goalIds != null ? goalIds : ' ';
                    System.debug('goalId is' + p360.Goals_Created_IDs_Jan__c);
                    p360.Total_number_of_Goal_Counts1__c = newGoals.size(); // error from integer to string
                    System.debug('p360Goals_Created_ID__c==>' +p360.Total_number_of_Goal_Counts1__c);
                    listOfP360.add(p360);
                    system.debug('listOfp360' +listOfP360);  
                }
            }           
        }        
        
        
        if(listOfP360.size()>0)
        {
            upsert listOfP360;
            system.debug(listOfP360);
        }
        
        for(Participant_360__c p360 : listOfP360)
        {
            system.debug('p360:' +p360);
            if(contactYearP360.containsKey(p360.Contact__c))
            {
                contactYearP360.get(p360.Contact__c).put(String.valueOf(p360.Participated_Year__c),p360);
                system.debug('contactYearP360 :' +contactYearP360);
                system.debug('contactYearP360 :' +contactYearP360.keyset());
                system.debug('contactYearP360 :' +contactYearP360.values());
            }
            else
            {
                contactYearP360.put(p360.Contact__c,new Map<String,Participant_360__c>{String.valueOf(p360.Participated_Year__c) => p360});
                system.debug('contactYearP360 :' +contactYearP360);
            }
            system.debug('contactYearP360 :' +contactYearP360);
            system.debug('contactYearP360 :' +contactYearP360.keyset());
            system.debug('contactYearP360 :' +contactYearP360.values());   
        }
        
        
        List<Affiliated_Goals__c> affGoalList = new List<Affiliated_Goals__c>();
        for(Goal__c goal : goalList)
        {
            System.debug('goal:' +goal);
            if(mapOfYears.get(goal)!=null)
            {
                System.debug('mapOfYears:' +mapOfYears);
                for(String year : mapOfYears.get(goal))
                {
                    System.debug('year:' +year);
                    
                    if(mapOfAffGoals.get(goal.Id) == null)
                    {
                        System.debug('mapOfAffGoals:' +mapOfAffGoals);
                        Affiliated_Goals__c newAffGoal = new Affiliated_Goals__c();
                        newAffGoal.Goal__c = goal.id;
                        newAffGoal.Participant_360__c = contactYearP360.get(goal.Contact__c).get(year).Id ;
                        System.debug(newAffGoal.Participant_360__c);
                        newAffGoal.Name = goal.Name+ '-' +String.valueOf(year);
                        newAffGoal.Year_exist__c = String.valueOf(year);
                        System.debug(newAffGoal.Year_exist__c);
                        affGoalList.add(newAffGoal); 
                        System.debug('affGoalList :' +affGoalList);
                    }
                    else
                    {
                        if(mapOfAffGoals.get(goal.id).get(year) == null){
                            System.debug('mapOfAffGoals:' +mapOfAffGoals);
                            Affiliated_Goals__c newAffGoal = new Affiliated_Goals__c();
                            newAffGoal.Goal__c = goal.id;
                            newAffGoal.Participant_360__c = contactYearP360.get(goal.Contact__c).get(year).id;
                            System.debug('Participant_360__c:' +newAffGoal.Participant_360__c);
                            newAffGoal.Name = goal.Name+ '-' +String.valueOf(year);
                            newAffGoal.Year_exist__c = String.valueOf(year);
                            System.debug('yearExist:' +newAffGoal.Year_exist__c);
                            affGoalList.add(newAffGoal);      
                        }
                        
                    }
                }
                
            }
        }
        if(!affGoalList.isEmpty())
        {
            insert affGoalList;   
        }
        system.debug('AffGoals==='+affGoalList);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* string Contactyear = Id.valueOf(goal.Contact__c) + '-'+ string.valueOf(goal.Set_Date__c.year());
system.debug('contactyear=='+Contactyear);

if(!contactYearGoalMap.containsKey(Contactyear))
{
contactYearGoalMap.put(Contactyear, new set<Id>()) ; 
system.debug('contactYearGoalMap=='+contactYearGoalMap);
}
contactYearGoalMap.get(Contactyear).add(goal.Id);
system.debug(contactYearGoalMap);

system.debug(mapOfGoalCount);
mapOfGoal.put(goal.id, goal);  
system.debug(mapOfGoal);
contactId.add(goal.Contact__c);
system.debug(contactId);
goalYears.add( string.valueOf(goal.Set_Date__c.year())); 
system.debug(goalYears);
mapOfGoalYears.put(goal.id,string.valueOf(goal.Set_Date__c.year()));
//string goalYear =  Id.valueOf(goal.Id)+' - '+string.valueOf(goal.Set_Date__c.year());


}
}


system.debug('contactYearGoalMap>> '+contactYearGoalMap);
system.debug('contactYearGoalMap>> '+contactYearGoalMap.keyset()); // contact id and its associated year
system.debug('contactYearGoalMap>> '+contactYearGoalMap.values());
system.debug('contactYearGoalMap>> '+contactYearGoalMap.isEmpty());
system.debug('contactYearGoalMap>> '+!contactYearGoalMap.isEmpty());
system.debug('mapoOfGoal>>'+mapOfGoal);  //goal record
system.debug('mapoOfGoal>> '+mapOfGoal.keyset());
system.debug('mapoOfGoal>> '+mapOfGoal.values());
system.debug('mapOfGoalYears>> '+mapOfGoalYears);
system.debug('mapOfGoalYears>> '+mapOfGoalYears.keyset());
system.debug('mapOfGoalYears>> '+mapOfGoalYears.values());

for(Goal__c goal : goalList)
{
system.debug(goal);

mapOfYears.put(goal.id,years); 

system.debug(mapOfYears);
if(mapOfYears.containsKey(goal.id))
{
System.debug(mapOfYears);
for(String year : mapOfYears.get(goal.id ))
{
system.debug('Year==>' +Year);
if(mapOfGoalCount.containskey(goal.Contact__c))
{
if(mapOfGoalCount.get(goal.Contact__c).containsKey(year))
{
mapOfGoalCount.get(goal.Contact__c).get(year).add(goal); 
System.debug('mapOfGoalCount==>' +mapOfGoalCount);
}  
else
{
mapOfGoalCount.get(goal.Contact__c).put(year,new Set<Goal__c>{goal}); 
System.debug('mapOfGoalCount==' +mapOfGoalCount);
}   
}


else
{
mapOfGoalCount.put(goal.Contact__c,new Map<String,Set<Goal__c>>{year => new Set<Goal__c>{goal}});  
system.debug(mapOfGoalCount);
}
List<Goal__c> listOfGoal = new List<Goal__c> ();
Set<Goal__c> setOfGoals = mapOfGoalCount.get(goal.Contact__c).get(year);
for(Goal__c gg:setOfGoals)
{

if(gg.Set_Date__c != null && String.valueOf(gg.Set_Date__c.year()) == year )
{


listOfGoal.add(gg);  
}
}

}


}

}


Map<string,Participant_360__c> contactYearP360 = new Map<string,Participant_360__c>();
for(Participant_360__c p30List: [ SELECT Id, Contact__c, Participant_360_Name__c, Participated_Year__c,Goals_Created_ID__c, Total_number_of_AffGoal_Counts__c 
FROM Participant_360__c
WHERE Participated_Year__c IN : years AND Contact__c IN: contactId])
{
Set<Goal__c> setOfGoal = mapOfGoalCount.get(goal.Contact__c).get(year);



string Contactyear = Id.valueOf(p30List.Contact__c) + '-' + p30List.Participated_Year__c; // existing contactid and year
system.debug('Contactyear=='+Contactyear);
contactYearP360.put(Contactyear, p30List) ; 
system.debug('conp360==> '+contactYearP360);
system.debug('conp360Key==> '+contactYearP360.keyset());
system.debug('conp360value==> '+contactYearP360.values());



p30List.Goals_Created_ID__c = String.valueOf(contactYearP360.size()+1);
system.debug('p30List:' +p30List);
system.debug( p30List.Goals_Created_ID__c);
//system.debug(mapOfGoalCount);
}
for(string contactYear:contactYearGoalMap.keyset())                  
{
system.debug(contactYear);
system.debug(contactYearP360.containskey(contactYear));
system.debug(!contactYearP360.containskey(contactYear));
if(!contactYearP360.containskey(contactYear)) // check contactid and year is not means,create new participant
{
Id goalId = new List<Id>(contactYearGoalMap.get(contactYear))[0]; // to store the goal ids
system.debug('goalId=='+goalId);
// Goal__c goals =   mapOfGoal.get(goalId); // return the 
// system.debug('goals==>'+goals);
Participant_360__c newParticipant = new Participant_360__c();
// newParticipant.Id = goals.Participant_360__c;
newParticipant.Id = mapOfGoal.get(goalId).Participant_360__c;
// newParticipant.Contact__c = goals.Contact__c;
newParticipant.Contact__c = mapOfGoal.get(goalId).Contact__c;
// newParticipant.Name = goals.Contact_Name__c +' '+ goals.Set_Date__c.year() +' : '+ goals.Name;  
newParticipant.Name = mapOfGoal.get(goalId).Contact_Name__c+' - '+' Participant360 '+' : '+mapOfGoal.get(goalId).Set_Date__c.year();
//newParticipant.Participant_360_Name__c = goals.Set_Date__c.year()+' - '+goals.Contact_Name__c+' Participant 360 '+' ';
newParticipant.Participant_360_Name__c = mapOfGoal.get(goalId).Set_Date__c.year()+' - '+mapOfGoal.get(goalId).Contact_Name__c+' Participant 360 '+' ';
//newParticipant.Participated_Year__c = string.valueOf(goals.Set_Date__c.year());
newParticipant.Participated_Year__c = mapOfGoalYears.get(goalId);
//contactYearP360.put(Id.valueOf(goals.Contact__c)+ '-' +string.valueOf(goals.Set_Date__c.year()),newParticipant); 
newParticipant.Goals_Created_ID__c = string.valueOf('1');
system.debug(newParticipant.Goals_Created_ID__c);
//contactYearP360.get(Contactyear).Goals_Created_ID__c = (contactYearP360.get(Contactyear).Goals,1);
contactYearP360.put(mapOfGoal.get(goalId).Contact__c+ '-' +mapOfGoalYears.get(goalId),newParticipant); 
system.debug('contactYearP360=='+contactYearP360);
}
}

if(!contactYearP360.isEmpty())
{
upsert contactYearP360.values(); // for updating the existing and inserting the new
}
system.debug('contactYearP360>> ' +contactYearP360.values());
system.debug('contactYearP360>> ' +contactYearP360.keyset());
system.debug('contactYearP360>> ' +contactYearP360.isEmpty());
system.debug('contactYearP360>> ' +!contactYearP360.isEmpty());
if(!contactYearGoalMap.isEmpty())
{
List<Affiliated_Goals__c> AffGoals = new List<Affiliated_Goals__c>();
for(string contactYear : contactYearGoalMap.keyset())
{
system.debug('con==>'+contactYear);
system.debug(contactYearGoalMap.containsKey(contactYear));
system.debug(!contactYearGoalMap.containsKey(contactYear));
if(contactYearGoalMap.containsKey(contactYear) && !contactYearGoalMap.get(contactYear).isEmpty())
{
for(Id goalId : contactYearGoalMap.get(contactYear)) // to check contactYearGaolMap.values()
{
system.debug('goalId=='+goalId);
Affiliated_Goals__c newAffGoal = new Affiliated_Goals__c();
newAffGoal.Goal__c = goalId;
newAffGoal.Participant_360__c = contactYearP360.get(contactYear).Id ;
newAffGoal.Name = mapOfGoal.get(goalId).Name+ '-' +mapOfGoal.get(goalId).Set_Date__c.year();
newAffGoal.Year_exist__c = contactYearP360.get(contactYear).Participated_Year__c;
AffGoals.add(newAffGoal);  
}
}
}

if(!AffGoals.isEmpty())
{
insert AffGoals;   
}
system.debug('AffGoals==='+AffGoals);
}
}*/
    
    
    
    
    
    // After update on goal object  (update met/drop date trigger to decrease the count)     
    
    public static void afterUpdate(List<Goal__c> listOfGoal,Map<Id,Goal__c> OldMapOfGoal)
    {
        Map<String,Affiliated_Goals__c> mapOfAffGoal = new  Map<String,Affiliated_Goals__c>();
        Set<Id> contactId  = new Set<Id>();
        Set<String> years = new Set<String>();
        Map<Id,Map<String,Set<Goal__c>>> mapOfGoalCount = new Map<Id,Map<String,Set<Goal__c>>>();
        Map<Id,Set<String>> mapOfGoalYears = new Map<Id,Set<String>>();
        Map<string,Set<String>> contactYearGoalMap  = new Map<string,set<String>>();
        Map<Id,Goal__c> mapOfGoal = new Map<Id,Goal__c>();
        Map<Goal__c,Set<String>> mapOfYears = new Map<Goal__c,Set<String>>();
        
        for(Goal__c goals : listOfGoal)
        { 
            system.debug('goals:' +goals);
            if(( goals.Set_Date__c!=null) || (goals.Met_Date__c != OldMapOfGoal.get(goals.id).Met_Date__c && goals.Met_Date__c!=null)
               || ( goals.Goal_Dropped_Date__c != OldMapOfGoal.get(goals.id).Goal_Dropped_Date__c && goals.Goal_Dropped_Date__c!=null) )
            {
                system.debug(goals);
                contactId.add(goals.Contact__c);
                
            }
        }
        Map<Id,Contact> mapOfContacts = new Map<Id,Contact>([Select Id, Name FROM Contact WHERE ID IN:contactId]);
        
        Map<Id,Map<String,Affiliated_Goals__c>> mapOfAffGoals = new Map<Id,Map<String,Affiliated_Goals__c>>();
        List<Affiliated_Goals__c> listOfAffGoals = [SELECT Year_exist__c, Id, Goal__c, Participant_360__c FROM Affiliated_Goals__c WHERE Goal__c IN:listOfGoal];
        System.debug('listOfAffGoals:' +listOfAffGoals);
        List<Affiliated_Goals__c> listOfAffGoals1 = [SELECT Year_exist__c, Id, Goal__c, Participant_360__c FROM Affiliated_Goals__c WHERE Goal__c IN:listOfGoal ORDER BY Year_exist__c ASC];
        System.debug('listOfAffGoals:' +listOfAffGoals1);
        
        if(listOfAffGoals1!=null)
        {
            for(Affiliated_Goals__c AffGoals : listOfAffGoals1 )
            {
                system.debug('AffGoals:' +AffGoals);
                if(mapOfAffGoals.containsKey(AffGoals.Goal__c))
                {
                    system.debug(mapOfAffGoals);
                    mapOfAffGoals.get(AffGoals.Goal__c).put(String.valueOf(AffGoals.Year_exist__c),AffGoals);
                    System.debug('mapOfAffGoals:' +mapOfAffGoals);
                }
                else 
                {
                    if(AffGoals.Year_exist__c != null)
                        
                        mapOfAffGoals.put(AffGoals.Goal__c,new Map<String,Affiliated_Goals__c>{String.valueOf(AffGoals.Year_exist__c) => AffGoals});
                    System.debug('mapOfAffGoals:' +mapOfAffGoals);
                }
                System.debug('mapOfAffGoals:' +mapOfAffGoals);    
            }
            System.debug('mapOfAffGoals:' +mapOfAffGoals);
            
        }
        system.debug('mapOfAffGoals:' +mapOfAffGoals);
        
        for(Goal__c goal : [SELECT Id, Name, Contact__c, Set_Date__c, Participant_360__c,Met_Date__c,Goal_Dropped_Date__c 
                            FROM Goal__c WHERE Contact__c IN:contactId])
        {
            if(goal.Set_Date__c!=null )
            {
                System.debug('goal:' +goal.Set_Date__c);
                years.add(String.valueOf(goal.Set_Date__c.year()));
                system.debug(years);
            }
            if(goal.Set_Date__c!=null && goal.Met_Date__c!=null && goal.Set_Date__c.year()!=goal.Met_Date__c.year())
            {
                System.debug('goal:' +goal.Met_Date__c);
                System.debug(goal.Set_Date__c.year()!=goal.Met_Date__c.year());
                years.add(String.valueOf(goal.Met_Date__c.year()));
                system.debug(years);
            }
            if(goal.Set_Date__c!=null && goal.Goal_Dropped_Date__c!=null && goal.Set_Date__c.year()!=goal.Goal_Dropped_Date__c.year())
            {
                System.debug('goal:' +goal.Goal_Dropped_Date__c);
                System.debug(goal.Set_Date__c.year()!=goal.Goal_Dropped_Date__c.year());
                years.add(String.valueOf(goal.Goal_Dropped_Date__c.year()));
                system.debug(years);
            }
            mapOfGoalYears.put(goal.id,years);
            system.debug('mapOfYears :' +mapOfGoalYears);
            system.debug('mapOfYears :' +mapOfGoalYears.keyset());
            system.debug('mapOfYears :' +mapOfGoalYears.values());
        }
        
        for(Goal__c goal :[SELECT Id, Name, Contact__c, Goal_Dropped_Date__c, Goal_Status__c, Participant_360__c, Met_Date__c, Set_Date__c 
                           FROM Goal__c WHERE Contact__c IN:contactId] )
        {
            if(mapOfGoalYears.containsKey(goal.id))
            {
                system.debug(mapOfGoalYears.keyset());
                system.debug(mapOfGoalYears.values());
                for(String year : mapOfGoalYears.get(goal.id))
                {
                    if(mapOfGoalCount.containsKey(goal.Contact__c))
                    {
                        if(mapOfGoalCount.get(goal.Contact__c).containsKey(year))
                        {
                            mapOfGoalCount.get(goal.Contact__c).get(year).add(goal);
                            System.debug('mapOfGoalCount is:' +mapOfGoalCount);
                        }
                        else
                        {
                            mapOfGoalCount.get(goal.Contact__c).put(year, new Set<Goal__c>{goal});  
                            System.debug('mapOfGoalCount is:' +mapOfGoalCount);
                        }
                    }
                    else
                    {
                        mapOfGoalCount.put(goal.Contact__c,new Map<String,Set<Goal__c>>{year => new Set<Goal__c>{goal}});
                        System.debug('mapOfGoalCount is:' +mapOfGoalCount);
                    }
                }
            }
        }
        System.debug('mapOfGoalCount is:' +mapOfGoalCount);
        
        Map<Id,Map<string,Participant_360__c>> contactYearP360 = new Map<Id,Map<string,Participant_360__c>>();
        for(Participant_360__c p30List: [ SELECT Id, Contact__c, Participant_360_Name__c, Participated_Year__c,Goals_Created_ID__c, Total_number_of_AffGoal_Counts__c 
                                         FROM Participant_360__c
                                         WHERE  Contact__c IN: contactId])
        {
            System.debug('p30List :' +p30List);
            if(contactYearP360.containsKey(p30List.Contact__c))
            {
                System.debug('contactYearP360 :' +contactYearP360);
                contactYearP360.get(p30List.Contact__c).put(String.valueOf(p30List.Participated_Year__c),p30List);
                System.debug('contactYearP360 :' +contactYearP360);
            }
            else
            {
                System.debug('contactYearP360 :' +contactYearP360);
                contactYearP360.put(p30List.Contact__c,new Map<String,Participant_360__c>{String.valueOf(p30List.Participated_Year__c) => p30List }) ; 
                System.debug('contactYearP360 :' +contactYearP360);
                System.debug('contactYearP360 :' +contactYearP360.keyset());
                System.debug('contactYearP360 :' +contactYearP360.values());
            }
            
        }
        
        List<Participant_360__c> listOfP360 = new List<Participant_360__c>(); 
        for(Goal__c goal : listOfGoal)
        {
            System.debug('goal :' +goal);
            if(mapOfGoalYears.containsKey(goal.id))
            {
                System.debug('mapOfYears:' +mapOfGoalYears);
                for(String year : mapOfGoalYears.get(goal.id))
                {
                    System.debug('year :' +year);
                    Set<Goal__c> setOfGoals = mapOfGoalCount.get(goal.Contact__c).get(year);
                    System.debug('setOfGoals:' +setOfGoals);
                    List<Goal__c> listOfGoals = new List<Goal__c>();
                    List<Goal__c> metOfGoals =new List<Goal__c>();
                    List<Goal__c> dropOfGoals =new List<Goal__c>();
                    List<Goal__c> newGoals = new  List<Goal__c>();
                    String metIDs = '';
                    String droppedIDs = '';
                    System.debug('setOfGoal==>' +setOfGoals);
                    System.debug('setOfGoal==>' +setOfGoals.size());
                    
                    for(Goal__c gg : setOfGoals)
                    {
                        System.debug('gg:' +gg);
                        if(gg.Set_Date__c!=null && string.valueOf(gg.Set_Date__c.year()) == year)
                        {
                            System.debug('gg' +gg);
                            newGoals.add(gg);
                            system.debug(newGoals);
                        }
                        system.debug(newGoals.size()); 
                        
                        if(gg.Met_Date__c!=null && String.valueOf(gg.Met_Date__c.year()) == year)
                        {
                            System.debug('gg' +gg);
                            metOfGoals.add(gg);
                            listOfGoals.add(gg);
                            metIDs+=gg.Name+';';
                            System.debug(metOfGoals); 
                            System.debug(metIDs);
                        }
                        System.debug(metOfGoals.size()); 
                        System.debug(metIDs);
                        
                        if(gg.Goal_Dropped_Date__c!=null && string.valueOf(gg.Goal_Dropped_Date__c.year()) == year)
                        {
                            System.debug('gg' +gg);
                            dropOfGoals.add(gg);
                            listOfGoals.add(gg);
                            
                            droppedIDs+=gg.Name+';';
                            System.debug(dropOfGoals);
                            System.debug(droppedIDs);
                            
                        }
                        System.debug(dropOfGoals.size()); 
                        System.debug(droppedIDs);
                    }
                    System.debug(metOfGoals.size()); 
                    System.debug(metIDs);
                    System.debug(dropOfGoals.size());
                    System.debug(droppedIDs);
                    system.debug(listOfGoals.size());
                    
                    if(contactYearP360.get(goal.Contact__c) != null  && contactYearP360.get(goal.Contact__c).get(year) != null)
                    {
                        System.debug('contactYearP360 is:' +contactYearP360.get(goal.Contact__c) + '-' + contactYearP360.get(goal.Contact__c).get(year));
                        Participant_360__c p360 =   contactYearP360.get(goal.Contact__c).get(year);
                        p360.Goals_Created_ID__c = string.valueOf(listOfGoals.size());
                        System.debug(p360.Goals_Created_ID__c);
                        p360.Goals_Met_ID__c = String.valueOf(metOfGoals.size());
                        p360.Goals_Dropped_ID__c = String.valueOf(dropOfGoals.size());
                        p360.Goals_Met_IDs_Jan__c = metIDs;
                        //p360.Goals_Met_IDs_Jan__c = metIDs != null ? metIDs : null;
                        System.debug(p360.Goals_Met_IDs_Jan__c);
                        p360.Goals_Dropped_IDs_Jan__c = droppedIDs;
                        //p360.Goals_Dropped_IDs_Jan__c = droppedIDs != null ? droppedIDs : null;
                        System.debug( p360.Goals_Dropped_IDs_Jan__c);
                        listOfP360.add(p360);
                        System.debug('listOfP360:' +listOfP360);
                    }
                    else
                    {
                        //Goal__c goal1 = mapOfGoal.values();
                        Participant_360__c p360 = new Participant_360__c();
                        p360.Contact__c = goal.Contact__c;
                        p360.Name = mapOfContacts.get(goal.Contact__c).Name+' - '+' Participant360 '+' : '+string.valueOf(year);
                        System.debug('p360Name==>' +p360.Name);
                        p360.Participated_Year__c = String.valueOf(year);  // year is must
                        System.debug('p360Participated_Year__c==>' +p360.Participated_Year__c);
                        p360.Participant_360_Name__c = String.valueOf(year)+' - '+goal.Contact_Name__c+' Participant 360 '+' ';
                        System.debug('p360Participant_360_Name__c==>' +p360.Participant_360_Name__c);
                        p360.Goals_Created_ID__c = string.valueOf(listOfGoals.size());
                        p360.Goals_Met_ID__c = String.valueOf(metOfGoals.size());
                        p360.Goals_Dropped_ID__c = String.valueOf(dropOfGoals.size());
                        p360.Goals_Met_IDs_Jan__c = metIDs;
                        //p360.Goals_Met_IDs_Jan__c = metIDs != null ? metIDs : null;
                        System.debug(p360.Goals_Met_IDs_Jan__c);
                        p360.Goals_Dropped_IDs_Jan__c = droppedIDs;
                        //p360.Goals_Dropped_IDs_Jan__c = droppedIDs != null ? droppedIDs : null;
                        System.debug( p360.Goals_Dropped_IDs_Jan__c);
                        System.debug('p360Goals_Created_ID__c==>' +p360.Goals_Created_ID__c);
                        System.debug('p360Goals_Created_ID__c==>' +p360.Goals_Met_ID__c);
                        System.debug('p360Goals_Created_ID__c==>' +p360.Goals_Dropped_ID__c);
                        listOfP360.add(p360);
                        system.debug('listOfp360' +listOfP360);  
                    }
                }           
            }        
        }
        
        if(listOfP360.size()>0)
        {
            upsert listOfP360;
            system.debug(listOfP360);
        }
        
        for(Participant_360__c p360 : listOfP360)
        {
            system.debug('p360:' +p360);
            if(contactYearP360.containsKey(p360.Contact__c))
            {
                contactYearP360.get(p360.Contact__c).put(String.valueOf(p360.Participated_Year__c),p360);
                system.debug('contactYearP360 :' +contactYearP360);
                system.debug('contactYearP360 :' +contactYearP360.keyset());
                system.debug('contactYearP360 :' +contactYearP360.values());
            }
            else
            {
                contactYearP360.put(p360.Contact__c,new Map<String,Participant_360__c>{String.valueOf(p360.Participated_Year__c) => p360});
                system.debug('contactYearP360 :' +contactYearP360);
            }
            system.debug('contactYearP360 :' +contactYearP360);
            system.debug('contactYearP360 :' +contactYearP360.keyset());
            system.debug('contactYearP360 :' +contactYearP360.values());   
        }       
        
        List<Affiliated_Goals__c> affGoalList = new List<Affiliated_Goals__c>();
        for(Goal__c goal :listOfGoal )
        {
            if(mapOfGoalYears.containsKey(goal.id))
            {
                for(String year : mapOfGoalYears.get(goal.id))
                {
                    if(mapOfAffGoals.get(goal.Id) == null)
                    {
                        System.debug('mapOfAffGoals:' +mapOfAffGoals);
                        Affiliated_Goals__c newAffGoal = new Affiliated_Goals__c();
                        newAffGoal.Goal__c = goal.id;
                        newAffGoal.Participant_360__c = contactYearP360.get(goal.Contact__c).get(year).Id ;
                        System.debug(newAffGoal.Participant_360__c);
                        newAffGoal.Name = goal.Name+ '-' +String.valueOf(year);
                        newAffGoal.Year_exist__c = String.valueOf(year);
                        System.debug(newAffGoal.Participant_360__c);
                        affGoalList.add(newAffGoal); 
                        System.debug('affGoalList :' +affGoalList);  
                    }
                    else
                    {
                        if(mapOfAffGoals.get(goal.id).get(year) == null)
                        {
                            System.debug('mapOfAffGoals:' +mapOfAffGoals);
                            Affiliated_Goals__c newAffGoal = new Affiliated_Goals__c();
                            newAffGoal.Goal__c = goal.id;
                            newAffGoal.Participant_360__c = contactYearP360.get(goal.Contact__c).get(year).id;
                            System.debug('Participant_360__c:' +newAffGoal.Participant_360__c);
                            newAffGoal.Name = goal.Name+ '-' +String.valueOf(year);
                            newAffGoal.Year_exist__c = String.valueOf(year);
                            System.debug('yearExist:' +newAffGoal.Year_exist__c);
                            affGoalList.add(newAffGoal);      
                        }
                        
                    }
                }
                
            }
        }
        
        if(affGoalList.size() > 0)
        {
            insert affGoalList;   
        }
        system.debug('AffGoals==='+affGoalList);
        
        For(Affiliated_Goals__c AffGoals : affGoalList )
        {
            system.debug('AffGoals:' +AffGoals);
            if(mapOfAffGoals.containsKey(AffGoals.Goal__c))
            {
                system.debug(mapOfAffGoals);
                mapOfAffGoals.get(AffGoals.Goal__c).put(String.valueOf(AffGoals.Year_exist__c),AffGoals);
                System.debug('mapOfAffGoals:' +mapOfAffGoals);
            }
            else
            {
                mapOfAffGoals.put(AffGoals.Goal__c,new Map<String, Affiliated_Goals__c>{String.valueOf(AffGoals.Year_exist__c)=>AffGoals}); 
            }
        }
        
        Set<Affiliated_Goals__c> affGoalDelete = new Set<Affiliated_Goals__c>();
        for(Goal__c goal : listOfGoal)
        {
            if(mapOfGoalYears.containsKey(goal.id))
            {
                For(String year : mapOfAffGoals.get(goal.id).keyset())
                {
                    System.debug('goalyear'+ year);
                    affGoalDelete.add(mapOfAffGoals.get(goal.id).get(year));
                }
                
                For(String year:mapOfGoalYears.get(goal.id))
                {
                    System.debug('goalyear' +year);
                    if(mapOfAffGoals.get(goal.id)!=null)
                    {
                        System.debug(mapOfAffGoals);
                        if(mapOfAffGoals.get(goal.id).containsKey(year))
                        {
                            System.debug(mapOfAffGoals);
                            affGoalDelete.remove(mapOfAffGoals.get(goal.id).get(year));
                        }
                    }
                }
            }
        }
        
        if(!affGoalDelete.isEmpty())
        {
            List<Affiliated_Goals__c> AffGoalListDel = new List<Affiliated_Goals__c>();
            AffGoalListDel.addAll(affGoalDelete);
            delete AffGoalListDel;
        }
        
        
        
        
        
        /*List<Affiliated_Goals__c> listOfAffgoal = new List<Affiliated_Goals__c>();
set<Id> setofIds = new set<Id>();
for(Goal__c goals : listOfGoal)
{ 
if((goals.Met_Date__c != OldMapOfGoal.get(goals.id).Met_Date__c) || (goals.Goal_Dropped_Date__c != OldMapOfGoal.get(goals.id).Goal_Dropped_Date__c) )
{
setofIds.add(goals.id);
}
system.debug(setofIds);
List<Affiliated_Goals__c> affGoals =[ SELECT Id, Name, Goal__c, Participant_360__c, Status__c, Year_exist__c FROM Affiliated_Goals__c WHERE Goal__c IN:setofIds];
system.debug(affGoals);
for(Affiliated_Goals__c aff:affGoals)
{

listOfAffgoal.add(aff);
}
delete affGoals;
system.debug(affGoals);
}*/
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /* if(gg.Set_Date__c!=null && string.valueOf(gg.Set_Date__c.year()) == year)
{
newGoals.add(gg);
newGoals.size();
system.debug(newGoals.size());
}*/
        /*  if(gg.Met_Date__c!=null && String.valueOf(gg.Met_Date__c.year()) == year)
{
metGoals.add(gg); 
metGoals.size();
system.debug(metGoals.size());
}  
if(gg.Goal_Dropped_Date__c!=null && string.valueOf(gg.Goal_Dropped_Date__c.year()) == year)
{
dropGoals.add(gg);
dropGoals.size();
system.debug(dropGoals.size()); 
}
}
system.debug('newGoals==>' +newGoals.size());
system.debug('metgoals==>' +metGoals.size());
}
}
List<Participant_360__c> createParticipant = new List<Participant_360__c>();
Map<String, Participant_360__c> mapOfP360 = new Map<String, Participant_360__c>();
For(Participant_360__c p360List:[SELECT Id, Name, Contact__c, Participant_360_Name__c, Participated_Year__c, Goals_Created_ID__c, Goals_Met_ID__c, Goals_Dropped_ID__c 
FROM Participant_360__c Where Contact__c IN:contactId ] )
{
system.debug(p360List);
string conYear = Id.valueOf(p360List.Contact__c);
system.debug(conYear);
if(!mapOfP360.containsKey(conYear))
{
mapOfP360.put(conYear,p360List); 
system.debug(mapOfP360);
}
system.debug(mapOfP360);
system.debug(mapOfP360.keyset());
system.debug(mapOfP360.values());
}
for(string contactYear:mapOfP360.keyset())
{
system.debug('contactYear:' +contactYear);
if(mapOfP360.containsKey(contactYear))
{
Participant_360__c pp =  mapOfP360.values();
system.debug(pp);
pp.Goals_Created_ID__c = string.valueOf(newGoals.size());
system.debug('createdgoals' +pp);
pp.Goals_Met_ID__c = string.valueOf(metGoals.size());
system.debug('metGoals:' +pp);
createParticipant.add(pp);
system.debug(createParticipant);
}
else
{
Goal__c goal1 = mapOfGoal.values();
system.debug(goal1);
Participant_360__c pp = new  Participant_360__c();
pp.Contact__c = goal1.Contact__c;
pp.Name = goal1.Name+' Participant360 '+string.valueOf(years);
pp.Participated_Year__c = String.valueOf(years);
pp.Id = goal1.Participant_360__c;
pp.Participant_360_Name__c = goal1.Set_Date__c.year()+' - '+goal1.Contact_Name__c+' Participant 360 '+' ';
pp.Goals_Created_ID__c = string.valueOf(newGoals.size());
pp.Goals_Met_ID__c = string.valueOf(metGoals.size());
createParticipant.add(pp);
system.debug(createParticipant);
}
}
upsert createParticipant;
system.debug(createParticipant);
/* for(Goal__c goals:goal)    
{
if(!contactYearGoalMap.containsKey(goals.Contact__c))
{
contactYearGoalMap.put(goals.Contact__c,new Set<String>());
system.debug(contactYearGoalMap.keyset());
system.debug(contactYearGoalMap.values());
}
else
{
contactYearGoalMap.get(goals.Contact__c).addAll(years);
System.debug(contactYearGoalMap.keyset());
System.debug(contactYearGoalMap.values());  
}   

}
for(Goal__c goals:goal)
{
if(mapOfGoalYears.containsKey(goals.Id))
{
system.debug('mapOfGoalYears:' +mapOfGoalYears);
system.debug('mapOfGoalYears:' +mapOfGoalYears.keyset());
system.debug('mapOfGoalYears:' +mapOfGoalYears.values());
for(String year : mapOfGoalYears.get(goals.Id))
{ 
system.debug('year==>'+year);
if(mapOfGoalsCount.containsKey(goals.Contact__c)) 
{
if(mapOfGoalsCount.get(goals.Contact__c).containsKey(year))
{
system.debug('mapOfGoalsCount:' + mapOfGoalsCount);
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.keyset());
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.values());
mapOfGoalsCount.get(goals.Contact__c).get(year).add(goals);
system.debug('mapOfGoalsCount:' + mapOfGoalsCount);
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.keyset());
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.values());
}
else
{
mapOfGoalsCount.get(goals.Contact__c).put(year,new Set<Goal__c>{goals});
system.debug('mapOfGoalsCount:' + mapOfGoalsCount);
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.keyset());
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.values()); 
}
}
else
{
mapOfGoalsCount.put(goals.Contact__c,new Map<String,Set<Goal__c>>{year => new Set<Goal__c>{goals}});
system.debug('mapOfGoalsCount:' + mapOfGoalsCount);
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.keyset());
system.debug('mapOfGoalsCount:' + mapOfGoalsCount.values());    
}

}
}

system.debug(mapOfGoalsCount.values());
mapOfGoals.put(goals.Id,goals);
system.debug('mapOfGoals:' +mapOfGoals);
system.debug('mapOfGoals:' +mapOfGoals.keyset());
system.debug('mapOfGoals:' +mapOfGoals.values());
}

Map<Id,Map<String,Participant_360__c>> mapOfP360 = new Map<Id,Map<String,Participant_360__c>>();
for(Participant_360__c p360: [SELECT Id, Name, Contact__c, Participated_Year__c, Participant_360_Name__c, Goals_Created_ID__c, Goals_Met_ID__c, Goals_Dropped_ID__c 
FROM Participant_360__c 
WHERE Contact__c IN: contactId])
{
system.debug(p360);
if(mapOfP360.containsKey(p360.Contact__c))
{
mapOfP360.get(p360.Contact__c).put(String.valueOf(p360.Participated_Year__c),p360);
system.debug('mapOfP360:' +mapOfP360);
system.debug('mapOfP360:' +mapOfP360.keyset());
system.debug('mapOfP360:' +mapOfP360.values());
}
else
{
mapOfP360.put(p360.Contact__c,new Map<String,Participant_360__c>{string.valueOf(p360.Participated_Year__c) => p360});
system.debug('mapOfP360:' +mapOfP360);
system.debug('mapOfP360:' +mapOfP360.keyset());
system.debug('mapOfP360:' +mapOfP360.values());  
}

}

/* List<Participant_360__c> listOfP360 = new  List<Participant_360__c>();
for(Goal__c goals: goal)
{
system.debug(goals);
if(mapOfGoalYears.containsKey(goals.Id))
{
system.debug('mapOfGoalYears:' +mapOfGoalYears);
system.debug('mapOfGoalYears:' +mapOfGoalYears.keyset());
system.debug('mapOfGoalYears:' +mapOfGoalYears.values());

for(string year : mapOfGoalYears.get(goals.Id))
{
if(mapOfGoalsCount.get(goals.Contact__c).containsKey(year))
{
system.debug(year);
Set<Goal__c> setOfGoals = mapOfGoalsCount.get(goals.Contact__c).get(year);
system.debug('setOfGoals:' +setOfGoals);
List<Goal__c> metGoals = new List<Goal__c>();
List<Goal__c> droppedGoals = new List<Goal__c>();
List<Goal__c> newGoals = new List<Goal__c>();
for(Goal__c gg:setOfGoals)
{
system.debug('goals :'+ gg);
newGoals.add(gg);
system.debug(newGoals.size());   
if(gg.Met_Date__c!=null && String.valueOf(gg.Met_Date__c.year()) == year)
{
metGoals.add(gg); 
metGoals.size();
system.debug(metGoals.size());
}
if(gg.Goal_Dropped_Date__c!=null && string.valueOf(gg.Goal_Dropped_Date__c.year()) == year)
{
droppedGoals.add(gg);  
droppedGoals.size(); 
system.debug(droppedGoals.size()); 
}
}
system.debug('metgoals==>'+metGoals.size());
system.debug('droppedGoals==>'+droppedGoals.size());
if(mapOfP360.get(goals.Contact__c)!=null && mapOfP360.get(goals.Contact__c).get(year)!= null)
//																																			if(mapOfP360.get(goals.Contact__c).containsKey(year))
{
System.debug('p360==>' +mapOfP360.get(goals.Contact__c)+ ' - '+mapOfP360.get(goals.Contact__c).get(year));
Participant_360__c pp = mapOfP360.get(goals.Contact__c).get(year);
pp.Goals_Created_ID__c = String.valueOf(newGoals.size());
pp.Goals_Met_ID__c = String.valueOf(metGoals.size());
pp.Goals_Dropped_ID__c = String.valueOf(droppedGoals.size());
listOfP360.add(pp);
System.debug('listOfP360:' +listOfP360);
// mapOfP360.get(goal.Contact__c).put(year,pp);
//system.debug(mapOfP360.keyset());
// system.debug(mapOfP360.values());
}
else
{
//List<Id> goalId = new List<Id>(mapOfGoals.keyset())[0];
Id goalId = new List<Id>(mapOfGoals.keyset())[0];
System.debug(goalId);
Goal__c goal1 = mapOfGoals.get(goalId);
system.debug(goal1);
Participant_360__c pp = new Participant_360__c();
pp.Name = goal1.Name+' Participant360 '+string.valueOf(year);
pp.Contact__c = goal1.Contact__c;
pp.Participated_Year__c = String.valueOf(year);
pp.Goals_Created_ID__c = String.valueOf(newGoals.size());
pp.Goals_Met_ID__c = String.valueOf(metGoals.size());
pp.Goals_Dropped_ID__c = String.valueOf(droppedGoals.size());     
//mapOfP360.get(goal.Contact__c).put(String.valueOf(year),pp);
listOfP360.add(pp);
system.debug('listOfP360 :' +listOfP360);
}
}
}
}
}
if(!listOfP360.isEmpty())
{
system.debug(listOfP360);
upsert listOfP360;
system.debug(listOfP360);    
}*/
        
    }
}