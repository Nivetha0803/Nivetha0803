public class DemoYoutubeAPI {

    public static HTTPResponse makeGetCallout()
    {
    Http http = new HttP();
        HttpRequest request = new HttpRequest();
         request.setEndpoint('https://www.googleapis.com/youtube/v3/channels??id=7lCDEYXw3mM&Key=AIzaSyBQ269jGmz3KU82mSEzl1xtrOHPtIN7d9Q&part=snippet,statistics');
     
         request.setMethod('GET');
       HttpResponse response = http.send(request);
                             
        if(response.getStatusCode() == 200)
         {
          Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
List<Object> items = (List<Object>) results.get('items');
                           for(Object item : items)
                           {
                               system.debug(item);
                           }
                             }
                           return response;  
                                
    }
    
}