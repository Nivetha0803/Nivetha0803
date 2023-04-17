global class Apexjobschedulerexample implements Schedulable{
    
    global void execute(SchedulableContext ctx)
    {
        List<Account> listacc = [SELECT Id, Name, Rating, AnnualRevenue FROM Account];
        
        for(Account acc : listacc)
        {
            if(acc.Rating.equals('Hot'))
            {
                acc.AnnualRevenue = 10000;
            }
            else if(acc.Rating.equals('Cold'))
            {
                acc.AnnualRevenue = 5000;
            }
            else if(acc.Rating.equals('Warm'))
            {
                acc.AnnualRevenue = 3000;
            }
            else 
            {
               acc.AnnualRevenue = 1000; 
            }
        }
        
        update listacc;
        
    }
}