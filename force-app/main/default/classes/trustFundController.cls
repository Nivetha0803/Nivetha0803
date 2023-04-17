public with sharing class trustFundController {
    @AuraEnabled(cacheable=true)
    public static List<Trust_Fund_Tracker__c> getTrustFundList(String recordId ,String hsgType, String month,String year){

      List<Trust_Fund_Tracker__c> trustList  = [SELECT Id,tracker_monthly_gross_wages__c,
        tracker_month__c,tracker_year__c,tracker_hsg_type__c,tracker_hours__c FROM Trust_Fund_Tracker__c
        WHERE Id=:recordId AND tracker_hsg_type__c=:hsgType AND tracker_month__c=:month AND tracker_year__c=:year];
        return trustList;
    }
// Insert TrustFundTracker
    @AuraEnabled
    public static String createTrustFund(String hsgType, String month,String year, Integer hoursReported, Integer grossWages ){
        Trust_Fund_Tracker__c trustFund = new Trust_Fund_Tracker__c();
        trustFund.tracker_hsg_type__c = hsgType;
        trustFund.tracker_year__c = year;
        trustFund.tracker_month__c = month;
        trustFund.tracker_hours__c = hoursReported;
        trustFund.tracker_monthly_gross_wages__c = grossWages;
        insert trustFund;
        return trustFund.id;
    }
    
}