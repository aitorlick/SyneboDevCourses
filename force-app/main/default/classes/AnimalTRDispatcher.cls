public class AnimalTRDispatcher {

    public static void setAnimalFields(List<Animal__c> newList) {
		List<Animal__c> animalsList = [SELECT Id
                                  		, Name
                                   		, Eats__c
                                   		, Says__c
                                   		, External_Id__c
                                   FROM Animal__c
                                   WHERE Id IN : newList];
        List<Animal__c> animalsListToProcessing = new List<Animal__c>();
        for(Animal__c animal_i : animalsList) {
            if (!String.isBlank(animal_i.External_Id__c)) {
                animalsListToProcessing.add(animal_i);
            }
		}
		AnimalTRService.setAnimalFields(animalsListToProcessing);         
	}
    
}