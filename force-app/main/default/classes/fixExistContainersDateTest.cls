@isTest
public class fixExistContainersDateTest {

    @testSetup 
    private static void setup(){
        List<Container__c> cntrs = new List<Container__c>();
        for(Integer i=0;i<200;i++) {
        	cntrs.add(TestDataFactory.prepareContainer('Batch '+i));	    
        }
        insert cntrs;
        
        List<ContainerInvoice__c> cntrsInvs = new List<ContainerInvoice__c>();
        for(Container__c cntr : cntrs) {
            for(Integer i=0;i<5;i++) {
                cntrsInvs.add(TestDataFactory.prepareContainerInvoice('Batch '+i, cntr.Id));
            }
        }          
        insert cntrsInvs;
    }
    
    @isTest
    private static void existContainersDateFixTest(){
        
        Test.startTest();
        fixExistContainersDate fixExCntrDate = new fixExistContainersDate();
        Id batchId = Database.executeBatch(fixExCntrDate);
        Test.stopTest();
        
        System.assertEquals(200, [SELECT count() FROM Container__c WHERE Test_Date__c != : null]);
    }
    
}