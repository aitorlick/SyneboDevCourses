public with sharing class AnimalController {

    @AuraEnabled
    public static List<Animal__c> getAnimalsById(String externalID){
        
        Boolean incomingDataIsId = true;
        try{
            Id test = Id.valueOf(externalID);           
        } catch(Exception e) {
            incomingDataIsId = false;
        }
        
        String searchField = incomingDataIsId ? 'Id' : 'External_Id__c';
        String query = 'SELECT Id'
            + 		', Name'
            + 		', Eats__c'
            + 	 	', Says__c'
            + 		', External_Id__c'
            +' FROM Animal__c'
            +' WHERE ' + searchField +' = :externalID';    
        
        List<Animal__c> animalList = Database.query(query);
        
        return animalList;
        
    }

    @AuraEnabled
    public static Animal__c createAnimal(Animal__c animal, Boolean updateAnimalWithoutQuestions) {
        System.debug('animal in: '+animal);
        System.debug('updateAnimalWithoutQuestions in: '+updateAnimalWithoutQuestions);
        List<Animal__c> animalsList = [SELECT Id
                                  		, Name
                                   		, Eats__c
                                   		, Says__c
                                   		, External_Id__c
                                   FROM Animal__c
                                   WHERE External_Id__c =: animal.External_Id__c
                                   LIMIT 1];

        if (animalsList.isEmpty()) {
            insert animal;    
            return animal;
        } else {
            if (updateAnimalWithoutQuestions == true) {
                Animal__c existingAnimal = animalsList.get(0);
                existingAnimal.Name = animal.Name;
                existingAnimal.Eats__c = animal.Eats__c;
                existingAnimal.Says__c = animal.Says__c;
                update existingAnimal;
                return existingAnimal;
            } else {
                return null; // trigerring lwc modal question for update
            }

        }
    }

    @AuraEnabled
    public static String getExistAnimal(Animal__c animal) {

        List<Animal__c> animalsList = [SELECT Id
                                  		, Name
                                   		, Eats__c
                                   		, Says__c
                                   		, External_Id__c
                                   FROM Animal__c
                                   WHERE External_Id__c =: animal.External_Id__c
                                   LIMIT 1];

        String result;                                   
        if (!animalsList.isEmpty()) {
            result = (String) animalsList.get(0).Id;
        }
        return result;    

    }
    
}