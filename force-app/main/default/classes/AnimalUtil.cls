public class AnimalUtil {

    public static Boolean compareUpdateFields(Animal__c animal, AnimalFromJSON animalFJ) {

		if (animal.Name != animalFJ.animal.name ||
            animal.Eats__c != animalFJ.animal.eats ||
            animal.Says__c != animalFJ.animal.says
           ) {
			animal.Name = animalFJ.animal.name;
			animal.Eats__c = animalFJ.animal.eats;
			animal.Says__c = animalFJ.animal.says;
			return true;
		} else {
			return false;
		}
        
    }
    
    public static void compareUpdateFieldsAndPutInMapToUpdate(Animal__c animal, AnimalFromJSON animalFJ, List<Animal__c> animalsListToUpdate) {

        if (compareUpdateFields(animal, animalFJ)) {
			animalsListToUpdate.add(animal);
		}
        
    }
      
}