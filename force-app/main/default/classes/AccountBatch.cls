public class AccountBatch implements Database.Batchable<sObject>{
    List<Account> updateAcc = new List<Account>();
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        system.debug('Start method');
        String query = 'SELECT ID, Name, Rating FROM Account WHERE Rating=\'Hot\'';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        system.debug('execute method');
        system.debug('record size '+ scope.size());
        for(Account record : scope )
        {
            record.Rating = 'Cold';
            updateAcc.add(record);
            system.debug('update the record is '+ updateAcc);
        }
        update updateAcc;
        system.debug('update the record is '+ updateAcc);
    }
    
    public void finish(Database.BatchableContext bc)
    {
       system.debug('finish method');
    }
}