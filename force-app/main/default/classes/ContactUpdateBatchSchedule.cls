global class ContactUpdateBatchSchedule implements Database.Batchable<sobject>, Schedulable{
    public String userIds{get;set;}
    List<String> conEmail = new List<String>();
    Id conId;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('batch apex');
        String query = 'SELECT Id, LastName,LeadSource,Name,AccountId,OwnerId FROM Contact';
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext bc, List<Contact> conList){
        system.debug('batch apex');
        List<Contact> updateCon = new List<Contact>();
         Set<Id> conIds = new Set<Id>();
        List<String> userEmail = new List<String>();
        
        
        For(Contact con : conList)
        {
            system.debug('contact size'+con);
            if(con.LeadSource == 'Web'){
                con.LeadSource = 'Phone Inquiry';
                conIds.add(con.OwnerId);
                system.debug('conIds '+conIds);
                updateCon.add(con);
                 system.debug('updateCon '+updateCon);
            }
        }
        update updateCon;
        system.debug('updateCon '+updateCon);
       
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
       
       /* Id userId =UserInfo.getUserId(); 
        User userInfo = [SELECT Id, Email,Name FROM User WHERE Id =: userId];
       
       List<User> usrIns = [Select Id, Name, Email, Phone FROM User WHERE ID =:userIds];
        system.debug('useIns '+userInfo);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<Contact> listOfCon = [SELECT ID, Name, Email,OwnerId,LastName FROM Contact WHERE OwnerId =:conIds];
            For(Contact con : listOfCon)
        {
            conEmail.add(con.Email);
            conId = con.Id;
            System.debug('conEmail '+conEmail);
        }
        
       // String[] toAddress = new String[]{conEmail};
    //    system.debug('user id '+toAddress);
        mail.setSenderDisplayName('Email Alert');
        mail.setToAddresses(conEmail);
        mail.setTemplateID('00X5e000001CkLX');
        mail.setSaveAsActivity(false);
        mail.setTargetObjectId(conId);
        mails.add(mail);
        Messaging.SendEmail(mails);*/
               
    }
    
    
    
    
    global void finish(Database.BatchableContext bc){
        system.debug('finish method');
       List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
       
        Id userId =UserInfo.getUserId(); 
        User userInfo = [SELECT Id, Email,Name FROM User WHERE Id =: userId];
       system.debug('@@user info '+userInfo);
        system.debug('@@user info '+userInfo.Email);
        system.debug('@@user info '+userInfo.Name);
        
        String[] toAddress = new String[] {userInfo.Email};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSenderDisplayName('Email Alert');
        mail.setToAddresses(toAddress);
         mail.setTemplateID('00X5e000001CkLX');
        mail.setTargetObjectId(userInfo.Id);
        mail.setSaveAsActivity(false); 
        mails.add(mail);
        Messaging.SendEmail(mails);  
       } 
    
    global void execute(SchedulableContext Sc){
        ContactUpdateBatchSchedule conUpdate = new ContactUpdateBatchSchedule();
        database.executeBatch(conUpdate);
        
    }
}