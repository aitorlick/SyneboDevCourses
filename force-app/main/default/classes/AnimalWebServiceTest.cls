@isTest
public class AnimalWebServiceTest {
    
    @testSetup 
    public static void setup(){
        TestDataFactory.createAnimals(2);
    }
    
    @isTest 
    static void testGetAnimalsById() {
        Animal__c testAnimal = [SELECT Id 
                                FROM Animal__c
                                LIMIT 1];
        Id recordId = testAnimal.Id;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-moose-hng51t-dev-ed.lightning.force.com/services/apexrest/Animals/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        String jsonAnimal = AnimalWebService.getAnimals();
        // Verify results
        System.assert(!String.isBlank(jsonAnimal));
    }
    
    @isTest 
    static void testGetAnimalsByExternalId() {
        Animal__c testAnimal = [SELECT External_Id__c 
                                FROM Animal__c
                                LIMIT 1];
        String externalId = testAnimal.External_Id__c;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-moose-hng51t-dev-ed.lightning.force.com/services/apexrest/Animals/'
            + externalId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        String jsonAnimal = AnimalWebService.getAnimals();
        // Verify results
        System.assert(!String.isBlank(jsonAnimal));
    }
    
    @isTest 
    static void testGetAllAnimals() {
       
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-moose-hng51t-dev-ed.lightning.force.com/services/apexrest/Animals/';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        String jsonAnimal = AnimalWebService.getAnimals();
        // Verify results
        System.assert(!String.isBlank(jsonAnimal));
    }
 
    @isTest 
	static void testUpdateAnimal() {
        
    	Animal__c testAnimal = [SELECT External_Id__c 
                                FROM Animal__c
                                WHERE External_Id__c =:'1'
                                LIMIT 1];
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-moose-hng51t-dev-ed.lightning.force.com/services/apexrest/Animals/';
        
        Map<String, String> headers = request.headers;
		headers.put('Content-Type', 'application/json');
        
        String jsonString = '{"animal":{"id":'+testAnimal.External_Id__c+',"name":"chicken","eats":"chicken food","says":"cluck cluck"}}';
        request.requestBody = Blob.valueOf(jsonString);
        request.httpMethod = 'POST';
        RestContext.request = request;
        // Call the method to test
        AnimalWebService.updateOrCreateAnimal();
        // Verify results
        Animal__c resultAnimal = [SELECT Eats__c 
                                FROM Animal__c
                                WHERE Id =:testAnimal.Id 
                                LIMIT 1];
        System.assertEquals('chicken food', resultAnimal.Eats__c);
        
    }
    
    @isTest 
	static void testUpdateAnimalByCallout() {
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-moose-hng51t-dev-ed.lightning.force.com/services/apexrest/Animals/';
        
        Map<String, String> headers = request.headers;
		headers.put('Content-Type', 'application/json');
        
        String jsonString = '{"animal":{"id":2,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}';
        request.requestBody = Blob.valueOf(jsonString);
        request.httpMethod = 'POST';
        RestContext.request = request;
        // Call the method to test
        AnimalWebService.updateOrCreateAnimal();
        // Verify results
        Animal__c resultAnimal = [SELECT Eats__c 
                                FROM Animal__c
                                WHERE External_Id__c =:'2'
                                LIMIT 1];
        System.assert(resultAnimal != null);
        
    }
    
}