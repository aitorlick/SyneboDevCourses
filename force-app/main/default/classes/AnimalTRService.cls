public class AnimalTRService {

    public static void setAnimalFields(List<Animal__c> animalsListToProcessing) { 
        
		AnimalsQueueableCallouts animalCall = new AnimalsQueueableCallouts(animalsListToProcessing);
		Id jobID = System.enqueueJob(animalCall);
        System.debug('AnimalsCallouts jobID: '+jobID);
        
	}
    
}