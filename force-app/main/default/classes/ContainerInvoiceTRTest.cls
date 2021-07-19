@isTest
public class ContainerInvoiceTRTest {

    @testSetup 
    private static void setup(){
        
        TestDataFactory.createContainers(2);
        
        Container__c cntr1 = [SELECT Id 
                 			  FROM Container__c 
                 			  WHERE Name = :'Test cntr 0'
                 			  LIMIT 1];
        
        Container__c cntr2 = [SELECT Id 
             	 			  FROM Container__c 
                 			  WHERE Name = :'Test cntr 1'
                 			  LIMIT 1];
        
        TestDataFactory.createContainerInvoice(100, cntr1.Id);
        TestDataFactory.createContainerInvoice(100, cntr2.Id);
        
    }
    
    @isTest
    private static void containerInvoiceIsertionTest(){
    	
        List<Container__c> cntrs1 = [SELECT Id 
                 					 FROM Container__c 
                 					 WHERE Name = :'Test cntr 0'];
        
        List<Container__c> cntrs2 = [SELECT Id 
             	 					 FROM Container__c 
                 					 WHERE Name = :'Test cntr 1'];
        
        List<ContainerInvoice__c> cntrInv1 = [SELECT Id 
                              		FROM ContainerInvoice__c 
                              		WHERE Container__c = :cntrs1[0].Id];
        
        List<ContainerInvoice__c> cntrInv2 = [SELECT Id 
                              		FROM ContainerInvoice__c 
                              		WHERE Container__c = :cntrs2[0].Id];
        
        System.assertEquals(1, cntrs1.size());
        System.assertEquals(1, cntrs2.size());
        System.assertEquals(100, cntrInv1.size());
        System.assertEquals(100, cntrInv2.size());
    }
    
    @isTest
    private static void containerInvoiceChangeParentTest(){
   	 
        Container__c cntr1 = [SELECT Id 
                 			  FROM Container__c 
                 			  WHERE Name = :'Test cntr 0'
                 			  LIMIT 1];
        
        Container__c cntr2 = [SELECT Id 
             	 			  FROM Container__c 
                 			  WHERE Name = :'Test cntr 1'
                 			  LIMIT 1];
        
        ContainerInvoice__c cntrInv1 = [SELECT Id 
                              			FROM ContainerInvoice__c 
                              			WHERE Container__c = :cntr1.Id
                                    	LIMIT 1];
        
        cntrInv1.Container__c = cntr2.Id;
        
        update cntrInv1;
        
        List<ContainerInvoice__c> cntrInvs1 = [SELECT Id 
                              		FROM ContainerInvoice__c 
                              		WHERE Container__c = :cntr1.Id];
        
        List<ContainerInvoice__c> cntrInvs2 = [SELECT Id 
                              		FROM ContainerInvoice__c 
                              		WHERE Container__c = :cntr2.Id];
        
        System.debug(cntrInvs1.size());
        System.debug(cntrInvs1.size());
        
        System.assertEquals(99, cntrInvs1.size());
        System.assertEquals(101, cntrInvs2.size()); 	
        
    }
}