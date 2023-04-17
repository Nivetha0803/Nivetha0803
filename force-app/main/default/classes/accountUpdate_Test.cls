@isTest
public class accountUpdate_Test {
    public static testMethod void accUpdTestMtd(){
        Account acc = new Account();
        acc.Name='Account1';
        insert acc;
        
        test.startTest();
        accountUpdate accUpdate = new accountUpdate();
        accUpdate.updateAccount('Account1','1234567');
        test.stopTest();
    }
    
    public static testMethod void accUpdNegTestMtd(){
        
        
        test.startTest();
        accountUpdate accUpdate = new accountUpdate();
        accUpdate.updateAccount('Account1','1234567');
        test.stopTest();
    }
}