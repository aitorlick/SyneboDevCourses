public class AnimalsCallouts {
    public static HttpCalloutMock mock = new AnimalsHttpCalloutMock();
    
    public static HttpResponse makeGetCallout(String externalId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+externalId);
        request.setMethod('GET');
        if (Test.isRunningTest()) {
			return mock.respond(request);
		} else {
			return http.send(request);                    
		}                 
    }
}