public with sharing class InsertClaimController {
    @AuraEnabled
public static Claims__c insertClaimMethod(String benefitType, String Claimsts, String MemRegion, String AddBills, String Member,
                                    String BankAcc, Date ClaimRec , String FunBills, String Sign, Integer CheckAmt) {
    Claims__c cc = new Claims__c();
    cc.Benefit_Type__c = benefitType;
    cc.Claim_Status__c = Claimsts;
    cc.Member_Region__c = MemRegion;
    cc.Additional_Bills__c = AddBills;
    cc.Member__c = Member;
     cc.Bank_Account__c = BankAcc;     
      cc.Check_Amount__c = CheckAmt;
       cc.Funeral_Bill__c = FunBills;
         cc.Signatures__c = Sign;                             
        insert cc;
        return cc;
    }
   
    @AuraEnabled
    public static List<Claims__c> OnLoadClaimRecords(Boolean onLoad){
        String[] fromDateSplit;
            String[] toDateSplit;
            String fromDTStr;
            String toDTStr;
        onLoad=false;
       
        String query = 'SELECT Id, Name, Member_Region__c,CreatedDate, CreatedById, Bank_Account__c, LastReferencedDate, Additional_Bills__c, Benefit_Type__c, Claim_Status__c, Member__c, Funeral_Bill__c FROM Claims__c where '+
            'OwnerId = \''+UserInfo.getUserId()+'\' AND ';
        system.debug('$$$ query onload records '+query);
        if(onLoad=True)
        {
            query+=' CreatedDate = TODAY';
            system.debug('$$$ query onload records '+query);
        }
        
        
         query +=' Order By CreatedDate DESC';
        system.debug('<<query>>'+query);
        return Database.query(query);
       
    }
    
    
     @AuraEnabled
    public static List<Claims__c> fetchClaimRecords( String fromDate, String toDate){
        String[] fromDateSplit;
            String[] toDateSplit;
            String fromDTStr;
            String toDTStr;
       
       
        String query = 'SELECT Id, Name, Member_Region__c,CreatedDate, CreatedById, Bank_Account__c, LastReferencedDate, Additional_Bills__c, Benefit_Type__c, Claim_Status__c, Member__c, Funeral_Bill__c FROM Claims__c where '+
            'OwnerId = \''+UserInfo.getUserId()+'\' AND ';
        system.debug('$$$ query onload records '+query);
       
         
        if(toDate == null) {
            
                fromDateSplit = fromDate.split('-');
                fromDTStr = DateTime.newInstance(Integer.valueOf(fromDateSplit[0]), Integer.valueOf(fromDateSplit[1]), Integer.valueOf(fromDateSplit[2]), 0, 0, 0).format('yyyy-MM-dd\'T\'HH:mm:ss')+'.000+0000';
                query +=  ' CreatedDate >='+fromDTStr;
                system.debug('$$$ query from date records '+query);
            }
                
            
            else if(fromDate!=null && toDate!=null){
               
                fromDateSplit = fromDate.split('-');
                fromDTStr = DateTime.newInstance(Integer.valueOf(fromDateSplit[0]), Integer.valueOf(fromDateSplit[1]), Integer.valueOf(fromDateSplit[2]), 0, 0, 0).format('yyyy-MM-dd\'T\'HH:mm:ss')+'.000+0000';
                toDateSplit = toDate.split('-');
                toDTStr = DateTime.newInstance(Integer.valueOf(toDateSplit[0]), Integer.valueOf(toDateSplit[1]), Integer.valueOf(toDateSplit[2]), 23, 59, 59).format('yyyy-MM-dd\'T\'HH:mm:ss')+'.000+0000';
                query +=  ' CreatedDate >='+fromDTStr+' AND CreatedDate <='+toDTStr;
                 system.debug('$$$ query from to To date records '+query);
            }
            
        
         //query +=' Order By CreatedDate DESC';
        //system.debug('<<query>>'+query);
        return Database.query(query);
       
    }
}