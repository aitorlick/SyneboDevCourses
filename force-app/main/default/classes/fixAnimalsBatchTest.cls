@isTest
public class fixAnimalsBatchTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @testSetup 
    private static void setup(){
        TestDataFactory.createAnimals(100);
    }
    
    @isTest
    private static void fixAnimalTest(){
        
        Test.startTest();
        fixAnimalsBatch fab = new fixAnimalsBatch();
        Id batchId = Database.executeBatch(fab,100);
        Test.stopTest();
        
        List<Animal__c> animals = [SELECT Id 
             	 			  	   FROM Animal__c 
                 			  	   WHERE Name ='chicken'];
        System.assertEquals(100, animals.size());
    }
    
    @isTest
    private static void fixAnimalScheduleTest(){
        
        Test.startTest();
 
        String jobId = System.schedule('fixAnimalsBatch',
            CRON_EXP,
            new fixAnimalsBatch());
 
        Test.stopTest();
        
        List<Animal__c> animals = [SELECT Id 
             	 			  	   FROM Animal__c 
                 			  	   WHERE Name ='chicken'];
        System.assertEquals(100, animals.size());
    }
    
}