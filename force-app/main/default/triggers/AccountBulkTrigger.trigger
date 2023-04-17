trigger AccountBulkTrigger on Account (after update) 
{
    
    AccountHandlerBulkUpdate.accountBulkUpdate(trigger.new,trigger.oldMap);
    //system.debug(trigger.new,trigger.oldMap);
    
        }