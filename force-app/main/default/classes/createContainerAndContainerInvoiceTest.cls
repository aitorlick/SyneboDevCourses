@isTest
public class createContainerAndContainerInvoiceTest {
	
    @testSetup 
    private static void setup(){
        TestDataFactory.createContainers(10);
    }
    
    @isTest
    private static void createCntrTest(){
        
        Test.startTest();        
        createContainerAndContainerInvoice createCntr = new createContainerAndContainerInvoice(10);
        System.enqueueJob(createCntr);
        Test.stopTest();
        
        System.assertEquals(10, [SELECT count() 
                                 FROM Container__c
                                 WHERE Name LIKE :'Super test%']);      
    }
    
    @isTest
    private static void createCntrInvTest(){
        
        List<Container__c> cntrs = [SELECT Id 
                                    FROM Container__c
                                    WHERE Name LIKE :'Test cntr%'];
        
        Test.startTest();
        createContainerAndContainerInvoice createCntrInv = new createContainerAndContainerInvoice(false, 10, cntrs);
        System.enqueueJob(createCntrInv); 
        Test.stopTest();
        
        System.assertEquals(100, [SELECT count() FROM ContainerInvoice__c]);
    }
    
}