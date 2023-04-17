trigger GoalTrigger on Goal__c (After insert, After update)
{
    
    if(trigger.isAfter&&trigger.isInsert) 
    {
        GoalTriggerHandler.afterInsert(trigger.new); 
    }
    if(trigger.isAfter&&trigger.isUpdate) 
    {
        GoalTriggerHandler.afterUpdate(trigger.new,trigger.oldMap);
    }
    
    
    
    
    
    
    
    
    
    
    /* else if(trigger.isBefore && trigger.isInsert ){
GoalTriggerHandler.beforeInsert(trigger.new);
}
else if(trigger.isBefore && trigger.isUpdate){
GoalTriggerHandler.beforeUpdate(trigger.new,trigger.oldMap);
}*/
}