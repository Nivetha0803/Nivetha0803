trigger OpportunityTrigger on Opportunity (before insert,before update,after insert,after update,after delete) {

if(Trigger.isInsert && Trigger.isBefore){
       
     //  OpportunityTriggerHandler.OpportunityInsert(trigger.new);
OpportunityAmountAutomate.amountAutomateIns(trigger.new);
      }
   if(Trigger.isUpdate && Trigger.isBefore){
         {
//OpportunityTriggerHandler.opportunityUpdate(trigger.new,trigger.oldMap);
OpportunityAmountAutomate.amountAutomateIns(trigger.new);
}
       
      
   
     
  
   }
    
    
}