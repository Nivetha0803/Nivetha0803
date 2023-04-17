trigger AccountTrigger on Account (After insert,After update) {
    if(trigger.isAfter && trigger.isUpdate)
    {
       AccountTriggerHandler.afterUpdate(trigger.new);
 
    }
}