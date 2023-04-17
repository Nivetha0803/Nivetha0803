trigger DuplicateContactTrigger on Contact (before insert,before update) {
   if(trigger.isBefore && trigger.isInsert )
   {
      FindDuplicateContactHandler.duplicateInsert(trigger.new);
    }
     if(trigger.isBefore && trigger.isUpdate)
  {
  //    FindDuplicateContactHandler.duplicateUpdate(trigger.new,trigger.oldMap);  
   }
  /* if(trigger.isBefore && trigger.isInsert)
    {
      dupphoneHandler.findDuplicateRecords(trigger.new);  
    }*/
   
}