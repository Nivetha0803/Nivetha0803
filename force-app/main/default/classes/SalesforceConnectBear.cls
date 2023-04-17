public class SalesforceConnectBear {
    
    public static void getBearSalesforceOrgB()
    {
        HTTP http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDCB/services/apexrest/Bear__c');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            system.debug('response '+response);
            List<Object> lists = (List<Object>)JSON.deserializeUntyped(response.getBody());
             system.debug('list of response is  '+lists);
            For(Object obj : lists)
            {
                Map<String,Object> params = (Map<String,Object>)obj;
                system.debug('bear name '+params.get('Name')+ 'location is '+params.get('Location__c')+'bear sex is '+params.get('Sex__c'));
            }
        }
    }

}