public class OpenWeatherCallout {
 public static httpResponse openWeatherWebService()
 {
     Http http = new Http();
     HttpRequest request = new HttpRequest();
     request.setEndpoint('https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid={a7034c2c8f51ad085a39c88a3c9bcc75}');
      system.debug('response '+request);
     request.setMethod('GET');
     
     HttpResponse response = new HttpResponse();
     system.debug('response '+response.getBody());
     if(response.getStatusCode() == 200)
     {
         List<Object> results =(List<Object>)JSON.deserializeUntyped(response.getBody());
             for(Object result : results)
             {
                 Map<String, Object> params = (Map<String, Object>) result;
                
         system.debug('response '+params);
     }
     
 }
     return response;
}
}