public class AnimalsQueueableCallouts implements Queueable, Database.AllowsCallouts {
	private List<Animal__c> animalsList;
    
    public AnimalsQueueableCallouts(List<Animal__c> animalsList) {    
        this.animalsList = animalsList;
    }
    
    public void execute(QueueableContext context) {
    
        List<Animal__c> animalsListToProcessing = new List<Animal__c>();
        for (Integer i = 0; i < 100; i++) {
            if (!animalsList.isEmpty()) {
                break;
            }
            Animal__c currentAnimal = animalsList.get(0);
            animalsListToProcessing.add(currentAnimal);
            animalsList.remove(0);
        }
        
        List<Animal__c> animalsListToUpdate = new List<Animal__c>();
        for (Animal__c animal_i : animalsListToProcessing) {
            HttpResponse response = AnimalsCallouts.makeGetCallout(animal_i.External_Id__c);
        	if (response.getStatusCode() != 200) {
                System.debug('Failed to get additional fields of Animal with Id: '+animal_i.Id);
                continue;
            }
            AnimalFromJSON animalFJ = AnimalFromJSON.parse(response.getBody());
            if (animalFJ.animal == null || 
                animalFJ.animal.id == null ||
                animalFJ.animal.id == 0) {
                System.debug('Failed to get additional fields of Animal with Id: '+animal_i.Id);
                continue;
            }
            AnimalUtil.compareUpdateFieldsAndPutInMapToUpdate(animal_i, animalFJ, animalsListToUpdate);                               
        }
        
        update animalsListToUpdate;
        
        if(!animalsList.isEmpty()) {
			if(!Test.isRunningTest()){
                AnimalsQueueableCallouts animalCall = new AnimalsQueueableCallouts(animalsList);
                Id jobID = System.enqueueJob(animalCall);
                System.debug('AnimalsCallouts jobID: '+jobID);
            }
		}
    }
}