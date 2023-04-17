global class FollowUpLeads implements Database.Batchable<sObject>,Schedulable {
   Date cutoffDate;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('start');
        //Date startDate = Date.today().addDays(-7);
//Date startDateTime = Date.valueOf(startDate);
        cutoffDate = Date.today().addDays(-7);
        system.debug('cutoffDate '+cutoffDate);
        String strquery = 'SELECT ID, Name, Email, FirstName, CreatedDate, Created_Date__c, Status FROM Lead WHERE Status = \'Open - Not Contacted\' AND Created_Date__c < :cutoffDate';
        system.debug('strquery '+strquery);
       
        return Database.getQueryLocator(strquery);
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        system.debug('execute');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        //email.setToAddresses(new List<String>());
        for (Lead l : (List<Lead>)scope) {
            system.debug(' lead '+l);
            if(l.Created_Date__c!=null){
             Integer daysSinceLastFollowup = l.Created_Date__c.daysBetween(Date.today().addDays(-7));
             system.debug(' Date.today().addDays(-7) '+Date.today().addDays(-7));
             system.debug(' daysSinceLastFollowup '+daysSinceLastFollowup);
              system.debug(' l.Created_Date__c '+l.Created_Date__c);
            if (daysSinceLastFollowup == 3) {
                system.debug(' daysSinceLastFollowup '+daysSinceLastFollowup);
                Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
                email1.setToAddresses(new List<String>{l.Email});
                system.debug('email '+email1);
                email1.setSenderDisplayName('First Reminder: Please follow up with lead and this is your first follow-up email. ' + l.Name);
                email1.setTemplateId('00X5e000001ClkK');
                email1.setTargetObjectId(l.Id);
                emails.add(email1);
            } else if (daysSinceLastFollowup == 6) {
                system.debug(' daysSinceLastFollowup '+daysSinceLastFollowup);
                Messaging.SingleEmailMessage email2 = new Messaging.SingleEmailMessage();
                email2.setToAddresses(new List<String>{l.Email});
                system.debug('email '+email2);
                email2.setSenderDisplayName('Second Reminder: Please follow up with lead and this is your second follow-up email.' + l.Name);
                email2.setTemplateId('00X5e000001ClkK');
                email2.setTargetObjectId(l.Id);
                emails.add(email2);
            } else if (daysSinceLastFollowup == 9) {
                system.debug(' daysSinceLastFollowup '+daysSinceLastFollowup);
                Messaging.SingleEmailMessage email3 = new Messaging.SingleEmailMessage();
                email3.setToAddresses(new List<String>{l.Email});
                system.debug('email '+email3);
                email3.setSenderDisplayName('Final Reminder: Please follow up with lead and this is your third follow-up email.' + l.Name);
                email3.setTemplateId('00X5e000001ClkK');
                email3.setTargetObjectId(l.Id);
                emails.add(email3);
            }
            }
           
        }
        
        Messaging.sendEmail(emails);
    }
global void finish(Database.BatchableContext bc) {
        System.debug('Batch job completed successfully');
    }
     global void execute(SchedulableContext Sc){
        FollowUpLeads FollowLd = new FollowUpLeads();
        database.executeBatch(FollowLd);
        
    }
    
        /*List<Lead> leadsToFollowUp  = new List<Lead>();
            EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Follow_Up_Template'];

        For(Lead leadRec :LeadIns){
            if(leadRec.Status=='Open' && leadRec.CreatedDate<Date.today().addDays(-7)){
                leadsToFollowUp .add(leadRec);
            }
        }
        if(!leadsToFollowUp.isEmpty()){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
         for (Lead lead : leadsToFollowUp) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{ lead.Email });
            email.setTemplateId(template.Id);
            emails.add(email);
        }
            Messaging.sendEmail(emails);
        }
    }*/

}