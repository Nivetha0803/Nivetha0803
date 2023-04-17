public class SpoonacularConnect {
    private static final string Spoonacular_api='https://api.spoonacular.com';
     private static final string api_Key='e1e87ee1a562476391bd9a3ec1fb7d18';
public static void getBearSalesforceOrgB(string recId)
    {
        HTTP http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Spoonacular_api+'/recipes/'+recId+'/information?apiKey='+api_Key);
       
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            system.debug('response '+response.getBody());
                    }
    }

}