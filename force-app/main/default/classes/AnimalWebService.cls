@RestResource(urlMapping='/Animals/*')
global class AnimalWebService {

    @HttpGet
    global static String getAnimals() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String animalId = request.requestURI.substring(
        request.requestURI.lastIndexOf('/')+1);
 		
        String  result;
        if (String.isBlank(animalId)) {
        	List<Animal__c> animalsList = [SELECT Id
                                  		, Name
                                   		, Eats__c
                                   		, Says__c
                                   		, External_Id__c
                                   FROM Animal__c];
            result = JSON.serialize(animalsList);
        } else {
			Boolean incomingDataIsId = true;
            try{
                Id test = Id.valueOf(animalId);           
            } catch(Exception e) {
                incomingDataIsId = false;
            }
     
            String searchField = incomingDataIsId ? 'Id' : 'External_Id__c';
            String query = 'SELECT Id'
                         + 		', Eats__c'
                         + 	 	', Says__c'
                         + 		', External_Id__c'
                         +' FROM Animal__c'
                         +' WHERE ' + searchField +' = :animalId'
                         +' LIMIT 1';    
              
            Animal__c animal = Database.query(query);            
            result = JSON.serialize(animal);
        } 
        return result;
    }
    
    @HttpPost
    global static void updateOrCreateAnimal() {
        
        RestRequest request = RestContext.request;        
        AnimalFromJSON animalFJ = AnimalFromJSON.parse(request.requestBody.toString());
        
        if (animalFJ.animal == null || 
			animalFJ.animal.id == null ||
			animalFJ.animal.id == 0) {
            System.debug('AnimalWebService @HttpPost: invalid incomming data');
			return;
		}
          
        String External_Id = String.valueOf(animalFJ.animal.id);
        List<Animal__c> animals = [SELECT Id
                            		   , Name
                            		   , Eats__c
                            		   , Says__c
                            		   , External_Id__c
                            	  FROM Animal__c
                            	  WHERE External_Id__c =: External_Id
                            	  LIMIT 1];
        if (!animals.isEmpty()) {
            Animal__c animal = animals.get(0); 
            if(AnimalUtil.compareUpdateFields(animal, animalFJ)) {
                update animal;
            }
            System.debug('AnimalWebService @HttpPost: Animal was found in current database');
            return; 
        }                

		AnimalFromJSON animalFJToInsert;        
        HttpResponse response = AnimalsCallouts.makeGetCallout(External_Id);
        if (response.getStatusCode() == 200) {
			AnimalFromJSON externalAnimalFJ = AnimalFromJSON.parse(response.getBody());
            if (externalAnimalFJ.animal != null || 
                externalAnimalFJ.animal.id != null ||
                externalAnimalFJ.animal.id != 0) {
                animalFJToInsert = externalAnimalFJ;
			}
        }
        if (animalFJToInsert == null) {
            animalFJToInsert = animalFJ;
        }
        
        Animal__c newAnimal = new Animal__c();
        newAnimal.Name = animalFJToInsert.animal.name;
        newAnimal.Eats__c = animalFJToInsert.animal.eats;
        newAnimal.Says__c = animalFJToInsert.animal.says;
        newAnimal.External_Id__c = External_Id;
        
        insert newAnimal;
        System.debug('AnimalWebService @HttpPost: a new animal was created');
    }
    
}