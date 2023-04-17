public class SalesforceConnect {
    public static void getCasesFromSalesforceOrgB()
    {
    Http http = new HttP();
        HttpRequest request = new HttpRequest();
         request.setEndpoint('callout:SFDCB/services/apexrest/Cases');
           request.setMethod('GET');
       HttpResponse response = http.send(request);
                           system.debug('response '+response.getBody())   ;    
        if(response.getStatusCode() == 200)
         {
             List<Object> results =(List<Object>)JSON.deserializeUntyped(response.getBody());
             for(Object result : results)
             {
                 Map<String, Object> params = (Map<String, Object>) result;
                 system.debug('CaseNumber'+params.get('CaseNumber')+'- Subject'+params.get('Subject')); 
  
             }
          }
        
}
    
     public static void CreateCaseSalesforceOrgB()
     {
        Http http = new HttP();
        HttpRequest request = new HttpRequest();
         request.setEndpoint('callout:SFDCB/services/apexrest/Cases');
           request.setMethod('POST'); 
         request.setHeader('Content-Type', 'application/json;charset=UTF-8');
         request.setBody('{"subject":"Case From salesforce org A","status":"New","origin":"Web","priority":"High"}');
          HttpResponse response = http.send(request);
          system.debug('response '+response.getBody())   ;  
     }
}