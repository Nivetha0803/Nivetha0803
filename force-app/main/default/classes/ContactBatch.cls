global class ContactBatch implements Database.Batchable<sObject>, Database.Stateful{
    global integer total_size = 0;
    global integer fail_size=0;
    global integer success_size=0;
   
        
    global  Database.QueryLocator start(Database.BatchableContext bc)
    {
        string query = 'SELECT Id, Name,Fax, Email,MobilePhone,Description,Account.Name,Account.Rating,Account.Phone,Account.Fax,Account.Industry FROM Contact';
        return Database.getQueryLocator(query);
    }
    global void  execute(Database.BatchableContext bc,List<Contact> conList)
    {
        Integer size = conList.size();
         total_size = total_size+size;
             
        For(Integer i=0;i<size;i++)
        {
            Contact con = conList.get(i);
            if(con.Fax == null || con.Fax=='')
            {
                con.Fax = con.Account.Fax;
            }
            if(con.MobilePhone == null || con.MobilePhone=='')
            {
                con.MobilePhone = con.Account.Phone;
            }
            
            con.Email='nivetharajan1997@gmail.com';
            con.Description = con.Account.Name+''+con.Account.Rating+''+con.Account.Industry+''+con.Email;
        }
        //Update conList;
        Database.SaveResult[] result = Database.update(conList, false);
        
        // Database.insert
        // Database.Update
        // Database.delete
        // Database.undelete
        
         Integer size_result = result.size();
        For(Integer i=0;i<size_result;i++)
        {
            Database.SaveResult sr = result.get(i);
            if(sr.isSuccess())
            {
               success_size+=1;
            }
            else{
              fail_size+=1;
            }
        }
    }
    global  void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Status of Batch class : contactBatch');
        email.setSenderDisplayName('Demo Batch class');
        email.setHtmlBody('Dear User, <br/> batch processed' +'<br/> Total records :'+total_size+'<br/> Success count :'+success_size+'<br/> Fail count :'+fail_size);
        List<String> emailTo = new List<String>();
        emailTo.add('Nivetharajan1997@gmail.com');
        email.setToAddresses(new List<String> {'Nivetharajan1997@gmail.com'});
        
        Messaging.SingleEmailMessage[] emailList = new List<messaging.SingleEmailMessage>();
        emailList.add(email);
        Messaging.sendEmail(emailList, false);        
        
        
        
        
    }
}