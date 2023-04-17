public class CreateClaimController {

    
    public Claims__c claimObj{get;set;}
    public Members__c membrec{get;set;}
    public String countryField{get; set;}
    
    public List<Members__c> membList{get;set;}
    
    public Id recordId {get; set;}
    
    public string currentRecordId{get; set;}
    List<Claims__c> updateClaim = new List<Claims__c>();
    public Boolean checkContact { get; set; }
    public Boolean hasContact   { get; set; }
   
    
    Public createClaimController(ApexPages.StandardController controller){
        hasContact = true;
        checkContact = true;
        membrec = (Members__c)controller.getRecord();
        recordId = membrec.Id;
        membList = [SELECT Id, Member_Full_Name__c,Name,Last_Name__c, Country__c,(SELECT ID,Claim_Status__c FROM Beneficiary__r) FROM Members__c WHERE ID =:recordId];
        System.debug('Full_Name__c=>'+membList);
        System.debug('Size of member list=>'+membList.size());
        
        for(Members__c mm : membList){
            countryField = mm.Country__c;
        }
        
        claimObj = new Claims__c();
        system.debug('claimObj'+claimObj);
        claimObj.Member__c=recordId;
        //claimObj.Member_Region__c = countryField;
        
        
    }
    
    public void changeField(){
        // AutoFill the Claim record field values from the associated member record.
        if(claimObj.Member_Region__c == 'USA')
        {
            claimObj.W9_Form__c= 'Yes';
            claimObj.Bank_Account__c='Citibank';
            system.debug('claimObj'+claimObj);
        }
        else if(claimObj.Member_Region__c == 'Canada')
        {
            claimObj.W9_Form__c= 'No';
            claimObj.Bank_Account__c='Bank Of Montreal';
            system.debug('claimObj'+claimObj);
        } 
        else{
            claimObj.Bank_Account__c='';
        }
    }
    Public PageReference saveBeneficiary(){
        
        try{
            upsert claimObj;
        }
        catch(Exception e){
            System.debug('Error Message=>'+e.getMessage());
            return null;
        } 
        
        PageReference pageRef = new PageReference('/'+claimObj.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference doCancel(){
        
        this.currentRecordId = ApexPages.CurrentPage().getparameters().get('id');
        PageReference pageRef = new PageReference('/'+currentRecordId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    

}