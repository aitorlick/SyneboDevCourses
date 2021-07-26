@isTest
public class AnimalTRTest {
   
    @isTest
    private static void animalsIsertionTest(){
   
        Test.startTest();
        
		TestDataFactory.createAnimals(100);
        
        Test.stopTest();
        
        List<Animal__c> animals = [SELECT Id 
             	 			  	   FROM Animal__c 
                 			  	   WHERE Name ='chicken'];
        System.assertEquals(100, animals.size());
        
    }
    
}