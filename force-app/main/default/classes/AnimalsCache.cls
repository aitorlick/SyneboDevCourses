public class AnimalsCache {

    public static Map<String, AnimalFromJSON> animalExternalIdToAnimalFromJSONMap;

    public static AnimalFromJSON getAnimalFromJSON(String externalId) {

        if (animalExternalIdToAnimalFromJSONMap == null) {
            animalExternalIdToAnimalFromJSONMap = new Map<String, AnimalFromJSON>();
        }

        AnimalFromJSON objectResult;
        if (animalExternalIdToAnimalFromJSONMap.containsKey(externalId)) {
            objectResult = animalExternalIdToAnimalFromJSONMap.get(externalId);
        }

        return objectResult;
    }
    
    public static void putAnimalFromJSONToCache(String externalId, AnimalFromJSON animalFJ) {
    	animalExternalIdToAnimalFromJSONMap.put(externalId, animalFJ);
    }
    
}