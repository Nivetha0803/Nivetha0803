@isTest
public class OpportunityAmountAutomate_Test {
  @isTest
    public static  void oppAutomateTest1(){
        List<Opportunity> listOfOpp = new List<Opportunity>();
        For(integer i=1;i<15;i++)
        {
            Opportunity opp1 = new Opportunity();
            opp1.Name ='Test Opportunity1';
            opp1.Amount= 1000;
            opp1.CloseDate=Date.parse('5/10/2022');
            opp1.Current_Year__c='2022';
            opp1.Next_Year__c='2023';
            opp1.Start_Date__c=date.parse('1/1/2020');
            opp1.Start_Date__c=date.newInstance(2020, i, 1);
            opp1.End_Date__c = date.newInstance(2024,i,8);
            listOfOpp.add(opp1);
            
        
           
           
            
           
        }
        database.insert(listOfOpp, false);
        system.debug('listOfOpp'+listOfOpp);
    }
    @isTest
    public static void oppAutomateTest2(){
        List<Opportunity> listOfOpp = new List<Opportunity>();
        For(integer i=1;i<15;i++)
        {
            Opportunity opp2 = new Opportunity();
            opp2.Name ='Test Opportunity2';
            opp2.Amount= 2000;
            opp2.CloseDate=Date.parse('8/1/2024');
            opp2.Current_Year__c='2021';
            opp2.Next_Year__c='2022';
            opp2.Start_Date__c=date.newInstance(2021, i, 1);
            opp2.End_Date__c=date.newInstance(2024, i, 8);
            listOfOpp.add(opp2);
        }
        database.insert(listOfOpp, false);
        system.debug('listOfOpp'+listOfOpp);
    }
    @isTest
    public static void oppAutomateTest3(){
        List<Opportunity> listOfOpp = new List<Opportunity>();
        For(integer i=1;i<15;i++)
        {
            Opportunity opp3 = new Opportunity();
            opp3.Name ='Test Opportunity3';
            opp3.Amount= 4000;
            opp3.Current_Year__c='2021';
            opp3.Next_Year__c='2022';
            opp3.CloseDate=Date.newInstance(2022, i, 1);
            opp3.Start_Date__c=date.newInstance(2020, i, 1);
            opp3.End_Date__c=date.newInstance(2022, i, 1);
            listOfOpp.add(opp3);
         }
        database.insert(listOfOpp, false);
        system.debug('listOfOpp'+listOfOpp);
    }
    @isTest
    public static void oppAutomateTest4(){
        List<Opportunity> listOfOpp = new List<Opportunity>();
        For(integer i=1;i<15;i++)
        {
            Opportunity opp4 = new Opportunity();
            opp4.Name ='Test Opportunity4';
            opp4.Amount= 4000;
            opp4.Current_Year__c='2021';
            opp4.Next_Year__c='2022';
            opp4.CloseDate=Date.newInstance(2022, i, 1);
            opp4.Start_Date__c=date.newInstance(2020, i, 1);
            opp4.End_Date__c=date.newInstance(2021, i, 1);
            listOfOpp.add(opp4);
         }
        database.insert(listOfOpp, false);
        system.debug('listOfOpp'+listOfOpp);
    }
    @isTest
    public static void oppAutomateTest5(){
        List<Opportunity> listOfOpp = new List<Opportunity>();
        For(integer i=1;i<15;i++)
        {
            Opportunity opp5 = new Opportunity();
            opp5.Name ='Test Opportunity5';
            opp5.Amount= 6000;
            opp5.Current_Year__c='2021';
            opp5.Next_Year__c='';
            opp5.CloseDate=Date.newInstance(2022, i, 1);
            opp5.Start_Date__c=date.newInstance(2020, i, 1);
            opp5.End_Date__c=date.newInstance(2021, i, 1);
            listOfOpp.add(opp5);
         }
        database.insert(listOfOpp, false);
        system.debug('listOfOpp'+listOfOpp);
    }
    @isTest
    public static void oppAutomateTest6(){
        List<Opportunity> listOfOpp = new List<Opportunity>();
        For(integer i=1;i<15;i++)
        {
            Opportunity opp6 = new Opportunity();
            opp6.Name ='Test Opportunity6';
            opp6.Amount= 6000;
            opp6.Current_Year__c='';
            opp6.Next_Year__c='2021';
            opp6.CloseDate=Date.newInstance(2022, i, 1);
            opp6.Start_Date__c=date.newInstance(2020, i, 1);
            opp6.End_Date__c=date.newInstance(2021, i, 1);
            listOfOpp.add(opp6);
         }
        database.insert(listOfOpp, false);
        system.debug('listOfOpp'+listOfOpp);
    }
    
}