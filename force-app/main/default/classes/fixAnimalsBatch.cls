global class fixAnimalsBatch implements Database.Batchable<SObject>, schedulable {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
		String query = 'SELECT Id'
            		 + 	    ', Name'
            		 + 	    ', Eats__c'
            		 + 	    ', External_Id__c'
            		 + 	    ', Says__c'
            		 + ' FROM Animal__c'            		 
            		 + ' WHERE External_Id__c != null';
        
		return Database.getQueryLocator(query);
        
	}

	public void execute(Database.BatchableContext bs, List<Animal__c> scope){
        
        List<Animal__c> animalsListToUpdate = new List<Animal__c>();
        for (Animal__c animal_i : scope) {
            String cacheNameAnimal = 'Animal'+(String)animal_i.Id;
            AnimalFromJSON animalFJ = (AnimalFromJSON)Cache.org.get(cacheNameAnimal);
            if (animalFJ == null || animalFJ.animal == null) {
                HttpResponse response = AnimalsCallouts.makeGetCallout(animal_i.External_Id__c);
                if (response.getStatusCode() != 200) {
                    System.debug('Failed to get additional fields of Animal with Id: '+animal_i.Id);
                    continue;
                }
                animalFJ = AnimalFromJSON.parse(response.getBody());
                if (animalFJ.animal == null || 
                    animalFJ.animal.id == null ||
                    animalFJ.animal.id == 0) {
                    System.debug('Failed to get additional fields of Animal with Id: '+animal_i.Id);
                    continue;
                }
                Cache.Org.put(cacheNameAnimal, animalFJ, 172800);
            }
            AnimalUtil.compareUpdateFieldsAndPutInMapToUpdate(animal_i, animalFJ, animalsListToUpdate);                
        }
        
        update animalsListToUpdate;
        
	}
    
	public void finish(Database.BatchableContext BC){
	}
    
    global void execute(SchedulableContext SC) {
 		Database.executebatch(new fixAnimalsBatch(),100);
    }

}