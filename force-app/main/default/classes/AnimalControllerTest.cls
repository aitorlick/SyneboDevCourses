@isTest
public class AnimalControllerTest {

    @testSetup 
    private static void setup(){
        TestDataFactory.createAnimals(5);
    }
    
    @isTest
    private static void getAnimalsById_TestById(){
   
        Test.startTest();
        
		List<Animal__c> animals = [SELECT Id 
             	 			  	   FROM Animal__c 
                 			  	   LIMIT 1];
        
		List<Animal__c> receivedAnimals = AnimalController.getAnimalsById(animals.get(0).Id);
        
        Test.stopTest();
        
        System.assertEquals(1, receivedAnimals.size());
        
    }
    
    @isTest
    private static void getAnimalsById_TestByExternalId(){
   
        Test.startTest();
        
		List<Animal__c> animals = [SELECT External_Id__c 
             	 			  	   FROM Animal__c 
                 			  	   LIMIT 1];
        
		List<Animal__c> receivedAnimals = AnimalController.getAnimalsById(animals.get(0).External_Id__c);
        
        Test.stopTest();
        
        System.assertEquals(1, receivedAnimals.size());
        
    }
    
    @isTest
    private static void createAnimalTest_NotExistingRecord(){
   
        Test.startTest();
        
		Animal__c newAnimal = TestDataFactory.prepareAnimal('TestNotExistingAnimal', '123');
        
		Animal__c receivedAnimal = AnimalController.createAnimal(newAnimal, false);
        
        Test.stopTest();
        
        System.assert(receivedAnimal != null);
        
    }
    
    @isTest
    private static void createAnimalTest_ExistingRecord_WihtQuestionTrigerring(){
   
        Test.startTest();
        
		List<Animal__c> animals = [SELECT External_Id__c 
             	 			  	   FROM Animal__c 
                 			  	   LIMIT 1];
        
		Animal__c receivedAnimal = AnimalController.createAnimal(animals.get(0), false);
        
        Test.stopTest();
        
        System.assert(receivedAnimal == null);
        
    }
    
    @isTest
    private static void createAnimalTest_ExistingRecord_WihtoutQuestionTrigerring(){
   
        Test.startTest();
        
		List<Animal__c> animals = [SELECT External_Id__c 
                                   		, Name
                                   		, Eats__c 
                                   		, Says__c 
             	 			  	   FROM Animal__c 
                 			  	   LIMIT 1];
        
		Animal__c receivedAnimal = AnimalController.createAnimal(animals.get(0), true);
        
        Test.stopTest();
        System.debug(receivedAnimal);
        System.assert(receivedAnimal != null);
        
    }
    
    @isTest
    private static void getExistAnimal_IsExist(){
   
        Test.startTest();
        
		List<Animal__c> animals = [SELECT External_Id__c 
             	 			  	   FROM Animal__c 
                 			  	   LIMIT 1];
        
		String idString = AnimalController.getExistAnimal(animals.get(0));
        
        Test.stopTest();
        
        System.assert(!STring.isBlank(idString));
        
    }
    
    @isTest
    private static void getExistAnimal_NotExist(){
   
        Test.startTest();
        
		Animal__c newAnimal = TestDataFactory.prepareAnimal('TestNotExistingAnimal', '123234');
        
		String idString = AnimalController.getExistAnimal(newAnimal);
        
        Test.stopTest();
        
        System.assert(STring.isBlank(idString));
        
    }
    
}