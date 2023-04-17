public with sharing class getTrustFundController {
    @AuraEnabled(cacheable=true)

 
        public static List<Trust_Fund_Tracker__c> getTrustFundList(String hsgType, String month,String year,Integer grossWages,Integer hours)
        {

            return [SELECT Id,tracker_monthly_gross_wages__c,
              tracker_month__c,tracker_year__c,tracker_hsg_type__c,tracker_hours__c FROM Trust_Fund_Tracker__c
              WHERE tracker_hsg_type__c=:hsgType AND tracker_month__c=:month AND tracker_year__c=:year AND tracker_monthly_gross_wages__c=:grossWages AND tracker_hours__c=:hours];
                }


            @AuraEnabled(cacheable=true)
            public static List<Trust_Fund_Tracker__c> getTrackerRecord(){
                return [SELECT Id,tracker_monthly_gross_wages__c,
                tracker_month__c,tracker_year__c,tracker_hsg_type__c,tracker_hours__c FROM Trust_Fund_Tracker__c where tracker_hsg_type__c!=null];
               
                
            }
}