public class FacebookConnect {
public static void getFacebookId()
    {
        HTTP http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://graph.facebook.com/me?access_token=EAAQ8yfjZA84oBAEuZByyaeg00rMHxekFhxDQ7d9vtLv1mRDs3Hi285feT4sXOBuY82ZAng7TAwwzGpaByZBUJWghUokvJyP9ZARZCviSoqJeZBPZBVztaaZCg3K2xyA5JUgD8bZCFcVL45lWcgDK1abQeZB8BqeF4ZB6GnujAAsK05PlBWSbzVZA2IUogV9h165uqo1DJG8h56R6DyEHU80hAQjrb7XxdthPbr2xEwFXteRVwn2ZCAieUxt2ZCq');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            system.debug(response.getBody());
        }
    }

}