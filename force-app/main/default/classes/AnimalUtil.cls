public class AnimalUtil {

    public static void compareUpdateFieldsAndPutInMapToUpdate(Animal__c animal, AnimalFromJSON animalFJ, List<Animal__c> animalsListToUpdate) {

		if (animal.Name != animalFJ.animal.name ||
            animal.Eats__c != animalFJ.animal.eats ||
            animal.Says__c != animalFJ.animal.says
           ) {
               animal.Name = animalFJ.animal.name;
               animal.Eats__c = animalFJ.animal.eats;
               animal.Says__c = animalFJ.animal.says;
               animalsListToUpdate.add(animal);
		}
        
    }
    
}