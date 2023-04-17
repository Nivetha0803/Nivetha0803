trigger ContactTrigger on Contact (After Insert, after Update) {
    if(trigger.isAfter && trigger.isInsert)
    {
        ContactTriggerHandler.afterInsert(trigger.new);
    }
 /*if(trigger.isAfter && trigger.isUpdate)
    {
        ContactTriggerHandler.afterUpdate(trigger.new,trigger.oldMap);
    }*/
 
}