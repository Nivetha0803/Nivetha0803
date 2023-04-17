trigger ConvertedLeadUpdate on Lead (before Insert, before Update, after update) {
    if(Trigger.isBefore && Trigger.isInsert){
       for(Lead ld : Trigger.new){
        if(ld.Lead_Stages__c=='Lead')
        {
            ld.Converted_Lead_Details__c = ld.LeadSource+' , '+ld.Company+' , '+ld.NumberOfEmployees;
        }
        else if(ld.Lead_Stages__c!='Lead')
        {
            ld.Converted_Lead_Details__c = '';
        }
        
    } 
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Lead ld : Trigger.new){
             if(ld.Lead_Stages__c=='Lead' && Trigger.oldMap.get(ld.Id).Lead_Stages__c!='Lead')
             {
               ld.Converted_Lead_Details__c = ld.LeadSource+' , '+ld.Company+' , '+ld.NumberOfEmployees;  
             }
           else if(ld.Lead_Stages__c!='Lead' && Trigger.oldMap.get(ld.Id).Lead_Stages__c=='Lead')
             {
               ld.Converted_Lead_Details__c = '';  
             }
            else if(ld.Lead_Stages__c!='Lead' && Trigger.oldMap.get(ld.Id).Lead_Stages__c!='Lead')
             {
               ld.Converted_Lead_Details__c = '';  
             }
        }
    }
    
}