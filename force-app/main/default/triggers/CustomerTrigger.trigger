trigger CustomerTrigger on Customer__c (After insert,After update)
{
    if(trigger.isAfter&&trigger.isInsert)
    {
        CustomerTriggerHandler.afterInsert(Trigger.new);
    }
    
    if(trigger.isAfter&&trigger.isUpdate)
    {
      CustomerTriggerHandler.afterUpdate(Trigger.new, Trigger.oldmap);
    }
    
    if(trigger.isAfter&&trigger.isDelete)
    {
       CustomerTriggerHandler.afterInsert(Trigger.old);
    }

}